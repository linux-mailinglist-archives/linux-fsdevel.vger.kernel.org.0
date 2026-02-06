Return-Path: <linux-fsdevel+bounces-76506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEP1EFI5hWmS+QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 01:44:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF59F8BF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 01:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 243D0300B445
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 00:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0FF229B2A;
	Fri,  6 Feb 2026 00:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="VXOpK8fH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dn6V78+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB2B225408;
	Fri,  6 Feb 2026 00:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770338633; cv=none; b=pGEpK1Fg5lSUeCDUpgLIUiXE7+FxIspvnrvBe3c0jGY4xqzyC3DByAna0KG3Sh03Tb2cSrzYM8qPWL7yqzFXZnGWN/51T9RNYhSl1eRuYkcjs2ab4v4qVQ6S+RTwNUCWPbTdZnUjkJqJ2+6IKXQdv4hFTC/rw/tXFmUYeOZR8z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770338633; c=relaxed/simple;
	bh=B6vsCIv0NxmuoS9AgdlydEh11lEAq/6bM8IdGMXrHgY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hqTEwCRS/0wIwPy75h5jd69V2SqWRv0p4ZKWGibRrBM4gzerMuO43gc0QSJjUCSgAw0EnUtCG05twSZCqztqYIXSO8++umtilps3BbcGjcszNHEAKwKItNH7f7o5AZnlBRJJ6VGniiM9mtu+mfHAaDvSIi+Svod3j0yrI+DBY8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=VXOpK8fH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dn6V78+j; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 5999E1380A43;
	Thu,  5 Feb 2026 19:43:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 05 Feb 2026 19:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1770338632; x=1770345832; bh=cmlvY2WVMaI2/0++B9slQhcJiXu+2rbDUBq
	lXijKh2o=; b=VXOpK8fHiqa+cOMT5uGBQeQStYUmKYIgtE67aKsnwHpfqlajOMZ
	HlqXd4DtRG86gLyzfWDkupTjHVEYT256ADDb93Uco2RSrJwwrg0P+uAfoDKdD3F7
	ZZ3j0BDB3la6nQ3YqN2eg+Qlf9xg7RIv6xQ8QRZtTNLB1/Vq3syi85GrdRVaT57e
	WlCJqWtprfJLSHpcU+kcF36GvQF5mSDd28z59jxyfT6rvNh9M58OmzFmmwDDkOlv
	3Nd7bdzdNR2t/vSsrdrDTk574fFETBnw/1ETPC0ShZqCTawX2Kps/arerxTLhR/K
	CHsMDtlfW2qgkLdee0PfPtgsSE6Gn8m0+zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770338632; x=
	1770345832; bh=cmlvY2WVMaI2/0++B9slQhcJiXu+2rbDUBqlXijKh2o=; b=d
	n6V78+jp32a1vd2V7DpZi13ve6QYYDl0sm0mhTTGtpDsMnxL1bzYvCbOoEK/zAta
	c2wTPHtgwt2mGaAwtYRM/amfRXW6/SuCZ7RKwO/aJxypJBdF32yCS6BJb4X9MRch
	VRfIPWztOancM5RgYFmyFMcmhxRLGT2h9GIPIWfhS1kSTNDT4cMayfrlqfDb3Itg
	Hp66L3tM8l+oeJEeBqw8MrJsnjtUvIsAY5iRVn15wIBwvtN+1MQ84x8Ft+/OmR48
	hxV+Qeu9qX/YXMMLHiHnz8ZY+G6KbE51MdKGANypIUB8e6UAzEnYypGslblTggfd
	o1woO0iBaVwE/aF3NnBDQ==
X-ME-Sender: <xms:RzmFaboaV45VBlKHNyrkIFVvgPmo3eMvMSLpIOP_r74BkBXCqCXW2w>
    <xme:RzmFaRMko5Lhw6n--W_wxlLIJvg-T1OdP-uqkWLnh_Zcfn8QS6l_koZ7FoYTy5Gd8
    oodJNe3NouGyNRzoRwq_bcp6sItGNIo-q39edIZ9caQFJlOiw>
X-ME-Received: <xmr:RzmFaYMKXouTvPMzZuUiQfpY_BvLqtYOT_rlz7GlIvM78oPct_YBUkLBy-__NJTGitLcQr4ZqMU7KVo9ydW5ItQgljdgsiU7CPuzsE_cfWTl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeijeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhr
    tghpthhtohepjhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:RzmFaT0fkSFhIKkBeQfaQ3YG3bIYRAYGxDHkLA_fskBCLtx_OS7NIQ>
    <xmx:RzmFac0rQ7f0x5AXuvVQ7DW-cvVqkZgipPPkLp78hDk59buK8hVrzQ>
    <xmx:RzmFaSykkpQ1kwEeQU_BS8DrKPCXzZQck55M5-oJvvRGNmeCUHGQ6A>
    <xmx:RzmFafnHxx7KLGr-uBlwntHItcoYTv4_HeKg1pcU0UhYJHFRXWCCtg>
    <xmx:SDmFaewzj9eVyj5u1DsJGWltseq4K-d6SY0j8fEggkV4iXFHaRYSROq8>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 19:43:45 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "David Howells" <dhowells@redhat.com>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Miklos Szeredi" <miklos@szeredi.hu>,
 "John Johansen" <john.johansen@canonical.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 08/13] ovl: Simplify ovl_lookup_real_one()
In-reply-to:
 <CAOQ4uxh_Ugyy9=Vx_XOzWMTdhqVx6kAu43q+F+afhNF_Zv_9TA@mail.gmail.com>
References: <20260204050726.177283-1-neilb@ownmail.net>,
 <20260204050726.177283-9-neilb@ownmail.net>,
 <5d273a008fc51a2fded785efbe30e5bd2a89b985.camel@kernel.org>,
 <CAOQ4uxh_Ugyy9=Vx_XOzWMTdhqVx6kAu43q+F+afhNF_Zv_9TA@mail.gmail.com>
Date: Fri, 06 Feb 2026 11:43:43 +1100
Message-id: <177033862352.16766.1800645278281300265@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76506-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[ownmail.net];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,canonical.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,noble.neil.brown.name:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,brown.name:replyto,brown.name:email]
X-Rspamd-Queue-Id: 2AF59F8BF9
X-Rspamd-Action: no action

On Fri, 06 Feb 2026, Amir Goldstein wrote:
> On Thu, Feb 5, 2026 at 1:38=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
> >
> > On Wed, 2026-02-04 at 15:57 +1100, NeilBrown wrote:
> > > From: NeilBrown <neil@brown.name>
> > >
> > > The primary purpose of this patch is to remove the locking from
> > > ovl_lookup_real_one() as part of centralising all locking of directories
> > > for name operations.
> > >
> > > The locking here isn't needed.  By performing consistency tests after
> > > the lookup we can be sure that the result of the lookup was valid at
> > > least for a moment, which is all the original code promised.
> > >
> > > lookup_noperm_unlocked() is used for the lookup and it will take the
> > > lock if needed only where it is needed.
> > >
> > > Also:
> > >  - don't take a reference to real->d_parent.  The parent is
> > >    only use for a pointer comparison, and no reference is needed for
> > >    that.
> > >  - Several "if" statements have a "goto" followed by "else" - the
> > >    else isn't needed: the following statement can directly follow
> > >    the "if" as a new statement
> > >  - Use a consistent pattern of setting "err" before performing a test
> > >    and possibly going to "fail".
> > >  - remove the "out" label (now that we don't need to dput(parent) or
> > >    unlock) and simply return from fail:.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/overlayfs/export.c | 61 ++++++++++++++++++-------------------------
> > >  1 file changed, 26 insertions(+), 35 deletions(-)
> > >
> > > diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> > > index 83f80fdb1567..dcd28ffc4705 100644
> > > --- a/fs/overlayfs/export.c
> > > +++ b/fs/overlayfs/export.c
> > > @@ -359,59 +359,50 @@ static struct dentry *ovl_lookup_real_one(struct =
dentry *connected,
> > >                                         struct dentry *real,
> > >                                         const struct ovl_layer *layer)
> > >  {
> > > -     struct inode *dir =3D d_inode(connected);
> > > -     struct dentry *this, *parent =3D NULL;
> > > +     struct dentry *this;
> > >       struct name_snapshot name;
> > >       int err;
> > >
> > >       /*
> > > -      * Lookup child overlay dentry by real name. The dir mutex protec=
ts us
> > > -      * from racing with overlay rename. If the overlay dentry that is=
 above
> > > -      * real has already been moved to a parent that is not under the
> > > -      * connected overlay dir, we return -ECHILD and restart the looku=
p of
> > > -      * connected real path from the top.
> > > +      * @connected is a directory in the overlay and @real is an object
> > > +      * on @layer which is expected to be a child of @connected.
> > > +      * The goal is to return a dentry from the overlay which correspo=
nds
>=20
> As the header comment already says:
> "...return a connected overlay dentry whose real dentry is @real"
>=20
> The wording "corresponds to @real" reduces clarity IMO.

Ok, I'll rephrase.


>=20
> > > +      * to @real.  This is done by looking up the name from @real in
> > > +      * @connected and checking that the result meets expectations.
> > > +      *
> > > +      * Return %-ECHILD if the parent of @real no-longer corresponds to
> > > +      * @connected, and %-ESTALE if the dentry found by lookup doesn't
> > > +      * correspond to @real.
> > >        */
>=20
> I dislike kernel-doc inside code comments.
> I think this is actively discouraged and I haven't found a single example
> of this style in fs code.
>=20
> If you want to keep this format, please lift the comment to function
> header comment - it is anyway a very generic comment that explains the
> function in general.

OK, I'll remove the formatting or move it - not sure which.
I find that with parameter names like "connected" and "real", some sort
of syntax helps.


>=20
> > > -     inode_lock_nested(dir, I_MUTEX_PARENT);
> > > -     err =3D -ECHILD;
> > > -     parent =3D dget_parent(real);
> > > -     if (ovl_dentry_real_at(connected, layer->idx) !=3D parent)
> > > -             goto fail;
> > >
> > > -     /*
> > > -      * We also need to take a snapshot of real dentry name to protect=
 us
> > > -      * from racing with underlying layer rename. In this case, we don=
't
> > > -      * care about returning ESTALE, only from dereferencing a free na=
me
> > > -      * pointer because we hold no lock on the real dentry.
> > > -      */
> > >       take_dentry_name_snapshot(&name, real);
> > > -     /*
> > > -      * No idmap handling here: it's an internal lookup.
> > > -      */
> > > -     this =3D lookup_noperm(&name.name, connected);
> > > +     this =3D lookup_noperm_unlocked(&name.name, connected);
> > >       release_dentry_name_snapshot(&name);
> > > +
> > > +     err =3D -ECHILD;
> > > +     if (ovl_dentry_real_at(connected, layer->idx) !=3D real->d_parent)
> > > +             goto fail;
> > > +
> > >       err =3D PTR_ERR(this);
> > > -     if (IS_ERR(this)) {
> > > +     if (IS_ERR(this))
> > >               goto fail;
> > > -     } else if (!this || !this->d_inode) {
> > > -             dput(this);
> > > -             err =3D -ENOENT;
> > > +
> > > +     err =3D -ENOENT;
> > > +     if (!this || !this->d_inode)
> > >               goto fail;
> > > -     } else if (ovl_dentry_real_at(this, layer->idx) !=3D real) {
> > > -             dput(this);
> > > -             err =3D -ESTALE;
> > > +
> > > +     err =3D -ESTALE;
> > > +     if (ovl_dentry_real_at(this, layer->idx) !=3D real)
> > >               goto fail;
> > > -     }
> > >
> > > -out:
> > > -     dput(parent);
> > > -     inode_unlock(dir);
> > >       return this;
> > >
> > >  fail:
> > >       pr_warn_ratelimited("failed to lookup one by real (%pd2, layer=3D=
%d, connected=3D%pd2, err=3D%i)\n",
> > >                           real, layer->idx, connected, err);
> > > -     this =3D ERR_PTR(err);
> > > -     goto out;
> > > +     if (!IS_ERR(this))
> > > +             dput(this);
> > > +     return ERR_PTR(err);
> > >  }
> > >
> > >  static struct dentry *ovl_lookup_real(struct super_block *sb,
> >
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20
> Otherwise, it looks fine.

Thanks,
NeilBrown


>=20
> Thanks,
> Amir.
>=20


