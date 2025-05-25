Return-Path: <linux-fsdevel+bounces-49823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC7DAC3628
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 20:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAFD018935C1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 18:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8721F5619;
	Sun, 25 May 2025 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cHDABpVD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87841EFFA1
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748196397; cv=none; b=huRRDUfrE/wjbBoFSoj8cJ8qUagkOCYWpO6mCR0kE5tWHHZ9sxW5+IN+j2DEwgoFd7QAO2VZcViR4BOLuP9AQhJOJt9lRoWlk557fjl5pFbNdseSPu2gQHWzIokdt78DHXadJr9Du8k43T8utkTTIm1LZoEz/XZhHccKgmQmMqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748196397; c=relaxed/simple;
	bh=1L1zC3YodjFh2Hto7/+7iJG9cI3qkffdyoD2FlYbLPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwHByKt/tnIr07N9j5eiWMAyUV40Vo8SRZl37yf4GH2LyxQloZTrd/38sEIG2EoLhX4cWvRAaPHVDryrSZ3oXtJ55ssE+fih4+BOfAVhdE+k0eVXLC4uytnrltpgkEm6vqaUxu/Dxc7tpf8MTGDcOFfUQBzzJH0Z8CA3j4NCYmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cHDABpVD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KVfJgTUJV68+MTrQkDxOLnQB9EW/2gUQ4l1Or7+OWRs=; b=cHDABpVDTBQyK4oJpxHWnw/JcH
	n70KxjrEvA7IW+NTVo9z1evLYC5+oXg/5lu2jen1xax12qTAO2zrpc2FiQeAAQJ4m0GQMN+mwSVpA
	hfnZfuTAKcdUYSQWWIK/nS4nlps178ievkfoY3DvvavwKSDbHSwtqXjIcbSYrUfY1xAQ39BFdc8tk
	6S2skdHQv9uTI2G3J0tlhRiWSlSMGR4FwkGPKv57wkwHiNIp5X+J+pQpHEiNvz2nIsnkt+4e9v9xn
	1xM1EvT74OeJ55qNk1F8EL9gRj+mpl35XVS3N9t7ijl2+AmwIRlpBAgOmgizAdtoA3sMfcnM2KwNR
	9MSF7trg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJFk0-0000000GSER-0EP0;
	Sun, 25 May 2025 18:06:32 +0000
Date: Sun, 25 May 2025 19:06:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
Message-ID: <20250525180632.GU2023217@ZenIV>
References: <20250525083209.GS2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250525083209.GS2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, May 25, 2025 at 09:32:09AM +0100, Al Viro wrote:

> Breakage is still present in the current mainline ;-/

With CONFIG_DEBUG_VM on top of pagealloc debugging:

[ 1434.992817] run fstests generic/127 at 2025-05-25 11:46:11g
[ 1448.956242] BUG: Bad page state in process kworker/2:1  pfn:112cb0g
[ 1448.956846] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x3e pfn:0x112cb0g
[ 1448.957453] flags: 0x800000000000000e(referenced|uptodate|writeback|zone=2)g
[ 1448.957863] raw: 800000000000000e dead000000000100 dead000000000122 0000000000000000g
[ 1448.958303] raw: 000000000000003e 0000000000000000 00000000ffffffff 0000000000000000g
[ 1448.958833] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) setg
[ 1448.959320] Modules linked in: xfs autofs4 fuse nfsd auth_rpcgss nfs_acl nfs lockd grace sunrpc loop ecryptfs 9pnet_virtio 9pnet netfs evdev pcspkr sg button ext4 jbd2 btrfs blake2b_generic xor zlib_deflate raid6_pq zstd_compress sr_mod cdrom ata_generic ata_piix psmouse serio_raw i2c_piix4 i2c_smbus libata e1000g
[ 1448.960874] CPU: 2 UID: 0 PID: 2614 Comm: kworker/2:1 Not tainted 6.14.0-rc1+ #78g
[ 1448.960878] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014g
[ 1448.960879] Workqueue: xfs-conv/sdb1 xfs_end_io [xfs]g
[ 1448.960938] Call Trace:g
[ 1448.960939]  <TASK>g
[ 1448.960940]  dump_stack_lvl+0x4f/0x60g
[ 1448.960953]  bad_page+0x6f/0x100g
[ 1448.960957]  free_frozen_pages+0x471/0x640g
[ 1448.960958]  iomap_finish_ioend+0x196/0x3c0g
[ 1448.960963]  iomap_finish_ioends+0x83/0xc0g
[ 1448.960964]  xfs_end_ioend+0x64/0x140 [xfs]g
[ 1448.961003]  xfs_end_io+0x93/0xc0 [xfs]g
[ 1448.961036]  process_one_work+0x153/0x390g
[ 1448.961044]  worker_thread+0x2ab/0x3b0g
[ 1448.961045]  ? rescuer_thread+0x470/0x470g
[ 1448.961047]  kthread+0xf7/0x200g
[ 1448.961048]  ? kthread_use_mm+0xa0/0xa0g
[ 1448.961049]  ret_from_fork+0x2d/0x50g
[ 1448.961053]  ? kthread_use_mm+0xa0/0xa0g
[ 1448.961054]  ret_from_fork_asm+0x11/0x20g
[ 1448.961058]  </TASK>g
[ 1448.961155] Disabling lock debugging due to kernel taintg
[ 1448.969569] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x3e pfn:0x112cb0g
[ 1448.970023] flags: 0x800000000000000e(referenced|uptodate|writeback|zone=2)g
[ 1448.970651] raw: 800000000000000e dead000000000100 dead000000000122 0000000000000000g
[ 1448.971222] raw: 000000000000003e 0000000000000000 00000000ffffffff 0000000000000000g
[ 1448.971812] page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_count(folio) + 127u <= 127u))g
[ 1448.972490] ------------[ cut here ]------------g
[ 1448.972841] kernel BUG at ./include/linux/mm.h:1455!g
[ 1448.973421] Oops: invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOCg
[ 1448.973853] CPU: 2 UID: 0 PID: 2614 Comm: kworker/2:1 Tainted: G    B              6.14.0-rc1+ #78g
[ 1448.974345] Tainted: [B]=BAD_PAGEg
[ 1448.974565] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014g
[ 1448.975074] Workqueue: xfs-conv/sdb1 xfs_end_io [xfs]g
[ 1448.975428] RIP: 0010:folio_end_writeback+0x155/0x180g
[ 1448.975731] Code: 13 40 0f 92 c5 e9 23 ff ff ff 48 c7 c6 00 d5 e7 81 48 89 df e8 0c 8a 03 00 0f 0b 48 c7 c6 d0 38 e5 81 48 89 df e8 fb 89 03 00 <0f> 0b 48 c7 c6 40 5b e5 81 48 89 df e8 ea 89 03 00 0f 0b 48 c7 c6g
[ 1448.976655] RSP: 0018:ffffc90001a53d68 EFLAGS: 00010286g
[ 1448.976953] RAX: 000000000000005c RBX: ffffea00044b2c00 RCX: 0000000000000000g
[ 1448.977331] RDX: 0000000000000001 RSI: ffffffff81e74e9e RDI: 00000000ffffffffg
[ 1448.977711] RBP: ffffea00044b2c40 R08: 0000000000004ffb R09: 00000000ffffefffg
[ 1448.978089] R10: 00000000ffffefff R11: ffffffff82043bc0 R12: 0000000000001000g
[ 1448.978464] R13: ffff888101ecb840 R14: 0000000000000000 R15: ffffea00044b2c00g
[ 1448.978844] FS:  0000000000000000(0000) GS:ffff88842dd00000(0000) knlGS:0000000000000000g
[ 1448.979289] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033g
[ 1448.979609] CR2: 00007fd3d42a2000 CR3: 0000000111543000 CR4: 00000000000006f0g
[ 1448.979989] Call Trace:g
[ 1448.980170]  <TASK>g
[ 1448.980336]  ? die+0x32/0x80g
[ 1448.980543]  ? do_trap+0xd5/0x100g
[ 1448.980767]  ? folio_end_writeback+0x155/0x180g
[ 1448.981033]  ? do_error_trap+0x65/0x80g
[ 1448.981270]  ? folio_end_writeback+0x155/0x180g
[ 1448.981536]  ? exc_invalid_op+0x4c/0x60g
[ 1448.981790]  ? folio_end_writeback+0x155/0x180g
[ 1448.982056]  ? asm_exc_invalid_op+0x16/0x20g
[ 1448.982315]  ? folio_end_writeback+0x155/0x180g
[ 1448.982580]  ? folio_end_writeback+0x155/0x180g
[ 1448.982846]  iomap_finish_ioend+0x196/0x3c0g
[ 1448.983108]  iomap_finish_ioends+0x55/0xc0g
[ 1448.983363]  xfs_end_ioend+0x64/0x140 [xfs]g
[ 1448.983663]  xfs_end_io+0x93/0xc0 [xfs]g
[ 1448.983937]  process_one_work+0x153/0x390g
[ 1448.984189]  worker_thread+0x2ab/0x3b0g
[ 1448.984427]  ? rescuer_thread+0x470/0x470g
[ 1448.984674]  kthread+0xf7/0x200g
[ 1448.984887]  ? kthread_use_mm+0xa0/0xa0g
[ 1448.985128]  ret_from_fork+0x2d/0x50g
[ 1448.985362]  ? kthread_use_mm+0xa0/0xa0g
[ 1448.985601]  ret_from_fork_asm+0x11/0x20g
[ 1448.985846]  </TASK>g
[ 1448.986017] Modules linked in: xfs autofs4 fuse nfsd auth_rpcgss nfs_acl nfs lockd grace sunrpc loop ecryptfs 9pnet_virtio 9pnet netfs evdev pcspkr sg button ext4 jbd2 btrfs blake2b_generic xor zlib_deflate raid6_pq zstd_compress sr_mod cdrom ata_generic ata_piix psmouse serio_raw i2c_piix4 i2c_smbus libata e1000g
[ 1448.987399] ---[ end trace 0000000000000000 ]---g
[ 1448.987896] RIP: 0010:folio_end_writeback+0x155/0x180g
[ 1448.988220] Code: 13 40 0f 92 c5 e9 23 ff ff ff 48 c7 c6 00 d5 e7 81 48 89 df e8 0c 8a 03 00 0f 0b 48 c7 c6 d0 38 e5 81 48 89 df e8 fb 89 03 00 <0f> 0b 48 c7 c6 40 5b e5 81 48 89 df e8 ea 89 03 00 0f 0b 48 c7 c6g
[ 1448.989246] RSP: 0018:ffffc90001a53d68 EFLAGS: 00010286g
[ 1448.992210] RAX: 000000000000005c RBX: ffffea00044b2c00 RCX: 0000000000000000g
[ 1448.992619] RDX: 0000000000000001 RSI: ffffffff81e74e9e RDI: 00000000ffffffffg
[ 1448.993010] RBP: ffffea00044b2c40 R08: 0000000000004ffb R09: 00000000ffffefffg
[ 1448.993577] R10: 00000000ffffefff R11: ffffffff82043bc0 R12: 0000000000001000g
[ 1448.994411] R13: ffff888101ecb840 R14: 0000000000000000 R15: ffffea00044b2c00g
[ 1448.994823] FS:  0000000000000000(0000) GS:ffff88842dd00000(0000) knlGS:0000000000000000g
[ 1448.995390] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033g
[ 1448.995916] CR2: 00007fd3d42a2000 CR3: 0000000111543000 CR4: 00000000000006f0g
kvm: terminating on signal 15 from pid 32057 (killall)

