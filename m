Return-Path: <linux-fsdevel+bounces-49471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E462ABCE05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 05:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D011B16A731
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 03:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF62258CDA;
	Tue, 20 May 2025 03:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pNNlH6sk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F5E21B8E0
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 03:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747713337; cv=none; b=rkvuXtYhunsZWNrGSgZSHhpUXHMqyU2sCPjb2z0lCcODdjIzqqkNmXLnEW1FOCj8itAqih2X4U1dnaN7J1UlNOibVEz0ilOrm53CLLxWcVDKsdVRBvtYkqEsjPxC607TnXB7oSx0uNPZphz+8RkGhdXc7yqjlNd3o4N+fA2Xoko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747713337; c=relaxed/simple;
	bh=w8WHRQYEpuCWeHAPB9nFkldqFCPHSRWCIyyrfG+VjFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/pddRfQuo4Epgeuhfft62IcaeEmhh28nuCSAY5i1c1BokgKmsP0CRFWtaPHNfvAGJZ4leQLUvrWRC+gqBZYmfnRASBSE6hqHGUly1UoABEgFamrE2urph7+ew5DWtU3tzPZXBnYDbCCxkClDICrzeZ4XRru31GKjqU7l4b/DaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pNNlH6sk; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac4301b5-6f82-49f2-9c71-7c4c015d48f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747713332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0vG90czwujKi76lIQqwAygZDtoFqpt79hvyKmQojSMw=;
	b=pNNlH6sk3FlySAJ2Aw+t5Bg4vSx9G6WX8djrJhqbRgeMvqruf1NO15m2qRa2PpbBOPRc2S
	Fy1yTcad3nqHDLHSgyckiR558t39k1/j+oSFYS1c9+HcaOOoJ/Km+GZwdy0UItkQ2Beinh
	+8rG3OypIkNx9VpA/94mcyJ07b7xtoE=
Date: Tue, 20 May 2025 11:55:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] mm: prevent KSM from completely breaking VMA merging
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
 Xu Xin <xu.xin16@zte.com.cn>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/5/19 16:51, Lorenzo Stoakes wrote:
> If a user wishes to enable KSM mergeability for an entire process and all
> fork/exec'd processes that come after it, they use the prctl()
> PR_SET_MEMORY_MERGE operation.
> 
> This defaults all newly mapped VMAs to have the VM_MERGEABLE VMA flag set
> (in order to indicate they are KSM mergeable), as well as setting this flag
> for all existing VMAs.
> 
> However it also entirely and completely breaks VMA merging for the process
> and all forked (and fork/exec'd) processes.
> 
> This is because when a new mapping is proposed, the flags specified will
> never have VM_MERGEABLE set. However all adjacent VMAs will already have
> VM_MERGEABLE set, rendering VMAs unmergeable by default.
> 
> To work around this, we try to set the VM_MERGEABLE flag prior to
> attempting a merge. In the case of brk() this can always be done.
> 
> However on mmap() things are more complicated - while KSM is not supported
> for file-backed mappings, it is supported for MAP_PRIVATE file-backed
> mappings.
> 
> And these mappings may have deprecated .mmap() callbacks specified which
> could, in theory, adjust flags and thus KSM merge eligiblity.
> 
> So we check to determine whether this at all possible. If not, we set
> VM_MERGEABLE prior to the merge attempt on mmap(), otherwise we retain the
> previous behaviour.
> 
> When .mmap_prepare() is more widely used, we can remove this precaution.
> 
> While this doesn't quite cover all cases, it covers a great many (all
> anonymous memory, for instance), meaning we should already see a
> significant improvement in VMA mergeability.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Looks good to me with the build fix. And it seems that ksm_add_vma()
is not used anymore..

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks!

> ---
>   include/linux/ksm.h |  4 ++--
>   mm/ksm.c            | 20 ++++++++++++------
>   mm/vma.c            | 49 +++++++++++++++++++++++++++++++++++++++++++--
>   3 files changed, 63 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index d73095b5cd96..ba5664daca6e 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -17,8 +17,8 @@
>   #ifdef CONFIG_KSM
>   int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>   		unsigned long end, int advice, unsigned long *vm_flags);
> -
> -void ksm_add_vma(struct vm_area_struct *vma);
> +vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
> +			 vm_flags_t vm_flags);
>   int ksm_enable_merge_any(struct mm_struct *mm);
>   int ksm_disable_merge_any(struct mm_struct *mm);
>   int ksm_disable(struct mm_struct *mm);
> diff --git a/mm/ksm.c b/mm/ksm.c
> index d0c763abd499..022af14a95ea 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2731,16 +2731,24 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
>   	return 0;
>   }
>   /**
> - * ksm_add_vma - Mark vma as mergeable if compatible
> + * ksm_vma_flags - Update VMA flags to mark as mergeable if compatible
>    *
> - * @vma:  Pointer to vma
> + * @mm:       Proposed VMA's mm_struct
> + * @file:     Proposed VMA's file-backed mapping, if any.
> + * @vm_flags: Proposed VMA"s flags.
> + *
> + * Returns: @vm_flags possibly updated to mark mergeable.
>    */
> -void ksm_add_vma(struct vm_area_struct *vma)
> +vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
> +			 vm_flags_t vm_flags)
>   {
> -	struct mm_struct *mm = vma->vm_mm;
> +	vm_flags_t ret = vm_flags;
>   
> -	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> -		__ksm_add_vma(vma);
> +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags) &&
> +	    __ksm_should_add_vma(file, vm_flags))
> +		ret |= VM_MERGEABLE;
> +
> +	return ret;
>   }
>   
>   static void ksm_add_vmas(struct mm_struct *mm)
> diff --git a/mm/vma.c b/mm/vma.c
> index 3ff6cfbe3338..5bebe55ea737 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2482,7 +2482,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
>   	 */
>   	if (!vma_is_anonymous(vma))
>   		khugepaged_enter_vma(vma, map->flags);
> -	ksm_add_vma(vma);
>   	*vmap = vma;
>   	return 0;
>   
> @@ -2585,6 +2584,45 @@ static void set_vma_user_defined_fields(struct vm_area_struct *vma,
>   	vma->vm_private_data = map->vm_private_data;
>   }
>   
> +static void update_ksm_flags(struct mmap_state *map)
> +{
> +	map->flags = ksm_vma_flags(map->mm, map->file, map->flags);
> +}
> +
> +/*
> + * Are we guaranteed no driver can change state such as to preclude KSM merging?
> + * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
> + *
> + * This is applicable when PR_SET_MEMORY_MERGE has been set on the mm_struct via
> + * prctl() causing newly mapped VMAs to have the KSM mergeable VMA flag set.
> + *
> + * If this is not the case, then we set the flag after considering mergeability,
> + * which will prevent mergeability as, when PR_SET_MEMORY_MERGE is set, a new
> + * VMA will not have the KSM mergeability VMA flag set, but all other VMAs will,
> + * preventing any merge.
> + */
> +static bool can_set_ksm_flags_early(struct mmap_state *map)
> +{
> +	struct file *file = map->file;
> +
> +	/* Anonymous mappings have no driver which can change them. */
> +	if (!file)
> +		return true;
> +
> +	/* shmem is safe. */
> +	if (shmem_file(file))
> +		return true;
> +
> +	/*
> +	 * If .mmap_prepare() is specified, then the driver will have already
> +	 * manipulated state prior to updating KSM flags.
> +	 */
> +	if (file->f_op->mmap_prepare)
> +		return true;
> +
> +	return false;
> +}
> +
>   static unsigned long __mmap_region(struct file *file, unsigned long addr,
>   		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
>   		struct list_head *uf)
> @@ -2595,6 +2633,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>   	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
>   	VMA_ITERATOR(vmi, mm, addr);
>   	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
> +	bool check_ksm_early = can_set_ksm_flags_early(&map);
>   
>   	error = __mmap_prepare(&map, uf);
>   	if (!error && have_mmap_prepare)
> @@ -2602,6 +2641,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>   	if (error)
>   		goto abort_munmap;
>   
> +	if (check_ksm_early)
> +		update_ksm_flags(&map);
> +
>   	/* Attempt to merge with adjacent VMAs... */
>   	if (map.prev || map.next) {
>   		VMG_MMAP_STATE(vmg, &map, /* vma = */ NULL);
> @@ -2611,6 +2653,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>   
>   	/* ...but if we can't, allocate a new VMA. */
>   	if (!vma) {
> +		if (!check_ksm_early)
> +			update_ksm_flags(&map);
> +
>   		error = __mmap_new_vma(&map, &vma);
>   		if (error)
>   			goto unacct_error;
> @@ -2713,6 +2758,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>   	 * Note: This happens *after* clearing old mappings in some code paths.
>   	 */
>   	flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
> +	flags = ksm_vma_flags(mm, NULL, flags);
>   	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
>   		return -ENOMEM;
>   
> @@ -2756,7 +2802,6 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>   
>   	mm->map_count++;
>   	validate_mm(mm);
> -	ksm_add_vma(vma);
>   out:
>   	perf_event_mmap(vma);
>   	mm->total_vm += len >> PAGE_SHIFT;

