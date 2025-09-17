Return-Path: <linux-fsdevel+bounces-61884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C5DB7D83F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1E51718EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 07:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C145C2FFF8D;
	Wed, 17 Sep 2025 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="WHn1EZQB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lSg9XMDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4009D2F291B;
	Wed, 17 Sep 2025 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094622; cv=none; b=TQ7L/kjiUhaT7Siqvm+xt+olmJdATBZ9MLx8xCdc14EA+kS3aVVFtRdV2wSTfK/j/la04GX1qFkYSB2vk65p3WeddpPxB8xAFf5ow5JjAWglLLyecknNp2gCZBV1ELmfSvA/wme2U01V8U/UygejbY1xeDyuAbadx941Iyj5Az0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094622; c=relaxed/simple;
	bh=/a4SbsVzqO1jNQ82naGvBj0LOt0lvz/CD/bjLWnkpF8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ACvou4k/kgU3Lk9Z7mld0S+vxsQZI3SoEln2dgd1PIHYNqKhcMlvxG0D9wldT1QAEKfhXH4gjGXIASdznDu3eggsphHjf0LuEcj7h4VlBdTiGi+DZZlg2FmemrG3GZT8AVM+flkvfTp2Wz10fP4nnytzebxDwXqXvCQewo4P5LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=WHn1EZQB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lSg9XMDV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B14A14000EC;
	Wed, 17 Sep 2025 03:36:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 17 Sep 2025 03:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758094619; x=1758181019; bh=9WYxe3ScZzspcMiOBOj1l0vTDzVUROKuguU
	p/Md8T9M=; b=WHn1EZQBN4Gv8PcS2306IUOkEI1G1yYPUg7vzrYtwkZrbet25Ey
	sEB8x11fTj5+ntxmrD4fyTkLgZr6uot9GEAxtqB2sJBmxOZJmPQrQcOza0SoXej+
	tAJ/QvNnRzyjtOlfMAeAhpRpH/qsAAk/kZfPqfD6PTkHQRlIm2ipWhzMZ125jWds
	rLfOMOWLwJMVm6ixM7AepUK5s9ukvTfLA9+9LJgl4qwq8/JExclZQ58ESoQ0LImo
	x37b6a71zQmlA9cdUdO5Gv+hjnaKfMcq415YHAWg4f7BLKHdG5fARwuShXLJ5WxT
	ncJFJUmTyuHMPJrslt8g9BXguQTaPP76O6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758094619; x=
	1758181019; bh=9WYxe3ScZzspcMiOBOj1l0vTDzVUROKuguUp/Md8T9M=; b=l
	Sg9XMDVHk2tLClpo2YJlnhtwKGs7OGu9n5WowubzjEA9Sjbdgor0chcqUTFOtz3k
	aSp53BWVB/mxbj1l+FjRXXkOKr4CaWh0zj50mVb7lc0duiixHp7B5eyqykkOvBtN
	pTNR+Ir7dufPOUxkd1EgA+FlQNAVTyQOmqbqQdjpNn55qbZ5XrYirOh34czpAR/7
	uE1XsgVOgwhLAcQYVXwKnCDZpG/IKYjPTjsWVWcDgQgs/mNzuJplB2oM6Tm5DLo+
	jxJdtd6mf1wNpfTXzCZ9HGPWW331IkgmW4z+6zGQUonczDkYyBwsF/gx/EaqiDpr
	9ZfuhruPAXXM+1JuDt+OQ==
X-ME-Sender: <xms:GmXKaGrn6A9GEYKPybXPjIttYfPGAmSPtCJeBWoHTN5TM6Ztz26ZwA>
    <xme:GmXKaAX9cbtMiAMmpBduVxzepulWpd0jkIwFTCR0qPdkn_qj4OLkFNQFaK7HXCKk4
    9st8K3xNLolwg>
X-ME-Received: <xmr:GmXKaHo67P-p9du6Ge_80bZcWEsum5qDMYb7pFR4tPIdfORm13RdbPk4jlaE-o5v0T-e_cEXSGZozlwHVfwvH1Tc99i6xlKdpeLXMgfqRQZf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegvdekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepthhrohhnughmhieskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghn
    nhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:GmXKaPBZtEQRrrWbhPB8LFq12WQKF_QkHpHa8C2-MHw-SOgnOpaK2Q>
    <xmx:GmXKaLhi2isTeWPH9w0G2HbJaQH0x97QHLeV6gfN6RsDo8npKKRdOA>
    <xmx:GmXKaFbBDQbPXnZy_qtPCPi45Ha_DtWQcPX4mhGK9QMEM66Uiltj5g>
    <xmx:GmXKaEmmSIHUpwNa9339RrmDgHRMOh0BQ3NsJxBI9pku7PTP7WFo8Q>
    <xmx:G2XKaFKcsaIm6yCJzQ3hRyHQv2NU0I16xclk5R5aAWhTxwtdwPI6xewm>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 03:36:56 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>, "Amir Goldstein" <amir73il@gmail.com>,
 "Jan Kara" <jack@suse.cz>
Subject: Re: [PATCH 2/2] VFS: don't call ->atomic_open on cached negative
 without O_CREAT
In-reply-to: <20250917042348.GS39973@ZenIV>
References: <20250915031134.2671907-1-neilb@ownmail.net>,
 <20250915031134.2671907-3-neilb@ownmail.net>, <20250917042348.GS39973@ZenIV>
Date: Wed, 17 Sep 2025 17:36:54 +1000
Message-id: <175809461430.1696783.8945122470534240428@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 17 Sep 2025, Al Viro wrote:
> On Mon, Sep 15, 2025 at 01:01:08PM +1000, NeilBrown wrote:
>=20
> > All filesystems with ->atomic_open() currently handle the case of a
> > negative dentry without O_CREAT either by returning -ENOENT or by
> > calling finish_no_open(), either with NULL or with the negative dentry.
>=20
> Wait a sec...  Just who is passing finish_no_open() a negative dentry?
> Any such is very likely to be a bug...

You're right, that never happens.  It always NULL being passed or
-ENOENT being returned in the cases I was considering.

>=20
> > All of these have the same effect.
> >=20
> > For filesystems without ->atomic_open(), lookup_open() will, in this
> > case, also call finish_no_open().
> >=20
> > So this patch removes the burden from filesystems by calling
> > finish_no_open() early on a negative cached dentry when O_CREAT isn't
> > requested.
>=20
> Re "removing the burden" - it still can be called with negative cached with=
out
> O_CREAT.

You, but it will also have exclusive access to the dentry - either an
exclusive lock on the parent, or DCACHE_PAR_LOOKUP.  That is the
important outcome that I wanted to achieve.

>=20
> O_CREAT in open(2) arguments might not survive to the call of atomic_open()=
 -
> in case when you don't have write permissions on parent.  In that case
> we strip O_CREAT and call into atomic_open() (if the method is there).
> In that case -ENOENT from atomic_open() is translated into -EACCES or -EROF=
S:
>                 dentry =3D atomic_open(nd, dentry, file, open_flag, mode);
> 		if (unlikely(create_error) && dentry =3D=3D ERR_PTR(-ENOENT))
> 			dentry =3D ERR_PTR(create_error);
> 		return dentry;
> In case when no ->atomic_open() is there the same logics is
>         if (unlikely(create_error) && !dentry->d_inode) {
> 		error =3D create_error;
> 		goto out_dput;
> 	}
> in the very end of lookup_open().  The point is, you might have had a call
> of ->d_revalidate() with LOOKUP_CREATE|LOOKUP_OPEN and then have the damn
> thing passed to ->atomic_open() with no O_CREAT in flags.
>=20

That inconsistency could be confusing for the filesystem.  It would be
hard to make it consistent through.

Thanks,
NeilBrown


