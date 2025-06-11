Return-Path: <linux-fsdevel+bounces-51364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D8BAD61EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 23:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471F61E24AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 21:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A170924886A;
	Wed, 11 Jun 2025 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jVZuacOo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D32621D595
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678703; cv=none; b=NAsxaIgJMYpwqDxX2B2afopwX2h8nHD1Pio4HWM1GcDY0La1mw2n+HQUdoZXgMoXmfZcPv1AquWaKA6WMu5HiRtkU36KrwlkfsBvaNbnp+DdUnJZUuFQBkxqUA2G55c8HE5dDZES3/3qPSXq+Yjkwylg2mv0kZnJwbo94twEt4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678703; c=relaxed/simple;
	bh=IFFauBa06Dp5AA6wuuBZFjGoEDH8goVFQ4+yVa0oHDw=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=IJInjzg4JmwqRHAjckYUB8960ih+Qrw3M8FwhCjySikWyEyHQCfU/EqOIu0nA8OAeGMY6OxQLCPOSeYaJWOXS9BJEvZxQNSHpIZA0HIoNrRC17iKbFplcQm/v4q9WprLDj3zAxghWFUkeMPKiIpyJ6FmkE/CeZmNCs0cWP0FRz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jVZuacOo; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-747d84fe5f8so160421b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 14:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749678700; x=1750283500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P74GB7QCjfO1/JUQfevXX891SWVXbSdMv9d1fQ1ZP9c=;
        b=jVZuacOoRJNjoceCDknIw2tbCw37wzXTJuZiQXVIRc8Gj5e1oQzvibCAng0S1AaDKQ
         ahhYYK6kzb1gKkgseEUE6+N5FjeIa5tJZapLP/UH4YW9fbaDRmcNWhCi5N9lDnzZT4jz
         Ke0jtg+2R5Utn8jdVdYH/Y7t1b2bl08ZsgWYTozxTYqBWwBZZgEIeEljbufRxVwJSVK+
         MnCCnUzIqRU7M+ibePm54VbK+AEasOeP4ZgAaQp4uBSNcDiNanxRamKpOFYVeVevWzLJ
         Pf/JO5ngK9kHOmUUEroIGRjlao1NAOm8RvdQcvrmHLUSQ1hnXbkenEd3WZJkAeDDNcD7
         nkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749678700; x=1750283500;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P74GB7QCjfO1/JUQfevXX891SWVXbSdMv9d1fQ1ZP9c=;
        b=ueQOt36bc5vEsdRlhxL3o0fRHWNxdqYqYITEZyWw1R9wVZfcShUVKXEF/wSDS37gDA
         41qnW89Q/pBPnf3paAwlCqzlwU1kwnTqF/GIziMaMGqOjqZR5HgrKxjMLyAeCvKGR6Qd
         8LciSRLO9M0lg+GKLO3/L0H5wzSFa6wZJ7Blid/b5Lw+DuzgfybeN6W6s9T7M2WM355O
         P71p2Unr8VTFLGL7f3TyLnJs5TWmnxH1Zh/2BUh/LxvX2XOEnOezgD6ktKRQRHssttKj
         7Aiq2ivQkqhBmhZx3KMuC7BZLZ4cwxnp5NsUa98W0GrpAravrHcPaqZgmAjZ/asIcKTI
         uzeg==
X-Forwarded-Encrypted: i=1; AJvYcCXJikXvruuwP/DNwZFZOjj+UoNW6ZPnShfHCJ4wvREaCGzD5iUb7MhihscJWfV12rArsSqvEG85oSuXAE+b@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeq9z+W2viEDpf/OSJnGLhCUMWFnkrLbXBAlvSTUV+bA8/wQjo
	CfDUKJYrH6YsEB70ANf4ofErmiEFAiOkE8VG8TcgUjOsOxggKAfCRcb/Ih2JBSPL7WpUbuIra6o
	nyKyqLZ8afdIlvTy84SwPa9v2uA==
X-Google-Smtp-Source: AGHT+IGDTpLNIk1v6FYeKf7oNfAk8Qg6hqB3D47kkAOSUbTW/pul7qUFUR3OYyVFMKcQ9CcbKjzQTmU7clRREaS3tA==
X-Received: from pfbhj8.prod.google.com ([2002:a05:6a00:8708:b0:746:2747:e782])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:98f:b0:742:a77b:8c3 with SMTP id d2e1a72fcca58-7486cb21e68mr6223581b3a.4.1749678699581;
 Wed, 11 Jun 2025 14:51:39 -0700 (PDT)
Date: Wed, 11 Jun 2025 14:51:38 -0700
In-Reply-To: <20250529054227.hh2f4jmyqf6igd3i@amd.com> (message from Michael
 Roth on Thu, 29 May 2025 00:42:27 -0500)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqz1prqvted.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
From: Ackerley Tng <ackerleytng@google.com>
To: Michael Roth <michael.roth@amd.com>
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
	mic@digikod.net, mpe@ellerman.id.au, muchun.song@linux.dev, nikunj@amd.com, 
	nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, 
	qperret@google.com, quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Michael Roth <michael.roth@amd.com> writes:

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
>
> KVM_CAP_GMEM_CONVERSION doesn't get introduced until later, so it seems
> like this flag should be deferred until that patch is in place. Is it
> really needed at that point though? Userspace would be able to set the
> initial state via KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls.
>

I can move this change to the later patch. Thanks! Will fix in the next
revision.

> The mtree contents seems to get stored in the same manner in either case so
> performance-wise only the overhead of a few userspace<->kernel switches
> would be saved. Are there any other reasons?
>
> Otherwise, maybe just settle on SHARED as a documented default (since at
> least non-CoCo VMs would be able to reliably benefit) and let
> CoCo/GUEST_MEMFD_FLAG_SUPPORT_SHARED VMs set PRIVATE at whatever
> granularity makes sense for the architecture/guest configuration.
>

Because shared pages are split once any memory is allocated, having a
way to INIT_PRIVATE could avoid the split and then merge on
conversion. I feel that is enough value to have this config flag, what
do you think?

I guess we could also have userspace be careful not to do any allocation
before converting.

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
>
> One really nice thing about using a maple tree is that it should get rid
> of a fairly significant startup delay for SNP/TDX when the entire xarray gets
> initialized with private attribute entries via KVM_SET_MEMORY_ATTRIBUTES
> (which is the current QEMU default behavior).
>
> I'd originally advocated for sticking with the xarray implementation Fuad was
> using until we'd determined we really need it for HugeTLB support, but I'm
> sort of thinking it's already justified just based on the above.
>
> Maybe it would make sense for KVM memory attributes too?
>
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
>> +
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
>
> I like the idea of using a write-lock/read-lock to protect write/read access
> to shareability state (though maybe not necessarily re-using filemap's
> invalidate lock), it's simple and still allows concurrent faulting in of gmem
> pages. One issue on the SNP side (which also came up in one of the gmem calls)
> is if we introduce support for tracking preparedness as discussed (e.g. via a
> new SHAREABILITY_GUEST_PREPARED state) the
> SHAREABILITY_GUEST->SHAREABILITY_GUEST_PREPARED transition would occur at
> fault-time, and so would need to take the write-lock and no longer allow for
> concurrent fault-handling.
>
> I was originally planning on introducing a new rw_semaphore with similar
> semantics to the rw_lock that Fuad previously had in his restricted mmap
> series[1] (and simiar semantics to filemap invalidate lock here). The main
> difference, to handle setting SHAREABILITY_GUEST_PREPARED within fault paths,
> was that in the case of a folio being present for an index, the folio lock would
> also need to be held in order to update the shareability state. Because
> of that, fault paths (which will always either have or allocate folio
> basically) can rely on the folio lock to guard shareability state in a more
> granular way and so can avoid a global write lock.
>
> They would still need to hold the read lock to access the tree however.
> Or more specifically, any paths that could allocate a folio need to take
> a read lock so there isn't a TOCTOU situation where shareability is
> being updated for an index for which a folio hasn't been allocated, but
> then just afterward the folio gets faulted in/allocated while the
> shareability state is already being updated which the understand that
> there was no folio around that needed locking.
>
> I had a branch with in-place conversion support for SNP[2] that added this
> lock reworking on top of Fuad's series along with preparation tracking,
> but I'm now planning to rebase that on top of the patches from this
> series that Sean mentioned[3] earlier:
>
>   KVM: guest_memfd: Add CAP KVM_CAP_GMEM_CONVERSION
>   KVM: Query guest_memfd for private/shared status
>   KVM: guest_memfd: Skip LRU for guest_memfd folios
>   KVM: guest_memfd: Introduce KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
>   KVM: guest_memfd: Introduce and use shareability to guard faulting
>   KVM: guest_memfd: Make guest mem use guest mem inodes instead of anonymous inodes
>
> but figured I'd mention it here in case there are other things to consider on
> the locking front.
>
> Definitely agree with Sean though that it would be nice to start identifying a
> common base of patches for the in-place conversion enablement for SNP, TDX, and
> pKVM so the APIs/interfaces for hugepages can be handled separately.
>
> -Mike
>
> [1] https://lore.kernel.org/kvm/20250328153133.3504118-1-tabba@google.com/
> [2] https://github.com/mdroth/linux/commits/mmap-swprot-v10-snp0-wip2/
> [3] https://lore.kernel.org/kvm/aC86OsU2HSFZkJP6@google.com/
>
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

