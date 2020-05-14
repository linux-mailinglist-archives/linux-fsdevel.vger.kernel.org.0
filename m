Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9226F1D2C92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 12:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgENKXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 06:23:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:57120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgENKXs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 06:23:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8E97AAE67;
        Thu, 14 May 2020 10:23:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 62C4A1E12A8; Thu, 14 May 2020 12:23:46 +0200 (CEST)
Date:   Thu, 14 May 2020 12:23:46 +0200
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
Subject: Re: [PATCH V1 3/9] fs/ext4: Disallow encryption if inode is DAX
Message-ID: <20200514102346.GE9569@quack2.suse.cz>
References: <20200514065316.2500078-1-ira.weiny@intel.com>
 <20200514065316.2500078-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514065316.2500078-4-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-05-20 23:53:09, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Encryption and DAX are incompatible.  Changing the DAX mode due to a
> change in Encryption mode is wrong without a corresponding
> address_space_operations update.
> 
> Make the 2 options mutually exclusive by returning an error if DAX was
> set first.
> 
> Furthermore, clarify the documentation of the exclusivity and how that
> will work.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> 
> ---
> Changes:
> 	remove WARN_ON_ONCE
> 	Add documentation to the encrypt doc WRT DAX
> ---
>  Documentation/filesystems/fscrypt.rst |  4 +++-
>  fs/ext4/super.c                       | 10 +---------
>  2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
> index aa072112cfff..1475b8d52fef 100644
> --- a/Documentation/filesystems/fscrypt.rst
> +++ b/Documentation/filesystems/fscrypt.rst
> @@ -1038,7 +1038,9 @@ astute users may notice some differences in behavior:
>  - The ext4 filesystem does not support data journaling with encrypted
>    regular files.  It will fall back to ordered data mode instead.
>  
> -- DAX (Direct Access) is not supported on encrypted files.
> +- DAX (Direct Access) is not supported on encrypted files.  Attempts to enable
> +  DAX on an encrypted file will fail.  Mount options will _not_ enable DAX on
> +  encrypted files.
>  
>  - The st_size of an encrypted symlink will not necessarily give the
>    length of the symlink target as required by POSIX.  It will actually
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index bf5fcb477f66..9873ab27e3fa 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1320,7 +1320,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
>  	if (inode->i_ino == EXT4_ROOT_INO)
>  		return -EPERM;
>  
> -	if (WARN_ON_ONCE(IS_DAX(inode) && i_size_read(inode)))
> +	if (IS_DAX(inode))
>  		return -EINVAL;
>  
>  	res = ext4_convert_inline_data(inode);
> @@ -1344,10 +1344,6 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
>  			ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
>  			ext4_clear_inode_state(inode,
>  					EXT4_STATE_MAY_INLINE_DATA);
> -			/*
> -			 * Update inode->i_flags - S_ENCRYPTED will be enabled,
> -			 * S_DAX may be disabled
> -			 */
>  			ext4_set_inode_flags(inode);
>  		}
>  		return res;
> @@ -1371,10 +1367,6 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
>  				    ctx, len, 0);
>  	if (!res) {
>  		ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
> -		/*
> -		 * Update inode->i_flags - S_ENCRYPTED will be enabled,
> -		 * S_DAX may be disabled
> -		 */
>  		ext4_set_inode_flags(inode);
>  		res = ext4_mark_inode_dirty(handle, inode);
>  		if (res)
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
