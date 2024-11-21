Return-Path: <linux-fsdevel+bounces-35455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFAB9D4EB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 15:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304CE284167
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 14:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F1B1D934B;
	Thu, 21 Nov 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="SHteVPhf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QFyjiVtr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77F24A02;
	Thu, 21 Nov 2024 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732199645; cv=none; b=FqzHEPlBmvbp0/ov1CgKg91YMZbKt0cIR1iRjoxjQstvr7EsqROl4PMY0qp48SgR8/Jod7bGr2gRHMWtkacL6QJcrdit707BXVpLDyQcRhLq9CnuY1HX2212Ok8iltuK+O/7HX846U5M4jNjL5wAIkECxHXQlNT/qLf2BqtXO8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732199645; c=relaxed/simple;
	bh=pIKV3HP1VFzMsK7qp0/RzOA25Z/QTyzJnYYwGtbCSAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hW85rKpX8jOV7R9VxKoJ9acFWswdC3I4K3kmdxLwATfmdeaulsyKnHyhQCpxtu7hWt6hX28Kx1Ra0WVRHq4Z5dVDxoBFAHWe1nkxscgMUwpXcTl0ToHJqN9E39lidXgEPJJ4ro0Wb+6v+sWW12cFCdQB2KRmYiwhLGojLb+ECn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=SHteVPhf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QFyjiVtr; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1370225401A1;
	Thu, 21 Nov 2024 09:34:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 21 Nov 2024 09:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1732199640; x=1732286040; bh=0BYnMeJRRg
	a6HCEMYOl8JHeH/RdBznWhgGPzkdFC558=; b=SHteVPhfBZHF+oVkqiqfXHCdQM
	0BauPYR14ct0FS7w+RoxJLyX463jk8SyPch19crb/4eWT65MJyhitNCwGQaPR4+J
	vLKst/yW2vHlDClQUGN8eKAcMN1OgMO0jxCHDZ4WqdIP/HfOSW8kD5sszcxBSn0e
	MrenqfA51fhFAWLcmNQq/8zpJTqBIt46/Ioab2vA0/luy+w5ICKS1kGPq4VoHCvx
	scXfWyu44QWyPwkVSvT7YPLaAOlZuKx+pDNnhowjxRV3/hxe/fKMFQjJqa+mEzZ8
	BWOvodjEI3QdpqRKLh3lBFBFKCI14UvM9iuBW4kIVl0zhNh3a7cHqXHIvTQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732199640; x=1732286040; bh=0BYnMeJRRga6HCEMYOl8JHeH/RdBznWhgGP
	zkdFC558=; b=QFyjiVtrEpuRhZSbpi7uTbm+Ve10QDiebnYaC+AVoBk18OSOL0y
	XaKNDoSwOTJzWhNT5Tcsq9vvXvWUkLGICYm4lfjYQ5iRmFnK0ax9fAv0k+UCVvgQ
	PzszfOjpZtoJhYc2we0aGyQcigslSH+3BwrVD1fIlkZysPRg1dxk7wQQ+peVLmvl
	OF+30YNoJxDq28J4l9rXgMqoyZE4prRCw8i0HPcmgduBZkV5bcuUWA7/ndrVGIjy
	L60Su+5GlNT5wjvKbgLz82XjFT2S355RLVltfivOMQxuwzn8nhXmdfCDqQFcMMjP
	5wdWOjpNngt32p1mxy6qTl8KinIDEG3Dt8Q==
X-ME-Sender: <xms:2EQ_Z43G0HHV3dgjtkCFFhFemyIqoetbakXQ1BpMKzw0X4vmbYSqKg>
    <xme:2EQ_ZzFUOaDMU7YemgNprVEBh-aJgD0Q7PXaEtPxt2Dujimgsvfi_KNNbaTsXvcR7
    KjvVCRD15H6n0vjDWw>
X-ME-Received: <xmr:2EQ_Zw43mcxookhNFM_lV-Ar0KDQeuBfsuupnkspydWsPd60KYfQQhtRA4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeigdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefvhigthhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpih
    iiiigrqeenucggtffrrghtthgvrhhnpeelveduteeghfehkeeukefhudfftefhheetfedt
    hfevgfetleevvdduveetueefheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohes
    thihtghhohdrphhiiiiirgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    peihuhhnrdiihhhouhesfihinhgurhhivhgvrhdrtghomhdprhgtphhtthhopehsthhgrh
    grsggvrhesshhtghhrrggsvghrrdhorhhgpdhrtghpthhtoheptgihphhhrghrsegthihp
    hhgrrhdrtghomhdprhgtphhtthhopegrlhgvkhhsrghnughrrdhmihhkhhgrlhhithhshi
    hnsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtohepmhgtghhrohhfsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhovghlrdhgrhgrnhgrughosheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhh
    ihhrrghmrghtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2EQ_Zx1xfu7bMFHuXpLNy3GvdU3EO31teX2VFaQ5lc4q-xnQo2R9sg>
    <xmx:2EQ_Z7H7dc6esBAh0rSchQKiz0paeVTxebweZQeun_P7dtICZdD4wg>
    <xmx:2EQ_Z6_Mb-658p7Cg3fNEFcakxCVBA2PEEDMoc1FZ6xfZ3STPQQrAQ>
    <xmx:2EQ_ZwnycN2vaNYgYmfVyb9Fao4NoXiXVbZ5FHh79KyT8a1vlPK6Ig>
    <xmx:2EQ_Z7HaBXadyn7xvkK1GVw-C7V0eRnnZgAhf3aGWJnWomVCmv_iUoVg>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 09:33:58 -0500 (EST)
Date: Thu, 21 Nov 2024 07:33:54 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Christian Brauner <brauner@kernel.org>
Cc: Yun Zhou <yun.zhou@windriver.com>, stgraber@stgraber.org,
	cyphar@cyphar.com,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	mcgrof@kernel.org, kees@kernel.org, joel.granados@kernel.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel: add pid_max to pid_namespace
Message-ID: <Zz9E0pGTioTcH32m@tycho.pizza>
References: <20241105031024.3866383-1-yun.zhou@windriver.com>
 <20241120-entgiften-geldhahn-a9d2922ec3e0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120-entgiften-geldhahn-a9d2922ec3e0@brauner>

On Wed, Nov 20, 2024 at 10:06:27AM +0100, Christian Brauner wrote:
> On Tue, Nov 05, 2024 at 11:10:24AM +0800, Yun Zhou wrote:
> > It is necessary to have a different pid_max in different containers.
> > For example, multiple containers are running on a host, one of which
> > is Android, and its 32 bit bionic libc only accepts pid <= 65535. So
> > it requires the global pid_max <= 65535. This will cause configuration
> > conflicts with other containers and also limit the maximum number of
> > tasks for the entire system.
> > 
> > Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> > ---
> 
> Fwiw, I've done a patch like this years ago and then Alex revived it in
> [1] including selftests! There's downsides to consider:
> 
> [1]: https://lore.kernel.org/lkml/20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com

Thanks, looks like this patch has the same oddity.

For me it's enough to just walk up the tree when changing pid_max. It
seems unlikely that applications will create a sub pidns and then lower
the max in their own pid_max. Famous last words and all that.

Tycho

