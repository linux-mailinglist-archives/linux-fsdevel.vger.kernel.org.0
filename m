Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE624CF755
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 12:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfJHKmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 06:42:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:42794 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729876AbfJHKmM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:42:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64D21AF0B;
        Tue,  8 Oct 2019 10:42:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CAA9A1E4827; Tue,  8 Oct 2019 12:42:09 +0200 (CEST)
Date:   Tue, 8 Oct 2019 12:42:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 3/8] ext4: introduce new callback for IOMAP_REPORT
 operations
Message-ID: <20191008104209.GF5078@quack2.suse.cz>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <cb2dcb6970da1b53bdf85583f13ba2aaf1684e96.1570100361.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb2dcb6970da1b53bdf85583f13ba2aaf1684e96.1570100361.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-10-19 21:33:45, Matthew Bobrowski wrote:
> As part of ext4_iomap_begin() cleanups and port across direct I/O path
> to make use of iomap infrastructure, we split IOMAP_REPORT operations
> into a separate ->iomap_begin() handler.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

It would just need small adjustments if you change patch 1 as I suggested:

> +static u16 ext4_iomap_check_delalloc(struct inode *inode,
> +				     struct ext4_map_blocks *map)
> +{
> +	struct extent_status es;
> +	ext4_lblk_t end = map->m_lblk + map->m_len - 1;
> +
> +	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, map->m_lblk,
> +				  end, &es);
> +
> +	/* Entire range is a hole */
> +	if (!es.es_len || es.es_lblk > end)
> +		return IOMAP_HOLE;
> +	if (es.es_lblk <= map->m_lblk) {
> +		ext4_lblk_t offset = 0;
> +
> +		if (es.es_lblk < map->m_lblk)
> +			offset = map->m_lblk - es.es_lblk;
> +		map->m_lblk = es.es_lblk + offset;
> +		map->m_len = es.es_len - offset;
> +		return IOMAP_DELALLOC;
> +	}
> +
> +	/* Range starts with a hole */
> +	map->m_len = es.es_lblk - map->m_lblk;
> +	return IOMAP_HOLE;
> +}

This function would then be IMO better off to directly update 'iomap' as
needed after ext4_set_iomap() sets hole there.

								Honza

> +
> +static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
> +				   loff_t length, unsigned flags,
> +				   struct iomap *iomap)
> +{
> +	int ret;
> +	u16 type = 0;
> +	struct ext4_map_blocks map;
> +	u8 blkbits = inode->i_blkbits;
> +	unsigned long first_block, last_block;
> +
> +	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
> +		return -EINVAL;
> +	first_block = offset >> blkbits;
> +	last_block = min_t(loff_t, (offset + length - 1) >> blkbits,
> +			   EXT4_MAX_LOGICAL_BLOCK);
> +
> +	if (ext4_has_inline_data(inode)) {
> +		ret = ext4_inline_data_iomap(inode, iomap);
> +		if (ret != -EAGAIN) {
> +			if (ret == 0 && offset >= iomap->length)
> +				ret = -ENOENT;
> +			return ret;
> +		}
> +	}
> +
> +	map.m_lblk = first_block;
> +	map.m_len = last_block = first_block + 1;
> +	ret = ext4_map_blocks(NULL, inode, &map, 0);
> +	if (ret < 0)
> +		return ret;
> +	if (ret == 0)
> +		type = ext4_iomap_check_delalloc(inode, &map);
> +	return ext4_set_iomap(inode, iomap, type, first_block, &map);
> +}
> +
> +const struct iomap_ops ext4_iomap_report_ops = {
> +	.iomap_begin = ext4_iomap_begin_report,
> +};
> +
>  static int ext4_iomap_alloc(struct inode *inode,
>  			    unsigned flags,
>  			    unsigned long first_block,
> @@ -3498,12 +3564,10 @@ static int ext4_iomap_alloc(struct inode *inode,
>  static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  			    unsigned flags, struct iomap *iomap)
>  {
> -	u16 type = 0;
> -	unsigned int blkbits = inode->i_blkbits;
> -	unsigned long first_block, last_block;
> -	struct ext4_map_blocks map;
> -	bool delalloc = false;
>  	int ret;
> +	struct ext4_map_blocks map;
> +	u8 blkbits = inode->i_blkbits;
> +	unsigned long first_block, last_block;
>  
>  	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>  		return -EINVAL;
> @@ -3511,64 +3575,21 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	last_block = min_t(loff_t, (offset + length - 1) >> blkbits,
>  			   EXT4_MAX_LOGICAL_BLOCK);
>  
> -	if (flags & IOMAP_REPORT) {
> -		if (ext4_has_inline_data(inode)) {
> -			ret = ext4_inline_data_iomap(inode, iomap);
> -			if (ret != -EAGAIN) {
> -				if (ret == 0 && offset >= iomap->length)
> -					ret = -ENOENT;
> -				return ret;
> -			}
> -		}
> -	} else {
> -		if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
> -			return -ERANGE;
> -	}
> +	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
> +		return -ERANGE;
>  
>  	map.m_lblk = first_block;
>  	map.m_len = last_block - first_block + 1;
>  
> -	if (flags & IOMAP_REPORT) {
> -		ret = ext4_map_blocks(NULL, inode, &map, 0);
> -		if (ret < 0)
> -			return ret;
> -
> -		if (ret == 0) {
> -			ext4_lblk_t end = map.m_lblk + map.m_len - 1;
> -			struct extent_status es;
> -
> -			ext4_es_find_extent_range(inode, &ext4_es_is_delayed,
> -						  map.m_lblk, end, &es);
> -
> -			if (!es.es_len || es.es_lblk > end) {
> -				/* entire range is a hole */
> -			} else if (es.es_lblk > map.m_lblk) {
> -				/* range starts with a hole */
> -				map.m_len = es.es_lblk - map.m_lblk;
> -			} else {
> -				ext4_lblk_t offs = 0;
> -
> -				if (es.es_lblk < map.m_lblk)
> -					offs = map.m_lblk - es.es_lblk;
> -				map.m_lblk = es.es_lblk + offs;
> -				map.m_len = es.es_len - offs;
> -				delalloc = true;
> -			}
> -		}
> -	} else if (flags & IOMAP_WRITE) {
> +	if (flags & IOMAP_WRITE)
>  		ret = ext4_iomap_alloc(inode, flags, first_block, &map);
> -	} else {
> +	else
>  		ret = ext4_map_blocks(NULL, inode, &map, 0);
> -		if (ret < 0)
> -			return ret;
> -	}
>  
>  	if (ret < 0)
>  		return ret;
> -
> -	if (!ret)
> -		type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
> -	return ext4_set_iomap(inode, iomap, type, first_block, &map);
> +	return ext4_set_iomap(inode, iomap, ret ? 0 : IOMAP_HOLE, first_block,
> +			      &map);
>  }
>  
>  static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
