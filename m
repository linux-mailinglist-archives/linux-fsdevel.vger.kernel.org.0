Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C5125842
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 01:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfLSAMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 19:12:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfLSAMo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 19:12:44 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 901942176D;
        Thu, 19 Dec 2019 00:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576714362;
        bh=t9eobqLU5zZnDpTX9F8DnN3q6+imrU5dEKYtoOZPHA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0TCswugXuHO49ooSCJVbRrpCPYkIxqkA3hkl9ik586Z+1nH9t9mtmBX04drzQ90F+
         10xVzVc/81szaOrGUrl89TpEoW6yzcPKqpr5ip53Vz38VE2l7z4LLKXLtm8YdJ7iHx
         O7fZxCX3iMQgSx5jxMyNuEsRtDa7tI/BttV1qs+Q=
Date:   Wed, 18 Dec 2019 16:12:41 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 9/9] ext4: add inline encryption support
Message-ID: <20191219001240.GD47399@gmail.com>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-10-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218145136.172774-10-satyat@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+Cc linux-ext4]

On Wed, Dec 18, 2019 at 06:51:36AM -0800, Satya Tangirala wrote:
> Wire up ext4 to support inline encryption via the helper functions which
> fs/crypto/ now provides.  This includes:
> 
> - Adding a mount option 'inlinecrypt' which enables inline encryption
>   on encrypted files where it can be used.
> 
> - Setting the bio_crypt_ctx on bios that will be submitted to an
>   inline-encrypted file.
> 
>   Note: submit_bh_wbc() in fs/buffer.c also needed to be patched for
>   this part, since ext4 sometimes uses ll_rw_block() on file data.
> 
> - Not adding logically discontiguous data to bios that will be submitted
>   to an inline-encrypted file.
> 
> - Not doing filesystem-layer crypto on inline-encrypted files.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>

In the next version can you please add linux-ext4 to Cc for the series?

> ---
>  fs/buffer.c        |  2 ++
>  fs/ext4/ext4.h     |  1 +
>  fs/ext4/inode.c    |  4 ++--
>  fs/ext4/page-io.c  |  6 ++++--
>  fs/ext4/readpage.c | 11 ++++++++---
>  fs/ext4/super.c    | 13 +++++++++++++
>  6 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index d8c7242426bb..3ad000db4a19 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -3108,6 +3108,8 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
>  	 */
>  	bio = bio_alloc(GFP_NOIO, 1);
>  
> +	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
> +
>  	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
>  	bio_set_dev(bio, bh->b_bdev);
>  	bio->bi_write_hint = write_hint;

In 5.5, there was some decryption code added to fs/buffer.c in order to support
ext4 encryption with blocksize < PAGE_SIZE:

static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
{
        /* Decrypt if needed */
        if (uptodate && IS_ENABLED(CONFIG_FS_ENCRYPTION) &&
            IS_ENCRYPTED(bh->b_page->mapping->host) &&
            S_ISREG(bh->b_page->mapping->host->i_mode)) {
	...


This needs to be updated to use fscrypt_inode_uses_fs_layer_crypto() instead, so
that the filesystem-layer decryption is not done when the file is already using
inline decryption.

> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index f8578caba40d..aeaa01724d7c 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1153,6 +1153,7 @@ struct ext4_inode_info {
>  #define EXT4_MOUNT_JOURNAL_CHECKSUM	0x800000 /* Journal checksums */
>  #define EXT4_MOUNT_JOURNAL_ASYNC_COMMIT	0x1000000 /* Journal Async Commit */
>  #define EXT4_MOUNT_WARN_ON_ERROR	0x2000000 /* Trigger WARN_ON on error */
> +#define EXT4_MOUNT_INLINECRYPT		0x4000000 /* Inline encryption support */
>  #define EXT4_MOUNT_DELALLOC		0x8000000 /* Delalloc support */
>  #define EXT4_MOUNT_DATA_ERR_ABORT	0x10000000 /* Abort on file data write */
>  #define EXT4_MOUNT_BLOCK_VALIDITY	0x20000000 /* Block validity checking */
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 28f28de0c1b6..44d9651b8638 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1090,7 +1090,7 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
>  	}
>  	if (unlikely(err)) {
>  		page_zero_new_buffers(page, from, to);
> -	} else if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode)) {
> +	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
>  		for (i = 0; i < nr_wait; i++) {
>  			int err2;
>  
> @@ -3698,7 +3698,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
>  		/* Uhhuh. Read error. Complain and punt. */
>  		if (!buffer_uptodate(bh))
>  			goto unlock;
> -		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode)) {
> +		if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
>  			/* We expect the key to be set. */
>  			BUG_ON(!fscrypt_has_encryption_key(inode));
>  			WARN_ON_ONCE(fscrypt_decrypt_pagecache_blocks(
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 24aeedb8fc75..acde754cc5ca 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -404,6 +404,7 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
>  	 * __GFP_DIRECT_RECLAIM is set, see comments for bio_alloc_bioset().
>  	 */
>  	bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
> +	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
>  	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
>  	bio_set_dev(bio, bh->b_bdev);
>  	bio->bi_end_io = ext4_end_bio;
> @@ -420,7 +421,8 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
>  {
>  	int ret;
>  
> -	if (io->io_bio && bh->b_blocknr != io->io_next_block) {
> +	if (io->io_bio && (bh->b_blocknr != io->io_next_block ||
> +			   !fscrypt_mergeable_bio_bh(io->io_bio, bh))) {
>  submit_and_retry:
>  		ext4_io_submit(io);
>  	}
> @@ -508,7 +510,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  	 * (e.g. holes) to be unnecessarily encrypted, but this is rare and
>  	 * can't happen in the common case of blocksize == PAGE_SIZE.
>  	 */
> -	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) && nr_to_submit) {
> +	if (fscrypt_inode_uses_fs_layer_crypto(inode) && nr_to_submit) {
>  		gfp_t gfp_flags = GFP_NOFS;
>  		unsigned int enc_bytes = round_up(len, i_blocksize(inode));
>  
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index fef7755300c3..7844e27518b4 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -183,7 +183,7 @@ static struct bio_post_read_ctx *get_bio_post_read_ctx(struct inode *inode,
>  	unsigned int post_read_steps = 0;
>  	struct bio_post_read_ctx *ctx = NULL;
>  
> -	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
> +	if (fscrypt_inode_uses_fs_layer_crypto(inode))
>  		post_read_steps |= 1 << STEP_DECRYPT;
>  
>  	if (ext4_need_verity(inode, first_idx))
> @@ -220,6 +220,7 @@ int ext4_mpage_readpages(struct address_space *mapping,
>  	const unsigned blkbits = inode->i_blkbits;
>  	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
>  	const unsigned blocksize = 1 << blkbits;
> +	sector_t next_block;
>  	sector_t block_in_file;
>  	sector_t last_block;
>  	sector_t last_block_in_file;
> @@ -252,7 +253,8 @@ int ext4_mpage_readpages(struct address_space *mapping,
>  		if (page_has_buffers(page))
>  			goto confused;
>  
> -		block_in_file = (sector_t)page->index << (PAGE_SHIFT - blkbits);
> +		block_in_file = next_block =
> +			(sector_t)page->index << (PAGE_SHIFT - blkbits);
>  		last_block = block_in_file + nr_pages * blocks_per_page;
>  		last_block_in_file = (ext4_readpage_limit(inode) +
>  				      blocksize - 1) >> blkbits;
> @@ -352,7 +354,8 @@ int ext4_mpage_readpages(struct address_space *mapping,
>  		 * This page will go to BIO.  Do we need to send this
>  		 * BIO off first?
>  		 */
> -		if (bio && (last_block_in_bio != blocks[0] - 1)) {
> +		if (bio && (last_block_in_bio != blocks[0] - 1 ||
> +			    !fscrypt_mergeable_bio(bio, inode, next_block))) {
>  		submit_and_realloc:
>  			submit_bio(bio);
>  			bio = NULL;
> @@ -366,6 +369,8 @@ int ext4_mpage_readpages(struct address_space *mapping,
>  			 */
>  			bio = bio_alloc(GFP_KERNEL,
>  				min_t(int, nr_pages, BIO_MAX_PAGES));
> +			fscrypt_set_bio_crypt_ctx(bio, inode, next_block,
> +						  GFP_KERNEL);
>  			ctx = get_bio_post_read_ctx(inode, bio, page->index);
>  			if (IS_ERR(ctx)) {
>  				bio_put(bio);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 1d82b56d9b11..0a6b60620942 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1357,6 +1357,11 @@ static void ext4_get_ino_and_lblk_bits(struct super_block *sb,
>  	*lblk_bits_ret = 8 * sizeof(ext4_lblk_t);
>  }
>  
> +static bool ext4_inline_crypt_enabled(struct super_block *sb)
> +{
> +	return test_opt(sb, INLINECRYPT);
> +}
> +
>  static const struct fscrypt_operations ext4_cryptops = {
>  	.key_prefix		= "ext4:",
>  	.get_context		= ext4_get_context,
> @@ -1366,6 +1371,7 @@ static const struct fscrypt_operations ext4_cryptops = {
>  	.max_namelen		= EXT4_NAME_LEN,
>  	.has_stable_inodes	= ext4_has_stable_inodes,
>  	.get_ino_and_lblk_bits	= ext4_get_ino_and_lblk_bits,
> +	.inline_crypt_enabled	= ext4_inline_crypt_enabled,
>  };
>  #endif
>  
> @@ -1460,6 +1466,7 @@ enum {
>  	Opt_journal_path, Opt_journal_checksum, Opt_journal_async_commit,
>  	Opt_abort, Opt_data_journal, Opt_data_ordered, Opt_data_writeback,
>  	Opt_data_err_abort, Opt_data_err_ignore, Opt_test_dummy_encryption,
> +	Opt_inlinecrypt,
>  	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
>  	Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_jqfmt_vfsv1, Opt_quota,
>  	Opt_noquota, Opt_barrier, Opt_nobarrier, Opt_err,
> @@ -1556,6 +1563,7 @@ static const match_table_t tokens = {
>  	{Opt_noinit_itable, "noinit_itable"},
>  	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
>  	{Opt_test_dummy_encryption, "test_dummy_encryption"},
> +	{Opt_inlinecrypt, "inlinecrypt"},
>  	{Opt_nombcache, "nombcache"},
>  	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
>  	{Opt_removed, "check=none"},	/* mount option from ext2/3 */
> @@ -1767,6 +1775,11 @@ static const struct mount_opts {
>  	{Opt_jqfmt_vfsv1, QFMT_VFS_V1, MOPT_QFMT},
>  	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
>  	{Opt_test_dummy_encryption, 0, MOPT_GTE0},
> +#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
> +	{Opt_inlinecrypt, EXT4_MOUNT_INLINECRYPT, MOPT_SET},
> +#else
> +	{Opt_inlinecrypt, EXT4_MOUNT_INLINECRYPT, MOPT_NOSUPPORT},
> +#endif
>  	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
>  	{Opt_err, 0, 0}
>  };

On v5 there was a discussion about using a flag like SB_INLINECRYPT to replace
the ->inline_crypt_enabled() function.  Was this considered?

- Eric
