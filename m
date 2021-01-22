Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B67300A62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 18:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbhAVRvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 12:51:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729498AbhAVR1Y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:27:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 769A923A9A;
        Fri, 22 Jan 2021 17:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611336399;
        bh=1tEokNfyFasxoBx1qMykwyT98H3zjXxbGU+o59yKekI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=enRzpayif1D3SkCeaseoXkiIMmvhi3DtLynANBOwymMbdvVC96dRpcTvxQoS/cv1j
         izHk0Jg1xR2WTJ+PQ51Y01NWQIlvHgGVSutZlyw0/SQf3mCl2AuoNQGsdGnLAdL0HP
         5k9OVgKMWk7gC8hCZn+LBgAwWzmH5kNWkxVSKafKlAzNwgbMIwO/l8FQ8fnGegkggp
         WoPD9pSYWqMiZr56U6X9XcRx5xLXevmGCTxpIRZrxmzyAVZ5HW65/fSFLKTwgot8UB
         uoyct8b7ylsZRCeyokitclSADgbTeUa4ONhv/QtfhXRMzxPIHS85yxMm9krIPgeUtz
         7jaj8cZ3shM/w==
Message-ID: <48cd711c7f99e6bd52f4ba0565eb54589843ac89.camel@kernel.org>
Subject: Re: [RFC PATCH v4 05/17] ceph: crypto context handling for ceph
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 22 Jan 2021 12:26:38 -0500
In-Reply-To: <87y2gk53ft.fsf@suse.de>
References: <20210120182847.644850-1-jlayton@kernel.org>
         <20210120182847.644850-6-jlayton@kernel.org> <87y2gk53ft.fsf@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-01-22 at 16:41 +0000, Luis Henriques wrote:
> Jeff Layton <jlayton@kernel.org> writes:
> 
> > Store the fscrypt context for an inode as an encryption.ctx xattr.
> > When we get a new inode in a trace, set the S_ENCRYPTED bit if
> > the xattr blob has an encryption.ctx xattr.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/Makefile |  1 +
> >  fs/ceph/crypto.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  fs/ceph/crypto.h | 24 ++++++++++++++++++++++++
> >  fs/ceph/inode.c  |  6 ++++++
> >  fs/ceph/super.c  |  3 +++
> >  fs/ceph/super.h  |  1 +
> >  fs/ceph/xattr.c  | 32 ++++++++++++++++++++++++++++++++
> >  7 files changed, 109 insertions(+)
> >  create mode 100644 fs/ceph/crypto.c
> >  create mode 100644 fs/ceph/crypto.h
> > 
> > diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
> > index 50c635dc7f71..1f77ca04c426 100644
> > --- a/fs/ceph/Makefile
> > +++ b/fs/ceph/Makefile
> > @@ -12,3 +12,4 @@ ceph-y := super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
> >  
> > 
> > 
> > 
> >  ceph-$(CONFIG_CEPH_FSCACHE) += cache.o
> >  ceph-$(CONFIG_CEPH_FS_POSIX_ACL) += acl.o
> > +ceph-$(CONFIG_FS_ENCRYPTION) += crypto.o
> > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > new file mode 100644
> > index 000000000000..dbe8b60fd1b0
> > --- /dev/null
> > +++ b/fs/ceph/crypto.c
> > @@ -0,0 +1,42 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/ceph/ceph_debug.h>
> > +#include <linux/xattr.h>
> > +#include <linux/fscrypt.h>
> > +
> > +#include "super.h"
> > +#include "crypto.h"
> > +
> > +static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
> > +{
> > +	return __ceph_getxattr(inode, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT, ctx, len);
> > +}
> > +
> > +static int ceph_crypt_set_context(struct inode *inode, const void *ctx, size_t len, void *fs_data)
> > +{
> > +	int ret;
> > +
> > +	WARN_ON_ONCE(fs_data);
> > +	ret = __ceph_setxattr(inode, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT, ctx, len, XATTR_CREATE);
> > +	if (ret == 0)
> > +		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
> > +	return ret;
> > +}
> > +
> > +static bool ceph_crypt_empty_dir(struct inode *inode)
> > +{
> > +	struct ceph_inode_info *ci = ceph_inode(inode);
> > +
> > +	return ci->i_rsubdirs + ci->i_rfiles == 1;
> > +}
> 
> This is very tricky, as this check can't really guaranty that the
> directory is empty.  We need to make sure no other client has access to
> this directory during the whole operation of setting policy.  Would it be
> enough to ensure we have Fxc here?
> 

That's a good point. Yes, we probably should do just that. I'll take a
look and see what we need as far as caps go to ensure exclusion.

empty_dir is only called when setting the context, so we can grab cap
refs at that point and then just check to make sure it's empty here.

> > +
> > +static struct fscrypt_operations ceph_fscrypt_ops = {
> > +	.get_context		= ceph_crypt_get_context,
> > +	.set_context		= ceph_crypt_set_context,
> > +	.empty_dir		= ceph_crypt_empty_dir,
> > +	.max_namelen		= NAME_MAX,
> > +};
> > +
> > +void ceph_fscrypt_set_ops(struct super_block *sb)
> > +{
> > +	fscrypt_set_ops(sb, &ceph_fscrypt_ops);
> > +}
> > diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> > new file mode 100644
> > index 000000000000..189bd8424284
> > --- /dev/null
> > +++ b/fs/ceph/crypto.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Ceph fscrypt functionality
> > + */
> > +
> > +#ifndef _CEPH_CRYPTO_H
> > +#define _CEPH_CRYPTO_H
> > +
> > +#include <linux/fscrypt.h>
> > +
> > +#define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
> > +
> > +#ifdef CONFIG_FS_ENCRYPTION
> > +void ceph_fscrypt_set_ops(struct super_block *sb);
> > +
> > +#else /* CONFIG_FS_ENCRYPTION */
> > +
> > +static inline void ceph_fscrypt_set_ops(struct super_block *sb)
> > +{
> > +}
> > +
> > +#endif /* CONFIG_FS_ENCRYPTION */
> > +
> > +#endif
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index 5d20a620e96c..d465ad48ade5 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -14,10 +14,12 @@
> >  #include <linux/random.h>
> >  #include <linux/sort.h>
> >  #include <linux/iversion.h>
> > +#include <linux/fscrypt.h>
> >  
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> >  #include "super.h"
> >  #include "mds_client.h"
> >  #include "cache.h"
> > +#include "crypto.h"
> >  #include <linux/ceph/decode.h>
> >  
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> >  /*
> > @@ -553,6 +555,7 @@ void ceph_evict_inode(struct inode *inode)
> >  	clear_inode(inode);
> >  
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> >  	ceph_fscache_unregister_inode_cookie(ci);
> > +	fscrypt_put_encryption_info(inode);
> >  
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> >  	__ceph_remove_caps(ci);
> >  
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > @@ -912,6 +915,9 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
> >  		ceph_forget_all_cached_acls(inode);
> >  		ceph_security_invalidate_secctx(inode);
> >  		xattr_blob = NULL;
> > +		if ((inode->i_state & I_NEW) &&
> > +		     ceph_inode_has_xattr(ci, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT))
> > +			inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
> >  	}
> >  
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> >  	/* finally update i_version */
> > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > index 9b1b7f4cfdd4..cdac6ff675e2 100644
> > --- a/fs/ceph/super.c
> > +++ b/fs/ceph/super.c
> > @@ -20,6 +20,7 @@
> >  #include "super.h"
> >  #include "mds_client.h"
> >  #include "cache.h"
> > +#include "crypto.h"
> >  
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> >  #include <linux/ceph/ceph_features.h>
> >  #include <linux/ceph/decode.h>
> > @@ -988,6 +989,8 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
> >  	s->s_time_min = 0;
> >  	s->s_time_max = U32_MAX;
> >  
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > +	ceph_fscrypt_set_ops(s);
> > +
> >  	ret = set_anon_super_fc(s, fc);
> >  	if (ret != 0)
> >  		fsc->sb = NULL;
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index 13b02887b085..efe2e963c631 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -1013,6 +1013,7 @@ extern ssize_t ceph_listxattr(struct dentry *, char *, size_t);
> >  extern struct ceph_buffer *__ceph_build_xattrs_blob(struct ceph_inode_info *ci);
> >  extern void __ceph_destroy_xattrs(struct ceph_inode_info *ci);
> >  extern const struct xattr_handler *ceph_xattr_handlers[];
> > +bool ceph_inode_has_xattr(struct ceph_inode_info *ci, const char *name);
> >  
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> >  struct ceph_acl_sec_ctx {
> >  #ifdef CONFIG_CEPH_FS_POSIX_ACL
> > diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> > index 24997982de01..d0d719b768e4 100644
> > --- a/fs/ceph/xattr.c
> > +++ b/fs/ceph/xattr.c
> > @@ -1359,6 +1359,38 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
> >  		ceph_pagelist_release(as_ctx->pagelist);
> >  }
> >  
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > +/* Return true if inode's xattr blob has an xattr named "name" */
> > +bool ceph_inode_has_xattr(struct ceph_inode_info *ci, const char *name)
> > +{
> > +	void *p, *end;
> > +	u32 numattr;
> > +	size_t namelen;
> > +
> > +	lockdep_assert_held(&ci->i_ceph_lock);
> > +
> > +	if (!ci->i_xattrs.blob || ci->i_xattrs.blob->vec.iov_len <= 4)
> > +		return false;
> > +
> > +	namelen = strlen(name);
> > +	p = ci->i_xattrs.blob->vec.iov_base;
> > +	end = p + ci->i_xattrs.blob->vec.iov_len;
> > +	ceph_decode_32_safe(&p, end, numattr, bad);
> > +
> > +	while (numattr--) {
> > +		u32 len;
> > +
> > +		ceph_decode_32_safe(&p, end, len, bad);
> > +		ceph_decode_need(&p, end, len, bad);
> > +		if (len == namelen && !memcmp(p, name, len))
> > +			return true;
> > +		p += len;
> > +		ceph_decode_32_safe(&p, end, len, bad);
> > +		ceph_decode_skip_n(&p, end, len, bad);
> > +	}
> > +bad:
> > +	return false;
> > +}
> 
> I wonder if it wouldn't be better have an extra flag in struct
> ceph_inode_info instead of having to go through the xattr list every time
> we update an inode with data from the MDS.
> 

It is ugly, I'll grant you that. A flag in ceph_inode_info won't really
help though. We'd need some sort of flag in the inode info transmitted
from the MDS.

For now, we only call this for I_NEW inodes, but now I'm wondering if we
need to check it every time, to ensure that everything works if you see
the directory before another client encrypts it.

We may want to extend the protocol with such a flag, but the xattr
buffer is not usually that long. For now, I'm inclined to live with
parsing this info each time.

> > 
> > +
> >  /*
> >   * List of handlers for synthetic system.* attributes. Other
> >   * attributes are handled directly.
> > -- 
> > 
> > 2.29.2
> > 
> 

-- 
Jeff Layton <jlayton@kernel.org>

