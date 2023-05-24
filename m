Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCCA70F9C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 17:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjEXPHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 11:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjEXPHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 11:07:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161B9C;
        Wed, 24 May 2023 08:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D8F461722;
        Wed, 24 May 2023 15:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D14C433EF;
        Wed, 24 May 2023 15:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684940861;
        bh=NovvNzKCgnpyOA16gqnch6BIfKxYmjyswdBaDeKJjoQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=U8WEHk+WB/Z3dB/xLnclFMCsoe6j0cV2idj47GRRuHcNSexuCLrtMzkm4F1UU44Sd
         n83BoSkWo6pK+ovQdRNA2Du8MtHKnW/M6Mxw+w01uZUywJfi3POdxFyf+q1GWP8q0B
         ErPydTe5QABgniyJV7x/hmspoEhRFNC5FhWV+F7WQ+7H0rGAiP63/ATpxtschAj7/6
         TMUcQFEDyyH56nN0HRO8jFFQ6T4Dqkr+N7F0HtEw03HmJ+pU4lpwUDGMzspjIpPv5O
         yLeCQeciPh6bobuuij7i6taTKSSw/hluWpG1wLpaGlJWip6G37la0ymPz/+weK3dlf
         j6iB7PPmn0rwA==
Message-ID: <33ffcd5fd5d794fb642bbabf93f34a61d2f0d4e9.camel@kernel.org>
Subject: Re: [PATCH v5 2/3] NFSD: handle GETATTR conflict with write
 delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 24 May 2023 11:07:39 -0400
In-Reply-To: <1684799560-31663-3-git-send-email-dai.ngo@oracle.com>
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
         <1684799560-31663-3-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-05-22 at 16:52 -0700, Dai Ngo wrote:
> If the GETATTR request on a file that has write delegation in effect
> and the request attributes include the change info and size attribute
> then the write delegation is recalled and NFS4ERR_DELAY is returned
> for the GETATTR.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 37 +++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfs4xdr.c   |  5 +++++
>  fs/nfsd/state.h     |  3 +++
>  3 files changed, 45 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b90b74a5e66e..ea9cd781db5f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8353,3 +8353,40 @@ nfsd4_get_writestateid(struct nfsd4_compound_state=
 *cstate,
>  {
>  	get_stateid(cstate, &u->write.wr_stateid);
>  }
> +
> +__be32
> +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *inode=
)
> +{
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
> +			/*
> +			 * increment the sc_count to prevent the delegation to
> +			 * be freed while sending the CB_RECALL. The refcount is
> +			 * decremented by nfs4_put_stid in nfsd4_cb_recall_release
> +			 * after the request was sent.
> +			 */
> +			if (dp->dl_recall.cb_clp =3D=3D *(rqstp->rq_lease_breaker) ||
> +					!refcount_inc_not_zero(&dp->dl_stid.sc_count)) {

I still don't get why you're incrementing the refcount of this stateid.
At this point, you know that this stateid is owned by a different client
altogether,  and breaking its lease doesn't require a reference to the
stateid.

I think this will cause a refcount leak.

> +				spin_unlock(&ctx->flc_lock);
> +				return 0;
> +			}
> +			spin_unlock(&ctx->flc_lock);
> +			return nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> +		}
> +		break;
> +	}
> +	spin_unlock(&ctx->flc_lock);
> +	return 0;
> +}
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 76db2fe29624..ed09b575afac 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2966,6 +2966,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct =
svc_fh *fhp,
>  		if (status)
>  			goto out;
>  	}
> +	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> +		status =3D nfs4_handle_wrdeleg_conflict(rqstp, d_inode(dentry));
> +		if (status)
> +			goto out;
> +	}
> =20
>  	err =3D vfs_getattr(&path, &stat,
>  			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index d49d3060ed4f..64727a39f0db 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -732,4 +732,7 @@ static inline bool try_to_expire_client(struct nfs4_c=
lient *clp)
>  	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>  	return clp->cl_state =3D=3D NFSD4_EXPIRABLE;
>  }
> +
> +extern __be32 nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp,
> +				struct inode *inode);
>  #endif   /* NFSD4_STATE_H */

--=20
Jeff Layton <jlayton@kernel.org>
