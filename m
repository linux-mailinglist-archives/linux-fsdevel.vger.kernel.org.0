Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D0C1D115C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 13:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgEMLau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 07:30:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:42032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730064AbgEMLat (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 07:30:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 13B3EAF76;
        Wed, 13 May 2020 11:30:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BDAE31E12AE; Wed, 13 May 2020 13:30:46 +0200 (CEST)
Date:   Wed, 13 May 2020 13:30:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] fs/ext4: Update ext4_should_use_dax()
Message-ID: <20200513113046.GE27709@quack2.suse.cz>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
 <20200513054324.2138483-6-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513054324.2138483-6-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 12-05-20 22:43:20, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> S_DAX should only be enabled when the underlying block device supports
> dax.
> 
> Change ext4_should_use_dax() to check for device support prior to the
> over riding mount option.
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
> Changes from RFC
> 	Change function name to 'should enable'
> 	Clean up bool conversion
> 	Reorder this for better bisect-ability
> ---
>  fs/ext4/inode.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index a10ff12194db..d3a4c2ed7a1c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4398,10 +4398,8 @@ int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
>  		!ext4_test_inode_state(inode, EXT4_STATE_XATTR));
>  }
>  
> -static bool ext4_should_use_dax(struct inode *inode)
> +static bool ext4_should_enable_dax(struct inode *inode)
>  {
> -	if (!test_opt(inode->i_sb, DAX_ALWAYS))
> -		return false;
>  	if (!S_ISREG(inode->i_mode))
>  		return false;
>  	if (ext4_should_journal_data(inode))
> @@ -4412,7 +4410,13 @@ static bool ext4_should_use_dax(struct inode *inode)
>  		return false;
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_VERITY))
>  		return false;
> -	return true;
> +	if (!bdev_dax_supported(inode->i_sb->s_bdev,
> +				inode->i_sb->s_blocksize))
> +		return false;
> +	if (test_opt(inode->i_sb, DAX_ALWAYS))
> +		return true;
> +
> +	return false;
>  }
>  
>  void ext4_set_inode_flags(struct inode *inode)
> @@ -4430,7 +4434,7 @@ void ext4_set_inode_flags(struct inode *inode)
>  		new_fl |= S_NOATIME;
>  	if (flags & EXT4_DIRSYNC_FL)
>  		new_fl |= S_DIRSYNC;
> -	if (ext4_should_use_dax(inode))
> +	if (ext4_should_enable_dax(inode))
>  		new_fl |= S_DAX;
>  	if (flags & EXT4_ENCRYPT_FL)
>  		new_fl |= S_ENCRYPTED;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
