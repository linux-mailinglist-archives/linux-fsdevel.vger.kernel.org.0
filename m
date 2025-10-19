Return-Path: <linux-fsdevel+bounces-64622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB5DBEE624
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 15:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCDFB4057C8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403AE2EAB85;
	Sun, 19 Oct 2025 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNJGiqeO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6670D2E88B0;
	Sun, 19 Oct 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760881301; cv=none; b=Sydconc9wvVBdqgQgL8RTxbu/fXV5urrS/3ufUNLvfG/PNMp57ike1Izp10oKMgW4vn4tjCTqNigu39NApfpwsv/x9O6yw5cPauOBjiKb3ym1fRh+w+2taQ5l1q01tSkHgszzgC7ZMvErQJBjvkZY9nBySqpcda2e+bh5Fac8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760881301; c=relaxed/simple;
	bh=1JCcGdU0D0dfIG7v2bCZYHFfv6kb8BQcykm1I3JapgY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tI64gNtuFHPYIZptagubLhJCDGgvn9TGqnw6kjQAmpUN3rRY4+Dx9LJUygfYYbHLqK4E9jDBMd0tjXPZWxneRx6wqwwNcLJBdRgDhz1Ec/66dW1jPVnVsWlGFom02dflkBv7ir7KIceG6AF9JzPpAXTbECn6wksfsh05Nbohoew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNJGiqeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD14AC4CEF1;
	Sun, 19 Oct 2025 13:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760881301;
	bh=1JCcGdU0D0dfIG7v2bCZYHFfv6kb8BQcykm1I3JapgY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WNJGiqeO9IsVg1wCiwKSI5bb705R/GKPtimCYbS5LlnRlSTNoiLVDNB1tDPxQK87T
	 fZ9waLTHZkhzh0CCvxM2DQ7ttKivu8HBnbSFdZXTCjpRCjXBj0JtBm33mCGHYvDYnT
	 llt5s0AY1i0WcpduhELR42Xp35E95c1TMPdRZ9p63zZX71MZIFyiV8UtmAUfPmTYlU
	 ebawMeO7oVrmN6tnf6O4VxLLzDgPFgXSbVCY6WDXVE4cX4Zj/OddZJIux/YpCsRH9c
	 7HHH5ObJ4q8BfXjH/OlHtp9NZXjZ/HfxUyhCvlGIO+C4gaHSsfYxduL711R4zz2ev8
	 DjXYChtEri78Q==
Message-ID: <af2105e98a924a31ed76462b4076967735285276.camel@kernel.org>
Subject: Re: [PATCH v2 09/11] nfsd: allow filecache to hold S_IFDIR files
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Miklos Szeredi
 <miklos@szeredi.hu>,  Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,  Alexander Aring
 <alex.aring@gmail.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>,  Steve French <sfrench@samba.org>, Paulo
 Alcantara <pc@manguebit.org>, Ronnie Sahlberg	 <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey	 <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich	 <dakr@kernel.org>, David Howells <dhowells@redhat.com>,
 Tyler Hicks	 <code@tyhicks.com>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia	 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Amir
 Goldstein	 <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, Steve
 French	 <smfrench@gmail.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>, Kuniyuki
 Iwashima <kuniyu@google.com>, "David S. Miller"	 <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman	 <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, netfs@lists.linux.dev,
 ecryptfs@vger.kernel.org, 	linux-unionfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org
Date: Sun, 19 Oct 2025 09:41:36 -0400
In-Reply-To: <21904951-0cac-4a79-9be6-7dbf2f9849b6@oracle.com>
References: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
	 <20251017-dir-deleg-ro-v2-9-8c8f6dd23c8b@kernel.org>
	 <21904951-0cac-4a79-9be6-7dbf2f9849b6@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-18 at 15:33 -0400, Chuck Lever wrote:
> On 10/17/25 7:32 AM, Jeff Layton wrote:
> > The filecache infrastructure will only handle S_IFREG files at the
> > moment. Directory delegations will require adding support for opening
> > S_IFDIR inodes.
> >=20
> > Plumb a "type" argument into nfsd_file_do_acquire() and have all of the
> > existing callers set it to S_IFREG. Add a new nfsd_file_acquire_dir()
> > wrapper that nfsd can call to request a nfsd_file that holds a director=
y
> > open.
> >=20
> > For now, there is no need for a fsnotify_mark for directories, as
> > CB_NOTIFY is not yet supported. Change nfsd_file_do_acquire() to avoid
> > allocating one for non-S_IFREG inodes.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/filecache.c | 57 ++++++++++++++++++++++++++++++++++++++++-----=
--------
> >  fs/nfsd/filecache.h |  2 ++
> >  fs/nfsd/vfs.c       |  5 +++--
> >  fs/nfsd/vfs.h       |  2 +-
> >  4 files changed, 49 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index a238b6725008a5c2988bd3da874d1f34ee778437..93798575b8075c63f95cd41=
5b6d24df706ada0f6 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -1086,7 +1086,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct net *net,
> >  		     struct auth_domain *client,
> >  		     struct svc_fh *fhp,
> >  		     unsigned int may_flags, struct file *file,
> > -		     struct nfsd_file **pnf, bool want_gc)
> > +		     umode_t type, bool want_gc, struct nfsd_file **pnf)
> >  {
> >  	unsigned char need =3D may_flags & NFSD_FILE_MAY_MASK;
> >  	struct nfsd_file *new, *nf;
> > @@ -1097,13 +1097,13 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct net *net,
> >  	int ret;
> > =20
> >  retry:
> > -	if (rqstp) {
> > -		status =3D fh_verify(rqstp, fhp, S_IFREG,
> > +	if (rqstp)
> > +		status =3D fh_verify(rqstp, fhp, type,
> >  				   may_flags|NFSD_MAY_OWNER_OVERRIDE);
> > -	} else {
> > -		status =3D fh_verify_local(net, cred, client, fhp, S_IFREG,
> > +	else
> > +		status =3D fh_verify_local(net, cred, client, fhp, type,
> >  					 may_flags|NFSD_MAY_OWNER_OVERRIDE);
> > -	}
> > +
> >  	if (status !=3D nfs_ok)
> >  		return status;
> >  	inode =3D d_inode(fhp->fh_dentry);
> > @@ -1176,15 +1176,18 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct net *net,
> > =20
> >  open_file:
> >  	trace_nfsd_file_alloc(nf);
> > -	nf->nf_mark =3D nfsd_file_mark_find_or_create(inode);
> > -	if (nf->nf_mark) {
> > +
> > +	if (type =3D=3D S_IFREG)
> > +		nf->nf_mark =3D nfsd_file_mark_find_or_create(inode);
> > +
> > +	if (type !=3D S_IFREG || nf->nf_mark) {
> >  		if (file) {
> >  			get_file(file);
> >  			nf->nf_file =3D file;
> >  			status =3D nfs_ok;
> >  			trace_nfsd_file_opened(nf, status);
> >  		} else {
> > -			ret =3D nfsd_open_verified(fhp, may_flags, &nf->nf_file);
> > +			ret =3D nfsd_open_verified(fhp, type, may_flags, &nf->nf_file);
> >  			if (ret =3D=3D -EOPENSTALE && stale_retry) {
> >  				stale_retry =3D false;
> >  				nfsd_file_unhash(nf);
> > @@ -1246,7 +1249,7 @@ nfsd_file_acquire_gc(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
> >  		     unsigned int may_flags, struct nfsd_file **pnf)
> >  {
> >  	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
> > -				    fhp, may_flags, NULL, pnf, true);
> > +				    fhp, may_flags, NULL, S_IFREG, true, pnf);
> >  }
> > =20
> >  /**
> > @@ -1271,7 +1274,7 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
> >  		  unsigned int may_flags, struct nfsd_file **pnf)
> >  {
> >  	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
> > -				    fhp, may_flags, NULL, pnf, false);
> > +				    fhp, may_flags, NULL, S_IFREG, false, pnf);
> >  }
> > =20
> >  /**
> > @@ -1314,8 +1317,8 @@ nfsd_file_acquire_local(struct net *net, struct s=
vc_cred *cred,
> >  	const struct cred *save_cred =3D get_current_cred();
> >  	__be32 beres;
> > =20
> > -	beres =3D nfsd_file_do_acquire(NULL, net, cred, client,
> > -				     fhp, may_flags, NULL, pnf, false);
> > +	beres =3D nfsd_file_do_acquire(NULL, net, cred, client, fhp, may_flag=
s,
> > +				     NULL, S_IFREG, false, pnf);
> >  	put_cred(revert_creds(save_cred));
> >  	return beres;
> >  }
> > @@ -1344,7 +1347,33 @@ nfsd_file_acquire_opened(struct svc_rqst *rqstp,=
 struct svc_fh *fhp,
> >  			 struct nfsd_file **pnf)
> >  {
> >  	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
> > -				    fhp, may_flags, file, pnf, false);
> > +				    fhp, may_flags, file, S_IFREG, false, pnf);
> > +}
> > +
> > +/**
> > + * nfsd_file_acquire_dir - Get a struct nfsd_file with an open directo=
ry
> > + * @rqstp: the RPC transaction being executed
> > + * @fhp: the NFS filehandle of the file to be opened
> > + * @pnf: OUT: new or found "struct nfsd_file" object
> > + *
> > + * The nfsd_file_object returned by this API is reference-counted
> > + * but not garbage-collected. The object is unhashed after the
> > + * final nfsd_file_put(). This opens directories only, and only
> > + * in O_RDONLY mode.
> > + *
> > + * Return values:
> > + *   %nfs_ok - @pnf points to an nfsd_file with its reference
> > + *   count boosted.
> > + *
> > + * On error, an nfsstat value in network byte order is returned.
> > + */
> > +__be32
> > +nfsd_file_acquire_dir(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > +		      struct nfsd_file **pnf)
> > +{
> > +	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL, fhp,
> > +				    NFSD_MAY_READ|NFSD_MAY_64BIT_COOKIE,
> > +				    NULL, S_IFDIR, false, pnf);
> >  }
> > =20
> >  /*
> > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> > index e3d6ca2b60308e5e91ba4bb32d935f54527d8bda..b383dbc5b9218d21a29b852=
572f80fab08de9fa9 100644
> > --- a/fs/nfsd/filecache.h
> > +++ b/fs/nfsd/filecache.h
> > @@ -82,5 +82,7 @@ __be32 nfsd_file_acquire_opened(struct svc_rqst *rqst=
p, struct svc_fh *fhp,
> >  __be32 nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
> >  			       struct auth_domain *client, struct svc_fh *fhp,
> >  			       unsigned int may_flags, struct nfsd_file **pnf);
> > +__be32 nfsd_file_acquire_dir(struct svc_rqst *rqstp, struct svc_fh *fh=
p,
> > +		  struct nfsd_file **pnf);
> >  int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
> >  #endif /* _FS_NFSD_FILECACHE_H */
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index eeb138569eba5df6de361cf6ba29604722e14af9..12c33223b612664dbb3b18b=
591e97fc708165763 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -959,15 +959,16 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *=
fhp, umode_t type,
> >  /**
> >   * nfsd_open_verified - Open a regular file for the filecache
> >   * @fhp: NFS filehandle of the file to open
> > + * @type: S_IFMT inode type allowed (0 means any type is allowed)
> >   * @may_flags: internal permission flags
> >   * @filp: OUT: open "struct file *"
> >   *
> >   * Returns zero on success, or a negative errno value.
> >   */
> >  int
> > -nfsd_open_verified(struct svc_fh *fhp, int may_flags, struct file **fi=
lp)
> > +nfsd_open_verified(struct svc_fh *fhp, umode_t type, int may_flags, st=
ruct file **filp)
> >  {
> > -	return __nfsd_open(fhp, S_IFREG, may_flags, filp);
> > +	return __nfsd_open(fhp, type, may_flags, filp);
> >  }
> > =20
> >  /*
> > diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> > index fa46f8b5f132079e3a2c45e71ecf9cc43181f6b0..ded2900d423f80d33fb6c8b=
809bc5d9fc842ebfd 100644
> > --- a/fs/nfsd/vfs.h
> > +++ b/fs/nfsd/vfs.h
> > @@ -114,7 +114,7 @@ __be32		nfsd_setxattr(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
> >  int 		nfsd_open_break_lease(struct inode *, int);
> >  __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
> >  				int, struct file **);
> > -int		nfsd_open_verified(struct svc_fh *fhp, int may_flags,
> > +int		nfsd_open_verified(struct svc_fh *fhp, umode_t type, int may_flag=
s,
> >  				struct file **filp);
> >  __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  				struct file *file, loff_t offset,
> >=20
>=20
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
>=20
> These can probably go in via Christian's tree. I don't think there
> are going to be conflicts between these and what's in nfsd-testing
> now.

That would work. I think I have at least one more respin of the VFS
bits before we merge anything anyway.
--=20
Jeff Layton <jlayton@kernel.org>

