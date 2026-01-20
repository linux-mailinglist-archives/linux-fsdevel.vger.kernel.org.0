Return-Path: <linux-fsdevel+bounces-74597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E69D3C554
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 11:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E7964F6326
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 09:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BEE3DA7D4;
	Tue, 20 Jan 2026 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="B4Ifw4qd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0gXg21rp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76913D7D9E;
	Tue, 20 Jan 2026 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902371; cv=none; b=hP8PkpOrgl5k0tsEr3fZ8yv62F6Hz2NREXw7B4dwFzagCxR7Cuc2EdC34QNw1WMugrMH06E0rlTsUFaxVM84qt1QRB0m73fl6FeD5rcvIyVrn3b6TjI8VrE86DIcD3TTvdWj7cYG3J4ryrqhVw9UObAe8uUD/GCQ77km5twZd2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902371; c=relaxed/simple;
	bh=yG5WbZNhS76GS16oeBUSIjAB5qNc7ux113oe3wE4Goo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ENgOPgXxLffxiwKyeaVxqJMITWeg3/2aLoPNjoDCQryoIGo1q5GTA4veVAACkfm1WNLmF8OLHDy5BBaAshThxjsfXN4rlficHYXQdHUXhbmSKdYlhJdlTfZ3ABrfW8FLqJF6GJ3t2YkbRI4Q5vndeDhttMtve5rCdhPLLFn3RWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=B4Ifw4qd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0gXg21rp; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8303B1D0003E;
	Tue, 20 Jan 2026 04:46:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 20 Jan 2026 04:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768902367; x=1768988767; bh=xLj+omD/xUaOwHlJMjM5Cd1lvhK2K0AkJhH
	zat7HUlU=; b=B4Ifw4qdn1EK4S+d4eGA1D846SHX3u7rxLP8b9TZVzs7bmX06al
	TuQ+7GFuDS7ZuH5Gcfz/+/byLl5Tn8OUaiFInaGtcJO9aKIMxtTtwFrjwuIB59+1
	Br7v3anVLJJNX3tmgPYGhn7otAvqFKzKaEO58O2V6Qo+XyQIEr7iVfnQYp1zFXCd
	/i6f9IXiyZZOqGHWvOxPcRIS0B2q89kCmO24ZH8Li5e/44KB4w1jSRcZdJJbhLYS
	GN88kE4P4W2OLaZQcfmNa2OGHhm+IiIx89cH/RbCGd7Uj/b/6BNYV8I/gQ6Wv8qf
	nmB7LZOJmAAaGuk4airk7s+anYDtbZmSqUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768902367; x=
	1768988767; bh=xLj+omD/xUaOwHlJMjM5Cd1lvhK2K0AkJhHzat7HUlU=; b=0
	gXg21rpr2Z4zgNqne6hMODDti+4WcS4a++cY/a4jb1kE7oXqHPa6XF7Zg/X1uf7g
	Wpidn/NRyhDFfH4BnocqV5yD3tHfFcH9iNOwM4nDBdT0mtbHrd8Rbj0orVgXcd1D
	T/a1aGkp4PTKcPAK3IH2RWulHL8Vx6DPIZGQj1nqXYEVU+jaKIvgU7S3s6HaP2sI
	OBxI86Au6rBM07VOcd7xcf0mCgVg0dKLrXHwXZ1kpfNWbtw1tAr9/Sjm6WE0vw8W
	7NuF7gywuoBExIrkrWalSCpX3ULsN+Ne1mH8EMtwEyxyhYia6BONPDq6bXup+1+o
	WLrUzuwuQ+yvR40g8haYQ==
X-ME-Sender: <xms:3k5vaY2yWnYxjjhcUUeUR0fkPdOIwOKZ1Q9xiYNGfYBFfH4w70Mkeg>
    <xme:3k5vabOFA-yttgW3lI2__ZIWmRrWN4TE34jfysH2j6CHguCFwJ9-IcZzV-xlkoAZ_
    QtkUnAp-npEwW6fr9HSXAnxBTImD4e9siGIjobmXOYnV2Ldtg>
X-ME-Received: <xmr:3k5vaQbNO-xgO4pFotID1lSUdfNpZ1HFwqHPLf2DT7Gw_ihjFNb5xefkQSIj43YM37CaRqseCpWLUW6-bgOseYMRkXZLtsm0VHQ21wfGMuoe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedttdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlvghnnhgrrhhtsehpohgvthhtvghrihhnghdrnhgvthdp
    rhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtth
    hopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhn
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvsghighhgvghrsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3k5vaRwunNfPAME-DDu3Dxc0NbDcsapAW6hLWi3rLyzd_fnWQlix1Q>
    <xmx:3k5vaXPrrGU6wB33T_iXOTA9QJMpaNDTDOJVEP7Rlt9fkhHScIq3DA>
    <xmx:3k5vaYcxm9PU3cw41EENuobZfGWVGEfcYtbUAe5W30Y5FkRcqgX6gg>
    <xmx:3k5vaURr8dq1AueuiMdLNNAdWsIOa3ri48-q7o0gVccvJ-clrd6H7Q>
    <xmx:305vafBfLVxScQ6viY39yR2uCE0RaMQe8XYxdu32bFYeAxRZIHKxpHSh>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 04:46:03 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Rick Macklem" <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org, "Lennart Poettering" <lennart@poettering.net>
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
In-reply-to: <20260120-tratsch-luftfahrt-d447fdd12c10@brauner>
References: <cover.1768573690.git.bcodding@hammerspace.com>,
 <20260119-reingehen-gelitten-a5e364f704fa@brauner>,
 <176885678653.16766.8436118850581649792@noble.neil.brown.name>,
 <20260120-tratsch-luftfahrt-d447fdd12c10@brauner>
Date: Tue, 20 Jan 2026 20:46:01 +1100
Message-id: <176890236169.16766.7338555258291967939@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 20 Jan 2026, Christian Brauner wrote:
> > You don't need signing to ensure a filehandle doesn't persist across
> > reboot.  For that you just need a generation number.  Storing a random
> > number generated at boot time in the filehandle would be a good solution.
> 
> For pidfs I went with the 64-bit inode number. But I dislike the
> generation number thing. If I would have to freedom to completely redo
> it I would probably assign a uuid to the pidfs sb and then use that in
> the file handles alongside the inode number. That would be enough for
> sure as the uuid would change on each boot.

What you are calling a "uuid" in "the pidfs sb" is exactly what I am
calling a "generation number" - for pidfs it would be a "generation
number" for the whole filesystem, while for ext4 etc it is a generation
number of the inode number.

So we are substantially in agreement.

Why do you not have freedom to add a uuid to the pidfs sb and to the
filehandles now?

Thanks,
NeilBrown

> 
> > The only reason we need signing is because filesystems only provide
> > 32bits of generation number.  If a filesystem stored 64 bits, and used a
> > crypto-safe random number for the generation number, then we wouldn't
> > need signing or a key.
> > 
> > We need a key, effectively, to turn a 32bit number that can be iterated
> > into a 64bit number which cannot, in a non-reversible way.
> > 
> > Does userspace refuse the extract the inode number if the filehandle
> > size changes?  It it can cope with size change, then adding a random
> > number to the end of the filehandle should not be a problem.
> 
> At least nsfs file handles are public api and may grow in size.
> 
> > I didn't know that.....
> > Oh, there is a "permission" operation now:
> > 
> >  * permission:
> >  *    Allow filesystems to specify a custom permission function.
> > 
> > Not the most useful documentation I have ever read.
> > Not documented in Documentation/filesystems/exporting.rst
> > 
> > Not used in fs/exportfs/.
> > Ahhh.. used in fs/fhandle.c to bypass may_decode_fh()
> > 
> > Fair enough - seems sane for a special-purpose filesystem to give away
> > different access.
> > 
> > Thanks for the info.
> > 
> > I wonder if nfsd should refuse to export filesystems which have a
> > .permission function, as they clearly are something special.
> 
> No problem. pidfs and nsfs have custom permission and open because they
> both don't need to reconstruct any paths and aren't subject to the same
> permission checking.
> 


