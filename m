Return-Path: <linux-fsdevel+bounces-71507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E54CC5F42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 05:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D3143024278
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 04:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89FD29BD91;
	Wed, 17 Dec 2025 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="DDC/zJxs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JyK4gPlN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6051DFFD;
	Wed, 17 Dec 2025 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765945272; cv=none; b=oRvG/A8KRH1LWjAwfcoV4aKJ/NkkQdYqKb0sOH8n35b1j64nK3AVZzPimtNlpWNwBpnDJRFb8WOyO0FyYIa0tcd1mr4Kf2iWGpblF6HoVbf/bVFJdav9x0wmMxErlwv0oL0iAPCZCA+i2z3Bvz1QLUdWcfEv5U5jKypAIpg+OlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765945272; c=relaxed/simple;
	bh=V44O9YS2fEQe5GlmUSXMQ57r9NXHCKoCHMsAAzkfGUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YY95kWHVUL1Hg5KFzjs4UuBl0oXz8H4iBaWZPOuMw2xpvV6G/v0K7JTZtIUgT3HobRQoVZ9WBR9hPzAKHS7fn4pWrMXDFk5fk3qWEA+X51V/EUbGv57c7HbfDgjSmTxWnaJyCMYw30ZiAR39VmUVXVydWL+jJGUwYyUMrHOxSAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=DDC/zJxs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JyK4gPlN; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 040B67A0044;
	Tue, 16 Dec 2025 23:21:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 16 Dec 2025 23:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765945268;
	 x=1766031668; bh=apzxJrLZTs3K7lqQ1syXkRTRvEhfGpt0EKc0mVl3B7c=; b=
	DDC/zJxsZ4V4YIv4C6jW1g3ulxbzHQDewTpeU73doK99H/0eJ1/KRmlksK1+A7Kd
	sYr3LCXrRtX1NAuLYWuWWM/cb2bjGEden98WNf1zkUT3N2monrgcho39XW0ZuAPy
	NMNIEq4kVAFKVN0qcduYEXypIRpOOdXPxZc0BgTCdk6B4aVcUnHN0xq0Tismhwft
	JIB5uOThivu+MHPf1MVrJl4QR3SDtldIm0pBhmoXtoTIf6sl4b/3QohBLb370x5s
	Ml1/mFW67yiOcb9xTQvsQyTYN+uNPD8tG53PgjavVK7Gxh34jWt3UWVyUw1W7W2P
	F/pzZ9INLmlREwyYMq4kww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765945268; x=
	1766031668; bh=apzxJrLZTs3K7lqQ1syXkRTRvEhfGpt0EKc0mVl3B7c=; b=J
	yK4gPlN6M5XxkpLM05c3qfWP1fROcmcq7nZDraHkai/aO1ddPFcpM9CAUMsAITVh
	d0zbgTI/zYnhOsTkrmXBYD72NWFS1SRZq8u2e3yQqMV5aKJnhHPqgTcDfxZRNuGZ
	IcHqXSUWz52nAgrihWsin/NTxGcouk4oecuBNxtM5BywY/Ro1Wjzb97U8kgb2x+P
	UyLj4BOXWE/DnmgXRF1w/o156D3sI3DznDPVIAAhiGxMD7+1vgyUZclunb3dgPSB
	2JgSQD2gMhVVzjVz4uh3SJwBHmy2QBDoZXqM8d2y8+dY69sqGKxpRIwFFxRzx+rU
	DNnQ9MnKtG/LNcQ4tTWCA==
X-ME-Sender: <xms:tC9CaSofCRVviaO0kczt_a0Pya9T6WSO1IDtd_w9O9m7O0fq3kI7Ww>
    <xme:tC9CaS4FaEz03SWw9deCsqYHBkQMhDzktGYH7dQrd2A05x3yIWiAwDv43cwjVpBeb
    161NwHoIYJtuyMaGd3xyYEJXy_HqwEHnqOuinURhPY-If9Fp9jup4E>
X-ME-Received: <xmr:tC9CaZdknZIhkOEBZn-KtZrp9ATQwLKyQPuQ9QNelHbs_qp1lonMYbt3KL8xKztPjxNFA9nC5r-WctMDJ0Qrxe72NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepgfhrihgtucfu
    rghnuggvvghnuceoshgrnhguvggvnhesshgrnhguvggvnhdrnhgvtheqnecuggftrfgrth
    htvghrnhepveeikeeuteefueejtdehfeefvdegffeivdejjeelfffhgeegjeeutdejueel
    hfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grnhguvggvnhesshgrnhguvggvnhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehsrghnuggvvghnsehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peguhhhofigvlhhlshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepvhhirhhoseiivg
    hnihhvrdhlihhnuhigrdhorhhgrdhukh
X-ME-Proxy: <xmx:tC9CaX7sRhEMpA6J-MHRwgi3xxCg5tN2YTOmdKn0RjJksTk0P9Wm1g>
    <xmx:tC9CaQu6iKP85mZSvZsFA_WgvQQcA1ZZavnetczznx3KNc9DVfebgw>
    <xmx:tC9CaXh4ztacqAcat1zJjToWb5PstKnjfqRATfA_fj5N_Z5vKkPs2Q>
    <xmx:tC9Cabp2n4hp0Cg6pO-QJhhWKth3mYS5yaun7kCsH2K4hBzh4D_alw>
    <xmx:tC9CaciNKJuE4v5vl5ahyPgl7Pad8n2eryJqK-CmTubRQpAMHky2BKiV>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 23:21:08 -0500 (EST)
Message-ID: <5d630a62-6774-43b8-a9b7-9b6ab56e25be@sandeen.net>
Date: Tue, 16 Dec 2025 22:21:07 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Remove internal old mount API code
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Eric Sandeen <sandeen@redhat.com>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, viro@zeniv.linux.org.uk
References: <20251212174403.2882183-1-sandeen@redhat.com>
 <20251215-brummen-rosen-c4fc9d11009a@brauner>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20251215-brummen-rosen-c4fc9d11009a@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/25 8:02 AM, Christian Brauner wrote:
> On Fri, 12 Dec 2025 11:44:03 -0600, Eric Sandeen wrote:
>> Now that the last in-tree filesystem has been converted to the new mount
>> API, remove all legacy mount API code designed to handle un-converted
>> filesystems, and remove associated documentation as well.
>>
>> (The code to handle the legacy mount(2) syscall from userspace is still
>> in place, of course.)
>>
>> [...]
> 
> I love this. Thanks for all the work on this! :)

"Of the 56 or so kernel filesystems, around 30 still remain to be
converted, Sandeen said, so he has been joking that the completion
of the effort will be in 2026."

*phew* just under the wire ;)

-Eric

