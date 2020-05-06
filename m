Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F881C6CB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 11:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgEFJSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 05:18:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:44548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgEFJSG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 05:18:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 50740B3BB;
        Wed,  6 May 2020 09:18:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6E05B1E12B1; Wed,  6 May 2020 11:18:02 +0200 (CEST)
Date:   Wed, 6 May 2020 11:18:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        tytso@mit.edu, adilger@dilger.ca, riteshh@linux.ibm.com,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 02/11] ext4: fix fiemap size checks for bitmap files
Message-ID: <20200506091802.GD17863@quack2.suse.cz>
References: <20200505154324.3226743-1-hch@lst.de>
 <20200505154324.3226743-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505154324.3226743-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 05-05-20 17:43:15, Christoph Hellwig wrote:
> Add an extra validation of the len parameter, as for ext4 some files
> might have smaller file size limits than others.  This also means the
> redundant size check in ext4_ioctl_get_es_cache can go away, as all
> size checking is done in the shared fiemap handler.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 31 +++++++++++++++++++++++++++++++
>  fs/ext4/ioctl.c   | 33 ++-------------------------------
>  2 files changed, 33 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index f2b577b315a09..2b4b94542e34d 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4832,6 +4832,28 @@ static const struct iomap_ops ext4_iomap_xattr_ops = {
>  	.iomap_begin		= ext4_iomap_xattr_begin,
>  };
>  
> +static int ext4_fiemap_check_ranges(struct inode *inode, u64 start, u64 *len)
> +{
> +	u64 maxbytes;
> +
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> +		maxbytes = inode->i_sb->s_maxbytes;
> +	else
> +		maxbytes = EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
> +
> +	if (*len == 0)
> +		return -EINVAL;
> +	if (start > maxbytes)
> +		return -EFBIG;
> +
> +	/*
> +	 * Shrink request scope to what the fs can actually handle.
> +	 */
> +	if (*len > maxbytes || (maxbytes - *len) < start)
> +		*len = maxbytes - start;
> +	return 0;
> +}
> +
>  static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  			__u64 start, __u64 len, bool from_es_cache)
>  {
> @@ -4852,6 +4874,15 @@ static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	if (fiemap_check_flags(fieinfo, ext4_fiemap_flags))
>  		return -EBADR;
>  
> +	/*
> +	 * For bitmap files the maximum size limit could be smaller than
> +	 * s_maxbytes, so check len here manually instead of just relying on the
> +	 * generic check.
> +	 */
> +	error = ext4_fiemap_check_ranges(inode, start, &len);
> +	if (error)
> +		return error;
> +
>  	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
>  		fieinfo->fi_flags &= ~FIEMAP_FLAG_XATTR;
>  		error = iomap_fiemap(inode, fieinfo, start, len,
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index bfc1281fc4cbc..0746532ba463d 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -733,29 +733,6 @@ static void ext4_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
>  		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
>  }
>  
> -/* copied from fs/ioctl.c */
> -static int fiemap_check_ranges(struct super_block *sb,
> -			       u64 start, u64 len, u64 *new_len)
> -{
> -	u64 maxbytes = (u64) sb->s_maxbytes;
> -
> -	*new_len = len;
> -
> -	if (len == 0)
> -		return -EINVAL;
> -
> -	if (start > maxbytes)
> -		return -EFBIG;
> -
> -	/*
> -	 * Shrink request scope to what the fs can actually handle.
> -	 */
> -	if (len > maxbytes || (maxbytes - len) < start)
> -		*new_len = maxbytes - start;
> -
> -	return 0;
> -}
> -
>  /* So that the fiemap access checks can't overflow on 32 bit machines. */
>  #define FIEMAP_MAX_EXTENTS	(UINT_MAX / sizeof(struct fiemap_extent))
>  
> @@ -765,8 +742,6 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
>  	struct fiemap __user *ufiemap = (struct fiemap __user *) arg;
>  	struct fiemap_extent_info fieinfo = { 0, };
>  	struct inode *inode = file_inode(filp);
> -	struct super_block *sb = inode->i_sb;
> -	u64 len;
>  	int error;
>  
>  	if (copy_from_user(&fiemap, ufiemap, sizeof(fiemap)))
> @@ -775,11 +750,6 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
>  	if (fiemap.fm_extent_count > FIEMAP_MAX_EXTENTS)
>  		return -EINVAL;
>  
> -	error = fiemap_check_ranges(sb, fiemap.fm_start, fiemap.fm_length,
> -				    &len);
> -	if (error)
> -		return error;
> -
>  	fieinfo.fi_flags = fiemap.fm_flags;
>  	fieinfo.fi_extents_max = fiemap.fm_extent_count;
>  	fieinfo.fi_extents_start = ufiemap->fm_extents;
> @@ -792,7 +762,8 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
>  	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
>  		filemap_write_and_wait(inode->i_mapping);
>  
> -	error = ext4_get_es_cache(inode, &fieinfo, fiemap.fm_start, len);
> +	error = ext4_get_es_cache(inode, &fieinfo, fiemap.fm_start,
> +			fiemap.fm_length);
>  	fiemap.fm_flags = fieinfo.fi_flags;
>  	fiemap.fm_mapped_extents = fieinfo.fi_extents_mapped;
>  	if (copy_to_user(ufiemap, &fiemap, sizeof(fiemap)))
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
