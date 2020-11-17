Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1011C2B6D0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 19:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbgKQSRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 13:17:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730914AbgKQSQw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:16:52 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B352222E;
        Tue, 17 Nov 2020 18:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605637011;
        bh=LYmQa3sjmY4vGoc9PzmWfJg6D+u8panQLU6mw2v2bU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BIyHtChuKC/1Z2hfN01FJL2lQedY2Jopd9Xk6ljOb8WSU5039BmyYLu1lS/JerWeZ
         P+zilHNPhlrTLNiM1v44Y5EagbQsJhPY2JHB3h9CWIqeujkTkuhcWx5hjeDSPcyMf4
         ccWF5nBSvvcF0BXkSIJq0FUknVkLg8jyR9SxjF2Y=
Date:   Tue, 17 Nov 2020 10:16:49 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/3] libfs: Add generic function for setting dentry_ops
Message-ID: <X7QTkSyiMojM6T10@sol.localdomain>
References: <20201117040315.28548-1-drosen@google.com>
 <20201117040315.28548-2-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117040315.28548-2-drosen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 04:03:13AM +0000, Daniel Rosenberg wrote:
> 
> Currently the casefolding dentry operation are always set if the
> filesystem defines an encoding because the features is toggleable on
> empty directories. Since we don't know what set of functions we'll
> eventually need, and cannot change them later, we add just add them.

This isn't a very useful explanation, since encryption can be toggled on empty
directories too (at least from off to on --- not the other way).  Why is
casefolding different?

> +static const struct dentry_operations generic_ci_dentry_ops = {
> +	.d_hash = generic_ci_d_hash,
> +	.d_compare = generic_ci_d_compare,
> +};
>  #endif
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
> + * @dentry:	dentry to set ops on
> + *
> + * This function sets the dentry ops for the given dentry to handle both
> + * casefolded and encrypted dentry names.
> + *
> + * Encryption requires d_revalidate to remove nokey names once the key is present.
> + * Casefolding is toggleable on an empty directory. Since we can't change the
> + * operations later on, we just add the casefolding ops if the filesystem defines an
> + * encoding.
> + */

There are some overly long lines here (> 80 columns).

But more importantly this still isn't a good explanation.  Encryption can also
be enabled on empty directories; what makes casefolding different?

It's also not obvious why so many different copies of the dentry operations
needed, instead of just using generic_encrypted_ci_dentry_ops on all.

If I'm still struggling to understand this after following these patches for a
long time, I expect everyone else will have trouble too...

Here's a suggestion which I think explains it a lot better.  It's still possible
I'm misunderstanding something, though, so please check it carefully:

/**
 * generic_set_encrypted_ci_d_ops - helper for setting d_ops for given dentry
 * @dentry:	dentry to set ops on
 *
 * Casefolded directories need d_hash and d_compare set, so that the dentries
 * contained in them are handled case-insensitively.  Note that these operations
 * are needed on the parent directory rather than on the dentries in it, and the
 * casefolding flag can be enabled on an empty directory later but the
 * dentry_operations can't be changed later.  As a result, if the filesystem has
 * casefolding support enabled at all, we have to give all dentries the
 * casefolding operations even if their inode doesn't have the casefolding flag
 * currently (and thus the casefolding ops would be no-ops for now).
 *
 * Encryption works differently in that the only dentry operation it needs is
 * d_revalidate, which it only needs on dentries that have the no-key name flag.
 * The no-key flag can't be set "later", so we don't have to worry about that.
 *
 * Finally, to maximize compatibility with overlayfs (which isn't compatible
 * with certain dentry operations) and to avoid taking an unnecessary
 * performance hit, we use custom dentry_operations for each possible
 * combination rather always installing all operations.
 */

> +void generic_set_encrypted_ci_d_ops(struct dentry *dentry)
> +{
> +#ifdef CONFIG_FS_ENCRYPTION
> +	bool needs_encrypt_ops = dentry->d_flags & DCACHE_NOKEY_NAME;
> +#endif
> +#ifdef CONFIG_UNICODE
> +	bool needs_ci_ops = dentry->d_sb->s_encoding;
> +#endif
> +#if defined(CONFIG_FS_ENCRYPTION) && defined(CONFIG_UNICODE)
> +	if (needs_encrypt_ops && needs_ci_ops) {
> +		d_set_d_op(dentry, &generic_encrypted_ci_dentry_ops);
> +			return;
> +	}

The return statement above has the wrong indentation level.

> +#endif
> +#ifdef CONFIG_FS_ENCRYPTION
> +	if (needs_encrypt_ops) {
> +		d_set_d_op(dentry, &generic_encrypted_dentry_ops);
> +		return;
> +	}
> +#endif
> +#ifdef CONFIG_UNICODE
> +	if (needs_ci_ops) {
> +		d_set_d_op(dentry, &generic_ci_dentry_ops);
> +		return;
> +	}
> +#endif
> +}
> +EXPORT_SYMBOL(generic_set_encrypted_ci_d_ops);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8667d0cdc71e..11345e66353b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3202,6 +3202,7 @@ extern int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
>  extern int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
>  				const char *str, const struct qstr *name);
>  #endif
> +extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
>  
>  #ifdef CONFIG_MIGRATION
>  extern int buffer_migrate_page(struct address_space *,
