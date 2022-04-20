Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA76509011
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 21:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348096AbiDTTNb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 15:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347774AbiDTTNa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:13:30 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF532AE3D;
        Wed, 20 Apr 2022 12:10:43 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6627A6090; Wed, 20 Apr 2022 15:10:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6627A6090
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1650481842;
        bh=A8pvKFoxnNuHyK91SmuRn/6WTwjgjP+n9Q0E97QWhgU=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=PGm72LGPbjhuqevSO7j0bQ96GPtYQn+bxSwH6MZ/NKo07K+UdaHHD9UIJG4HwEX73
         mfHmEF9HL6wmCZRQG5hYGOoYSIFyN2xAdGp3V9Bo/9YyrQLykcF5olUvlTeXKAVXzm
         ff7y6w202m7FWkVXj5TR6Orpkdkw+ewuGAZQWZpU=
Date:   Wed, 20 Apr 2022 15:10:42 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 4/8] NFSD: Refactor NFSv3 CREATE
Message-ID: <20220420191042.GA27805@fieldses.org>
References: <165047903719.1829.18357114060053600197.stgit@manet.1015granger.net>
 <165047934027.1829.4170855794285748158.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165047934027.1829.4170855794285748158.stgit@manet.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 20, 2022 at 02:29:00PM -0400, Chuck Lever wrote:
> The NFSv3 CREATE and NFSv4 OPEN(CREATE) use cases are about to
> diverge such that it makes sense to split do_nfsd_create() into one
> version for NFSv3 and one for NFSv4.
> 
> As a first step, copy do_nfsd_create() to nfs3proc.c and remove
> NFSv4-specific logic.
> 
> One immediate legibility benefit is that the logic for handling
> NFSv3 createhow is now quite straightforward. NFSv4 createhow
> has some subtleties that IMO do not belong in generic code.

That makes sense to me, though just eyeballing the two resulting
functions, you end up with a *lot* of duplication.  I wonder if it'd be
possible to keep the two paths free of complications from each other
while sharing more code, e.g. if there are logical blocks of code that
could now be pulled out into common helpers.

--b.

> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs3proc.c |  127 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 121 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 981a2a71c5af..981a3a7a6e16 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -8,6 +8,7 @@
>  #include <linux/fs.h>
>  #include <linux/ext2_fs.h>
>  #include <linux/magic.h>
> +#include <linux/namei.h>
>  
>  #include "cache.h"
>  #include "xdr3.h"
> @@ -220,10 +221,126 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
>  }
>  
>  /*
> - * With NFSv3, CREATE processing is a lot easier than with NFSv2.
> - * At least in theory; we'll see how it fares in practice when the
> - * first reports about SunOS compatibility problems start to pour in...
> + * Implement NFSv3's unchecked, guarded, and exclusive CREATE
> + * semantics for regular files. Except for the created file,
> + * this operation is stateless on the server.
> + *
> + * Upon return, caller must release @fhp and @resfhp.
>   */
> +static __be32
> +nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		  struct svc_fh *resfhp, struct nfsd3_createargs *argp)
> +{
> +	struct iattr *iap = &argp->attrs;
> +	struct dentry *parent, *child;
> +	__u32 v_mtime, v_atime;
> +	struct inode *inode;
> +	__be32 status;
> +	int host_err;
> +
> +	if (isdotent(argp->name, argp->len))
> +		return nfserr_exist;
> +	if (!(iap->ia_valid & ATTR_MODE))
> +		iap->ia_mode = 0;
> +
> +	status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
> +	if (status != nfs_ok)
> +		return status;
> +
> +	parent = fhp->fh_dentry;
> +	inode = d_inode(parent);
> +
> +	host_err = fh_want_write(fhp);
> +	if (host_err)
> +		return nfserrno(host_err);
> +
> +	fh_lock_nested(fhp, I_MUTEX_PARENT);
> +
> +	child = lookup_one_len(argp->name, parent, argp->len);
> +	if (IS_ERR(child)) {
> +		status = nfserrno(PTR_ERR(child));
> +		goto out;
> +	}
> +
> +	if (d_really_is_negative(child)) {
> +		status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
> +		if (status != nfs_ok)
> +			goto out;
> +	}
> +
> +	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
> +	if (status != nfs_ok)
> +		goto out;
> +
> +	v_mtime = 0;
> +	v_atime = 0;
> +	if (argp->createmode == NFS3_CREATE_EXCLUSIVE) {
> +		u32 *verifier = (u32 *)argp->verf;
> +
> +		/*
> +		 * Solaris 7 gets confused (bugid 4218508) if these have
> +		 * the high bit set, as do xfs filesystems without the
> +		 * "bigtime" feature. So just clear the high bits.
> +		 */
> +		v_mtime = verifier[0] & 0x7fffffff;
> +		v_atime = verifier[1] & 0x7fffffff;
> +	}
> +
> +	if (d_really_is_positive(child)) {
> +		status = nfs_ok;
> +
> +		switch (argp->createmode) {
> +		case NFS3_CREATE_UNCHECKED:
> +			if (!d_is_reg(child))
> +				break;
> +			iap->ia_valid &= ATTR_SIZE;
> +			goto set_attr;
> +		case NFS3_CREATE_GUARDED:
> +			status = nfserr_exist;
> +			break;
> +		case NFS3_CREATE_EXCLUSIVE:
> +			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
> +			    d_inode(child)->i_atime.tv_sec == v_atime &&
> +			    d_inode(child)->i_size == 0) {
> +				break;
> +			}
> +			status = nfserr_exist;
> +		}
> +		goto out;
> +	}
> +
> +	if (!IS_POSIXACL(inode))
> +		iap->ia_mode &= ~current_umask();
> +
> +	host_err = vfs_create(&init_user_ns, inode, child, iap->ia_mode, true);
> +	if (host_err < 0) {
> +		status = nfserrno(host_err);
> +		goto out;
> +	}
> +
> +	/* A newly created file already has a file size of zero. */
> +	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size == 0))
> +		iap->ia_valid &= ~ATTR_SIZE;
> +	if (argp->createmode == NFS3_CREATE_EXCLUSIVE) {
> +		iap->ia_valid = ATTR_MTIME | ATTR_ATIME |
> +				ATTR_MTIME_SET | ATTR_ATIME_SET;
> +		iap->ia_mtime.tv_sec = v_mtime;
> +		iap->ia_atime.tv_sec = v_atime;
> +		iap->ia_mtime.tv_nsec = 0;
> +		iap->ia_atime.tv_nsec = 0;
> +	}
> +
> +set_attr:
> +	status = nfsd_create_setattr(rqstp, fhp, resfhp, iap);
> +
> +out:
> +	fh_unlock(fhp);
> +	if (child && !IS_ERR(child))
> +		dput(child);
> +	fh_drop_write(fhp);
> +	return status;
> +}
> +
>  static __be32
>  nfsd3_proc_create(struct svc_rqst *rqstp)
>  {
> @@ -239,9 +356,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
>  	dirfhp = fh_copy(&resp->dirfh, &argp->fh);
>  	newfhp = fh_init(&resp->fh, NFS3_FHSIZE);
>  
> -	resp->status = do_nfsd_create(rqstp, dirfhp, argp->name, argp->len,
> -				      &argp->attrs, newfhp, argp->createmode,
> -				      (u32 *)argp->verf, NULL, NULL);
> +	resp->status = nfsd3_create_file(rqstp, dirfhp, newfhp, argp);
>  	return rpc_success;
>  }
>  
> 
