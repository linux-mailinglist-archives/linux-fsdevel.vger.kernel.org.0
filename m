Return-Path: <linux-fsdevel+bounces-67690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B490C46FDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 14:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4AC18834B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 13:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4D3311C24;
	Mon, 10 Nov 2025 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJRJnoHT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E1A30E0C5;
	Mon, 10 Nov 2025 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782309; cv=none; b=J+Ym0LAA5oRBo4e+cJkXLI3xrjF6kX1MGWi53H1IGQkZAFdOkVaEtmJuMjRQb6aiDePif7GN0cwIbqHlMockZo2PEc7vkU+XoJCclTGdF78EZc63zTUmLUHq3jvXKbmJBfDW/IxSAzIqscs/GPVZvWrqrgN2uT5G1DKYj7miw5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782309; c=relaxed/simple;
	bh=K1xogRmcdnJHCvjWGY+Er/5mR9phjWmkoC/mTpkqq+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBOnXyO6mpRXeUuvr70iBH2Yyaeuumh3auWYopNX0jxvbcstdPSvCQNpr0nct2QYRfkjfO9x29x6Pc6c5a6sZ9ryy4oEzv7bF8mzRP8BSmyDsLaEiGltX16IbYcSLAzhFZm66rJZskquyRz7qWcLa/ODVI/GdPmDHO1xFcOLVuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJRJnoHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5E7C4CEFB;
	Mon, 10 Nov 2025 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762782305;
	bh=K1xogRmcdnJHCvjWGY+Er/5mR9phjWmkoC/mTpkqq+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nJRJnoHTl+9Cbeu8AtpQVl6MNu8LP7vYCarp/uXV0NbcLGe5/UyGPbNA4xSCI2RwC
	 UPZmRzo9UEkoy089Iscpp5zjMrREPUnqLbKm++nbSkNKPu6x56aI+Xh3ev/QLMxEec
	 5c0fkBUdfIeOd6MKzMEIqZzG7e6gVDaVhCSdHwTLfdkd4kAYztyAKHnKyl3X+S3fzV
	 9ovZf4kVEn7eNQe3LemtVmi9zH1TsJkySJDyQTzaD4W3PCvng8gUNAjb73ZhIYrUPz
	 9YxUpUh25WrfYWIBf27UgkW6dDxg8oF9+SWT6FXPYKflLL4vUgUmyLlAW0YPlrGzUi
	 pT0FLuBk5ZvOQ==
Date: Mon, 10 Nov 2025 15:44:43 +0200
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
Message-ID: <aRHsSxhIikzC9AAN@kernel.org>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
 <0b50fd4b1d3241d0965e6b969fb49bcc14704d9b.1762621568.git.lorenzo.stoakes@oracle.com>
 <aRHJ0RDu9fJGEBF8@kernel.org>
 <1a77db9b-ddb2-42bc-8e8f-f4794a5bfc6d@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a77db9b-ddb2-42bc-8e8f-f4794a5bfc6d@lucifer.local>

On Mon, Nov 10, 2025 at 01:01:36PM +0000, Lorenzo Stoakes wrote:
> On Mon, Nov 10, 2025 at 01:17:37PM +0200, Mike Rapoport wrote:
> > On Sat, Nov 08, 2025 at 05:08:15PM +0000, Lorenzo Stoakes wrote:
> > > PTE markers were previously only concerned with UFFD-specific logic - that
> > > is, PTE entries with the UFFD WP marker set or those marked via
> > > UFFDIO_POISON.
> > >
> > > However since the introduction of guard markers in commit
> > >  7c53dfbdb024 ("mm: add PTE_MARKER_GUARD PTE marker"), this has no longer
> > >  been the case.
> > >
> > > Issues have been avoided as guard regions are not permitted in conjunction
> > > with UFFD, but it still leaves very confusing logic in place, most notably
> > > the misleading and poorly named pte_none_mostly() and
> > > huge_pte_none_mostly().
> > >
> > > This predicate returns true for PTE entries that ought to be treated as
> > > none, but only in certain circumstances, and on the assumption we are
> > > dealing with H/W poison markers or UFFD WP markers.
> > >
> > > This patch removes these functions and makes each invocation of these
> > > functions instead explicitly check what it needs to check.
> > >
> > > As part of this effort it introduces is_uffd_pte_marker() to explicitly
> > > determine if a marker in fact is used as part of UFFD or not.
> > >
> > > In the HMM logic we note that the only time we would need to check for a
> > > fault is in the case of a UFFD WP marker, otherwise we simply encounter a
> > > fault error (VM_FAULT_HWPOISON for H/W poisoned marker, VM_FAULT_SIGSEGV
> > > for a guard marker), so only check for the UFFD WP case.
> > >
> > > While we're here we also refactor code to make it easier to understand.
> > >
> > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  fs/userfaultfd.c              | 83 +++++++++++++++++++----------------
> > >  include/asm-generic/hugetlb.h |  8 ----
> > >  include/linux/swapops.h       | 18 --------
> > >  include/linux/userfaultfd_k.h | 21 +++++++++
> > >  mm/hmm.c                      |  2 +-
> > >  mm/hugetlb.c                  | 47 ++++++++++----------
> > >  mm/mincore.c                  | 17 +++++--
> > >  mm/userfaultfd.c              | 27 +++++++-----
> > >  8 files changed, 123 insertions(+), 100 deletions(-)
> > >
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index 54c6cc7fe9c6..04c66b5001d5 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> > > @@ -233,40 +233,46 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
> > >  {
> > >  	struct vm_area_struct *vma = vmf->vma;
> > >  	pte_t *ptep, pte;
> > > -	bool ret = true;
> > >
> > >  	assert_fault_locked(vmf);
> > >
> > >  	ptep = hugetlb_walk(vma, vmf->address, vma_mmu_pagesize(vma));
> > >  	if (!ptep)
> > > -		goto out;
> > > +		return true;
> > >
> > > -	ret = false;
> > >  	pte = huge_ptep_get(vma->vm_mm, vmf->address, ptep);
> > >
> > >  	/*
> > >  	 * Lockless access: we're in a wait_event so it's ok if it
> > > -	 * changes under us.  PTE markers should be handled the same as none
> > > -	 * ptes here.
> > > +	 * changes under us.
> > >  	 */
> > > -	if (huge_pte_none_mostly(pte))
> > > -		ret = true;
> > > +
> > > +	/* If missing entry, wait for handler. */
> >
> > It's actually #PF handler that waits ;-)
> 
> Think I meant uffd userland 'handler' as in handle_userfault(). But this is not
> clear obviously.
> 
> >
> > When userfaultfd_(huge_)must_wait() return true, it means that process that
> > caused a fault should wait until userspace resolves the fault and return
> > false means that it's ok to retry the #PF.
> 
> Yup.
> 
> >
> > So the comment here should probably read as
> >
> > 	/* entry is still missing, wait for userspace to resolve the fault */
> >
> 
> Will update to make clearer thanks.
> 
> >
> > > +	if (huge_pte_none(pte))
> > > +		return true;
> > > +	/* UFFD PTE markers require handling. */
> > > +	if (is_uffd_pte_marker(pte))
> > > +		return true;
> > > +	/* If VMA has UFFD WP faults enabled and WP fault, wait for handler. */
> > >  	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
> > > -		ret = true;
> > > -out:
> > > -	return ret;
> > > +		return true;
> > > +
> > > +	/* Otherwise, if entry isn't present, let fault handler deal with it. */
> >
> > Entry is actually present here, e.g because there is a thread that called
> > UFFDIO_COPY in parallel with the fault, so no need to stuck the faulting
> > process.
> 
> Well it might not be? Could be a swap entry, migration entry, etc. unless I'm
> missing cases? Point of comment was 'ok if non-present in a way that doesn't
> require a userfaultfd userland handler the fault handler will deal'
> 
> But anyway agree this isn't clear, probably better to just say 'otherwise no
> need for userland uffd handler to do anything here' or similar.

It's not that userspace does not need to do anything, it's just that pte is
good enough for the faulting thread to retry the page fault without waiting
for userspace to resolve the fault.
 
> Cheers, Lorenzo

-- 
Sincerely yours,
Mike.

