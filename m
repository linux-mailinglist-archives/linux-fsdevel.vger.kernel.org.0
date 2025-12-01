Return-Path: <linux-fsdevel+bounces-70353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FF5C98299
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 17:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A68E2344024
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C7E33344E;
	Mon,  1 Dec 2025 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIGe1Ps6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51AE31D362
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764605000; cv=none; b=XeoPHW5ENn0toRDkSbxkl2QPbxgOw2BUsJ7wBcfGIwNSToFYcbjceTmmU+TiVtmTUBVN72qryfvGnx8r2xyb5mSHXzmTVg+s/F0I854V2RTk5CpqfS57L1N5Vzxe/IiuGBDWHHw0rCAx9oNYFbEtM6Gims6d1K1xj1IfKnyLwdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764605000; c=relaxed/simple;
	bh=L694A+hcx1692Ups7VU6/fHwaV+/sr3zZmZeWzx6L7k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fFJSvf+Y09ZJWMv35J1w7UYnw03o/+EN8VgoztlTghqQpsrpSyJlpdSURVH/w+/cHrU+vwHKe9FfxB8IfpwtoGBDk2Bc7gCsbLg80nZgignKoTcj0XFD2nSTyIe6DJGBaUj2TucRaD3O3WSlI5I9sLZYARiuAyz4/JWndlu5bts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIGe1Ps6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30F3C4AF09;
	Mon,  1 Dec 2025 16:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764605000;
	bh=L694A+hcx1692Ups7VU6/fHwaV+/sr3zZmZeWzx6L7k=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=DIGe1Ps6tMLcC/64dye/OiKC6hTkPRTu9ee1HXSAb6CsAjpU7QwluXuXccBLdeVq4
	 sxvCD3oo+3ZF/JpF/ynixe8mKvDhC/SxB7zzHAVKfQ/JU/IjkeJH90DJSTakYAmO2B
	 u5q2ZFotxbLgduuRNalSQEEUlLKj/7ENjffZcTX6izClViB+oSHtaQHMsp2IOIozWP
	 /SmtLPBhhKM0BGMBTmljKMTBlUasLJrINP6WV/D5PBgx2mXwjDijG/WdqV/Kxf/W+H
	 7J7M8MuKxnCRgkYssaVTEITHCXxDL4V3bcIiKTh7GW3Ef0DeD2O1yrvm3jUo+bqUHk
	 ZQ6+oIuHSIMxg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 090A6F40094;
	Mon,  1 Dec 2025 11:03:19 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 01 Dec 2025 11:03:19 -0500
X-ME-Sender: <xms:RrwtaUZJyw5z4kK5o9zGWtoc_QyoMKZtmclUwks2lmudUHxR-4CpHw>
    <xme:RrwtaaPqeQz3lQm4P5CjCQWl6oHXinM7gqE_knhJxI7ZoxoHfoz-gSoWdAHoEYLof
    6fQkJLhAMjCwPTrsV7o8KDRTJ1voab7U9NgY6aTkN9YJQEFsdHpSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheekudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprghlvgigrdgrrh
    hinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggr
    ugdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrsggv
    theslhifnhdrnhgvthdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomh
    dprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphht
    thhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:RrwtabtFWcE-yCULQ3moXO3b1NtdDzsQlEjhglqGK1X3YqwtCfexZg>
    <xmx:RrwtaQlVArQLulqrEVJjy6nV9xrJEZzNGAGMuazF0lLGcmpieKNtFg>
    <xmx:RrwtabwJ9TiaKV8NHB2BjismzRlPl0m9IURwRMrMg0KPoCsX1HCnKA>
    <xmx:RrwtaUypRStNp2sOQ-xkOS5UAs4rgsA60Ya6lZ5NCmEt5PP8ISPozw>
    <xmx:R7wtaS82eR-2vzXf4SyCVAGrfnysrmeW2FGfIDgnBLxg6Camo5BZGaXA>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A6FE8780070; Mon,  1 Dec 2025 11:03:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aw9RNCMXdYSN
Date: Mon, 01 Dec 2025 11:01:38 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Jonathan Corbet" <corbet@lwn.net>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <d3635d5d-0594-4639-bf56-f35519b39c5b@app.fastmail.com>
In-Reply-To: <803c22e7855b699a74cf65c0ba9a0e9ad5b41257.camel@kernel.org>
References: <20251201-dir-deleg-ro-v1-0-2e32cf2df9b7@kernel.org>
 <78e50574-56f3-42e6-a471-c2dba4c7f1ad@app.fastmail.com>
 <803c22e7855b699a74cf65c0ba9a0e9ad5b41257.camel@kernel.org>
Subject: Re: [PATCH 0/2] filelock: fix conflict detection with userland file
 delegations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Dec 1, 2025, at 10:52 AM, Jeff Layton wrote:
> On Mon, 2025-12-01 at 10:19 -0500, Chuck Lever wrote:
>> 
>> On Mon, Dec 1, 2025, at 10:08 AM, Jeff Layton wrote:
>> > This patchset fixes the way that conflicts are detected when userland
>> > requests file delegations. The problem is due to a hack that was added
>> > long ago which worked up until userland could request a file delegation.
>> > 
>> > This fixes the bug and makes things a bit less hacky. Please consider
>> > for v6.19.
>> 
>> I would like a little more time to review this carefully, especially
>> in light of similar work Dai has already posted in this area. If by
>> "v6.19" you mean "not before v6.19-rcN where N > 3", then that WFM.
>> 
>
> Ok. Do you have a specific concern?

It looks so similar to what Dai was doing to deal with nfsd deadlocking
and my recent RFC in the same area that we should ensure that these
efforts are all going in a compatible direction.

Clearly, adding callbacks to NFSD that just return 0 is not a
functional risk ;-) But during a merge window I can't guarantee I'll
have time to look at this closely.


> FWIW, I did mention to Dai that the
> first patch in this series would make it more palatable to handle his
> new lm_breaker_timedout operation in lease_dispose_list().
>
> By v6.19, I mean before v6.19 ships. This bug needs to be fixed before
> we release a kernel that provides the new F_SETDELEG interface.

No problem. v6.19-rc rather than in the merge window is all I need.


>> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> > ---
>> > Jeff Layton (2):
>> >       filelock: add lease_dispose_list() helper
>> >       filelock: allow lease_managers to dictate what qualifies as a conflict
>> > 
>> >  Documentation/filesystems/locking.rst |   1 +
>> >  fs/locks.c                            | 119 +++++++++++++++++-----------------
>> >  fs/nfsd/nfs4layouts.c                 |  11 +++-
>> >  fs/nfsd/nfs4state.c                   |   7 ++
>> >  include/linux/filelock.h              |   1 +
>> >  5 files changed, 79 insertions(+), 60 deletions(-)
>> > ---
>> > base-commit: 76c63ff12e067e1ff77b19a83c24774899ed01fc
>> > change-id: 20251201-dir-deleg-ro-41a16bc22838
>> > 
>> > Best regards,
>> > -- 
>> > Jeff Layton <jlayton@kernel.org>
>
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever

