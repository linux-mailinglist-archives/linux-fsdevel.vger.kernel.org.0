Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E555CF701
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 12:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfJHK1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 06:27:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:36718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729958AbfJHK1M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:27:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8F8A8ADFE;
        Tue,  8 Oct 2019 10:27:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B8ABD1E4827; Tue,  8 Oct 2019 12:27:09 +0200 (CEST)
Date:   Tue, 8 Oct 2019 12:27:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 1/8] ext4: move out iomap field population into
 separate helper
Message-ID: <20191008102709.GD5078@quack2.suse.cz>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <8b4499e47bea3841194850e1b3eeb924d87e69a5.1570100361.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b4499e47bea3841194850e1b3eeb924d87e69a5.1570100361.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-10-19 21:33:09, Matthew Bobrowski wrote:
> Separate the iomap field population chunk into a separate simple
> helper routine. This helps reducing the overall clutter within the
> ext4_iomap_begin() callback, especially as we move across more code to
> make use of iomap infrastructure.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> ---
>  fs/ext4/inode.c | 65 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 37 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 516faa280ced..1ccdc14c4d69 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3406,10 +3406,43 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
>  	return inode->i_state & I_DIRTY_DATASYNC;
>  }
>  
> +static int ext4_set_iomap(struct inode *inode, struct iomap *iomap, u16 type,
> +			  unsigned long first_block, struct ext4_map_blocks *map)
> +{
> +	u8 blkbits = inode->i_blkbits;
> +
> +	iomap->flags = 0;
> +	if (ext4_inode_datasync_dirty(inode))
> +		iomap->flags |= IOMAP_F_DIRTY;
> +	iomap->bdev = inode->i_sb->s_bdev;
> +	iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
> +	iomap->offset = (u64) first_block << blkbits;
> +	iomap->length = (u64) map->m_len << blkbits;
> +
> +	if (type) {
> +		iomap->type = type;
> +		iomap->addr = IOMAP_NULL_ADDR;
> +	} else {
> +		if (map->m_flags & EXT4_MAP_MAPPED) {
> +			iomap->type = IOMAP_MAPPED;
> +		} else if (map->m_flags & EXT4_MAP_UNWRITTEN) {
> +			iomap->type = IOMAP_UNWRITTEN;
> +		} else {
> +			WARN_ON_ONCE(1);
> +			return -EIO;
> +		}
> +		iomap->addr = (u64) map->m_pblk << blkbits;
> +	}

Looking at this function now, the 'type' argument looks a bit weird. Can we
perhaps just remove the 'type' argument and change the above to:

	if (map->m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)) {
		if (map->m_flags & EXT4_MAP_MAPPED)
			iomap->type = IOMAP_MAPPED;
		else if (map->m_flags & EXT4_MAP_UNWRITTEN)
			iomap->type = IOMAP_UNWRITTEN;
		iomap->addr = (u64) map->m_pblk << blkbits;
	} else {
		iomap->type = IOMAP_HOLE;
		iomap->addr = IOMAP_NULL_ADDR;
	}

And then in ext4_iomap_begin() we overwrite the type to:

	if (delalloc && iomap->type == IOMAP_HOLE)
		iomap->type = IOMAP_DELALLOC;

That would IMO make ext4_set_iomap() arguments harder to get wrong.

								Honza

> +
> +	if (map->m_flags & EXT4_MAP_NEW)
> +		iomap->flags |= IOMAP_F_NEW;
> +	return 0;
> +}
> +
>  static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  			    unsigned flags, struct iomap *iomap)
>  {
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +	u16 type = 0;
>  	unsigned int blkbits = inode->i_blkbits;
>  	unsigned long first_block, last_block;
>  	struct ext4_map_blocks map;
> @@ -3523,33 +3556,9 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  			return ret;
>  	}
>  
> -	iomap->flags = 0;
> -	if (ext4_inode_datasync_dirty(inode))
> -		iomap->flags |= IOMAP_F_DIRTY;
> -	iomap->bdev = inode->i_sb->s_bdev;
> -	iomap->dax_dev = sbi->s_daxdev;
> -	iomap->offset = (u64)first_block << blkbits;
> -	iomap->length = (u64)map.m_len << blkbits;
> -
> -	if (ret == 0) {
> -		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
> -		iomap->addr = IOMAP_NULL_ADDR;
> -	} else {
> -		if (map.m_flags & EXT4_MAP_MAPPED) {
> -			iomap->type = IOMAP_MAPPED;
> -		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> -			iomap->type = IOMAP_UNWRITTEN;
> -		} else {
> -			WARN_ON_ONCE(1);
> -			return -EIO;
> -		}
> -		iomap->addr = (u64)map.m_pblk << blkbits;
> -	}
> -
> -	if (map.m_flags & EXT4_MAP_NEW)
> -		iomap->flags |= IOMAP_F_NEW;
> -
> -	return 0;
> +	if (!ret)
> +		type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
> +	return ext4_set_iomap(inode, iomap, type, first_block, &map);
>  }
>  
>  static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
