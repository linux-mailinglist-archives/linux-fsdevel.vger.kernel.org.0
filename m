Return-Path: <linux-fsdevel+bounces-42916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B014CA4B74A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 05:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8AE3A5218
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 04:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5771D86DC;
	Mon,  3 Mar 2025 04:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wSWLuwDL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC12F4AEE2
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 04:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740977542; cv=none; b=cykajwSFmUX/tAk98lIAt0N54dPWBl9sR4z+czC1IGghjpFMC1F2ZgAK7TaMSs/v3IqAnAtCdqSHS1fWnwuJ3s/l6pUmWOpUH3zq7vfyh3jrPpjBmbUAkvAlqysk2RFCtPcSzVOAGHYKp9lCAzrKLlnvpaEAFUXhg66+W0URrrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740977542; c=relaxed/simple;
	bh=S3PkOiHguL3A47fRrYLoHlJ5RRhdtvRrRT/slT/VDHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwZT72lHk/hXtQO/v32J4/OQWO8Grl6zeHQZn5ffDlTWdmwyaw//qANWMOJ3Yez5ic2tYSy5lUaFAB3FFMYL1ADmdg2m6t2zrnV6RM28X2Y7bTEuY82Xvybh1tBJ9SBVUbF3BoJeCxweduV+TnRveYNqf7KRXmDwb/lB66nAff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wSWLuwDL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gQw5ITGZgmCnNe/hk5hAVGzpx+dtW1jxF5kvbKk1odc=; b=wSWLuwDLOx/IJZoMUiZ0yLVGD2
	SXj8j0XbeQNESMdMfbNuJ/QVGxN4Nv7yHkdEn7N+3JpX/8ziNQncpR0Ynhc9ODh2iuuCPpC3kv61t
	8rjAQdpbQbAWzTCoxuOwLB1/FUVQD5AGsxQsggfavZPHcTE5edeBdsE6rYCysG0CDwwi72ymLzyfH
	dzQuCzdW+sHYBawGMWiblgM+wgqcSyNDHs3069Cip0lO0QYSQUK+Ik36Kus3jjXRGyn0SuEkN/V6K
	oT2FaHsFenmKx8eADvCWxRiDakYpt37qIq4cAHLLtK2eargfP9WChI4J143zjK5At4HwKEibYNLvq
	yRBRqg6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1toxmp-0000000Aadi-29RH;
	Mon, 03 Mar 2025 04:52:15 +0000
Date: Mon, 3 Mar 2025 04:52:15 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Subject: Re: Calling folio_end_writeback() inside a spinlock under task
 context?
Message-ID: <Z8U1f4g5av7L1Tv-@casper.infradead.org>
References: <14bd34c8-8fe0-4440-8dfd-e71223303edc@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14bd34c8-8fe0-4440-8dfd-e71223303edc@gmx.com>

Adding Jens to the cc.  As you well know, he added this code, so I'm
mystified why you didn't cc him.  Also adding linux-fsdevel (I presume
this was a mistake and you inadvertently cc'd f2fs-devel instead.)

On Mon, Mar 03, 2025 at 10:34:26AM +1030, Qu Wenruo wrote:
> [SPINLOCK AND END WRITEBACK]
> 
> Although folio_end_writeback() can be called in an interruption context
> (by the in_task() check), surprisingly it may not be suitable to be
> called inside a spinlock (in task context):

It's poor practice to do that; you're introducing a dependency between
your fs lock and the i_mapping lock, which is already pretty intertwined
with ... every other lock in the system.

> For example the following call chain can lead to sleep:
> 
> spin_lock()
> folio_end_writeback()
> |- folio_end_dropbehind_write()
>    |- folio_launder()
>       Which can sleep.
> 
> My question is, can and should we allow folio_end_writeback() inside a
> spinlock?
> 
> [BTRFS' ASYNC EXTENT PROBLEM]
> 
> This is again a btrfs specific behavior, that we have to call
> folio_end_writeback() inside a spinlock to make sure really only one
> thread can clear the writeback flag of a folio.
> 
> I know iomap is doing a pretty good job preventing early finished
> writeback to clear the folio writeback flag, meanwhile we're still
> submitting other blocks inside the folio.
> 
> Iomap goes holding one extra writeback count before starting marking
> blocks writeback and submitting them.
> And after all blocks are submitted, reduce the writeback count (and call
> folio_end_writeback() if it's the last one holding the writeback flag).
> 
> But the iomap solution requires that, all blocks inside a folio to be
> submitted at the same time.

I aactually don't like the iomap solution as it's currently written; it
just hasn't risen high enough up my todo list to fix it.

What we should do is initialise folio->ifs->write_bytes_pending to
bitmap_weight(ifs->state, blocks_per_folio) * block_size in
iomap_writepage_map() [this is oversimplified; we'd need to handle eof
and so on too]

That would address your problem as well as do fewer atomic operations.

> This is not true in btrfs, due to the design of btrfs' async extent,
> which can mark the blocks for writeback really at any timing, as we keep
> the lock of folios and queue them into a workqueue to do compression,
> then only after the compression is done, we submit and mark them
> writeback and unlock.
> 
> If we do not hold a spinlock calling folio_end_writeback(), but only
> checks if we're the last holder and call folio_end_writeback() out of
> the spinlock, we can hit the following race where folio_end_writeback()
> can be called on the same folio:
> 
>      0          32K         64K
>      |<- AE 1 ->|<- AE 2 ->|
> 
>             Thread A (AE 1)           |            Thread B (AE 2)
> --------------------------------------+------------------------------
> submit_one_async_extent()             |
> |- process_one_folio()                |
>      |- subpage_set_writeback()       |
>                                       |
> /* IO finished */                     |
> end_compressed_writeback()            |
> |- btrfs_folio_clear_writeback()      |
>      |- spin_lock()                   |
>      |  /* this is the last writeback |
>      |     holder, should end the     |
>      |     folio writeback flag */    |
>      |- last = true                   |
>      |- spin_unlock()                 |
>      |                                | submit_one_async_extent()
>      |                                | |- process_one_folio()
>      |                                |    |- subpage_set_writeback()

This seems weird.  Why are you setting the "subpage" writeback bit
while the folio writeback bit is still set?  That smells like a
bug-in-waiting if not an actual bug to me.  Surely it should wait on
the folio writeback bit to clear?

>      |                                | /* IO finished */
>      |                                | end_compressed_writeback()
>      |                                | |btrfs_folio_clear_writeback()
>      |                                |    | /* Again the last holder */
>      |                                |    |- spin_lock()
>      |                                |    |- last = true
>      |                                |    |- spin_unlock()
>      |- folio_end_writeback()         |    |- folio_end_writeback()
> 
> I know the most proper solution would to get rid of the delayed unlock
> and submission, but mark blocks for writeback without the async extent
> mechanism completely, then follow the iomap's solution.
> 
> But that will be a huge change (although we will go that path
> eventually), meanwhile the folio_end_writeback() inside spinlock needs
> to be fixed asap.

I'd suggest the asap solution is for btrfs to mark itself as not
supporting dropbehind.

> So my question is, can we allow folio_end_writeback() to be called
> inside a spinlock, at the cost of screwing up the folio reclaim for
> DONTCACHE?
> 
> Thanks,
> Qu
> 

