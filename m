Return-Path: <linux-fsdevel+bounces-67098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B5AC3551E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 12:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 464184F4C9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ECF30FC1F;
	Wed,  5 Nov 2025 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knbkAIWy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36F82F1FD2;
	Wed,  5 Nov 2025 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341485; cv=none; b=XLlYUu7avzOr2agvRVMvtg4Coaz2suflMZ/cWrCCYGqNmRojdr5a2kR9wPgztnpsmtgmePkH/N2+doffspnKoAOhfgYHhhOG0lZZIEme/lrw4fv6U1h6edsSAPdkR+k1yirC9/6p1ISYUyY0B3rx3mTov/Hk9RFQLrmFqpD99/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341485; c=relaxed/simple;
	bh=8cflPIIAlr4DmbW78x+5XZ22FHRHMpp/a4PnXwi0bOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jT26Mj5sWcMezr00mwvebMz/sDTfWC4pEvnCaeaKXMJ/5vBknzkjcqqyZq5M0T6evJGV4RXavEhwulnq1KJecrCH9F8/fNPStnEl8lZORZZ8HDDUWN40hTyvrF7FGeasWVM9JyMila8/59xUQsrGpZlBjCyRdMeyKKXjqCn8qNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knbkAIWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433B2C4CEF8;
	Wed,  5 Nov 2025 11:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762341484;
	bh=8cflPIIAlr4DmbW78x+5XZ22FHRHMpp/a4PnXwi0bOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=knbkAIWy+gu8l89MmQNXr3pfUDrTBcAa5VFmEg+n9PObqU1AWWKF0acsKwWMgLhbH
	 IXMTaen9CLUj6kGz74gOHjlxgl/TuDingIaNexgEFiVgrKXcI0wUKPJ13YU2+rNfyF
	 9PfJnVqepZVUD8aKbPazYDWfyySYDOrEHi2zHejVEkphIyGwGP3lS0rbPEiAaGwWCu
	 lqYBW9ZizV+C3uokG45KWpN0YpxNAgxzjt/AESjr903xi8cuCMSDDX4mZSp0L0lMRN
	 f6ZZIt7iYWsqJGyfvmS1/ZUPd+0RXsxPperxNAOLSaXqCJwl04pf51Xa1wqwqASMuA
	 V4Ncif9cwClkw==
From: Christian Brauner <brauner@kernel.org>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Christoph Hellwig <hch@lst.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 1/5] vfat: fix missing sb_min_blocksize() return value checks
Date: Wed,  5 Nov 2025 12:17:48 +0100
Message-ID: <20251105-subtil-tabuisieren-bb71156f02aa@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
References: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=5811; i=brauner@kernel.org; h=from:subject:message-id; bh=8cflPIIAlr4DmbW78x+5XZ22FHRHMpp/a4PnXwi0bOs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyG6Xsctik969Qq3+hy9FtC94+aFpt15jYdMFy1pRsP T0z+U0uHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOptGFkeC8QlLfrwtyZF6X0 Itcb6tklFH/lFGVOqJ3b7b7Y+cH1V4wM/6MFoxOTPvt+POi1e/KPLCaZ4DuvFEqVP/kfn8r+6N4 XfgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 04 Nov 2025 20:50:06 +0800, Yongpeng Yang wrote:
> When emulating an nvme device on qemu with both logical_block_size and
> physical_block_size set to 8 KiB, but without format, a kernel panic
> was triggered during the early boot stage while attempting to mount a
> vfat filesystem.
> 
> [95553.682035] EXT4-fs (nvme0n1): unable to set blocksize
> [95553.684326] EXT4-fs (nvme0n1): unable to set blocksize
> [95553.686501] EXT4-fs (nvme0n1): unable to set blocksize
> [95553.696448] ISOFS: unsupported/invalid hardware sector size 8192
> [95553.697117] ------------[ cut here ]------------
> [95553.697567] kernel BUG at fs/buffer.c:1582!
> [95553.697984] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> [95553.698602] CPU: 0 UID: 0 PID: 7212 Comm: mount Kdump: loaded Not tainted 6.18.0-rc2+ #38 PREEMPT(voluntary)
> [95553.699511] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [95553.700534] RIP: 0010:folio_alloc_buffers+0x1bb/0x1c0
> [95553.701018] Code: 48 8b 15 e8 93 18 02 65 48 89 35 e0 93 18 02 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d 31 d2 31 c9 31 f6 31 ff c3 cc cc cc cc <0f> 0b 90 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f
> [95553.702648] RSP: 0018:ffffd1b0c676f990 EFLAGS: 00010246
> [95553.703132] RAX: ffff8cfc4176d820 RBX: 0000000000508c48 RCX: 0000000000000001
> [95553.703805] RDX: 0000000000002000 RSI: 0000000000000000 RDI: 0000000000000000
> [95553.704481] RBP: ffffd1b0c676f9c8 R08: 0000000000000000 R09: 0000000000000000
> [95553.705148] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> [95553.705816] R13: 0000000000002000 R14: fffff8bc8257e800 R15: 0000000000000000
> [95553.706483] FS:  000072ee77315840(0000) GS:ffff8cfdd2c8d000(0000) knlGS:0000000000000000
> [95553.707248] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [95553.707782] CR2: 00007d8f2a9e5a20 CR3: 0000000039d0c006 CR4: 0000000000772ef0
> [95553.708439] PKRU: 55555554
> [95553.708734] Call Trace:
> [95553.709015]  <TASK>
> [95553.709266]  __getblk_slow+0xd2/0x230
> [95553.709641]  ? find_get_block_common+0x8b/0x530
> [95553.710084]  bdev_getblk+0x77/0xa0
> [95553.710449]  __bread_gfp+0x22/0x140
> [95553.710810]  fat_fill_super+0x23a/0xfc0
> [95553.711216]  ? __pfx_setup+0x10/0x10
> [95553.711580]  ? __pfx_vfat_fill_super+0x10/0x10
> [95553.712014]  vfat_fill_super+0x15/0x30
> [95553.712401]  get_tree_bdev_flags+0x141/0x1e0
> [95553.712817]  get_tree_bdev+0x10/0x20
> [95553.713177]  vfat_get_tree+0x15/0x20
> [95553.713550]  vfs_get_tree+0x2a/0x100
> [95553.713910]  vfs_cmd_create+0x62/0xf0
> [95553.714273]  __do_sys_fsconfig+0x4e7/0x660
> [95553.714669]  __x64_sys_fsconfig+0x20/0x40
> [95553.715062]  x64_sys_call+0x21ee/0x26a0
> [95553.715453]  do_syscall_64+0x80/0x670
> [95553.715816]  ? __fs_parse+0x65/0x1e0
> [95553.716172]  ? fat_parse_param+0x103/0x4b0
> [95553.716587]  ? vfs_parse_fs_param_source+0x21/0xa0
> [95553.717034]  ? __do_sys_fsconfig+0x3d9/0x660
> [95553.717548]  ? __x64_sys_fsconfig+0x20/0x40
> [95553.717957]  ? x64_sys_call+0x21ee/0x26a0
> [95553.718360]  ? do_syscall_64+0xb8/0x670
> [95553.718734]  ? __x64_sys_fsconfig+0x20/0x40
> [95553.719141]  ? x64_sys_call+0x21ee/0x26a0
> [95553.719545]  ? do_syscall_64+0xb8/0x670
> [95553.719922]  ? x64_sys_call+0x1405/0x26a0
> [95553.720317]  ? do_syscall_64+0xb8/0x670
> [95553.720702]  ? __x64_sys_close+0x3e/0x90
> [95553.721080]  ? x64_sys_call+0x1b5e/0x26a0
> [95553.721478]  ? do_syscall_64+0xb8/0x670
> [95553.721841]  ? irqentry_exit+0x43/0x50
> [95553.722211]  ? exc_page_fault+0x90/0x1b0
> [95553.722681]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [95553.723166] RIP: 0033:0x72ee774f3afe
> [95553.723562] Code: 73 01 c3 48 8b 0d 0a 33 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 af 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d da 32 0f 00 f7 d8 64 89 01 48
> [95553.725188] RSP: 002b:00007ffe97148978 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
> [95553.725892] RAX: ffffffffffffffda RBX: 00005dcfe53d0080 RCX: 000072ee774f3afe
> [95553.726526] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
> [95553.727176] RBP: 00007ffe97148ac0 R08: 0000000000000000 R09: 000072ee775e7ac0
> [95553.727818] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [95553.728459] R13: 00005dcfe53d04b0 R14: 000072ee77670b00 R15: 00005dcfe53d1a28
> [95553.729086]  </TASK>
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/5] vfat: fix missing sb_min_blocksize() return value checks
      https://git.kernel.org/vfs/vfs/c/c9374affbcb5
[2/5] exfat: check return value of sb_min_blocksize in exfat_read_boot_sector
      https://git.kernel.org/vfs/vfs/c/d1178095d240
[3/5] isofs: check the return value of sb_min_blocksize() in isofs_fill_super
      https://git.kernel.org/vfs/vfs/c/f0e6852b29d1
[4/5] xfs: check the return value of sb_min_blocksize() in xfs_fs_fill_super
      https://git.kernel.org/vfs/vfs/c/018e0be111cb
[5/5] block: add __must_check attribute to sb_min_blocksize()
      https://git.kernel.org/vfs/vfs/c/11fee7948917

