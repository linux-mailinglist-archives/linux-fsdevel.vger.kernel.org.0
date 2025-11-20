Return-Path: <linux-fsdevel+bounces-69212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD179C72D2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 09:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CEC44E5D7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 08:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CE631B803;
	Thu, 20 Nov 2025 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TZQTZgyB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PbZwNbw9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB95131AF3C;
	Thu, 20 Nov 2025 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626877; cv=none; b=cf8zOZ1Q9xIlyuxwNeNpfiZedS/9ZQtv7AoYCn2nR44jcbkeQvXkaIigldWiDGkruAng6zwGPxSG0C4RiP1W5lzqA+U9+IaCqXxJbhk3idEAIfnlGPU8noKaOsw42IHZ4ubAPcb54SqHtfCZdTObiJitjG8/E6zS6QD0Jlmeg3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626877; c=relaxed/simple;
	bh=z/8pN91Ni5yt00D0aZA6TYxGreivp4v1oSml4t+EGnM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uv4HxegSEFAQz1g0nsGeb1TSGYf3Yzfd/wuISTapn9ViR6z7fWrKWNSa0bMErt6RpzBer1qKs+3ydjuOgiFD9wzvlZW7yUOn2lmr2UCucZTu2mLxux/YSLeb1IXzclfoiNjX+M9CYMVaH4H9wAlTgDuJlRdXKNGvr2580hpY1vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TZQTZgyB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PbZwNbw9; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 75B9114001B3;
	Thu, 20 Nov 2025 03:21:13 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 20 Nov 2025 03:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763626873;
	 x=1763713273; bh=vw18kNyGCqDYWIxezAS79655AupPNhDVjKs/IhFQtF0=; b=
	TZQTZgyBILHUJ/Tkesi3a1zooFztclctkFHwNarRQlD8uEvrSEz8/ZLMDC4YVKO3
	vBgcZt3Y5KeAh88AncdKFX0j45BaEu5w3wRl7rUVnNXQNNL9c5BoKAi4gCc3RHgZ
	GzHstWKMVePbJZl08umAQG4qsoSE30E/gfsfxBBRT8/gE9wXA05yeWnV73+W3/69
	tIKQ2XWnEOSsO1MhJPfWqTesfkY7o9Pjyolj2Yr3YW8QQPzraqXSF/D0ZKbl7m2h
	zNOrUyam0y7KkuPobpoYd6EMhZF+cYl3EAMq1QTMrSTiLzw4dTo8gqFAC/wjsm8u
	yLBLWeKdI1ur6cVjX533Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763626873; x=
	1763713273; bh=vw18kNyGCqDYWIxezAS79655AupPNhDVjKs/IhFQtF0=; b=P
	bZwNbw94B6GBIFwYUFGKR0gpbLTJnTJw8PC7Iq1YH8wa6nbnTe5qlwr+gZbCEd4F
	3jFyvOO9q5GQogti0O4oNJu+lDYTxPdSX2pBThnFX7al8Z5vbSw/tcdI9TvdDL6D
	kAgUv3n06lzmg2KGSWf0bA8pL3EYsZ9sgz4AQ1H3ecywa37AlUWlbcOwupPFo0nt
	UvzlN9Q72qyAZGIc3biQJqaW5dO0nZ599froyS7KX6D7wU4FTrKwlHBavsbTR5Df
	gV0tHSW/79qkiFuBmZY/9/kkKBscLLTeYyj4nruj7pAteUw9BK4lm/FCsmZ6YNZ9
	/vYGkcfMo3HGkEYUbA1uA==
X-ME-Sender: <xms:ds8eafrt0XZ5raKkctIqJ3bsxTZsJ3_coyiCDR1B8glhoOeG1Us4hQ>
    <xme:ds8eaUfDNz3nOUSqWwKQtDWBUysvMM-A3YbIjtOsSz-twhZmep6TXBlZfRGjd_2fc
    3Nx4H7iv5dVD7m15wuSCwVRjPvZEgShvGtQ_mZim6x90Qsitp3V8hk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdeiheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepfeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmiiigrhgvrghrhiestdhpohhinhhtvghrrdguvgdprhgtphhtth
    hopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehgrhgrfhesrghmrgiiohhnrdgt
    ohhmpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhlvghrohihsegtshhgrhhouhhprd
    gvuhdprhgtphhtthhopehjuhhlihgrnhdrshhtvggtkhhlihhnrgestgihsggvrhhushdq
    thgvtghhnhholhhoghihrdguvgdprhgtphhtthhopegthihphhgrrhestgihphhhrghrrd
    gtohhmpdhrtghpthhtohepnhhstghhihgthhgrnhesfhhrvggvsghogidrfhhrpdhrtghp
    thhtoheprghnugihrdhshhgvvhgthhgvnhhkohesghhmrghilhdrtghomhdprhgtphhtth
    hopegvmhgrihhlvdhtvghmrgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ds8eaU8GJMQFMXMY7ag887-iiAgPBvBEFvogn_AJx2SSSemdle75Yw>
    <xmx:ds8eadDXsm5xeCIuZaqkJu9DxNh3McNmkrxSEQy7NrDKtfzGmmMoNw>
    <xmx:ds8eaRqnVSFCVAf1pz7hTWqL9NJXmPlKn_-2-0xEekUQ-h7VVfpOcw>
    <xmx:ds8eafEzw4fMambw9Ym5jvlE_UEbIKsbkhlkglFK2Ux7LBbh0KXi5g>
    <xmx:ec8eaT7KiVhTF9AO3TSUH4nk64QGdvPiYBjgGQFexVwi-KIbNi5bYy8I>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0C1AE700054; Thu, 20 Nov 2025 03:21:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAVmrCFNBMTV
Date: Thu, 20 Nov 2025 09:20:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Askar Safin" <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Christoph Hellwig" <hch@lst.de>, "Jens Axboe" <axboe@kernel.dk>,
 "Andy Shevchenko" <andy.shevchenko@gmail.com>,
 "Aleksa Sarai" <cyphar@cyphar.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Julian Stecklina" <julian.stecklina@cyberus-technology.de>,
 "Gao Xiang" <hsiangkao@linux.alibaba.com>,
 "Art Nikpal" <email2tema@gmail.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Alexander Graf" <graf@amazon.com>, "Rob Landley" <rob@landley.net>,
 "Lennart Poettering" <mzxreary@0pointer.de>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-block@vger.kernel.org,
 initramfs@vger.kernel.org, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, "Michal Simek" <monstr@monstr.eu>,
 "Luis Chamberlain" <mcgrof@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Thorsten Blum" <thorsten.blum@linux.dev>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Dave Young" <dyoung@redhat.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Borislav Petkov" <bp@alien8.de>, "Jessica Clarke" <jrtc27@jrtc27.com>,
 "Nicolas Schichan" <nschichan@freebox.fr>,
 "David Disseldorp" <ddiss@suse.de>, patches@lists.linux.dev
Message-Id: <3e2d69f3-8b3a-4c41-8c5b-185c5f3a7b15@app.fastmail.com>
In-Reply-To: <20251119222407.3333257-2-safinaskar@gmail.com>
References: <20251119222407.3333257-1-safinaskar@gmail.com>
 <20251119222407.3333257-2-safinaskar@gmail.com>
Subject: Re: [PATCH v4 1/3] init: remove deprecated "load_ramdisk" and "prompt_ramdisk"
 command line parameters
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 19, 2025, at 23:24, Askar Safin wrote:
> ...which do nothing. They were deprecated (in documentation) in
> 6b99e6e6aa62 ("Documentation/admin-guide: blockdev/ramdisk: remove use of
> "rdev"") in 2020 and in kernel messages in c8376994c86c ("initrd: remove
> support for multiple floppies") in 2020.
>
> Signed-off-by: Askar Safin <safinaskar@gmail.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 ----
>  arch/arm/configs/neponset_defconfig             | 2 +-

For the arm defconfig:

Acked-by: Arnd Bergmann <arnd@arndb.de>

