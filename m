Return-Path: <linux-fsdevel+bounces-60470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF93B4827E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 04:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776513A3B7B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 02:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA6D1DE3CB;
	Mon,  8 Sep 2025 02:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="uRTxh72n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YSpY+Fzc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2401AE56A
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 02:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757297269; cv=none; b=LnnjBSIJy4VF0wVJu1O8oYODb5lJL3WLfwwj+cSBBN4ySV/bujXFDRyv0KNHZUkcANVbPkqSaPgPEngd/UuhBBbLjjiualRGY+iNgW08gSliVSVakT4Hb+x+X9ReJv1oFdjMa39mdQS9WumhzBsYwcIYYzSkEEFY29YsNp1pGE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757297269; c=relaxed/simple;
	bh=/zsRWF77oEP/4iqLWnghIM7S2E5nITsPqTPp0eXIHY0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tFTr2Bz/ew6TI2Oor98RzOZilJ1//Sg76qpvbfq3QGkxZRDrEgcFp5jpkxOCbUwltPsW5nm7Fikk+pKwW44RBgbIfFbeoUonW+8qH1YT9yZP9jbWcBfVbDdOIwQYwslLc/ViyLWSTgFGWk0xMDmFftaA73hwxYNP7eSiMO5MmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=uRTxh72n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YSpY+Fzc; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A1DD140003D;
	Sun,  7 Sep 2025 22:07:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sun, 07 Sep 2025 22:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757297266;
	 x=1757383666; bh=7LK1n303WC2CiyRXvXOfIzI2TyEk6TRcjhKR6IkCtmc=; b=
	uRTxh72nZYR4NgfV2//7x1lPbXGe/GHsnUS5LC3NZZ1iBh9yaSIWAqkLwlkpbuxK
	M71LVnzrk6r/b+kcYIntXUXlPrdLTRDVS5eOUqN6TQPi8DZqs5DrbueUBsSTNn7d
	Ih62OSkHOSkjHBNR1RBRi2V+VO8I8uQK/PMHh/pUzXTblvXrkrJeFcpHV+/g3FDF
	1KyqndmtukST4nxYwIXnoP9HL758pYJ4/3dEBAP5x9flMpUAlArbrUSU4Z8u/tdS
	OrlKUQxHkDC2wfGN7p9P9SKIsl9PcuDhuU0yvwuq4LqZ0DQ/cn2mKzP2CFRgnen3
	k4++1efRJSSkTPDN0FJjYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757297266; x=
	1757383666; bh=7LK1n303WC2CiyRXvXOfIzI2TyEk6TRcjhKR6IkCtmc=; b=Y
	SpY+FzcUT78ST6OSIiOmxOS3s3TFoaZsPvzbwOhYbP0gZVHGenjdTbsJ3tZh/42m
	xrnKV7CQQd4jWcpy5fay/6H+AZqICqLzbPDMaUKfGLxo7ue5Ic7ARqxpXae+90AN
	9U4FVJw8MoIlXycTQjJxZRGoU7hMRs7/vMVr3mmpoYABmEa8Cad+XrqTVqVI3tAI
	9zdQLPVKUcd54avSP/nDJUBgrZ1EUC1ipu7joORbOAAN5sfu/XvDlj8kF2YfLvvy
	eCCHl/MZkccBqOC/MCP9TR/G6mODkzr6U8j9hzQfTCu43BzFJaPy3KLXwmECDAaa
	se8+0OizZT3GXeGEVS8Vw==
X-ME-Sender: <xms:cTq-aGPuvN5kOOoAd7axpjXHPNQor4iqQWH_cv1RiThLhv5sndsl6Q>
    <xme:cTq-aMXo6j8gtfMe6ZE7iX9pMBs8Zmg9xtTeETCPt0E2jAoovDsF4MWyw_s82AucE
    3_8WaEqywFl9A>
X-ME-Received: <xmr:cTq-aC0ekK4JNSZxnINjwwR0dHXY1WhFrgVM7u3izox7_ZkDLfp12yJgkoXRKFmaVnva8hm4vVn2oSTrxACRzYKByRMA6ZjwHaTGQ75E97dO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffksehtqhertddttdejnecuhfhrohhmpedfpfgvihhluehr
    ohifnhdfuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epueffkeetfeffieevfefgledukeelgfelveejteeutdduffduuedujeetteehffefnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehjrg
    gtkhesshhushgvrdgtiidprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:cTq-aCojOZGRdJ_9Z_xt3-zfIhGpPCOvVkkvdxxG5eCIdCMXQPTCxw>
    <xmx:cTq-aBUjU5C8gsEYTaC4G_lzQ0RgRfHjwTo51FRtGE496cd0urJ26g>
    <xmx:cTq-aFai-_mJnDrCzA20azcSTB7kvsJxYSUMdQbgF_SvXrR0tm47qg>
    <xmx:cTq-aGfCkhFIXrW8wgcYuvTVBZSF8O4BUK1rX_iUHbytx2SVYjWU5Q>
    <xmx:cjq-aN2BZE1QRIkTHs531qyjk4sgO_MizarM3oFkZ9cuLNUKkyzGogqk>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 22:07:43 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, "Miklos Szeredi" <miklos@szeredi.hu>
Subject: Re: [PATCH 2/6] VFS/ovl: add lookup_one_positive_killable()
In-reply-to:
 <CAOQ4uxhnvYeJiZ9Bd73kwu3y4VCeeJCvNN1K+GExxF4koA+bxA@mail.gmail.com>
References:
 <>, <CAOQ4uxhnvYeJiZ9Bd73kwu3y4VCeeJCvNN1K+GExxF4koA+bxA@mail.gmail.com>
Date: Mon, 08 Sep 2025 12:07:37 +1000
Message-id: <175729725709.2850467.826431423203156062@noble.neil.brown.name>

On Sat, 06 Sep 2025, Amir Goldstein wrote:
> On Sat, Sep 6, 2025 at 7:00=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > ovl wants a lookup which won't block on a fatal signal.
> > It currently uses down_write_killable() and then repeated
> > calls to lookup_one()
> >
> > The lock may not be needed if the name is already in the dcache and it
> > aid proposed future changes if the locking is kept internal to namei.c
> >
> > So this patch adds lookup_one_positive_killable() which is like
> > lookup_one_positive() but will abort in the face of a fatal signal.
> > overlayfs is changed to use this.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
>=20
> I think the commit should mention that this changes from
> inode_lock_killable() to inode_lock_shared_killable() on the
> underlying dir inode which is a good thing for this scope.
>=20
> BTW I was reading the git history that led to down_write_killable()
> in this code and I had noticed that commit 3e32715496707
> ("vfs: get rid of old '->iterate' directory operation") has made
> the ovl directory iteration non-killable when promoting the read
> lock on the ovl directory to write lock.

hmmmm....

So the reason that this uses a killable lock is simply because it used
to happen under readdir and readdir uses a killable lock.  Is that
right?

So there is no particularly reason that "killable" is important here?
So I could simply change it to use lookup_one_positive() and you
wouldn't mind?

I'd actually like to make all directory/dentry locking killable - I
don't think there is any downside.  But I don't want to try pushing that
until my current exercise is finished.

>=20
> In any case, you may add:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks!

NeilBrown

>=20
> > ---
> >  fs/namei.c             | 54 ++++++++++++++++++++++++++++++++++++++++++
> >  fs/overlayfs/readdir.c | 28 +++++++++++-----------
> >  include/linux/namei.h  |  3 +++
> >  3 files changed, 71 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index cd43ff89fbaa..b1bc298b9d7c 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1827,6 +1827,19 @@ static struct dentry *lookup_slow(const struct qst=
r *name,
> >         return res;
> >  }
> >
> > +static struct dentry *lookup_slow_killable(const struct qstr *name,
> > +                                          struct dentry *dir,
> > +                                          unsigned int flags)
> > +{
> > +       struct inode *inode =3D dir->d_inode;
> > +       struct dentry *res;
> > +       if (inode_lock_shared_killable(inode))
> > +               return ERR_PTR(-EINTR);
> > +       res =3D __lookup_slow(name, dir, flags);
> > +       inode_unlock_shared(inode);
> > +       return res;
> > +}
> > +
> >  static inline int may_lookup(struct mnt_idmap *idmap,
> >                              struct nameidata *restrict nd)
> >  {
> > @@ -3010,6 +3023,47 @@ struct dentry *lookup_one_unlocked(struct mnt_idma=
p *idmap, struct qstr *name,
> >  }
> >  EXPORT_SYMBOL(lookup_one_unlocked);
> >
> > +/**
> > + * lookup_one_positive_killable - lookup single pathname component
> > + * @idmap:     idmap of the mount the lookup is performed from
> > + * @name:      qstr olding pathname component to lookup
> > + * @base:      base directory to lookup from
> > + *
> > + * This helper will yield ERR_PTR(-ENOENT) on negatives. The helper retu=
rns
> > + * known positive or ERR_PTR(). This is what most of the users want.
> > + *
> > + * Note that pinned negative with unlocked parent _can_ become positive =
at any
> > + * time, so callers of lookup_one_unlocked() need to be very careful; pi=
nned
> > + * positives have >d_inode stable, so this one avoids such problems.
> > + *
> > + * This can be used for in-kernel filesystem clients such as file server=
s.
> > + *
> > + * Ut should be called without the parent i_rwsem held, and will take
>=20
> Typo: ^^ It
>=20
> Thanks,
> Amir.
>=20


