Return-Path: <linux-fsdevel+bounces-7057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2889082139C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 12:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02781F213C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 11:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD79823DB;
	Mon,  1 Jan 2024 11:33:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF1B20FD
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jan 2024 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.122])
	by sina.com (10.75.12.45) with ESMTP
	id 6592A30500007E54; Mon, 1 Jan 2024 19:33:31 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3265331457689
X-SMAIL-UIID: 05E51E30F69B439BA57A35AEF53799B8-20240101-193331-1
From: Hillf Danton <hdanton@sina.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Genes Lists <lists@sapience.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: 6.6.8 stable: crash in folio_mark_dirty
Date: Mon,  1 Jan 2024 19:33:16 +0800
Message-Id: <20240101113316.2595-1-hdanton@sina.com>
In-Reply-To: <ZZKA6Phgfa78kM9I@casper.infradead.org>
References: <8bb29431064fc1f70a42edef75a8788dd4a0eecc.camel@sapience.com> <20231231012846.2355-1-hdanton@sina.com> <20240101015504.2446-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 1 Jan 2024 09:07:52 +0000 Matthew Wilcox
> On Mon, Jan 01, 2024 at 09:55:04AM +0800, Hillf Danton wrote:
> > On Sun, 31 Dec 2023 13:07:03 +0000 Matthew Wilcox <willy@infradead.org>
> > > I don't think this can happen.  Look at the call trace;
> > > block_dirty_folio() is called from unmap_page_range().  That means the
> > > page is in the page tables.  We unmap the pages in a folio from the
> > > page tables before we set folio->mapping to NULL.  Look at
> > > invalidate_inode_pages2_range() for example:
> > > 
> > >                                 unmap_mapping_pages(mapping, indices[i],
> > >                                                 (1 + end - indices[i]), false);
> > >                         folio_lock(folio);
> > >                         folio_wait_writeback(folio);
> > >                         if (folio_mapped(folio))
> > >                                 unmap_mapping_folio(folio);
> > >                         BUG_ON(folio_mapped(folio));
> > >                                 if (!invalidate_complete_folio2(mapping, folio))
> > > 
> > What is missed here is the same check [1] in invalidate_inode_pages2_range(),
> > so I built no wheel.
> > 
> > 			folio_lock(folio);
> > 			if (unlikely(folio->mapping != mapping)) {
> > 				folio_unlock(folio);
> > 				continue;
> > 			}
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/truncate.c#n658
> 
> That's entirely different.  That's checking in the truncate path whether
> somebody else already truncated this page.  What I was showing was why
> a page found through a page table walk cannot have been truncated (which
> is actually quite interesting, because it's the page table lock that
> prevents the race).
> 
Feel free to shed light on how ptl protects folio->mapping.

