Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64543CF81A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 13:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfJHL1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 07:27:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:38226 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730648AbfJHL1J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:27:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 30797AE35;
        Tue,  8 Oct 2019 11:27:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E2D341E4827; Tue,  8 Oct 2019 13:27:06 +0200 (CEST)
Date:   Tue, 8 Oct 2019 13:27:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 6/8] ext4: move inode extension checks out from
 ext4_iomap_alloc()
Message-ID: <20191008112706.GI5078@quack2.suse.cz>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <d1ca9cc472175760ef629fb66a88f0c9b0625052.1570100361.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1ca9cc472175760ef629fb66a88f0c9b0625052.1570100361.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-10-19 21:34:36, Matthew Bobrowski wrote:
> We lift the inode extension/orphan list handling logic out from
> ext4_iomap_alloc() and place it within the caller
> ext4_dax_write_iter().
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/file.c  | 17 +++++++++++++++++
>  fs/ext4/inode.c | 22 ----------------------
>  2 files changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 2883711e8a33..f64da0c590b2 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -309,6 +309,7 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	ssize_t ret;
>  	size_t count;
>  	loff_t offset;
> +	handle_t *handle;
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  
>  	if (!inode_trylock(inode)) {
> @@ -328,6 +329,22 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  
>  	offset = iocb->ki_pos;
>  	count = iov_iter_count(from);
> +
> +	if (offset + count > EXT4_I(inode)->i_disksize) {
> +		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> +		if (IS_ERR(handle)) {
> +			ret = PTR_ERR(handle);
> +			goto out;
> +		}
> +
> +		ret = ext4_orphan_add(handle, inode);
> +		if (ret) {
> +			ext4_journal_stop(handle);
> +			goto out;
> +		}
> +		ext4_journal_stop(handle);
> +	}
> +
>  	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
>  
>  	error = ext4_handle_inode_extension(inode, offset, ret, count);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d616062b603e..e133dda55063 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3508,7 +3508,6 @@ static int ext4_iomap_alloc(struct inode *inode,
>  			    struct ext4_map_blocks *map)
>  {
>  	handle_t *handle;
> -	u8 blkbits = inode->i_blkbits;
>  	int ret, dio_credits, retries = 0;
>  
>  	/*
> @@ -3530,28 +3529,7 @@ static int ext4_iomap_alloc(struct inode *inode,
>  		return PTR_ERR(handle);
>  
>  	ret = ext4_map_blocks(handle, inode, map, EXT4_GET_BLOCKS_CREATE_ZERO);
> -	if (ret < 0)
> -		goto journal_stop;
>  
> -	/*
> -	 * If we have allocated blocks beyond the EOF, we need to make
> -	 * sure that they get truncate if we crash before updating the
> -	 * inode size metadata in ext4_iomap_end(). For faults, we
> -	 * don't need to do that (and cannot due to the orphan list
> -	 * operations needing an inode_lock()). If we happen to
> -	 * instantiate blocks beyond EOF, it is because we race with a
> -	 * truncate operation, which already has added the inode onto
> -	 * the orphan list.
> -	 */
> -	if (!(flags & IOMAP_FAULT) && first_block + map->m_len >
> -	    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
> -		int err;
> -
> -		err = ext4_orphan_add(handle, inode);
> -		if (err < 0)
> -			ret = err;
> -	}
> -journal_stop:
>  	ext4_journal_stop(handle);
>  	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
>  		goto retry;
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
