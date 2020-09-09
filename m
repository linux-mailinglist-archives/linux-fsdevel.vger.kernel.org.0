Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DC0262EE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 15:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgIINF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 09:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730260AbgIINEk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:04:40 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CB4B21D7E;
        Wed,  9 Sep 2020 13:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599656551;
        bh=6zMjrl/YbojE1hnzKJtcDrSBETP1uBHaRuxNOAI3DU4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VP/ls1VgCa8hNX83ZCVsmrGRv3Rd+vX/ALPcucnJV++T0WJrK7EQUUFlSUxUJxdUC
         5QaK12iXC7jyvKhOw0M0hU/KWi+L+vnKToKQ0BpGsjkvM/ZB4rkF7ghRSN8/4MVb1Q
         D0kKy8v2JfAERRxGTGr6dEeHQUGgL2di7xpbuvng=
Message-ID: <0e6b21ceae302f691fe9a66bc918c4c2b28d3049.camel@kernel.org>
Subject: Re: [RFC PATCH v2 16/18] ceph: add support to readdir for encrypted
 filenames
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Date:   Wed, 09 Sep 2020 09:02:30 -0400
In-Reply-To: <20200908053459.GN68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
         <20200904160537.76663-17-jlayton@kernel.org>
         <20200908053459.GN68127@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-09-07 at 22:34 -0700, Eric Biggers wrote:
> On Fri, Sep 04, 2020 at 12:05:35PM -0400, Jeff Layton wrote:
> > diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> > index 1b11e9af165e..88c672ccdcf8 100644
> > --- a/fs/ceph/crypto.h
> > +++ b/fs/ceph/crypto.h
> > @@ -6,6 +6,8 @@
> >  #ifndef _CEPH_CRYPTO_H
> >  #define _CEPH_CRYPTO_H
> >  
> > +#include <linux/fscrypt.h>
> > +
> >  #ifdef CONFIG_FS_ENCRYPTION
> >  
> >  #define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
> > @@ -16,6 +18,29 @@ int ceph_fscrypt_set_ops(struct super_block *sb);
> >  int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
> >  				 struct ceph_acl_sec_ctx *as);
> >  
> > +static inline int ceph_fname_alloc_buffer(struct inode *parent, struct fscrypt_str *fname)
> > +{
> > +	if (!IS_ENCRYPTED(parent))
> > +		return 0;
> > +	return fscrypt_fname_alloc_buffer(NAME_MAX, fname);
> > +}
> > +
> > +static inline void ceph_fname_free_buffer(struct inode *parent, struct fscrypt_str *fname)
> > +{
> > +	if (IS_ENCRYPTED(parent))
> > +		fscrypt_fname_free_buffer(fname);
> > +}
> > +
> > +static inline int ceph_get_encryption_info(struct inode *inode)
> > +{
> > +	if (!IS_ENCRYPTED(inode))
> > +		return 0;
> > +	return fscrypt_get_encryption_info(inode);
> > +}
> > +
> > +int ceph_fname_to_usr(struct inode *parent, char *name, u32 len,
> > +			struct fscrypt_str *tname, struct fscrypt_str *oname);
> > +
> >  #else /* CONFIG_FS_ENCRYPTION */
> >  
> >  #define DUMMY_ENCRYPTION_ENABLED(fsc) (0)
> > @@ -31,6 +56,28 @@ static inline int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *
> >  	return 0;
> >  }
> >  
> > +static inline int ceph_fname_alloc_buffer(struct inode *parent, struct fscrypt_str *fname)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline void ceph_fname_free_buffer(struct inode *parent, struct fscrypt_str *fname)
> > +{
> > +}
> > +
> > +static inline int ceph_get_encryption_info(struct inode *inode)
> > +{
> > +	return 0;
> > +}
> 
> This makes it so that readdir will succeed on encrypted directories when
> !CONFIG_FS_ENCRYPTION.  The other filesystems instead return an error code,
> which seems much better.  Can you check what the other filesystems handle
> readdir?
>

Maybe. I'm not sure it's better.

It would be nice to be able to allow such clients to be able to clean
out an encrypted tree (given appropriate permissions, of course).

A network filesystem like this is a much different case than a local
one. We may have a swath of varying client kernel versions and
configurations that are operating on the same filesystem.

Where we draw that line is still being determined though.

> > +static bool fscrypt_key_status_change(struct dentry *dentry)
> > +{
> > +	struct inode *dir;
> > +	bool encrypted_name, have_key;
> > +
> > +	lockdep_assert_held(&dentry->d_lock);
> > +
> > +	dir = d_inode(dentry->d_parent);
> > +	if (!IS_ENCRYPTED(dir))
> > +		return false;
> > +
> > +	encrypted_name = dentry->d_flags & DCACHE_ENCRYPTED_NAME;
> > +	have_key = fscrypt_has_encryption_key(dir);
> > +
> > +	if (encrypted_name == have_key)
> > +		ceph_dir_clear_complete(dir);
> > +
> > +	dout("%s encrypted_name=%d have_key=%d\n", __func__, encrypted_name, have_key);
> > +	return encrypted_name == have_key;
> > +}
> > +
> 
> Only the no-key => key case needs to be handled, not key => no-key.
> Also, the caller already has 'dir', so there's no need to use ->d_parent.
> 
> What's wrong with just:
> 
>                 di = ceph_dentry(dentry);
>                 if (d_unhashed(dentry) ||
>                     d_really_is_negative(dentry) ||
>                     di->lease_shared_gen != shared_gen ||
> +                   ((dentry->d_flags & DCACHE_ENCRYPTED_NAME) &&
> +                    fscrypt_has_encryption_key(dir)))  {
>                         spin_unlock(&dentry->d_lock);
>                         dput(dentry);
>                         err = -EAGAIN;
>                         goto out;
>                 }

Ok, I didn't realize that I didn't need to worry about key removal. Your
proposed scheme is simpler.

> >  /*
> >   * When possible, we try to satisfy a readdir by peeking at the
> >   * dcache.  We make this work by carefully ordering dentries on
> > @@ -238,11 +261,11 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
> >  			goto out;
> >  		}
> >  
> > -		spin_lock(&dentry->d_lock);
> 
> Why delete this spin_lock()?
> 

Yikes -- good catch! Fixed.

> > +			if (IS_ENCRYPTED(inode) && !fscrypt_has_encryption_key(inode)) {
> > +				spin_lock(&dn->d_lock);
> > +				dn->d_flags |= DCACHE_ENCRYPTED_NAME;
> > +				spin_unlock(&dn->d_lock);
> > +			}
> 
> This is racy because fscrypt_has_encryption_key() could have been false when the
> dentry was created, then true here.
> 
> Take a look at how __fscrypt_prepare_lookup() solves this problem.

Blech.

I guess I need to have ceph_fname_to_usr tell whether the name is a
nokey name, but that info is not currently returned
by fscrypt_fname_disk_to_usr. I guess it will need to be...

-- 
Jeff Layton <jlayton@kernel.org>

