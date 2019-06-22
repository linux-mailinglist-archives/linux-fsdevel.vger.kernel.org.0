Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBED4F892
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2019 00:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfFVW3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jun 2019 18:29:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfFVW3A (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jun 2019 18:29:00 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45A6E206B7;
        Sat, 22 Jun 2019 22:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561242539;
        bh=c8fVFZZuYkZhgy8reLNIA8g+E5ers06eeDGckiaZq3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AYXStsrVq/xuYzf7uWcwMuGUXLnWY2Lo7cZxbMQPrq04wyTcErdo9cKIrdtloCcw2
         80jHKyEdHZqbsjLmjF+7FwM2ykvZmhCZOYDwBNbJX8w4Xl7uYNzfqNncqR8ZgEYcpU
         Nh1jzXQiG2CFGViyc0d8oXrh17vVK382gSxHhz+A=
Date:   Sat, 22 Jun 2019 15:28:58 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 08/16] fs-verity: add the hook for file ->setattr()
Message-ID: <20190622222858.GH19686@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190620205043.64350-1-ebiggers@kernel.org>
 <20190620205043.64350-9-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620205043.64350-9-ebiggers@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/20, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a function fsverity_prepare_setattr() which filesystems that support
> fs-verity must call to deny truncates of verity files.
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>

> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/verity/open.c         | 21 +++++++++++++++++++++
>  include/linux/fsverity.h |  7 +++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/fs/verity/open.c b/fs/verity/open.c
> index 3a3bb27e23f5e3..21ae0ef254a695 100644
> --- a/fs/verity/open.c
> +++ b/fs/verity/open.c
> @@ -296,6 +296,27 @@ int fsverity_file_open(struct inode *inode, struct file *filp)
>  }
>  EXPORT_SYMBOL_GPL(fsverity_file_open);
>  
> +/**
> + * fsverity_prepare_setattr - prepare to change a verity inode's attributes
> + * @dentry: dentry through which the inode is being changed
> + * @attr: attributes to change
> + *
> + * Verity files are immutable, so deny truncates.  This isn't covered by the
> + * open-time check because sys_truncate() takes a path, not a file descriptor.
> + *
> + * Return: 0 on success, -errno on failure
> + */
> +int fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr)
> +{
> +	if (IS_VERITY(d_inode(dentry)) && (attr->ia_valid & ATTR_SIZE)) {
> +		pr_debug("Denying truncate of verity file (ino %lu)\n",
> +			 d_inode(dentry)->i_ino);
> +		return -EPERM;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fsverity_prepare_setattr);
> +
>  /**
>   * fsverity_cleanup_inode - free the inode's verity info, if present
>   *
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 1372c236c8770c..cbcc358d073652 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -46,6 +46,7 @@ static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
>  /* open.c */
>  
>  extern int fsverity_file_open(struct inode *inode, struct file *filp);
> +extern int fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
>  extern void fsverity_cleanup_inode(struct inode *inode);
>  
>  #else /* !CONFIG_FS_VERITY */
> @@ -62,6 +63,12 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
>  	return IS_VERITY(inode) ? -EOPNOTSUPP : 0;
>  }
>  
> +static inline int fsverity_prepare_setattr(struct dentry *dentry,
> +					   struct iattr *attr)
> +{
> +	return IS_VERITY(d_inode(dentry)) ? -EOPNOTSUPP : 0;
> +}
> +
>  static inline void fsverity_cleanup_inode(struct inode *inode)
>  {
>  }
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
