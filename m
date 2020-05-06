Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97781C6CE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 11:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgEFJ1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 05:27:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:54846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbgEFJ1a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 05:27:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A05D9B167;
        Wed,  6 May 2020 09:27:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4E1A31E12B1; Wed,  6 May 2020 11:27:28 +0200 (CEST)
Date:   Wed, 6 May 2020 11:27:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        tytso@mit.edu, adilger@dilger.ca, riteshh@linux.ibm.com,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 05/11] fs: mark __generic_block_fiemap static
Message-ID: <20200506092728.GG17863@quack2.suse.cz>
References: <20200505154324.3226743-1-hch@lst.de>
 <20200505154324.3226743-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505154324.3226743-6-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 05-05-20 17:43:18, Christoph Hellwig wrote:
> There is no caller left outside of ioctl.c.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ioctl.c         | 4 +---
>  include/linux/fs.h | 4 ----
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 5e80b40bc1b5c..8fe5131b1deea 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -307,8 +307,7 @@ static inline loff_t blk_to_logical(struct inode *inode, sector_t blk)
>   * If you use this function directly, you need to do your own locking. Use
>   * generic_block_fiemap if you want the locking done for you.
>   */
> -
> -int __generic_block_fiemap(struct inode *inode,
> +static int __generic_block_fiemap(struct inode *inode,
>  			   struct fiemap_extent_info *fieinfo, loff_t start,
>  			   loff_t len, get_block_t *get_block)
>  {
> @@ -453,7 +452,6 @@ int __generic_block_fiemap(struct inode *inode,
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL(__generic_block_fiemap);
>  
>  /**
>   * generic_block_fiemap - FIEMAP for block based inodes
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 45cc10cdf6ddd..69b7619eb83d0 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3299,10 +3299,6 @@ static inline int vfs_fstat(int fd, struct kstat *stat)
>  extern const char *vfs_get_link(struct dentry *, struct delayed_call *);
>  extern int vfs_readlink(struct dentry *, char __user *, int);
>  
> -extern int __generic_block_fiemap(struct inode *inode,
> -				  struct fiemap_extent_info *fieinfo,
> -				  loff_t start, loff_t len,
> -				  get_block_t *get_block);
>  extern int generic_block_fiemap(struct inode *inode,
>  				struct fiemap_extent_info *fieinfo, u64 start,
>  				u64 len, get_block_t *get_block);
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
