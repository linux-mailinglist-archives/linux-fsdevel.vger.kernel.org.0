Return-Path: <linux-fsdevel+bounces-68785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 204CEC66239
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 21:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 3509B291B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 20:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CAB2FB62A;
	Mon, 17 Nov 2025 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sruGxpUK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF26268C42
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763412404; cv=none; b=OW9bmlfomRzWJm3hd/GSyDlDaY+4G8GGCtx6s4D6LVSvlbf2RAJhR1nYZAiLQuZJ1K1fmmxGsnoVOepiS/H39p+Ej4bLNMELwYx6RO/gf/EN4e2jdVm4is+NwD08HjzRc31VQgqR5u16OU/ROPl7ibWzzoOBYphXxpqkN8YbYHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763412404; c=relaxed/simple;
	bh=IOFT1afgQxY7PNXndscjuXLUvFY3EknSJ6WAMRGo/DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mltzQ1y49ETZIocy0/UOWNP7BCwVoqkqZ2pYVLviwItG8meYM0jQYrTybU+Xp6etWmpCYJ+2AMH/qV7QcQtWkuM0g2e5QP7sZotMBgBxOhdhgZadFI7YQj+K1fGDI/zO2kOrOLNb9t/nKn05sPC1T41f0q8Fbx4S4++orFchX/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sruGxpUK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7aoKKwEvCEvV8XCxzFGnhwGdK81sm1EtauBn21f8K4A=; b=sruGxpUKOk+6q3bHr4AbZ+iaMn
	urSdRhVza4FjaA71Bs5rjfq0D9JPHOxuThWGD5XlzfmGxVbV7ATnP/k/dPNATnU9+N70OCxqb0Vbe
	YJ//Fz1MJnN4Z2CCBcyncSX11V8yWlJ/QyoOQKXAQEkkcqYl8S2vULWtSB7+t/LBPgaPh5pIbGSH6
	YUWLGVvhm1Rs30fm3iyCgqfM0B935aHMqwh0fR74FF3/Lew+ruM0DiAOBKAnoHwxMz29LSaJV6KOd
	RS8zt/tzogjZP10lgF1tYfA1vQYv1n+UgokTM2lGDK6UGJTbPxCnNQwYQF4rYMLdMHjQpbm4o5DAM
	Ig6QewWA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL67Q-0000000EPid-0mIG;
	Mon, 17 Nov 2025 20:46:36 +0000
Date: Mon, 17 Nov 2025 20:46:35 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, djwong@kernel.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 5/9] iomap: simplify ->read_folio_range() error
 handling for reads
Message-ID: <aRuJqxE3XRoLcWrz@casper.infradead.org>
References: <20251111193658.3495942-1-joannelkoong@gmail.com>
 <20251111193658.3495942-6-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111193658.3495942-6-joannelkoong@gmail.com>

On Tue, Nov 11, 2025 at 11:36:54AM -0800, Joanne Koong wrote:
> Instead of requiring that the caller calls iomap_finish_folio_read()
> even if the ->read_folio_range() callback returns an error, account for
> this internally in iomap instead, which makes the interface simpler and
> makes it match writeback's ->read_folio_range() error handling
> expectations.

Bisection of next-20251117 leads to this patch (commit
f8eaf79406fe9415db0e7a5c175b50cb01265199)

Here's the failure:

generic/008       run fstests generic/008 at 2025-11-17 20:40:31
page: refcount:5 mapcount:0 mapping:00000000101f858e index:0x4 pfn:0x12d4f8
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff8881120315c0
aops:xfs_address_space_operations ino:83 dentry name(?):"008.2222"
flags: 0x8000000000014069(locked|uptodate|lru|private|head|reclaim|zone=2)
raw: 8000000000014069 ffffea0004b69f48 ffffea0004a0a508 ffff8881139d83f0
raw: 0000000000000004 ffff8881070b4420 00000005ffffffff ffff8881120315c0
head: 8000000000014069 ffffea0004b69f48 ffffea0004a0a508 ffff8881139d83f0
head: 0000000000000004 ffff8881070b4420 00000005ffffffff ffff8881120315c0
head: 8000000000000202 ffffea0004b53e01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: VM_BUG_ON_FOLIO(success && folio_test_uptodate(folio))
------------[ cut here ]------------
kernel BUG at mm/filemap.c:1538!
Oops: invalid opcode: 0000 [#1] SMP NOPTI
CPU: 1 UID: 0 PID: 2607 Comm: xfs_io Not tainted 6.18.0-rc1-ktest-00033-gf8eaf79406fe #151 NONE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:folio_end_read+0x68/0x70
Code: 8e e9 04 00 0f 0b 48 8b 07 48 89 c2 48 c1 ea 03 a8 08 74 00 83 e2 01 b8 09 00 00 00 74 c2 48 c7 c6 a0 6e 3e 82 e8 68 e9 04 00 <0f> 0b 90 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffff888112333870 EFLAGS: 00010286
RAX: 000000000000004b RBX: ffffea0004b53e00 RCX: 0000000000000027
RDX: ffff888179657c08 RSI: 0000000000000001 RDI: ffff888179657c00
RBP: ffff888112333870 R08: 00000000fffbffff R09: ffff88817f1fdfa8
R10: 0000000000000003 R11: 0000000000000000 R12: ffff8881070b4420
R13: 0000000000000001 R14: ffff888112333b28 R15: ffffea0004b53e00
FS:  00007f7b1ad91880(0000) GS:ffff8881f6b0b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d7455da018 CR3: 00000001111ac000 CR4: 0000000000750eb0
PKRU: 55555554
Call Trace:
 <TASK>
 iomap_read_end+0xac/0x130
 iomap_readahead+0x1e1/0x330
 xfs_vm_readahead+0x3d/0x50
 read_pages+0x69/0x270
 page_cache_ra_order+0x2c2/0x4d0
 page_cache_async_ra+0x204/0x3c0
 filemap_readahead.isra.0+0x67/0x80
 filemap_get_pages+0x376/0x8a0
 ? find_held_lock+0x31/0x90
 ? try_charge_memcg+0x21a/0x750
 ? lock_acquire+0xb2/0x290
 ? __memcg_kmem_charge_page+0x160/0x3c0
 filemap_read+0x106/0x4c0
 ? __might_fault+0x35/0x80
 generic_file_read_iter+0xbc/0x110
 xfs_file_buffered_read+0xa9/0x110
 xfs_file_read_iter+0x82/0xf0
 vfs_read+0x277/0x360
 __x64_sys_pread64+0x7a/0xa0
 x64_sys_call+0x1b03/0x1da0
 do_syscall_64+0x6a/0x2e0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f7b1b0efd07
Code: 08 89 3c 24 48 89 4c 24 18 e8 55 76 fa ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 a5 76 fa ff 48 8b
RSP: 002b:00007ffc4a4b8080 EFLAGS: 00000293 ORIG_RAX: 0000000000000011
RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007f7b1b0efd07
RDX: 0000000000001000 RSI: 000055d7455d8000 RDI: 0000000000000003
RBP: 0000000000001000 R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000001000 R11: 0000000000000293 R12: 0000000000000001
R13: 0000000000020000 R14: 000000000001f000 R15: 0000000000001000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_end_read+0x68/0x70
Code: 8e e9 04 00 0f 0b 48 8b 07 48 89 c2 48 c1 ea 03 a8 08 74 00 83 e2 01 b8 09 00 00 00 74 c2 48 c7 c6 a0 6e 3e 82 e8 68 e9 04 00 <0f> 0b 90 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffff888112333870 EFLAGS: 00010286
RAX: 000000000000004b RBX: ffffea0004b53e00 RCX: 0000000000000027
RDX: ffff888179657c08 RSI: 0000000000000001 RDI: ffff888179657c00
RBP: ffff888112333870 R08: 00000000fffbffff R09: ffff88817f1fdfa8
R10: 0000000000000003 R11: 0000000000000000 R12: ffff8881070b4420
R13: 0000000000000001 R14: ffff888112333b28 R15: ffffea0004b53e00
FS:  00007f7b1ad91880(0000) GS:ffff8881f6b0b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d7455da018 CR3: 00000001111ac000 CR4: 0000000000750eb0
PKRU: 55555554
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Fatal exception ]---

You're calling folio_end_read(folio, true) for a folio which is already
marked uptodate!  I haven't looked through your patch to see what the
problem is yet.  Very reproducible, you only have to run generic/008
with a 1kB blocksize XFS.  And CONFIG_VM_DEBUG set, of course.

