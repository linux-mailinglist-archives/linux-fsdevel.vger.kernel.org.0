Return-Path: <linux-fsdevel+bounces-7054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E7782135E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 10:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8091C20EEF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 09:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB743FEC;
	Mon,  1 Jan 2024 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dMJHNqsl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1C63C28;
	Mon,  1 Jan 2024 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HXbZ0sxnDZzhlQp2F6Mpy+dhtbcwpBUtIlShgaOKyHE=; b=dMJHNqslObVykUwGUh7oBNKQbJ
	dTBwsbSKgXSx6mgGrtVy6fS1Jco+6rzyqoL+TPl6tLvXlsVt7wXfSoU4rxIX1oge7YiPtoIVMSXHS
	u2gOa4ImoDONf8qjT/QhbvlRU4Ukk5+Ew/8JYvxPKmQXwqpBOvtf+gW6FYn9QLCb6ZZhpIrameylM
	88CAOLshXbNvBW3YAfHvodHqEjGcj/mB1SEHryW6SAEEmpzB9+kp7YDFuwzSJI6oV5raGMuUZ5oVi
	PP320X5QmfO4tdl4ARdwoFKAkTiU1x3J/aHPsOkIXs5PRfigvqowcGodoKDQUrkPDj3+E0o6pWSeE
	6OyWF2mA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rKEH2-008Rnu-77; Mon, 01 Jan 2024 09:07:52 +0000
Date: Mon, 1 Jan 2024 09:07:52 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 6.6.8 stable: crash in folio_mark_dirty
Message-ID: <ZZKA6Phgfa78kM9I@casper.infradead.org>
References: <8bb29431064fc1f70a42edef75a8788dd4a0eecc.camel@sapience.com>
 <20231231012846.2355-1-hdanton@sina.com>
 <20240101015504.2446-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240101015504.2446-1-hdanton@sina.com>

On Mon, Jan 01, 2024 at 09:55:04AM +0800, Hillf Danton wrote:
> On Sun, 31 Dec 2023 13:07:03 +0000 Matthew Wilcox <willy@infradead.org>
> > On Sun, Dec 31, 2023 at 09:28:46AM +0800, Hillf Danton wrote:
> > > On Sat, Dec 30, 2023 at 10:23:26AM -0500 Genes Lists <lists@sapience.com>
> > > > Apologies in advance, but I cannot git bisect this since machine was
> > > > running for 10 days on 6.6.8 before this happened.
> > > >
> > > > Dec 30 07:00:36 s6 kernel: ------------[ cut here ]------------
> > > > Dec 30 07:00:36 s6 kernel: WARNING: CPU: 0 PID: 521524 at mm/page-writeback.c:2668 __folio_mark_dirty (??:?) 
> > > > Dec 30 07:00:36 s6 kernel: CPU: 0 PID: 521524 Comm: rsync Not tainted 6.6.8-stable-1 #13 d238f5ab6a206cdb0cc5cd72f8688230f23d58df
> > > > Dec 30 07:00:36 s6 kernel: block_dirty_folio (??:?) 
> > > > Dec 30 07:00:36 s6 kernel: unmap_page_range (??:?) 
> > > > Dec 30 07:00:36 s6 kernel: unmap_vmas (??:?) 
> > > > Dec 30 07:00:36 s6 kernel: exit_mmap (??:?) 
> > > > Dec 30 07:00:36 s6 kernel: __mmput (??:?) 
> > > > Dec 30 07:00:36 s6 kernel: do_exit (??:?) 
> > > > Dec 30 07:00:36 s6 kernel: do_group_exit (??:?) 
> > > > Dec 30 07:00:36 s6 kernel: __x64_sys_exit_group (??:?) 
> > > > Dec 30 07:00:36 s6 kernel: do_syscall_64 (??:?) 
> > > 
> > > See what comes out if race is handled.
> > > Only for thoughts.
> > 
> > I don't think this can happen.  Look at the call trace;
> > block_dirty_folio() is called from unmap_page_range().  That means the
> > page is in the page tables.  We unmap the pages in a folio from the
> > page tables before we set folio->mapping to NULL.  Look at
> > invalidate_inode_pages2_range() for example:
> > 
> >                                 unmap_mapping_pages(mapping, indices[i],
> >                                                 (1 + end - indices[i]), false);
> >                         folio_lock(folio);
> >                         folio_wait_writeback(folio);
> >                         if (folio_mapped(folio))
> >                                 unmap_mapping_folio(folio);
> >                         BUG_ON(folio_mapped(folio));
> >                                 if (!invalidate_complete_folio2(mapping, folio))
> > 
> What is missed here is the same check [1] in invalidate_inode_pages2_range(),
> so I built no wheel.
> 
> 			folio_lock(folio);
> 			if (unlikely(folio->mapping != mapping)) {
> 				folio_unlock(folio);
> 				continue;
> 			}
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/truncate.c#n658

That's entirely different.  That's checking in the truncate path whether
somebody else already truncated this page.  What I was showing was why
a page found through a page table walk cannot have been truncated (which
is actually quite interesting, because it's the page table lock that
prevents the race).

