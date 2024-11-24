Return-Path: <linux-fsdevel+bounces-35726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588D49D7869
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 22:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285E02822C0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 21:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4CE178378;
	Sun, 24 Nov 2024 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tm7XtDTo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386A22500BA;
	Sun, 24 Nov 2024 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732484901; cv=none; b=Yx7YtVoJSp0zAnb90jQBCYyS/aBXa6XF0pFn9FZ5hGKB1J2sBYioP0coNj5yNtnimZhF+W+6alTP8VvGqgjxTMKN98sDc7E7FOGpC4L/iReBYQTesColRvtDnOUU9pXppCC8vcgKQKoWl8N3IHrC4yV0B40Ho8NPtcOEpzjSYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732484901; c=relaxed/simple;
	bh=jNTAPP/MfNPEwet+Ok+/W1RZ2VIy1+gzv/XDoCfYEdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3N74drCANtgfUT66zxD1wXyNDnRQ8rvLvspU/PN03Vx1DadcwRghlnbgKVOSU7951oMPnGYzrnGhYB4b/V636hHiLBtqkOXS+2Oc1IWiCQtFuxAWaW3wlfoSO9Qme3hqLhrllJxc/aqFynwLWfeFtfGi1yQHzGNiIQiH93ex+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tm7XtDTo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FUIkB0nu6kVu8Kh8kg7nHVT5DQReYZ3ZBRdCsxIWzDQ=; b=tm7XtDTooTSDxUSCSm73zsVteU
	xNt1bxswAxTe1kUbhDqRSsyw4BqsSMOgY6R/MoZBbnu4Gk0Nw6Dx2v15m13pfQF6suCXsjqGZj2+n
	pOL4RQ0ohNtn7o/Te8+EjTMA/LFadHLAmmmHy6efDsu/5I2Aj4vNsqF1bi7B8SIwEbtX8Mn5mrYaq
	n/CHXbj9vStw0VwSLOziTJoqYZZ3k9+/fIP8pFE2pMhl1MH6OIZ3lUEXU96VjJVs8qvQqRHYuYOEj
	wlfhwGgt3OQJUb37navH3TrkKkKRiN3B4yvYpkO2SGRIhTutILInHoOrRo5MaTno6/1JU/9mvAPdV
	vQYqwPaw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFK85-0000000Awx1-2C4n;
	Sun, 24 Nov 2024 21:26:53 +0000
Date: Sun, 24 Nov 2024 21:26:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: syzbot <syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in __folio_start_writeback
Message-ID: <Z0OaHcMWcRtohZfz@casper.infradead.org>
References: <67432dee.050a0220.1cc393.0041.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67432dee.050a0220.1cc393.0041.GAE@google.com>

On Sun, Nov 24, 2024 at 05:45:18AM -0800, syzbot wrote:
> 
>  __fput+0x5ba/0xa50 fs/file_table.c:458
>  task_work_run+0x24f/0x310 kernel/task_work.c:239
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
>  do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

This is:

        VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);

ie we've called __folio_start_writeback() on a folio which is already
under writeback.

Higher up in the trace, we have the useful information:

 page: refcount:6 mapcount:0 mapping:ffff888077139710 index:0x3 pfn:0x72ae5
 memcg:ffff888140adc000
 aops:btrfs_aops ino:105 dentry name(?):"file2"
 flags: 0xfff000000040ab(locked|waiters|uptodate|lru|private|writeback|node=0|zone=1|lastcpupid=0x7ff)
 raw: 00fff000000040ab ffffea0001c8f408 ffffea0000939708 ffff888077139710
 raw: 0000000000000003 0000000000000001 00000006ffffffff ffff888140adc000
 page dumped because: VM_BUG_ON_FOLIO(folio_test_writeback(folio))
 page_owner tracks the page as allocated

The interesting part of the page_owner stacktrace is:

  filemap_alloc_folio_noprof+0xdf/0x500
  __filemap_get_folio+0x446/0xbd0
  prepare_one_folio+0xb6/0xa20
  btrfs_buffered_write+0x6bd/0x1150
  btrfs_direct_write+0x52d/0xa30
  btrfs_do_write_iter+0x2a0/0x760
  do_iter_readv_writev+0x600/0x880
  vfs_writev+0x376/0xba0

(ie not very interesting)

> Workqueue: btrfs-delalloc btrfs_work_helper
> RIP: 0010:__folio_start_writeback+0xc06/0x1050 mm/page-writeback.c:3119
> Call Trace:
>  <TASK>
>  process_one_folio fs/btrfs/extent_io.c:187 [inline]
>  __process_folios_contig+0x31c/0x540 fs/btrfs/extent_io.c:216
>  submit_one_async_extent fs/btrfs/inode.c:1229 [inline]
>  submit_compressed_extents+0xdb3/0x16e0 fs/btrfs/inode.c:1632
>  run_ordered_work fs/btrfs/async-thread.c:245 [inline]
>  btrfs_work_helper+0x56b/0xc50 fs/btrfs/async-thread.c:324
>  process_one_work kernel/workqueue.c:3229 [inline]

This looks like a race?

process_one_folio() calls
btrfs_folio_clamp_set_writeback calls
btrfs_subpage_set_writeback:

        spin_lock_irqsave(&subpage->lock, flags);
        bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits)
;
        if (!folio_test_writeback(folio))
                folio_start_writeback(folio);
        spin_unlock_irqrestore(&subpage->lock, flags);

so somebody else set writeback after we tested for writeback here.

One thing that comes to mind is that _usually_ we take folio_lock()
first, then start writeback, then call folio_unlock() and btrfs isn't
doing that here (afaict).  Maybe that's not the source of the bug?

If it is, should we have a VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio)
in __folio_start_writeback()?  Or is there somewhere that can't lock the
folio before starting writeback?

