Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C327702B6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 13:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbjEOL0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 07:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240975AbjEOL0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 07:26:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5A6199F;
        Mon, 15 May 2023 04:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4FD8622BF;
        Mon, 15 May 2023 11:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14FBC433EF;
        Mon, 15 May 2023 11:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684149954;
        bh=rnleee3wDjRK8fGjr2zR8YH7w1K7MeESgyA0VQlz/tM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ftMuXBemkGg94NBZ8coSS+lmVYJPNsKjardv0533QtBVZPaArEMh4Hjtte7acIfRZ
         HRl08wbMC8LMGGn4E6oet3e7sijLE43oIs74eA4I4cUtFa2bcFgHIf93GGtYJQB/WZ
         Ha2K7AUhjnfl2GLfhAn+GkV9Ez1aq3GMnLj3z9LxNCPY7SurLcP8vwW9HMvaw5O+aD
         pcwMIXfi/g53Sqwlx//xjzyyFt4lyxHqX4oYSOXHtxNqhQyPC6ViHCVneWCkcEP6Yj
         K7+1JYjvnsgdNIyRZb3RQ3z8jl/gEBDRNv1chc7JbIn13rbuL7v+bjoTmZHtT9zU2t
         4Xg6Hnhddh4dg==
Message-ID: <9889f34351d261622909a2ca9d8f5d598d4bd27c.camel@kernel.org>
Subject: Re: [PATCH v2 2/4] NFSD: enable support for write delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 15 May 2023 07:25:52 -0400
In-Reply-To: <1684110038-11266-3-git-send-email-dai.ngo@oracle.com>
References: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
         <1684110038-11266-3-git-send-email-dai.ngo@oracle.com>
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

On Sun, 2023-05-14 at 17:20 -0700, Dai Ngo wrote:
> This patch grants write delegation for OPEN with NFS4_SHARE_ACCESS_WRITE
> if there is no conflict with other OPENs.
>=20
> Write delegation conflict with another OPEN, REMOVE, RENAME and SETATTR
> are handled the same as read delegation using notify_change,
> try_break_deleg.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 6e61fa3acaf1..09a9e16407f9 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1144,7 +1144,7 @@ static void block_delegations(struct knfsd_fh *fh)
> =20
>  static struct nfs4_delegation *
>  alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
> -		 struct nfs4_clnt_odstate *odstate)
> +		struct nfs4_clnt_odstate *odstate, u32 dl_type)
>  {
>  	struct nfs4_delegation *dp;
>  	long n;
> @@ -1170,7 +1170,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nf=
s4_file *fp,
>  	INIT_LIST_HEAD(&dp->dl_recall_lru);
>  	dp->dl_clnt_odstate =3D odstate;
>  	get_clnt_odstate(odstate);
> -	dp->dl_type =3D NFS4_OPEN_DELEGATE_READ;
> +	dp->dl_type =3D dl_type;
>  	dp->dl_retries =3D 1;
>  	dp->dl_recalled =3D false;
>  	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
> @@ -5451,6 +5451,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct=
 nfs4_ol_stateid *stp,
>  	struct nfs4_delegation *dp;
>  	struct nfsd_file *nf;
>  	struct file_lock *fl;
> +	u32 deleg;

nit: I'd probably call this "dl_type" for consistency

> =20
>  	/*
>  	 * The fi_had_conflict and nfs_get_existing_delegation checks
> @@ -5460,7 +5461,13 @@ nfs4_set_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
>  	if (fp->fi_had_conflict)
>  		return ERR_PTR(-EAGAIN);
> =20
> -	nf =3D find_readable_file(fp);
> +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> +		nf =3D find_writeable_file(fp);
> +		deleg =3D NFS4_OPEN_DELEGATE_WRITE;
> +	} else {
> +		nf =3D find_readable_file(fp);
> +		deleg =3D NFS4_OPEN_DELEGATE_READ;
> +	}
>  	if (!nf) {
>  		/*
>  		 * We probably could attempt another open and get a read
> @@ -5491,11 +5498,11 @@ nfs4_set_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
>  		return ERR_PTR(status);
> =20
>  	status =3D -ENOMEM;
> -	dp =3D alloc_init_deleg(clp, fp, odstate);
> +	dp =3D alloc_init_deleg(clp, fp, odstate, deleg);
>  	if (!dp)
>  		goto out_delegees;
> =20
> -	fl =3D nfs4_alloc_init_lease(dp, NFS4_OPEN_DELEGATE_READ);
> +	fl =3D nfs4_alloc_init_lease(dp, deleg);
>  	if (!fl)
>  		goto out_clnt_odstate;
> =20
> @@ -5583,6 +5590,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
>  	struct svc_fh *parent =3D NULL;
>  	int cb_up;
>  	int status =3D 0;
> +	u32 wdeleg =3D false;

Shouldn't that be a bool? I don't think you actually need this variable
anyway, you can just open-code the ternary condition in the assignment.

> =20
>  	cb_up =3D nfsd4_cb_channel_good(oo->oo_owner.so_client);
>  	open->op_recall =3D 0;
> @@ -5590,8 +5598,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
>  		case NFS4_OPEN_CLAIM_PREVIOUS:
>  			if (!cb_up)
>  				open->op_recall =3D 1;
> -			if (open->op_delegate_type !=3D NFS4_OPEN_DELEGATE_READ)
> -				goto out_no_deleg;
>  			break;
>  		case NFS4_OPEN_CLAIM_NULL:
>  			parent =3D currentfh;
> @@ -5617,7 +5623,9 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
>  	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->=
dl_stid.sc_stateid));
> =20
>  	trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> -	open->op_delegate_type =3D NFS4_OPEN_DELEGATE_READ;
> +	wdeleg =3D open->op_share_access & NFS4_SHARE_ACCESS_WRITE;
> +	open->op_delegate_type =3D wdeleg ?
> +			NFS4_OPEN_DELEGATE_WRITE : NFS4_OPEN_DELEGATE_READ;
>  	nfs4_put_stid(&dp->dl_stid);
>  	return;
>  out_no_deleg:

--=20
Jeff Layton <jlayton@kernel.org>
