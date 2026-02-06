Return-Path: <linux-fsdevel+bounces-76510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OChNAnBBhWmA+wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 02:18:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73365F8EA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 02:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE01A3029A45
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 01:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386BB238C29;
	Fri,  6 Feb 2026 01:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="mWJyX35X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GVvrtgtf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B3288AD;
	Fri,  6 Feb 2026 01:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770340713; cv=none; b=igSwjTZmdjIk2ccAO3zsv1HtXVyoQBqi4nH6f1j03IYA+QfJCTzIeYBO2Sr44VUcScoTfVcerQEPrb2Fw2zTn6/pZaHIDTmmzqWXg4uUs6C5iPTdW75D27xIP25gi7PBIyOVSuA8OlN4rQinFohpJNR7PT2E0I8JENOafRJJdiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770340713; c=relaxed/simple;
	bh=1/ZYX3ZsyGelWUdhvffm2+IywukQ79tOmbPRAsuLT/8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=btM5QhhEwZ4onw74KlNw54e2rk+FoKuTe/rAdaiGwUja/p//72yP9AAcRNpn3tWBMeT/pdLh6xV6gzu+JYwqMvi7WU1pSmDNc5Mql9C753wRU969HfoHk0hUSKC5I++xvU1n2ZIZlt0qIwPaoqim0x039eAdH059CT3q6OvTg+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=mWJyX35X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GVvrtgtf; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id AE0291380830;
	Thu,  5 Feb 2026 20:18:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 05 Feb 2026 20:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1770340712; x=1770347912; bh=Zkqi7FUbPlBKBKbLMS4Nd4ZqklSd/cC+47u
	ajjEEgxg=; b=mWJyX35XMkX5bbdkdOcL/QnCS9dYVa50GP3ia+ZNmKwKG1RX+zZ
	xgK3SbKLa+ZEz/WPz/P9cASqwWKp8vzjaDrVmsNZBOQSyoJGm7zjusWiZvNqhtEI
	7mOpzH23tiedYSgihmy9wmuDmrA0OOQvLTiRIGqN8rK16GNl+yiJQinn+xKjI6CL
	BYQja40R97UxiEB1szOTyyQ2iG1r2OQJjyUphKNVEtKqMqcenYQ6QdziItwvXCRi
	s3iy2fGoLmTqFKBpfdI9M+QpOZxyqO2crXc4Q4/Qxg5DIYw9XZf48pBsx/Cn39dJ
	15Z4nDl3SqOtUd7TSh0vIhkYEHk+HuwGalA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770340712; x=
	1770347912; bh=Zkqi7FUbPlBKBKbLMS4Nd4ZqklSd/cC+47uajjEEgxg=; b=G
	VvrtgtfOwb5IwnjMj4sAItg3wm4lEBN16MOkDuioHU+vwsj5exdeiDkgETA8Aga0
	EJJe2FUAhtlt8gKUxYYVl+ver5hZ8/MoJjdBMLAnYYC1Qr/zDvonMHLl8js7CYh3
	3QCM4pq49kr/ZA9p+asoYznxWauTNp7JLZTWGRv467Q95C3l3LYf16luQyCX6a8N
	bZ4b0S5SmZcUTRy3dZUYvflXcqHDmrbROXxdKSYI7vIk9JJOKqwwSX95xbgxm6x2
	Xx9xF3g0798Tm0EYOVE8kTZSPN7tVciFz5ItvFXOYskCIwH9x2YcJyL5cCXX0MNP
	P+js1tYlVdx3DWkB9cbGQ==
X-ME-Sender: <xms:aEGFaeQ4zPh7eEpRMZEiwCvQwvhJLSsBfnkda_QO50aemZnGtDlkkw>
    <xme:aEGFaYCtO2L_AarMPeS4yf37yoPEOfVLN5OQyo27nMXy8UF-UJG6zzdfB7ElxN6Qi
    3wl8X62iJRBjYySl4O8AfvN6IeQWQwStgPn-cNljaPsmci_XA>
X-ME-Received: <xmr:aEGFafbSmmU_FY3J4ORxeS9bBj08jMoN-wCn4jCmHyJGsCTFtXp8-vzJPMJaWXiaR9_Wvh36Lsy6vGGFNxJwqw5gM6ZKH3pFxwSp854W-njm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeikeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:aEGFaZLnaIM4MfbcD78cQknuGA4RK2wEZsxocxtzlL80GyqKah9fLg>
    <xmx:aEGFaQ2V8lZHV1kLR2dB4Cis9hZ00LO6sKAFS9nJo6fHhIDHvgLadQ>
    <xmx:aEGFacZ9d0GqvNczaq7QQd2Ku2Hhgq___1EZTXbVcHaBA05M-Fk_fQ>
    <xmx:aEGFabW4kq8RpMJC3hXznI1fVO4P22i6UFyfIJsClcD0ixe0Ivor4w>
    <xmx:aEGFaVE2Kf6EEu5MkgUKalH7kaW-OZK3of_mfTzbA7SISD7y4rUJqw8g>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 20:18:24 -0500 (EST)
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
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "David Howells" <dhowells@redhat.com>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "John Johansen" <john.johansen@canonical.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 12/13] ovl: remove ovl_lock_rename_workdir()
In-reply-to:
 <CAOQ4uxi3bNYq1b4=qL-JLi19hRwurntfLZXhUMVL003NarBdGg@mail.gmail.com>
References: <20260204050726.177283-1-neilb@ownmail.net>,
 <20260204050726.177283-13-neilb@ownmail.net>,
 <CAOQ4uxi3bNYq1b4=qL-JLi19hRwurntfLZXhUMVL003NarBdGg@mail.gmail.com>
Date: Fri, 06 Feb 2026 12:18:20 +1100
Message-id: <177034070093.16766.8687569968950580318@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76510-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[ownmail.net];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,canonical.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ownmail.net:email,ownmail.net:dkim,brown.name:replyto,brown.name:email,messagingengine.com:dkim,noble.neil.brown.name:mid]
X-Rspamd-Queue-Id: 73365F8EA2
X-Rspamd-Action: no action

On Thu, 05 Feb 2026, Amir Goldstein wrote:
> On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > This function is unused.
> >
>=20
> I am confused.
> What was this "fix" fixing an unused function:
>=20
> e9c70084a64e5 ovl: fail ovl_lock_rename_workdir() if either target is unhas=
hed
>=20
> What am I missing?
>=20

Commit 833d2b3a072f ("Add start_renaming_two_dentries()")

removed the last use of ovl_lock_rename_workdir() earlier, but in a
different branch.

e9c was committed upstream Nov 28th v6.18~7
833 was committed upstream Dec 1st  v6.19-rc1~240

> Otherwise, feel free to add:
>=20
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
NeilBrown


>=20
> Thanks,
> Amir.
>=20


