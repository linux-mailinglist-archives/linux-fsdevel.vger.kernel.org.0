Return-Path: <linux-fsdevel+bounces-65021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85430BF9D69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 05:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F206A3AA81C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 03:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06092C3259;
	Wed, 22 Oct 2025 03:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="tW3mw/sD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I2WH2BA3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D92C2345
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 03:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761104143; cv=none; b=gZ+vsqEcNNQJp1H4XExRei9H2l2BQrHMFomwjPGtSq8GATyvPxdOWzSlZTTVILvIGWjbuqPLYSF6GfJXyFy1rGos8qu5/7y2v2Hyy/1gMLIsKbC1+HAfwGSXhGLe/PKdzSKMUjnyHMynpgp5ZXvmytFdD+/rOa0eHV7iaXofiyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761104143; c=relaxed/simple;
	bh=BquYXIbqxnCWdH+0tRon3rUfUp9sWh561OHq21wHJ+M=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HagIjhsFoz2r0L+qwIdCIvJCfakYBe9jFTdFsomcM/yI9BnvDlNFF4lSOBlNrtRnxRznoomlZ71toHPlVxYTfUxZqRYvtquXEVY/UYrGG6v2M5YjRj4hZCMHff1uoasd78e0Oqu/Y6u2pW4AhQwTljdOiwHkJDoDOBFejJ4zvJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=tW3mw/sD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I2WH2BA3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4EE951400140;
	Tue, 21 Oct 2025 23:35:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 23:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1761104140; x=1761190540; bh=jCd3bsZJOCuuXldIHedNC05pKE+oiyZmGli
	K3Gi+1vU=; b=tW3mw/sDnicD+5ejPHaTGP66hLmrwrdug7eaP1e32ga6hfu7S4u
	8vpQuGULQYjKVemWJR0u6+Y0wWEcnwsvDGQ4DbZP8TDHtLvBuoiSLsTaArAt37ij
	NT292g9VWkBLo+QuMyxyfdSD6s9DwEE10agcn9jJBU9RecToJcrNbaE1CzWIp70J
	B+CWNcZSDeISPPSN77zGFpUJCPpEPJp/FJ0XEA4gUkDb5uVLcMQUJQHtWNpoDyrn
	BzArmnmpdX5IAIADq09FCSDUFDee1K8/kKxpkcqX0nSU7Bx5PsXq/dsDU9rNn57W
	YDq1UBtcXwVlUqM+pRWPYh29cLoZ+z8LP0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761104140; x=
	1761190540; bh=jCd3bsZJOCuuXldIHedNC05pKE+oiyZmGliK3Gi+1vU=; b=I
	2WH2BA3KL/+cgFXyMMaFxFVeFMNUY2eMwcW+y2B5+5Nvmlb81IFrZB0nRp7OitO1
	ro8zlIbSVv1nwxDKSsmo9S3n0dIOBRaA1s3kfrKzYi4xaJqasAgObNXDNKPcw4Cr
	xjKhnN9wMrtRBe1q6mPLt7cUV/6ztWPw4VZgQpqiq6WaxitL+DdfxW+Shlohepfs
	w7Wer8UdOJ9ojBRnVdFoGL14n1D06YtPclIyHOrYD9qpLNOBgChPUfC0DqGJEVMx
	cbm3SAfIyN6SHioWKnK2i/QjglPfslAc8AG/p1I1fiwHriV0bw2zd4Kd+E+q6GQF
	KTLzbYCPVADreOHZSiItQ==
X-ME-Sender: <xms:C1H4aKsc2muuUykEHiR8sGbhPEOh5AT1JwywQFNTZHjYxok-xD_1-w>
    <xme:C1H4aKb1cyibvfkdBRI8eumraPr9ea0VnfzWqTPvAq8wOVzd87h3wFojH8H-MefOA
    XhmcbU9uoCmdZ4dgDPV6jTZx8-U4HYzjzhC1Ggcq0JZ4bejh0A>
X-ME-Received: <xmr:C1H4aEwyI9_AK76_rX1R8xvtq7QQ17eUB7RY6IENeqS-Hl1VaSoIL48ESwgYjMm82g4riX0c7hNaz8jZ5OqJQdgDCUOATrn9scVYyMOES1EM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhrohesii
    gvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtkhesshhush
    gvrdgtiidprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrmhhirhejfe
    hilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:C1H4aKi2CubohKsUFJjtnSkhZRaPPuCl-LSoR-b8UdRzcK_Lua31jw>
    <xmx:C1H4aImRzpDlBeDJcHTg4add972uaFgyqePq8HvPD69Y1sAD_CKnpg>
    <xmx:C1H4aIh7sMWYvb_BV7PLm6szNl2R7QCJr3qqm3QiCtyIi4GYSdGIgw>
    <xmx:C1H4aE2dNdQstFwfpLB-HfC-OFi7EKYXNJTvq6AwwBQ_n8IjJPB2sg>
    <xmx:DFH4aPnucdNs1pVnv7IvxpiLRC59wcW8dOcEcCCqEKIw1WHPjqN-19zr>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 23:35:37 -0400 (EDT)
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
Subject: Re: [PATCH v2 09/14] VFS/nfsd/ovl: introduce start_renaming() and
 end_renaming()
In-reply-to:
 <CAOQ4uxg27fWDEqQYJ9yw25PTZ37qjNUJu36SfQNwdCComP0UOA@mail.gmail.com>
References: <20251015014756.2073439-1-neilb@ownmail.net>,
 <20251015014756.2073439-10-neilb@ownmail.net>,
 <CAOQ4uxg27fWDEqQYJ9yw25PTZ37qjNUJu36SfQNwdCComP0UOA@mail.gmail.com>
Date: Wed, 22 Oct 2025 14:35:35 +1100
Message-id: <176110413598.1793333.9404395927201124508@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 19 Oct 2025, Amir Goldstein wrote:
> On Wed, Oct 15, 2025 at 3:48=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > start_renaming() combines name lookup and locking to prepare for rename.
> > It is used when two names need to be looked up as in nfsd and overlayfs -
> > cases where one or both dentrys are already available will be handled
> > separately.
> >
> > __start_renaming() avoids the inode_permission check and hash
> > calculation and is suitable after filename_parentat() in do_renameat2().
> > It subsumes quite a bit of code from that function.
> >
> > start_renaming() does calculate the hash and check X permission and is
> > suitable elsewhere:
> > - nfsd_rename()
> > - ovl_rename()
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
>=20
> Review comments from v1 not addressed:
> https://lore.kernel.org/linux-fsdevel/CAOQ4uxh+NcAv9v6NtVRrLCMYbpd0ajtvsd6c=
9-W2a7+vur0UJQ@mail.gmail.com/

I do remember looking at those .... thanks for the reminder.
They all look good and sensible.  I have made the appropriate changes.

Thanks,
NeilBrown

