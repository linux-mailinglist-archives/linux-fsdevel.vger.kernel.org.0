Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DEB1D5DCE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 May 2020 04:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgEPCC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 22:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgEPCC4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 22:02:56 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 047B120671;
        Sat, 16 May 2020 02:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589594575;
        bh=udGZ/mluE2geb6BB8HoGVq2HXLCwXdDkVOVFXYUtwhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opoNd5ub3tJqB7aomfT3jNItncU2GVNtSneh6kO9sM8U/OsKCHyX7JqIq+jJpqax/
         btQ+J2EQ7PGpxh1xYxSlW0mk6vCLoyVaq0JcjUGxjb5dUcLDW3n3chvxw55ZDoxAGo
         3N4Lkt0uGqa3OgAYoiVezqJold1tfxIkFNtpOYf4=
Date:   Fri, 15 May 2020 19:02:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
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
Subject: Re: [PATCH 3/9] fs/ext4: Disallow encryption if inode is DAX
Message-ID: <20200516020253.GG1009@sol.localdomain>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
 <20200513054324.2138483-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513054324.2138483-4-ira.weiny@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 10:43:18PM -0700, ira.weiny@intel.com wrote:
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

I'm confused by the ext4_set_context() change.

ext4_set_context() is only called when FS_IOC_SET_ENCRYPTION_POLICY sets an
encryption policy on an empty directory, *or* when a new inode (regular, dir, or
symlink) is created in an encrypted directory (thus inheriting encryption from
its parent).

So when is it reachable when IS_DAX()?  Is the issue that the DAX flag can now
be set on directories?  The commit message doesn't seem to be talking about
directories.  Is the behavior we want is that on an (empty) directory with the
DAX flag set, FS_IOC_SET_ENCRYPTION_POLICY should fail with EINVAL?

I don't see why the i_size_read(inode) check is there though, so I think you're
at least right to remove that.

- Eric
