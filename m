Return-Path: <linux-fsdevel+bounces-63085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F070DBAB80D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 07:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C41717CF94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 05:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50272765C0;
	Tue, 30 Sep 2025 05:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="KM2fdgI9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="magPx4cu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B7A128395
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 05:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759210675; cv=none; b=RA6lU/vi5q8AQUbK1MEW2WGCtLvQ1D5F4Afy6T3n0to8XW5/GKJCLRJJHaWyR+NcDC4E+vPPpFin83MY5udhVxDCNdUaiqAKDzJ6ywCSP/svEHnJbyfrSlFdZeVdHxWRxKF4UPLKtOidg6GCqB6rOu2CD7ggSmwNI3xoOe6jU1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759210675; c=relaxed/simple;
	bh=ozCeWI2pu8BYwiJZdxcYxvBNeV1k7Gv3zAIVv7sEStM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=R8kOLq3jhMoWf6xKyFwW77tv+qQ9XpgLlhiYzEOP+dZfTen4SfzK+DirhIS4uwheuqbsJDqbmU8JTQ2N0XglhVtnqW0s5wouE8mKFTTygpcJYt9E24WYQyqWWEZQBVQjrBjJf1Bt6u+UZkRNMVDIbn2dX3w95vypXgIgm9z9PKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=KM2fdgI9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=magPx4cu; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1589314000B1;
	Tue, 30 Sep 2025 01:37:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 30 Sep 2025 01:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759210673; x=1759297073; bh=gifGwEG6Mo/rS0oqClXvrzxDKBPPkZ8dAZ3
	6t61qF5E=; b=KM2fdgI9wsE7jf8IqDu2GYZqTns3i9ZkzZhJLV7epwhlLfc4F+o
	GTmQl4r8uM+AsMO6ZPG545St35JNhqpOliNy30nG0AyaAQWt09V+f1PWLXanJ854
	kiaaUXvJzTzz3t7S0Z4EF3mBNND7BV0dH4Xs+AjCVj7RNLG8UiBH88JgWx2dP1ka
	obPrZJ/he3Q/vkkeNWKTwVumeu7HOedPxFzNZ04l+LXu8inpPAGlzMY0jzOhhx1i
	ZAwlD/vw5VPE3XdvKyB/URs7mqSe9qFar004yKamxnmVDoiOYXmz4+MkZuue5Mp4
	iNXbZVVwbgt785q32H9lymNowHkr5NiWcrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759210673; x=
	1759297073; bh=gifGwEG6Mo/rS0oqClXvrzxDKBPPkZ8dAZ36t61qF5E=; b=m
	agPx4cuY/F8Kpc2845zHEi0H/iaFez5/NfC22IO+B0kpUbQMn6VhAcHInBaqbqgd
	oe3DmLaQBtHDHLqVyR4sRZnmceZTKNwfGCLtcIJhkHgnfSQO3QfEuRK04Mh0M+4A
	PEP1qmTa9ZqBie8ZbTdfsu5Tt9X7zWiouF+M7gSmyb+4ERr3hJ95cnahhZ4gplDl
	ZBOBVtxRGmWTxPwbDu/ouPC1d0u7bySIP1knGSu2FSpxblgVEymoT8WJuXVVwE1c
	fp1SkbsH031oEAuYaNE+hyo+gLKmo64XETMaEFbXFNlfNEnOFxK2pff4EB/zSjqg
	nDU05KS3fJJIa25s7q0uA==
X-ME-Sender: <xms:sGzbaIcGM0fFPOWh0bS_Lk-OWQ1acCbP3WnnbPEEYoPlQuKZ_YbQlQ>
    <xme:sGzbaFIwO85bZphMUDXAhpvud9RUhFNqBYDYVtd4hV90yDaul0kbEpYd8raF6DNyX
    -7uCqj4pgQkH0nqX00DvauM9W1bs2weJHwugHHc7rA-v6aKHw>
X-ME-Received: <xmr:sGzbaIi1PbKLMgRIK00mh2WGL0Xs1RFi5p5ScddnJ-bEaweRPUyctNLNyMS4G1-5PN-UcPQOI44Qh6VDlfnVB5ibsA6qKhVoPOnjKflUQMyZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdektddtiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:sGzbaDR_jJ03mc0cMJbcc5W07NXKSlgYtn55vzviVkuPAQ1UJzH3nQ>
    <xmx:sGzbaCW9TpbZMcTt-2kZriRHNNlDhGUoSE7TtbNazpW7pwkgHmhjSA>
    <xmx:sGzbaPQ0QcBEFLxNxXDttYU8KQbA_GrAdnia07gL4Fsp6M_91HlbsA>
    <xmx:sGzbaEmY-yGyL7e6muERlOg3pMycQXvkm7XMatj2B1Hz4bbDWuB4tg>
    <xmx:sWzbaHWXSRzOlva3oChjijyP8I4chVJ91FchbHBIJOQJ8wry0th0yOkj>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 01:37:50 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/11] VFS/nfsd/cachefiles/ovl: add start_creating() and
 end_creating()
In-reply-to: <ac7482e19782ad9a0bb928253247c8860ed53ab8.camel@kernel.org>
References: <20250926025015.1747294-1-neilb@ownmail.net>,
 <20250926025015.1747294-4-neilb@ownmail.net>,
 <ac7482e19782ad9a0bb928253247c8860ed53ab8.camel@kernel.org>
Date: Tue, 30 Sep 2025 15:37:48 +1000
Message-id: <175921066852.1696783.17363248489652049263@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 29 Sep 2025, Jeff Layton wrote:
> On Fri, 2025-09-26 at 12:49 +1000, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > start_creating() is similar to simple_start_creating() but is not so
> > simple.
> > It takes a qstr for the name, includes permission checking, and does NOT
> > report an error if the name already exists, returning a positive dentry
> > instead.



> > =20
> > -	if (!d_is_negative(dentry)) {
> > +	while (!d_is_negative(dentry)) {
>=20
> Can you explain why this changed from an if to a while? The existing
> code doesn't seem to ever retry this operation.

I tried to explain that in the commit message:

> Occasionally this change means that the parent lock is held for a
> shorter period of time, for example in cachefiles_commit_tmpfile().
> As this function now unlocks after an unlink and before the following
> lookup, it is possible that the lookup could again find a positive
> dentry, so a while loop is introduced there.

Is there something I could do to make that clearer?

....
> > @@ -1828,12 +1822,6 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *f=
fhp,
> >  	}
> >  out:
> >  	return err !=3D nfs_ok ? err : nfserrno(host_err);
> > -
> > -out_dput:
> > -	dput(dnew);
> > -out_unlock:
> > -	inode_unlock(dirp);
> > -	goto out_drop_write;
> >  }
> >=20
> >=20
>=20
>=20
> I do quite like the nfsd cleanup though!
>=20
>=20

Thanks!

NeilBrown

