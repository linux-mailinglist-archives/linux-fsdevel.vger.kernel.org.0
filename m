Return-Path: <linux-fsdevel+bounces-69061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 31263C6DAE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A2EA349515
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0B7338590;
	Wed, 19 Nov 2025 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlTNcb3M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452A6199252;
	Wed, 19 Nov 2025 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543786; cv=none; b=IvDEI1iZXjW0mZUiDghf6M4K7JIZHHuqBnAhiRcykizMl1XC2ncb/ebE2tHjd4KnfsWL0dwlhRkSd5R7gc3MrAeTtGMAbQiqq6Bxm6nUbBizHJ8tj/Yb0wdgS2kO126S44SFqPQpibqub+IZtOfUqZWP2aV08bxPFmMLqmpS1g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543786; c=relaxed/simple;
	bh=pVtZ+fK4btyZD14SaYan12k/0/Sh9SgT5AKYHSQTNMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJuPSS9N29S4zTbBM+8woqzXeTq4t8SnpBC4QmYPZcz5qtHe67yQFJCtAWSxJ0vRgqQCR4KetyR4eYa+LbxCNZhonBsLlVtz6jj5itakuI7oBtbgCfHnZ3qaVYT83qEZCGOcg9EToObXBEsgaOrVsn68qDzjR+gXm6iUiGsso0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlTNcb3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25F6C2BCB6;
	Wed, 19 Nov 2025 09:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763543785;
	bh=pVtZ+fK4btyZD14SaYan12k/0/Sh9SgT5AKYHSQTNMw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FlTNcb3MPw83x3iSu8dqCCFLrB+fCZKLBfiYE+hxgj98uFnZcSe9DxEcrzBDKIDDm
	 l3wkzpgeMFUFKVOYtzOHyLB9/xL7CRM7yxH98fJjZNlmwshO13xwdCRQp55x2+qquh
	 oVQqZMKP8QH9QroiilyrMy9gf9M6JRIsOI/kyUri7SnctuceDpLp5rkwi+9wCp8e9Y
	 BQdJZpQHyWFKT1ah1HnhIGAkT3ytbceyguPa5erSYk4TFZUTNAeRN0w763wzefvhI4
	 4qMjkvkep1aLhSQla5QjFmeCoSpBQ3r0pOf+gHLXvOtnx4H4kWigjtQ8YwR6OLMXDv
	 jWH4MV5JyfsoA==
Message-ID: <61f7c6d2-a15e-4c6a-9704-0e3db65eed3c@kernel.org>
Date: Wed, 19 Nov 2025 10:16:14 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] mm: set the VM_MAYBE_GUARD flag on guard region
 install
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
References: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
 <e9e9ce95b6ac17497de7f60fc110c7dd9e489e8d.1763460113.git.lorenzo.stoakes@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <e9e9ce95b6ac17497de7f60fc110c7dd9e489e8d.1763460113.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   
> +/* Can we retract page tables for this file-backed VMA? */
> +static bool file_backed_vma_is_retractable(struct vm_area_struct *vma)

It's not really the VMA that is retractable :)

Given that the function we are called this from is called 
"retract_page_tables" (and not file_backed_...) I guess I would just 
have called this

"page_tables_are_retractable"

"page_tables_support_retract"

Or sth. along those lines.

> +{
> +	/*
> +	 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
> +	 * got written to. These VMAs are likely not worth removing
> +	 * page tables from, as PMD-mapping is likely to be split later.
> +	 */
> +	if (READ_ONCE(vma->anon_vma))
> +		return false;
> +
> +	/*
> +	 * When a vma is registered with uffd-wp, we cannot recycle
> +	 * the page table because there may be pte markers installed.
> +	 * Other vmas can still have the same file mapped hugely, but
> +	 * skip this one: it will always be mapped in small page size
> +	 * for uffd-wp registered ranges.
> +	 */
> +	if (userfaultfd_wp(vma))
> +		return false;
> +
> +	/*
> +	 * If the VMA contains guard regions then we can't collapse it.
> +	 *
> +	 * This is set atomically on guard marker installation under mmap/VMA
> +	 * read lock, and here we may not hold any VMA or mmap lock at all.
> +	 *
> +	 * This is therefore serialised on the PTE page table lock, which is
> +	 * obtained on guard region installation after the flag is set, so this
> +	 * check being performed under this lock excludes races.
> +	 */
> +	if (vma_flag_test_atomic(vma, VM_MAYBE_GUARD_BIT))
> +		return false;
> +
> +	return true;
> +}
> +
>   static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>   {
>   	struct vm_area_struct *vma;
> @@ -1724,14 +1761,6 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>   		spinlock_t *ptl;
>   		bool success = false;
>   
> -		/*
> -		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
> -		 * got written to. These VMAs are likely not worth removing
> -		 * page tables from, as PMD-mapping is likely to be split later.
> -		 */
> -		if (READ_ONCE(vma->anon_vma))
> -			continue;
> -
>   		addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>   		if (addr & ~HPAGE_PMD_MASK ||
>   		    vma->vm_end < addr + HPAGE_PMD_SIZE)
> @@ -1743,14 +1772,8 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>   
>   		if (hpage_collapse_test_exit(mm))
>   			continue;
> -		/*
> -		 * When a vma is registered with uffd-wp, we cannot recycle
> -		 * the page table because there may be pte markers installed.
> -		 * Other vmas can still have the same file mapped hugely, but
> -		 * skip this one: it will always be mapped in small page size
> -		 * for uffd-wp registered ranges.
> -		 */
> -		if (userfaultfd_wp(vma))
> +
> +		if (!file_backed_vma_is_retractable(vma))
>   			continue;
>   
>   		/* PTEs were notified when unmapped; but now for the PMD? */
> @@ -1777,15 +1800,15 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>   			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>   
>   		/*
> -		 * Huge page lock is still held, so normally the page table
> -		 * must remain empty; and we have already skipped anon_vma
> -		 * and userfaultfd_wp() vmas.  But since the mmap_lock is not
> -		 * held, it is still possible for a racing userfaultfd_ioctl()
> -		 * to have inserted ptes or markers.  Now that we hold ptlock,
> -		 * repeating the anon_vma check protects from one category,
> -		 * and repeating the userfaultfd_wp() check from another.
> +		 * Huge page lock is still held, so normally the page table must
> +		 * remain empty; and we have already skipped anon_vma and
> +		 * userfaultfd_wp() vmas.  But since the mmap_lock is not held,
> +		 * it is still possible for a racing userfaultfd_ioctl() or
> +		 * madvise() to have inserted ptes or markers.  Now that we hold
> +		 * ptlock, repeating the retractable checks protects us from
> +		 * races against the prior checks.
>   		 */
> -		if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
> +		if (likely(file_backed_vma_is_retractable(vma))) {
>   			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
>   			pmdp_get_lockless_sync();
>   			success = true;
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 0b3280752bfb..5dbe40be7c65 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1141,15 +1141,21 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
>   		return -EINVAL;
>   
>   	/*
> -	 * If we install guard markers, then the range is no longer
> -	 * empty from a page table perspective and therefore it's
> -	 * appropriate to have an anon_vma.
> -	 *
> -	 * This ensures that on fork, we copy page tables correctly.
> +	 * Set atomically under read lock. All pertinent readers will need to
> +	 * acquire an mmap/VMA write lock to read it. All remaining readers may
> +	 * or may not see the flag set, but we don't care.
> +	 */
> +	vma_flag_set_atomic(vma, VM_MAYBE_GUARD_BIT);
> +

In general LGTM.

> +	/*
> +	 * If anonymous and we are establishing page tables the VMA ought to
> +	 * have an anon_vma associated with it.

Do you know why? I know that as soon as we have anon folios in there we 
need it, but is it still required for guard regions? Patch #5 should 
handle the for case I guess.

Which other code depends on that?

-- 
Cheers

David

