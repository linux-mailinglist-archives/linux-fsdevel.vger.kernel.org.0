Return-Path: <linux-fsdevel+bounces-67675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F60C46339
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 12:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF6D3A78F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A2B3081D7;
	Mon, 10 Nov 2025 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suAfZZSb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F403923B616;
	Mon, 10 Nov 2025 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773481; cv=none; b=KExwkPNlDcHCckFBlni4cnATEvlB+wKJ1qtVF3gkf4I5/xjovHumznKjqVjtwXWg8VLHOqvO5XYlueD7SWvw8wRBKfs3q/4VNPVbW/rB5CbHr9pxmrAQz7Dl9gQLS1Bv2qj5bKDzpFvd8OouIbP+1cbxfbLV01BQmfya/BGyFDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773481; c=relaxed/simple;
	bh=Kl3noGEumLrebFoTSEUpT8n+WyWcc5CDX7vO2T8znyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsD3yyKFanaEOK8PRxPgK3aHYTh0IdcJuqY8lF/WU4iLKAK0ki3EMd2RBdobcDuyq32kDEGR25WjXuQz4JTyFB8XzvjWcfOza/Iwtb7zzU/frx4e5Bno2hMCK1Lvfz88nMUd0VSUNG26TapWJ+495NN53CrZnaZwc3kjTY+INGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suAfZZSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C43C116B1;
	Mon, 10 Nov 2025 11:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762773480;
	bh=Kl3noGEumLrebFoTSEUpT8n+WyWcc5CDX7vO2T8znyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=suAfZZSbiazW8sFc3Ab8Dx4NBPVEAhiluxobak9p2W7fV7tGaO7etyuexr+Wd3vCj
	 PqHxUnnNW7q++eT7YBuJNwAJ3rvKAo7XoOn6lFdrMFjUD3WX+vxmv61jmLfPOYOs4S
	 kgsdkCyDsNIp911BsonJsPQag0KfEYtcFcMSuVKaDEiv4/3VDw0E9C2G+b/HLgSKiW
	 SvzHr4R5cUfu3krfZf0NcIhD1aEvXuOLOydf18+trvSrzMjKoRzc936vRumSNGLv/7
	 zHFW012E2kZECXgXkvGjDJltpN+//CUP2yGc+d3k9TyonAEyXSC/gzEyX+zosgPkV/
	 y+Taz5qHRrJ5A==
Date: Mon, 10 Nov 2025 13:17:37 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 01/16] mm: correctly handle UFFD PTE markers
Message-ID: <aRHJ0RDu9fJGEBF8@kernel.org>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
 <0b50fd4b1d3241d0965e6b969fb49bcc14704d9b.1762621568.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b50fd4b1d3241d0965e6b969fb49bcc14704d9b.1762621568.git.lorenzo.stoakes@oracle.com>

On Sat, Nov 08, 2025 at 05:08:15PM +0000, Lorenzo Stoakes wrote:
> PTE markers were previously only concerned with UFFD-specific logic - that
> is, PTE entries with the UFFD WP marker set or those marked via
> UFFDIO_POISON.
> 
> However since the introduction of guard markers in commit
>  7c53dfbdb024 ("mm: add PTE_MARKER_GUARD PTE marker"), this has no longer
>  been the case.
> 
> Issues have been avoided as guard regions are not permitted in conjunction
> with UFFD, but it still leaves very confusing logic in place, most notably
> the misleading and poorly named pte_none_mostly() and
> huge_pte_none_mostly().
> 
> This predicate returns true for PTE entries that ought to be treated as
> none, but only in certain circumstances, and on the assumption we are
> dealing with H/W poison markers or UFFD WP markers.
> 
> This patch removes these functions and makes each invocation of these
> functions instead explicitly check what it needs to check.
> 
> As part of this effort it introduces is_uffd_pte_marker() to explicitly
> determine if a marker in fact is used as part of UFFD or not.
> 
> In the HMM logic we note that the only time we would need to check for a
> fault is in the case of a UFFD WP marker, otherwise we simply encounter a
> fault error (VM_FAULT_HWPOISON for H/W poisoned marker, VM_FAULT_SIGSEGV
> for a guard marker), so only check for the UFFD WP case.
> 
> While we're here we also refactor code to make it easier to understand.
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  fs/userfaultfd.c              | 83 +++++++++++++++++++----------------
>  include/asm-generic/hugetlb.h |  8 ----
>  include/linux/swapops.h       | 18 --------
>  include/linux/userfaultfd_k.h | 21 +++++++++
>  mm/hmm.c                      |  2 +-
>  mm/hugetlb.c                  | 47 ++++++++++----------
>  mm/mincore.c                  | 17 +++++--
>  mm/userfaultfd.c              | 27 +++++++-----
>  8 files changed, 123 insertions(+), 100 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 54c6cc7fe9c6..04c66b5001d5 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -233,40 +233,46 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	pte_t *ptep, pte;
> -	bool ret = true;
>  
>  	assert_fault_locked(vmf);
>  
>  	ptep = hugetlb_walk(vma, vmf->address, vma_mmu_pagesize(vma));
>  	if (!ptep)
> -		goto out;
> +		return true;
>  
> -	ret = false;
>  	pte = huge_ptep_get(vma->vm_mm, vmf->address, ptep);
>  
>  	/*
>  	 * Lockless access: we're in a wait_event so it's ok if it
> -	 * changes under us.  PTE markers should be handled the same as none
> -	 * ptes here.
> +	 * changes under us.
>  	 */
> -	if (huge_pte_none_mostly(pte))
> -		ret = true;
> +
> +	/* If missing entry, wait for handler. */

It's actually #PF handler that waits ;-)

When userfaultfd_(huge_)must_wait() return true, it means that process that
caused a fault should wait until userspace resolves the fault and return
false means that it's ok to retry the #PF.

So the comment here should probably read as

	/* entry is still missing, wait for userspace to resolve the fault */

and the rest of the comments here and in userfaultfd_must_wait() need
similar update.

> +	if (huge_pte_none(pte))
> +		return true;
> +	/* UFFD PTE markers require handling. */
> +	if (is_uffd_pte_marker(pte))
> +		return true;
> +	/* If VMA has UFFD WP faults enabled and WP fault, wait for handler. */
>  	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
> -		ret = true;
> -out:
> -	return ret;
> +		return true;
> +
> +	/* Otherwise, if entry isn't present, let fault handler deal with it. */

Entry is actually present here, e.g because there is a thread that called
UFFDIO_COPY in parallel with the fault, so no need to stuck the faulting
process.

> +	return false;
>  }
>  #else
>  static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
>  					      struct vm_fault *vmf,
>  					      unsigned long reason)
>  {
> -	return false;	/* should never get here */
> +	/* Should never get here. */
> +	VM_WARN_ON_ONCE(1);
> +	return false;
>  }
>  #endif /* CONFIG_HUGETLB_PAGE */
>  
>  /*
> - * Verify the pagetables are still not ok after having reigstered into
> + * Verify the pagetables are still not ok after having registered into
>   * the fault_pending_wqh to avoid userland having to UFFDIO_WAKE any
>   * userfault that has already been resolved, if userfaultfd_read_iter and
>   * UFFDIO_COPY|ZEROPAGE are being run simultaneously on two different
> @@ -284,53 +290,55 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
>  	pmd_t *pmd, _pmd;
>  	pte_t *pte;
>  	pte_t ptent;
> -	bool ret = true;
> +	bool ret;
>  
>  	assert_fault_locked(vmf);
>  
>  	pgd = pgd_offset(mm, address);
>  	if (!pgd_present(*pgd))
> -		goto out;
> +		return true;
>  	p4d = p4d_offset(pgd, address);
>  	if (!p4d_present(*p4d))
> -		goto out;
> +		return true;
>  	pud = pud_offset(p4d, address);
>  	if (!pud_present(*pud))
> -		goto out;
> +		return true;
>  	pmd = pmd_offset(pud, address);
>  again:
>  	_pmd = pmdp_get_lockless(pmd);
>  	if (pmd_none(_pmd))
> -		goto out;
> +		return true;
>  
> -	ret = false;
>  	if (!pmd_present(_pmd))
> -		goto out;
> +		return false;

This one is actually tricky, maybe it's worth adding a gist of commit log
from a365ac09d334 ("mm, userfaultfd, THP: avoid waiting when PMD under THP migration")
as a comment.

>  
> -	if (pmd_trans_huge(_pmd)) {
> -		if (!pmd_write(_pmd) && (reason & VM_UFFD_WP))
> -			ret = true;
> -		goto out;
> -	}
> +	if (pmd_trans_huge(_pmd))
> +		return !pmd_write(_pmd) && (reason & VM_UFFD_WP);

...

> diff --git a/mm/hmm.c b/mm/hmm.c
> index a56081d67ad6..43d4a91035ff 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -244,7 +244,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>  	uint64_t pfn_req_flags = *hmm_pfn;
>  	uint64_t new_pfn_flags = 0;
>  
> -	if (pte_none_mostly(pte)) {
> +	if (pte_none(pte) || pte_marker_uffd_wp(pte)) {

Would be nice to add the note from the changelog as a comment here.

>  		required_fault =
>  			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
>  		if (required_fault)

-- 
Sincerely yours,
Mike.

