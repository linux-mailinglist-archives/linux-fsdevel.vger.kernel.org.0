Return-Path: <linux-fsdevel+bounces-42179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCFEA3E055
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 17:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82BAA3AD84C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 16:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEDF2135CB;
	Thu, 20 Feb 2025 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fSEQdgil"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7812135A5;
	Thu, 20 Feb 2025 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068158; cv=none; b=neEZ9dw6RYOnG7dA1fIhzckzN8HmPxH90PuMfGyF2QfcRgWcfA4fC2VUgyILe/PSxDfvQ4ezMo2VksDQN2DCt8VvBQegoXHNUpZ+YwAiwIuDSEYweYy/ODj3cE20YDehJYhDG1p26Ulr/j6qVF0CG0scJLFbDpfXFgg2Ezahb7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068158; c=relaxed/simple;
	bh=v5jU51XdS5IxHtGzZ0jSCWi4nb+5lghXAbNiqz17AXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXpidfhOqiK1jrhH7EljeAZnvP7Ift89wlE2XpFTXdYFp71TnlUrNcbErWmb/pw+sSQl+vb6xqy3i19txyxWdhKlv/omhmmjg3O2d+JJwdgtmLg0XS1Rfp8uxgsvoxjXsK7HJpxbAir5Vy/PjZpzDxwUp8ilG0FaFFQUEc+eAt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fSEQdgil; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/v0e059AYWdCApNiIRf7ofl3oeJFZjMI+2NzL/MN+sA=; b=fSEQdgil+eU5Ey5bdxle+6sEXy
	2jGSwL1/1bSyKEksuPVT+RKzowhvqnldQwuTQiIhBtSePe42QjCLkNb67YnEUEaLkAWHrv5Ym6+Vi
	uDZbZW2W6Q0OfG/HxGypfBxH75KYG+2Jgx3sBR14qG7evqfnJTktW+YVk/rHbzHdHT5qgrlP7nIFa
	xcx9xU12o+VB08HLU2uHS77KYBiMGbo81IQg6iJ5nRlUpp71aFufA9bo+IjJmmDavrDyoPs3s+Gv7
	U11z9Yqkp3aldNMLrewhuDPZFZ5V4HqubXHWuRkF3yvV9XMEWVg4Bm5PcAHu3naXNQMmd0m9P2aL0
	iZEmNnqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tl9DN-0000000A9dX-408l;
	Thu, 20 Feb 2025 16:15:53 +0000
Date: Thu, 20 Feb 2025 16:15:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: syzbot <syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev,
	dhowells@redhat.com, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] kernel BUG in folio_unlock (3)
Message-ID: <Z7dVOaTWTVCojNzr@casper.infradead.org>
References: <67b75198.050a0220.14d86d.02e2.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b75198.050a0220.14d86d.02e2.GAE@google.com>

On Thu, Feb 20, 2025 at 08:00:24AM -0800, syzbot wrote:
> ------------[ cut here ]------------
> kernel BUG at mm/filemap.c:1499!

Tried to unlock a folio that wasn't locked.

The entire log is interesting:

https://syzkaller.appspot.com/x/log.txt?x=12af2fdf980000

It injects a failure which hits p9_tag_alloc() (so adding the 9p people
to the cc)

The page dump is:

 page: refcount:1 mapcount:0 mapping:ffff888035b30890 index:0x0 pfn:0x37e9a
 memcg:ffff88801c6be000
 aops:v9fs_addr_operations ino:2721d72 dentry name(?):"file0"
 flags: 0xfff20000000020(lru|node=0|zone=1|lastcpupid=0x7ff)
 raw: 00fff20000000020 ffffea0000e1d1c8 ffff88801b0b31a0 ffff888035b30890
 raw: 0000000000000000 0000000000000000 00000001ffffffff ffff88801c6be000
 page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))

> Call Trace:
>  <TASK>
>  netfs_perform_write+0xc04/0x2140 fs/netfs/buffered_write.c:400
>  netfs_buffered_write_iter_locked fs/netfs/buffered_write.c:445 [inline]
>  netfs_file_write_iter+0x494/0x550 fs/netfs/buffered_write.c:484
>  v9fs_file_write_iter+0x9b/0x100 fs/9p/vfs_file.c:407
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0x5ae/0x1150 fs/read_write.c:679
>  ksys_write+0x12b/0x250 fs/read_write.c:731

