Return-Path: <linux-fsdevel+bounces-42542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1707A4304F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 23:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D443B91ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A586620B21B;
	Mon, 24 Feb 2025 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHUU2wNt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E153D3DBB6;
	Mon, 24 Feb 2025 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437643; cv=none; b=YfSDk0+Kvxcvk2U9ptX+hsy6ZWJS0XzTENIXbPCZg5+IUzpeqFtCq4AF283Z6K/5W1DEJMHmk8ysJUntn8aOQIEcFScU8jj5V8EPWguLsIxu88FaK4mLZ3IqdzvCqkg2HTnnlrADOdvMRE/Y0N80LoHrFzXu4BSMUSWpNnHVFok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437643; c=relaxed/simple;
	bh=8wuf28wcKNuRFZdMryVLcMXa96tPa4E/Eq++v1inuV0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PXzwMvUN9nrKvhZS2z1B8dpQ8PThkGGjNbpKYLlJS+r8rmO1l3hFGjt3yM0Bcn4ntlkUCVkP8obzD5L0osZksCAwDgb0QaWdWL7AODJuzxBv0QZN7p0GUYqC9xLXq5Kbal+74j+FxQhRrtrNWjXvoUfbAiknNRhA2mkbTCwTdL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHUU2wNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39741C4CED6;
	Mon, 24 Feb 2025 22:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740437642;
	bh=8wuf28wcKNuRFZdMryVLcMXa96tPa4E/Eq++v1inuV0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HHUU2wNtbPxKlY60qOTDIMfm6GIQC0nNHYDf0bVZDHCeCG3aof4JGpEtYytvszbdD
	 xK9Hv55DBhUChS3xWYpZzJrqHz64P26euumNmN+VCX28FndTglvCXBjkelnjYx/hSh
	 9CdYpaYIzVypAKhNh2FW4WSAWoElE/cveUEzandN3GJBFY1nYDrUhN0/9q6hy9CzK+
	 3yD3/53RHsAL1dIiCuZNk4k10u180WjbvgrO8aGgPxJKWeip3FPoyplJj0huSXsYyG
	 3r3Hs4w6YzNv5mvhta5jwLu49cVlgBQ4iwqiV27mbWEabdyNYHxvcGwkp7uT2SPu/G
	 4/8heotc+xjiQ==
Message-ID: <574058aa674be2c9e802f88af7e6b224597199e8.camel@kernel.org>
Subject: Re:  [PATCH 3/6] ceph: return the correct dentry on mkdir
From: Jeff Layton <jlayton@kernel.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "neilb@suse.de"
 <neilb@suse.de>
Cc: "brauner@kernel.org" <brauner@kernel.org>, Xiubo Li <xiubli@redhat.com>,
  "idryomov@gmail.com"	 <idryomov@gmail.com>, Olga Kornievskaia
 <okorniev@redhat.com>,  "linux-cifs@vger.kernel.org"	
 <linux-cifs@vger.kernel.org>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, 
 "linux-um@lists.infradead.org"	 <linux-um@lists.infradead.org>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "johannes@sipsolutions.net"	 <johannes@sipsolutions.net>,
 "chuck.lever@oracle.com" <chuck.lever@oracle.com>,  "anna@kernel.org"	
 <anna@kernel.org>, "miklos@szeredi.hu" <miklos@szeredi.hu>, 
 "trondmy@kernel.org"	 <trondmy@kernel.org>, "viro@zeniv.linux.org.uk"
 <viro@zeniv.linux.org.uk>,  "jack@suse.cz"	 <jack@suse.cz>,
 "tom@talpey.com" <tom@talpey.com>, "richard@nod.at"	 <richard@nod.at>,
 "anton.ivanov@cambridgegreys.com"	 <anton.ivanov@cambridgegreys.com>,
 "linux-fsdevel@vger.kernel.org"	 <linux-fsdevel@vger.kernel.org>,
 "netfs@lists.linux.dev" <netfs@lists.linux.dev>, 
 "linux-nfs@vger.kernel.org"	 <linux-nfs@vger.kernel.org>,
 "ceph-devel@vger.kernel.org"	 <ceph-devel@vger.kernel.org>,
 "senozhatsky@chromium.org"	 <senozhatsky@chromium.org>
Date: Mon, 24 Feb 2025 17:53:58 -0500
In-Reply-To: <f7d3e39f5ced7832d451de172004172b59a994eb.camel@ibm.com>
References: <>, <e77d268e129b8002e894fc7c16ae0e2faa1cd8dd.camel@ibm.com>
		 <174036334830.74271.5394074407973955108@noble.neil.brown.name>
	 <f7d3e39f5ced7832d451de172004172b59a994eb.camel@ibm.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-24 at 22:09 +0000, Viacheslav Dubeyko wrote:
> On Mon, 2025-02-24 at 13:15 +1100, NeilBrown wrote:
> > On Fri, 21 Feb 2025, Viacheslav Dubeyko wrote:
> > > On Fri, 2025-02-21 at 10:36 +1100, NeilBrown wrote:
> > > > ceph already splices the correct dentry (in splice_dentry()) from t=
he
> > > > result of mkdir but does nothing more with it.
> > > >=20
> > > > Now that ->mkdir can return a dentry, return the correct dentry.
> > > >=20
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > ---
> > > >  fs/ceph/dir.c | 9 ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > > > index 39e0f240de06..c1a1c168bb27 100644
> > > > --- a/fs/ceph/dir.c
> > > > +++ b/fs/ceph/dir.c
> > > > @@ -1099,6 +1099,7 @@ static struct dentry *ceph_mkdir(struct mnt_i=
dmap *idmap, struct inode *dir,
> > > >  	struct ceph_client *cl =3D mdsc->fsc->client;
> > > >  	struct ceph_mds_request *req;
> > > >  	struct ceph_acl_sec_ctx as_ctx =3D {};
> > > > +	struct dentry *ret =3D NULL;
> > >=20
> > > I believe that it makes sense to initialize pointer by error here and=
 always
> > > return ret as output. If something goes wrong in the logic, then we a=
lready have
> > > error.
> >=20
> > I'm not certain that I understand, but I have made a change which seems
> > to be consistent with the above and included it below.  Please let me
> > know if it is what you intended.
> >=20
> > >=20
> > > >  	int err;
> > > >  	int op;
> > > > =20
> > > > @@ -1166,14 +1167,20 @@ static struct dentry *ceph_mkdir(struct mnt=
_idmap *idmap, struct inode *dir,
> > > >  	    !req->r_reply_info.head->is_dentry)
> > > >  		err =3D ceph_handle_notrace_create(dir, dentry);
> > > >  out_req:
> > > > +	if (!err && req->r_dentry !=3D dentry)
> > > > +		/* Some other dentry was spliced in */
> > > > +		ret =3D dget(req->r_dentry);
> > > >  	ceph_mdsc_put_request(req);
> > > >  out:
> > > >  	if (!err)
> > > > +		/* Should this use 'ret' ?? */
> > >=20
> > > Could we make a decision should or shouldn't? :)
> > > It looks not good to leave this comment instead of proper implementat=
ion. Do we
> > > have some obstacles to make this decision?
> >=20
> > I suspect we should use ret, but I didn't want to make a change which
> > wasn't directly required by my needed.  So I highlighted this which
> > looks to me like a possible bug, hoping that someone more familiar with
> > the code would give an opinion.  Do you agree that 'ret' (i.e.
> > ->r_dentry) should be used when ret is not NULL?
> >=20
>=20
> I think if we are going to return ret as a dentry, then it makes sense to=
 call
> the ceph_init_inode_acls() for d_inode(ret). I don't see the point to cal=
l
> ceph_init_inode_acls() for d_inode(dentry) then.
>=20

My assumption when looking at this was that they should point to the
same inode. That said, working with d_inode(ret) after that point is
less confusing to the casual reader.

> > >=20
> > > >  		ceph_init_inode_acls(d_inode(dentry), &as_ctx);
> > > >  	else
> > > >  		d_drop(dentry);
> > > >  	ceph_release_acl_sec_ctx(&as_ctx);
> > > > -	return ERR_PTR(err);
> > > > +	if (err)
> > > > +		return ERR_PTR(err);
> > > > +	return ret;
> > >=20
> > > What's about this?
> > >=20
> > > return err ? ERR_PTR(err) : ret;
> >=20
> > We could do that, but you said above that you thought we should always
> > return 'ret' - which does make some sense.
> >=20
> > What do you think of the following alternate patch?
> >=20
>=20
> Patch looks good to me. Thanks.
>=20
> Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>=20
> > Thanks,
> > NeilBrown
> >=20
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index 39e0f240de06..d2e5c557df83 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -1099,6 +1099,7 @@ static struct dentry *ceph_mkdir(struct mnt_idmap=
 *idmap, struct inode *dir,
> >  	struct ceph_client *cl =3D mdsc->fsc->client;
> >  	struct ceph_mds_request *req;
> >  	struct ceph_acl_sec_ctx as_ctx =3D {};
> > +	struct dentry *ret;
> >  	int err;
> >  	int op;
> > =20
> > @@ -1116,32 +1117,32 @@ static struct dentry *ceph_mkdir(struct mnt_idm=
ap *idmap, struct inode *dir,
> >  		      ceph_vinop(dir), dentry, dentry, mode);
> >  		op =3D CEPH_MDS_OP_MKDIR;
> >  	} else {
> > -		err =3D -EROFS;
> > +		ret =3D ERR_PTR(-EROFS);
> >  		goto out;
> >  	}
> > =20
> >  	if (op =3D=3D CEPH_MDS_OP_MKDIR &&
> >  	    ceph_quota_is_max_files_exceeded(dir)) {
> > -		err =3D -EDQUOT;
> > +		ret =3D ERR_PTR(-EDQUOT);
> >  		goto out;
> >  	}
> >  	if ((op =3D=3D CEPH_MDS_OP_MKSNAP) && IS_ENCRYPTED(dir) &&
> >  	    !fscrypt_has_encryption_key(dir)) {
> > -		err =3D -ENOKEY;
> > +		ret =3D ERR_PTR(-ENOKEY);
> >  		goto out;
> >  	}
> > =20
> > =20
> >  	req =3D ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
> >  	if (IS_ERR(req)) {
> > -		err =3D PTR_ERR(req);
> > +		ret =3D ERR_CAST(req);
> >  		goto out;
> >  	}
> > =20
> >  	mode |=3D S_IFDIR;
> >  	req->r_new_inode =3D ceph_new_inode(dir, dentry, &mode, &as_ctx);
> >  	if (IS_ERR(req->r_new_inode)) {
> > -		err =3D PTR_ERR(req->r_new_inode);
> > +		ret =3D ERR_CAST(req->r_new_inode);
> >  		req->r_new_inode =3D NULL;
> >  		goto out_req;
> >  	}
> > @@ -1165,15 +1166,23 @@ static struct dentry *ceph_mkdir(struct mnt_idm=
ap *idmap, struct inode *dir,
> >  	    !req->r_reply_info.head->is_target &&
> >  	    !req->r_reply_info.head->is_dentry)
> >  		err =3D ceph_handle_notrace_create(dir, dentry);
> > +	ret =3D ERR_PTR(err);
> >  out_req:
> > +	if (!IS_ERR(ret) && req->r_dentry !=3D dentry)
> > +		/* Some other dentry was spliced in */
> > +		ret =3D dget(req->r_dentry);
> >  	ceph_mdsc_put_request(req);
> >  out:
> > -	if (!err)
> > -		ceph_init_inode_acls(d_inode(dentry), &as_ctx);
> > -	else
> > +	if (!IS_ERR(ret)) {
> > +		if (ret)
> > +			ceph_init_inode_acls(d_inode(ret), &as_ctx);
> > +		else
> > +			ceph_init_inode_acls(d_inode(dentry), &as_ctx);
> > +	} else {
> >  		d_drop(dentry);
> > +	}
> >  	ceph_release_acl_sec_ctx(&as_ctx);
> > -	return ERR_PTR(err);
> > +	return ret;
> >  }
> > =20
> >  static int ceph_link(struct dentry *old_dentry, struct inode *dir,
> >=20
>=20
> Thanks,
> Slava.
>=20

--=20
Jeff Layton <jlayton@kernel.org>

