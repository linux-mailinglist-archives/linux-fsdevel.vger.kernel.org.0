Return-Path: <linux-fsdevel+bounces-53140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 879A1AEAF81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 09:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1FB1BC0484
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 07:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838C11FFC59;
	Fri, 27 Jun 2025 07:02:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B14B23A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 07:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007775; cv=none; b=f8oeAGqMYgABRMBT/GKYaDKe5qczY7H0TuwnlY3rNAZ+ke4iJMmbgz2eSIcr9pBYQ056wNgI1c+vYd6TOnYUvarejdNE8JwKqqxsO36bkO60XLbYQIv1dxgqlpWFDrEx9KWSMntg1qoo9Wc8kPx/8SfA9536ZmIg+7uRogvcGgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007775; c=relaxed/simple;
	bh=IQJVW5i4VyLBMRYebQ9qx1uPcPe1ZAw3mRdT1Ae9ONk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuumrUQpgsoBjKiU9WmF0GyWFe6C/ZEp0F4N4vM5SSKA02NYrO9iRlEqNJknq1XLTwAzm7tLkkkAlqE/5Ijf3CTrEF3TYAuQ7hpJ/ohBILHVRfOxsY9rphK+vdFF6r0aH69MUfUsQ9sBq+5pBT07Qz1lUG6bNtekPyEMhH78WdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0199A68AFE; Fri, 27 Jun 2025 09:02:40 +0200 (CEST)
Date: Fri, 27 Jun 2025 09:02:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Price <anprice@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: refactor the iomap writeback code v2
Message-ID: <20250627070240.GA32487@lst.de>
References: <20250617105514.3393938-1-hch@lst.de> <07ef2fd5-d4cb-4fc3-8917-4bd6f06501d0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07ef2fd5-d4cb-4fc3-8917-4bd6f06501d0@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 26, 2025 at 03:59:54PM +0100, Andrew Price wrote:
>> This version passes basic testing on xfs, and gets as far as mainline
>> for gfs2 (crashes in generic/361).
>
> I can't get generic/361 to crash per se, but it does fail as it detects the new warning about the missing ->migrate_folio for the gfs2_{rgrp,meta}_aops, which I'm looking at now.
>
> If you have different results to this, please let me know more about the crash and your test environment.

This is qemu on two virtio_blk devices, 512 byte sector size and the
followin mkfs option:

export MKFS_OPTIONS="-O -p lock_nolock"


generic/361 2s ... [  627.703731] run fstests generic/361 at 2025-06-27 03:28:28
[  628.022201] gfs2: fsid=vdc: Trying to join cluster "lock_nolock", "vdc"
[  628.022666] gfs2: fsid=vdc: Now mounting FS (format 1802)...
[  628.026350] gfs2: fsid=vdc.0: journal 0 mapped with 1 extents in 0ms
[  628.026867] gfs2: fsid=vdc.0: jid=0, already locked for use
[  628.027124] gfs2: fsid=vdc.0: jid=0: Looking at journal...
[  628.032915] gfs2: fsid=vdc.0: jid=0: Journal head lookup took 5ms
[  628.033227] gfs2: fsid=vdc.0: jid=0: Done
[  628.033415] gfs2: fsid=vdc.0: first mount done, others may mount
[  628.042031] loop0: detected capacity change from 0 to 2097152
[  628.299636] gfs2: fsid=loop0: Trying to join cluster "lock_nolock", "loop0"
[  628.300022] gfs2: fsid=loop0: Now mounting FS (format 1802)...
[  628.303319] gfs2: fsid=loop0.0: journal 0 mapped with 1 extents in 0ms
[  628.304047] gfs2: fsid=loop0.0: jid=0, already locked for use
[  628.304344] gfs2: fsid=loop0.0: jid=0: Looking at journal...
[  628.306401] gfs2: fsid=loop0.0: jid=0: Journal head lookup took 2ms
[  628.306704] gfs2: fsid=loop0.0: jid=0: Done
[  628.306925] gfs2: fsid=loop0.0: first mount done, others may mount
[  629.093872] critical space allocation error, dev loop0, sector 913152 op 0x1:(WRITE) flags 0x4800
[  629.094701] loop0: writeback error on inode 16708, offset 398209024, sector 913152
[  629.094741] critical space allocation error, dev loop0, sector 917232 op 0x1:(WRITE) flags 0x4800
[  629.095447] critical space allocation error, dev loop0, sector 919792 op 0x1:(WRITE) flags 0x8000
[  629.095867] loop0: writeback error on inode 16708, offset 400293888, sector
917232
[  629.095906] critical space allocation error, dev loop0, sector 921312 op 0x1:(WRITE) flags 0x4800
[  629.096654] critical space allocation error, dev loop0, sector 923872 op 0x1:(WRITE) flags 0x8000
[  629.097079] loop0: writeback error on inode 16708, offset 402378752, sector 921312
[  629.097120] critical space allocation error, dev loop0, sector 925392 op 0x1:(WRITE) flags 0x4800
[  629.097996] critical space allocation error, dev loop0, sector 927952 op 0x1:(WRITE) flags 0x8000
[  629.098464] loop0: writeback error on inode 16708, offset 404463616, sector 925392
[  629.098506] critical space allocation error, dev loop0, sector 929472 op 0x1:(WRITE) flags 0x4800
[  629.099325] critical space allocation error, dev loop0, sector 932032 op 0x1:(WRITE) flags 0x8000
[  629.099794] loop0: writeback error on inode 16708, offset 406548480, sector 929472
[  629.099844] critical space allocation error, dev loop0, sector 933552 op 0x1:(WRITE) flags 0x4800
[  629.100634] loop0: writeback error on inode 16708, offset 408633344, sector
933552
[  629.100676] loop0: writeback error on inode 16708, offset 410718208, sector 937632
[  629.101016] loop0: writeback error on inode 16708, offset 412803072, sector 941712
[  629.101497] loop0: writeback error on inode 16708, offset 414887936, sector 945792
[  629.102236] loop0: writeback error on inode 16708, offset 416972800, sector 949872
[  629.106734] Buffer I/O error on dev loop0, logical block 16708, lost async page write
[  629.107413] Buffer I/O error on dev loop0, logical block 17192, lost async page write
[  629.107915] Buffer I/O error on dev loop0, logical block 17219, lost async page write
[  629.108248] Buffer I/O error on dev loop0, logical block 17729, lost async page write
[  629.109214] Buffer I/O error on dev loop0, logical block 18239, lost async page write
[  629.109552] Buffer I/O error on dev loop0, logical block 18749, lost async page write
[  629.109875] Buffer I/O error on dev loop0, logical block 19259, lost async page write
[  629.110196] Buffer I/O error on dev loop0, logical block 19769, lost async page write
[  629.110275] Buffer I/O error on dev loop0, logical block 81503, lost async page write
[  629.110524] Buffer I/O error on dev loop0, logical block 20279, lost async page write
[  629.111725] gfs2: fsid=loop0.0: fatal: I/O error - block = 16708, function = gfs2_ail1_empty_one8
[  629.112427] gfs2: fsid=loop0.0: about to withdraw this file system
[  634.215552] gfs2: fsid=loop0.0: Journal recovery skipped for jid 0 until next mount.
[  634.215906] gfs2: fsid=loop0.0: Glock dequeues delayed: 0
[  634.216172] gfs2: fsid=loop0.0: File system withdrawn
[  634.216397] CPU: 1 UID: 0 PID: 148587 Comm: mount Tainted: G N  6.16.0-rc3+ #375 
[  634.216399] Tainted: [N]=TEST
[  634.216400] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.3-debian-1.16.3-2 04
[  634.216401] Call Trace:
[  634.216402]  <TASK>
[  634.216402]  dump_stack_lvl+0x4b/0x70
[  634.216409]  gfs2_withdraw.cold+0x98/0x4aa
[  634.216411]  ? __pfx_autoremove_wake_function+0x10/0x10
[  634.216413]  revoke_lo_before_commit+0x14/0x160
[  634.216415]  gfs2_log_flush+0x444/0xbf0
[  634.216417]  gfs2_sync_fs+0x39/0x50
[  634.216419]  sync_filesystem+0x76/0x90
[  634.216421]  gfs2_reconfigure+0x30/0x360
[  634.216423]  reconfigure_super+0xc1/0x250
[  634.216425]  path_mount+0x95a/0xb40
[  634.216426]  __x64_sys_mount+0x100/0x130
[  634.216426]  do_syscall_64+0x50/0x1e0
[  634.216429]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  634.216430] RIP: 0033:0x7f96fc253e0a
[  634.216433] Code: 48 8b 0d f9 7f 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 8
[  634.216434] RSP: 002b:00007fffd5523288 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[  634.216436] RAX: ffffffffffffffda RBX: 000055b819d26aa0 RCX: 00007f96fc253e0a
[  634.216437] RDX: 000055b819d26cd0 RSI: 000055b819d288b0 RDI: 000055b819d27ca0
[  634.216437] RBP: 0000000000000000 R08: 000055b819d26cf0 R09: 000055b819d26d10
[  634.216438] R10: 0000000000200021 R11: 0000000000000246 R12: 000055b819d27ca0
[  634.216438] R13: 000055b819d26cd0 R14: 00007f96fc3bb264 R15: 000055b819d26bb8
[  634.216439]  </TASK>
[  634.259070] ------------[ cut here ]------------
[  634.259369] kernel BUG at fs/gfs2/super.c:76!
[  634.262243] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[  634.263386] CPU: 0 UID: 0 PID: 148595 Comm: umount Tainted: G N  6.16.0-rc3+ #37 
[  634.263832] Tainted: [N]=TEST
[  634.263956] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04
[  634.264332] RIP: 0010:gfs2_jindex_free+0x13e/0x170
[  634.264647] Code: 08 e8 56 42 98 ff 48 c7 43 48 00 00 00 00 48 89 df e8 c6 38 90 ff 48 8b 04 24 b
[  634.265562] RSP: 0018:ffffc90004ba3df8 EFLAGS: 00010286
[  634.265805] RAX: ffff88811a3f41c0 RBX: ffff88811a3f41c0 RCX: 0000000000000000
[  634.266141] RDX: 0000000000000001 RSI: ffff88810425c610 RDI: 00000000ffffffff
[  634.266454] RBP: ffffc90004ba3df8 R08: ffff8881364f7638 R09: ffff8881364f75e8
[  634.266732] R10: 0000000000000000 R11: ffff8881364f7508 R12: dead000000000122
[  634.267009] R13: dead000000000100 R14: ffff88810425c620 R15: 0000000000000000
[  634.267285] FS:  00007f3f53e6d840(0000) GS:ffff8882b35d7000(0000) knlGS:0000000000000000
[  634.267622] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  634.267856] CR2: 00005625aaa38cc0 CR3: 00000001047e6006 CR4: 0000000000772ef0
[  634.268128] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  634.268405] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[  634.268685] PKRU: 55555554
[  634.268805] Call Trace:
[  634.268913]  <TASK>
[  634.269002]  gfs2_put_super+0x165/0x230
[  634.269157]  generic_shutdown_super+0x79/0x180
[  634.269334]  kill_block_super+0x15/0x40
[  634.269578]  deactivate_locked_super+0x2b/0xb0
[  634.269788]  cleanup_mnt+0xb5/0x150
[  634.269954]  task_work_run+0x54/0x80
[  634.270123]  exit_to_user_mode_loop+0xbc/0xc0
[  634.270326]  do_syscall_64+0x1bc/0x1e0
[  634.270503]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  634.270731] RIP: 0033:0x7f3f54099b37
[  634.270899] Code: cf 92 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 8
[  634.271717] RSP: 002b:00007ffd63032398 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[  634.272052] RAX: 0000000000000000 RBX: 00005630901e2bb8 RCX: 00007f3f54099b37
[  634.272371] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005630901e6b60
[  634.272695] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000073
[  634.273017] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3f541d4264
[  634.273342] R13: 00005630901e6b60 R14: 00005630901e2cd0 R15: 00005630901e2aa0
[  634.273703]  </TASK>
[  634.273809] Modules linked in: kvm_intel kvm irqbypass [last unloaded: scsi_debug]
[  634.274259] ---[ end trace 0000000000000000 ]---
[  634.274460] RIP: 0010:gfs2_jindex_free+0x13e/0x170
[  634.274753] Code: 08 e8 56 42 98 ff 48 c7 43 48 00 00 00 00 48 89 df e8 c6 38 90 ff 48 8b 04 24 b
[  634.275604] RSP: 0018:ffffc90004ba3df8 EFLAGS: 00010286
[  634.275857] RAX: ffff88811a3f41c0 RBX: ffff88811a3f41c0 RCX: 0000000000000000
[  634.276230] RDX: 0000000000000001 RSI: ffff88810425c610 RDI: 00000000ffffffff
[  634.276549] RBP: ffffc90004ba3df8 R08: ffff8881364f7638 R09: ffff8881364f75e8
[  634.276896] R10: 0000000000000000 R11: ffff8881364f7508 R12: dead000000000122
[  634.277208] R13: dead000000000100 R14: ffff88810425c620 R15: 0000000000000000
[  634.277549] FS:  00007f3f53e6d840(0000) GS:ffff8882b35d7000(0000) knlGS:0000000000000000
[  634.277948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  634.278201] CR2: 00005625aaa38cc0 CR3: 00000001047e6006 CR4: 0000000000772ef0
[  634.278513] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  634.278819] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[  634.279127] PKRU: 55555554


