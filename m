Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B118A70AF17
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 18:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjEUQvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 12:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjEUQtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 12:49:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD28FC1;
        Sun, 21 May 2023 09:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 606C860E73;
        Sun, 21 May 2023 16:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6C6C433D2;
        Sun, 21 May 2023 16:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684687762;
        bh=gVEhJCo75MKgRh8J5ErIwJvoWaIZrFtp2iICiYvWILg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ff0sJ5tWs6KU5O29Bm4h2q+9QfEPrQ7S48RNJ1XWHL+SvL0eOXV4iRm+02hSSLKZ/
         XLeRkKHMojqaSv8gMKFfX2b0nKw1FD4BSptYsXDEqpH/z6iRcgcWFqqMJ7BKlSNFy0
         +7r+4xfuDpNCBMfC10lEa+HcNJPfXJKDhWn7z8Su+LZ3D5gtEMOO8wMs3FCohuZF85
         4NPzTN3uw38A3j2BtXRaBqdG5Kvbwl46AxD/LLyQoJGAHNiDyITTOYoK8Yk8iGRwrb
         mxMWEFi+xW1LbyBTn2cpPiN3Sp4Vk6FvyQO/kPUqkkQHjyLnXh+0l+/XGaucnjp09/
         +FXHaM08SpOiw==
Message-ID: <d6770af7219b19dfeaa05a271444dd462c32943c.camel@kernel.org>
Subject: Re: [PATCH v4 3/4] NFSD: handle GETATTR conflict with write
 delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Sun, 21 May 2023 12:49:20 -0400
In-Reply-To: <1684618595-4178-4-git-send-email-dai.ngo@oracle.com>
References: <1684618595-4178-1-git-send-email-dai.ngo@oracle.com>
         <1684618595-4178-4-git-send-email-dai.ngo@oracle.com>
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

On Sat, 2023-05-20 at 14:36 -0700, Dai Ngo wrote:
> If the GETATTR request on a file that has write delegation in effect
> and the request attributes include the change info and size attribute
> then the write delegation is recalled and NFS4ERR_DELAY is returned
> for the GETATTR.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 76db2fe29624..e069b970f136 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2920,6 +2920,46 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, u32 bm=
val0, u32 bmval1, u32 bmval2)
>  	return nfserr_resource;
>  }
> =20
> +static struct file_lock *
> +nfs4_wrdeleg_filelock(struct svc_rqst *rqstp, struct inode *inode)
> +{
> +	struct file_lock_context *ctx;
> +	struct file_lock *fl;
> +
> +	ctx =3D locks_inode_context(inode);
> +	if (!ctx)
> +		return NULL;
> +	spin_lock(&ctx->flc_lock);
> +	if (!list_empty(&ctx->flc_lease)) {
> +		fl =3D list_first_entry(&ctx->flc_lease,
> +					struct file_lock, fl_list);
> +		if (fl->fl_type =3D=3D F_WRLCK) {
> +			spin_unlock(&ctx->flc_lock);
> +			return fl;
> +		}
> +	}
> +	spin_unlock(&ctx->flc_lock);
> +	return NULL;
> +}
> +
> +static __be32
> +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *inode=
)
> +{
> +	__be32 status;
> +	struct file_lock *fl;
> +	struct nfs4_delegation *dp;
> +
> +	fl =3D nfs4_wrdeleg_filelock(rqstp, inode);
> +	if (!fl)
> +		return 0;
> +	dp =3D fl->fl_owner;

One problem here is that you don't know whether the owner was set by
nfsd. This owner could be a struct file from a userland lease holder,
and that that point it's not safe to dereference it below like you are.

The q&d way we check for this in other places is to validate that the
fl_lmops is correct. In this case you'd want to make sure it's set to
&nfsd_lease_mng_ops.

Beyond that, you also don't know whether that owner or file_lock still
_exists_ after you drop the flc_lock. You need to either do these checks
while holding that lock, or take a reference to the owner before you
start dereferencing things.

Probably, you're better off here just doing it all under the flc_lock.

> +	if (dp->dl_recall.cb_clp =3D=3D *(rqstp->rq_lease_breaker))
> +		return 0;
> +	refcount_inc(&dp->dl_stid.sc_count);

Another problem: the sc_count might already have gone to zero here. You
don't already hold a reference to dl_stid at this point, so you can't
just increment it without taking the cl_lock for that client.

You may be able to do this safely with refcount_inc_not_zero, and just
ignore the delegation if it's already at zero.

> +	status =3D nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> +	return status;
> +}
> +
>  /*
>   * Note: @fhp can be NULL; in this case, we might have to compose the fi=
lehandle
>   * ourselves.
> @@ -2966,6 +3006,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct =
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

--=20
Jeff Layton <jlayton@kernel.org>
