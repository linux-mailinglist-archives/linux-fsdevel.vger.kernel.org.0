Return-Path: <linux-fsdevel+bounces-66752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E617C2B8EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19C6B4F89E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72113064B9;
	Mon,  3 Nov 2025 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eXfSx3ii";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BDjD8TEE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c16v2S6i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XgRYthOO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B40B305054
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170686; cv=none; b=R/GbEAfsx1pUeAgeABqS8meleutS4O3711GgL7YZJhgPk4L+EIc0XDEdlV7Q9zVapHxyrCqpS8pcCpApC7SjkpbpSEC4+5IDC+VDwl3EqJWYd7vLyhP9eLF3UK8CO1e6RonhvRTI0T/pxhf6YuHgjtk+ihvJlKllHzTPoO6EuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170686; c=relaxed/simple;
	bh=ttsQppbIm8ILKrJIJqRAo06BDzEsVtqTbytNyksjwug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aswuTED4WT6gtI89o6Ag9RRr7wMVKjn6WQY9g1LyDXCBCH97N29+/3t8C+layh6mZV4LU8FWxp85uJSVeoox1CG2HE/iKDSvEUyqcNhntNdU5u99kBjLNv5Vvc9QbbjZJTfO4EWVvrgsDb3rCIdbVM47pcSiREDeztlXXZxTtZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eXfSx3ii; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BDjD8TEE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c16v2S6i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XgRYthOO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2ED8D219BE;
	Mon,  3 Nov 2025 11:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762170682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPbHi8i7WeF2vW9PhUCWeWoscHCu7qEQF7Dw96amgIc=;
	b=eXfSx3iiW5rxKCXXsgy7CRyw+/gnXEVdL4EoqeXL645hEN5ulMndlT9CuFA6NShz03YVIm
	E+FO+bXQF333miWa5PB7N2YDY1ugErOaqu142fyBb87AYn45XbZ/UyD+1RJphBfD9PtWOf
	ccPTLMr0S4/eEa/Sl7pdpS8rTYE2ICw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762170682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPbHi8i7WeF2vW9PhUCWeWoscHCu7qEQF7Dw96amgIc=;
	b=BDjD8TEEx7J7F94V8gReIZSIsGGcZaOjJgYfBwG+lHeMi2ID58jViUt1dxmxgAP9LXB8ok
	6IurJgKWPMrQV7Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762170681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPbHi8i7WeF2vW9PhUCWeWoscHCu7qEQF7Dw96amgIc=;
	b=c16v2S6iJfRxqL0SNnOdEElU7xUVazCajzPN+nGeIjQA4Qq0eAZiVnvIIkVarYj0zvYfKe
	hQOZQ+RCJA3wveSbis40AY8ddkH7Ie6xqtJCtx9akfLaykYtEfmBORNY7P+XET59w77C2y
	rjd0njiRLPSWy71yR0u029uW/d4PVTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762170681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPbHi8i7WeF2vW9PhUCWeWoscHCu7qEQF7Dw96amgIc=;
	b=XgRYthOOV1bV7+bhkXj5Vin8x5TYng5drjnGQwUYVYRU8OHovwxH3U/NSQsUZtEqtkYmNF
	CCi4ZoJ0/mmxrODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12BC81364F;
	Mon,  3 Nov 2025 11:51:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gfCKBDmXCGmiOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 11:51:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 661CFA2812; Mon,  3 Nov 2025 12:51:20 +0100 (CET)
Date: Mon, 3 Nov 2025 12:51:20 +0100
From: Jan Kara <jack@suse.cz>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [PATCH v2] fix missing sb_min_blocksize() return value checks in
 some filesystems
Message-ID: <zsidbbgdma6gzdcofd5zwz6vcow5drnurbswxlskxdyl7pvrkz@4b3vbfowyzgk>
References: <20251102163835.6533-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102163835.6533-2-yangyongpeng.storage@gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email,xiaomi.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Mon 03-11-25 00:38:36, Yongpeng Yang wrote:
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
> in vfat, exfat, isofs, and xfs. Add the __must_check mark to
> sb_min_blocksize().
> 
> Cc: <stable@vger.kernel.org> # v6.15
> Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
> for sb_set_blocksize()")
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

for the isofs and generic changes.

								Honza


> ---
> v2:
> - add the __must_check mark to sb_min_blocksize() and include the Fixes
> tag
> ---
>  block/bdev.c       | 2 +-
>  fs/exfat/super.c   | 7 ++++++-
>  fs/fat/inode.c     | 9 +++++++--
>  fs/isofs/inode.c   | 5 +++++
>  fs/xfs/xfs_super.c | 8 ++++++--
>  include/linux/fs.h | 2 +-
>  6 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 810707cca970..638f0cd458ae 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -231,7 +231,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
>  
>  EXPORT_SYMBOL(sb_set_blocksize);
>  
> -int sb_min_blocksize(struct super_block *sb, int size)
> +int __must_check sb_min_blocksize(struct super_block *sb, int size)
>  {
>  	int minsize = bdev_logical_block_size(sb->s_bdev);
>  	if (size < minsize)
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
> index 1067ebb3b001..14dcace5f0c4 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1673,7 +1673,7 @@ xfs_fs_fill_super(
>  {
>  	struct xfs_mount	*mp = sb->s_fs_info;
>  	struct inode		*root;
> -	int			flags = 0, error;
> +	int			flags = 0, error, blocksize;
>  
>  	mp->m_super = sb;
>  
> @@ -1693,7 +1693,11 @@ xfs_fs_fill_super(
>  	if (error)
>  		return error;
>  
> -	sb_min_blocksize(sb, BBSIZE);
> +	blocksize = sb_min_blocksize(sb, BBSIZE);
> +	if (!blocksize) {
> +		xfs_err(mp, "unable to set blocksize");
> +		return -EINVAL;
> +	}
>  	sb->s_xattr = xfs_xattr_handlers;
>  	sb->s_export_op = &xfs_export_operations;
>  #ifdef CONFIG_XFS_QUOTA
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c895146c1444..26d4ca0f859a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3424,7 +3424,7 @@ extern void inode_sb_list_add(struct inode *inode);
>  extern void inode_add_lru(struct inode *inode);
>  
>  extern int sb_set_blocksize(struct super_block *, int);
> -extern int sb_min_blocksize(struct super_block *, int);
> +extern int __must_check sb_min_blocksize(struct super_block *, int);
>  
>  int generic_file_mmap(struct file *, struct vm_area_struct *);
>  int generic_file_mmap_prepare(struct vm_area_desc *desc);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

