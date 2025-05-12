Return-Path: <linux-fsdevel+bounces-48721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27688AB3387
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2546860512
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B56725FA02;
	Mon, 12 May 2025 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGBw6o7M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6042500CF;
	Mon, 12 May 2025 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041852; cv=none; b=FDNvvPWZ+n9h8wxCOzHyw1Gn0ifTDzx5IdIqN2/JW0WfsX8XZkBPfDpWqSJdrEzNRiEhsewExsdLZN/2dFzldObU0mDjQyc2HxdnRyWPnrNDAxaMkC/HjPn2PvJwL3/7QGVo7GM41vMGfKnvHQfAzBp9VBY+jJb1MCnVzvI+75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041852; c=relaxed/simple;
	bh=+1IOHdKISoxG3w9nCLHNQVvF2wUG/YP4+W5ADs4xvDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JU3jbhTxTFz8WC6SwiDbqqcZTfCLgO2ORY7G5iiPFrx6i9f1Aoe4A8ZuyNum6OzdSwSSFGKWk1oEnL7Bf0xjXsEW36iq2M02EgGkpA132tMTaV0vJ9wuXsXnxFlSStaOnrZYM0gdivC3hoHjH89HPBpwXPlhbGmRHwtr7gg1rT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGBw6o7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11882C4CEE7;
	Mon, 12 May 2025 09:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747041852;
	bh=+1IOHdKISoxG3w9nCLHNQVvF2wUG/YP4+W5ADs4xvDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SGBw6o7M/brLv8Uxis1et1W3SjhWCKv041fJQRSAPJhpHLZ35qyiyW119UaxE6run
	 HZtZgorqb3N+W2kGqaMkrxvV45uu78eB6zggHTmR3RaAL7osdIdnqi9l90J25bzyvS
	 eLUlyNlhhpo+ETDgd0GmsDP9MUxZ8BYbAydcCQq9kJPLhEAptZl98eMpC3sVIQwP6O
	 KiZjcYnt3Ie9R6mtaRP4xpC69gcd6ZO1aG89k03QcV+LFGsCa13IGQ6mFvlM9jzb9o
	 LQJR5KznyRXjZkarId8x71+b4kWuyEHVm7zenxIiQ5UyQZSboPHaa3s7lIcYgXJyWn
	 XrinhYfsCh5zg==
Date: Mon, 12 May 2025 11:24:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/3] mm: introduce new .mmap_prepare() file callback
Message-ID: <20250512-starren-dannen-12f66d67b4f6@brauner>
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
 <adb36a7c4affd7393b2fc4b54cc5cfe211e41f71.1746792520.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adb36a7c4affd7393b2fc4b54cc5cfe211e41f71.1746792520.git.lorenzo.stoakes@oracle.com>

On Fri, May 09, 2025 at 01:13:34PM +0100, Lorenzo Stoakes wrote:
> Provide a means by which drivers can specify which fields of those
> permitted to be changed should be altered to prior to mmap()'ing a
> range (which may either result from a merge or from mapping an entirely new
> VMA).
> 
> Doing so is substantially safer than the existing .mmap() calback which
> provides unrestricted access to the part-constructed VMA and permits
> drivers and file systems to do 'creative' things which makes it hard to
> reason about the state of the VMA after the function returns.
> 
> The existing .mmap() callback's freedom has caused a great deal of issues,
> especially in error handling, as unwinding the mmap() state has proven to
> be non-trivial and caused significant issues in the past, for instance
> those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> error path behaviour").
> 
> It also necessitates a second attempt at merge once the .mmap() callback
> has completed, which has caused issues in the past, is awkward, adds
> overhead and is difficult to reason about.
> 
> The .mmap_prepare() callback eliminates this requirement, as we can update
> fields prior to even attempting the first merge. It is safer, as we heavily
> restrict what can actually be modified, and being invoked very early in the
> mmap() process, error handling can be performed safely with very little
> unwinding of state required.
> 
> The .mmap_prepare() and deprecated .mmap() callbacks are mutually
> exclusive, so we permit only one to be invoked at a time.
> 
> Update vma userland test stubs to account for changes.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/fs.h               | 25 ++++++++++++
>  include/linux/mm_types.h         | 24 +++++++++++
>  mm/memory.c                      |  3 +-
>  mm/mmap.c                        |  2 +-
>  mm/vma.c                         | 68 +++++++++++++++++++++++++++++++-
>  tools/testing/vma/vma_internal.h | 66 ++++++++++++++++++++++++++++---
>  6 files changed, 180 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 016b0fe1536e..e2721a1ff13d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2169,6 +2169,7 @@ struct file_operations {
>  	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
>  	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
>  				unsigned int poll_flags);
> +	int (*mmap_prepare)(struct vm_area_desc *);
>  } __randomize_layout;
>  
>  /* Supports async buffered reads */
> @@ -2238,11 +2239,35 @@ struct inode_operations {
>  	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
>  } ____cacheline_aligned;
>  
> +/* Did the driver provide valid mmap hook configuration? */
> +static inline bool file_has_valid_mmap_hooks(struct file *file)
> +{
> +	bool has_mmap = file->f_op->mmap;
> +	bool has_mmap_prepare = file->f_op->mmap_prepare;
> +
> +	/* Hooks are mutually exclusive. */
> +	if (WARN_ON_ONCE(has_mmap && has_mmap_prepare))
> +		return false;
> +	if (WARN_ON_ONCE(!has_mmap && !has_mmap_prepare))
> +		return false;
> +
> +	return true;
> +}
> +
>  static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> +	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
> +		return -EINVAL;
> +
>  	return file->f_op->mmap(file, vma);
>  }
>  
> +static inline int __call_mmap_prepare(struct file *file,
> +		struct vm_area_desc *desc)
> +{
> +	return file->f_op->mmap_prepare(desc);
> +}

nit: I would prefer if we could rename this to vfs_mmap() and
vfs_mmap_prepare() as this is in line with all the other vfs related
helpers we expose.

> +
>  extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
>  extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
>  extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index e76bade9ebb1..15808cad2bc1 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -763,6 +763,30 @@ struct vma_numab_state {
>  	int prev_scan_seq;
>  };
>  
> +/*
> + * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
> + * manipulate mutable fields which will cause those fields to be updated in the
> + * resultant VMA.
> + *
> + * Helper functions are not required for manipulating any field.
> + */
> +struct vm_area_desc {
> +	/* Immutable state. */
> +	struct mm_struct *mm;
> +	unsigned long start;
> +	unsigned long end;
> +
> +	/* Mutable fields. Populated with initial state. */
> +	pgoff_t pgoff;
> +	struct file *file;
> +	vm_flags_t vm_flags;
> +	pgprot_t page_prot;
> +
> +	/* Write-only fields. */
> +	const struct vm_operations_struct *vm_ops;
> +	void *private_data;
> +};
> +
>  /*
>   * This struct describes a virtual memory area. There is one of these
>   * per VM-area/task. A VM area is any part of the process virtual memory
> diff --git a/mm/memory.c b/mm/memory.c
> index 68c1d962d0ad..99af83434e7c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -527,10 +527,11 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>  		dump_page(page, "bad pte");
>  	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
>  		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
> -	pr_alert("file:%pD fault:%ps mmap:%ps read_folio:%ps\n",
> +	pr_alert("file:%pD fault:%ps mmap:%ps mmap_prepare: %ps read_folio:%ps\n",
>  		 vma->vm_file,
>  		 vma->vm_ops ? vma->vm_ops->fault : NULL,
>  		 vma->vm_file ? vma->vm_file->f_op->mmap : NULL,
> +		 vma->vm_file ? vma->vm_file->f_op->mmap_prepare : NULL,
>  		 mapping ? mapping->a_ops->read_folio : NULL);
>  	dump_stack();
>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 81dd962a1cfc..50f902c08341 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -475,7 +475,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  				vm_flags &= ~VM_MAYEXEC;
>  			}
>  
> -			if (!file->f_op->mmap)
> +			if (!file_has_valid_mmap_hooks(file))
>  				return -ENODEV;
>  			if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
>  				return -EINVAL;
> diff --git a/mm/vma.c b/mm/vma.c
> index 1f2634b29568..3f32e04bb6cc 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -17,6 +17,11 @@ struct mmap_state {
>  	unsigned long pglen;
>  	unsigned long flags;
>  	struct file *file;
> +	pgprot_t page_prot;
> +
> +	/* User-defined fields, perhaps updated by .mmap_prepare(). */
> +	const struct vm_operations_struct *vm_ops;
> +	void *vm_private_data;
>  
>  	unsigned long charged;
>  	bool retry_merge;
> @@ -40,6 +45,7 @@ struct mmap_state {
>  		.pglen = PHYS_PFN(len_),				\
>  		.flags = flags_,					\
>  		.file = file_,						\
> +		.page_prot = vm_get_page_prot(flags_),			\
>  	}
>  
>  #define VMG_MMAP_STATE(name, map_, vma_)				\
> @@ -2385,6 +2391,10 @@ static int __mmap_new_file_vma(struct mmap_state *map,
>  	int error;
>  
>  	vma->vm_file = get_file(map->file);
> +
> +	if (!map->file->f_op->mmap)
> +		return 0;
> +
>  	error = mmap_file(vma->vm_file, vma);
>  	if (error) {
>  		fput(vma->vm_file);
> @@ -2441,7 +2451,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
>  	vma_iter_config(vmi, map->addr, map->end);
>  	vma_set_range(vma, map->addr, map->end, map->pgoff);
>  	vm_flags_init(vma, map->flags);
> -	vma->vm_page_prot = vm_get_page_prot(map->flags);
> +	vma->vm_page_prot = map->page_prot;
>  
>  	if (vma_iter_prealloc(vmi, vma)) {
>  		error = -ENOMEM;
> @@ -2528,6 +2538,56 @@ static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
>  	vma_set_page_prot(vma);
>  }
>  
> +/*
> + * Invoke the f_op->mmap_prepare() callback for a file-backed mapping that
> + * specifies it.
> + *
> + * This is called prior to any merge attempt, and updates whitelisted fields
> + * that are permitted to be updated by the caller.
> + *
> + * All but user-defined fields will be pre-populated with original values.
> + *
> + * Returns 0 on success, or an error code otherwise.
> + */
> +static int call_mmap_prepare(struct mmap_state *map)
> +{
> +	int err;
> +	struct vm_area_desc desc = {
> +		.mm = map->mm,
> +		.start = map->addr,
> +		.end = map->end,
> +
> +		.pgoff = map->pgoff,
> +		.file = map->file,
> +		.vm_flags = map->flags,
> +		.page_prot = map->page_prot,
> +	};
> +
> +	/* Invoke the hook. */
> +	err = __call_mmap_prepare(map->file, &desc);
> +	if (err)
> +		return err;
> +
> +	/* Update fields permitted to be changed. */
> +	map->pgoff = desc.pgoff;
> +	map->file = desc.file;
> +	map->flags = desc.vm_flags;
> +	map->page_prot = desc.page_prot;
> +	/* User-defined fields. */
> +	map->vm_ops = desc.vm_ops;
> +	map->vm_private_data = desc.private_data;
> +
> +	return 0;
> +}
> +
> +static void set_vma_user_defined_fields(struct vm_area_struct *vma,
> +		struct mmap_state *map)
> +{
> +	if (map->vm_ops)
> +		vma->vm_ops = map->vm_ops;
> +	vma->vm_private_data = map->vm_private_data;
> +}
> +
>  static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
>  		struct list_head *uf)
> @@ -2535,10 +2595,13 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma = NULL;
>  	int error;
> +	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
>  	VMA_ITERATOR(vmi, mm, addr);
>  	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
>  
>  	error = __mmap_prepare(&map, uf);
> +	if (!error && have_mmap_prepare)
> +		error = call_mmap_prepare(&map);
>  	if (error)
>  		goto abort_munmap;
>  
> @@ -2556,6 +2619,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  			goto unacct_error;
>  	}
>  
> +	if (have_mmap_prepare)
> +		set_vma_user_defined_fields(vma, &map);
> +
>  	/* If flags changed, we might be able to merge, so try again. */
>  	if (map.retry_merge) {
>  		struct vm_area_struct *merged;
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 198abe66de5a..f6e45e62da3a 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -253,8 +253,40 @@ struct mm_struct {
>  	unsigned long flags; /* Must use atomic bitops to access */
>  };
>  
> +struct vm_area_struct;
> +
> +/*
> + * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
> + * manipulate mutable fields which will cause those fields to be updated in the
> + * resultant VMA.
> + *
> + * Helper functions are not required for manipulating any field.
> + */
> +struct vm_area_desc {
> +	/* Immutable state. */
> +	struct mm_struct *mm;
> +	unsigned long start;
> +	unsigned long end;
> +
> +	/* Mutable fields. Populated with initial state. */
> +	pgoff_t pgoff;
> +	struct file *file;
> +	vm_flags_t vm_flags;
> +	pgprot_t page_prot;
> +
> +	/* Write-only fields. */
> +	const struct vm_operations_struct *vm_ops;
> +	void *private_data;
> +};
> +
> +struct file_operations {
> +	int (*mmap)(struct file *, struct vm_area_struct *);
> +	int (*mmap_prepare)(struct vm_area_desc *);
> +};
> +
>  struct file {
>  	struct address_space	*f_mapping;
> +	const struct file_operations	*f_op;
>  };
>  
>  #define VMA_LOCK_OFFSET	0x40000000
> @@ -1125,11 +1157,6 @@ static inline void vm_flags_clear(struct vm_area_struct *vma,
>  	vma->__vm_flags &= ~flags;
>  }
>  
> -static inline int call_mmap(struct file *, struct vm_area_struct *)
> -{
> -	return 0;
> -}
> -
>  static inline int shmem_zero_setup(struct vm_area_struct *)
>  {
>  	return 0;
> @@ -1405,4 +1432,33 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
>  	(void)vma;
>  }
>  
> +/* Did the driver provide valid mmap hook configuration? */
> +static inline bool file_has_valid_mmap_hooks(struct file *file)
> +{
> +	bool has_mmap = file->f_op->mmap;
> +	bool has_mmap_prepare = file->f_op->mmap_prepare;
> +
> +	/* Hooks are mutually exclusive. */
> +	if (WARN_ON_ONCE(has_mmap && has_mmap_prepare))
> +		return false;
> +	if (WARN_ON_ONCE(!has_mmap && !has_mmap_prepare))
> +		return false;
> +
> +	return true;
> +}
> +
> +static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
> +		return -EINVAL;
> +
> +	return file->f_op->mmap(file, vma);
> +}
> +
> +static inline int __call_mmap_prepare(struct file *file,
> +		struct vm_area_desc *desc)
> +{
> +	return file->f_op->mmap_prepare(desc);
> +}
> +
>  #endif	/* __MM_VMA_INTERNAL_H */
> -- 
> 2.49.0
> 

