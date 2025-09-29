Return-Path: <linux-fsdevel+bounces-62989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F4133BA7C5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 152F77A8BA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2721F4617;
	Mon, 29 Sep 2025 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="r5D3Qdzg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="os5Iltrk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E721C2324
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759110312; cv=none; b=LAr7SWgjZl8OZP0n8Zg2EcqzSysTkzaNBt8k3lONK40wf9yyc7w4li8RcPpM47E0IaMko/lnPzeUQhvJCaH9GsHrAZ/9tCRiQcosEDsHUlhy7Fs9aGsPkxAzEmo2do5WtU2RpIQja6k8EAULGgYtsbXZ9Y7lHcvo8avw6JogQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759110312; c=relaxed/simple;
	bh=ZaKaXqheqK29EBgLNYw81zL15dmCevkUf6kvYd6k/GE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Pzo3Ve586d00btWswTu9tdqKWAPPCQBWtVghdsp8kzOMPqA+SYgCQm6N43M36/KsWlK/nFepDuMlNdb7C71xg9gxgWhXQV2d/lpGa/xsO2iuBnIHmDahhCieFvDMeQqpYS1QgPOC0oUziIIA7VcpKk2NSoYdvBM5ukMILkdYkBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=r5D3Qdzg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=os5Iltrk; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 567C7140007F;
	Sun, 28 Sep 2025 21:45:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sun, 28 Sep 2025 21:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759110309; x=1759196709; bh=lCsJA4G318vtVlApDofwn4/fI+tiKW3b118
	OaVC0z5Q=; b=r5D3QdzghrkCnj8t4BoqEl7ompGdKLzKxEBvJuivPBSRYdj/9aX
	OKaZfRtL1yYjgvUJAFgy0kZlba4mLOfT9wZHKNYYlMH9hLoYLPhYNIMd29Kh3uyk
	WRy86otsh72lBnqeNmkWqGmay5bqY34iV9SWtP7w57iUdc+iI3h+X6Vq8WRjZCM0
	Sp5qxrTEQjxoBEi847Cjnuttgq8bBFFVSP2B+Sc3IGNyDQTnnc6OXMvqhZEyYjpY
	iGdhiE/ZjPrPI62pL6hn3vudUwUP6l+W6A/vd6qqgRJjXO/gRCk3zDPK4WDOvO5v
	aCKs2YFs2rXMydW9w9qU4GPdmNWijY6Vkvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759110309; x=
	1759196709; bh=lCsJA4G318vtVlApDofwn4/fI+tiKW3b118OaVC0z5Q=; b=o
	s5IltrkB2A3p8N56RmgFa5g/eRDhT8Bc/wgc+0XlYJu7aI0ISkI+0SZTRgxSJCIX
	ucdxR03SgMFmXdfGcpuHSwACDfJwMsP5eRsRgHJBxf0vNSyZN56eJ8/SPYsQwuOF
	SB8ixIYdNBbT7rkqhX2lHWIcK1KHdKPdSgpkfoQtdS3SO5vT8pdhnVP3YaBsSFc2
	x9dtxbmTrKuQhPI3eeFMyJj6MVqhGuziMLZ9uHi2LrsKvaaLhXpGNE8cRrox/gNO
	81HgSfLX7fY+4Gx5ISdGy3waO68W4egP46zzHCF5XB15njZdGgQZvSL3BbBk0EOw
	okP6+kMvnNgE9LqTdPpOA==
X-ME-Sender: <xms:pOTZaMoVN4DHjyw8oV-dwbElFDj0H4gfNzhxsQTch5Ih0Go8A0wwGg>
    <xme:pOTZaNnhb-YIQWgRPUxXZgdYFnvBWU3ovm0afKf9PiikJCZBb9RzLiiqVHSLSvFX9
    B66Kwfdc13K2gqCOgFmsmfPyWVfuFOrEQycAcIWzYzf9NHv>
X-ME-Received: <xmr:pOTZaAOWoBKNYYKHLD5W0vvQdoM3bmeFgmb5giFgzsQC5s84CRoit8F9pxULbl4Xzw5Sk0yT3fsWxjN6DkQYhQ7EvHBf-dd_fvZOcHtCCnSy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejieejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthekredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    dvhffgheekkeeitdelfeehhfekvedvgeffhffgudffieevleffheelhfefheevteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:pOTZaJOVuBhcpbJGhW2Kbw3gFfUJ3kG0NWLdezh0jlwDiySRjNntIw>
    <xmx:pOTZaJidwaWXbIRohUwvBnniLQlZ--4AtoDpM053Gn7SQbS-GtQy7A>
    <xmx:pOTZaOsX1i3qfsJ-AXvCxQQRHwGUmvHwIMqH1q55m-Uik4IWbS2SLw>
    <xmx:pOTZaHQl_vtWWX4kSB4MWpN9bURSpZoLeN0S9wmzmHjaK0gr29R6hg>
    <xmx:peTZaICjW_KlcT7HW9g7fuX7LCVUln4dFmpEauPptCJFi0AqiM7Zhx-a>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Sep 2025 21:45:06 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Subject: Re: [PATCH 07/11] VFS: add start_creating_killable() and
 start_removing_killable()
In-reply-to:
 <CAOQ4uxhb-fKixuGz-XS09qktVmm5DwK6oUf8ufV_vqKiA2YPww@mail.gmail.com>
References: <20250926025015.1747294-1-neilb@ownmail.net>,
 <20250926025015.1747294-8-neilb@ownmail.net>,
 <CAOQ4uxhb-fKixuGz-XS09qktVmm5DwK6oUf8ufV_vqKiA2YPww@mail.gmail.com>
Date: Mon, 29 Sep 2025 11:44:58 +1000
Message-id: <175911029880.1696783.10540839124796610279@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 28 Sep 2025, Amir Goldstein wrote:
> On Fri, Sep 26, 2025 at 4:51 AM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > These are similar to start_creating() and start_removing(), but allow a
> > fatal signal to abort waiting for the lock.
> >
> > They are used in btrfs for subvol creation and removal.
> >
> > btrfs_may_create() no longer needs IS_DEADDIR() and
> > start_creating_killable() includes that check.
> 
> TBH, I think there is not much to gain from this removal
> and now the comment
> /* copy of may_create in fs/namei.c() */
> is less accurate, so I would not change btrfs_may_create()

That is reasonable.  I actually wanted to remove btrfs_may_create()
completely but found that some of it was still needed.

I had another look and I think that if an idmap arg is added to
vfs_mkobj(), then using that is the "correct" way to create arbitrary
objects, and that is really what btrfs is doing here.  vfs_mkobj()
incorporates the may_create() test itself.

> 
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> 
> Apart from that and the other comment below, the callers look good
> so you may add:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
NeilBrown

