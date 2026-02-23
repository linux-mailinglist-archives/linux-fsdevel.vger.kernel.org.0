Return-Path: <linux-fsdevel+bounces-78012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKMtOGnVnGkJLAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:32:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF7817E634
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82333308EB83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 22:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784CF37B417;
	Mon, 23 Feb 2026 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="djhRLti+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kVmRdWfn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA66D334C35;
	Mon, 23 Feb 2026 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885825; cv=none; b=ok1rklj0xKwZUP+/X4N1k+bPj1RbacGiPftlLdnRe9UkViiHvrtF+ZNPzqIyFveqi5VAfCYtJ3pISB7CMzHVfMRVY3gJruqYmu0C01E5qyIBPfFJIEbUEtmvtynKVGnhLCMFcGdoJX7HgPxHQwm1TOr8SVI9WkzRcC0cvXMnx2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885825; c=relaxed/simple;
	bh=/5WFghxPGeFYVrk72aGIi9ZnNXwEdI2MoZ8rzkMC3Kk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LHex+miy5xXaIerO+TZMxsxqBDQ1TJ0/h7VTAVhJB+dvVkg+Np9LfKtpmmPobW8l0FdlQtyyf86n4G63xODdtz+fFXp0QMtQH964RF31mgMRlEDu4XgAwQail8uVptTqEnJRhbl0oXqtr96DPgYalxDjNvt7ToeOMSbIrvdtJS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=djhRLti+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kVmRdWfn; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id F1CAA1380AB6;
	Mon, 23 Feb 2026 17:30:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 23 Feb 2026 17:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1771885822; x=1771893022; bh=QzPV/qCsvxJY4RwTgulk7KEWJKUjbc4FEPm
	hIim+IiA=; b=djhRLti+RvB4XemjfWD0EGKH+SyajCh3gm9zwfTCWq4STAmXhK6
	u2+/KfXPPOvJdAeU54mCxbV71Pi1BCNPB17vZnN2110NQSzU4FGeZkXDaDS2AF7b
	G/ezW2vhfH0RO5zFxgazqijD1F+SMVKZSUeUVdAE7VhDjDMs2oY3wSlkFuTOWJIm
	GqdKEmRTD3DHvuon+RnZ0A6a4NRyTeTkgqOuVg7zFtCltMu40B6gWucVLaWrHoqB
	TYnsKZ4h6jgbYKkYuHY9vzfknKqMf4mud88OA8e6yJFrx19KO3aVO7y60QWiwnkj
	KDk/ISG745cbpvclm1EQjUSQRC2prpvPpiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771885822; x=
	1771893022; bh=QzPV/qCsvxJY4RwTgulk7KEWJKUjbc4FEPmhIim+IiA=; b=k
	VmRdWfnIrkeJyEoqdscTtwVT706JFZqlgJWfXPtESrxAPRmLPhIxguvo3m9eCjv6
	EPTSmJcXbrVXTs5wxxQMu6ZmrMxaXNlhXH7dMdg/HUQh8AnTHsQxs766764EN1K9
	Pl1GUL3dFynomKEenFL8gRr/iWKUGU5xF9kdwsPUvtfjCTsias/z4Ora+NhB+HvA
	/ONGi/I1SHx3V3FGSnEeiI/Mx0KOwlK6pqAhyw3udewuNZ+FQAVgUtLvg9jPIMof
	K2/CDV2eimzzbpRZlM3ycw1rJJRGy8q7cNpOAt7S4CmaHcKQBeHi2YARveRlxsR/
	Lt6IeYvaPpPsa8OcYhhPQ==
X-ME-Sender: <xms:_tScaYCVOuOT5HF7SS7Ns-60gnJ9sHBVIc4G4rgk7eCI06DME4NG4g>
    <xme:_tScaWrW5IwCYdtB8R1FACRpoo7NbI-dLI5fXlDaub2sLit8cTFp4OtrASLfWECHR
    B0YKnggJSYi2Vo4mvXKq_CdfDjTDbbna361hTsCMUUZaCVRpg>
X-ME-Received: <xmr:_tScaXbTFFTa5dkWNYh-O-hx7ORzbjajQ29KCg8vwjcV07r-8ojO9nWqJ9z0rLYt3WzMeuPRRRN1lRfkPawTdkgjLU-ER6jIBfbmMILB3mlk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhr
    tghpthhtohepjhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:_tScaYGo_lqp-egiVcRdWUjPAhdxRr-P0HT0Gek5_qsPVsGfDLpXkA>
    <xmx:_tScadZVvLvB_E-eV5b_oH55r9FAloGTyz4tjDrjkZiagukPs_ZL1A>
    <xmx:_tScadfFBTM_fc4MAdPMac2eX6IsH3FJBHJWmkD9DMvxzQW5YAwsDQ>
    <xmx:_tScaZDD1MGGGm2IS_KjTsY4Jp5l0Plp2q95xNlGhLq3BdTcMO1phA>
    <xmx:_tScae7MQvlqGATc6P23ySuIK9WPMcHeQyrDKLc_2QLOT0hbBUadUWqj>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 17:30:16 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chris Mason" <clm@meta.com>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "David Howells" <dhowells@redhat.com>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Amir Goldstein" <amir73il@gmail.com>,
 "John Johansen" <john.johansen@canonical.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
Subject: Re: [PATCH v2 12/15] ovl: change ovl_create_real() to get a new lock
 when re-opening created file.
In-reply-to: <20260223132424.105125-1-clm@meta.com>
References: <20260223011210.3853517-1-neilb@ownmail.net>,
 <20260223011210.3853517-13-neilb@ownmail.net>,
 <20260223132424.105125-1-clm@meta.com>
Date: Tue, 24 Feb 2026 09:30:14 +1100
Message-id: <177188581436.8396.15474182964858193799@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78012-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,ownmail.net:email,ownmail.net:dkim,messagingengine.com:dkim,noble.neil.brown.name:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FF7817E634
X-Rspamd-Action: no action

On Tue, 24 Feb 2026, Chris Mason wrote:
> NeilBrown <neilb@ownmail.net> wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > When ovl_create_real() is used to create a file on the upper filesystem
> > it needs to return the resulting dentry - positive and hashed.
> > It is usually the case the that dentry passed to the create function
> > (e.g.  vfs_create()) will be suitable but this is not guaranteed.  The
> > filesystem may unhash that dentry forcing a repeat lookup next time the
> > name is wanted.
> >=20
>=20
> Hi everyone,
>=20
> Amir suggested I run these through, and this commit was flagged:
>=20
> commit 62d49d1e44667e4f93bec415faabec5526992ac0
> Author: NeilBrown <neil@brown.name>
>=20
> ovl: change ovl_create_real() to get a new lock when re-opening created fil=
e.
>=20
> This commit changes ovl_create_real() to drop the directory lock and
> reacquire a new lock for lookup when the created dentry is unhashed. It
> also removes ovl_lookup_upper() which is no longer used.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
>=20
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index c4feb89ad1e39..6285069ccc590 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -159,7 +159,8 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, stru=
ct dentry *dir,
> >  }
> >
> >  struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
> > -			       struct dentry *newdentry, struct ovl_cattr *attr)
> > +			       struct dentry *newdentry, struct qstr *qname,
> > +			       struct ovl_cattr *attr)
> >  {
> >  	struct inode *dir =3D parent->d_inode;
> >  	int err;
> > @@ -221,19 +222,29 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, =
struct dentry *parent,
> >  		struct dentry *d;
> >  		/*
> >  		 * Some filesystems (i.e. casefolded) may return an unhashed
> > -		 * negative dentry from the ovl_lookup_upper() call before
> > +		 * negative dentry from the ovl_start_creating_upper() call before
> >  		 * ovl_create_real().
> >  		 * In that case, lookup again after making the newdentry
> >  		 * positive, so ovl_create_upper() always returns a hashed
> > -		 * positive dentry.
> > +		 * positive dentry.  We lookup using qname which should be
> > +		 * the same name as newentry, but is certain not to change.
> > +		 * As we have to drop the lock before the lookup a race
> > +		 * could result in a lookup failure.  In that case we return
> > +		 * an error.
> >  		 */
> > -		d =3D ovl_lookup_upper(ofs, newdentry->d_name.name, parent,
> > -				     newdentry->d_name.len);
> > -		dput(newdentry);
> > -		if (IS_ERR_OR_NULL(d))
> > +		end_creating_keep(newdentry);
> > +		d =3D ovl_start_creating_upper(ofs, parent, qname);
> > +
> > +		if (IS_ERR_OR_NULL(d)) {
> >  			err =3D d ? PTR_ERR(d) : -ENOENT;
> > +		} else if (d->d_inode !=3D newdentry->d_inode) {
> > +			err =3D -EIO;
> > +			dput(newdentry);
> > +		} else {
> > +			dput(newdentry);
> >  			return d;
> > +		}
> > +		return ERR_PTR(err);
> >  	}
>=20
> Does this leak the newdentry reference when IS_ERR_OR_NULL(d) is true?
>=20
> The code now calls end_creating_keep(newdentry) which keeps the reference,
> then calls ovl_start_creating_upper(). If that returns an error or NULL,
> the function returns ERR_PTR(err) without cleaning up newdentry:
>=20
> 	end_creating_keep(newdentry);
> 	d =3D ovl_start_creating_upper(ofs, parent, qname);
>=20
> 	if (IS_ERR_OR_NULL(d)) {
> 		err =3D d ? PTR_ERR(d) : -ENOENT;
> 	} ...
> 	return ERR_PTR(err);
>=20
> The old code always went through the 'out:' label which called
> end_creating(newdentry) on error. The new code bypasses that cleanup.
>=20
>=20
> Does this leak both the parent lock and the dentry 'd' when the lookup
> returns a different inode?
>=20
> When d->d_inode !=3D newdentry->d_inode, the code sets err =3D -EIO and cal=
ls
> dput(newdentry), but doesn't clean up 'd':
>=20
> 	} else if (d->d_inode !=3D newdentry->d_inode) {
> 		err =3D -EIO;
> 		dput(newdentry);
> 	} ...
> 	return ERR_PTR(err);
>=20
> The dentry 'd' was returned by ovl_start_creating_upper() with the parent
> directory lock held. The code needs to call end_creating(d) to release the
> lock via end_dirop()->inode_unlock() and release the dentry reference via
> end_dirop()->dput().
>=20
>=20

Yes, that code is rather messed up - thanks.

I've made it:

		end_creating_keep(newdentry);
		d =3D ovl_start_creating_upper(ofs, parent, qname);

		if (IS_ERR_OR_NULL(d)) {
			err =3D d ? PTR_ERR(d) : -ENOENT;
		} else if (d->d_inode !=3D newdentry->d_inode) {
			err =3D -EIO;
		} else {
			dput(newdentry);
			return d;
		}
		end_creating(d);
		dput(newdentry);
		return ERR_PTR(err);

Thanks,
NeilBrown

