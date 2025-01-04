Return-Path: <linux-fsdevel+bounces-38389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D22A01416
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 12:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1674163D2B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 11:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FFE19AD89;
	Sat,  4 Jan 2025 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uN8xkk0n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFEBA932;
	Sat,  4 Jan 2025 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735990000; cv=none; b=p7vqf1mWFez3JutIiMnhyHPY2HGAAG5vZi61yXX1RlFaHJCEArj9h0zdgowOalnbeE+Ga/o30f257cPqPPEco7PTgV8HUBnGOJurvMkgN7Bg0kyBu+3KdNSbgQP4Q1czADJFLE8AHdhdqXzyQXsJxMSPQXsDBS5BDFuY0jMH/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735990000; c=relaxed/simple;
	bh=h2Amqj8Ampfziz2fjjEcSKqRyE7SKrsGvl+ubzxRBSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqxaOuSWdWipdy6EoXXH4McKIPMQUtpLrpkbf3pYIOu8oFqyEr623zjTtb9oLJBxwRIq3nJpwfgINO+VukXvw22Xvsjcr3huTL+NQGT63UaFx9Iicb8ky4BXbO0olp4MPo3e3V9ZFf3e0/rux1y7zvrlYrY5sltC0yFciOkLk9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uN8xkk0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32574C4CED1;
	Sat,  4 Jan 2025 11:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735989999;
	bh=h2Amqj8Ampfziz2fjjEcSKqRyE7SKrsGvl+ubzxRBSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uN8xkk0nC6hkuOv1Z1zCkjbla1voIeLLqlKJFW5prCpS77WDet4ldRbBewbemslHn
	 Du+zIiBGI/G1bAtAmgwf3MGurUeZ6R+8HT1lzC93ohSOSJQNIaf1pqUmZSQmKZKekk
	 BTHOGg9aZ5OlmSCusHbL1SdqxswHgeoJLO99UwiOaJjn4rIc89HRnQXyuEdxGmFsFM
	 y/5rH6MfqShP+gXBTmD+bDUFFJFmd0o9qnJsI5tBfKU8VmLJ0iR3g3hY67lyZsRUkX
	 kHLn0PEIi6SmMYKt45vF11Kictu2QEPrOS2UHdgFoDTk9CTgvlDphxuEnEemX2lfC4
	 yAEG589m/0yKQ==
Date: Sat, 4 Jan 2025 12:26:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-fsdevel@vger.kernel.org, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: mnt_list corruption triggered during btrfs/326
Message-ID: <20250104-gockel-zeitdokument-59fe0ff5b509@brauner>
References: <ec6784ed-8722-4695-980a-4400d4e7bd1a@gmx.com>
 <324cf712-7a7e-455b-b203-e221cb1ed542@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <324cf712-7a7e-455b-b203-e221cb1ed542@gmx.com>

On Wed, Jan 01, 2025 at 07:05:10AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/12/30 19:59, Qu Wenruo 写道:
> > Hi,
> > 
> > Although I know it's triggered from btrfs, but the mnt_list handling is
> > out of btrfs' control, so I'm here asking for some help.

Thanks for the report.

> > 
> > [BUG]
> > With CONFIG_DEBUG_LIST and CONFIG_BUG_ON_DATA_CORRUPTION, and an
> > upstream 6.13-rc kernel, which has commit 951a3f59d268 ("btrfs: fix
> > mount failure due to remount races"), I can hit the following crash,
> > with varied frequency (from 1/4 to hundreds runs no crash):
> 
> There is also another WARNING triggered, without btrfs callback involved
> at all:
> 
> [  192.688671] ------------[ cut here ]------------
> [  192.690016] WARNING: CPU: 3 PID: 59747 at fs/mount.h:150

This would indicate that move_from_ns() was called on a mount that isn't
attached to a mount namespace (anymore or never has).

Here's it's particularly peculiar because it looks like the warning is
caused by calling move_from_ns() when moving a mount from an anonymous
mount namespace in attach_recursive_mnt().

Can you please try and reproduce this with
commit 211364bef4301838b2e1 ("fs: kill MNT_ONRB")
from the vfs-6.14.mount branch in
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git ?

> attach_recursive_mnt+0xc58/0x1260
> [  192.692051] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6
> nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> nf_tables binfmt_misc btrfs xor raid6_pq zstd_compress iTCO_wdt
> intel_pmc_bxt iTCO_vendor_support i2c_i801 i2c_smbus virtio_net
> net_failover virtio_balloon lpc_ich failover joydev loop dm_multipath
> nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock zram
> crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
> polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3
> virtio_blk virtio_console bochs serio_raw scsi_dh_rdac scsi_dh_emc
> scsi_dh_alua fuse qemu_fw_cfg
> [  192.707547] CPU: 3 UID: 0 PID: 59747 Comm: mount Kdump: loaded Not
> tainted 6.13.0-rc4-custom+ #9
> [  192.709485] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> Arch Linux 1.16.3-1-1 04/01/2014
> [  192.711601] RIP: 0010:attach_recursive_mnt+0xc58/0x1260
> [  192.712725] Code: 85 c0 0f 85 79 ff ff ff 48 c7 c7 04 e7 00 8e 83 05
> 9c 18 28 03 01 e8 97 1d c8 01 31 f6 48 89 ef e8 dd c1 fe ff e9 9c f5 ff
> ff <0f> 0b e9 48 f8 ff ff 48 8b 44 24 10 48 8d 78 20 48 b8 00 00 00 00
> [  192.716521] RSP: 0018:ffff888105cafb68 EFLAGS: 00010246
> [  192.717621] RAX: 0000000000001020 RBX: ffff88811cc24030 RCX:
> ffffffff8ca0e8e5
> [  192.719078] RDX: ffff888105cafbf0 RSI: ffff888118db0800 RDI:
> ffff88811cc240f0
> [  192.720313] RBP: ffff88811cc24000 R08: ffff88810f21a840 R09:
> ffffed1020b95f62
> [  192.721028] R10: 0000000000000003 R11: ffff88810a56e558 R12:
> ffff88811cc24000
> [  192.721718] R13: dffffc0000000000 R14: ffff88810f21a840 R15:
> ffff888105cafbf0
> [  192.722426] FS:  00007fdf69887800(0000) GS:ffff888236f80000(0000)
> knlGS:0000000000000000
> [  192.723229] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  192.723849] CR2: 00007fdf697a9000 CR3: 000000010d925000 CR4:
> 0000000000750ef0
> [  192.724549] PKRU: 55555554
> [  192.724860] Call Trace:
> [  192.725101]  <TASK>
> [  192.725311]  ? __warn.cold+0xb6/0x176
> [  192.725672]  ? attach_recursive_mnt+0xc58/0x1260
> [  192.726149]  ? report_bug+0x1f0/0x2a0
> [  192.726520]  ? handle_bug+0x54/0x90
> [  192.726895]  ? exc_invalid_op+0x17/0x40
> [  192.727259]  ? asm_exc_invalid_op+0x1a/0x20
> [  192.727664]  ? _raw_spin_lock+0x85/0xe0
> [  192.728053]  ? attach_recursive_mnt+0xc58/0x1260
> [  192.728501]  ? attach_recursive_mnt+0xb82/0x1260
> [  192.728954]  ? _raw_spin_unlock+0xe/0x20
> [  192.729330]  ? count_mounts+0x1e0/0x1e0
> [  192.729703]  ? _raw_spin_lock+0x85/0xe0
> [  192.730082]  ? _raw_write_lock_bh+0xe0/0xe0
> [  192.730493]  do_move_mount+0x7a8/0x1a20
> [  192.730871]  __do_sys_move_mount+0x7e2/0xcf0
> [  192.731288]  ? syscall_exit_to_user_mode+0x10/0x200
> [  192.731762]  ? do_syscall_64+0x8e/0x160
> [  192.732180]  ? do_move_mount+0x1a20/0x1a20
> [  192.732587]  do_syscall_64+0x82/0x160
> [  192.732950]  ? syscall_exit_to_user_mode_prepare+0x15a/0x190
> [  192.733500]  ? syscall_exit_to_user_mode+0x10/0x200
> [  192.733977]  ? do_syscall_64+0x8e/0x160
> [  192.734374]  ? from_kuid_munged+0x86/0x100
> [  192.734765]  ? from_kuid+0xc0/0xc0
> [  192.735115]  ? syscall_exit_to_user_mode_prepare+0x15a/0x190
> [  192.735644]  ? syscall_exit_to_user_mode+0x10/0x200
> [  192.736124]  ? do_syscall_64+0x8e/0x160
> [  192.736487]  ? exc_page_fault+0x76/0xf0
> [  192.736861]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [  192.737352] RIP: 0033:0x7fdf69a5c3de
> [  192.737725] Code: 73 01 c3 48 8b 0d 32 3a 0f 00 f7 d8 64 89 01 48 83
> c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 ad 01 00 00 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 02 3a 0f 00 f7 d8 64 89 01 48
> [  192.739455] RSP: 002b:00007ffd2b7c36d8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000001ad
> [  192.740176] RAX: ffffffffffffffda RBX: 0000557ac60e9a00 RCX:
> 00007fdf69a5c3de
> [  192.740895] RDX: 00000000ffffff9c RSI: 00007fdf69bc9902 RDI:
> 0000000000000004
> [  192.741578] RBP: 00007ffd2b7c3700 R08: 0000000000000004 R09:
> 0000000000000001
> [  192.742247] R10: 0000557ac60e9e40 R11: 0000000000000246 R12:
> 00007fdf69bd6b00
> [  192.742911] R13: 0000557ac60e9e40 R14: 0000557ac60ebbe0 R15:
> 0000000000000066
> [  192.743573]  </TASK>
> [  192.743803] ---[ end trace 0000000000000000 ]---
> 
> Thanks,
> Qu
> 
> > 
> > [  303.356328] BTRFS: device fsid 6fd8eb6f-1ea5-40aa-9857-05c64efe6d43
> > devid 1 transid 9 /dev/mapper/test-scratch1 (253:2) scanned by mount
> > (358060)
> > [  303.358614] BTRFS info (device dm-2): first mount of filesystem
> > 6fd8eb6f-1ea5-40aa-9857-05c64efe6d43
> > [  303.359475] BTRFS info (device dm-2): using crc32c (crc32c-intel)
> > checksum algorithm
> > [  303.360134] BTRFS info (device dm-2): using free-space-tree
> > [  313.264317] list_del corruption, ffff8fd48a7b2c90->prev is NULL
> > [  313.264966] ------------[ cut here ]------------
> > [  313.265402] kernel BUG at lib/list_debug.c:54!
> > [  313.265847] Oops: invalid opcode: 0000 [#1] PREEMPT SMP
> > [  313.266335] CPU: 4 UID: 0 PID: 370457 Comm: mount Kdump: loaded Not
> > tainted 6.13.0-rc4-custom+ #8
> > [  313.267252] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > Arch Linux 1.16.3-1-1 04/01/2014
> > [  313.268147] RIP: 0010:__list_del_entry_valid_or_report.cold+0x6d/0x6f
> > [  313.268777] Code: 05 77 a0 e8 4b 10 fd ff 0f 0b 48 89 fe 48 c7 c7 90
> > 05 77 a0 e8 3a 10 fd ff 0f 0b 48 89 fe 48 c7 c7 60 05 77 a0 e8 29 10 fd
> > ff <0f> 0b 4c 89 ea be 01 00 00 00 4c 89 44 24 48 48 c7 c7 20 7c 2b a1
> > [  313.270493] RSP: 0018:ffffa7620d2b3a38 EFLAGS: 00010246
> > [  313.270960] RAX: 0000000000000033 RBX: ffff8fd48a7b2c00 RCX:
> > 0000000000000000
> > [  313.271565] RDX: 0000000000000000 RSI: ffff8fd5f7c21900 RDI:
> > ffff8fd5f7c21900
> > [  313.272226] RBP: ffff8fd48a7b2c00 R08: 0000000000000000 R09:
> > 0000000000000000
> > [  313.272895] R10: 74707572726f6320 R11: 6c65645f7473696c R12:
> > ffffa7620d2b3a58
> > [  313.273521] R13: ffff8fd48a7b2c00 R14: 0000000000000000 R15:
> > ffff8fd48a7b2c90
> > [  313.274138] FS:  00007f04740d4800(0000) GS:ffff8fd5f7c00000(0000)
> > knlGS:0000000000000000
> > [  313.274864] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  313.275392] CR2: 00007f0473ff6000 CR3: 000000011a8eb000 CR4:
> > 0000000000750ef0
> > [  313.276084] PKRU: 55555554
> > [  313.276327] Call Trace:
> > [  313.276551]  <TASK>
> > [  313.276752]  ? __die_body.cold+0x19/0x28
> > [  313.277102]  ? die+0x2e/0x50
> > [  313.277699]  ? do_trap+0xc6/0x110
> > [  313.278033]  ? do_error_trap+0x6a/0x90
> > [  313.278401]  ? __list_del_entry_valid_or_report.cold+0x6d/0x6f
> > [  313.278941]  ? exc_invalid_op+0x50/0x60
> > [  313.279308]  ? __list_del_entry_valid_or_report.cold+0x6d/0x6f
> > [  313.279850]  ? asm_exc_invalid_op+0x1a/0x20
> > [  313.280241]  ? __list_del_entry_valid_or_report.cold+0x6d/0x6f
> > [  313.280777]  ? __list_del_entry_valid_or_report.cold+0x6d/0x6f
> > [  313.281285]  umount_tree+0xed/0x3c0
> > [  313.281589]  put_mnt_ns+0x51/0x90
> > [  313.281886]  mount_subtree+0x92/0x130
> > [  313.282205]  btrfs_get_tree+0x343/0x6b0 [btrfs]
> > [  313.282785]  vfs_get_tree+0x23/0xc0
> > [  313.283089]  vfs_cmd_create+0x59/0xd0
> > [  313.283406]  __do_sys_fsconfig+0x4eb/0x6b0
> > [  313.283764]  do_syscall_64+0x82/0x160
> > [  313.284085]  ? syscall_exit_to_user_mode_prepare+0x15a/0x190
> > [  313.284598]  ? __fs_parse+0x68/0x1b0
> > [  313.284929]  ? btrfs_parse_param+0x64/0x870 [btrfs]
> > [  313.285381]  ? vfs_parse_fs_param_source+0x20/0x90
> > [  313.285825]  ? __do_sys_fsconfig+0x1b8/0x6b0
> > [  313.286215]  ? syscall_exit_to_user_mode_prepare+0x15a/0x190
> > [  313.286719]  ? syscall_exit_to_user_mode+0x10/0x200
> > [  313.287151]  ? do_syscall_64+0x8e/0x160
> > [  313.287498]  ? vfs_fstatat+0x75/0xa0
> > [  313.287835]  ? __do_sys_newfstatat+0x56/0x90
> > [  313.288240]  ? syscall_exit_to_user_mode_prepare+0x15a/0x190
> > [  313.288749]  ? syscall_exit_to_user_mode+0x10/0x200
> > [  313.289188]  ? do_syscall_64+0x8e/0x160
> > [  313.289544]  ? do_syscall_64+0x8e/0x160
> > [  313.289892]  ? do_syscall_64+0x8e/0x160
> > [  313.290253]  ? syscall_exit_to_user_mode+0x10/0x200
> > [  313.290692]  ? do_syscall_64+0x8e/0x160
> > [  313.291034]  ? exc_page_fault+0x7e/0x180
> > [  313.291380]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > [  313.291845] RIP: 0033:0x7f04742a919e
> > [  313.292182] Code: 73 01 c3 48 8b 0d 72 3c 0f 00 f7 d8 64 89 01 48 83
> > c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 af 01 00 00 0f
> > 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 42 3c 0f 00 f7 d8 64 89 01 48
> > [  313.293830] RSP: 002b:00007ffc3df08df8 EFLAGS: 00000246 ORIG_RAX:
> > 00000000000001af
> > [  313.294529] RAX: ffffffffffffffda RBX: 000056407e37aa00 RCX:
> > 00007f04742a919e
> > [  313.295201] RDX: 0000000000000000 RSI: 0000000000000006 RDI:
> > 0000000000000003
> > [  313.295864] RBP: 00007ffc3df08f40 R08: 0000000000000000 R09:
> > 0000000000000001
> > [  313.296602] R10: 0000000000000000 R11: 0000000000000246 R12:
> > 00007f0474423b00
> > [  313.297416] R13: 0000000000000000 R14: 000056407e37cbe0 R15:
> > 00007f0474418561
> > [  313.298242]  </TASK>
> > [  313.298832] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6
> > nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> > nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> > nf_tables binfmt_misc btrfs xor raid6_pq zstd_compress iTCO_wdt
> > intel_pmc_bxt iTCO_vendor_support i2c_i801 i2c_smbus virtio_net joydev
> > net_failover lpc_ich virtio_balloon failover loop dm_multipath nfnetlink
> > vsock_loopback vmw_vsock_virtio_transport_common vsock zram
> > crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
> > polyval_generic ghash_clmulni_intel virtio_console sha512_ssse3
> > sha256_ssse3 bochs sha1_ssse3 virtio_blk serio_raw scsi_dh_rdac
> > scsi_dh_emc scsi_dh_alua fuse qemu_fw_cfg
> > [  313.304504] Dumping ftrace buffer:
> > [  313.304876]    (ftrace buffer empty)
> > 
> > [EARLY ANALYZE]
> > 
> > The offending line is the list_move() call inside unmount_tree().
> > 
> > With crash core dump, the offending mnt_list is totally corrupted:
> > 
> > crash> struct list_head ffff8fd48a7b2c90
> > struct list_head {
> >    next = 0x1,
> >    prev = 0x0
> > }
> > 
> > umount_tree() should be protected by @mount_lock seqlock, and
> > @namespace_sem rwsem.
> > 
> > I also checked other mnt_list users:
> > 
> > - commit_tree()
> > - do_umount()
> > - copy_tree()
> > 
> > They all hold write @mount_lock at least.
> > 
> > The only caller doesn't hold @mount_lock is iterate_mounts() but that's
> > only called from audit, and I'm not sure if audit is even involved in
> > this case.

This is fine as audit creates a private copy of the mount tree it is
interested in. The mount tree is not visible to other callers anymore.

> > 
> > So I ran out of ideas why this mnt_list can even happen.
> > 
> > Even if it's some btrfs' abuse, all mnt_list users are properly
> > protected thus it should not lead to such list corruption.
> > 
> > Any advice would be appreciated.
> > 
> > Thanks,
> > Qu
> > 
> 

