Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E92717CE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 12:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbjEaKLG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 06:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjEaKLF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 06:11:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBCAE2;
        Wed, 31 May 2023 03:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40EBB6393F;
        Wed, 31 May 2023 10:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F55BC433D2;
        Wed, 31 May 2023 10:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685527862;
        bh=h1EJ1xX7OolfopbpdWT6rGhdXYAHeK0qRMOGc/5lXkU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Q3FMY+gNoziIVz/PHcYZ3/LCIoAjvyuUEWjCkGrb32Nhq6mvQZMnE4BI1mX4iHX+6
         i6YTGT74i/BbE9c8p17sJCUZ/dN6B4Y+sdy7IqNHpkRRTmVaE739KEv+L7zG6FUvce
         +01ITrcMYGwxiPpuVadTpoJg9NExkebQI2/yMSHxB3FZ6skA7tjTGUvjCPGLg841dv
         BtdElQqDeCtH2TnTfB75S0Hf5BnhN5VnXd7zZnkatF2Ei39A3dVIj1twrv6BMmgSSE
         hxIu/0/eTL+YMZje0a63+UbnsC+Oqj/AoEUns0MjcNIMQfeq6P1GtCMG/r+HF+sP4t
         rUseTKtnxn6sA==
Message-ID: <8b89f4aa367e600f1d837187fe5694049e803539.camel@kernel.org>
Subject: Re: [PATCH v3 1/2] NFSD: handle GETATTR conflict with write
 delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 31 May 2023 06:11:00 -0400
In-Reply-To: <1685500507-23598-2-git-send-email-dai.ngo@oracle.com>
References: <1685500507-23598-1-git-send-email-dai.ngo@oracle.com>
         <1685500507-23598-2-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-05-30 at 19:35 -0700, Dai Ngo wrote:
> If the GETATTR request on a file that has write delegation in effect
> and the request attributes include the change info and size attribute
> then the write delegation is recalled. If the delegation is returned
> within 30ms then the GETATTR is serviced as normal otherwise the
> NFS4ERR_DELAY error is returned for the GETATTR.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/nfsd/nfs4xdr.c   |  5 +++++
>  fs/nfsd/state.h     |  3 +++
>  3 files changed, 68 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b90b74a5e66e..fea78d90ecf7 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8353,3 +8353,63 @@ nfsd4_get_writestateid(struct nfsd4_compound_state=
 *cstate,
>  {
>  	get_stateid(cstate, &u->write.wr_stateid);
>  }
> +
> +/**
> + * nfsd4_deleg_getattr_conflict - Trigger recall if GETATTR causes confl=
ict
> + * @rqstp: RPC transaction context
> + * @inode: file to be checked for a conflict
> + *
> + * This function is called when there is a conflict between a write
> + * delegation and a change/size GETATR from another client. The server
> + * must either use the CB_GETATTR to get the current values of the
> + * attributes from the client that hold the delegation or recall the
> + * delegation before replying to the GETATTR. See RFC 8881 section
> + * 18.7.4.
> + *
> + * Returns 0 if there is no conflict; otherwise an nfs_stat
> + * code is returned.
> + */
> +__be32
> +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode=
)
> +{
> +	__be32 status;
> +	struct file_lock_context *ctx;
> +	struct file_lock *fl;
> +	struct nfs4_delegation *dp;
> +
> +	ctx =3D locks_inode_context(inode);
> +	if (!ctx)
> +		return 0;
> +	spin_lock(&ctx->flc_lock);
> +	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
> +		if (fl->fl_flags =3D=3D FL_LAYOUT)
> +			continue;
> +		if (fl->fl_lmops !=3D &nfsd_lease_mng_ops) {
> +			/*
> +			 * non-nfs lease, if it's a lease with F_RDLCK then
> +			 * we are done; there isn't any write delegation
> +			 * on this inode
> +			 */
> +			if (fl->fl_type =3D=3D F_RDLCK)
> +				break;
> +			goto break_lease;
> +		}
> +		if (fl->fl_type =3D=3D F_WRLCK) {
> +			dp =3D fl->fl_owner;
> +			if (dp->dl_recall.cb_clp =3D=3D *(rqstp->rq_lease_breaker)) {
> +				spin_unlock(&ctx->flc_lock);
> +				return 0;
> +			}
> +break_lease:
> +			spin_unlock(&ctx->flc_lock);
> +			status =3D nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> +			if (status !=3D nfserr_jukebox ||
> +					!nfsd_wait_for_delegreturn(rqstp, inode))
> +				return status;
> +			return 0;
> +		}
> +		break;
> +	}
> +	spin_unlock(&ctx->flc_lock);
> +	return 0;
> +}

I think you have the logic right now, but this function kind of
resembles spaghetti. I'll add a reviewed-by, but it might be good to
simplify this function somehow later.

> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index b83954fc57e3..4590b893dbc8 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2970,6 +2970,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct =
svc_fh *fhp,
>  		if (status)
>  			goto out;
>  	}
> +	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> +		status =3D nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
> +		if (status)
> +			goto out;
> +	}
> =20
>  	err =3D vfs_getattr(&path, &stat,
>  			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index d49d3060ed4f..cbddcf484dba 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -732,4 +732,7 @@ static inline bool try_to_expire_client(struct nfs4_c=
lient *clp)
>  	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>  	return clp->cl_state =3D=3D NFSD4_EXPIRABLE;
>  }
> +
> +extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
> +				struct inode *inode);
>  #endif   /* NFSD4_STATE_H */

Reviewed-by: Jeff Layton <jlayton@kernel.org>
