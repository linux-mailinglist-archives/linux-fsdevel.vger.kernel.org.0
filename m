Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6BD715BC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 12:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjE3Kae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 06:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjE3KaI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 06:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C6FE5F;
        Tue, 30 May 2023 03:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BB7661452;
        Tue, 30 May 2023 10:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35727C433EF;
        Tue, 30 May 2023 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685442558;
        bh=eXgms0j3ifAbCZc7BYiC1NSMaPjHX66aHgUmpH3tBvs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VF/Db1v82fkkdflvmQJQv0Tn3NWCoQ1LF6FGOVoPhHUWyTAFsovHBt9JXJrkDEQd5
         crQfneNPnHpy2Klo+VkE/L0VpqMfWZoIeVB2zu0moBxaRFKv2nOWMF7hfRkVcLazTg
         VmRpe85R0Z31OWF+IFU5nSst8fZC+HFJKCMB74kdlmfpA9Oaj5TsPFsos9YsH7zYRM
         sCSkeCbhMwoaLzpje2aTfMo2DvCSuOiOSLv7rn6PpDsYPmQ/c0RrAbi63TA1yZDSUB
         FZTH5GG8KBx9GhUqrVoFqvtOwxfaUBzHg77+7n9E+DxaeC6eFFV8+LIdniUhCVMWBE
         YlpZ0z23Ce8pA==
Message-ID: <283915f369b99b88b2a335034a11cddf7b93fcff.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] NFSD: handle GETATTR conflict with write
 delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Tue, 30 May 2023 06:29:16 -0400
In-Reply-To: <1685429537-11855-2-git-send-email-dai.ngo@oracle.com>
References: <1685429537-11855-1-git-send-email-dai.ngo@oracle.com>
         <1685429537-11855-2-git-send-email-dai.ngo@oracle.com>
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

On Mon, 2023-05-29 at 23:52 -0700, Dai Ngo wrote:
> If the GETATTR request on a file that has write delegation in effect
> and the request attributes include the change info and size attribute
> then the write delegation is recalled. If the delegation is returned
> within 30ms then the GETATTR is serviced as normal otherwise the
> NFS4ERR_DELAY error is returned for the GETATTR.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++=
+++
>  fs/nfsd/nfs4xdr.c   |  5 +++++
>  fs/nfsd/state.h     |  3 +++
>  3 files changed, 58 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b90b74a5e66e..7826483e8421 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8353,3 +8353,53 @@ nfsd4_get_writestateid(struct nfsd4_compound_state=
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
> +		if (fl->fl_flags =3D=3D FL_LAYOUT ||
> +				fl->fl_lmops !=3D &nfsd_lease_mng_ops)
> +			continue;
> +		if (fl->fl_type =3D=3D F_WRLCK) {
> +			dp =3D fl->fl_owner;
> +			if (dp->dl_recall.cb_clp =3D=3D *(rqstp->rq_lease_breaker)) {
> +				spin_unlock(&ctx->flc_lock);
> +				return 0;
> +			}
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


If there is a lease held by a userland program (e.g. Samba), why don't
you want to break it here? Shouldn't it also be broken in this case?

I think this logic may be wrong. ISTM that you want to basically always
call nfsd_open_break_lease, unless it's a delegation held by the same
client.


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

--=20
Jeff Layton <jlayton@kernel.org>
