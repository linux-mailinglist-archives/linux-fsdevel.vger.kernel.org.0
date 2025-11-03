Return-Path: <linux-fsdevel+bounces-66843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F36DC2D4A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 17:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F3A42642F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 16:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C3B31AF1F;
	Mon,  3 Nov 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5qHNpgk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6C53164A6;
	Mon,  3 Nov 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188611; cv=none; b=pIoRJoFOQuh7y+6jDReaEzn3USBUkYqi+9lsGw9n5daV3idt9TNRCH85ij3J+L00K6/sfbFxl9i5qmMkEWdBKa0UcEYLXBsp8e/cV2Q8cOooTe/EMhFWtnFmmS6kcQbYOFju5V356cD/IEf1deeK7UsjuM5kO90ddL9cpboxe0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188611; c=relaxed/simple;
	bh=2NkK38TMc9LjJ8TfBFIjiUuCdo4RLI6/R2QEBQ+3oS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAyOhELfHMJEhdm4SVd3jm6DArA438xYUyUlaZKM4LAMOVJEHPW7EpmhTc6BNI8Ku7H7VnzQR15VumYOn1ydEt+mU4+o4UGyc/B2UtwAk7DSt/eYJIv8Wp+MFb4mGC+RiISukzfX1A8qP5rKFkaohC2/2TjF9UrPeXLd3NesJ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5qHNpgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED4CC4CEE7;
	Mon,  3 Nov 2025 16:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188610;
	bh=2NkK38TMc9LjJ8TfBFIjiUuCdo4RLI6/R2QEBQ+3oS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5qHNpgkyZf8G8iPlE8jjG6diw2zsxGCBW5lvorirQt793LgKtv5xy7pJymcJlVjP
	 ORtRmpa9oGl1YgF5PE1t7vQncGFeOGeiZL6yZgfK7Klt5lluGVDve7u70ignIzrdWa
	 AUH+dmArO6hW4d2CF7jDum5fiA7uK3bb9mqiTmN00pUcmeHLcc5j/Kt4C+7RhlV1s3
	 Hltb/jtTNRl0wjWUzwJIEoJIzhoDiegS+O+eDt81ty0bLZ+G7n6DAPj2AEOfvvrqql
	 o6F/ln8BYfX3HpQ7bqgBKuvAZ6hunRA9BK6YU8OAqKHZ01xfg8ifMbN+CPLLSAHcDC
	 0wmC7RvGLvH5Q==
Date: Mon, 3 Nov 2025 08:48:29 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	linux-fscrypt@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2] fscrypt: fix left shift underflow when
 inode->i_blkbits > PAGE_SHIFT
Message-ID: <20251103164829.GC1735@sol>
References: <20251030072956.454679-1-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030072956.454679-1-yangyongpeng.storage@gmail.com>

[+linux-fsdevel, linux-block, and Luis]

On Thu, Oct 30, 2025 at 03:29:56PM +0800, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> When simulating an nvme device on qemu with both logical_block_size and
> physical_block_size set to 8 KiB, a error trace appears during partition
> table reading at boot time. The issue is caused by inode->i_blkbits being
> larger than PAGE_SHIFT, which leads to a left shift of -1 and triggering a
> UBSAN warning.
> 
> [    2.697306] ------------[ cut here ]------------
> [    2.697309] UBSAN: shift-out-of-bounds in fs/crypto/inline_crypt.c:336:37
> [    2.697311] shift exponent -1 is negative
> [    2.697315] CPU: 3 UID: 0 PID: 274 Comm: (udev-worker) Not tainted 6.18.0-rc2+ #34 PREEMPT(voluntary)
> [    2.697317] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [    2.697320] Call Trace:
> [    2.697324]  <TASK>
> [    2.697325]  dump_stack_lvl+0x76/0xa0
> [    2.697340]  dump_stack+0x10/0x20
> [    2.697342]  __ubsan_handle_shift_out_of_bounds+0x1e3/0x390
> [    2.697351]  bh_get_inode_and_lblk_num.cold+0x12/0x94
> [    2.697359]  fscrypt_set_bio_crypt_ctx_bh+0x44/0x90
> [    2.697365]  submit_bh_wbc+0xb6/0x190
> [    2.697370]  block_read_full_folio+0x194/0x270
> [    2.697371]  ? __pfx_blkdev_get_block+0x10/0x10
> [    2.697375]  ? __pfx_blkdev_read_folio+0x10/0x10
> [    2.697377]  blkdev_read_folio+0x18/0x30
> [    2.697379]  filemap_read_folio+0x40/0xe0
> [    2.697382]  filemap_get_pages+0x5ef/0x7a0
> [    2.697385]  ? mmap_region+0x63/0xd0
> [    2.697389]  filemap_read+0x11d/0x520
> [    2.697392]  blkdev_read_iter+0x7c/0x180
> [    2.697393]  vfs_read+0x261/0x390
> [    2.697397]  ksys_read+0x71/0xf0
> [    2.697398]  __x64_sys_read+0x19/0x30
> [    2.697399]  x64_sys_call+0x1e88/0x26a0
> [    2.697405]  do_syscall_64+0x80/0x670
> [    2.697410]  ? __x64_sys_newfstat+0x15/0x20
> [    2.697414]  ? x64_sys_call+0x204a/0x26a0
> [    2.697415]  ? do_syscall_64+0xb8/0x670
> [    2.697417]  ? irqentry_exit_to_user_mode+0x2e/0x2a0
> [    2.697420]  ? irqentry_exit+0x43/0x50
> [    2.697421]  ? exc_page_fault+0x90/0x1b0
> [    2.697422]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    2.697425] RIP: 0033:0x75054cba4a06
> [    2.697426] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 19 83 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45 10 0f 05 <48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83 ec 08
> [    2.697427] RSP: 002b:00007fff973723a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
> [    2.697430] RAX: ffffffffffffffda RBX: 00005ea9a2c02760 RCX: 000075054cba4a06
> [    2.697432] RDX: 0000000000002000 RSI: 000075054c190000 RDI: 000000000000001b
> [    2.697433] RBP: 00007fff973723c0 R08: 0000000000000000 R09: 0000000000000000
> [    2.697434] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> [    2.697434] R13: 00005ea9a2c027c0 R14: 00005ea9a2be5608 R15: 00005ea9a2be55f0
> [    2.697436]  </TASK>
> [    2.697436] ---[ end trace ]---
> 
> This situation can happen for block devices because when
> CONFIG_TRANSPARENT_HUGEPAGE is enabled, the maximum logical_block_size
> is 64 KiB. set_init_blocksize() then sets the block device inode->i_blkbits
> to 8 KiB, which is within this limit.
> 
> File I/O does not trigger this problem because for filesystems that do not
> support the FS_LBS feature, sb_set_blocksize() prevents sb->s_blocksize_bits
> from being larger than PAGE_SHIFT. During inode allocation,
> alloc_inode()->inode_init_always() assigns inode->i_blkbits from
> sb->s_blocksize_bits. Currently, only xfs_fs_type has the FS_LBS flag, and
> since xfs I/O paths do not reach submit_bh_wbc(), it does not hit the
> left-shift underflow issue.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> ---
> v2:
> - Added more explanations about the issue in the commit message.
> ---
>  fs/crypto/inline_crypt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
> index 5dee7c498bc8..6beb5f490612 100644
> --- a/fs/crypto/inline_crypt.c
> +++ b/fs/crypto/inline_crypt.c
> @@ -333,7 +333,7 @@ static bool bh_get_inode_and_lblk_num(const struct buffer_head *bh,
>  	inode = mapping->host;
>  
>  	*inode_ret = inode;
> -	*lblk_num_ret = ((u64)folio->index << (PAGE_SHIFT - inode->i_blkbits)) +
> +	*lblk_num_ret = (((u64)folio->index << PAGE_SHIFT) >> inode->i_blkbits) +
>  			(bh_offset(bh) >> inode->i_blkbits);
>  	return true;
>  }

Applied to https://git.kernel.org/pub/scm/fs/fscrypt/linux.git/log/?h=for-current

I also added:

    Fixes: 47dd67532303 ("block/bdev: lift block size restrictions to 64k")
    Cc: stable@vger.kernel.org

- Eric

