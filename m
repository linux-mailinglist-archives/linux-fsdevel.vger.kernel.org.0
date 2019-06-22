Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133E84F8A9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2019 00:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfFVWnn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jun 2019 18:43:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfFVWnn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jun 2019 18:43:43 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AA812084E;
        Sat, 22 Jun 2019 22:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561243422;
        bh=DcyohrKT72HLIRQWpmZKgJ9cYufyV5h3FgzJrKSEzqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0UcE3JNB92K56eXwIaeRiAOevDg9flpmPmcEW0WWWiVvcr7eSRw0Z9orFqbTJZ1w
         wIeoStA/9a0DlOVbZOu3SGFsd1PJdAeKDTRnH9iSx/BopGxHP4WMfhVSr3Qt+4+KCs
         vToVvBi+I8LblcGPSzKdB/4BVO6uCtB1QOo0jyjA=
Date:   Sat, 22 Jun 2019 15:43:41 -0700
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
Subject: Re: [PATCH v5 11/16] fs-verity: implement FS_IOC_MEASURE_VERITY ioctl
Message-ID: <20190622224341.GK19686@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190620205043.64350-1-ebiggers@kernel.org>
 <20190620205043.64350-12-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620205043.64350-12-ebiggers@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/20, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a function for filesystems to call to implement the
> FS_IOC_MEASURE_VERITY ioctl.  This ioctl retrieves the file measurement
> that fs-verity calculated for the given file and is enforcing for reads;
> i.e., reads that don't match this hash will fail.  This ioctl can be
> used for authentication or logging of file measurements in userspace.
> 
> See the "FS_IOC_MEASURE_VERITY" section of
> Documentation/filesystems/fsverity.rst for the documentation.
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>

> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/verity/Makefile       |  1 +
>  fs/verity/measure.c      | 57 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/fsverity.h | 11 ++++++++
>  3 files changed, 69 insertions(+)
>  create mode 100644 fs/verity/measure.c
> 
> diff --git a/fs/verity/Makefile b/fs/verity/Makefile
> index 04b37475fd280a..6f7675ae0a3110 100644
> --- a/fs/verity/Makefile
> +++ b/fs/verity/Makefile
> @@ -3,5 +3,6 @@
>  obj-$(CONFIG_FS_VERITY) += enable.o \
>  			   hash_algs.o \
>  			   init.o \
> +			   measure.o \
>  			   open.o \
>  			   verify.o
> diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> new file mode 100644
> index 00000000000000..05049b68c74553
> --- /dev/null
> +++ b/fs/verity/measure.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * fs/verity/measure.c: ioctl to get a verity file's measurement
> + *
> + * Copyright 2019 Google LLC
> + */
> +
> +#include "fsverity_private.h"
> +
> +#include <linux/uaccess.h>
> +
> +/**
> + * fsverity_ioctl_measure() - get a verity file's measurement
> + *
> + * Retrieve the file measurement that the kernel is enforcing for reads from a
> + * verity file.  See the "FS_IOC_MEASURE_VERITY" section of
> + * Documentation/filesystems/fsverity.rst for the documentation.
> + *
> + * Return: 0 on success, -errno on failure
> + */
> +int fsverity_ioctl_measure(struct file *filp, void __user *_uarg)
> +{
> +	const struct inode *inode = file_inode(filp);
> +	struct fsverity_digest __user *uarg = _uarg;
> +	const struct fsverity_info *vi;
> +	const struct fsverity_hash_alg *hash_alg;
> +	struct fsverity_digest arg;
> +
> +	vi = fsverity_get_info(inode);
> +	if (!vi)
> +		return -ENODATA; /* not a verity file */
> +	hash_alg = vi->tree_params.hash_alg;
> +
> +	/*
> +	 * The user specifies the digest_size their buffer has space for; we can
> +	 * return the digest if it fits in the available space.  We write back
> +	 * the actual size, which may be shorter than the user-specified size.
> +	 */
> +
> +	if (get_user(arg.digest_size, &uarg->digest_size))
> +		return -EFAULT;
> +	if (arg.digest_size < hash_alg->digest_size)
> +		return -EOVERFLOW;
> +
> +	memset(&arg, 0, sizeof(arg));
> +	arg.digest_algorithm = hash_alg - fsverity_hash_algs;
> +	arg.digest_size = hash_alg->digest_size;
> +
> +	if (copy_to_user(uarg, &arg, sizeof(arg)))
> +		return -EFAULT;
> +
> +	if (copy_to_user(uarg->digest, vi->measurement, hash_alg->digest_size))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fsverity_ioctl_measure);
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 7ef2ef82653409..247359c86b72e0 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -116,6 +116,10 @@ static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
>  
>  extern int fsverity_ioctl_enable(struct file *filp, const void __user *arg);
>  
> +/* measure.c */
> +
> +extern int fsverity_ioctl_measure(struct file *filp, void __user *arg);
> +
>  /* open.c */
>  
>  extern int fsverity_file_open(struct inode *inode, struct file *filp);
> @@ -143,6 +147,13 @@ static inline int fsverity_ioctl_enable(struct file *filp,
>  	return -EOPNOTSUPP;
>  }
>  
> +/* measure.c */
> +
> +static inline int fsverity_ioctl_measure(struct file *filp, void __user *arg)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  /* open.c */
>  
>  static inline int fsverity_file_open(struct inode *inode, struct file *filp)
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
