Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7101C6CC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 11:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgEFJWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 05:22:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:49140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgEFJWP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 05:22:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C7889AB89;
        Wed,  6 May 2020 09:22:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6BED31E12B1; Wed,  6 May 2020 11:22:13 +0200 (CEST)
Date:   Wed, 6 May 2020 11:22:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        tytso@mit.edu, adilger@dilger.ca, riteshh@linux.ibm.com,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 03/11] ext4: split _ext4_fiemap
Message-ID: <20200506092213.GE17863@quack2.suse.cz>
References: <20200505154324.3226743-1-hch@lst.de>
 <20200505154324.3226743-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505154324.3226743-4-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 05-05-20 17:43:16, Christoph Hellwig wrote:
> The fiemap and EXT4_IOC_GET_ES_CACHE cases share almost no code, so split
> them into entirely separate functions.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 72 +++++++++++++++++++++++------------------------
>  1 file changed, 35 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 2b4b94542e34d..d2a2a3ba5c44a 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4854,11 +4854,9 @@ static int ext4_fiemap_check_ranges(struct inode *inode, u64 start, u64 *len)
>  	return 0;
>  }
>  
> -static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -			__u64 start, __u64 len, bool from_es_cache)
> +int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> +		u64 start, u64 len)
>  {
> -	ext4_lblk_t start_blk;
> -	u32 ext4_fiemap_flags = FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR;
>  	int error = 0;
>  
>  	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
> @@ -4868,10 +4866,7 @@ static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
>  	}
>  
> -	if (from_es_cache)
> -		ext4_fiemap_flags &= FIEMAP_FLAG_XATTR;
> -
> -	if (fiemap_check_flags(fieinfo, ext4_fiemap_flags))
> +	if (fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR))
>  		return -EBADR;
>  
>  	/*
> @@ -4885,40 +4880,20 @@ static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  
>  	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
>  		fieinfo->fi_flags &= ~FIEMAP_FLAG_XATTR;
> -		error = iomap_fiemap(inode, fieinfo, start, len,
> -				     &ext4_iomap_xattr_ops);
> -	} else if (!from_es_cache) {
> -		error = iomap_fiemap(inode, fieinfo, start, len,
> -				     &ext4_iomap_report_ops);
> -	} else {
> -		ext4_lblk_t len_blks;
> -		__u64 last_blk;
> -
> -		start_blk = start >> inode->i_sb->s_blocksize_bits;
> -		last_blk = (start + len - 1) >> inode->i_sb->s_blocksize_bits;
> -		if (last_blk >= EXT_MAX_BLOCKS)
> -			last_blk = EXT_MAX_BLOCKS-1;
> -		len_blks = ((ext4_lblk_t) last_blk) - start_blk + 1;
> -
> -		/*
> -		 * Walk the extent tree gathering extent information
> -		 * and pushing extents back to the user.
> -		 */
> -		error = ext4_fill_es_cache_info(inode, start_blk, len_blks,
> -						fieinfo);
> +		return iomap_fiemap(inode, fieinfo, start, len,
> +				    &ext4_iomap_xattr_ops);
>  	}
> -	return error;
> -}
>  
> -int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		__u64 start, __u64 len)
> -{
> -	return _ext4_fiemap(inode, fieinfo, start, len, false);
> +	return iomap_fiemap(inode, fieinfo, start, len, &ext4_iomap_report_ops);
>  }
>  
>  int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		      __u64 start, __u64 len)
>  {
> +	ext4_lblk_t start_blk, len_blks;
> +	__u64 last_blk;
> +	int error = 0;
> +
>  	if (ext4_has_inline_data(inode)) {
>  		int has_inline;
>  
> @@ -4929,9 +4904,32 @@ int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  			return 0;
>  	}
>  
> -	return _ext4_fiemap(inode, fieinfo, start, len, true);
> -}
> +	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
> +		error = ext4_ext_precache(inode);
> +		if (error)
> +			return error;
> +		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
> +	}
> +
> +	if (fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC))
> +		return -EBADR;
>  
> +	error = ext4_fiemap_check_ranges(inode, start, &len);
> +	if (error)
> +		return error;
> +
> +	start_blk = start >> inode->i_sb->s_blocksize_bits;
> +	last_blk = (start + len - 1) >> inode->i_sb->s_blocksize_bits;
> +	if (last_blk >= EXT_MAX_BLOCKS)
> +		last_blk = EXT_MAX_BLOCKS-1;
> +	len_blks = ((ext4_lblk_t) last_blk) - start_blk + 1;
> +
> +	/*
> +	 * Walk the extent tree gathering extent information
> +	 * and pushing extents back to the user.
> +	 */
> +	return ext4_fill_es_cache_info(inode, start_blk, len_blks, fieinfo);
> +}
>  
>  /*
>   * ext4_access_path:
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
