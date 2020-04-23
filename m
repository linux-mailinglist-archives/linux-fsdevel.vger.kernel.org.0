Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D3C1B5A5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 13:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgDWLUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 07:20:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:55254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbgDWLUR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:20:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7831EB0BE;
        Thu, 23 Apr 2020 11:20:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C072C1E1293; Thu, 23 Apr 2020 13:20:14 +0200 (CEST)
Date:   Thu, 23 Apr 2020 13:20:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger@dilger.ca, darrick.wong@oracle.com, hch@infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 5/5] ext4: Get rid of ext4_fiemap_check_ranges
Message-ID: <20200423112014.GL3737@quack2.suse.cz>
References: <cover.1587555962.git.riteshh@linux.ibm.com>
 <b2edd7710f07d94101a6055e398a5e4ed01f09bf.1587555962.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2edd7710f07d94101a6055e398a5e4ed01f09bf.1587555962.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 23-04-20 16:17:57, Ritesh Harjani wrote:
> Now that fiemap_check_ranges() is available for other filesystems
> to use, so get rid of ext4's private version.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Nice. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ioctl.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 76a2b5200ba3..6a7d7e9027cd 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -733,29 +733,6 @@ static void ext4_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
>  		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
>  }
>  
> -/* copied from fs/ioctl.c */
> -static int ext4_fiemap_check_ranges(struct super_block *sb,
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
> @@ -775,7 +752,7 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
>  	if (fiemap.fm_extent_count > FIEMAP_MAX_EXTENTS)
>  		return -EINVAL;
>  
> -	error = ext4_fiemap_check_ranges(sb, fiemap.fm_start, fiemap.fm_length,
> +	error = fiemap_check_ranges(sb, fiemap.fm_start, fiemap.fm_length,
>  				    &len);
>  	if (error)
>  		return error;
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
