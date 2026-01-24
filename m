Return-Path: <linux-fsdevel+bounces-75331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLemDuoOdGmS1wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:14:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9128A7B9F5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FCFF301C5B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E610C35949;
	Sat, 24 Jan 2026 00:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzQ0fMXr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72433C8E6;
	Sat, 24 Jan 2026 00:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769213661; cv=none; b=eUB2pIvCschRaRKKvLcrXk9eDqIf+AfFzPP6DxRfNZH87Z2N2dFXMu20eefG2upTFnLBx8XatkmU8UZ9UsHFQhXWTFJ1EUECxzyhQusWgwoJj4UOwMy0+2zzcrbraPji9VWUzAbzFQJEUJI+Io0xOmPQDjP985UCqiMBtBu/6Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769213661; c=relaxed/simple;
	bh=Myx1r/NFHfWVAPL/f9/7A2AtpUuxAOTrENKN5st8jJI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MX0BDiQGMPks3001MDdMo2kzhi8MxUEsgU4iqfPA5tx31SCsc1nzvfbuoNQ8md8stavECrIpG82OD6vTyJcLHha0Ku1oAaRrJU8JPfOF0qVe51sQ3PtVdWOctcFx9G/7SjevNpZmg4+EV9NzL80YYhi3hX/IP78sZifTvI89fm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzQ0fMXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCCBC4CEF1;
	Sat, 24 Jan 2026 00:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769213661;
	bh=Myx1r/NFHfWVAPL/f9/7A2AtpUuxAOTrENKN5st8jJI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nzQ0fMXrOzhj40OJnH82XZDTPURSS2gLlgVb8BoMrd9/pU8tjKFeOpp25bzw1puRT
	 h2Xgnneg2mtKiFPfoTQOef9T5XmVh2GqrA6GHswwkoYKtud5220gcSO/dmQhSLKawR
	 iu3S5LRda20bSzOuSeBRLWvq8AFF4l48tTgrWrWnyjfo5D3bsTk6+fCaMq1fmb8Kh4
	 hOwaiwi4oolUuENafwRFPsz+v2YgLuoLG/j6pZY/cVqyuvyj1H6FHohk0f0Gf5IgML
	 +g6nUU0Rp6Z29S8k/UzuykH0UO8V+RaFs8pzj+9zjioaHwjSpzS94S5MyQjd3JFCbI
	 MiK6Rpid9yU/A==
Message-ID: <d1e5a45b5c3d8ac2d92ac15c8ae7ff79dafdef92.camel@kernel.org>
Subject: Re: [PATCH/RFC] nfsd: rate limit requests that result in -ESTALE
 from the filesystem
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Chuck Lever <chuck.lever@oracle.com>, Trond
 Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Benjamin
 Coddington	 <bcodding@hammerspace.com>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem	 <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Date: Fri, 23 Jan 2026 19:14:17 -0500
In-Reply-To: <176920977124.16766.1785815212991547773@noble.neil.brown.name>
References: <176920977124.16766.1785815212991547773@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75331-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[brown.name,oracle.com,kernel.org,hammerspace.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9128A7B9F5
X-Rspamd-Action: no action

On Sat, 2026-01-24 at 10:09 +1100, NeilBrown wrote:
> This is an idea for an alternate approach to address the problem that
> Ben is trying to address by signing file handles.
>=20
> The reasons I think an alternate is worth considering are:
>=20
>  - Ben's approach requires some configuration, though not much.
>    This approach requires zero configuration which is always better.
>=20
>  - Ben's approach adds a siphash calculation or two to (almost) every
>    NFS request.  This may not be a great cost but it is still some time
>    and some power.  Less is more.
>=20
> Filehandles already contain 32 bits of randomness.  Rather than adding
> another 64 bits as Ben's patch does, this patch increase the time it
> take to test all possible values for those 32 bits to make it an
> impractical attack.
>=20
> Comments welcome.
>=20
> Thanks,
> NeilBrown
>=20
>=20
>=20
> From: NeilBrown <neil@brown.name>
> Subject: [PATCH] nfsd: rate limit requests that result in -ESTALE from th=
e
>  filesystem
>=20
> NFS file handles typically contain a 32 bit generation number which is
> randomly generated by the filesystem when the inode (or inode number) is
> allocated.  This makes it hard to guess correct file handles.  Hard but
> not impossible on a low latency network with a high speed server.
>=20
> The NFS server will reject a request to access the file associated with
> a filehandle if the user credential given is now allowed the access the
> file, but it is not able to check if the user (or client) should be
> allowed to even know that filehandle.  This would require knowing all
> the paths to a given file, all the credential that the client has access
> to, when whether some combination of those credential can complete a
> walk down any of the paths.
>=20
> So the NFS server currently depends on the client to "do the right
> thing".
>=20
> In some circumstances the client may not be sufficiently trusted, and
> path-based access controls may be an important part of the access
> management strategy.  In these cases the protection provided by nfsd may
> not be sufficient.
>=20
> The only known attack methodology is to guess the inode number of a file
> of interest, then iterate over all possible generation numbers.  This
> would be expected to achieve success (if the inode number is valid) in,
> on average, 2^31 guesses.  At one per microsecond this is less than one
> hour.  At one per 10 microseconds this is less than one day.
>=20
> When presented with an incorrect guess the filesystem with report an
> error to nfsd, either NULL or ERR_PTR(-ESTALE).  This patch causes nfsd
> to detect those errors and insert a 15ms delay.  It also take a lock so
> that all such delays are serialised.  This increases the expected time
> to success to 1 year.
>=20
> Normally NFSERR_STALE errors are rare and are no on a fast path.
> Normal accesses which use a filehandle which has become stale will now
> incur a 15msec does which is likely to be unnoticeable.  An attack will
> notice an intolerable delay.
>=20
> Possible this code could detect if there are ever a large number of
> requests over an extended time and then take more firm action.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/netns.h  |  2 ++
>  fs/nfsd/nfsctl.c |  1 +
>  fs/nfsd/nfsfh.c  | 15 +++++++++++++++
>  3 files changed, 18 insertions(+)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 9fa600602658..f7229d1f9d86 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -219,6 +219,8 @@ struct nfsd_net {
>  	/* last time an admin-revoke happened for NFSv4.0 */
>  	time64_t		nfs40_last_revoke;
> =20
> +	struct mutex		estale_rate_limit_mutex;
> +
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  	/* Local clients to be invalidated when net is shut down */
>  	spinlock_t              local_clients_lock;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 7587c64bf26d..55d25d9b414f 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2198,6 +2198,7 @@ static __net_init int nfsd_net_init(struct net *net=
)
>  	nfsd4_init_leases_net(nn);
>  	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
>  	seqlock_init(&nn->writeverf_lock);
> +	mutex_init(&nn->estale_rate_limit_mutex);
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  	spin_lock_init(&nn->local_clients_lock);
>  	INIT_LIST_HEAD(&nn->local_clients);
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ed85dd43da18..7032f65fe21a 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -244,6 +244,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqs=
tp, struct net *net,
>  						data_left, fileid_type, 0,
>  						nfsd_acceptable, exp);
>  		if (IS_ERR_OR_NULL(dentry)) {
> +			struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +
>  			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
>  					dentry ?  PTR_ERR(dentry) : -ESTALE);
>  			switch (PTR_ERR(dentry)) {
> @@ -252,6 +254,19 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rq=
stp, struct net *net,
>  				break;
>  			default:
>  				dentry =3D ERR_PTR(-ESTALE);
> +				/* We limit ESTALE returns to 1 every
> +				 * 15 milliseconds (across all threads) to
> +				 * prevent a client from guessing the
> +				 * correct (32 bit) generation number
> +				 * for an given inode in significantly
> +				 * less than 1 year.  This ensures clients
> +				 * can only access files for which they
> +				 * are allowed to access a path from the
> +				 * exported root.
> +				 */
> +				mutex_lock(&nn->estale_rate_limit_mutex);
> +				msleep(15);
> +				mutex_unlock(&nn->estale_rate_limit_mutex);

Hmm...maybe a mutex_trylock and if it fails do an immediate -EAGAIN
return (which hopefully becomes NFSERR3_JUKEBOX or NFS4ERR_DELAY)? This
could be a way to DoS the server, otherwise.

>  			}
>  		}
>  	}


FWIW, I don't necessarily see this as a replacement for Ben's work, but
it might be a nice complement.
--=20
Jeff Layton <jlayton@kernel.org>

