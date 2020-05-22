Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B0B1DE4A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 12:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgEVKlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 06:41:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:59102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728703AbgEVKlO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 06:41:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DD063ACA5;
        Fri, 22 May 2020 10:41:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 02B971E126B; Fri, 22 May 2020 12:41:10 +0200 (CEST)
Date:   Fri, 22 May 2020 12:41:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 4/8] fs/ext4: Update ext4_should_use_dax()
Message-ID: <20200522104109.GB14199@quack2.suse.cz>
References: <20200521191313.261929-1-ira.weiny@intel.com>
 <20200521191313.261929-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521191313.261929-5-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-05-20 12:13:09, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> S_DAX should only be enabled when the underlying block device supports
> dax.
> 
> Cache the underlying support for DAX in the super block and modify
> ext4_should_use_dax() to check for device support prior to the over
> riding mount option.
> 
> While we are at it change the function to ext4_should_enable_dax() as
> this better reflects the ask as well as matches xfs.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> 
> ---
> Changes from V3:
> 	Add a sb DAX supported flag for performance
> 
> Changes from RFC
> 	Change function name to 'should enable'
> 	Clean up bool conversion
> 	Reorder this for better bisect-ability
> ---
>  fs/ext4/ext4.h  |  1 +
>  fs/ext4/inode.c | 15 ++++++++++-----
>  fs/ext4/super.c |  5 ++++-
>  3 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 1a3daf2d18ef..0b4db9ce7756 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1979,6 +1979,7 @@ static inline bool ext4_has_incompat_features(struct super_block *sb)
>   */
>  #define EXT4_FLAGS_RESIZING	0
>  #define EXT4_FLAGS_SHUTDOWN	1
> +#define EXT4_FLAGS_BDEV_IS_DAX	2
>  
>  static inline int ext4_forced_shutdown(struct ext4_sb_info *sbi)
>  {
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index a10ff12194db..6532870f6a0b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4398,10 +4398,10 @@ int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
>  		!ext4_test_inode_state(inode, EXT4_STATE_XATTR));
>  }
>  
> -static bool ext4_should_use_dax(struct inode *inode)
> +static bool ext4_should_enable_dax(struct inode *inode)
>  {
> -	if (!test_opt(inode->i_sb, DAX_ALWAYS))
> -		return false;
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +
>  	if (!S_ISREG(inode->i_mode))
>  		return false;
>  	if (ext4_should_journal_data(inode))
> @@ -4412,7 +4412,12 @@ static bool ext4_should_use_dax(struct inode *inode)
>  		return false;
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_VERITY))
>  		return false;
> -	return true;
> +	if (!test_bit(EXT4_FLAGS_BDEV_IS_DAX, &sbi->s_ext4_flags))
> +		return false;
> +	if (test_opt(inode->i_sb, DAX_ALWAYS))
> +		return true;
> +
> +	return false;
>  }
>  
>  void ext4_set_inode_flags(struct inode *inode)
> @@ -4430,7 +4435,7 @@ void ext4_set_inode_flags(struct inode *inode)
>  		new_fl |= S_NOATIME;
>  	if (flags & EXT4_DIRSYNC_FL)
>  		new_fl |= S_DIRSYNC;
> -	if (ext4_should_use_dax(inode))
> +	if (ext4_should_enable_dax(inode))
>  		new_fl |= S_DAX;
>  	if (flags & EXT4_ENCRYPT_FL)
>  		new_fl |= S_ENCRYPTED;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 7b99c44d0a91..f7d76dcaedfe 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4092,13 +4092,16 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  		goto failed_mount;
>  	}
>  
> +	if (bdev_dax_supported(sb->s_bdev, blocksize))
> +		set_bit(EXT4_FLAGS_BDEV_IS_DAX, &sbi->s_ext4_flags);
> +
>  	if (sbi->s_mount_opt & EXT4_MOUNT_DAX_ALWAYS) {
>  		if (ext4_has_feature_inline_data(sb)) {
>  			ext4_msg(sb, KERN_ERR, "Cannot use DAX on a filesystem"
>  					" that may contain inline data");
>  			goto failed_mount;
>  		}
> -		if (!bdev_dax_supported(sb->s_bdev, blocksize)) {
> +		if (!test_bit(EXT4_FLAGS_BDEV_IS_DAX, &sbi->s_ext4_flags)) {
>  			ext4_msg(sb, KERN_ERR,
>  				"DAX unsupported by block device.");
>  			goto failed_mount;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
