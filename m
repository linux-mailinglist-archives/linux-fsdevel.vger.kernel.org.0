Return-Path: <linux-fsdevel+bounces-50094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7F1AC8212
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 20:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3701BA70C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 18:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B86230BF5;
	Thu, 29 May 2025 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZvBeYNJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EDB1DA5F
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748542820; cv=none; b=L0E9UGCrB2z4nXJX+QnF1983JrIXGuywLsxWRdK7j6/H+Ofo17xLnAoJDmuP+bhzYUJxa0tChyYwaZO7N1YluA48g7YoGjAPEWDuLjnIsZm0LMtCfPlUS/BnHhviZSPZ5xiB7qUp+bA9s+J7fW73h7DvRu+2Thv6sqxZxId12Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748542820; c=relaxed/simple;
	bh=g3RIX2STW0NSdM5VX+XSDwgg+BfHvXIHc5xpLvtbDuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fC8jj1j3LObTMs2oFofr/IVVVZsaJAdpdTviM9oJ7VuVuI7Pb6kBbeRT6NOFTk1+dcPFbF4+GvUCD3BL10EvUDOzaOAeqhymOpzkfCGQe5PxMj+lB9g6wGSKRLqW8plD6EuBsr/PXMTEn5X1Yj9/eiJxh0fldVigEL4a5avI9Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dZvBeYNJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-747af0bf0ebso902613b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748542818; x=1749147618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VfbJ3SAMOI+96wfKOcoCTG/GNgODonkk4ldcKc8FS58=;
        b=dZvBeYNJ/KiNonOHJ8Ezd5dwrJiT+vs+xpYW+Yc4odgmFvNnsdE3sqRTEK36yzQsJk
         qOLsrlOzBulgxopB49XSYANiqQydG2FTIKWA364xMbBUNp2M56wocc3TU9FdMu0u/1b7
         f7bA/puoA7tz0InoR30wY4jFCGKVmhKr8yLdYtTwL1EUGUrg9aBNwhh6QSZrRC98O8TB
         Ydymi3QlkQd1gvqQKJbBsCzrgNiufjqYLrJ0NoVWi+jfSF+25954zmbawPxOlHvsgwEj
         0er+QvHbwtpM5blQCW0PgbOed2vXOj87rsIVx5rGvqT212FPDRsg2qKAkTHd7hUq2cJ+
         aRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748542818; x=1749147618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfbJ3SAMOI+96wfKOcoCTG/GNgODonkk4ldcKc8FS58=;
        b=GTuczlluLgFZXi/FOuawF+unXoNPv0++8TFeTvYfJS02wPb0+EdzWRJ1O/r4vSNdPA
         VlRyoF9WWQ7ceBrokvr4zGFeDhdWzkqyX5uPwnAVW4jzoOLUnHl3i7faM4zpGmaHT606
         u4JVdswfSOa1TF8llvI+bf6cU7uKq6LsxglDBZfFh6PajZCnxthkOP/kUD7xRarcdG72
         kV3r6MHcb+CznbvlFzUJbPq783cIju8NyXDbt03q/iXW5KK3hlVeT+WvaXLosbGMJkfA
         a5ORCSi2oeq9+N7IahbVR2RO7Y4OFvR9340rEe43TNdcGbi9vK93lJcv9TF4I5U8YYEo
         GgOw==
X-Forwarded-Encrypted: i=1; AJvYcCV32/lMNGLBYbncgCbv/tjx3sYnCjG/mDnUSWJICdBH/CVM3S3BCmXLHXWzuQUWlry4RexO90aTNopX/Kdm@vger.kernel.org
X-Gm-Message-State: AOJu0Yywy04GF9rB6E7bkUn0B0OfwAIuQOC5nMoOtWeyJs3J0IxDejiB
	u+5qunEGa84ATzoDJHieLQjaOXgi7/+1x3v+V9dIOq3tDzydQ+2UUtS/ZulLFLrkkGF+HoRQtqI
	YOeulTngaZP/I18n10ScgmEaZ9g==
X-Google-Smtp-Source: AGHT+IEGQ99xCbo63ElioTP4TSOSQO9Qp/9XbqkHfPc1TG0hEr1RvfBOYX4D49wzFG2SKhNE6JPiZpB8so1iJjxGSQ==
X-Received: from pfbhc10.prod.google.com ([2002:a05:6a00:650a:b0:747:adac:b0dd])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7a47:b0:1f5:93b1:6a58 with SMTP id adf61e73a8af0-21ad94e2100mr1045007637.8.1748542817673;
 Thu, 29 May 2025 11:20:17 -0700 (PDT)
Date: Thu, 29 May 2025 11:20:16 -0700
In-Reply-To: <aDU3eL7qQYrXkE3T@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com>
 <aDU3eL7qQYrXkE3T@yzhao56-desk.sh.intel.com>
Message-ID: <diqzcybr6zz3.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
From: Ackerley Tng <ackerleytng@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Wed, May 14, 2025 at 04:41:41PM -0700, Ackerley Tng wrote:
>> Track guest_memfd memory's shareability status within the inode as
>> opposed to the file, since it is property of the guest_memfd's memory
>> contents.
>> 
>> Shareability is a property of the memory and is indexed using the
>> page's index in the inode. Because shareability is the memory's
>> property, it is stored within guest_memfd instead of within KVM, like
>> in kvm->mem_attr_array.
>> 
>> KVM_MEMORY_ATTRIBUTE_PRIVATE in kvm->mem_attr_array must still be
>> retained to allow VMs to only use guest_memfd for private memory and
>> some other memory for shared memory.
>> 
>> Not all use cases require guest_memfd() to be shared with the host
>> when first created. Add a new flag, GUEST_MEMFD_FLAG_INIT_PRIVATE,
>> which when set on KVM_CREATE_GUEST_MEMFD, initializes the memory as
>> private to the guest, and therefore not mappable by the
>> host. Otherwise, memory is shared until explicitly converted to
>> private.
>> 
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
>> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
>> Co-developed-by: Fuad Tabba <tabba@google.com>
>> Signed-off-by: Fuad Tabba <tabba@google.com>
>> Change-Id: If03609cbab3ad1564685c85bdba6dcbb6b240c0f
>> ---
>>  Documentation/virt/kvm/api.rst |   5 ++
>>  include/uapi/linux/kvm.h       |   2 +
>>  virt/kvm/guest_memfd.c         | 124 ++++++++++++++++++++++++++++++++-
>>  3 files changed, 129 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index 86f74ce7f12a..f609337ae1c2 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -6408,6 +6408,11 @@ belonging to the slot via its userspace_addr.
>>  The use of GUEST_MEMFD_FLAG_SUPPORT_SHARED will not be allowed for CoCo VMs.
>>  This is validated when the guest_memfd instance is bound to the VM.
>>  
>> +If the capability KVM_CAP_GMEM_CONVERSIONS is supported, then the 'flags' field
>> +supports GUEST_MEMFD_FLAG_INIT_PRIVATE.  Setting GUEST_MEMFD_FLAG_INIT_PRIVATE
>> +will initialize the memory for the guest_memfd as guest-only and not faultable
>> +by the host.
>> +
>>  See KVM_SET_USER_MEMORY_REGION2 for additional details.
>>  
>>  4.143 KVM_PRE_FAULT_MEMORY
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 4cc824a3a7c9..d7df312479aa 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1567,7 +1567,9 @@ struct kvm_memory_attributes {
>>  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
>>  
>>  #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
>> +
>>  #define GUEST_MEMFD_FLAG_SUPPORT_SHARED	(1UL << 0)
>> +#define GUEST_MEMFD_FLAG_INIT_PRIVATE	(1UL << 1)
>>  
>>  struct kvm_create_guest_memfd {
>>  	__u64 size;
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 239d0f13dcc1..590932499eba 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -4,6 +4,7 @@
>>  #include <linux/falloc.h>
>>  #include <linux/fs.h>
>>  #include <linux/kvm_host.h>
>> +#include <linux/maple_tree.h>
>>  #include <linux/pseudo_fs.h>
>>  #include <linux/pagemap.h>
>>  
>> @@ -17,6 +18,24 @@ struct kvm_gmem {
>>  	struct list_head entry;
>>  };
>>  
>> +struct kvm_gmem_inode_private {
>> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
>> +	struct maple_tree shareability;
>> +#endif
>> +};
>> +
>> +enum shareability {
>> +	SHAREABILITY_GUEST = 1,	/* Only the guest can map (fault) folios in this range. */
>> +	SHAREABILITY_ALL = 2,	/* Both guest and host can fault folios in this range. */
>> +};
>> +
>> +static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index);
>> +
>> +static struct kvm_gmem_inode_private *kvm_gmem_private(struct inode *inode)
>> +{
>> +	return inode->i_mapping->i_private_data;
>> +}
>> +
>>  /**
>>   * folio_file_pfn - like folio_file_page, but return a pfn.
>>   * @folio: The folio which contains this index.
>> @@ -29,6 +48,58 @@ static inline kvm_pfn_t folio_file_pfn(struct folio *folio, pgoff_t index)
>>  	return folio_pfn(folio) + (index & (folio_nr_pages(folio) - 1));
>>  }
>>  
>> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
>> +
>> +static int kvm_gmem_shareability_setup(struct kvm_gmem_inode_private *private,
>> +				      loff_t size, u64 flags)
>> +{
>> +	enum shareability m;
>> +	pgoff_t last;
>> +
>> +	last = (size >> PAGE_SHIFT) - 1;
>> +	m = flags & GUEST_MEMFD_FLAG_INIT_PRIVATE ? SHAREABILITY_GUEST :
>> +						    SHAREABILITY_ALL;
>> +	return mtree_store_range(&private->shareability, 0, last, xa_mk_value(m),
>> +				 GFP_KERNEL);
>> +}
>> +
>> +static enum shareability kvm_gmem_shareability_get(struct inode *inode,
>> +						 pgoff_t index)
>> +{
>> +	struct maple_tree *mt;
>> +	void *entry;
>> +
>> +	mt = &kvm_gmem_private(inode)->shareability;
>> +	entry = mtree_load(mt, index);
>> +	WARN(!entry,
>> +	     "Shareability should always be defined for all indices in inode.");
> I noticed that in [1], the kvm_gmem_mmap() does not check the range.
> So, the WARN() here can be hit when userspace mmap() an area larger than the
> inode size and accesses the out of band HVA.
>
> Maybe limit the mmap() range?
>
> @@ -1609,6 +1620,10 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
>         if (!kvm_gmem_supports_shared(file_inode(file)))
>                 return -ENODEV;
>
> +       if (vma->vm_end - vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT) > i_size_read(file_inode(file)))
> +               return -EINVAL;
> +
>         if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) !=
>             (VM_SHARED | VM_MAYSHARE)) {
>                 return -EINVAL;
>
> [1] https://lore.kernel.org/all/20250513163438.3942405-8-tabba@google.com/
>

This is a good idea. Thanks! I also think it is a good idea to include
this with the guest_memfd mmap base series that Fuad is working on [1],
maybe in v11.

[1] https://lore.kernel.org/all/20250527180245.1413463-1-tabba@google.com/

>> +	return xa_to_value(entry);
>> +}
>> +
>> +static struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t index)
>> +{
>> +	if (kvm_gmem_shareability_get(inode, index) != SHAREABILITY_ALL)
>> +		return ERR_PTR(-EACCES);
>> +
>> +	return kvm_gmem_get_folio(inode, index);
>> +}
>> +
>> +#else
>> +
>> +static int kvm_gmem_shareability_setup(struct maple_tree *mt, loff_t size, u64 flags)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t index)
>> +{
>> +	WARN_ONCE("Unexpected call to get shared folio.")
>> +	return NULL;
>> +}
>> +
>> +#endif /* CONFIG_KVM_GMEM_SHARED_MEM */
>> +
>>  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>>  				    pgoff_t index, struct folio *folio)
>>  {
>> @@ -333,7 +404,7 @@ static vm_fault_t kvm_gmem_fault_shared(struct vm_fault *vmf)
>>  
>>  	filemap_invalidate_lock_shared(inode->i_mapping);
>>  
>> -	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
>> +	folio = kvm_gmem_get_shared_folio(inode, vmf->pgoff);
>>  	if (IS_ERR(folio)) {
>>  		int err = PTR_ERR(folio);
>>  
>> @@ -420,8 +491,33 @@ static struct file_operations kvm_gmem_fops = {
>>  	.fallocate	= kvm_gmem_fallocate,
>>  };
>>  
>> +static void kvm_gmem_free_inode(struct inode *inode)
>> +{
>> +	struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
>> +
>> +	kfree(private);
>> +
>> +	free_inode_nonrcu(inode);
>> +}
>> +
>> +static void kvm_gmem_destroy_inode(struct inode *inode)
>> +{
>> +	struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
>> +
>> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
>> +	/*
>> +	 * mtree_destroy() can't be used within rcu callback, hence can't be
>> +	 * done in ->free_inode().
>> +	 */
>> +	if (private)
>> +		mtree_destroy(&private->shareability);
>> +#endif
>> +}
>> +
>>  static const struct super_operations kvm_gmem_super_operations = {
>>  	.statfs		= simple_statfs,
>> +	.destroy_inode	= kvm_gmem_destroy_inode,
>> +	.free_inode	= kvm_gmem_free_inode,
>>  };
>>  
>>  static int kvm_gmem_init_fs_context(struct fs_context *fc)
>> @@ -549,12 +645,26 @@ static const struct inode_operations kvm_gmem_iops = {
>>  static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>>  						      loff_t size, u64 flags)
>>  {
>> +	struct kvm_gmem_inode_private *private;
>>  	struct inode *inode;
>> +	int err;
>>  
>>  	inode = alloc_anon_secure_inode(kvm_gmem_mnt->mnt_sb, name);
>>  	if (IS_ERR(inode))
>>  		return inode;
>>  
>> +	err = -ENOMEM;
>> +	private = kzalloc(sizeof(*private), GFP_KERNEL);
>> +	if (!private)
>> +		goto out;
>> +
>> +	mt_init(&private->shareability);
> Wrap the mt_init() inside "#ifdef CONFIG_KVM_GMEM_SHARED_MEM" ?
>

Will fix this in the next revision. Will also update this to only
initialize shareability if (flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED).

>> +	inode->i_mapping->i_private_data = private;
>> +
>> +	err = kvm_gmem_shareability_setup(private, size, flags);
>> +	if (err)
>> +		goto out;
>> +
>>  	inode->i_private = (void *)(unsigned long)flags;
>>  	inode->i_op = &kvm_gmem_iops;
>>  	inode->i_mapping->a_ops = &kvm_gmem_aops;
>> @@ -566,6 +676,11 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>>  	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>>  
>>  	return inode;
>> +
>> +out:
>> +	iput(inode);
>> +
>> +	return ERR_PTR(err);
>>  }
>>  
>>  static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
>> @@ -654,6 +769,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
>>  	if (kvm_arch_vm_supports_gmem_shared_mem(kvm))
>>  		valid_flags |= GUEST_MEMFD_FLAG_SUPPORT_SHARED;
>>  
>> +	if (flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED)
>> +		valid_flags |= GUEST_MEMFD_FLAG_INIT_PRIVATE;
>> +
>>  	if (flags & ~valid_flags)
>>  		return -EINVAL;
>>  
>> @@ -842,6 +960,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>  	if (!file)
>>  		return -EFAULT;
>>  
>> +	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
>> +
>>  	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, &is_prepared, max_order);
>>  	if (IS_ERR(folio)) {
>>  		r = PTR_ERR(folio);
>> @@ -857,8 +977,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>  		*page = folio_file_page(folio, index);
>>  	else
>>  		folio_put(folio);
>> -
>>  out:
>> +	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
>>  	fput(file);
>>  	return r;
>>  }
>> -- 
>> 2.49.0.1045.g170613ef41-goog
>> 
>> 

