Return-Path: <linux-fsdevel+bounces-39680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D11A16F15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D1018871E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1BC1E8824;
	Mon, 20 Jan 2025 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpzWMuIu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FC41E5732;
	Mon, 20 Jan 2025 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737386105; cv=none; b=tw/gKZaZF8zSjaA0owqaoloYGueXJcX6XfRv0T8uiwJrKY5IH/7XC9tZieqT+e3LHuK0QW+2F1YmwNX0rY9gMtmrA+0SDvqLXc+n0dxbuYr/g5HoONH+YPQzKnYjA7fTCWtE0LSIgLwP8HCOO/bdy61LCTBAQwQnNf286jNw3MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737386105; c=relaxed/simple;
	bh=bHvXN/BHhv8QdRScLTJFNXOTF58/OH0CTg28AVP9tf4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=INgekGe3Asy24t+lwXnhL4c2YBZNDS7AY7PdUyVaTg3+rXNznI+Mj3ysOEqdteHMm/kmopqm7ptUPBXLJv+XGcus8+4CdyREFOe4U0iS5oPu6hYVEhQD4dzSQ+fsfJ+v8EB0svOEY5pfufZ9yi43iqDGm8oPdJoVIbl2NKXC/Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpzWMuIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D592C4CEE1;
	Mon, 20 Jan 2025 15:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737386105;
	bh=bHvXN/BHhv8QdRScLTJFNXOTF58/OH0CTg28AVP9tf4=;
	h=Date:From:To:Cc:Subject:From;
	b=XpzWMuIuSmWcKKA7EySaIqTVsgfJphCyd+JYlriuABWBLFo3xS9+uBusYR7Tx8i30
	 s4VImk5/uEvOs7tocy5QYDX0B+o3s9ByVv/ZN2SiiNA3LSv4avzD4BHLVkqXN5lU3j
	 qy9iJ5SBCMud0QF69nzEtx078Y2AG2ImyyD/iMu6ceOdpp0t0jtS0YqrHO/7PRv2lx
	 q73vJQaATTE5bbi/uEP1tqCoK9KEakTV3c+GesLJ5EtLtNL7dL66iPG+OafBcGfqLn
	 DPYqt5xlNaZC0c3o1oY6EX2AUIgHn1HkKC457edm66JOdNfuub1tHyxWj4sWJ+LSfQ
	 YrG8pJP+FAw1g==
Date: Mon, 20 Jan 2025 16:15:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>, djwong@kernel.org, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: xfs_repair after data corruption (not caused by xfs, but by failing
 nvme drive)
Message-ID: <20250120-hackbeil-matetee-905d32a04215@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hey,

so last week I got a nice surprise when my (relatively new) nvme drive
decided to tell me to gf myself. I managed to recover by now and get
pull requests out and am back in a working state.

I had to reboot and it turned out that my LUKS encrypted xfs filesystem
got corrupted. I booted a live image and did a ddrescue to an external
drive in the hopes of recovering the things that hadn't been backed up
and also I didn't want to have to go and setup my laptop again.

The xfs filesystem was mountable with:

mount -t xfs -o norecovery,ro /dev/mapper/dm4 /mnt

and I was able to copy out everything without a problem.

However, I was curious whether xfs_repair would get me anything and so I
tried it (with and without the -L option and with and without the -o
force_geometry option).

What was surprising to me is that xfs_repair failed at the first step
finding a usable superblock:

> sudo xfs_repair /dev/mapper/dm-sdd4
Phase 1 - find and verify superblock...
couldn't verify primary superblock - not enough secondary superblocks with matching geometry !!!

attempting to find secondary superblock...
..found candidate secondary superblock...
unable to verify superblock, continuing...
....found candidate secondary superblock...
unable to verify superblock, continuing...

I let it run across the whole drive and it did find a lot more
superblocks but for all of them it told me that it couldn't verify them.

I was surprised that I was able to recover all my data and had no issues
mounting the filesystems but xfs_repair failing to validate any
superblocks.

I honestly am just curious why xfs_repair fails to validate any
superblocks.

This is the splat I get when mounting without norecovery,ro:

[88222.149672] XFS (dm-4): Mounting V5 Filesystem 80526d30-90c7-4347-9d9e-333db3f5353b
[88222.632954] XFS (dm-4): Starting recovery (logdev: internal)
[88224.056721] XFS (dm-4): Metadata CRC error detected at xfs_agfl_read_verify+0xa5/0x120 [xfs], xfs_agfl block 0xeb6f603
[88224.057319] XFS (dm-4): Unmount and run xfs_repair
[88224.057328] XFS (dm-4): First 128 bytes of corrupted metadata buffer:
[88224.057338] 00000000: f1 80 cf 13 6c 73 aa 39 55 20 29 5c 2a ca ee 9a  ....ls.9U )\*...
[88224.057346] 00000010: 5a 0f 56 de ff da 93 5a 95 f2 01 ff 9f e7 6f 86  Z.V....Z......o.
[88224.057353] 00000020: dc 90 f4 ad 8b 7c 6d 47 87 1d b6 47 80 25 d0 d5  .....|mG...G.%..
[88224.057359] 00000030: da 36 1c f4 ee 22 e0 f4 b4 19 9a 74 bf d2 7d 49  .6...".....t..}I
[88224.057366] 00000040: 2e 1c 0d 62 a9 93 7b c0 53 b5 52 b7 eb 58 d3 52  ...b..{.S.R..X.R
[88224.057371] 00000050: fc 4b 13 cc 42 c7 36 88 1d 52 28 ef c7 20 cb 39  .K..B.6..R(.. .9
[88224.057377] 00000060: f7 db 9a 83 2c eb 23 52 b3 1a 85 bb d6 5e ff 4b  ....,.#R.....^.K
[88224.057383] 00000070: c3 3d 88 a6 dd bf ab 2a 94 1d 2d 19 6c b5 d1 e5  .=.....*..-.l...
[88224.057473] XFS (dm-4): metadata I/O error in "xfs_alloc_read_agfl+0x9b/0x100 [xfs]" at daddr 0xeb6f603 len 1 error 74
[88224.058055] XFS (dm-4): Metadata I/O Error (0x1) detected at xfs_trans_read_buf_map+0x159/0x300 [xfs] (fs/xfs/xfs_trans_buf.c:296).  Shutting down filesystem.
[88224.058638] XFS (dm-4): Please unmount the filesystem and rectify the problem(s)
[88224.058654] 00000000: 40 12 01 00 01 00 00 00 e0 da a2 29 81 88 ff ff  @..........)....
[88224.058662] XFS (dm-4): Internal error xfs_rmap_recover_work at line 544 of file fs/xfs/xfs_rmap_item.c.  Caller xfs_defer_finish_recovery+0x21/0x90 [xfs]
[88224.059283] CPU: 0 UID: 0 PID: 164438 Comm: mount Not tainted 6.12.9-amd64 #1  Debian 6.12.9-1
[88224.059298] Hardware name: LENOVO 20KHCTO1WW/20KHCTO1WW, BIOS N23ET88W (1.63 ) 02/28/2024
[88224.059305] Call Trace:
[88224.059314]  <TASK>
[88224.059325]  dump_stack_lvl+0x5d/0x80
[88224.059347]  xfs_corruption_error+0x92/0xa0 [xfs]
[88224.059942]  ? xfs_defer_finish_recovery+0x21/0x90 [xfs]
[88224.060615]  xfs_rmap_recover_work+0x38d/0x3b0 [xfs]
[88224.061148]  ? xfs_defer_finish_recovery+0x21/0x90 [xfs]
[88224.061704]  xfs_defer_finish_recovery+0x21/0x90 [xfs]
[88224.062240]  xlog_recover_process_intents+0x75/0x210 [xfs]
[88224.062768]  ? xfs_read_agf+0x95/0x150 [xfs]
[88224.063024]  ? lock_timer_base+0x76/0xa0
[88224.063030]  xlog_recover_finish+0x4a/0x310 [xfs]
[88224.063215]  xfs_log_mount_finish+0x115/0x170 [xfs]
[88224.063396]  xfs_mountfs+0x58d/0x990 [xfs]
[88224.063578]  xfs_fs_fill_super+0x5a3/0x9b0 [xfs]
[88224.063760]  ? __pfx_xfs_fs_fill_super+0x10/0x10 [xfs]
[88224.063936]  get_tree_bdev_flags+0x131/0x1d0
[88224.063942]  vfs_get_tree+0x26/0xd0
[88224.063946]  vfs_cmd_create+0x59/0xe0
[88224.063951]  __do_sys_fsconfig+0x4e3/0x6b0
[88224.063956]  do_syscall_64+0x82/0x190
[88224.063963]  ? generic_permission+0x39/0x220
[88224.063967]  ? mntput_no_expire+0x4a/0x260
[88224.063971]  ? do_faccessat+0x1e1/0x2e0
[88224.063975]  ? syscall_exit_to_user_mode+0x4d/0x210
[88224.063981]  ? do_syscall_64+0x8e/0x190
[88224.063986]  ? exc_page_fault+0x7e/0x180
[88224.063990]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[88224.063996] RIP: 0033:0x7f0e424557da
[88224.064027] Code: 73 01 c3 48 8b 0d 46 56 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 af 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 16 56 0d 00 f7 d8 64 89 01 48
[88224.064031] RSP: 002b:00007ffd930e3098 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
[88224.064036] RAX: ffffffffffffffda RBX: 0000564cee560a60 RCX: 00007f0e424557da
[88224.064039] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
[88224.064041] RBP: 0000564cee561b40 R08: 0000000000000000 R09: 00007f0e4252bb20
[88224.064044] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[88224.064046] R13: 00007f0e425dc5e0 R14: 00007f0e425de244 R15: 00007f0e425c57bf
[88224.064051]  </TASK>
[88224.064059] XFS (dm-4): Corruption detected. Unmount and run xfs_repair
[88224.064066] XFS (dm-4): Failed to recover intents
[88224.064069] XFS (dm-4): Ending recovery (logdev: internal)
[88224.064169] XFS (dm-4): log mount finish failed

With xfs_metadump I get:

> sudo xfs_metadump /dev/mapper/dm-sdd4 xfs_corrupt.metadump                                    

Superblock has bad magic number 0xa604f4c6. Not an XFS filesystem?
Metadata CRC error detected at 0x55d6d5e1c553, xfs_agfl block 0xeb6f603/0x200

I can generate a metadump image if that's helpful and there's interest
in looking into this. But as I said, I've recovered so I don't want to
waste your time.

Thanks!
Christian

