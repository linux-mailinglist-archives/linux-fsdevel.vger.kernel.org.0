Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C779111066C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 22:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfLCVVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 16:21:08 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37006 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbfLCVVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 16:21:08 -0500
Received: from localhost (unknown [IPv6:2610:98:8005::647])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E95F128C59C;
        Tue,  3 Dec 2019 21:21:04 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Daniel Rosenberg <drosen@google.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 4/8] vfs: Fold casefolding into vfs
Organization: Collabora
References: <20191203051049.44573-1-drosen@google.com>
        <20191203051049.44573-5-drosen@google.com>
        <20191203074154.GA216261@architecture4> <85wobdb3hp.fsf@collabora.com>
        <20191203203414.GA727@sol.localdomain>
Date:   Tue, 03 Dec 2019 16:21:02 -0500
In-Reply-To: <20191203203414.GA727@sol.localdomain> (Eric Biggers's message of
        "Tue, 3 Dec 2019 12:34:14 -0800")
Message-ID: <85zhg96r7l.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Tue, Dec 03, 2019 at 02:42:10PM -0500, Gabriel Krisman Bertazi wrote:
>> Gao Xiang <gaoxiang25@huawei.com> writes:

>> I think Daniel's approach of moving this into VFS is the simplest way to
>> actually solve the issue, instead of extending and duplicating a lot of
>> functionality into filesystem hooks to support the possible mixes of
>> case-insensitive, overlayfs and fscrypt.
>> 
>
> I think we can actually get everything we want using dentry_operations only,
> since the filesystem can set ->d_op during ->lookup() (like what is done for
> encrypted filenames now) rather than at dentry allocation time.  And fs/crypto/
> can export fscrypt_d_revalidate() rather than setting ->d_op itself.

Problem is, differently from fscrypt, case-insensitive uses the d_hash()
hook and for a lookup, we actually use
dentry->d_parent->d_ops->d_hash().  Which works well, until you are flipping the
casefold flag.  Then the dentry already exists and you need to modify
the d_ops on the fly, which I couldn't find precedent anywhere.  I tried
invalidating the dentry whenever we flip the flag, but then if it has
negative dentries as children,I wasn't able to reliably invalidate it,
and that's when I reached the limit of my knowledge in VFS.  In
particular, in every attempt I made to implement it like this, I was
able to race and do a case-insensitive lookup on a directory that was
just made case sensitive.

I'm not saying there isn't a way.  But it is a bit harder than this
proposal. I tried it already and still didn't manage to make it work.
Maybe someone who better understands vfs.

> It's definitely ugly to have to handle the 3 cases of encrypt, casefold, and
> encrypt+casefold separately -- and this will need to be duplicated for each
> filesystem.  But we do have to weigh that against adding additional complexity
> and overhead to the VFS for everyone.  If we do go with the VFS changes, please
> try to make them as simple and unobtrusive as possible.

Well, it is just not case-insensitive+fscrypt. Also overlayfs
there. Probably more.  So we have much more cases.  I understand the VFS
changes need to be very well thought, but when I worked on this it
started to look a more correct solution than using the hooks.

> diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
> index 3719efa546c6..cfa44adff2b3 100644
> --- a/fs/crypto/crypto.c
> +++ b/fs/crypto/crypto.c
> @@ -290,7 +290,7 @@ EXPORT_SYMBOL(fscrypt_decrypt_block_inplace);
>   * Validate dentries in encrypted directories to make sure we aren't potentially
>   * caching stale dentries after a key has been added.
>   */
> -static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
> +int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
>  {
>  	struct dentry *dir;
>  	int err;
> @@ -329,10 +329,7 @@ static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
>  
>  	return valid;
>  }
> -
> -const struct dentry_operations fscrypt_d_ops = {
> -	.d_revalidate = fscrypt_d_revalidate,
> -};
> +EXPORT_SYMBOL_GPL(fscrypt_d_revalidate);
>  
>  /**
>   * fscrypt_initialize() - allocate major buffers for fs encryption.
> diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
> index 130b50e5a011..4420670ac40a 100644
> --- a/fs/crypto/fscrypt_private.h
> +++ b/fs/crypto/fscrypt_private.h
> @@ -233,7 +233,6 @@ extern int fscrypt_crypt_block(const struct inode *inode,
>  			       unsigned int len, unsigned int offs,
>  			       gfp_t gfp_flags);
>  extern struct page *fscrypt_alloc_bounce_page(gfp_t gfp_flags);
> -extern const struct dentry_operations fscrypt_d_ops;
>  
>  extern void __printf(3, 4) __cold
>  fscrypt_msg(const struct inode *inode, const char *level, const char *fmt, ...);
> diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
> index bb3b7fcfdd48..ec81b6a597aa 100644
> --- a/fs/crypto/hooks.c
> +++ b/fs/crypto/hooks.c
> @@ -116,7 +116,6 @@ int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
>  		spin_lock(&dentry->d_lock);
>  		dentry->d_flags |= DCACHE_ENCRYPTED_NAME;
>  		spin_unlock(&dentry->d_lock);
> -		d_set_d_op(dentry, &fscrypt_d_ops);
>  	}
>  	return err;
>  }
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index 9fdd2b269d61..bd3c14e6b24a 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -704,9 +704,47 @@ static int ext4_d_hash(const struct dentry *dentry, struct qstr *str)
>  	kfree(norm);
>  	return ret;
>  }
> +#endif /* !CONFIG_UNICODE */
>  
> -const struct dentry_operations ext4_dentry_ops = {
> +#ifdef CONFIG_UNICODE
> +static const struct dentry_operations ext4_ci_dentry_ops = {
> +	.d_hash = ext4_d_hash,
> +	.d_compare = ext4_d_compare,
> +};
> +#endif
> +
> +#ifdef CONFIG_FS_ENCRYPTION
> +static const struct dentry_operations ext4_encrypted_dentry_ops = {
> +	.d_revalidate = fscrypt_d_revalidate,
> +};
> +#endif
> +
> +#if IS_ENABLED(CONFIG_UNICODE) && IS_ENABLED(CONFIG_FS_ENCRYPTION)
> +static const struct dentry_operations ext4_encrypted_ci_dentry_ops = {
>  	.d_hash = ext4_d_hash,
>  	.d_compare = ext4_d_compare,
> +	.d_revalidate = fscrypt_d_revalidate,
>  };
>  #endif
> +
> +void ext4_set_d_ops(struct inode *dir, struct dentry *dentry)
> +{
> +#ifdef CONFIG_FS_ENCRYPTION
> +	if (dentry->d_flags & DCACHE_ENCRYPTED_NAME) {
> +#ifdef CONFIG_UNICODE
> +		if (IS_CASEFOLDED(dir)) {
> +			d_set_d_op(dentry, &ext4_encrypted_ci_dentry_ops);
> +			return;
> +		}
> +#endif
> +		d_set_d_op(dentry, &ext4_encrypted_dentry_ops);
> +		return;
> +	}
> +#endif
> +#ifdef CONFIG_UNICODE
> +	if (IS_CASEFOLDED(dir)) {
> +		d_set_d_op(dentry, &ext4_ci_dentry_ops);
> +		return;
> +	}
> +#endif
> +}
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index f8578caba40d..00a10015a53c 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2499,6 +2499,8 @@ static inline  unsigned char get_dtype(struct super_block *sb, int filetype)
>  extern int ext4_check_all_de(struct inode *dir, struct buffer_head *bh,
>  			     void *buf, int buf_size);
>  
> +void ext4_set_d_ops(struct inode *dir, struct dentry *dentry);
> +
>  /* fsync.c */
>  extern int ext4_sync_file(struct file *, loff_t, loff_t, int);
>  
> @@ -3097,10 +3099,6 @@ static inline void ext4_unlock_group(struct super_block *sb,
>  /* dir.c */
>  extern const struct file_operations ext4_dir_operations;
>  
> -#ifdef CONFIG_UNICODE
> -extern const struct dentry_operations ext4_dentry_ops;
> -#endif
> -
>  /* file.c */
>  extern const struct inode_operations ext4_file_inode_operations;
>  extern const struct file_operations ext4_file_operations;
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index a856997d87b5..4df1d074b393 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1608,6 +1608,7 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
>  	struct buffer_head *bh;
>  
>  	err = ext4_fname_prepare_lookup(dir, dentry, &fname);
> +	ext4_set_d_ops(dir, dentry);
>  	if (err == -ENOENT)
>  		return NULL;
>  	if (err)
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 1d82b56d9b11..ac593e9af270 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4498,11 +4498,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  		goto failed_mount4;
>  	}
>  
> -#ifdef CONFIG_UNICODE
> -	if (sbi->s_encoding)
> -		sb->s_d_op = &ext4_dentry_ops;
> -#endif
> -
>  	sb->s_root = d_make_root(root);
>  	if (!sb->s_root) {
>  		ext4_msg(sb, KERN_ERR, "get root dentry failed");
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 1a7bffe78ed5..0de461f2225a 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -120,6 +120,8 @@ static inline struct page *fscrypt_pagecache_page(struct page *bounce_page)
>  
>  extern void fscrypt_free_bounce_page(struct page *bounce_page);
>  
> +extern int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags);
> +
>  /* policy.c */
>  extern int fscrypt_ioctl_set_policy(struct file *, const void __user *);
>  extern int fscrypt_ioctl_get_policy(struct file *, void __user *);

-- 
Gabriel Krisman Bertazi
