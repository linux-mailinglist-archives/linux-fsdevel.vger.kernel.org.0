Return-Path: <linux-fsdevel+bounces-43311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D93A7A540E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 03:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C7467A3E11
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 02:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EDB194C94;
	Thu,  6 Mar 2025 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="O/lx6gLA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UmxIYFSL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D54D1946A2;
	Thu,  6 Mar 2025 02:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741229841; cv=none; b=GyPeBjYpla8ptVmGHTYjDc2Aj5iOYymU4wpB7jyLbY7JOSjkstODYZ3Rnw7Glqfpi5HMaxA4h4FEK2ZPXiEBhMdh/Rg4QHdF/55heAuPlq5FcDjDrvM81xnSc2fZEMC+Bwo95lY/tZCNOdB0I+0Yhgmugs8PxZwsyXQFWFpl70A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741229841; c=relaxed/simple;
	bh=HQ2oyZWO/ihrErRAXcpVyz1HUj/Zc1sPkID5Y2McYYQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VC0ZyO7AHXGBZRrUsfVcWEEYpnpRZupnqnmJ9bdxeSEgvht78tMtI6PfhBeCLFD167UWcWMhwwF1LJROEPTltdDcDnkPHgl0OqsyJNr9bVQU7EMWu598aB6HZlaN0dnqZuN80oCQ25yfLiFupJz+CftwuHTbnFBhOYuR60gTZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=O/lx6gLA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UmxIYFSL; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 67C47201CA4;
	Wed,  5 Mar 2025 21:57:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 05 Mar 2025 21:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741229838;
	 x=1741233438; bh=iJdqcUx1FD9GNKU9jg3pnj0uaf9OUSt5mROyFUWKFcw=; b=
	O/lx6gLABQUuIkH2b9wpqQpCarHzw9VoVcO2l7qMKAdBtRyfRR3+6dt7QoYEGJjV
	y1AW2l6iCZzpw9US3uWZVqpM8deHBltr3RgbKF9K+AxEAb9wCRp5CgE5dMfwMSvh
	RBES/8TDTiSxJGE+zPh28rgOvhF3nJ2iWGSI1SZarKPIjO5hZ1kb1NiCXVPSGg43
	MLcC1RoR/kYxerWgyshPu5L3cJG/gn0RBCAlDbM84UPUnLgz0VgtZRFeKUp7oGuv
	NdBknVrMCpg6hlxBxu42tCMbVhcmpKDb6SWkt/XVPKn26m3XiYG2pKtUgqVA12Cb
	wH08fBNnG/JzNYzA0WOi0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741229838; x=
	1741233438; bh=iJdqcUx1FD9GNKU9jg3pnj0uaf9OUSt5mROyFUWKFcw=; b=U
	mxIYFSL/f4FA52wwLBVaU7HCTo89QBVG5MQJs404VhvJBzwQKkth9kYKUJDhFCl4
	nW2KfPGxqOGSW8iPGSTrhK/nvZXUdUDH3GH0Jq/P9qq2WVJ54lMUNadYu2YTiHhY
	3ECqjdLIQWEWHZWZqzG/xH+vH5SsGtj6M8pYnqlQ+cJovyQYoZxu8RKwMnge3/Xu
	c1mHbquBY4/19SRfLKo9Gd/bCCZVDWDm8aa8AwRimAjGDXiScYGAJxSShN/O1UZI
	doYjqoPYQDk0HMe4WxSTwM9tIsKBAMNzojI2Kn8KK1srX+H6hXEffWlDQz6bDLTe
	scM2jwbnCyEaNlOL/Zs/g==
X-ME-Sender: <xms:DQ_JZ8hm-3A_jPMdY9x8ANKPB_nY56S3ZqlRWLASxQ25Sm90XVyg1w>
    <xme:DQ_JZ1CPuHEjEOQ3vcK5VBH13IaBFyFWnu-1Mst1eJsc-0jOtJAGaUiDTu6e_vQhC
    veSnr1VU5nNk3gQWe4>
X-ME-Received: <xmr:DQ_JZ0E9d7HpBGcvLMrWM3UQ3-3z_WjQxn1ryRZbUr7FXMxM3cWg2XeoSyqaJn4A1CvhiFe8bM0jwDMRy8UAz6UizSoaPDQY3NfzaTOxx_dVnPHq0NulZ84PfoI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdeiheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepjeefgfeghfejuefhheeigedvteetudeiudefvefhhefg
    gfffhfetudefteevudffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdr
    ohhrghdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhope
    hlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprhgvphhnohhpsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshgu
    vghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthihtghhohesth
    ihtghhohdrphhiiiiirgdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:DQ_JZ9TmnMvz7yONSYJocsLi0HHRDnO3LhqyBTcPPnTUZUBsKDp5jQ>
    <xmx:DQ_JZ5yE5IjAsg2zGps3VgdNubTltJrItbjFHy91uq_DLE695f2s3g>
    <xmx:DQ_JZ746J6HpgrHBhLh7rCBDFouaufqgjONh0gsbdBqTS6Xu555tPw>
    <xmx:DQ_JZ2xIQDrXJDS9PjtfUGvwM6iekHuQv2PNMr466Q_7f6dMD3n21g>
    <xmx:Dg_JZ_54GVZ6qpLXsaM3CChhIdo9At7U1lTi5R0r2wPvOEiQg-W57nVe>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 21:57:15 -0500 (EST)
Message-ID: <f6ef02c3-ad22-4dc6-b584-93276509dbeb@maowtm.org>
Date: Thu, 6 Mar 2025 02:57:13 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Jeff Xu <jeffxu@google.com>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Francis Laniel <flaniel@linux.microsoft.com>,
 Matthieu Buffet <matthieu@buffet.re>
References: <cover.1741047969.git.m@maowtm.org>
 <20250304.Choo7foe2eoj@digikod.net>
Content-Language: en-US, en-GB
In-Reply-To: <20250304.Choo7foe2eoj@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/4/25 19:48, Mickaël Salaün wrote:

> Thanks for this RFC, this is very promising!

Hi Mickaël - thanks for the prompt review and for your support! I have 
read your replies and have some thoughts already, but I kept getting 
distracted by other stuff and so haven't had much chance to express 
them.  I will address some first today and some more over the weekend.

> Another interesting use case is to trace programs and get an
> unprivileged "permissive" mode to quickly create sandbox policies.

Yes that would also be a good use. I thought of this initially but was 
thinking "I guess you can always do that with audit" but if we have 
landlock supervise maybe that would be an easier thing for tools to 
build upon...?

> As discussed, I was thinking about whether or not it would be possible
> to use the fanotify interface (e.g. fanotify_init(), fanotify FD...),
> but looking at your code, I think it would mostly increase complexity.
> There are also the issue with the Landlock semantic (e.g. access rights)
> which does not map 1:1 to the fanotify one.  A last thing is that
> fanotify is deeply tied to the VFS.  So, unless someone has a better
> idea, let's continue with your approach.

That sounds sensible - I will keep going with the current direction of a 
landlock-specific uapi. (happy to revisit should other people have 
suggestions)

> Android's SDCardFS is another example of such use.

Interesting - seems like it was deprecated for reasons unrelated to 
security though.

> One of the main suggestion would be to align with the audit patch series
> semantic and the defined "blockers":
> https://lore.kernel.org/all/20250131163059.1139617-1-mic@digikod.net/
> I'll send another series soon.

I will have a read of the existing audit series - are you planning 
significant changes to it in the next one?


