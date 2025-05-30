Return-Path: <linux-fsdevel+bounces-50237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06430AC95A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 20:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 955AB7AD608
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 18:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B895820E6;
	Fri, 30 May 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJ/uzqDo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CD127703D
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 18:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748629929; cv=none; b=tLTHDZw82ss/vax/K+0jvJhQquN+4MrBfY4GF28Mu0PTY5DyGbL4jmOSfMzI797Jx7ay+y/djz6W50X511/x3v57FL7tmR7332APF7Tqs6aQGTWr9oFf7TY1MHthPpvSoAh61KYm/4KGN44k+RnVIpYTfyh2wcTEquHCK+2uqq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748629929; c=relaxed/simple;
	bh=AFynUQvTUTH6mZs3VLHSeW2tG2PCrFuGLmHjWHOyDvk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CrGm+qirQiegXYTA+IaD+zoBn03MiEejI0rW5znxjueKeiKDe4WqoH+0DGm4NYm5Z5w0kocK1cJ0Cbj4muYshQw6rPNszowvOln/l0RC3Ya6c+TjliTywluTB6X+31Sp1BHKIKrdUc3s2S+evMtgMoFmEAUDoIUXUa9DFm1Ya/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJ/uzqDo; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742b01ad1a5so3396839b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 11:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748629927; x=1749234727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lGiyvE+Z7SWCN1E9FOENP3p6d5ja0ty4l2hl1/VGD8A=;
        b=iJ/uzqDo8kKPy/tZZAOMDIQx/bJUC+imgYKIVaacaxJqbFcvH3QLIu4pR3gVJx6YRP
         88z+uTYUoAfLNyq9b2ilQkWaGFXmniPc0UHFUuYjlHgEdIkBtc0x3tF5Df57P5wagXRT
         HFE/gcnwxrjyjzMCHXSMpCVMqlbgYN2fuluK3mpcr8DIgI8HStL+LV9a88l0/SoEWbXJ
         D4k7IL9g2PDFOnltGMhJcj7WP8G8MmUNrUKHhwqCgMajOf1vZorEOHD8iYCTHO36lYbx
         n6som5l9+JpIDF8HjqaNzfLfteDeM3FvjThw+EY3hGxaHqC+olx+7e83ot9HYAeq92HN
         E+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748629927; x=1749234727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGiyvE+Z7SWCN1E9FOENP3p6d5ja0ty4l2hl1/VGD8A=;
        b=SNk3J8uW4dowQjP7vwbffWsJvTyZL9jNteomG1RGZgQKQPoiMN0NvOgEAAw1mLzouR
         rsTE3VMBioLo3Zn4hT8VzOj7WBmCF10Luh25qQkcZE06mcgc6/28/IBAfZo5F95/aGyQ
         PhPCKyKA9Q3O2g3ujQ1T4o1R/6wGJo46xvAH3OSX8sRjs8DfyvaFdYPBC6TqZfqRsE8x
         WIdnyGW89hxrv3gIDxJieNWZl/k/K8Ge8u37LC25WJWrXjTV1xQImeei0hx0BopbdchY
         j2fYSPn4G+u/Hrd5iVyEcfRhRqc3+ULWERCp0eGiPRDKn2FA2BtuMdbNhayP87MI+/LP
         3lQA==
X-Forwarded-Encrypted: i=1; AJvYcCXhNSMKC1Bl2D/L+2swamAXXlJ9uFziG/P8u4NJNdGL2zfiCFCF/Jg5hoTQGg0n9P2qtRuOpzQ8DODIrWiI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy83Qbvl/rcTWI0JH2LxUjyjwa2NGYDX3Q7PxeCJqC7VdgH9A9w
	A12ECTHDutI8plmKeW01HNlUh76wKlvtS58gcOIEtwwSIyidMhLI1hWCl1qlcYLkHo44Az5dRJM
	9WP16yvkDkdvs0rbFFDYzFtaGPQ==
X-Google-Smtp-Source: AGHT+IHM5kPg6eMJSoESrR+TXUjl4+oS0Sa65KfzAcdN3HQaYyK4tSpaTAlF7bAq/a4lRhtVcdm1+x3J3RssfsHAbg==
X-Received: from pfbg25.prod.google.com ([2002:a05:6a00:ae19:b0:746:3162:8be1])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1951:b0:746:24c9:c92e with SMTP id d2e1a72fcca58-747c1a7b5b2mr5413543b3a.8.1748629926517;
 Fri, 30 May 2025 11:32:06 -0700 (PDT)
Date: Fri, 30 May 2025 11:32:04 -0700
In-Reply-To: <CA+EHjTxgO4LmdYY83a+uzBshvFf8EcJzY58Rovvz=pZgyO2yow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com>
 <aDU3eL7qQYrXkE3T@yzhao56-desk.sh.intel.com> <CA+EHjTxgO4LmdYY83a+uzBshvFf8EcJzY58Rovvz=pZgyO2yow@mail.gmail.com>
Message-ID: <diqzzfeu54rf.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
From: Ackerley Tng <ackerleytng@google.com>
To: Fuad Tabba <tabba@google.com>, Yan Zhao <yan.y.zhao@intel.com>
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
	steven.sistare@oracle.com, suzuki.poulose@arm.com, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, vannapurve@google.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, xiaoyao.li@intel.com, 
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Fuad Tabba <tabba@google.com> writes:

> Hi,
>
> .. snip..
>
>> I noticed that in [1], the kvm_gmem_mmap() does not check the range.
>> So, the WARN() here can be hit when userspace mmap() an area larger than the
>> inode size and accesses the out of band HVA.
>>
>> Maybe limit the mmap() range?
>>
>> @@ -1609,6 +1620,10 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
>>         if (!kvm_gmem_supports_shared(file_inode(file)))
>>                 return -ENODEV;
>>
>> +       if (vma->vm_end - vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT) > i_size_read(file_inode(file)))
>> +               return -EINVAL;
>> +
>>         if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) !=
>>             (VM_SHARED | VM_MAYSHARE)) {
>>                 return -EINVAL;
>>
>> [1] https://lore.kernel.org/all/20250513163438.3942405-8-tabba@google.com/
>
> I don't think we want to do that for a couple of reasons. We catch
> such invalid accesses on faulting, and, by analogy, afaikt, neither
> secretmem nor memfd perform a similar check on mmap (nor do
> memory-mapped files in general).
>
> There are also valid reasons why a user would want to deliberately
> mmap more memory than the backing store, knowing that it's only going
> to fault what it's going to use, e.g., alignment.
>

This is a good point.

I think there's no check against the inode size on faulting now though?
v10's [1] kvm_gmem_fault_shared() calls kvm_gmem_get_folio()
straightaway.

We should add a check like [2] to kvm_gmem_fault_shared().

[1] https://lore.kernel.org/all/20250513163438.3942405-8-tabba@google.com/
[2] https://github.com/torvalds/linux/blob/8477ab143069c6b05d6da4a8184ded8b969240f5/mm/filemap.c#L3373

> Cheers,
> /fuad
>
>
>> > +     return xa_to_value(entry);
>> > +}
>> > +
>> > +static struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t index)
>> > +{
>> > +     if (kvm_gmem_shareability_get(inode, index) != SHAREABILITY_ALL)
>> > +             return ERR_PTR(-EACCES);
>> > +
>> > +     return kvm_gmem_get_folio(inode, index);
>> > +}
>> > +
>> > +#else
>> > +
>> > +static int kvm_gmem_shareability_setup(struct maple_tree *mt, loff_t size, u64 flags)
>> > +{
>> > +     return 0;
>> > +}
>> > +
>> > +static inline struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t index)
>> > +{
>> > +     WARN_ONCE("Unexpected call to get shared folio.")
>> > +     return NULL;
>> > +}
>> > +
>> > +#endif /* CONFIG_KVM_GMEM_SHARED_MEM */
>> > +
>> >  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>> >                                   pgoff_t index, struct folio *folio)
>> >  {
>> > @@ -333,7 +404,7 @@ static vm_fault_t kvm_gmem_fault_shared(struct vm_fault *vmf)
>> >
>> >       filemap_invalidate_lock_shared(inode->i_mapping);
>> >
>> > -     folio = kvm_gmem_get_folio(inode, vmf->pgoff);
>> > +     folio = kvm_gmem_get_shared_folio(inode, vmf->pgoff);
>> >       if (IS_ERR(folio)) {
>> >               int err = PTR_ERR(folio);
>> >
>> > @@ -420,8 +491,33 @@ static struct file_operations kvm_gmem_fops = {
>> >       .fallocate      = kvm_gmem_fallocate,
>> >  };
>> >
>> > +static void kvm_gmem_free_inode(struct inode *inode)
>> > +{
>> > +     struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
>> > +
>> > +     kfree(private);
>> > +
>> > +     free_inode_nonrcu(inode);
>> > +}
>> > +
>> > +static void kvm_gmem_destroy_inode(struct inode *inode)
>> > +{
>> > +     struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
>> > +
>> > +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
>> > +     /*
>> > +      * mtree_destroy() can't be used within rcu callback, hence can't be
>> > +      * done in ->free_inode().
>> > +      */
>> > +     if (private)
>> > +             mtree_destroy(&private->shareability);
>> > +#endif
>> > +}
>> > +
>> >  static const struct super_operations kvm_gmem_super_operations = {
>> >       .statfs         = simple_statfs,
>> > +     .destroy_inode  = kvm_gmem_destroy_inode,
>> > +     .free_inode     = kvm_gmem_free_inode,
>> >  };
>> >
>> >  static int kvm_gmem_init_fs_context(struct fs_context *fc)
>> > @@ -549,12 +645,26 @@ static const struct inode_operations kvm_gmem_iops = {
>> >  static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>> >                                                     loff_t size, u64 flags)
>> >  {
>> > +     struct kvm_gmem_inode_private *private;
>> >       struct inode *inode;
>> > +     int err;
>> >
>> >       inode = alloc_anon_secure_inode(kvm_gmem_mnt->mnt_sb, name);
>> >       if (IS_ERR(inode))
>> >               return inode;
>> >
>> > +     err = -ENOMEM;
>> > +     private = kzalloc(sizeof(*private), GFP_KERNEL);
>> > +     if (!private)
>> > +             goto out;
>> > +
>> > +     mt_init(&private->shareability);
>> Wrap the mt_init() inside "#ifdef CONFIG_KVM_GMEM_SHARED_MEM" ?
>>
>> > +     inode->i_mapping->i_private_data = private;
>> > +
>> > +     err = kvm_gmem_shareability_setup(private, size, flags);
>> > +     if (err)
>> > +             goto out;
>> > +
>> >       inode->i_private = (void *)(unsigned long)flags;
>> >       inode->i_op = &kvm_gmem_iops;
>> >       inode->i_mapping->a_ops = &kvm_gmem_aops;
>> > @@ -566,6 +676,11 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>> >       WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>> >
>> >       return inode;
>> > +
>> > +out:
>> > +     iput(inode);
>> > +
>> > +     return ERR_PTR(err);
>> >  }
>> >
>> >  static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
>> > @@ -654,6 +769,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
>> >       if (kvm_arch_vm_supports_gmem_shared_mem(kvm))
>> >               valid_flags |= GUEST_MEMFD_FLAG_SUPPORT_SHARED;
>> >
>> > +     if (flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED)
>> > +             valid_flags |= GUEST_MEMFD_FLAG_INIT_PRIVATE;
>> > +
>> >       if (flags & ~valid_flags)
>> >               return -EINVAL;
>> >
>> > @@ -842,6 +960,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>> >       if (!file)
>> >               return -EFAULT;
>> >
>> > +     filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
>> > +
>> >       folio = __kvm_gmem_get_pfn(file, slot, index, pfn, &is_prepared, max_order);
>> >       if (IS_ERR(folio)) {
>> >               r = PTR_ERR(folio);
>> > @@ -857,8 +977,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>> >               *page = folio_file_page(folio, index);
>> >       else
>> >               folio_put(folio);
>> > -
>> >  out:
>> > +     filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
>> >       fput(file);
>> >       return r;
>> >  }
>> > --
>> > 2.49.0.1045.g170613ef41-goog
>> >
>> >

