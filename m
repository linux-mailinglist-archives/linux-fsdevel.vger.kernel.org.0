Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D529A159FAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 04:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgBLDzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 22:55:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbgBLDzq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 22:55:46 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5566B206D7;
        Wed, 12 Feb 2020 03:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581479745;
        bh=QRHIt8kBfhFwG/eebDuW7D9CmPyDjyjrXyg9CDC5NUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QDjwA1UUCb18CDvTZAWN3AWxXhe8SylkHRngDpUO6Eo0l9UqmK2TbcwHSvmdzSIdq
         8lpBsW3LIAzLnS9/lpjvbuepoMDAj1jRGvX2twIB172UT2z1b0FdwMXW2zw4q/ykCV
         QH0qbBpDSO+kDk6Nfy2KrHxMmTeVcqviduLNqrp8=
Date:   Tue, 11 Feb 2020 19:55:43 -0800
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
Subject: Re: [PATCH v7 2/8] fs: Add standard casefolding support
Message-ID: <20200212035543.GD870@sol.localdomain>
References: <20200208013552.241832-1-drosen@google.com>
 <20200208013552.241832-3-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208013552.241832-3-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 05:35:46PM -0800, Daniel Rosenberg wrote:
> This adds general supporting functions for filesystems that use
> utf8 casefolding. It provides standard dentry_operations and adds the
> necessary structures in struct super_block to allow this standardization.
> 
> Ext4 and F2fs are switch to these implementations.

I think you mean that ext4 and f2fs *will be switched* to these implementations?
It's later in the series, not in this patch.

> +#ifdef CONFIG_UNICODE
> +bool needs_casefold(const struct inode *dir)
> +{
> +	return IS_CASEFOLDED(dir) && dir->i_sb->s_encoding &&
> +			(!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir));
> +}
> +EXPORT_SYMBOL(needs_casefold);

Can you add kerneldoc comments to all the new functions that are exported to
modules?

> +struct hash_ctx {
> +	struct utf8_itr_context ctx;
> +	unsigned long hash;
> +};
> +
> +static int do_generic_ci_hash(struct utf8_itr_context *ctx, int byte, int pos)
> +{
> +	struct hash_ctx *hctx = container_of(ctx, struct hash_ctx, ctx);
> +
> +	hctx->hash = partial_name_hash((unsigned char)byte, hctx->hash);
> +	return 0;
> +}
> +
> +int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
> +{
> +	const struct inode *inode = READ_ONCE(dentry->d_inode);
> +	struct super_block *sb = dentry->d_sb;
> +	const struct unicode_map *um = sb->s_encoding;
> +	int ret = 0;
> +	struct hash_ctx hctx;
> +
> +	if (!inode || !needs_casefold(inode))
> +		return 0;
> +
> +	hctx.hash = init_name_hash(dentry);
> +	hctx.ctx.actor = do_generic_ci_hash;
> +	ret = utf8_casefold_iter(um, str, &hctx.ctx);
> +	if (ret < 0)
> +		goto err;
> +	str->hash = end_name_hash(hctx.hash);
> +
> +	return 0;
> +err:
> +	if (sb_has_enc_strict_mode(sb))
> +		ret = -EINVAL;
> +	return ret;
> +}
> +EXPORT_SYMBOL(generic_ci_d_hash);
> +#endif

This breaks the !strict_mode case by starting to fail lookups of names that
aren't valid Unicode, instead of falling back to the standard case-sensitive
behavior.

There is an xfstest for casefolding; is this bug not caught by it (in which case
the test needs to be improved)?  Or did you just not run it?

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 6eae91c0668f9..a260afbc06d22 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1382,6 +1382,12 @@ extern int send_sigurg(struct fown_struct *fown);
>  #define SB_ACTIVE	(1<<30)
>  #define SB_NOUSER	(1<<31)
>  
> +/* These flags relate to encoding and casefolding */
> +#define SB_ENC_STRICT_MODE_FL	(1 << 0)

It would be helpful if the comment mentioned that these flags are stored on-disk
(and therefore can't be re-numbered, unlike the other flags defined nearby).

> +#ifdef CONFIG_UNICODE
> +	struct unicode_map *s_encoding;
> +	__u16 s_encoding_flags;
>  #endif

This isn't a UAPI header, so 's_encoding_flags' should use u16, not __u16.

And for that matter, 's_encoding_flags' will be pointer-sized due to padding
anyway, so maybe just make it 'unsigned int'?

> +static inline bool needs_casefold(const struct inode *dir)
> +{
> +	return 0;
> +}
> +#endif

Use false instead of 0 for 'bool'.

- Eric
