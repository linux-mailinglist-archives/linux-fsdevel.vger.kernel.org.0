Return-Path: <linux-fsdevel+bounces-7059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3E08213F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 15:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B340F1F216FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A31B63C7;
	Mon,  1 Jan 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z0G2xAzH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B0D6107;
	Mon,  1 Jan 2024 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QRdEn0NaJiEbRMphd2l3d+AB5MhJXfTmZ+Djh+NAXgM=; b=Z0G2xAzHGXfIIvdWetmiLf5NIU
	JQauzKrlkPq9bsgE1GRFBPe32I9it1i/aw//Qu0y3CWwwO9Udb4fy1WWpc8wroUToamA1f+hFZLV5
	dYwVS6i3FqKRN9uzCJO24Pzmq7zX+HveCTEmtMyQxWL0EMyKWQ/B+TKfqtM6hnBgyW1bZ5TfKC3Y6
	phZdBzmlOpI7zpXc1V+TRjFf1VBvdy4CzUB1qQ9qjb7DziEXT5xYIQfq2luXFeQBtnHCcVuS0Eraf
	d85B+N2gzsD7uyVnckb00rVsE/r4AgBthARU4CgyePzGXMsoPe2Nx3l4pIvoySza6K8fo0HTX6ntU
	6lldKCaw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rKJ0Q-008bvC-9G; Mon, 01 Jan 2024 14:11:02 +0000
Date: Mon, 1 Jan 2024 14:11:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 6.6.8 stable: crash in folio_mark_dirty
Message-ID: <ZZLH9u9KGUgqAmGC@casper.infradead.org>
References: <8bb29431064fc1f70a42edef75a8788dd4a0eecc.camel@sapience.com>
 <20231231012846.2355-1-hdanton@sina.com>
 <20240101015504.2446-1-hdanton@sina.com>
 <20240101113316.2595-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240101113316.2595-1-hdanton@sina.com>

On Mon, Jan 01, 2024 at 07:33:16PM +0800, Hillf Danton wrote:
> On Mon, 1 Jan 2024 09:07:52 +0000 Matthew Wilcox
> > On Mon, Jan 01, 2024 at 09:55:04AM +0800, Hillf Danton wrote:
> > > On Sun, 31 Dec 2023 13:07:03 +0000 Matthew Wilcox <willy@infradead.org>
> > > > I don't think this can happen.  Look at the call trace;
> > > > block_dirty_folio() is called from unmap_page_range().  That means the
> > > > page is in the page tables.  We unmap the pages in a folio from the
> > > > page tables before we set folio->mapping to NULL.  Look at
> > > > invalidate_inode_pages2_range() for example:
> > > > 
> > > >                                 unmap_mapping_pages(mapping, indices[i],
> > > >                                                 (1 + end - indices[i]), false);
> > > >                         folio_lock(folio);
> > > >                         folio_wait_writeback(folio);
> > > >                         if (folio_mapped(folio))
> > > >                                 unmap_mapping_folio(folio);
> > > >                         BUG_ON(folio_mapped(folio));
> > > >                                 if (!invalidate_complete_folio2(mapping, folio))
> > > > 
> > > What is missed here is the same check [1] in invalidate_inode_pages2_range(),
> > > so I built no wheel.
> > > 
> > > 			folio_lock(folio);
> > > 			if (unlikely(folio->mapping != mapping)) {
> > > 				folio_unlock(folio);
> > > 				continue;
> > > 			}
> > > 
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/truncate.c#n658
> > 
> > That's entirely different.  That's checking in the truncate path whether
> > somebody else already truncated this page.  What I was showing was why
> > a page found through a page table walk cannot have been truncated (which
> > is actually quite interesting, because it's the page table lock that
> > prevents the race).
> > 
> Feel free to shed light on how ptl protects folio->mapping.

The documentation for __folio_mark_dirty() hints at it:

 * The caller must hold folio_memcg_lock().  Most callers have the folio
 * locked.  A few have the folio blocked from truncation through other
 * means (eg zap_vma_pages() has it mapped and is holding the page table
 * lock).  This can also be called from mark_buffer_dirty(), which I
 * cannot prove is always protected against truncate.

Re-reading that now, I _think_ mark_buffer_dirty() always has to be
called with a reference on the bufferhead, which means that a racing
truncate will fail due to

invalidate_inode_pages2_range -> invalidate_complete_folio2 -> 
filemap_release_folio -> try_to_free_buffers -> drop_buffers -> buffer_busy


From an mm point of view, what is implicit is that truncate calls
unmap_mapping_folio -> unmap_mapping_range_tree ->
unmap_mapping_range_vma -> zap_page_range_single -> unmap_single_vma ->
unmap_page_range -> zap_p4d_range -> zap_pud_range -> zap_pmd_range ->
zap_pte_range -> pte_offset_map_lock()

So a truncate will take the page lock, then spin on the pte lock
until the racing munmap() has finished (ok, this was an exit(), not
a munmap(), but exit() does an implicit munmap()).

