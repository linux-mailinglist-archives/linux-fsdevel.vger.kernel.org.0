Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF9D3BE7F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 14:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhGGMb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 08:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231485AbhGGMb7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:31:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5651061C7C;
        Wed,  7 Jul 2021 12:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625660958;
        bh=IKwRYIgA9sblB4R6sPs+wSgkx2PZqDnqDhyFwot+gIs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Fx3e4dU6YX7emse9QIppWA9EwFbjmFFkFSGGwJmVi/oULMOF/t7HuYpGhLGuZg2ZR
         sGXRPZyjVVimjxeSwj747va5rs4YD1zvIlk51dIQw6i/2n39ojLX5zvb+ZJulXG4Rt
         p3izcIJvLZhd1TYKHnvsO7tmAIDPX0ma7Ahjrs70GJ4bvtGeXInBtshp6WipfEBW4r
         K4cdQRbLT6wX9rxENJsibYfzY1oyXX5k6+/kxvHEU0j9LpcfldxUd8YXIE/cb/NcyT
         H0o0wHwvo6FoLXURrvthvIUsqqAti9v8VEsbQZbMKnoCc4EllZyGxMNcYJgXD7iPxQ
         ZUx+JSKrfe9wA==
Message-ID: <793c1277c2f04eff1537407f873583bc26c5b848.camel@kernel.org>
Subject: Re: [RFC PATCH v7 11/24] ceph: add routine to create fscrypt
 context prior to RPC
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     ceph-devel@vger.kernel.org, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 07 Jul 2021 08:29:17 -0400
In-Reply-To: <YOWGZgcdx/6KcHsx@suse.de>
References: <20210625135834.12934-1-jlayton@kernel.org>
         <20210625135834.12934-12-jlayton@kernel.org> <YOWGZgcdx/6KcHsx@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-07-07 at 11:48 +0100, Luis Henriques wrote:
> On Fri, Jun 25, 2021 at 09:58:21AM -0400, Jeff Layton wrote:
> > After pre-creating a new inode, do an fscrypt prepare on it, fetch a
> > new encryption context and then marshal that into the security context
> > to be sent along with the RPC. Call the new function from
> > ceph_new_inode.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/crypto.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  fs/ceph/crypto.h | 25 +++++++++++++++++++++++++
> >  fs/ceph/inode.c  | 10 ++++++++--
> >  fs/ceph/super.h  |  5 +++++
> >  fs/ceph/xattr.c  |  3 +++
> >  5 files changed, 83 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > index 997a33e1d59f..675d41fd2eb0 100644
> > --- a/fs/ceph/crypto.c
> > +++ b/fs/ceph/crypto.c
> > @@ -4,6 +4,7 @@
> >  #include <linux/fscrypt.h>
> >  
> >  #include "super.h"
> > +#include "mds_client.h"
> >  #include "crypto.h"
> >  
> >  static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
> > @@ -86,3 +87,44 @@ void ceph_fscrypt_set_ops(struct super_block *sb)
> >  {
> >  	fscrypt_set_ops(sb, &ceph_fscrypt_ops);
> >  }
> > +
> > +int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
> > +				 struct ceph_acl_sec_ctx *as)
> > +{
> > +	int ret, ctxsize;
> > +	bool encrypted = false;
> > +	struct ceph_inode_info *ci = ceph_inode(inode);
> > +
> > +	ret = fscrypt_prepare_new_inode(dir, inode, &encrypted);
> > +	if (ret)
> > +		return ret;
> > +	if (!encrypted)
> > +		return 0;
> > +
> > +	as->fscrypt_auth = kzalloc(sizeof(*as->fscrypt_auth), GFP_KERNEL);
> > +	if (!as->fscrypt_auth)
> > +		return -ENOMEM;
> > +
> > +	ctxsize = fscrypt_context_for_new_inode(as->fscrypt_auth->cfa_blob, inode);
> > +	if (ctxsize < 0)
> > +		return ctxsize;
> > +
> > +	as->fscrypt_auth->cfa_version = cpu_to_le32(CEPH_FSCRYPT_AUTH_VERSION);
> > +	as->fscrypt_auth->cfa_blob_len = cpu_to_le32(ctxsize);
> > +
> > +	WARN_ON_ONCE(ci->fscrypt_auth);
> > +	kfree(ci->fscrypt_auth);
> 
> It's odd to have again a kfree() after a WARN_ON_ONCE() :-)
> 

Throw a warning but handle the case sanely? That seems normal to me :)

> > +	ci->fscrypt_auth_len = ceph_fscrypt_auth_size(ctxsize);
> > +	ci->fscrypt_auth = kmemdup(as->fscrypt_auth, ci->fscrypt_auth_len, GFP_KERNEL);
> > +	if (!ci->fscrypt_auth)
> > +		return -ENOMEM;
> > +
> > +	inode->i_flags |= S_ENCRYPTED;
> > +
> > +	return 0;
> > +}
> > +
> > +void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as)
> > +{
> > +	swap(req->r_fscrypt_auth, as->fscrypt_auth);
> > +}
> 
> This means that req->r_fscrypt_auth will need to be freed in
> ceph_mdsc_release_request().  (I believe you've moved this function to
> some other commit in your experimental branch).
> 

Ahh yes. Good catch. I'll fix that up too.

> > diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> > index d2b1f8e7b300..bdf1ba47db16 100644
> > --- a/fs/ceph/crypto.h
> > +++ b/fs/ceph/crypto.h
> > @@ -11,6 +11,9 @@
> >  #define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
> >  
> >  #ifdef CONFIG_FS_ENCRYPTION
> > +struct ceph_fs_client;
> > +struct ceph_acl_sec_ctx;
> > +struct ceph_mds_request;
> >  
> >  #define CEPH_FSCRYPT_AUTH_VERSION	1
> >  struct ceph_fscrypt_auth {
> > @@ -19,10 +22,19 @@ struct ceph_fscrypt_auth {
> >  	u8	cfa_blob[FSCRYPT_SET_CONTEXT_MAX_SIZE];
> >  } __packed;
> >  
> > +static inline u32 ceph_fscrypt_auth_size(u32 ctxsize)
> > +{
> > +	return offsetof(struct ceph_fscrypt_auth, cfa_blob) + ctxsize;
> > +}
> > +
> >  void ceph_fscrypt_set_ops(struct super_block *sb);
> >  
> >  void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
> >  
> > +int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
> > +				 struct ceph_acl_sec_ctx *as);
> > +void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as);
> > +
> >  #else /* CONFIG_FS_ENCRYPTION */
> >  
> >  static inline void ceph_fscrypt_set_ops(struct super_block *sb)
> > @@ -32,6 +44,19 @@ static inline void ceph_fscrypt_set_ops(struct super_block *sb)
> >  static inline void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc)
> >  {
> >  }
> > +
> > +static inline int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
> > +						struct ceph_acl_sec_ctx *as)
> > +{
> > +	if (IS_ENCRYPTED(dir))
> > +		return -EOPNOTSUPP;
> > +	return 0;
> > +}
> > +
> > +static inline void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req,
> > +						struct ceph_acl_sec_ctx *as_ctx)
> > +{
> > +}
> >  #endif /* CONFIG_FS_ENCRYPTION */
> >  
> >  #endif
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index fba139a4f57b..a0b311195e80 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -83,12 +83,17 @@ struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
> >  			goto out_err;
> >  	}
> >  
> > +	inode->i_state = 0;
> > +	inode->i_mode = *mode;
> > +
> >  	err = ceph_security_init_secctx(dentry, *mode, as_ctx);
> >  	if (err < 0)
> >  		goto out_err;
> >  
> > -	inode->i_state = 0;
> > -	inode->i_mode = *mode;
> > +	err = ceph_fscrypt_prepare_context(dir, inode, as_ctx);
> > +	if (err)
> > +		goto out_err;
> > +
> >  	return inode;
> >  out_err:
> >  	iput(inode);
> > @@ -101,6 +106,7 @@ void ceph_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *a
> >  		req->r_pagelist = as_ctx->pagelist;
> >  		as_ctx->pagelist = NULL;
> >  	}
> > +	ceph_fscrypt_as_ctx_to_req(req, as_ctx);
> >  }
> >  
> >  /**
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index 534c2a76562d..651d7909a443 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -26,6 +26,8 @@
> >  #include <linux/fscache.h>
> >  #endif
> > 
> > +#include "crypto.h"
> > +
> >  /* f_type in struct statfs */
> >  #define CEPH_SUPER_MAGIC 0x00c36400
> >  
> > @@ -1068,6 +1070,9 @@ struct ceph_acl_sec_ctx {
> >  #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
> >  	void *sec_ctx;
> >  	u32 sec_ctxlen;
> > +#endif
> > +#ifdef CONFIG_FS_ENCRYPTION
> > +	struct ceph_fscrypt_auth *fscrypt_auth;
> >  #endif
> >  	struct ceph_pagelist *pagelist;
> >  };
> > diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> > index 1242db8d3444..16a62a2bd61e 100644
> > --- a/fs/ceph/xattr.c
> > +++ b/fs/ceph/xattr.c
> > @@ -1362,6 +1362,9 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
> >  #endif
> >  #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
> >  	security_release_secctx(as_ctx->sec_ctx, as_ctx->sec_ctxlen);
> > +#endif
> > +#ifdef CONFIG_FS_ENCRYPTION
> > +	kfree(as_ctx->fscrypt_auth);
> >  #endif
> >  	if (as_ctx->pagelist)
> >  		ceph_pagelist_release(as_ctx->pagelist);
> > -- 
> > 2.31.1
> > 

-- 
Jeff Layton <jlayton@kernel.org>

