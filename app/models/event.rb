class Event < ApplicationRecord

 validates_presence_of :name, :friendly_id

 validates_uniqueness_of :friendly_id
 validates_format_of :friendly_id, :with => /\A[a-z0-9\-]+\z/
 scope :only_public, -> { where( :status => "public" ) }
 scope :only_available, -> { where( :status => ["public", "private"] ) }
 STATUS = ["draft", "public", "private"]
 validates_inclusion_of :status, :in => STATUS
 has_many :tickets, :dependent => :destroy
 has_many :registrations, :dependent => :destroy
 accepts_nested_attributes_for :tickets, :allow_destroy => true, :reject_if => :all_blank
 # before_validation :generate_friendly_id, :on => :create
 include RankedModel
 ranks :row_order

 def to_param
   self.friendly_id
 end
 belongs_to :category, :optional => true
protected
 # def generate_friendly_id
 #   self.friendly_id = SecureRandom.uuid
 # end
end
