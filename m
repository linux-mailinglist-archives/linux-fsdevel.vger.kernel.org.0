Return-Path: <linux-fsdevel+bounces-66597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C928EC25D22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 16:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476AE1891D0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 15:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCF32D190C;
	Fri, 31 Oct 2025 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xlaf9i5o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A1C2D0C99;
	Fri, 31 Oct 2025 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761924205; cv=none; b=utFepgiZ4NEbD70kGKgRrivDjNBOW6nIBl0xnkNSJ3hSSzEwvO0IKxIHk+ZnNA7YHWyuFJkhWKV2xj8cnlC03o/QUi9ynROkDDNsHLXW0assxEAXnby3gxkT1w+nSCfaYEy1N0kCISpvVhlahXb8LdfLJa2/HIQPWZXelOT6DdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761924205; c=relaxed/simple;
	bh=y9raUuBig5N4WyKFwF7uynqetobG8lw/9Bb0lLpRhMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYyR0ey77voVINfoPfdn6pIEyAHRcsr8TTM6t0nS1DnTANQ5jA6ojfSOWUjDWGAC0q9NWe5ocgktDeNo14iAqXwgaI+f/yOncENWVFWpJWiBWm6fCt/rflO/7p53rBdpk7CwUJm150yfsutMHbHIvbJUF7lMTtEHA3fLpmBwick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xlaf9i5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05852C4CEFB;
	Fri, 31 Oct 2025 15:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761924205;
	bh=y9raUuBig5N4WyKFwF7uynqetobG8lw/9Bb0lLpRhMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xlaf9i5oR0S7ayGjVLYAdO0rAXqp0TCWBIgi1ozuDP8Ag9OO9CwaMAbyFaBkX/zk4
	 ZoEkrcF8Ca5oJrI4tyic6/jVwGMtJIy17vDZAM0rRqocl9UxKX35BxW/+5vucymJw3
	 CajRFuxHtUgqrVtsQSBMx6diaMV0s90p4UW0NC1YN6t7Eva99PCjkqZRq3Irv5WbDU
	 xrFqlhfvs9PM7/y2T4o3Ltu46Yv5BN6CAEpMLCL1YjnbinDAgPzeEuLKsHQlekRHTG
	 uO59ATG8DqFqbVLAKEYQm6s+K1YFjHBtaqOqtznsDsKc6i0vvEfpCby4aett/c3dRO
	 o3ltSsAPfpweg==
Date: Fri, 31 Oct 2025 08:23:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [PATCH] fix missing sb_min_blocksize() return value checks in
 some filesystems
Message-ID: <20251031152324.GN6174@frogsfrogsfrogs>
References: <20251031141528.1084112-1-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031141528.1084112-1-yangyongpeng.storage@gmail.com>

On Fri, Oct 31, 2025 at 10:15:27PM +0800, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
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
> The panic occurs as follows:
> 1. logical_block_size is 8KiB, causing {struct super_block *sb}->s_blocksize
> is initialized to 0.
> vfat_fill_super
>  - fat_fill_super
>   - sb_min_blocksize
>    - sb_set_blocksize //return 0 when size is 8KiB.
> 2. __bread_gfp is called with size == 0, causing folio_alloc_buffers() to
> compute an offset equal to folio_size(folio), which triggers a BUG_ON.
> fat_fill_super
>  - sb_bread
>   - __bread_gfp  // size == {struct super_block *sb}->s_blocksize == 0
>    - bdev_getblk
>     - __getblk_slow
>      - grow_buffers
>       - grow_dev_folio
>        - folio_alloc_buffers  // size == 0
>         - folio_set_bh //offset == folio_size(folio) and panic
> 
> To fix this issue, add proper return value checks for sb_min_blocksize()
> in vfat, exfat, isofs, and xfs.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> ---
>  fs/exfat/super.c   | 7 ++++++-
>  fs/fat/inode.c     | 9 +++++++--
>  fs/isofs/inode.c   | 5 +++++
>  fs/xfs/xfs_super.c | 8 ++++++--
>  4 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index 7f9592856bf7..fea41732354e 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -431,9 +431,14 @@ static int exfat_read_boot_sector(struct super_block *sb)
>  {
>  	struct boot_sector *p_boot;
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	int blocksize;
>  
>  	/* set block size to read super block */
> -	sb_min_blocksize(sb, 512);
> +	blocksize = sb_min_blocksize(sb, 512);
> +	if (!blocksize) {
> +		exfat_err(sb, "unable to set blocksize");
> +		return -EINVAL;
> +	}
>  
>  	/* read boot sector */
>  	sbi->boot_bh = sb_bread(sb, 0);
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index 9648ed097816..d22eec4f17b2 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -1535,7 +1535,7 @@ int fat_fill_super(struct super_block *sb, struct fs_context *fc,
>  		   void (*setup)(struct super_block *))
>  {
>  	struct fat_mount_options *opts = fc->fs_private;
> -	int silent = fc->sb_flags & SB_SILENT;
> +	int silent = fc->sb_flags & SB_SILENT, blocksize;
>  	struct inode *root_inode = NULL, *fat_inode = NULL;
>  	struct inode *fsinfo_inode = NULL;
>  	struct buffer_head *bh;
> @@ -1595,8 +1595,13 @@ int fat_fill_super(struct super_block *sb, struct fs_context *fc,
>  
>  	setup(sb); /* flavour-specific stuff that needs options */
>  
> +	error = -EINVAL;
> +	blocksize = sb_min_blocksize(sb, 512);
> +	if (!blocksize) {
> +		fat_msg(sb, KERN_ERR, "unable to set blocksize");
> +		goto out_fail;
> +	}
>  	error = -EIO;
> -	sb_min_blocksize(sb, 512);
>  	bh = sb_bread(sb, 0);
>  	if (bh == NULL) {
>  		fat_msg(sb, KERN_ERR, "unable to read boot sector");
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index 6f0e6b19383c..ad3143d4066b 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -610,6 +610,11 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
>  		goto out_freesbi;
>  	}
>  	opt->blocksize = sb_min_blocksize(s, opt->blocksize);
> +	if (!opt->blocksize) {
> +		printk(KERN_ERR
> +		       "ISOFS: unable to set blocksize\n");
> +		goto out_freesbi;
> +	}
>  
>  	sbi->s_high_sierra = 0; /* default is iso9660 */
>  	sbi->s_session = opt->session;
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index e85a156dc17d..b6e52861378f 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1642,7 +1642,7 @@ xfs_fs_fill_super(
>  {
>  	struct xfs_mount	*mp = sb->s_fs_info;
>  	struct inode		*root;
> -	int			flags = 0, error;
> +	int			flags = 0, error, blocksize;
>  
>  	mp->m_super = sb;
>  
> @@ -1662,7 +1662,11 @@ xfs_fs_fill_super(
>  	if (error)
>  		return error;
>  
> -	sb_min_blocksize(sb, BBSIZE);
> +	blocksize = sb_min_blocksize(sb, BBSIZE);

Hrmm... sb_min_blocksize clamps its argument (512) up to the bdev lba
size, which could fail.  That's unlikely given that XFS sets FS_LBS and
there shouldn't be a file->private_data; but this function is fallible
so let's not just ignore the return value.

The changes look correct to me, but shouldn't this have a fixes tag?
I could guess at:

Cc: <stable@vger.kernel.org> # v6.15
Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation for sb_set_blocksize()")

Either way,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +	if (!blocksize) {
> +		xfs_err(mp, "unable to set blocksize");
> +		return -EINVAL;
> +	}
>  	sb->s_xattr = xfs_xattr_handlers;
>  	sb->s_export_op = &xfs_export_operations;
>  #ifdef CONFIG_XFS_QUOTA
> -- 
> 2.43.0
> 
> 

