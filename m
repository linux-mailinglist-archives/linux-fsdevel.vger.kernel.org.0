Return-Path: <linux-fsdevel+bounces-62990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C33BA7FD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 07:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B404163BE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 05:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55E628152B;
	Mon, 29 Sep 2025 05:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="iyItz6to";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ApvXz//n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F01F428F
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 05:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759123600; cv=none; b=Sv4T39q3l/exQkwc+ZdX5kNeirx49niA8rrc3e60527BFXExNz6WIlbIq6QJAKwV1ZF2dLxdnfjMeR8ATnKs0EWGqNkVf4+lwRX7K195vxW0FN0eSYDwfjqlF9hhS2p2T/ynC4MzwdTDyHDbxkzcsojIhs+5J0+17DVplF2KY68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759123600; c=relaxed/simple;
	bh=9E9tsWmj1hn/ltRRNgg2l5FFveve3kddM6p030+Sp0Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=WJTtCbacCQbotyf4C15raPoyERN8rLEsveZ4p+j6QXSesNWBVSy6Pi0UfJHQu+KQZwuCXCTtI3p9YeJaHROyUG398i8ZRHY7uHuKNU13Z1WYxBe/Ld78NqSL9jqcjipTWx3GCdCcmzQwVfv+b6SSRE9cAAhhMAXbrAaZmmFvwX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=iyItz6to; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ApvXz//n; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4BBE01400188;
	Mon, 29 Sep 2025 01:26:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 29 Sep 2025 01:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759123597; x=1759209997; bh=alFrK5MaZuJdGXk9NECeV8tiLKJ0lAgsCVA
	qJz9dVhs=; b=iyItz6tolNPjouWvOHmuK/ARXew4445X1igl0iBPPlxC5sNgsos
	wit92f6jCqRo/PwRWwlIu4mn1sAL43ZP1Xg8YNesQtgJrQmbTKd6kxxc7+rjD8aO
	gjLRKIPN8ZADhHKi6Rmaa5GWkhcFFnm9WBkkEHKtUQuGn+cOmlsD0zN73LgIayAB
	7prJrh7IHvDSN88YiHq1KWfWi0NuLI9KB42EUgdyaFfMvSIWjtCDjM6FpiNGmChn
	KoW5MnUEAjQvFRFStfN3ox2Yr0hllQK+wEgqxz2kfHZlU+687ANEyMkMjfajSQIu
	omhiZfNFPWozkWngDbNskATd15v21yRzyoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759123597; x=
	1759209997; bh=alFrK5MaZuJdGXk9NECeV8tiLKJ0lAgsCVAqJz9dVhs=; b=A
	pvXz//nTriyt+pJIhlhm/D6PE15s44SKcCeWVqbCM/bn57dr+DizK/WZ9G8IxkcS
	1zfwmyzO190rJnn5c6DfzV3wmGLJZBXHJlZzR/VItqa+MBJcVL5LLsWRabrGLwRO
	I6fFpG1KEdJ1DCIlYBtxLFRQb3scQ7XrBiaDzA89jkzXQ2BTkFUb12mS1+nr4xeD
	5darJcLOGdck2437QDg6rA8aljOjFTbTr4kvMAfN1T8/jMRvR9ASDdAVdFbM2ArF
	GZHKULhkPT0RdbrwB4ps+jYTq3xKkrf3/Z0TPke2sFVt7wkSwlHvOX+Th7XV8CSO
	lGuA7CnJV/kUC4DEPma9Q==
X-ME-Sender: <xms:jBjaaHklgYgqJjuddgXTDmZUk0uaKzHpc67fdQLpwMy6Jg4gthW_0w>
    <xme:jBjaaCMhPK61qR48JjT6bXpNIWqMBfZqEgpke2K8VuopQ24hb1SxoeVY1op_-N_b7
    uR1crm-I6560uoElrnAyRNA29_xGroEKNOfhVEGDLr20CnKcg>
X-ME-Received: <xmr:jBjaaDOScRqkZs0eC2QWn0DWXMGxOHvopfOj4Iqm6FlD_t-UjmlGS7jmsL8C2V7prGwCNRy6cUwt2f-ldACrt8n6ui0tnyOsA9iZsviUeWA3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejjeduiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:jBjaaLjt_DeE3_OzZgLYrIY10RrCW9CkKVIc21oW56WLtXq-X9tfKg>
    <xmx:jBjaaIv1k1itoedYfsON-eCYq_1NR7zbZE7maxHjvCpeWqqBhf11TQ>
    <xmx:jBjaaJRCc9NBufPL2vDM73NYCL7kjjDP2GAbHiVxOOkTIBR07xE_-g>
    <xmx:jBjaaM2woaCObgUPyicmZ6aGoovKklG35CK3HGobXAtroNcieZOJ7Q>
    <xmx:jRjaaIevWzX1gJ7-l5bfCZKGJeuglDrNPt3g9ls--boHO2vH5ZovH3oI>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 01:26:34 -0400 (EDT)
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
 <CAOQ4uxjkJ4dvOkHHgSJV61ZGdCYOxc8JJ+C0EOZAG49XWKN3Pw@mail.gmail.com>
References: <20250926025015.1747294-1-neilb@ownmail.net>,
 <20250926025015.1747294-12-neilb@ownmail.net>,
 <CAOQ4uxjkJ4dvOkHHgSJV61ZGdCYOxc8JJ+C0EOZAG49XWKN3Pw@mail.gmail.com>
Date: Mon, 29 Sep 2025 15:26:27 +1000
Message-id: <175912358745.1696783.16384196748395150231@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 28 Sep 2025, Amir Goldstein wrote:
> On Fri, Sep 26, 2025 at 4:51=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > This requires the addition of start_creating_dentry().
> >
...
> > @@ -186,10 +190,12 @@ ecryptfs_do_create(struct inode *directory_inode,
> >         struct inode *lower_dir;
> >         struct inode *inode;
> >
> > -       rc =3D lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
> > -       if (!rc)
> > -               rc =3D vfs_create(&nop_mnt_idmap, lower_dir,
> > -                               lower_dentry, mode, true);
> > +       lower_dentry =3D ecryptfs_start_creating_dentry(ecryptfs_dentry);
> > +       if (IS_ERR(lower_dentry))
> > +               return ERR_CAST(lower_dentry);
> > +       lower_dir =3D lower_dentry->d_parent->d_inode;
> > +       rc =3D vfs_create(&nop_mnt_idmap, lower_dir,
> > +                       lower_dentry, mode, true);
> >         if (rc) {
> >                 printk(KERN_ERR "%s: Failure to create dentry in lower fs=
; "
> >                        "rc =3D [%d]\n", __func__, rc);
> > @@ -205,7 +211,7 @@ ecryptfs_do_create(struct inode *directory_inode,
> >         fsstack_copy_attr_times(directory_inode, lower_dir);
> >         fsstack_copy_inode_size(directory_inode, lower_dir);
> >  out_lock:
> > -       inode_unlock(lower_dir);
> > +       end_creating(lower_dentry, NULL);
>=20
> These calls were surprising to me.
> I did not recall any documentation that @parent could be NULL
> when calling end_creating(). In fact, the documentation specifically
> says that it should be the parent used for start_creating().

I've updated the documentation for end_creating() say that the parent is
not needed when vfs_mkdir() wasn't used.

>=20
> So either introduce end_creating_dentry(), which makes it clear
> that it does not take an ERR_PTR child,

it would be end_creating_not_mkdir() :-)

> Or add WARN_ON to end_creating() in case it is called with NULL
> parent and an ERR_PTR child to avoid dereferencing parent->d_inode
> in that case.

I don't think a WARN_ON is particularly useful immediately before a
NULL-pointer dereference.

Thanks for highlighting this - clarification of the documentation is
needed.

NeilBrown


