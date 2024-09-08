Return-Path: <linux-fsdevel+bounces-28916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB419709C0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 22:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7881B1C21344
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 20:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DC117A5B5;
	Sun,  8 Sep 2024 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGhcwFZ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2D4139587;
	Sun,  8 Sep 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725828051; cv=none; b=QkP3MMrGtSWOQptFXGPxInZRLAl2bBN4XusfHCCp/9S3EYMnqBTGsAODz2sG0afvEfpdWe1vXwopWwBFMvqcc/ynurNCjwkUnNQxNpX5JFjJ22AesQEf4FRcuuePjOul9OsOfO5aQWeBUi6IfeHUxkVeWgJ7OnYMa66GKwAsDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725828051; c=relaxed/simple;
	bh=wKw+JyaujKeOw/ei1GUHV0/eTdsnrmSRTcaO0yG2XlU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jEVMmcOYikbDTFH9rO0j7jdqjMZyr4o9yZESsZm71t2LRDSGx0Y3QLi5TGG356U+wJaWB/A2eluBtvuACzhoDUdBJPdFMD1/WqedF1o+ypLlTkfXRn5LYt/MPkf5qQYe3FH/jJAu5JalJXfJmhgMsyGT2h3ljChe1tsYS6kse7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGhcwFZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599ECC4CEC3;
	Sun,  8 Sep 2024 20:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725828050;
	bh=wKw+JyaujKeOw/ei1GUHV0/eTdsnrmSRTcaO0yG2XlU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pGhcwFZ3sfz9/E4869d1Y9TncgkwLFf1X+lE2scr/61nq4j+HP077tdUfY9zZnzmK
	 KAkbhTt2FO1VDfcz3vA1TIrklb5wd76/pItMbYKglN92SxlRhoWI0itjd2qA20GgH4
	 dwGKVLhi8IZgBXu0HlR1HJTBRU7qqrwnLyMAC1+9Q8+rt1I7L4q9uyKW0XgM/j32hR
	 vbikUtH863mP66/gw7V3xoi7WaSqBpUu/TsuMd+v9jG+Jq0hK5K4ylM90EoGcTOC/9
	 ATl42Es4Xuydf6ODGPkyoQqyR5PohGvxZcyZjy3O8+0l68TRHkVumf2dDDV4UI1MdL
	 ZehwvCzMZaIOQ==
Message-ID: <4eb752d9d8fabc0951df41762d92f751507292a3.camel@kernel.org>
Subject: Re: [PATCH v4 01/11] nfsd: fix initial getattr on write delegation
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trondmy@kernel.org>,  Anna Schumaker <anna@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Tom Haynes <loghyr@gmail.com>,  linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org
Date: Sun, 08 Sep 2024 16:40:47 -0400
In-Reply-To: <Zt3mK3fn0gWEsD9d@tissot.1015granger.net>
References: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
	 <20240905-delstid-v4-1-d3e5fd34d107@kernel.org>
	 <Zt3mK3fn0gWEsD9d@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-09-08 at 14:00 -0400, Chuck Lever wrote:
> On Thu, Sep 05, 2024 at 08:41:45AM -0400, Jeff Layton wrote:
> > At this point in compound processing, currentfh refers to the parent of
> > the file, not the file itself. Get the correct dentry from the delegati=
on
> > stateid instead.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfs4state.c | 31 +++++++++++++++++++++++--------
> >  1 file changed, 23 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index df69dc6af467..db90677fc016 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5914,6 +5914,26 @@ static void nfsd4_open_deleg_none_ext(struct nfs=
d4_open *open, int status)
> >  	}
> >  }
> > =20
> > +static bool
> > +nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *curren=
tfh,
> > +		     struct kstat *stat)
> > +{
> > +	struct nfsd_file *nf =3D find_rw_file(dp->dl_stid.sc_file);
>=20
> The xfstests workflow on NFSv4.2 exhausts the capacity of both the
> main and scratch devices (backed by xfs) about half-way through
> each test run.
>=20
> Deleting all visible files on both devices frees only a little bit
> of space. The test exports can be unshared but not unmounted
> (EBUSY). Looks like unlinked but still open files, maybe.
>=20
> Bisected to this here patch.
>=20
> Should there be a matching nfsd_file_put() book-end for the new
> find_rw_file() call site?
>=20

Yes. Braino on my end. I was thinking that find_rw_file didn't take a
reference, but it does and we do need to put it. Would you like me to
respin, or do you just want to add it in the appropriate spot?

>=20
> > +	struct path path;
> > +
> > +	if (!nf)
> > +		return false;
> > +
> > +	path.mnt =3D currentfh->fh_export->ex_path.mnt;
> > +	path.dentry =3D file_dentry(nf->nf_file);
> > +
> > +	if (vfs_getattr(&path, stat,
> > +			(STATX_INO | STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
> > +			AT_STATX_SYNC_AS_STAT))
> > +		return false;
> > +	return true;
> > +}
> > +
> >  /*
> >   * The Linux NFS server does not offer write delegations to NFSv4.0
> >   * clients in order to avoid conflicts between write delegations and
> > @@ -5949,7 +5969,6 @@ nfs4_open_delegation(struct nfsd4_open *open, str=
uct nfs4_ol_stateid *stp,
> >  	int cb_up;
> >  	int status =3D 0;
> >  	struct kstat stat;
> > -	struct path path;
> > =20
> >  	cb_up =3D nfsd4_cb_channel_good(oo->oo_owner.so_client);
> >  	open->op_recall =3D false;
> > @@ -5985,20 +6004,16 @@ nfs4_open_delegation(struct nfsd4_open *open, s=
truct nfs4_ol_stateid *stp,
> >  	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp=
->dl_stid.sc_stateid));
> > =20
> >  	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> > -		open->op_delegate_type =3D NFS4_OPEN_DELEGATE_WRITE;
> > -		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> > -		path.mnt =3D currentfh->fh_export->ex_path.mnt;
> > -		path.dentry =3D currentfh->fh_dentry;
> > -		if (vfs_getattr(&path, &stat,
> > -				(STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
> > -				AT_STATX_SYNC_AS_STAT)) {
> > +		if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
> >  			nfs4_put_stid(&dp->dl_stid);
> >  			destroy_delegation(dp);
> >  			goto out_no_deleg;
> >  		}
> > +		open->op_delegate_type =3D NFS4_OPEN_DELEGATE_WRITE;
> >  		dp->dl_cb_fattr.ncf_cur_fsize =3D stat.size;
> >  		dp->dl_cb_fattr.ncf_initial_cinfo =3D
> >  			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
> > +		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> >  	} else {
> >  		open->op_delegate_type =3D NFS4_OPEN_DELEGATE_READ;
> >  		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> >=20
> > --=20
> > 2.46.0
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

