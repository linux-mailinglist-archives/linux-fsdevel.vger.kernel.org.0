Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD92C17CC51
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 06:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCGFlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Mar 2020 00:41:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgCGFlS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Mar 2020 00:41:18 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A95492070A;
        Sat,  7 Mar 2020 05:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583559677;
        bh=Z5bTJVp50KuWeymYhYAdxIiTXYzyTVmZsP2BigxcerM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wI3oLIQFFHIL5ICoqkDZhrwLR+OMO+a4KW9PZo0HtYoZzUNdytbzjj1R7kofMI0br
         YhDNzK3xcG6s3VWGMLkjJzhFlcnB4XxIl9N4MXpPOM/wD3zWgocEAg5wVV81E/VRTI
         7AlRaoulsSD655PjM30iHYYdYN0zupK+ODogkYjw=
Date:   Fri, 6 Mar 2020 21:41:15 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v8 6/8] libfs: Add generic function for setting dentry_ops
Message-ID: <20200307054115.GC1069@sol.localdomain>
References: <20200307023611.204708-1-drosen@google.com>
 <20200307023611.204708-7-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307023611.204708-7-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 06:36:09PM -0800, Daniel Rosenberg wrote:
> This adds a function to set dentry operations at lookup time that will
> work for both encrypted files and casefolded filenames.
> 
> A filesystem that supports both features simultaneously can use this
> function during lookup preperations to set up its dentry operations once
> fscrypt no longer does that itself.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/libfs.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  2 ++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 0eaa63a9ae037..bdda03c8ece9e 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1474,4 +1474,54 @@ int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
>  	return ret;
>  }
>  EXPORT_SYMBOL(generic_ci_d_hash);
> +
> +static const struct dentry_operations generic_ci_dentry_ops = {
> +	.d_hash = generic_ci_d_hash,
> +	.d_compare = generic_ci_d_compare,
> +};
> +#endif
> +
> +#ifdef CONFIG_FS_ENCRYPTION
> +static const struct dentry_operations generic_encrypted_dentry_ops = {
> +	.d_revalidate = fscrypt_d_revalidate,
> +};
> +#endif
> +
> +#if IS_ENABLED(CONFIG_UNICODE) && IS_ENABLED(CONFIG_FS_ENCRYPTION)
> +static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
> +	.d_hash = generic_ci_d_hash,
> +	.d_compare = generic_ci_d_compare,
> +	.d_revalidate = fscrypt_d_revalidate,
> +};
> +#endif
> +
> +/**
> + * generic_set_encrypted_ci_d_ops - helper for setting d_ops for given dentry
> + * @dir:	parent of dentry whose ops to set
> + * @dentry:	dentry to set ops on
> + *
> + * This function sets the dentry ops for the given dentry to handle both
> + * casefolding and encryption of the dentry name.
> + */
> +void generic_set_encrypted_ci_d_ops(struct inode *dir, struct dentry *dentry)
> +{
> +#ifdef CONFIG_FS_ENCRYPTION
> +	if (dentry->d_flags & DCACHE_ENCRYPTED_NAME) {
> +#ifdef CONFIG_UNICODE
> +		if (dir->i_sb->s_encoding) {
> +			d_set_d_op(dentry, &generic_encrypted_ci_dentry_ops);
> +			return;
> +		}
>  #endif
> +		d_set_d_op(dentry, &generic_encrypted_dentry_ops);
> +		return;
> +	}
> +#endif
> +#ifdef CONFIG_UNICODE
> +	if (dir->i_sb->s_encoding) {
> +		d_set_d_op(dentry, &generic_ci_dentry_ops);
> +		return;
> +	}
> +#endif
> +}
> +EXPORT_SYMBOL(generic_set_encrypted_ci_d_ops);

What's wrong with using dentry->d_sb?  Then the 'dir' parameter wouldn't be
needed.

Also, can you please document why the dentry_operations for casefolding are set
per-filesystem while the dentry_operations for encryption are set per-dentry,
despite both features actually being per-directory things?

- Eric
