Return-Path: <linux-fsdevel+bounces-50668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0316ACE48B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 20:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDC81896A0B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 18:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505F51F8F09;
	Wed,  4 Jun 2025 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="hvEWL21z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OAmS595p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67DE320F;
	Wed,  4 Jun 2025 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749063376; cv=none; b=B+vlzlbmM6INFfSRhKoZ9n1WPOCQNKuV14e8vyIyiKsUo/4LNTYqnRi0W0rr9cOSg83XLHTz3ZQQXiftscwz6bx6pLYU2Wa/962zuBEhwbFT/9NLshFRm3D6Cmm3gGv5RnTiy9W+Iw5x+npFirM3xJtlAtlzithvjWK/bRSE73g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749063376; c=relaxed/simple;
	bh=s9TbrYcq92l0SE3L2FOqTDM9iPRqgtiegl20pfvWLuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrJkTq5Z3EAs6bTIpcR3pL4d4eTYCGBD6WqxO4U882O4useqpsfj73fnu4TcAyli4fB73cTulpIEUQ5nmYLLXfdknPrhZ8PJoDDV2nn3XABNg1jMeeAWaNozah1Hhhtgm3+XiBm3twHVsYYfSqNHgytR0ZFURLnX5a0c8Uj6CBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=hvEWL21z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OAmS595p; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id B03FF1140141;
	Wed,  4 Jun 2025 14:56:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 04 Jun 2025 14:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749063372;
	 x=1749149772; bh=vaGa3ap6ipv7FxB/7KmR8n7sQjoO+MLUwaElb5phmA8=; b=
	hvEWL21zf8p5Uvg1ZLcYgtm6/Sjt1/SvthvgZuom4i4LhDVH1j1FG2vllAmn/ujM
	XMH+742x3H1nmaygNFEBpI9KRkt/cj5JqBQ90a/myeIasOUtVXVpG6+dQug/BHGG
	26kDPGm9d1U9MQ41R8TokkxuFYZ5sP+x37szAfj8r0oWykfDw4hBhffqms3w3SmZ
	5bYSOMpjQNAIzF9vIIb2WMPFHAlbo3rYoPD7YUgXm0cLymejUkv9XQ9kGiHGUmO2
	hF/xe3YFdk3GziqY9RzFX8+j/EQdaAxccAc1fW6uNWb27HPR0h84Cn+8ODbBbA8x
	Y3rZ62M7zTi5jMHw01mJTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749063372; x=
	1749149772; bh=vaGa3ap6ipv7FxB/7KmR8n7sQjoO+MLUwaElb5phmA8=; b=O
	AmS595pskXQL0uTvrlCexdByXFCqIliEBhPn76BkHOO3iYefo2kFUWYip5MWrND+
	CeH4Ei5gP6lqRUyIOrS4wsQBaWJ26V82XmYMKYw93SHrYPYtTNl1IjGEunxpKC+J
	p/NT4fwHlEaHRcVidzTwx2S1AElCRYCEX5oWAVk7YS19eW88caQNy15PjdakzxZd
	8Haj7oCK9+WEvVi10HMkaMYG2nlz4+WMJDYFxMXXcp+i90QLFkkOQMZu+jYVySzD
	dNLYT1G10gXHiUkx0bi/C9aXiGn/X0T8tMjraNPIHdVVURl4eW8UVGxKGOnO1Nwh
	g1+UIc63CIlM3Z/dZ3DIw==
X-ME-Sender: <xms:y5ZAaNfSOEHQI2S44gzV7ef4m1jZWt52qtaEX9-i-yVqEdAd30oKBA>
    <xme:y5ZAaLMLyep1GjBRt3WuNGWOX-V8lbl_UGQzSNZq-TEAdYvbijdQIGOKLkyPg-hcv
    1tBxGb8M1fRSzMxH0A>
X-ME-Received: <xmr:y5ZAaGglgZIpFS7cJYrHzvDhcdatnMk1SphgQ-852cImZtpuYKg-FNhcGo7WaAGcZnvg_08>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqne
    cuggftrfgrthhtvghrnhepfedvheeluedthfelgfevvdfgkeelgfelkeegtddvhedvgfdt
    feeilefhudetgfdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrgh
    druhhkpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehs
    ohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvg
    drtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopegrlhgv
    gigvihdrshhtrghrohhvohhithhovhesghhmrghilhdrtghomhdprhgtphhtthhopegsrh
    gruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhr
    ihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:y5ZAaG_JW1mvPvaW7S6fsMBzWV9x5vzNhEEL3-CW5Dg98bxMfqlXig>
    <xmx:y5ZAaJtCprMr3F3DFMGue1VGncu4GLK7ExPeHG3Zzp93nU2drnkzMg>
    <xmx:y5ZAaFE6bC8TWBf98-jgpwCuouvEOKiUfngTsOIeCQZ8n3k55JwwjA>
    <xmx:y5ZAaAMsw-DyBigzsv3rMZ78GAzzQe3mHHzjlC0inVmdHPmKWUeasA>
    <xmx:zJZAaCAiAKZfGo0WQk6ROlhHMsWrLPy7KNrnX_-Y-KE2IwKqdYdn1Pd2>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 14:56:10 -0400 (EDT)
Message-ID: <c4005b56-b341-4f37-b189-6681fcfe5bc6@maowtm.org>
Date: Wed, 4 Jun 2025 19:56:09 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] Restart pathwalk on rename seqcount change
To: Al Viro <viro@zeniv.linux.org.uk>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: Song Liu <song@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, Jan Kara <jack@suse.cz>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Christian Brauner <brauner@kernel.org>,
 linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1748997840.git.m@maowtm.org>
 <7452abd023a695a7cb87d0a30536e9afecae0e9a.1748997840.git.m@maowtm.org>
 <20250604005546.GE299672@ZenIV>
 <9245d92c-9d23-4d10-9f2d-7383b1a1d9a9@maowtm.org>
 <20250604022126.GF299672@ZenIV>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250604022126.GF299672@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/25 03:21, Al Viro wrote:
> On Wed, Jun 04, 2025 at 02:12:11AM +0100, Tingmao Wang wrote:
>> On 6/4/25 01:55, Al Viro wrote:
>>> On Wed, Jun 04, 2025 at 01:45:45AM +0100, Tingmao Wang wrote:
>>>> +		rename_seqcount = read_seqbegin(&rename_lock);
>>>> +		if (rename_seqcount % 2 == 1) {
>>>
>>> Please, describe the condition when that can happen, preferably
>>> along with a reproducer.
>>
>> My understanding is that when a rename is in progress the seqcount is odd,
>> is that correct?
>>
>> If that's the case, then the fs_race_test in patch 2 should act as a
>> reproducer, since it's constantly moving the directory.
>>
>> I can add a comment to explain this, thanks for pointing out.
>
> Please, read through the header declaring those primitives and read the
> documentation it refers to - it's useful for background.

Ok, so I didn't realize read_seqbegin actually waits for the seqcount to
turn even.  I did read the header earlier when following dget_parent but
probably misremembered and mixed raw_seqcount_begin with read_seqbegin.

>
> What's more, look at the area covered by rename_lock - I seriously suspect
> that you are greatly overestimating it.

Admittedly "when a rename is in progress" is a vague statement.  Looking
at what takes rename_lock in the code, it's only when we actually do
d_move where we take this lock (plus some other places), and the critical
section isn't very large, and does not contain any waits etc.

If we keep read_seqbegin, then that gives landlock more opportunity to do
a reference-less parent walk, but at the expense that a d_move anywhere,
even if it doesn't affect anything we're currently looking at, will
temporarily block this landlocked application (even if not for very long),
and multiple concurrent renames might cause us to wait for longer (but
probably won't starve us since we just need one "cycle" where rename
seqcount is even).

Since we can still safely do a parent walk, just needing to take dentry
references on our way, we could simply fallback to that in this situation.
i.e.  we can use raw_seqcount_begin and keep the seqcount & 1 check.

Now, there is the argument that if d_move is very quick, then it might be
worth waiting for it to finish, and we will fallback to the original
parent walk if the seqcount changes again.  I'm not sure which is best,
but I'm inclining towards changing this to raw_seqcount_begin, as this is
purely an optimization, and we do not _need_ to avoid concurrent renames.

