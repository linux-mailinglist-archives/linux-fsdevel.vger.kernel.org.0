Return-Path: <linux-fsdevel+bounces-74188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BFDD36D8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 18:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9F9730577A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B8D34107D;
	Fri, 16 Jan 2026 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB04jB/+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90443303A07
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583577; cv=none; b=n/OZFEKpx6x6LmAdiKr1GaVUT42Db5O43MhGKOQFUFMd1L9nGwsDWh+mMTvq+h29xxsnOW7Uq3stV6o7YTG24xeT44vqbDiKsJu7B6hw/R8a9qbbZOP/S/u13EGXehCRhfFkaGc/3B7zq52NUKvy5D8dixCoRx8/DwM3A1ALFc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583577; c=relaxed/simple;
	bh=kfxduXTTU5FrJGj9RoStJLFU70YfLzICwWsiq4PPVW0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KM9lTP2tqWQGXvOiJ11WsG4uvUlRJ85BGraBHuPF694ivM8ycv9u232sK/+kUwDrk/NPpgb+6++yOZe7+WEcOPqRvXrqDa6WwKotsRU2EE+H742GrVk9POkExiSAXjYL7T+bhSN3HHI15aSBP/AYdN0S8/4aMATTiyP93GkM7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB04jB/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCACDC19423;
	Fri, 16 Jan 2026 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768583577;
	bh=kfxduXTTU5FrJGj9RoStJLFU70YfLzICwWsiq4PPVW0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mB04jB/+CVaKF4Wvv/fDGrvfD6cLn3GrW1bs36j2CjOhZgIvwmvbURMZtrIR/Z8zK
	 5Lhwx6YdwHGFNNX/+EjRmDgIDHxicU+dAZF8jH2sdpwEKtFtb41CQuQ0aUqFZbYQnb
	 LAM5CPB18mXg/h678Lr6xvE3jc66P+jI7NQR2s13IyC60dGz9m9Oc17nxlEAMdKphv
	 ekJQsjcXcQScuI6+dkzum7CUjBmox43AboqN1tIN9Zi0kpGUFtLrbkPoC4EBK8IL0S
	 wKDgBYXGRZZRiv6JxDO3pIL7DtEw3Mz9QeRCple1t21Z15ZGSaYOhz21zsSXY6Olzn
	 qiMOt4WzPhB9g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E2676F40077;
	Fri, 16 Jan 2026 12:12:55 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 16 Jan 2026 12:12:55 -0500
X-ME-Sender: <xms:l3FqaQscZs1E6OIHoJR9nSqRoTZQS3Y2MMkqoTFnHcZgNDsy-M05hw>
    <xme:l3FqaYSmXnEQza4jgAxdWkWrTbVANoh4G670jLBndMtTtRwIsS9hExsUyet0kSi6I
    gO3164XuxK4ToNpKIDHscLoQ9KTUsiYn_utTXI_zk9MWbyGlBZoUe10>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprhhitghkrdhmrg
    gtkhhlvghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggtohguughinhhgsehhrghm
    mhgvrhhsphgrtggvrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvsghighhgvghrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhnughmhieskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgv
    rdgtohhmpdhrtghpthhtoheplhhinhhugidqtghrhihpthhosehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:l3Fqae2w-gQMIk8X7f-KTDrVFhXvY6KbfB9U4pqH96RzlTbuGnHNaQ>
    <xmx:l3Fqac6tX7efPggA4t3ktMvfyhbfqMo9NQg4eo90SEqKL8y3BvIw-w>
    <xmx:l3FqaSROHbD9BwukI_jzJmVMhpkDFcGAnn4YTotl_9hZiqml5iO-YQ>
    <xmx:l3FqaZXajMSpW4PC7vi-NEBprpqdD4zgnnCZKxLk95sUzGtti0p4Jg>
    <xmx:l3FqafGFQTonHAz_zJgRDiYO1WADDn3M9WLF56CPpOqqkQV1cYJChzs3>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BEB83780070; Fri, 16 Jan 2026 12:12:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ0jPXehNcK3
Date: Fri, 16 Jan 2026 12:12:24 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Message-Id: <2b28af6e-a6da-4f10-a589-6dd20d2f2c6c@app.fastmail.com>
In-Reply-To: 
 <9c9cd6131574a45f2603c9248ba205a79b00fea3.1768573690.git.bcodding@hammerspace.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <9c9cd6131574a45f2603c9248ba205a79b00fea3.1768573690.git.bcodding@hammerspace.com>
Subject: Re: [PATCH v1 4/4] NFSD: Sign filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Jan 16, 2026, at 9:32 AM, Benjamin Coddington wrote:
> NFS clients may bypass restrictive directory permissions by using
> open_by_handle() (or other available OS system call) to guess the
> filehandles for files below that directory.
>
> In order to harden knfsd servers against this attack, create a method to
> sign and verify filehandles using siphash as a MAC (Message Authentication
> Code).  Filehandles that have been signed cannot be tampered with, nor can
> clients reasonably guess correct filehandles and hashes that may exist in
> parts of the filesystem they cannot access due to directory permissions.
>
> Append the 8 byte siphash to encoded filehandles for exports that have set
> the "sign_fh" export option.  The filehandle's fh_auth_type is set to
> FH_AT_MAC(1) to indicate the filehandle is signed.  Filehandles received from
> clients are verified by comparing the appended hash to the expected hash.
> If the MAC does not match the server responds with NFS error _BADHANDLE.
> If unsigned filehandles are received for an export with "sign_fh" they are
> rejected with NFS error _BADHANDLE.
>
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  fs/nfsd/nfs3xdr.c          | 20 +++++++----
>  fs/nfsd/nfs4xdr.c          | 12 ++++---
>  fs/nfsd/nfsfh.c            | 72 ++++++++++++++++++++++++++++++++++++--
>  fs/nfsd/nfsfh.h            | 22 ++++++++++++
>  include/linux/sunrpc/svc.h |  1 +
>  5 files changed, 113 insertions(+), 14 deletions(-)
>
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index ef4971d71ac4..f9d0c4892de7 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -120,11 +120,16 @@ svcxdr_encode_nfsstat3(struct xdr_stream *xdr, 
> __be32 status)
>  }
> 
>  static bool
> -svcxdr_encode_nfs_fh3(struct xdr_stream *xdr, const struct svc_fh *fhp)
> +svcxdr_encode_nfs_fh3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
> +						struct svc_fh *fhp)
>  {
> -	u32 size = fhp->fh_handle.fh_size;
> +	u32 size;
>  	__be32 *p;
> 
> +	if (fh_append_mac(fhp, SVC_NET(rqstp)))
> +		return false;
> +	size = fhp->fh_handle.fh_size;
> +

This is a layering violation. XDR encoding never alters the content
in the local data structures, and this will be impossible to
convert to xdrgen down the line. All of the NFS version-specific
code should not know or care about FH signing, IMO.

Why can't the new signing logic be contained in fh_compose()
and fh_verify() ?


>  	p = xdr_reserve_space(xdr, XDR_UNIT + size);
>  	if (!p)
>  		return false;
> @@ -137,11 +142,12 @@ svcxdr_encode_nfs_fh3(struct xdr_stream *xdr, 
> const struct svc_fh *fhp)
>  }
> 
>  static bool
> -svcxdr_encode_post_op_fh3(struct xdr_stream *xdr, const struct svc_fh *fhp)
> +svcxdr_encode_post_op_fh3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
> +							struct svc_fh *fhp)
>  {
>  	if (xdr_stream_encode_item_present(xdr) < 0)
>  		return false;
> -	if (!svcxdr_encode_nfs_fh3(xdr, fhp))
> +	if (!svcxdr_encode_nfs_fh3(rqstp, xdr, fhp))
>  		return false;
> 
>  	return true;
> @@ -772,7 +778,7 @@ nfs3svc_encode_lookupres(struct svc_rqst *rqstp, 
> struct xdr_stream *xdr)
>  		return false;
>  	switch (resp->status) {
>  	case nfs_ok:
> -		if (!svcxdr_encode_nfs_fh3(xdr, &resp->fh))
> +		if (!svcxdr_encode_nfs_fh3(rqstp, xdr, &resp->fh))
>  			return false;
>  		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
>  			return false;
> @@ -908,7 +914,7 @@ nfs3svc_encode_createres(struct svc_rqst *rqstp, 
> struct xdr_stream *xdr)
>  		return false;
>  	switch (resp->status) {
>  	case nfs_ok:
> -		if (!svcxdr_encode_post_op_fh3(xdr, &resp->fh))
> +		if (!svcxdr_encode_post_op_fh3(rqstp, xdr, &resp->fh))
>  			return false;
>  		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
>  			return false;
> @@ -1117,7 +1123,7 @@ svcxdr_encode_entry3_plus(struct nfsd3_readdirres 
> *resp, const char *name,
> 
>  	if (!svcxdr_encode_post_op_attr(resp->rqstp, xdr, fhp))
>  		goto out;
> -	if (!svcxdr_encode_post_op_fh3(xdr, fhp))
> +	if (!svcxdr_encode_post_op_fh3(resp->rqstp, xdr, fhp))
>  		goto out;
>  	result = true;
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 884b792c95a3..f12981b989d1 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2701,9 +2701,13 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
>  }
> 
>  static __be32 nfsd4_encode_nfs_fh4(struct xdr_stream *xdr,
> -				   struct knfsd_fh *fh_handle)
> +					struct svc_fh *fhp)
>  {
> -	return nfsd4_encode_opaque(xdr, fh_handle->fh_raw, fh_handle->fh_size);
> +	if (fh_append_mac(fhp, SVC_NET(RESSTRM_RQST(xdr))))
> +		return nfserr_resource;
> +
> +	return nfsd4_encode_opaque(xdr, fhp->fh_handle.fh_raw,
> +		fhp->fh_handle.fh_size);
>  }
> 
>  /* This is a frequently-encoded type; open-coded for speed */
> @@ -3359,7 +3363,7 @@ static __be32 nfsd4_encode_fattr4_acl(struct 
> xdr_stream *xdr,
>  static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
>  					     const struct nfsd4_fattr_args *args)
>  {
> -	return nfsd4_encode_nfs_fh4(xdr, &args->fhp->fh_handle);
> +	return nfsd4_encode_nfs_fh4(xdr, args->fhp);
>  }
> 
>  static __be32 nfsd4_encode_fattr4_fileid(struct xdr_stream *xdr,
> @@ -4460,7 +4464,7 @@ nfsd4_encode_getfh(struct nfsd4_compoundres 
> *resp, __be32 nfserr,
>  	struct svc_fh *fhp = u->getfh;
> 
>  	/* object */
> -	return nfsd4_encode_nfs_fh4(xdr, &fhp->fh_handle);
> +	return nfsd4_encode_nfs_fh4(xdr, fhp);
>  }
> 
>  static __be32
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ed85dd43da18..b2fb16b7f3c9 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -11,6 +11,7 @@
>  #include <linux/exportfs.h>
> 
>  #include <linux/sunrpc/svcauth_gss.h>
> +#include <crypto/skcipher.h>

Is this header still needed?


>  #include "nfsd.h"
>  #include "vfs.h"
>  #include "auth.h"
> @@ -137,6 +138,62 @@ static inline __be32 check_pseudo_root(struct 
> dentry *dentry,
>  	return nfs_ok;
>  }
> 
> +/*
> + * Intended to be called when encoding, appends an 8-byte MAC
> + * to the filehandle hashed from the server's fh_key:
> + */
> +int fh_append_mac(struct svc_fh *fhp, struct net *net)
> +{
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	struct knfsd_fh *fh = &fhp->fh_handle;
> +	siphash_key_t *fh_key = nn->fh_key;
> +	u64 hash;
> +
> +	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
> +		return 0;
> +
> +	if (!fh_key) {
> +		pr_warn("NFSD: unable to sign filehandles, fh_key not set.\n");

Use pr_warn_ratelimited() instead


> +		return -EINVAL;
> +	}
> +
> +	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
> +		pr_warn("NFSD: unable to sign filehandles, fh_size %lu would be 
> greater"
> +			" than fh_maxsize %d.\n", fh->fh_size + sizeof(hash), 
> fhp->fh_maxsize);
> +		return -EINVAL;
> +	}
> +
> +	fh->fh_auth_type = FH_AT_MAC;
> +	hash = siphash(&fh->fh_raw, fh->fh_size, fh_key);
> +	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
> +	fh->fh_size += sizeof(hash);

What prevents appending a MAC to the same FH multiple times?


> +
> +	return 0;
> +}
> +
> +/*
> + * Verify that the the filehandle's MAC was hashed from this filehandle
> + * given the server's fh_key:
> + */
> +static int fh_verify_mac(struct svc_fh *fhp, struct net *net)
> +{
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	struct knfsd_fh *fh = &fhp->fh_handle;
> +	siphash_key_t *fh_key = nn->fh_key;
> +	u64 hash;
> +
> +	if (fhp->fh_handle.fh_auth_type != FH_AT_MAC)
> +		return -EINVAL;
> +
> +	if (!fh_key) {
> +		pr_warn("NFSD: unable to verify signed filehandles, fh_key not 
> set.\n");
> +		return -EINVAL;
> +	}
> +
> +	hash = siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_key);
> +	return memcmp(&fh->fh_raw[fh->fh_size - sizeof(hash)], &hash, 
> sizeof(hash));

Let's use crypto_memneq() for this purpose, to avoid timing attacks.


> +}
> +
>  /*
>   * Use the given filehandle to look up the corresponding export and
>   * dentry.  On success, the results are used to set fh_export and
> @@ -166,8 +223,11 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst 
> *rqstp, struct net *net,
> 
>  	if (--data_left < 0)
>  		return error;
> -	if (fh->fh_auth_type != 0)
> +
> +	/* either FH_AT_NONE or FH_AT_MAC */
> +	if (fh->fh_auth_type > 1)
>  		return error;
> +
>  	len = key_len(fh->fh_fsid_type) / 4;
>  	if (len == 0)
>  		return error;
> @@ -237,9 +297,15 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst 
> *rqstp, struct net *net,
> 
>  	fileid_type = fh->fh_fileid_type;
> 
> -	if (fileid_type == FILEID_ROOT)
> +	if (fileid_type == FILEID_ROOT) {
>  		dentry = dget(exp->ex_path.dentry);
> -	else {
> +	} else {
> +		/* Root filehandle always unsigned because rpc.mountd has no key */
> +		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
> +			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp, -EKEYREJECTED);
> +			goto out;
> +		}
> +
>  		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
>  						data_left, fileid_type, 0,
>  						nfsd_acceptable, exp);
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 5ef7191f8ad8..d1ae272117f0 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -59,6 +59,9 @@ struct knfsd_fh {
>  #define fh_fsid_type		fh_raw[2]
>  #define fh_fileid_type		fh_raw[3]
> 
> +#define FH_AT_NONE		0
> +#define FH_AT_MAC		1
> +
>  static inline u32 *fh_fsid(const struct knfsd_fh *fh)
>  {
>  	return (u32 *)&fh->fh_raw[4];
> @@ -226,6 +229,7 @@ __be32	fh_getattr(const struct svc_fh *fhp, struct 
> kstat *stat);
>  __be32	fh_compose(struct svc_fh *, struct svc_export *, struct dentry 
> *, struct svc_fh *);
>  __be32	fh_update(struct svc_fh *);
>  void	fh_put(struct svc_fh *);
> +int	fh_append_mac(struct svc_fh *, struct net *net);
> 
>  static __inline__ struct svc_fh *
>  fh_copy(struct svc_fh *dst, const struct svc_fh *src)
> @@ -274,6 +278,24 @@ static inline bool fh_fsid_match(const struct 
> knfsd_fh *fh1,
>  	return true;
>  }
> 
> +static inline size_t fh_fileid_offset(const struct knfsd_fh *fh)
> +{
> +	return key_len(fh->fh_fsid_type) + 4;
> +}
> +
> +static inline size_t fh_fileid_len(const struct knfsd_fh *fh)
> +{
> +	switch (fh->fh_auth_type) {
> +	case FH_AT_NONE:
> +		return fh->fh_size - fh_fileid_offset(fh);
> +		break;
> +	case FH_AT_MAC:
> +		return fh->fh_size - 8 - fh_fileid_offset(fh);

Let's define/use symbolic constants here (8) and just above (4).


> +		break;

The break; statements are unreachable.


> +	}
> +	return 0;
> +}
> +
>  /**
>   * fh_want_write - Get write access to an export
>   * @fhp: File handle of file to be written
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 62152e4f3bcc..96dae45d70ca 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -267,6 +267,7 @@ enum {
>  };
> 
>  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : 
> rqst->rq_bc_net)
> +#define RESSTRM_RQST(xdr_stream) (container_of(xdr_stream, struct 
> svc_rqst, rq_res_stream))
> 
>  /*
>   * Rigorous type checking on sockaddr type conversions
> -- 
> 2.50.1

-- 
Chuck Lever

