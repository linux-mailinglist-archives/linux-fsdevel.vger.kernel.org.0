Return-Path: <linux-fsdevel+bounces-69041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AEFC6CA35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 04:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 4922E2C7D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 03:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6192233721;
	Wed, 19 Nov 2025 03:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="en2g3tBT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9D922576E
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 03:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523634; cv=none; b=fmN2E4yMJosjCWx9hkwOa5C/nB75cMaZ5Rb+6iAIsYa7CTHSVUQ5TGSYxl/Zjjdpu9EeYPB3AjBPXU1UjRzkchTjOWshsb2HfLSRnwvZB5yG2FlP2DaRV+PoASPgX0JYgeXuofMbaMUyGIdP4739fyt83EC6xu8auooYVjq/zgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523634; c=relaxed/simple;
	bh=V1nQ9fA5VFpbyEJV1cxYh/K38qVdwAnGTKMzxVnYXPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxmPhVC3EJYLGrhg2Ot6/Od7KUMe0mqHe790rMGr1z3eTvfoIZiU5WoV0oDiEeomhgHGDhbpd4wwrFVlWYhImk0LSSf8Ef/8f2CiEQyOf5OuGjaby3cwEPBvR/RJImULqeghRfRPU1Lah8/sk76P8bntE7jhbg8VhjvUn/XhNzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=en2g3tBT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g1Iad/4fpCZfnFaCuUCjbRvQWDRD8kJVkxX56CoY11A=; b=en2g3tBTTD+FTRzc3dOuFAkbJ+
	jgpjw6Q3V/hQmpe4lYMTAyPE5HGwPJCPqCRSxXyyVSNg3McTZMkVeg93LRP8rGysF9blRIiObViJw
	mm7/hY2OLU5WOLViD08+QAKMqRbFoWZWPXtsDYrh+EA4UdkqD84LuHlxbgtL/zZs7ngSoCumSHxcE
	/FbNYbt4ozJuAdjHOGvU3d2HrMHXlRTl8NXApcYRY9JhP3T/wHeXPUvUwXrC+7kYrFz+jV73a7D3R
	QLvld2kcjyCzzv/S6Q5dDgJrSroXbx8lh+NjVHWMQX78UN0i11itRjspJo0kMI1jmDZC9xFmaEuEz
	Ykh1fqOw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLZ3M-0000000GTSL-3hiX;
	Wed, 19 Nov 2025 03:40:20 +0000
Date: Wed, 19 Nov 2025 03:40:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, djwong@kernel.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 7/9] iomap: use loff_t for file positions and offsets
 in writeback code
Message-ID: <aR08JNZt4e8DNFwb@casper.infradead.org>
References: <20251111193658.3495942-1-joannelkoong@gmail.com>
 <20251111193658.3495942-8-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111193658.3495942-8-joannelkoong@gmail.com>

On Tue, Nov 11, 2025 at 11:36:56AM -0800, Joanne Koong wrote:
> Use loff_t instead of u64 for file positions and offsets to be
> consistent with kernel VFS conventions. Both are 64-bit types. loff_t is
> signed for historical reasons but this has no practical effect.

generic/303       run fstests generic/303 at 2025-11-19 03:27:51
XFS: Assertion failed: imap.br_startblock != DELAYSTARTBLOCK, file: fs/xfs/xfs_reflink.c, line: 1569
------------[ cut here ]------------
kernel BUG at fs/xfs/xfs_message.c:102!
Oops: invalid opcode: 0000 [#1] SMP NOPTI
CPU: 8 UID: 0 PID: 2422 Comm: cp Not tainted 6.18.0-rc1-ktest-00035-gb94488503277 #169 NONE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:assfail+0x3c/0x46
Code: c2 e0 cc 40 82 48 89 f1 48 89 fe 48 c7 c7 e3 60 45 82 48 89 e5 e8 e4 fd ff ff 8a 05 16 98 55 01 3c 01 76 02 0f 0b a8 01 74 02 <0f> 0b 0f 0b 5d c3 cc cc cc cc 48 8d 45 10 4c 8d 6c 24 10 48 89 e2
RSP: 0018:ffff888111433cf8 EFLAGS: 00010202
RAX: 00000000ffffff01 RBX: 0007ffffffffffff RCX: 000000007fffffff
RDX: 0000000000000021 RSI: 0000000000000000 RDI: ffffffff824560e3
RBP: ffff888111433cf8 R08: 0000000000000000 R09: 000000000000000a
R10: 000000000000000a R11: 0fffffffffffffff R12: 0000000000000001
R13: 00000000ffffff8b R14: ffff888105280000 R15: 0007ffffffffffff
FS:  00007fc4cd191580(0000) GS:ffff8881f6ccb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005612bbfade30 CR3: 000000011146c000 CR4: 0000000000750eb0
PKRU: 55555554
Call Trace:
 <TASK>
 xfs_reflink_remap_blocks+0x259/0x450
 xfs_file_remap_range+0xe9/0x3d0
 vfs_clone_file_range+0xde/0x460
 ioctl_file_clone+0x50/0xc0
 __x64_sys_ioctl+0x619/0x9d0
 ? do_sys_openat2+0x99/0xd0
 x64_sys_call+0xed0/0x1da0
 do_syscall_64+0x6a/0x2e0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fc4cd34d37b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffeb4734050 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fc4cd34d37b
RDX: 0000000000000003 RSI: 0000000040049409 RDI: 0000000000000004
RBP: 00007ffeb4734490 R08: 00007ffeb4734660 R09: 0000000000000002
R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000008000 R15: 0000000000000002
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:assfail+0x3c/0x46
Code: c2 e0 cc 40 82 48 89 f1 48 89 fe 48 c7 c7 e3 60 45 82 48 89 e5 e8 e4 fd ff ff 8a 05 16 98 55 01 3c 01 76 02 0f 0b a8 01 74 02 <0f> 0b 0f 0b 5d c3 cc cc cc cc 48 8d 45 10 4c 8d 6c 24 10 48 89 e2
RSP: 0018:ffff888111433cf8 EFLAGS: 00010202
RAX: 00000000ffffff01 RBX: 0007ffffffffffff RCX: 000000007fffffff
RDX: 0000000000000021 RSI: 0000000000000000 RDI: ffffffff824560e3
RBP: ffff888111433cf8 R08: 0000000000000000 R09: 000000000000000a
R10: 000000000000000a R11: 0fffffffffffffff R12: 0000000000000001
R13: 00000000ffffff8b R14: ffff888105280000 R15: 0007ffffffffffff
FS:  00007fc4cd191580(0000) GS:ffff8881f6ccb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005612bbfade30 CR3: 000000011146c000 CR4: 0000000000750eb0
PKRU: 55555554
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Fatal exception ]---


