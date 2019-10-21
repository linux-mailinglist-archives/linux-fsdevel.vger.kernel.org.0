Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16ECEDED94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 15:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfJUNbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 09:31:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:50794 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727322AbfJUNbc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:31:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 17C96B70D;
        Mon, 21 Oct 2019 13:31:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1C94D1E4AA0; Mon, 21 Oct 2019 15:31:29 +0200 (CEST)
Date:   Mon, 21 Oct 2019 15:31:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 03/12] ext4: split IOMAP_WRITE branch in
 ext4_iomap_begin() into helper
Message-ID: <20191021133129.GC25184@quack2.suse.cz>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <80f6c773a80a731c5c1f5e4d8ebb75d6da58a587.1571647179.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80f6c773a80a731c5c1f5e4d8ebb75d6da58a587.1571647179.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-10-19 20:18:00, Matthew Bobrowski wrote:
> In preparation for porting across the ext4 direct I/O path for reads
> and writes over to the iomap infrastructure, split up the IOMAP_WRITE
> chunk of code into a separate helper ext4_alloc_iomap(). This way,
> when we add the necessary bits for direct I/O, we don't end up with
> ext4_iomap_begin() becoming a behemoth twisty maze.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 112 ++++++++++++++++++++++++++----------------------
>  1 file changed, 60 insertions(+), 52 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 0dd29ae5cc8c..3dc92bd8a944 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3442,6 +3442,62 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
>  	}
>  }
>  
> +static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
> +			    unsigned int flags)
> +{
> +	handle_t *handle;
> +	u8 blkbits = inode->i_blkbits;
> +	int ret, dio_credits, retries = 0;
> +
> +	/*
> +	 * Trim the mapping request to the maximum value that we can map at
> +	 * once for direct I/O.
> +	 */
> +	if (map->m_len > DIO_MAX_BLOCKS)
> +		map->m_len = DIO_MAX_BLOCKS;
> +	dio_credits = ext4_chunk_trans_blocks(inode, map->m_len);
> +
> +retry:
> +	/*
> +	 * Either we allocate blocks and then don't get an unwritten extent, so
> +	 * in that case we have reserved enough credits. Or, the blocks are
> +	 * already allocated and and unwritten. In that case, the extent
> +	 * conversion fits into the credits too.
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
> +	 * If we have allocated blocks beyond EOF, we need to ensure that
> +	 * they're truncated if we crash before updating the inode size
> +	 * metadata within ext4_iomap_end(). For faults, we don't need to do
> +	 * that (and cannot due to the orphan list operations needing an
> +	 * inode_lock()). If we happen to instantiate blocks beyond EOF, it is
> +	 * because we race with a truncate operation, which already has added
> +	 * the inode onto the orphan list.
> +	 */
> +	if (!(flags & IOMAP_FAULT) && map->m_lblk + map->m_len >
> +	    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
> +		int err;
> +
> +		err = ext4_orphan_add(handle, inode);
> +		if (err < 0)
> +			ret = err;
> +	}
> +
> +journal_stop:
> +	ext4_journal_stop(handle);
> +	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
> +		goto retry;
> +
> +	return ret;
> +}
> +
>  static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  			    unsigned flags, struct iomap *iomap)
>  {
> @@ -3502,62 +3558,14 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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
> +		ret = ext4_iomap_alloc(inode, &map, flags);
>  	} else {
>  		ret = ext4_map_blocks(NULL, inode, &map, 0);
> -		if (ret < 0)
> -			return ret;
>  	}
>  
> +	if (ret < 0)
> +		return ret;
> +
>  	ext4_set_iomap(inode, iomap, &map, offset, length);
>  	if (delalloc && iomap->type == IOMAP_HOLE)
>  		iomap->type = IOMAP_DELALLOC;
> -- 
> 2.20.1
> 
> --<M>--
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
