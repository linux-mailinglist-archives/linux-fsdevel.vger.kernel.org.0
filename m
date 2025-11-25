Return-Path: <linux-fsdevel+bounces-69739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81710C84242
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DD73A9800
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CC92DC769;
	Tue, 25 Nov 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t53nA9yL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ECA28726D;
	Tue, 25 Nov 2025 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061615; cv=none; b=jtyBe8NYdDgGBDvEvoBu6jxsYYw69MDxVH9aqYxKLWpWVZMwRqfyTfEXci0k8TlO8pdBVjmGlvx+5Uikrb0zynTlPUbArgboz1ynBL3EGNAest3yUTXZZCeT783rchXqKZsuyRYj1kAPsgrVY57ewyDK3lcVg3kwD2xWICExb/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061615; c=relaxed/simple;
	bh=/6xgY+QUZe7yhtQ4EZKa7hVo/oNwHMs+v97FRI/VAu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f18wrt2XCSQvwjyf2tcGVUIxb8mVOU9TxMULrPkOPRfIcfv4pmekwY0t3+DaLWppxXbeH2wkrVayyA5p4WnipmEADgTGxS5Pt1lsULAUL/z2Bss80kM0q9qXXgbhIcWvIR3LmwY7+sLD6bEiWAoDOh8VrddFn8Bd2Gdx93Qz0T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t53nA9yL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50166C4CEF1;
	Tue, 25 Nov 2025 09:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764061614;
	bh=/6xgY+QUZe7yhtQ4EZKa7hVo/oNwHMs+v97FRI/VAu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t53nA9yLGeE+Sus973lZYZJlbwvfm23dE1MFnthrUMhnDg5r1ErvAiHIdBrgJHpOM
	 ElS5utqTTseVcfy6r/R5pRCtFQGsOLF8JYc2zQo2OH0qfZDJBfX2alR8Mz2NflGuta
	 FFsC+oYZ3Q6VQa6QcGm8+Ouj2E3vbAnH/TAGQDugfEPBSWPYPxXWqSFNUxUiu6UzbP
	 PtrJPnRrb10j0j89cXAWvhWJ4DO5MT/BjF6sKUmTpokDhL5GQtLswFdWXTgU1cMj+p
	 i406FhXS39Go2928v7A3mO77JqeU8lIsp9f7RecvxOJUCKbpwh/9SALqHm0D40m6DF
	 Dtj3Hp29U+Vpg==
Date: Tue, 25 Nov 2025 10:06:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: david.laight.linux@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Kees Cook <kees@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 30/44] fs: use min() or umin() instead of min_t()
Message-ID: <20251125-erlenholz-pausieren-0a4b80f2be6c@brauner>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-31-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251119224140.8616-31-david.laight.linux@gmail.com>

On Wed, Nov 19, 2025 at 10:41:26PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
> and so cannot discard significant bits.
> 
> A couple of places need umin() because of loops like:
> 	nfolios = DIV_ROUND_UP(ret + start, PAGE_SIZE);
> 
> 	for (i = 0; i < nfolios; i++) {
> 		struct folio *folio = page_folio(pages[i]);
> 		...
> 		unsigned int len = umin(ret, PAGE_SIZE - start);
> 		...
> 		ret -= len;
> 		...
> 	}
> where the compiler doesn't track things well enough to know that
> 'ret' is never negative.
> 
> The alternate loop:
>         for (i = 0; ret > 0; i++) {
>                 struct folio *folio = page_folio(pages[i]);
>                 ...
>                 unsigned int len = min(ret, PAGE_SIZE - start);
>                 ...
>                 ret -= len;
>                 ...
>         }
> would be equivalent and doesn't need 'nfolios'.
> 
> Most of the 'unsigned long' actually come from PAGE_SIZE.
> 
> Detected by an extra check added to min_t().
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---

Too late for this cycle but we will pick this up next cycle!

>  fs/buffer.c       | 2 +-
>  fs/exec.c         | 2 +-
>  fs/ext4/mballoc.c | 3 +--
>  fs/ext4/resize.c  | 2 +-
>  fs/ext4/super.c   | 2 +-
>  fs/fat/dir.c      | 4 ++--
>  fs/fat/file.c     | 3 +--
>  fs/fuse/dev.c     | 2 +-
>  fs/fuse/file.c    | 8 +++-----
>  fs/splice.c       | 2 +-
>  10 files changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 6a8752f7bbed..26c4c760b6c6 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2354,7 +2354,7 @@ bool block_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
>  	if (!head)
>  		return false;
>  	blocksize = head->b_size;
> -	to = min_t(unsigned, folio_size(folio) - from, count);
> +	to = min(folio_size(folio) - from, count);
>  	to = from + to;
>  	if (from < blocksize && to > folio_size(folio) - blocksize)
>  		return false;
> diff --git a/fs/exec.c b/fs/exec.c
> index 4298e7e08d5d..6d699e48df82 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -555,7 +555,7 @@ int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
>  		return -E2BIG;
>  
>  	while (len > 0) {
> -		unsigned int bytes_to_copy = min_t(unsigned int, len,
> +		unsigned int bytes_to_copy = min(len,
>  				min_not_zero(offset_in_page(pos), PAGE_SIZE));
>  		struct page *page;
>  
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 9087183602e4..cb68ea974de6 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4254,8 +4254,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  		 * get the corresponding group metadata to work with.
>  		 * For this we have goto again loop.
>  		 */
> -		thisgrp_len = min_t(unsigned int, (unsigned int)len,
> -			EXT4_BLOCKS_PER_GROUP(sb) - EXT4_C2B(sbi, blkoff));
> +		thisgrp_len = min(len, EXT4_BLOCKS_PER_GROUP(sb) - EXT4_C2B(sbi, blkoff));
>  		clen = EXT4_NUM_B2C(sbi, thisgrp_len);
>  
>  		if (!ext4_sb_block_valid(sb, NULL, block, thisgrp_len)) {
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 050f26168d97..76842f0957b5 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -1479,7 +1479,7 @@ static void ext4_update_super(struct super_block *sb,
>  
>  	/* Update the global fs size fields */
>  	sbi->s_groups_count += flex_gd->count;
> -	sbi->s_blockfile_groups = min_t(ext4_group_t, sbi->s_groups_count,
> +	sbi->s_blockfile_groups = min(sbi->s_groups_count,
>  			(EXT4_MAX_BLOCK_FILE_PHYS / EXT4_BLOCKS_PER_GROUP(sb)));
>  
>  	/* Update the reserved block counts only once the new group is
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 33e7c08c9529..e116fe48ff43 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4830,7 +4830,7 @@ static int ext4_check_geometry(struct super_block *sb,
>  		return -EINVAL;
>  	}
>  	sbi->s_groups_count = blocks_count;
> -	sbi->s_blockfile_groups = min_t(ext4_group_t, sbi->s_groups_count,
> +	sbi->s_blockfile_groups = min(sbi->s_groups_count,
>  			(EXT4_MAX_BLOCK_FILE_PHYS / EXT4_BLOCKS_PER_GROUP(sb)));
>  	if (((u64)sbi->s_groups_count * sbi->s_inodes_per_group) !=
>  	    le32_to_cpu(es->s_inodes_count)) {
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 92b091783966..8375e7fbc1a5 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -1353,7 +1353,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
>  
>  		/* Fill the long name slots. */
>  		for (i = 0; i < long_bhs; i++) {
> -			int copy = min_t(int, sb->s_blocksize - offset, size);
> +			int copy = umin(sb->s_blocksize - offset, size);
>  			memcpy(bhs[i]->b_data + offset, slots, copy);
>  			mark_buffer_dirty_inode(bhs[i], dir);
>  			offset = 0;
> @@ -1364,7 +1364,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
>  			err = fat_sync_bhs(bhs, long_bhs);
>  		if (!err && i < nr_bhs) {
>  			/* Fill the short name slot. */
> -			int copy = min_t(int, sb->s_blocksize - offset, size);
> +			int copy = umin(sb->s_blocksize - offset, size);
>  			memcpy(bhs[i]->b_data + offset, slots, copy);
>  			mark_buffer_dirty_inode(bhs[i], dir);
>  			if (IS_DIRSYNC(dir))
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 4fc49a614fb8..f48435e586c7 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -140,8 +140,7 @@ static int fat_ioctl_fitrim(struct inode *inode, unsigned long arg)
>  	if (copy_from_user(&range, user_range, sizeof(range)))
>  		return -EFAULT;
>  
> -	range.minlen = max_t(unsigned int, range.minlen,
> -			     bdev_discard_granularity(sb->s_bdev));
> +	range.minlen = max(range.minlen, bdev_discard_granularity(sb->s_bdev));
>  
>  	err = fat_trim_fs(inode, &range);
>  	if (err < 0)
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 132f38619d70..0c9fb0db1de1 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1813,7 +1813,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  			goto out_iput;
>  
>  		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
> -		nr_bytes = min_t(unsigned, num, folio_size(folio) - folio_offset);
> +		nr_bytes = min(num, folio_size(folio) - folio_offset);
>  		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  
>  		err = fuse_copy_folio(cs, &folio, folio_offset, nr_bytes, 0);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f1ef77a0be05..f4ffa559ad26 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1252,10 +1252,8 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  static inline unsigned int fuse_wr_pages(loff_t pos, size_t len,
>  				     unsigned int max_pages)
>  {
> -	return min_t(unsigned int,
> -		     ((pos + len - 1) >> PAGE_SHIFT) -
> -		     (pos >> PAGE_SHIFT) + 1,
> -		     max_pages);
> +	return min(((pos + len - 1) >> PAGE_SHIFT) - (pos >> PAGE_SHIFT) + 1,
> +		   max_pages);
>  }
>  
>  static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
> @@ -1550,7 +1548,7 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>  			struct folio *folio = page_folio(pages[i]);
>  			unsigned int offset = start +
>  				(folio_page_idx(folio, pages[i]) << PAGE_SHIFT);
> -			unsigned int len = min_t(unsigned int, ret, PAGE_SIZE - start);
> +			unsigned int len = umin(ret, PAGE_SIZE - start);
>  
>  			ap->descs[ap->num_folios].offset = offset;
>  			ap->descs[ap->num_folios].length = len;
> diff --git a/fs/splice.c b/fs/splice.c
> index f5094b6d00a0..41ce3a4ef74f 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1467,7 +1467,7 @@ static ssize_t iter_to_pipe(struct iov_iter *from,
>  
>  		n = DIV_ROUND_UP(left + start, PAGE_SIZE);
>  		for (i = 0; i < n; i++) {
> -			int size = min_t(int, left, PAGE_SIZE - start);
> +			int size = umin(left, PAGE_SIZE - start);
>  
>  			buf.page = pages[i];
>  			buf.offset = start;
> -- 
> 2.39.5
> 

