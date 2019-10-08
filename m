Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F223CF70E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 12:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbfJHKbk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 06:31:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:37738 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728866AbfJHKbk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:31:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 435C5AF0B;
        Tue,  8 Oct 2019 10:31:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D2D8E1E4827; Tue,  8 Oct 2019 12:31:37 +0200 (CEST)
Date:   Tue, 8 Oct 2019 12:31:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 2/8] ext4: move out IOMAP_WRITE path into separate
 helper
Message-ID: <20191008103137.GE5078@quack2.suse.cz>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <99b317af0f20a170fba2e70695d7cca1597fb19a.1570100361.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99b317af0f20a170fba2e70695d7cca1597fb19a.1570100361.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-10-19 21:33:29, Matthew Bobrowski wrote:
> In preparation for porting across the direct I/O path to iomap, split
> out the IOMAP_WRITE logic into a separate helper. This way, we don't
> need to clutter the ext4_iomap_begin() callback.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just please reformat the comments to use full 80 column lines. Your Emacs
still doesn't seem to get it :)

								Honza

> ---
>  fs/ext4/inode.c | 110 ++++++++++++++++++++++++++----------------------
>  1 file changed, 60 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 1ccdc14c4d69..caeb3dec0dec 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3439,6 +3439,62 @@ static int ext4_set_iomap(struct inode *inode, struct iomap *iomap, u16 type,
>  	return 0;
>  }
>  
> +static int ext4_iomap_alloc(struct inode *inode,
> +			    unsigned flags,
> +			    unsigned long first_block,
> +			    struct ext4_map_blocks *map)
> +{
> +	handle_t *handle;
> +	u8 blkbits = inode->i_blkbits;
> +	int ret, dio_credits, retries = 0;
> +
> +	/*
> +	 * Trim mapping request to the maximum value that we can map
> +	 * at once for direct I/O.
> +	 */
> +	if (map->m_len > DIO_MAX_BLOCKS)
> +		map->m_len = DIO_MAX_BLOCKS;
> +	dio_credits = ext4_chunk_trans_blocks(inode, map->m_len);
> +retry:
> +	/*
> +	 * Either we allocate blocks and then we don't get unwritten
> +	 * extent so we have reserved enough credits, or the blocks
> +	 * are already allocated and unwritten. In that case, the
> +	 * extent conversion fits in the credits as well.
> +	 */
> +	handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS, dio_credits);
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +
> +	ret = ext4_map_blocks(handle, inode, map, EXT4_GET_BLOCKS_CREATE_ZERO);
> +	if (ret < 0)
> +		goto journal_stop;
> +
> +	/*
> +	 * If we have allocated blocks beyond the EOF, we need to make
> +	 * sure that they get truncate if we crash before updating the
> +	 * inode size metadata in ext4_iomap_end(). For faults, we
> +	 * don't need to do that (and cannot due to the orphan list
> +	 * operations needing an inode_lock()). If we happen to
> +	 * instantiate blocks beyond EOF, it is because we race with a
> +	 * truncate operation, which already has added the inode onto
> +	 * the orphan list.
> +	 */
> +	if (!(flags & IOMAP_FAULT) && first_block + map->m_len >
> +	    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
> +		int err;
> +
> +		err = ext4_orphan_add(handle, inode);
> +		if (err < 0)
> +			ret = err;
> +	}
> +journal_stop:
> +	ext4_journal_stop(handle);
> +	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
> +		goto retry;
> +	return ret;
> +}
> +
>  static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  			    unsigned flags, struct iomap *iomap)
>  {
> @@ -3500,62 +3556,16 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  			}
>  		}
>  	} else if (flags & IOMAP_WRITE) {
> -		int dio_credits;
> -		handle_t *handle;
> -		int retries = 0;
> -
> -		/* Trim mapping request to maximum we can map at once for DIO */
> -		if (map.m_len > DIO_MAX_BLOCKS)
> -			map.m_len = DIO_MAX_BLOCKS;
> -		dio_credits = ext4_chunk_trans_blocks(inode, map.m_len);
> -retry:
> -		/*
> -		 * Either we allocate blocks and then we don't get unwritten
> -		 * extent so we have reserved enough credits, or the blocks
> -		 * are already allocated and unwritten and in that case
> -		 * extent conversion fits in the credits as well.
> -		 */
> -		handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS,
> -					    dio_credits);
> -		if (IS_ERR(handle))
> -			return PTR_ERR(handle);
> -
> -		ret = ext4_map_blocks(handle, inode, &map,
> -				      EXT4_GET_BLOCKS_CREATE_ZERO);
> -		if (ret < 0) {
> -			ext4_journal_stop(handle);
> -			if (ret == -ENOSPC &&
> -			    ext4_should_retry_alloc(inode->i_sb, &retries))
> -				goto retry;
> -			return ret;
> -		}
> -
> -		/*
> -		 * If we added blocks beyond i_size, we need to make sure they
> -		 * will get truncated if we crash before updating i_size in
> -		 * ext4_iomap_end(). For faults we don't need to do that (and
> -		 * even cannot because for orphan list operations inode_lock is
> -		 * required) - if we happen to instantiate block beyond i_size,
> -		 * it is because we race with truncate which has already added
> -		 * the inode to the orphan list.
> -		 */
> -		if (!(flags & IOMAP_FAULT) && first_block + map.m_len >
> -		    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
> -			int err;
> -
> -			err = ext4_orphan_add(handle, inode);
> -			if (err < 0) {
> -				ext4_journal_stop(handle);
> -				return err;
> -			}
> -		}
> -		ext4_journal_stop(handle);
> +		ret = ext4_iomap_alloc(inode, flags, first_block, &map);
>  	} else {
>  		ret = ext4_map_blocks(NULL, inode, &map, 0);
>  		if (ret < 0)
>  			return ret;
>  	}
>  
> +	if (ret < 0)
> +		return ret;
> +
>  	if (!ret)
>  		type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
>  	return ext4_set_iomap(inode, iomap, type, first_block, &map);
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
