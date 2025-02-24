Return-Path: <linux-fsdevel+bounces-42543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9BEA430DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 00:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BBE3A353F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 23:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA0320C463;
	Mon, 24 Feb 2025 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="loBfTiR6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J3mvHyzY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="loBfTiR6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J3mvHyzY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0638320B213
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439794; cv=none; b=ZfQgKNmbZk0HSsw4xaSkAoL0XsigLg1JsIywnCdqQYwYFW1Dw1wxqkPp+wR37cSnW9kwLgG/QZ+Sf1CWYJnGR2YstDgNXVhIwCVul4xtEjFn8tyJrNpj8E2Y2ZKDEXRfXuXdoDbGmq5b198iih2OUXKWvRkMKfjIwKRugUu6Ebw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439794; c=relaxed/simple;
	bh=vt/y9E4/DcaZ9NV1EBDUcDNYGDvwjv/mQRtyYJZcYqk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=N6pwwqkeWU5piX4QoVAAY88snhpDT5X05DS98EyaY4f3AvVjS8EIDWhnWD4Zzlf7OCsb+wSF18LW0mFGEPLKliImgar1FVaytMUHRUZZq35w/kEfdszm3C2iyHQ0FKkaGtwHkvJA7flXswWH61YE8EKQ37J8qFBFd8zBA8q/nNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=loBfTiR6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J3mvHyzY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=loBfTiR6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J3mvHyzY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1769F1F44E;
	Mon, 24 Feb 2025 23:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740439789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2oj990YaLGkPA4ae4sIKmdEX5RxKU3jTg87RjSWSYeg=;
	b=loBfTiR6kAlC/sS0ot1CDtcKEiKmB6GXrsHNK+SsrbeZzGdV6O2ZrsmO8jw3wvJPHK58Kj
	glzLsVFTkUpcycBhzhfiLzoYOAwECgg5wubkGZIw8GCF2DWKEIFm9faiQIbZ45b9stImh9
	J9FQoxLwzfFLcLMM4Nzxcdvxtbe/i94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740439789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2oj990YaLGkPA4ae4sIKmdEX5RxKU3jTg87RjSWSYeg=;
	b=J3mvHyzY65SyoNedSF0MYSEG2w3R6giaas15VW09Vb9TUfaAv1RMGveIpiZI1/xnVIoKU6
	p9GIZjyHOh0bImAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740439789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2oj990YaLGkPA4ae4sIKmdEX5RxKU3jTg87RjSWSYeg=;
	b=loBfTiR6kAlC/sS0ot1CDtcKEiKmB6GXrsHNK+SsrbeZzGdV6O2ZrsmO8jw3wvJPHK58Kj
	glzLsVFTkUpcycBhzhfiLzoYOAwECgg5wubkGZIw8GCF2DWKEIFm9faiQIbZ45b9stImh9
	J9FQoxLwzfFLcLMM4Nzxcdvxtbe/i94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740439789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2oj990YaLGkPA4ae4sIKmdEX5RxKU3jTg87RjSWSYeg=;
	b=J3mvHyzY65SyoNedSF0MYSEG2w3R6giaas15VW09Vb9TUfaAv1RMGveIpiZI1/xnVIoKU6
	p9GIZjyHOh0bImAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A647613332;
	Mon, 24 Feb 2025 23:29:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5OlzEuQAvWc2awAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 24 Feb 2025 23:29:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Viacheslav Dubeyko" <Slava.Dubeyko@ibm.com>
Cc: "brauner@kernel.org" <brauner@kernel.org>, "Xiubo Li" <xiubli@redhat.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "anna@kernel.org" <anna@kernel.org>, "miklos@szeredi.hu" <miklos@szeredi.hu>,
 "trondmy@kernel.org" <trondmy@kernel.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "jack@suse.cz" <jack@suse.cz>, "tom@talpey.com" <tom@talpey.com>,
 "richard@nod.at" <richard@nod.at>,
 "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "netfs@lists.linux.dev" <netfs@lists.linux.dev>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
 "senozhatsky@chromium.org" <senozhatsky@chromium.org>
Subject: RE:  [PATCH 3/6] ceph: return the correct dentry on mkdir
In-reply-to: <f7d3e39f5ced7832d451de172004172b59a994eb.camel@ibm.com>
References: <>, <f7d3e39f5ced7832d451de172004172b59a994eb.camel@ibm.com>
Date: Tue, 25 Feb 2025 10:29:37 +1100
Message-id: <174043977707.74271.6498110571534472585@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org,oracle.com,lists.infradead.org,sipsolutions.net,szeredi.hu,zeniv.linux.org.uk,suse.cz,talpey.com,nod.at,cambridgegreys.com,lists.linux.dev,chromium.org];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, 25 Feb 2025, Viacheslav Dubeyko wrote:
> On Mon, 2025-02-24 at 13:15 +1100, NeilBrown wrote:
> > On Fri, 21 Feb 2025, Viacheslav Dubeyko wrote:
> > > On Fri, 2025-02-21 at 10:36 +1100, NeilBrown wrote:
> > > > ceph already splices the correct dentry (in splice_dentry()) from the
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
> > > > @@ -1099,6 +1099,7 @@ static struct dentry *ceph_mkdir(struct mnt_idm=
ap *idmap, struct inode *dir,
> > > >  	struct ceph_client *cl =3D mdsc->fsc->client;
> > > >  	struct ceph_mds_request *req;
> > > >  	struct ceph_acl_sec_ctx as_ctx =3D {};
> > > > +	struct dentry *ret =3D NULL;
> > >=20
> > > I believe that it makes sense to initialize pointer by error here and a=
lways
> > > return ret as output. If something goes wrong in the logic, then we alr=
eady have
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
> > > > @@ -1166,14 +1167,20 @@ static struct dentry *ceph_mkdir(struct mnt_i=
dmap *idmap, struct inode *dir,
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
> > > It looks not good to leave this comment instead of proper implementatio=
n. Do we
> > > have some obstacles to make this decision?
> >=20
> > I suspect we should use ret, but I didn't want to make a change which
> > wasn't directly required by my needed.  So I highlighted this which
> > looks to me like a possible bug, hoping that someone more familiar with
> > the code would give an opinion.  Do you agree that 'ret' (i.e.
> > ->r_dentry) should be used when ret is not NULL?
> >=20
>=20
> I think if we are going to return ret as a dentry, then it makes sense to c=
all
> the ceph_init_inode_acls() for d_inode(ret). I don't see the point to call
> ceph_init_inode_acls() for d_inode(dentry) then.

If the mkdir used the original dentry, then ->mkdir returns NULL so ret
is NULL.  If the mkdir used a different dentry it returns that, so ret
is not NULL.

I'll try to re-organise the code so that "dentry" is the correct dentry
on success, and "ret" is the returned dentry, which might be NULL.

Thanks,
NeilBrown


>=20
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
> > @@ -1099,6 +1099,7 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *=
idmap, struct inode *dir,
> >  	struct ceph_client *cl =3D mdsc->fsc->client;
> >  	struct ceph_mds_request *req;
> >  	struct ceph_acl_sec_ctx as_ctx =3D {};
> > +	struct dentry *ret;
> >  	int err;
> >  	int op;
> > =20
> > @@ -1116,32 +1117,32 @@ static struct dentry *ceph_mkdir(struct mnt_idmap=
 *idmap, struct inode *dir,
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
> > @@ -1165,15 +1166,23 @@ static struct dentry *ceph_mkdir(struct mnt_idmap=
 *idmap, struct inode *dir,
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
>=20


