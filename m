Return-Path: <linux-fsdevel+bounces-50309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 222E0ACABBC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591AA1896347
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593331EFFA3;
	Mon,  2 Jun 2025 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="etCmQvSJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925951E521A
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857426; cv=none; b=R+djr2Sc6mMqMS7go+zBY5knHWyc8Du4czNAqc+GFsp4bw6ooI7T2YyxShkO2JxJr51r/MHeLzoC36RcrnDgg0wwi9YJKJfEw2ij9T8WjjSQR6SG5bCQVRaHLerpkL4pogiyTh+LopGixP3S7Ky+Bt9iosrZLcGZdMDr66ddZzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857426; c=relaxed/simple;
	bh=REBUgI6WvAgg7qhQ4s6VTIr8/bnIQiY5sJ0c/scjknM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scbI4sxKkkQCUB6cDEPZnPcOecq+uCi388QaS6vEPkWiloYRgJtFmW6q47qyZHLoawrVaPURz6dZyqmStdmqVLf2Ft95p1W4TAKcChT07sNFA3g0MDGpk6Vvbcr51XwxBA/5w1Fw6LTXM4I5A5CPGeBpDUxd7d5iU4HiEutOb5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=etCmQvSJ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47e9fea29easo651111cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Jun 2025 02:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748857422; x=1749462222; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uo8mvfVOCPKDzB6phw0TdqUcAgsJs18ujFhEA6TPVZg=;
        b=etCmQvSJUliKtsynHnnpq/r08LS0yJTn7ODhGfTyCLOEhbd4POBqJp3xsAzIzlTSXr
         fPklFwpmGOFRT2fXc3VuUi0n4/Gr2c/Ts+bgryPjDX/i/LhWQsSJ5D5F4eCBKOQ5U3t1
         bwkGFPF6zyHbtLlZrAOC3XDdSTbAD4lPMD4qOzr/mU6CCknvB7MULe+ZkkM6PFADauOs
         03gmfEMY7JlON23z7KZcs/9zzE1rsHTw3I5ToKz7bDwbk05WMVPjB4XsUEyH86ZG4qyu
         zjA1XPbVCLx/idQ6epH5UECBYIQkbCKE5/5M77cdyiPVlzKKHRwookjvFKlY1io7p1nj
         6pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748857422; x=1749462222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uo8mvfVOCPKDzB6phw0TdqUcAgsJs18ujFhEA6TPVZg=;
        b=nUSM4x97bRKhIEG8rHkjq4ot2a4v7herY2idheJH4in097q5HHuEubIjzdTkTgyiSW
         7J/PyPEl5pSCCFcmznwN+bJuw6nw5SSrI6RFgXYF16CGQ6BZwa0puE4yBYDI2GXUdLU/
         J1e7sccogDBpqu7ecZrmZZyuvxCre9x9a4YrrHKuqRYPJvdKJEJPu1gbdW6qjpuz3Qfh
         lJk4qNrQPoZXeexbHJxv4K1bjbuVbtUNXjCjomXvq//V0SJhLlzwoeen9NTjpye7CcNQ
         g+z1ZZS2yKZ9lfqQdrQ81++c+wXoLLDqoQZzyHki0PIHBMTJsvX5BIY3duMdfsa6Ffog
         P2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzt2N4xOiYjEoYjNNfLGBC6DurbHPm3kJB9SMQSCB24pDXmdn1x+pijrqeNhntzhj3qq0zw2teFofWiOpv@vger.kernel.org
X-Gm-Message-State: AOJu0YwKSLelfPX6646HGfXr9+OvAC26hbius13gcrjeZea3EE/Uso0I
	E9AfJ7Zxr2cq5l3qJJaFymWo6NtKxe/Rnvq4dxUZSoJ1mVo27mOID+h5hU9twuWeXdwEHrHmFTU
	SOYbMNaHoDJjhD7MW6uVjW8rY/T0xIyJvvhttAisK
X-Gm-Gg: ASbGncsaNtjGVnfB2eAgJcswposXfEuDHzXspTu2u5669qh3uNfWE3OxApFFfJuKhQc
	3aWyXTrFKlvNNNntWKxosEc/vGHlDLCqJjtWavBu7VaafW4rvYu4CXEn0WyNCTabYUGbBxy0Tbm
	mucMu+D7doTUHzdSfr01nIR2/6uxWsdX+8ld/YVQ1msHQ=
X-Google-Smtp-Source: AGHT+IGWihVD4pfolVqs4guDDc40fFZEGkU6C3Ax5Qsx3Qx9MhC6Q8kpj0Q3hgKeQLjhU0Zcd4NAEFjvR2PgYiaFuH4=
X-Received: by 2002:a05:622a:2288:b0:494:b833:aa42 with SMTP id
 d75a77b69052e-4a45815ef5cmr4822181cf.5.1748857421902; Mon, 02 Jun 2025
 02:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com>
 <aDU3eL7qQYrXkE3T@yzhao56-desk.sh.intel.com> <CA+EHjTxgO4LmdYY83a+uzBshvFf8EcJzY58Rovvz=pZgyO2yow@mail.gmail.com>
 <diqzzfeu54rf.fsf@ackerleytng-ctop.c.googlers.com>
In-Reply-To: <diqzzfeu54rf.fsf@ackerleytng-ctop.c.googlers.com>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 2 Jun 2025 10:43:05 +0100
X-Gm-Features: AX0GCFs1Ed5_8o-cI-u2zHzfuVBCp-xOIalJ6ir71J27GefrvJtgoWToLCCKlFs
Message-ID: <CA+EHjTyv9KsRsbf6ec9u5mLjBbcnNti9k8hPi9Do59Mw7ayYqw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
To: Ackerley Tng <ackerleytng@google.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org, 
	aik@amd.com, ajones@ventanamicro.com, akpm@linux-foundation.org, 
	amoorthy@google.com, anthony.yznaga@oracle.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, bfoster@redhat.com, binbin.wu@linux.intel.com, 
	brauner@kernel.org, catalin.marinas@arm.com, chao.p.peng@intel.com, 
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com, 
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, graf@amazon.com, haibo1.xu@intel.com, 
	hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
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

Hi Ackerley,

On Fri, 30 May 2025 at 19:32, Ackerley Tng <ackerleytng@google.com> wrote:
>
> Fuad Tabba <tabba@google.com> writes:
>
> > Hi,
> >
> > .. snip..
> >
> >> I noticed that in [1], the kvm_gmem_mmap() does not check the range.
> >> So, the WARN() here can be hit when userspace mmap() an area larger than the
> >> inode size and accesses the out of band HVA.
> >>
> >> Maybe limit the mmap() range?
> >>
> >> @@ -1609,6 +1620,10 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
> >>         if (!kvm_gmem_supports_shared(file_inode(file)))
> >>                 return -ENODEV;
> >>
> >> +       if (vma->vm_end - vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT) > i_size_read(file_inode(file)))
> >> +               return -EINVAL;
> >> +
> >>         if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) !=
> >>             (VM_SHARED | VM_MAYSHARE)) {
> >>                 return -EINVAL;
> >>
> >> [1] https://lore.kernel.org/all/20250513163438.3942405-8-tabba@google.com/
> >
> > I don't think we want to do that for a couple of reasons. We catch
> > such invalid accesses on faulting, and, by analogy, afaikt, neither
> > secretmem nor memfd perform a similar check on mmap (nor do
> > memory-mapped files in general).
> >
> > There are also valid reasons why a user would want to deliberately
> > mmap more memory than the backing store, knowing that it's only going
> > to fault what it's going to use, e.g., alignment.
> >
>
> This is a good point.
>
> I think there's no check against the inode size on faulting now though?
> v10's [1] kvm_gmem_fault_shared() calls kvm_gmem_get_folio()
> straightaway.
>
> We should add a check like [2] to kvm_gmem_fault_shared().

Yes! I mistakenly thought that kvm_gmem_get_folio() had such a check,
I just verified that it doesn't. I have added the check, as well as a
new selftest to make sure we don't miss it in the future.

Thanks!
/fuad

> [1] https://lore.kernel.org/all/20250513163438.3942405-8-tabba@google.com/
> [2] https://github.com/torvalds/linux/blob/8477ab143069c6b05d6da4a8184ded8b969240f5/mm/filemap.c#L3373
>
> > Cheers,
> > /fuad
> >
> >
> >> > +     return xa_to_value(entry);
> >> > +}
> >> > +
> >> > +static struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t index)
> >> > +{
> >> > +     if (kvm_gmem_shareability_get(inode, index) != SHAREABILITY_ALL)
> >> > +             return ERR_PTR(-EACCES);
> >> > +
> >> > +     return kvm_gmem_get_folio(inode, index);
> >> > +}
> >> > +
> >> > +#else
> >> > +
> >> > +static int kvm_gmem_shareability_setup(struct maple_tree *mt, loff_t size, u64 flags)
> >> > +{
> >> > +     return 0;
> >> > +}
> >> > +
> >> > +static inline struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t index)
> >> > +{
> >> > +     WARN_ONCE("Unexpected call to get shared folio.")
> >> > +     return NULL;
> >> > +}
> >> > +
> >> > +#endif /* CONFIG_KVM_GMEM_SHARED_MEM */
> >> > +
> >> >  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
> >> >                                   pgoff_t index, struct folio *folio)
> >> >  {
> >> > @@ -333,7 +404,7 @@ static vm_fault_t kvm_gmem_fault_shared(struct vm_fault *vmf)
> >> >
> >> >       filemap_invalidate_lock_shared(inode->i_mapping);
> >> >
> >> > -     folio = kvm_gmem_get_folio(inode, vmf->pgoff);
> >> > +     folio = kvm_gmem_get_shared_folio(inode, vmf->pgoff);
> >> >       if (IS_ERR(folio)) {
> >> >               int err = PTR_ERR(folio);
> >> >
> >> > @@ -420,8 +491,33 @@ static struct file_operations kvm_gmem_fops = {
> >> >       .fallocate      = kvm_gmem_fallocate,
> >> >  };
> >> >
> >> > +static void kvm_gmem_free_inode(struct inode *inode)
> >> > +{
> >> > +     struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
> >> > +
> >> > +     kfree(private);
> >> > +
> >> > +     free_inode_nonrcu(inode);
> >> > +}
> >> > +
> >> > +static void kvm_gmem_destroy_inode(struct inode *inode)
> >> > +{
> >> > +     struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
> >> > +
> >> > +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> >> > +     /*
> >> > +      * mtree_destroy() can't be used within rcu callback, hence can't be
> >> > +      * done in ->free_inode().
> >> > +      */
> >> > +     if (private)
> >> > +             mtree_destroy(&private->shareability);
> >> > +#endif
> >> > +}
> >> > +
> >> >  static const struct super_operations kvm_gmem_super_operations = {
> >> >       .statfs         = simple_statfs,
> >> > +     .destroy_inode  = kvm_gmem_destroy_inode,
> >> > +     .free_inode     = kvm_gmem_free_inode,
> >> >  };
> >> >
> >> >  static int kvm_gmem_init_fs_context(struct fs_context *fc)
> >> > @@ -549,12 +645,26 @@ static const struct inode_operations kvm_gmem_iops = {
> >> >  static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
> >> >                                                     loff_t size, u64 flags)
> >> >  {
> >> > +     struct kvm_gmem_inode_private *private;
> >> >       struct inode *inode;
> >> > +     int err;
> >> >
> >> >       inode = alloc_anon_secure_inode(kvm_gmem_mnt->mnt_sb, name);
> >> >       if (IS_ERR(inode))
> >> >               return inode;
> >> >
> >> > +     err = -ENOMEM;
> >> > +     private = kzalloc(sizeof(*private), GFP_KERNEL);
> >> > +     if (!private)
> >> > +             goto out;
> >> > +
> >> > +     mt_init(&private->shareability);
> >> Wrap the mt_init() inside "#ifdef CONFIG_KVM_GMEM_SHARED_MEM" ?
> >>
> >> > +     inode->i_mapping->i_private_data = private;
> >> > +
> >> > +     err = kvm_gmem_shareability_setup(private, size, flags);
> >> > +     if (err)
> >> > +             goto out;
> >> > +
> >> >       inode->i_private = (void *)(unsigned long)flags;
> >> >       inode->i_op = &kvm_gmem_iops;
> >> >       inode->i_mapping->a_ops = &kvm_gmem_aops;
> >> > @@ -566,6 +676,11 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
> >> >       WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> >> >
> >> >       return inode;
> >> > +
> >> > +out:
> >> > +     iput(inode);
> >> > +
> >> > +     return ERR_PTR(err);
> >> >  }
> >> >
> >> >  static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
> >> > @@ -654,6 +769,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
> >> >       if (kvm_arch_vm_supports_gmem_shared_mem(kvm))
> >> >               valid_flags |= GUEST_MEMFD_FLAG_SUPPORT_SHARED;
> >> >
> >> > +     if (flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED)
> >> > +             valid_flags |= GUEST_MEMFD_FLAG_INIT_PRIVATE;
> >> > +
> >> >       if (flags & ~valid_flags)
> >> >               return -EINVAL;
> >> >
> >> > @@ -842,6 +960,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> >> >       if (!file)
> >> >               return -EFAULT;
> >> >
> >> > +     filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
> >> > +
> >> >       folio = __kvm_gmem_get_pfn(file, slot, index, pfn, &is_prepared, max_order);
> >> >       if (IS_ERR(folio)) {
> >> >               r = PTR_ERR(folio);
> >> > @@ -857,8 +977,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> >> >               *page = folio_file_page(folio, index);
> >> >       else
> >> >               folio_put(folio);
> >> > -
> >> >  out:
> >> > +     filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
> >> >       fput(file);
> >> >       return r;
> >> >  }
> >> > --
> >> > 2.49.0.1045.g170613ef41-goog
> >> >
> >> >

