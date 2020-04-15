Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357901AA946
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 16:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636375AbgDON6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 09:58:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:38180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633783AbgDON6h (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:58:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 08777AC19;
        Wed, 15 Apr 2020 13:58:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8E38D1E1250; Wed, 15 Apr 2020 15:58:34 +0200 (CEST)
Date:   Wed, 15 Apr 2020 15:58:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 6/8] fs/ext4: Update ext4_should_use_dax()
Message-ID: <20200415135834.GI6126@quack2.suse.cz>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-7-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414040030.1802884-7-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 13-04-20 21:00:28, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Change the logic of ext4_should_use_dax() to support using the inode dax
> flag OR the overriding tri-state mount option.
> 
> While we are at it change the function to ext4_enable_dax() as this
> better reflects the ask.

I disagree with the renaming. ext4_enable_dax() suggests it enables
something. It does not. I'd either leave ext4_should_use_dax() or maybe
change it to ext4_should_enable_dax() if you really like the "enable" word
:).

> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  fs/ext4/inode.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index fa0ff78dc033..e9d582e516bc 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4383,9 +4383,11 @@ int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
>  		!ext4_test_inode_state(inode, EXT4_STATE_XATTR));
>  }
>  
> -static bool ext4_should_use_dax(struct inode *inode)
> +static bool ext4_enable_dax(struct inode *inode)
>  {
> -	if (!test_opt(inode->i_sb, DAX))
> +	unsigned int flags = EXT4_I(inode)->i_flags;
> +
> +	if (test_opt2(inode->i_sb, NODAX))
>  		return false;
>  	if (!S_ISREG(inode->i_mode))
>  		return false;
> @@ -4397,7 +4399,13 @@ static bool ext4_should_use_dax(struct inode *inode)
>  		return false;
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_VERITY))
>  		return false;
> -	return true;
> +	if (!bdev_dax_supported(inode->i_sb->s_bdev,
> +				inode->i_sb->s_blocksize))
> +		return false;
> +	if (test_opt(inode->i_sb, DAX))
> +		return true;
> +
> +	return (flags & EXT4_DAX_FL) == EXT4_DAX_FL;

flags & EXT4_DAX_FL is enough here, isn't it?

								Honza

>  }
>  
>  void ext4_set_inode_flags(struct inode *inode)
> @@ -4415,7 +4423,7 @@ void ext4_set_inode_flags(struct inode *inode)
>  		new_fl |= S_NOATIME;
>  	if (flags & EXT4_DIRSYNC_FL)
>  		new_fl |= S_DIRSYNC;
> -	if (ext4_should_use_dax(inode))
> +	if (ext4_enable_dax(inode))
>  		new_fl |= S_DAX;
>  	if (flags & EXT4_ENCRYPT_FL)
>  		new_fl |= S_ENCRYPTED;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
