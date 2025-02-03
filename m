Return-Path: <linux-fsdevel+bounces-40624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD01A25F8B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 17:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEFE3A4C48
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 16:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F9120A5EC;
	Mon,  3 Feb 2025 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="Ly/LyYxZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FMkwxj8m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F414F12D
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599177; cv=none; b=ttHVihKCB09nxWaLCa/8XhJVz2nTJ0LwbtpayqpMl2hsj3UxbmnnjAWpCkKaEHL3gHr4Vf2azWL8aHV3BVgjJfGUrT6Y+/6fQjssqckJ1eRql7o1oAR4tRogVwfEijZY91Kr1si5S6ZUkdFTUVcwMLmZtaqUflygf5TYdE9qejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599177; c=relaxed/simple;
	bh=yL2RxBG3SQDefC5FuxSb3CRC2KC9pcrjv3KeSNQkoW8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uys1Po2Db9z3n9tswgRBO+9hXO+JF+nmUJBRA4ieSCmRTP2I/gFI2Haj1mpJ09NPDdKTuyCm7ZBPurNziGTfaUOMJsACEDZTeubdx3ZWRuWlrLRpW5YUPJDYMJV5vL0gKO/KkAWu5pqvm8u9Kl5bC739Aev1aqwCU6uNlKD9byA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=Ly/LyYxZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FMkwxj8m; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A37625400D9;
	Mon,  3 Feb 2025 11:12:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 03 Feb 2025 11:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1738599173; x=
	1738685573; bh=+nijA2jMPTI0vPAAB2pEsIfDGScEMB1adtsIUIhMUKs=; b=L
	y/LyYxZ0KHgyN9vBLYOUQmN4Fbkss5G1h8g3p1S14iHyHi3NRSwhywUo4f1CQRbp
	RoOvbnFPC/FHutekbcPu+55FNzQW1tnk2XMWMYA87wbKKZQsC7EnWgbJ2JMrBXm2
	0U0F6GICZ10vdolHtEQfHfJCeTOibvq57vktn6LLcZPdKpHRBReUrjwxGtMvCw5E
	nRxzVq9s/1trKe7M8voXQUJIezE9ekqPpcu4YxDBJ1dBtW/4jEDWF+A+F/vUSjEc
	amxaILQD54rS1ZgU+PlCS01107oZ39eQ314bHKWPLpjhzMzjensTQLxH4qB48omm
	FumtunuFAgP6O7v/CIsWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738599173; x=1738685573; bh=+nijA2jMPTI0vPAAB2pEsIfDGScEMB1adts
	IUIhMUKs=; b=FMkwxj8mYEwfHQe4XuuKVwc+tw1MfyirJaQmxt8xtRvOAj2nZ0o
	qQc0mZ0O4cMNmqeT8NMYtnSCbTyYW/CKsx6VcM/Bxcwe8sJCxzlCs/vOMl6UIRIL
	XgtqEuHDa+Sr5eycQLvbt+/lY0jDj+okPY9xh5H7GxmYaYfxwc+wYuUyfQsJF1aA
	WVe/ii8RPM2z0qc3dUPUxsslNefrnbFE+fDBOAOUprgvBTUoZpfIiIO+p7b53+qy
	/CjhBzoYTe8jZ0H5f8m4UzaHRrRlQIOQzwX2Zwgqn15Tg7QAW8AKXiD5d7Olw77x
	qNk4s7xYrX91iuDKim4tyZ1MW4GRS1Rgkqw==
X-ME-Sender: <xms:BOugZ6BQYP6c07SGud0cD1FHVhLBxGbnXqByb7Ey-OUtU3Hpw2hgUg>
    <xme:BOugZ0gw6DKutenysWF6Z1byC1udz7LuLTFj6AkInqSDXh74eXJ84GNJRg5pDqHyi
    E4a4_kpkE9KK6BVF98>
X-ME-Received: <xmr:BOugZ9mW_TFDtGA_0uhggCesA9pr3Z1Hx_753HXocVcUa0jGbnC7EROIQYcyiPBNbkmOwYLi8suHqMMnaAFPWX1NfRIbTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredt
    necuhfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrh
    drtghomheqnecuggftrfgrthhtvghrnhepudetjefhvdeujefhkefhteelffelheevtddu
    ueelkeeludevteekteekjeevvddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhnsggprhgt
    phhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqfh
    hsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkjhhlgies
    thgvmhhplhgvohhfshhtuhhpihgurdgtohhmpdhrtghpthhtohepjhgrmhgvshdrsghoth
    htohhmlhgvhieshhgrnhhsvghnphgrrhhtnhgvrhhshhhiphdrtghomhdprhgtphhtthho
    pegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlh
    hinhhugidrohhrghdruhhkpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    htohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthht
    ohepthhjsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BOugZ4ycb6FWjkGRc6XUxfY6zvtpCG2PMh8XdvjuInneyQHxWhGP3w>
    <xmx:BOugZ_Qzf_gvHWCloQtv3Q_C3YV4uVzNtsfPX2dMexg7BV-YxPBDSQ>
    <xmx:BOugZzbzrBR-en-I3cLrPuhZHsnOgYwCjxds2-k2b5FTzpp-TulXfQ>
    <xmx:BOugZ4Sji6xhuE9Rvd5kUrbDtPTVS9sAr10erRx6fzwqRuFMCbj6Gw>
    <xmx:BeugZ3Y_3kzvB2TfdQSmCMzfyxv9uW2JqpT1Hi0byVD-jJiMLPnTZsYN>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 11:12:51 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,  Tejun Heo <tj@kernel.org>,  Linus
 Torvalds <torvalds@linux-foundation.org>,  Christoph Hellwig
 <hch@infradead.org>,  Christian Brauner <brauner@kernel.org>,  Al Viro
 <viro@zeniv.linux.org.uk>,  Jonathan Corbet <corbet@lwn.net>,  James
 Bottomley <James.Bottomley@hansenpartnership.com>,  Krister Johansen
 <kjlx@templeofstupid.com>,  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] samples/kernfs: Add a pseudo-filesystem to
 demonstrate kernfs usage
In-Reply-To: <2025020304-mango-preheated-1560@gregkh> (Greg Kroah-Hartman's
	message of "Mon, 3 Feb 2025 16:05:17 +0100")
References: <20250121153646.37895-1-me@davidreaver.com>
	<Z5h0Xf-6s_7AH8tf@infradead.org>
	<20250128102744.1b94a789@gandalf.local.home>
	<CAHk-=wjEK-Ymmw8KYA_tENpDr_RstYxbXH=akjiUwxhkUzNx0Q@mail.gmail.com>
	<20250128174257.1e20c80f@gandalf.local.home>
	<Z5lfg4jjRJ2H0WTm@slm.duckdns.org>
	<20250128182957.55153dfc@gandalf.local.home>
	<Z5lqguLX-XeoktBa@slm.duckdns.org>
	<20250128190224.635a9562@gandalf.local.home>
	<2025020304-mango-preheated-1560@gregkh>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 08:12:50 -0800
Message-ID: <86bjvjdn25.fsf@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Jan 28, 2025 at 07:02:24PM -0500, Steven Rostedt wrote:
>>
>> And eventfs goes one step further. Because there's a full directory layout
>> that's identical for every event, it has a single descriptor for directory
>> and not for file. As there can be over 10 files per directory/event I
>> didn't want to waste even that memory. This is why I couldn't use kernfs
>> for eventfs, as I was able to still save a couple of megabytes by not
>> having the files have any descriptor representing them (besides a single
>> array for all events).
>
> Ok, that's fine, but the original point of "are you sure you want to use
> kernfs for anything other than what we have today" remains.  It's only a
> limited set of use cases that kernfs is good for, libfs is still the
> best place to start out for a virtual filesystem.  The fact that the
> majority of our "fake" filesystems are using libfs and not kernfs is
> semi-proof of that?
>
> Or is it proof that kernfs is just too undocumented that no one wants to
> move to it?  I don't know, but adding samples like this really isn't the
> answer to that, the answer would be moving an existing libfs
> implementation to use kernfs and then that patch series would be the
> example to follow for others.
>
> thanks,
>
> greg k-h

Thanks for reviewing the patch, Greg!

I put this sample together with the idea that some documentation is
better than none. I researched how kernfs could be useful in tracefs and
debugfs, but I haven't looked deeply into other virtual filesystems, so
I may have overestimated how well kernfs fits other use cases. From this
discussion, I see that a real libfs-to-kernfs port would provide a
better understanding of kernfs' viability elsewhere and also serve as
documentation.

Thanks for the discussion, folks! I learned a lot from this thread.

Thanks,
David Reaver

