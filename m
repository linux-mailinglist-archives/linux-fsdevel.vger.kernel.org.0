Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9657A260A24
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 07:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgIHFfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 01:35:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgIHFfB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 01:35:01 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEA282137B;
        Tue,  8 Sep 2020 05:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599543300;
        bh=4vd0SEL8gnp+glTmfFuC60bTm4xG1EFO1ycwUiS8Gfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNCU+DpbqOecM6VLqbTPBHfmA34dR1HJffhgIqUc+pOHe9X1nVpjV7ejFdmSHuphZ
         1dZlI2fKANkgVPRKqNGPbVUzOddeUxt3cLQQyjFlatdb0pgcrLRphQ4/KOp1gATBSl
         pazEwKZ4FEjKmqtXJSnewtOUul3vEiGkREFR02cs=
Date:   Mon, 7 Sep 2020 22:34:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v2 16/18] ceph: add support to readdir for encrypted
 filenames
Message-ID: <20200908053459.GN68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
 <20200904160537.76663-17-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904160537.76663-17-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 12:05:35PM -0400, Jeff Layton wrote:
> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> index 1b11e9af165e..88c672ccdcf8 100644
> --- a/fs/ceph/crypto.h
> +++ b/fs/ceph/crypto.h
> @@ -6,6 +6,8 @@
>  #ifndef _CEPH_CRYPTO_H
>  #define _CEPH_CRYPTO_H
>  
> +#include <linux/fscrypt.h>
> +
>  #ifdef CONFIG_FS_ENCRYPTION
>  
>  #define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
> @@ -16,6 +18,29 @@ int ceph_fscrypt_set_ops(struct super_block *sb);
>  int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
>  				 struct ceph_acl_sec_ctx *as);
>  
> +static inline int ceph_fname_alloc_buffer(struct inode *parent, struct fscrypt_str *fname)
> +{
> +	if (!IS_ENCRYPTED(parent))
> +		return 0;
> +	return fscrypt_fname_alloc_buffer(NAME_MAX, fname);
> +}
> +
> +static inline void ceph_fname_free_buffer(struct inode *parent, struct fscrypt_str *fname)
> +{
> +	if (IS_ENCRYPTED(parent))
> +		fscrypt_fname_free_buffer(fname);
> +}
> +
> +static inline int ceph_get_encryption_info(struct inode *inode)
> +{
> +	if (!IS_ENCRYPTED(inode))
> +		return 0;
> +	return fscrypt_get_encryption_info(inode);
> +}
> +
> +int ceph_fname_to_usr(struct inode *parent, char *name, u32 len,
> +			struct fscrypt_str *tname, struct fscrypt_str *oname);
> +
>  #else /* CONFIG_FS_ENCRYPTION */
>  
>  #define DUMMY_ENCRYPTION_ENABLED(fsc) (0)
> @@ -31,6 +56,28 @@ static inline int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *
>  	return 0;
>  }
>  
> +static inline int ceph_fname_alloc_buffer(struct inode *parent, struct fscrypt_str *fname)
> +{
> +	return 0;
> +}
> +
> +static inline void ceph_fname_free_buffer(struct inode *parent, struct fscrypt_str *fname)
> +{
> +}
> +
> +static inline int ceph_get_encryption_info(struct inode *inode)
> +{
> +	return 0;
> +}

This makes it so that readdir will succeed on encrypted directories when
!CONFIG_FS_ENCRYPTION.  The other filesystems instead return an error code,
which seems much better.  Can you check what the other filesystems handle
readdir?

> +static bool fscrypt_key_status_change(struct dentry *dentry)
> +{
> +	struct inode *dir;
> +	bool encrypted_name, have_key;
> +
> +	lockdep_assert_held(&dentry->d_lock);
> +
> +	dir = d_inode(dentry->d_parent);
> +	if (!IS_ENCRYPTED(dir))
> +		return false;
> +
> +	encrypted_name = dentry->d_flags & DCACHE_ENCRYPTED_NAME;
> +	have_key = fscrypt_has_encryption_key(dir);
> +
> +	if (encrypted_name == have_key)
> +		ceph_dir_clear_complete(dir);
> +
> +	dout("%s encrypted_name=%d have_key=%d\n", __func__, encrypted_name, have_key);
> +	return encrypted_name == have_key;
> +}
> +

Only the no-key => key case needs to be handled, not key => no-key.
Also, the caller already has 'dir', so there's no need to use ->d_parent.

What's wrong with just:

                di = ceph_dentry(dentry);
                if (d_unhashed(dentry) ||
                    d_really_is_negative(dentry) ||
                    di->lease_shared_gen != shared_gen ||
+                   ((dentry->d_flags & DCACHE_ENCRYPTED_NAME) &&
+                    fscrypt_has_encryption_key(dir)))  {
                        spin_unlock(&dentry->d_lock);
                        dput(dentry);
                        err = -EAGAIN;
                        goto out;
                }
>  /*
>   * When possible, we try to satisfy a readdir by peeking at the
>   * dcache.  We make this work by carefully ordering dentries on
> @@ -238,11 +261,11 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
>  			goto out;
>  		}
>  
> -		spin_lock(&dentry->d_lock);

Why delete this spin_lock()?

> +			if (IS_ENCRYPTED(inode) && !fscrypt_has_encryption_key(inode)) {
> +				spin_lock(&dn->d_lock);
> +				dn->d_flags |= DCACHE_ENCRYPTED_NAME;
> +				spin_unlock(&dn->d_lock);
> +			}

This is racy because fscrypt_has_encryption_key() could have been false when the
dentry was created, then true here.

Take a look at how __fscrypt_prepare_lookup() solves this problem.

- Eric
