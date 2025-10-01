Return-Path: <linux-fsdevel+bounces-63138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B44BAEF4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 03:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D59C3B79A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 01:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B79E23373D;
	Wed,  1 Oct 2025 01:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="jzcjRFFW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oFF0Yo7N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4982F2D
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 01:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759282285; cv=none; b=cU2YceE1a8P2tZgxTvjdXy61yb4+a3PcNBi2eFc8Io3pwTGpJTnnThvzA7nTSpslEbp1xn5xE0l6iW6yXXYHCGKEneHrwHee1gYxxpgGL0v/sR7Y+0IuT4cPMlz0O/Sj74q7uSlH7yv9zO91734xZtMSl0w6eBZ2Cp6uNnnf/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759282285; c=relaxed/simple;
	bh=suYVtcwY1dbvMIrQiSSzX0JiPT57O+u3lC2xmigj8Qc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=G05yqgh+oqhickteWm6mgCFK3WWweXwVaAV+VysQ9ztRbcp/EJ7Jj0VviGKpsK/mJyxnE+6ymJysjRYnhOQnLBaQJfHj6dFuxxUGCcO9BH7DU+y0Yd00cjOCAfvrJmN3ACQR6mPZXjTb2fD/PbGFgwoEeg+U3NxeaHEpncYBy/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=jzcjRFFW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oFF0Yo7N; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0D5F6EC00C1;
	Tue, 30 Sep 2025 21:31:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 30 Sep 2025 21:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759282282; x=1759368682; bh=x7PUa6JkUkzl/HVzOfP7AJfxnSM9v4ViH5r
	RZf0sAYw=; b=jzcjRFFWc6WXPr5RBK57zBwZg0nMDzksWYu+hRfI2ku8FoEtSBg
	fxIZOJPUAWuhQm53wLl5wpRftkyLJFalFwwQ24JBDwVj2VAp08JyxqMY7lGxJ9bx
	ypGjqcIbXC33Ef2sfEiRO07FFLdaI4lOVi7pS79HexBD/+pveMXG2WSNDnz4lHgh
	vRZkhc9gJY63hz7r9xJe95MzYu7nj0EYysqwpqg0NiER3Zc+QBOgTxTQNV7ZKwvb
	O3vMywbNj3vAn1UMUuc/gSXc10mz+AnOrz+u3eVotQjKM4IZYfI2nZugpYp/EEBj
	7U4ykGGT1Wd3dsHeUOjdtc9xiLMwziew3Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759282282; x=
	1759368682; bh=x7PUa6JkUkzl/HVzOfP7AJfxnSM9v4ViH5rRZf0sAYw=; b=o
	FF0Yo7N3Zh78eGsQxpMBEhjZ+9cgU3EWg6uYdjmGk1dmAoGYv3CvBhuU8lHeD+1j
	0GgFdlUIAmKOmo2isc/xyPxhnSKm8JgXDZoTzj8FC6Thcidl3xjR1LwRY/NSnAWw
	RLe+AMY+2ac0A3XlcyMWsHAPTg/w3VfLOzNi2eVKFiVQEXEzZNcIm5jjvEUk8hMB
	/CDlXAYBC/TWApeKYMZNsT0Fd4AGE6TngF41nsIzxdPLc8uo7zNYIgHOMw3PkjrI
	CDLqOo4getD3YUR08zB1bzBGocyyuC28chiHv37cfX6KeOWI5Zw8Fak0w/4X0Dng
	XDvofotu3nsJIXxXUYe2w==
X-ME-Sender: <xms:aYTcaMFvZS7q9Phxur_79C6UnnIM8KL4nKNFmRMi7uZ-3iaOxB4s5w>
    <xme:aYTcaAQatNZav2mHmX0zQpi30SmvruslZgbjUuXPgNEk5b2YTYR5pSd7ujG5s9-Gi
    3QlApUF8pMV44cgF-Ku0oyWBe_y0Op2kNWdsVeyolKb_Pffiw>
X-ME-Received: <xmr:aYTcaFIix7vUjxaVOXitUakbNKY0z0RKbXbJ8NodoNuifhyIwB9xvUwcrin43zV9iEfbq0RZ0ydLE9laqR2v0prDif1LR9CZREHmDqmABjjV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:aYTcaDZNBZvREzX8c0jl69BVZuFXMQ2EvYwonq4ADj31255-3OcMDA>
    <xmx:aYTcaP8_rLGY3hyNorhWX_9lvy6-MY34DTlN5L4FHX_LUgm0A_osAw>
    <xmx:aYTcaMbHmRdFQXRQSBCHbC1wybSF4dJTQQnx-ZJqfJp2I3Ep_CKlkg>
    <xmx:aYTcaLPHMlwocO_5CtOYdK55Is0OWKkRPVU4lqp6DmYOCJINBANKdQ>
    <xmx:aoTcaB_hFGIzmaFciT4MebFC0eUI7Z9gPwNssoyQU_961fhzHZhaUJHC>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 21:31:19 -0400 (EDT)
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
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/11] ecryptfs: use new start_creaing/start_removing APIs
In-reply-to:
 <CAOQ4uxiovuo2S_22wkxoFjZr3MtgeiT4=9+e2MYs8xnTypsiWQ@mail.gmail.com>
References: <20250926025015.1747294-1-neilb@ownmail.net>,
 <20250926025015.1747294-12-neilb@ownmail.net>,
 <CAOQ4uxjkJ4dvOkHHgSJV61ZGdCYOxc8JJ+C0EOZAG49XWKN3Pw@mail.gmail.com>,
 <175912358745.1696783.16384196748395150231@noble.neil.brown.name>,
 <CAOQ4uxiovuo2S_22wkxoFjZr3MtgeiT4=9+e2MYs8xnTypsiWQ@mail.gmail.com>
Date: Wed, 01 Oct 2025 11:31:11 +1000
Message-id: <175928227148.1696783.14650052455220025233@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 29 Sep 2025, Amir Goldstein wrote:
> On Mon, Sep 29, 2025 at 7:26=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > On Sun, 28 Sep 2025, Amir Goldstein wrote:
> > > On Fri, Sep 26, 2025 at 4:51=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
> > > >
> > > > From: NeilBrown <neil@brown.name>
> > > >
> > > > This requires the addition of start_creating_dentry().
> > > >
> > ...
> > > > @@ -186,10 +190,12 @@ ecryptfs_do_create(struct inode *directory_inod=
e,
> > > >         struct inode *lower_dir;
> > > >         struct inode *inode;
> > > >
> > > > -       rc =3D lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir=
);
> > > > -       if (!rc)
> > > > -               rc =3D vfs_create(&nop_mnt_idmap, lower_dir,
> > > > -                               lower_dentry, mode, true);
> > > > +       lower_dentry =3D ecryptfs_start_creating_dentry(ecryptfs_dent=
ry);
> > > > +       if (IS_ERR(lower_dentry))
> > > > +               return ERR_CAST(lower_dentry);
> > > > +       lower_dir =3D lower_dentry->d_parent->d_inode;
> > > > +       rc =3D vfs_create(&nop_mnt_idmap, lower_dir,
> > > > +                       lower_dentry, mode, true);
> > > >         if (rc) {
> > > >                 printk(KERN_ERR "%s: Failure to create dentry in lowe=
r fs; "
> > > >                        "rc =3D [%d]\n", __func__, rc);
> > > > @@ -205,7 +211,7 @@ ecryptfs_do_create(struct inode *directory_inode,
> > > >         fsstack_copy_attr_times(directory_inode, lower_dir);
> > > >         fsstack_copy_inode_size(directory_inode, lower_dir);
> > > >  out_lock:
> > > > -       inode_unlock(lower_dir);
> > > > +       end_creating(lower_dentry, NULL);
> > >
> > > These calls were surprising to me.
> > > I did not recall any documentation that @parent could be NULL
> > > when calling end_creating(). In fact, the documentation specifically
> > > says that it should be the parent used for start_creating().
> >
> > I've updated the documentation for end_creating() say that the parent is
> > not needed when vfs_mkdir() wasn't used.
> >
>=20
> This was not what I was aiming for at all.
> This is exactly the bad interface that end_dirop_mkdir() was.

There is a reason for that.  vfs_mkdir() has a bad interface and somehow
we need to accommodate it.  Once we fix vfs_mkdir() the second arg to
end_creating() goes away.  Until then we need it, but don't always use
it.


> A well designed scope interface like strart_XXX/end_XXX should not depend
> on what happened between the
> start_XXX to end_XXX.
> If start_XXX succeeds you MUST call end_XXX

And that is what we do.

> end of story, no ifs and buts and conditional arguments only
> if mkdir was called. This is bad IMO.

The practical reality is that the second argument is ignored if
vfs_mkdir() wasn't used.  This isn't a function of the design of
end_creating(), it is a function of the design of vfs_mkdir().

>=20
>=20
>=20
> > >
> > > So either introduce end_creating_dentry(), which makes it clear
> > > that it does not take an ERR_PTR child,
> >
> > it would be end_creating_not_mkdir() :-)
> >
>=20
> OK, but that is not the emphasis.
> The emphasis is that dentry is not PTR_ERR,
> because in all the callers where you pass NULL parent
> the error case is checked beforehand.

No, it all other cases there is there cannot be an error.  Only
vfs_mkdir() returns a dentry that might be IS_ERR(), and consume the
dentry that was passed in.  All other vfs_foo() return an integer error
and don't consume the dentry.

"vfs_mkdir() was used" and "dentry migth be IS_ERR()" are logically
equivalent statements.

>=20
> static inline void end_creating_dentry(struct dentry *child)
> {
>         if (!(WARN_ON(IS_ERR(child))
>                 end_dirop(child);
> }
>=20
> If someone uses end_creating_dentry() after failed mkdir
> the assertion would trigger.

But you NEED end_creating() after a failed vfs_mkdir().  You still need
to unlock the parent.

"end_creating_dentry()" look like it is a pair to
"start_creating_dentry()" but the two are quite unrelated.


>=20
> > > Or add WARN_ON to end_creating() in case it is called with NULL
> > > parent and an ERR_PTR child to avoid dereferencing parent->d_inode
> > > in that case.
> >
> > I don't think a WARN_ON is particularly useful immediately before a
> > NULL-pointer dereference.
>=20
> Of course I did not mean WARN_ON and contoinue to dereference NULL
> that's never the correct use of WARN_ON.
>=20
> static inline void end_creating(struct dentry *child, struct dentry *parent)
> {
>         if (!IS_ERR(child)) {
>                 end_dirop(child);
>         } else if (!WARN_ON(!parent)) {
>                 /* The parent is still locked despite the error from
>                  * vfs_mkdir() - must unlock it.
>                  */
>                inode_unlock(parent->d_inode);
>         }
> }
>=20
> static inline void end_creating_dentry(struct dentry *child)
> {
>         end_creating(child, NULL);
> }
>=20
> To me, this:
>=20
>        end_creating_dentry(lower_dentry);
>=20
> Is more clear than this:
>=20
>        end_creating(lower_dentry, NULL);
>=20
> But my main concern was about adding the assertion
> and documenting that @parent may be NULL as long as
> it can be deduced from @child->d_parent (right?).

If it really bothers you to pass NULL I'll change it to pass the actual
parent.
   end_creating(lower_dentry, lower_dentry->d_parent);

Would you find that less bothersome?

Thanks,
NeilBrown

>=20
> Thanks,
> Amir.
>=20


