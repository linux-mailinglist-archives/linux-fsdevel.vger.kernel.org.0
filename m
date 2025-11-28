Return-Path: <linux-fsdevel+bounces-70177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F5DC92CB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 18:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 928BC4E3740
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F14432ED26;
	Fri, 28 Nov 2025 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="X/Yr9K3l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r7UNfM2n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A6D2627EC;
	Fri, 28 Nov 2025 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764350658; cv=none; b=MlqYNMg0bbE9N04+naRwPxqecpoN88WJioTb6sH0g9HFfcDb5qEvrsMfVEv6bS+cSL3+o0fBFz6WOsQ8e9Lu+PQ8NxSCtqVBNGBeM7+XvwVZmJo2341J4KCN1SZANrKcr6KQxLPeZbL4gUb9pe2y8q2anvWqLB+bPNeM44NzppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764350658; c=relaxed/simple;
	bh=UAvkHpUlrn9d3F7qZe01dl38Kp8jpQnLbeeJPJzFebA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8YiLCsQbCLIXiyg5MCOmx/oN1kGWId4zDUNsrWxWkF0lfWMmSI904XYinnWHbjcoYsuUVtbmPCFsf1F8+IjgJrdXmjmCaTueZdO6yRNDFaiQdZTikqbjrU1GzTsPzA6rSaIjUA1o+26rt18JgMfDGUVFRVXzQhHniW1Qc2qY6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=X/Yr9K3l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r7UNfM2n; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 126A1EC00B8;
	Fri, 28 Nov 2025 12:24:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 28 Nov 2025 12:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764350655;
	 x=1764437055; bh=0fPByf+feZB+VOIfY8Sd3EYuE0gzh9RLQNLwklqKDhg=; b=
	X/Yr9K3ltAqnrnCmuxDIO4geVUINML5t1QTOten/eQNHqKlII5qUfsoFLjGnqiF4
	Joe6QcXjhFtf5u4J+DuQFCMx6qVC/XsgaUyOcF/TotTcl1PXFkRGJCqPj5d7EAWS
	+0M+lZL+pa0364xrvBTwWTPQUJECVxkpsW1a230xDR56LOZ+XqFuuu2x6fh8FENJ
	e4bacove2GCIE1lyQua3GCRWuzPtWqmGA76q72DGT0BkZ+tr10Y0TehovLLuOqbp
	eUMdm+AcHM598cqJzNi1Wcmm41x0cGEisuDfuHKMVb8bAOGCZ+/P6BKElpim26mP
	alPvBdMCXqb2RfrmfncIyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764350655; x=
	1764437055; bh=0fPByf+feZB+VOIfY8Sd3EYuE0gzh9RLQNLwklqKDhg=; b=r
	7UNfM2nZXkk3YiDplaayTC0l/1PMIHdwkEeq7GblL3xUBCV44uJl/KKu4IWVAa6+
	WT7LK4HBqCRDeFEmUbgvAmkVJ61r/RpVbC2dULvH/XL9d/0D5zLvDWfdyENYqr9f
	fFQDTnOwKk8vqGjtWsYY4UasM6wrRJZhegeq8dD1q83GnXFR38tmYiEtYF1jJiMm
	5devh0xm9RcD031eMC5glAq6O63lt7Hogta6BWTgYXgdobTRLHSM7YLp1tTlgmEv
	9MyQbckULMdYfdVlF5B1qrnblDLGDOEPsgr7aFL3YYcJ0QBDcR/3VwpnF4lJseBU
	BXUHOCgQTQrO5CvsWzEAg==
X-ME-Sender: <xms:vtopadWv-XKTEA5ZYpOjW2ou8KivaMw19GqVf8l2Q3rM9gwyCuVFmA>
    <xme:vtopaRQva7TCBR-ZUjjtZpUPkuoL9w_RdieuKuqVa5SPPGsU-M3-mfKLOT2e8Xz6m
    e7-5nIfPegrKbW56RxwvDJ5_aEEWPyjAkhSmwK3RNKH_iENvAAlndQ>
X-ME-Received: <xmr:vtopaSBR1qOCljJwxI11Cu9OF3U06_ZmRQfV_kEgrz6pDJQWXzF3c8Duo4tkR33vv4VDrEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    ekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeeigfeltdehgeeghffgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdho
    rhhgrdhukhdprhgtphhtthhopegrkhhhnhgrsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghnnhhhsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehjvghffhiguhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphht
    thhopehivhgrnhhovhdrmhhikhhhrghilhdusehhuhgrfigvihdqphgrrhhtnhgvrhhsrd
    gtohhm
X-ME-Proxy: <xmx:vtopaRuSIwkiHKRRjuwBRt8tmP17unxrKSyZ5tA7Hk5hyIdI4xKOlA>
    <xmx:vtopaY__txPQhys5hlYFGID0jEDogTJuuAzWFwyaUWgwqiUIgzuTVg>
    <xmx:vtopaQSJ5Ox7xb4LkusZXL5O7IU8hETpaBkDcoJZVI2HeTN9OVZmEg>
    <xmx:vtopaSWCk9puLuAOv9A7IJ8ztUh2I1oWYOQ2Khyf5KEg0LYf63Nw7Q>
    <xmx:v9opaWvAbtWOo11pTLxU-WzG7Axl78lWfavkwjkd4Jy7VxNvzQ9a7s58>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 12:24:12 -0500 (EST)
Message-ID: <d1858185-245a-46d7-ae80-6384cd1ea96e@maowtm.org>
Date: Fri, 28 Nov 2025 17:24:11 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] landlock: Fix handling of disconnected directories
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Ben Scarlato <akhna@google.com>,
 Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@google.com>, Justin Suess <utilityemal77@gmail.com>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Paul Moore <paul@paul-moore.com>, Song Liu <song@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20251126191159.3530363-1-mic@digikod.net>
 <20251126191159.3530363-2-mic@digikod.net>
 <adf1f57c-8f8e-45a9-922c-4e08899bf14a@maowtm.org>
 <20251128.oht7Aic8nu9d@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251128.oht7Aic8nu9d@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/28/25 16:56, Mickaël Salaün wrote:
> On Fri, Nov 28, 2025 at 01:45:29AM +0000, Tingmao Wang wrote:
>> [...]
>>
>> Stepping back a bit, I also think it is reasonable to leave this issue as
>> is and not mitigate it (maybe warn about it in some way in the docs),
>> given that this can only happen if the policy is already weird (if the
>> intention is to protect some file, setting an allow access rule on its
>> parent, even if that parent is "hidden", is questionable).
> 
> I agree.

Some additional bit of reasoning, just to make sure this is sound, and
access gaining can really only happen if the policy deliberately adds rule
above protected hierarchies (i.e. this can't be exploited if the policy is
not "problematic", even if it has other hidden rules):

As far as I can tell, there is no way to exploit a "hidden" rule like this
to e.g. read a file if the file is not already under the "hidden" rule,
since in this case the file must be outside of the bind mount.  You can't
move files across mounts, and so the sandboxed application won't be able
to move it into the bind mount and cause the situation described above,
whether the destination is connected or disconnected.  (It also can't move
the file into such a mount from the source fs of the bind mount, even if
it has visibility to the source fs, since the refer check would fail
there.)


