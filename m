Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B15788E65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 20:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjHYSPj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 14:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjHYSPV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:15:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30864269F;
        Fri, 25 Aug 2023 11:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9B7366230;
        Fri, 25 Aug 2023 18:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208E6C433C8;
        Fri, 25 Aug 2023 18:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692987297;
        bh=64/AbvPkLgB4e19cCOpDNOspz3haSwXirK4b3QstYXk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AjDkN2LJt6FhlqjmjJV4tEDNoUAoeAcD+YlxU2802HMiyOFf0PRvyjS7L1jXphHCK
         mRWB6qLbr6ShqZRIkZHINdunAWkNZ5Jow1qHq77Nm7cxNl+jtHTNJRw0Zr/6mfXRdd
         i9pZIj+GO9Rl3nr/Ajoo0wjIl0ruyv66xaKEoVE1LN2AEKx9X0/AYCAA17VnvU/FJb
         MCqzZwFnKk/jPeN47Px8sovlhlQ/qCU0O5eYezWlczFjAPBtUACsBPX9xV2rOf/XRy
         eAQutXBJPqjak01ZwpKuPkghLttpDFcX0dQusD2O3CMXshy9x7fzmgP3w4VNgVk6pv
         F9SbwPxCCbeow==
Message-ID: <6711ad3dc3a97878dca300d0fa67e0d57665e52e.camel@kernel.org>
Subject: Re: [PATCH 1/7] lockd: introduce safe async lock op
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>, linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Date:   Fri, 25 Aug 2023 14:14:54 -0400
In-Reply-To: <20230823213352.1971009-2-aahringo@redhat.com>
References: <20230823213352.1971009-1-aahringo@redhat.com>
         <20230823213352.1971009-2-aahringo@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-08-23 at 17:33 -0400, Alexander Aring wrote:
> This patch reverts mostly commit 40595cdc93ed ("nfs: block notification
> on fs with its own ->lock") and introduces an EXPORT_OP_SAFE_ASYNC_LOCK
> export flag to signal that the "own ->lock" implementation supports
> async lock requests. The only main user is DLM that is used by GFS2 and
> OCFS2 filesystem. Those implement their own lock() implementation and
> return FILE_LOCK_DEFERRED as return value. Since commit 40595cdc93ed
> ("nfs: block notification on fs with its own ->lock") the DLM
> implementation were never updated. This patch should prepare for DLM
> to set the EXPORT_OP_SAFE_ASYNC_LOCK export flag and update the DLM
> plock implementation regarding to it.
>=20
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/lockd/svclock.c       |  5 ++---
>  fs/nfsd/nfs4state.c      | 13 ++++++++++---
>  include/linux/exportfs.h |  8 ++++++++
>  3 files changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index c43ccdf28ed9..6e3b230e8317 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -470,9 +470,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
file,
>  	    struct nlm_host *host, struct nlm_lock *lock, int wait,
>  	    struct nlm_cookie *cookie, int reclaim)
>  {
> -#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>  	struct inode		*inode =3D nlmsvc_file_inode(file);
> -#endif
>  	struct nlm_block	*block =3D NULL;
>  	int			error;
>  	int			mode;
> @@ -486,7 +484,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
file,
>  				(long long)lock->fl.fl_end,
>  				wait);
> =20
> -	if (nlmsvc_file_file(file)->f_op->lock) {
> +	if (!export_op_support_safe_async_lock(inode->i_sb->s_export_op,
> +					       nlmsvc_file_file(file)->f_op)) {
>  		async_block =3D wait;
>  		wait =3D 0;
>  	}
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 3aefbad4cc09..14ca06424ff1 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7430,6 +7430,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
>  	struct nfsd4_blocked_lock *nbl =3D NULL;
>  	struct file_lock *file_lock =3D NULL;
>  	struct file_lock *conflock =3D NULL;
> +	struct super_block *sb;
>  	__be32 status =3D 0;
>  	int lkflg;
>  	int err;
> @@ -7451,6 +7452,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
>  		dprintk("NFSD: nfsd4_lock: permission denied!\n");
>  		return status;
>  	}
> +	sb =3D cstate->current_fh.fh_dentry->d_sb;
> =20
>  	if (lock->lk_is_new) {
>  		if (nfsd4_has_session(cstate))
> @@ -7502,7 +7504,9 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
>  	fp =3D lock_stp->st_stid.sc_file;
>  	switch (lock->lk_type) {
>  		case NFS4_READW_LT:
> -			if (nfsd4_has_session(cstate))
> +			if (nfsd4_has_session(cstate) ||
> +			    export_op_support_safe_async_lock(sb->s_export_op,
> +							      nf->nf_file->f_op))
>  				fl_flags |=3D FL_SLEEP;
>  			fallthrough;
>  		case NFS4_READ_LT:
> @@ -7514,7 +7518,9 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
>  			fl_type =3D F_RDLCK;
>  			break;
>  		case NFS4_WRITEW_LT:
> -			if (nfsd4_has_session(cstate))
> +			if (nfsd4_has_session(cstate) ||
> +			    export_op_support_safe_async_lock(sb->s_export_op,
> +							      nf->nf_file->f_op))
>  				fl_flags |=3D FL_SLEEP;
>  			fallthrough;
>  		case NFS4_WRITE_LT:
> @@ -7542,7 +7548,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
>  	 * for file locks), so don't attempt blocking lock notifications
>  	 * on those filesystems:
>  	 */
> -	if (nf->nf_file->f_op->lock)
> +	if (!export_op_support_safe_async_lock(sb->s_export_op,
> +					       nf->nf_file->f_op))
>  		fl_flags &=3D ~FL_SLEEP;
> =20
>  	nbl =3D find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 11fbd0ee1370..10358a93cdc1 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -3,6 +3,7 @@
>  #define LINUX_EXPORTFS_H 1
> =20
>  #include <linux/types.h>
> +#include <linux/fs.h>
> =20
>  struct dentry;
>  struct iattr;
> @@ -224,9 +225,16 @@ struct export_operations {
>  						  atomic attribute updates
>  						*/
>  #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close=
 */
> +#define EXPORT_OP_SAFE_ASYNC_LOCK	(0x40) /* fs can do async lock request=
 */
>  	unsigned long	flags;
>  };
> =20
> +static inline bool export_op_support_safe_async_lock(const struct export=
_operations *export_ops,
> +						     const struct file_operations *f_op)
> +{
> +	return (export_ops->flags & EXPORT_OP_SAFE_ASYNC_LOCK) || !f_op->lock;
> +}
> +
>  extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid=
,
>  				    int *max_len, struct inode *parent,
>  				    int flags);

Conceptually, this looks fine, but I agree with Chuck's stylistic
points.

--=20
Jeff Layton <jlayton@kernel.org>
