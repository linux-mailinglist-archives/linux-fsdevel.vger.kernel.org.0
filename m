Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AF1269ACC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 03:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgIOBAK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 21:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgIOBAJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:00:09 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CFDA20897;
        Tue, 15 Sep 2020 01:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600131608;
        bh=IbaPkFrhAxdJSC83VEKLmmgUVkpafpKKB64Q7AESnO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2ptrCfeNLPq6LkBx0O4Oe6DsYFsXHzhANeJTQK4cMP12AjNh9VJKpQLxpzcVKUFG
         A341KcnDaKUXgt0AvDW83AhltbflPiLGxGkxT53aI1tzZ0jkqrFySuX8Jpq0mfzSNX
         m2V3aGx1x1P3FxJpmHFrMDaekJeRjaE2Yi3qSaII=
Date:   Mon, 14 Sep 2020 18:00:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v3 07/16] ceph: crypto context handling for ceph
Message-ID: <20200915010007.GG899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
 <20200914191707.380444-8-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914191707.380444-8-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:16:58PM -0400, Jeff Layton wrote:
> +static const union fscrypt_context *
> +ceph_get_dummy_context(struct super_block *sb)
> +{
> +	return ceph_sb_to_client(sb)->dummy_enc_ctx.ctx;
> +}

This hunk needs to go in the patch that adds test_dummy_encryption support.

> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> new file mode 100644
> index 000000000000..b5f38ee80553
> --- /dev/null
> +++ b/fs/ceph/crypto.h
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0

checkpatch wants a /* comment */ here, not a // comment.

Can you run checkpatch on the whole patchset and fix the warnings?

> +/*
> + * Ceph fscrypt functionality
> + */
> +
> +#ifndef _CEPH_CRYPTO_H
> +#define _CEPH_CRYPTO_H
> +
> +#ifdef CONFIG_FS_ENCRYPTION
> +
> +#define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
> +
> +void ceph_fscrypt_set_ops(struct super_block *sb);
> +
> +#else /* CONFIG_FS_ENCRYPTION */
> +
> +static inline int ceph_fscrypt_set_ops(struct super_block *sb)
> +{
> +	return 0;
> +}

The !CONFIG_FS_ENCRYPTION version of ceph_fscrypt_set_ops() needs to return
void.

> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 526faf4778ce..daae18267fd8 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -549,6 +549,7 @@ void ceph_evict_inode(struct inode *inode)
>  
>  	percpu_counter_dec(&mdsc->metric.total_inodes);
>  
> +	fscrypt_put_encryption_info(inode);
>  	truncate_inode_pages_final(&inode->i_data);
>  	clear_inode(inode);

Is it correct for fscrypt_put_encryption_info() to go before
truncate_inode_pages_final()?  The other filesystems call
fscrypt_put_encryption_info() later.  Note that all I/O needs to be done before
calling fscrypt_put_encryption_info().

> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index b3fc9bb61afc..055180218224 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -20,6 +20,7 @@
>  #include "super.h"
>  #include "mds_client.h"
>  #include "cache.h"
> +#include "crypto.h"
>  
>  #include <linux/ceph/ceph_features.h>
>  #include <linux/ceph/decode.h>
> @@ -984,6 +985,10 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
>  	s->s_time_min = 0;
>  	s->s_time_max = U32_MAX;
>  
> +	ret = ceph_fscrypt_set_ops(s);
> +	if (ret)
> +		goto out;
> +

This part doesn't compile when CONFIG_FS_ENCRYPTION=y.  It got fixed in a later
patch, but it should be fixed here.

> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 483a52d281cd..cc39cc36de77 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -985,6 +985,7 @@ extern ssize_t ceph_listxattr(struct dentry *, char *, size_t);
>  extern struct ceph_buffer *__ceph_build_xattrs_blob(struct ceph_inode_info *ci);
>  extern void __ceph_destroy_xattrs(struct ceph_inode_info *ci);
>  extern const struct xattr_handler *ceph_xattr_handlers[];
> +bool ceph_inode_has_xattr(struct ceph_inode_info *ci, char *name);
>  
>  struct ceph_acl_sec_ctx {
>  #ifdef CONFIG_CEPH_FS_POSIX_ACL
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 3a733ac33d9b..9dcb060cba9a 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1283,6 +1283,38 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
>  		ceph_pagelist_release(as_ctx->pagelist);
>  }
>  
> +/* Return true if inode's xattr blob has an xattr named "name" */
> +bool ceph_inode_has_xattr(struct ceph_inode_info *ci, char *name)

Use 'const char *' instead of 'char *'?


- Eric
