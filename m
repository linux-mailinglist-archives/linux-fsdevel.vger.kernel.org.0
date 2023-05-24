Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBB070F9CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbjEXPIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 11:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjEXPIz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 11:08:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78579C;
        Wed, 24 May 2023 08:08:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8491161559;
        Wed, 24 May 2023 15:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B516C433D2;
        Wed, 24 May 2023 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684940932;
        bh=CGAtmXlNfDfrMpchgS8nLVatIa5I1GnFafW2EgwQg+w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qp8knbrD93yG3yJMuerzBDbQD8dojOoLXfR6fbNH4DGGC8KoiJse/LOM9IGTfzPym
         HgrPgDDS+mwa5z2vLAgC3HzEJgqflYSvimyy+XaY4qDHe0T9yT3CUXyvboiuZKuiAT
         2ioGlC9vQ43Jfexqc6/WaHLLjrN/PRiD4Ut7mArX3gV9f+k1Q4y4MsWw6kDKZaiFUN
         w+WXULaVM/Q5OtzjxSL5lxPjZfAPhJ1BxYnUXN5q6cIlO8PTczGRhLdKpKYU4jRx9a
         muUa2W+k9EUx4cF4IC2C8TPfx2TUuU+rxJXzXgdfyjYRtHSfAwLD4fseUFrvi/Cthn
         KAGWUYRJJ+Ggw==
Message-ID: <b95df7c30b6c919532bda3b382c6837bce6e492f.camel@kernel.org>
Subject: Re: [PATCH v5 1/3] NFSD: enable support for write delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 24 May 2023 11:08:51 -0400
In-Reply-To: <1684799560-31663-2-git-send-email-dai.ngo@oracle.com>
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
         <1684799560-31663-2-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-05-22 at 16:52 -0700, Dai Ngo wrote:
> This patch grants write delegation for OPEN with NFS4_SHARE_ACCESS_WRITE
> if there is no conflict with other OPENs.
>=20
> Write delegation conflict with another OPEN, REMOVE, RENAME and SETATTR
> are handled the same as read delegation using notify_change,
> try_break_deleg.
>=20
> Add trace point to track whether read or write delegation is granted.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 28 +++++++++++++++++++---------
>  fs/nfsd/trace.h     |  1 +
>  2 files changed, 20 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 6e61fa3acaf1..b90b74a5e66e 100644
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
> +	u32 dl_type;
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
> +		dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> +	} else {
> +		nf =3D find_readable_file(fp);
> +		dl_type =3D NFS4_OPEN_DELEGATE_READ;
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
> +	dp =3D alloc_init_deleg(clp, fp, odstate, dl_type);
>  	if (!dp)
>  		goto out_delegees;
> =20
> -	fl =3D nfs4_alloc_init_lease(dp, NFS4_OPEN_DELEGATE_READ);
> +	fl =3D nfs4_alloc_init_lease(dp, dl_type);
>  	if (!fl)
>  		goto out_clnt_odstate;
> =20
> @@ -5590,8 +5597,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
>  		case NFS4_OPEN_CLAIM_PREVIOUS:
>  			if (!cb_up)
>  				open->op_recall =3D 1;
> -			if (open->op_delegate_type !=3D NFS4_OPEN_DELEGATE_READ)
> -				goto out_no_deleg;
>  			break;
>  		case NFS4_OPEN_CLAIM_NULL:
>  			parent =3D currentfh;
> @@ -5616,8 +5621,13 @@ nfs4_open_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
> =20
>  	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->=
dl_stid.sc_stateid));
> =20
> -	trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> -	open->op_delegate_type =3D NFS4_OPEN_DELEGATE_READ;
> +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> +		open->op_delegate_type =3D NFS4_OPEN_DELEGATE_WRITE;
> +		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> +	} else {
> +		open->op_delegate_type =3D NFS4_OPEN_DELEGATE_READ;
> +		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> +	}
>  	nfs4_put_stid(&dp->dl_stid);
>  	return;
>  out_no_deleg:
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 4183819ea082..a14cf8684255 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -607,6 +607,7 @@ DEFINE_STATEID_EVENT(layout_recall_release);
> =20
>  DEFINE_STATEID_EVENT(open);
>  DEFINE_STATEID_EVENT(deleg_read);
> +DEFINE_STATEID_EVENT(deleg_write);
>  DEFINE_STATEID_EVENT(deleg_return);
>  DEFINE_STATEID_EVENT(deleg_recall);
> =20

This one looks fine and is fairly straightforward.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
