Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC897D8B9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 10:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfJPIqN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 04:46:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:50028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726640AbfJPIqN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:46:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E765B165;
        Wed, 16 Oct 2019 08:46:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 36B371E3BDE; Wed, 16 Oct 2019 10:46:11 +0200 (CEST)
Date:   Wed, 16 Oct 2019 10:46:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        tytso@mit.edu, mbobrowski@mbobrowski.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/2] ext4: Move ext4_fiemap to iomap infrastructure
Message-ID: <20191016084611.GB30337@quack2.suse.cz>
References: <20190820130634.25954-1-riteshh@linux.ibm.com>
 <20190820130634.25954-3-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820130634.25954-3-riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 20-08-19 18:36:34, Ritesh Harjani wrote:
> This moves ext4_fiemap to use iomap infrastructure.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Thanks for the patch. I like how it removes lots of code :) The patch looks
good to me, just two small comments below. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> +static int ext4_xattr_iomap_fiemap(struct inode *inode, struct iomap *iomap)
>  {
> -	__u64 physical = 0;
> -	__u64 length;
> -	__u32 flags = FIEMAP_EXTENT_LAST;
> +	u64 physical = 0;
> +	u64 length;
>  	int blockbits = inode->i_sb->s_blocksize_bits;
> -	int error = 0;
> +	int ret = 0;
>  
>  	/* in-inode? */
>  	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
>  		struct ext4_iloc iloc;
> -		int offset;	/* offset of xattr in inode */
> +		int offset;     /* offset of xattr in inode */
>  
> -		error = ext4_get_inode_loc(inode, &iloc);
> -		if (error)
> -			return error;
> +		ret = ext4_get_inode_loc(inode, &iloc);
> +		if (ret)
> +			goto out;
>  		physical = (__u64)iloc.bh->b_blocknr << blockbits;
>  		offset = EXT4_GOOD_OLD_INODE_SIZE +
>  				EXT4_I(inode)->i_extra_isize;

Hum, I see you've just copied this from the old code but this actually
won't give full information for FIEMAP of inode with extended attribute
inodes. Not something you need to fix for your patch but I wanted to
mention this so that it doesn't get lost.

>  		physical += offset;
>  		length = EXT4_SB(inode->i_sb)->s_inode_size - offset;
> -		flags |= FIEMAP_EXTENT_DATA_INLINE;
>  		brelse(iloc.bh);
>  	} else { /* external block */
>  		physical = (__u64)EXT4_I(inode)->i_file_acl << blockbits;
>  		length = inode->i_sb->s_blocksize;
>  	}
>  
> -	if (physical)
> -		error = fiemap_fill_next_extent(fieinfo, 0, physical,
> -						length, flags);
> -	return (error < 0 ? error : 0);
> +	iomap->addr = physical;
> +	iomap->offset = 0;
> +	iomap->length = length;
> +	iomap->type = IOMAP_INLINE;
> +	iomap->flags = 0;
> +out:
> +	return ret;
>  }

...

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d6a34214e9df..92705e99e07c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3581,15 +3581,24 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
>  		iomap->addr = IOMAP_NULL_ADDR;
>  	} else {
> -		if (map.m_flags & EXT4_MAP_MAPPED) {
> -			iomap->type = IOMAP_MAPPED;
> -		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> +		/*
> +		 * There can be a case where map.m_flags may
> +		 * have both EXT4_MAP_UNWRITTEN & EXT4_MAP_MERGED
> +		 * set. This is when we do fallocate first and
> +		 * then try to write to that area, then it may have
> +		 * both flags set. So check for unwritten first.
> +		 */
> +		if (map.m_flags & EXT4_MAP_UNWRITTEN) {
>  			iomap->type = IOMAP_UNWRITTEN;
> +		} else if (map.m_flags & EXT4_MAP_MAPPED) {
> +			iomap->type = IOMAP_MAPPED;

This should be already part of Matthew's series so once you rebase on top
of it, you can just drop this hunk.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
