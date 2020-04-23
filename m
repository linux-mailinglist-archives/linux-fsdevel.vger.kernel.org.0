Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8026A1B5A53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgDWLS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 07:18:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:54332 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbgDWLS6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:18:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3CCEEB0BF;
        Thu, 23 Apr 2020 11:18:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 151781E1293; Thu, 23 Apr 2020 13:18:56 +0200 (CEST)
Date:   Thu, 23 Apr 2020 13:18:56 +0200
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
Subject: Re: [PATCH 3/5] vfs: EXPORT_SYMBOL for fiemap_check_ranges()
Message-ID: <20200423111856.GJ3737@quack2.suse.cz>
References: <cover.1587555962.git.riteshh@linux.ibm.com>
 <58eee51755bb15c312c9d5935655a89466bd34ca.1587555962.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58eee51755bb15c312c9d5935655a89466bd34ca.1587555962.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 23-04-20 16:17:55, Ritesh Harjani wrote:
> 1. fiemap_check_ranges() is needed by ovl_fiemap() to check for ranges
> before calling underlying inode's ->fiemap() call.
> 2. With this change even ext4 can use generic fiemap_check_ranges() instead of
> having a duplicate copy of it.
> 
> So make this EXPORT_SYMBOL for use by overlayfs.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>
	
								Honza

> ---
>  fs/ioctl.c         | 5 +++--
>  include/linux/fs.h | 2 ++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 282d45be6f45..f1d93263186c 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -166,8 +166,8 @@ int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags)
>  }
>  EXPORT_SYMBOL(fiemap_check_flags);
>  
> -static int fiemap_check_ranges(struct super_block *sb,
> -			       u64 start, u64 len, u64 *new_len)
> +int fiemap_check_ranges(struct super_block *sb, u64 start, u64 len,
> +			u64 *new_len)
>  {
>  	u64 maxbytes = (u64) sb->s_maxbytes;
>  
> @@ -187,6 +187,7 @@ static int fiemap_check_ranges(struct super_block *sb,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(fiemap_check_ranges);
>  
>  static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
>  {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 4f6f59b4f22a..1ea70fe07618 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1759,6 +1759,8 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
>  			    u64 phys, u64 len, u32 flags);
>  int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags);
>  
> +int fiemap_check_ranges(struct super_block *sb, u64 start, u64 len,
> +			u64 *new_len);
>  /*
>   * This is the "filldir" function type, used by readdir() to let
>   * the kernel specify what kind of dirent layout it wants to have.
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
