Return-Path: <linux-fsdevel+bounces-43639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DB8A599FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 16:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D887A4708
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 15:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DFC22171C;
	Mon, 10 Mar 2025 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PVcNxY1g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D541A7264;
	Mon, 10 Mar 2025 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620529; cv=none; b=KZ7qosVhelu2gZDlmupK5EofDfMWBJjQDs+O+KT6z1FJci/ZmcBdsinA0BVO/Ry4qJMlH+8RylqUGysZIdvI+Zo876BRFrsArwgwXl8tzue7aRljf4QfpXg5yRuegsrPRGbeNwmeGXAkmyDQ5Nam2pGh6KolSYFgqrJrGzsE/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620529; c=relaxed/simple;
	bh=mcn+vY+S1woGC0GGbfsPy3tYqvbju7ryrvfDi1hup5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIMrn91fHPHUOiDxarpKytOZYoflUCIHC/o1UJkGm/bfnn9UypLy45ALYRdnakGTeInZFDg/Fz+2E4MDCv3gO357//+bOK46xsMQdx+E3BHPm2kn+6nqSQCWDkAlGPYznvAnxY96Tn1BTToUbZy6u5baWomlq7bKvVjGYlIPBEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PVcNxY1g; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LFuFlzgoC5ukemUl0eQEeCKPuI6gKDdM8KBiSpcB9xc=; b=PVcNxY1guezp38LWF2ftYx46zh
	181jogpyXvCV9SSUrAPj/osD+voUmWRbp2zm6AeYiiKay6FgNfYmpKuauHVDCW6WjekFqReRquzm1
	PXmVsr717nWi+/mnwiKZlEEPvk+giC4gwbO5IndT89MR4H+AWHNuPMPsRHv2FBgJVbdC/PtBSG73X
	7xqfhrIZatuk/WFJMuQdok3HpPuEZXYDrP49NSsYbf1ppb1dyUFuARUdFjhn7Oco4mnpUUP6r1hqj
	qBzNNIt63C/zJ87dDmJM2ZeS2r2KnA10Hk6S8R2OWN77XmpBJY0Zq3k7VK2oHyb6A+Xek0GpayjpP
	ycbYH5mQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1trf3Z-00000006Dsj-3Xn1;
	Mon, 10 Mar 2025 15:28:45 +0000
Date: Mon, 10 Mar 2025 15:28:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: syzbot <syzbot+f2aaf773187f5cae54f3@syzkaller.appspotmail.com>
Cc: linux-block@vger.kernel.org, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] [fs?] KCSAN: data-race in __filemap_add_folio /
 invalidate_bdev (8)
Message-ID: <Z88FKeXyaQCeXapp@casper.infradead.org>
References: <67ceb38a.050a0220.e1a89.04b1.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ceb38a.050a0220.e1a89.04b1.GAE@google.com>

On Mon, Mar 10, 2025 at 02:40:26AM -0700, syzbot wrote:
> Reported-by: syzbot+f2aaf773187f5cae54f3@syzkaller.appspotmail.com
> 
> EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
> ==================================================================
> BUG: KCSAN: data-race in __filemap_add_folio / invalidate_bdev
> 
> read-write to 0xffff888100630570 of 8 bytes by task 3291 on cpu 0:
>  __filemap_add_folio+0x430/0x6f0 mm/filemap.c:929

This is a write to mapping->nrpages with the i_pages lock held, as it
should be.

>  filemap_add_folio+0x9c/0x1b0 mm/filemap.c:981
>  page_cache_ra_unbounded+0x1c1/0x350 mm/readahead.c:276
>  do_page_cache_ra mm/readahead.c:328 [inline]
>  force_page_cache_ra mm/readahead.c:357 [inline]
>  page_cache_sync_ra+0x252/0x680 mm/readahead.c:585
>  filemap_get_pages+0x2ca/0x11a0 mm/filemap.c:2580
>  filemap_read+0x230/0x8c0 mm/filemap.c:2691
>  blkdev_read_iter+0x228/0x2d0 block/fops.c:796
>  new_sync_read fs/read_write.c:484 [inline]
>  vfs_read+0x5cc/0x6f0 fs/read_write.c:565
>  ksys_read+0xe8/0x1b0 fs/read_write.c:708
> 
> read to 0xffff888100630570 of 8 bytes by task 3306 on cpu 1:
>  invalidate_bdev+0x25/0x70 block/bdev.c:99

This is a read of mapping->nrpages with no lock held.  So we could
silence this warning by making this a READ_ONCE or data_race().

The problem is that I'm not sure this is the right answer.  Obviously
here we only care about zero-vs-non-zero, but what if we race with
0 being incremented to 1?  Should there be some locking higher up
that prevents this?  Or is this "yes, root can do this and screw
themselves"?

>  ext4_put_super+0x571/0x810 fs/ext4/super.c:1356
>  generic_shutdown_super+0xe5/0x220 fs/super.c:642
>  kill_block_super+0x2a/0x70 fs/super.c:1710
>  ext4_kill_sb+0x44/0x80 fs/ext4/super.c:7368
>  deactivate_locked_super+0x7d/0x1c0 fs/super.c:473
>  deactivate_super+0x9f/0xb0 fs/super.c:506
>  cleanup_mnt+0x268/0x2e0 fs/namespace.c:1413
>  __cleanup_mnt+0x19/0x20 fs/namespace.c:1420
>  task_work_run+0x13a/0x1a0 kernel/task_work.c:227

