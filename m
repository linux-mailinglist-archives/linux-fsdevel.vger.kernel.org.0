Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E463B27625A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 22:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIWUof (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 16:44:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47686 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWUof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:44:35 -0400
X-Greylist: delayed 1561 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 16:44:34 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 0338129C28A
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org, kernel-team@android.com
Subject: Re: [PATCH 3/5] libfs: Add generic function for setting dentry_ops
Organization: Collabora
References: <20200923010151.69506-1-drosen@google.com>
        <20200923010151.69506-4-drosen@google.com>
Date:   Wed, 23 Sep 2020 16:44:28 -0400
In-Reply-To: <20200923010151.69506-4-drosen@google.com> (Daniel Rosenberg's
        message of "Wed, 23 Sep 2020 01:01:49 +0000")
Message-ID: <87ft785ikz.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Daniel Rosenberg <drosen@google.com> writes:

> This adds a function to set dentry operations at lookup time that will
> work for both encrypted files and casefolded filenames.
>
> A filesystem that supports both features simultaneously can use this
> function during lookup preperations to set up its dentry operations once
> fscrypt no longer does that itself.
>
> Currently the casefolding dentry operation are always set because the
> feature is toggleable on empty directories. Since we don't know what
> set of functions we'll eventually need, and cannot change them later,
> we add just add them.
>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/libfs.c         | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  1 +
>  2 files changed, 50 insertions(+)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index fc34361c1489..83303858f1fe 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1449,4 +1449,53 @@ int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
>  	return 0;
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
> + * @dentry:	dentry to set ops on
> + *
> + * This function sets the dentry ops for the given dentry to handle both
> + * casefolding and encryption of the dentry name.
> + */
> +void generic_set_encrypted_ci_d_ops(struct dentry *dentry)
> +{
> +#ifdef CONFIG_FS_ENCRYPTION
> +	if (dentry->d_flags & DCACHE_ENCRYPTED_NAME) {
> +#ifdef CONFIG_UNICODE
> +		if (dentry->d_sb->s_encoding) {
> +			d_set_d_op(dentry, &generic_encrypted_ci_dentry_ops);
> +			return;
> +		}
>  #endif
> +		d_set_d_op(dentry, &generic_encrypted_dentry_ops);
> +		return;
> +	}
> +#endif
> +#ifdef CONFIG_UNICODE
> +	if (dentry->d_sb->s_encoding) {
> +		d_set_d_op(dentry, &generic_ci_dentry_ops);
> +		return;
> +	}
> +#endif
> +}

I think this is harder to read than necessary.  What do you think about
just splitting the three cases like the following:

void generic_set_encrypted_ci_d_ops(struct dentry *dentry) {

#if defined(CONFIG_FS_ENCRYPTION) && defined(CONFIG_UNICODE)
    if (encoding && encryption) {
    	d_set_d_op(dentry, &generic_encrypted_ci_dentry_ops);
            return;
    }
#endif

#if defined (CONFIG_FS_ENCRYPTION)
    if (encryption) {
    	d_set_d_op(dentry, &generic_encrypted_dentry_ops);
        return;
    }
#endif

#if defined (CONFIG_UNICODE)
    if (encoding) {
    	d_set_d_op(dentry, &generic_ci_dentry_ops);
        return;
    }
#endif
}

> +EXPORT_SYMBOL(generic_set_encrypted_ci_d_ops);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index bc5417c61e12..6627896db835 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3277,6 +3277,7 @@ extern int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
>  extern int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
>  				const char *str, const struct qstr *name);
>  #endif
> +extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
>  
>  #ifdef CONFIG_MIGRATION
>  extern int buffer_migrate_page(struct address_space *,

-- 
Gabriel Krisman Bertazi
