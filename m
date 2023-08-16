Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023CF77E0AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 13:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244708AbjHPLnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 07:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242200AbjHPLnQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:43:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA4C123;
        Wed, 16 Aug 2023 04:43:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E728666B0;
        Wed, 16 Aug 2023 11:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877E0C433C9;
        Wed, 16 Aug 2023 11:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692186193;
        bh=tME6yHkXqztm9W3j2l6wvjBFeqKku0k4CRKSqoLlNLM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S6AaJ9v7+AgRgJyFZ4lWrI3tycQI7o3yI8+way/BdaENeWQXI67B9eqkGLhIP2A7o
         FnmLozBjeG3xJNPOuL/fDwd+L3WJ1FzpHClPivsW8NXmrWJTzRTqP7b1hd+vkKso/E
         6KlUdbzmhbn203yC/68NauvlslQM0K+J2h73jwogka29ctrpPVjJQ1bPCZCfkB1iDx
         ShAec9R7qPtHd+xD6TISOMi2Y8mdAt9Km+j3mgsWGxuwNXPGs2M4hwMH0AAbKrOmvf
         6VG3mMPzzSYO4uQ271/FjI2QNiAiP+gHwj0oVlQRkt6mPl+u6ysahosecFR/puOn7F
         3vWfepcKoT2yg==
Message-ID: <30aa456827011eabf4b095d66cba2ac23491627a.camel@kernel.org>
Subject: Re: [RFCv2 3/7] lockd: introduce safe async lock op
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>, linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Date:   Wed, 16 Aug 2023 07:43:11 -0400
In-Reply-To: <20230814211116.3224759-4-aahringo@redhat.com>
References: <20230814211116.3224759-1-aahringo@redhat.com>
         <20230814211116.3224759-4-aahringo@redhat.com>
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

On Mon, 2023-08-14 at 17:11 -0400, Alexander Aring wrote:
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
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/lockd/svclock.c       |  5 ++---
>  fs/nfsd/nfs4state.c      | 13 ++++++++++---
>  include/linux/exportfs.h |  8 ++++++++
>  3 files changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index 1e74a578d7de..b8bd2b841ee1 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -449,9 +449,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
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
> @@ -465,7 +463,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
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

This seems like a reasonable approach, in principle.

Acked-by: Jeff Layton <jlayton@kernel.org>
