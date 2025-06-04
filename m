Return-Path: <linux-fsdevel+bounces-50670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C27FACE4B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 21:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C33AF7A9AE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 19:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1005E1FFC5D;
	Wed,  4 Jun 2025 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="I5NgN3KJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jNAOL7rb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8885C1DFE12;
	Wed,  4 Jun 2025 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749064669; cv=none; b=rIXTCq/Me6HiAzvXbcbGqKR8lGx2/G7CNn+RhP/SSwblk6EaNvTGlHfxo6FTBQUJEIzlEnr1m1iG5iUhGr6KPRvjZk1LdohHCXQYjcI64rBQHGwPs/mNKvuGeCD7ZBivx8PI7uDyXlaiCvma+4xDvRFW9q1LhYHzL7MYQENWisY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749064669; c=relaxed/simple;
	bh=O7kf9KtDBjP650huWHV1AbZ890hWnWAPSANpvMutrAk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KJWlxu+kRCjuaWzslQ2pSIt1yhPXvi4AjPkOJEhDTfinAq+vyQPRIlXKOa+chv7rVXAEqfqTxvlSh0Z9vVW4G0VNjwg4AMoWS/qIJIFHOlW58Lbfz5PdxE8tfA00XB4I5eUecFp54B7SZsM4xJQr+TR8nV6JKLYSZmfw8KCfTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=I5NgN3KJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jNAOL7rb; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 78220114011D;
	Wed,  4 Jun 2025 15:17:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 04 Jun 2025 15:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749064666;
	 x=1749151066; bh=/2HnectDLKaHvkonOGTZKsHCakyAJw7bu2Es49gyzxE=; b=
	I5NgN3KJwBcGFnrB2s9hFMcXRZfxOo1UDZ/fepdARKrX1J68agBLhpnlcwqvmhiS
	b7gwOd6EM2geddYhd/udbGU1i7Dd0FRnTDTtnHNUPUS74idhtrCz6s1Q3PJvQTn6
	z97VLywDY5WpzYcCZgJ8nZ9wOiYP9Y+kcg4K1gtpOklrXtOpEeNxmLnCcMDyf+vz
	0SHU/dsOzZwtWdOx4r0yerkdflcX1V5t9mNoDOB5HqT7x5sxxhbhYc2zYsCp2ozP
	ShSVocXNJh5qiqwIHNeeQeb/yXMA2aXtuoFCJodiMUoaB8Nb2ZNk8m2LoevX6lgC
	tgM6Q2NdcNXgl/tDVfXLKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749064666; x=
	1749151066; bh=/2HnectDLKaHvkonOGTZKsHCakyAJw7bu2Es49gyzxE=; b=j
	NAOL7rblk4nahR9DRacvlpENEaSmuGeMreUSlNgoUscmi3XlLOsHcge70ZAe245/
	vODd4ZsA0FUc1FBiVczKffxJ//sXGd5KO1aLod616Knp/PZliKXmKUkY0HXyGOdl
	e/QJzq2N9ImSw0j04xr/UOwXavYz0W7/NWSR57JZId+oSHaIeYSd2ueWJoXwLaW3
	lQi2oOsTGmpmamj9nan1sUlpSgPvqehYxtBA7xmD1MKq/Wa2CP2/PUYllbC/USfJ
	lHXfqNcbiqTXUKCfyH/WFaZCp1moLtonRvRKKeANZwynI84zOp8Z5ebR6ZKkEIG4
	XRIBUpaj4J+g3w4GQdQCg==
X-ME-Sender: <xms:2ZtAaLITTcc3Iaja8FLXpJq2z54dIRNMHDplhbdD8nnLihxSQQC-ZQ>
    <xme:2ZtAaPJqkec27iM_QkCUyeVsf7JuQQOU-0DQvRQfBdGdQZO7XGtsOJXRpVdzDscTW
    _mC3_0EIJwv1-Ff-lw>
X-ME-Received: <xmr:2ZtAaDtNeKmJl3J7LKENwXRFX1d-WOxKpeXLaHZOejajAapJiHI1nw-D4SfCshvtXf-nN5M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffhvfevfhgjtgfgsehtjeertddtvdej
    necuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqne
    cuggftrfgrthhtvghrnhepheffleegkedtueefleduueehueevffduheejudduveevtdev
    keelkedtudfhvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrgh
    druhhkpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehs
    ohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvg
    drtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopegrlhgv
    gigvihdrshhtrghrohhvohhithhovhesghhmrghilhdrtghomhdprhgtphhtthhopegsrh
    gruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhr
    ihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2ZtAaEZQ496aHTcmGCeDtn90E1vn3iWx8aQPWP2f35wSdVkc9wPHTA>
    <xmx:2ZtAaCbWsxFJfx3xqucegjoo7tV0AWLBhkJkXtbCtKZqCglkxP6gHQ>
    <xmx:2ZtAaIDu5vvS6CiJYOmYv8JUii7ozUqdZA5E5Efh5o4nUTXOwRvkbg>
    <xmx:2ZtAaAYeOAxPr4n7s6uOsozqFfM_CgSOKUP-mw5Cb9lgWr1oDN_b_Q>
    <xmx:2ptAaLl1opBh4b1V83CTHCAWQqjrW3S73qkBVl0fbL5euFxkdD90K1yP>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 15:17:44 -0400 (EDT)
Message-ID: <0e98cfd7-a51b-4f39-970f-8ac9d5d60bec@maowtm.org>
Date: Wed, 4 Jun 2025 20:17:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] Restart pathwalk on rename seqcount change
From: Tingmao Wang <m@maowtm.org>
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
 <c4005b56-b341-4f37-b189-6681fcfe5bc6@maowtm.org>
Content-Language: en-US
In-Reply-To: <c4005b56-b341-4f37-b189-6681fcfe5bc6@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/25 19:56, Tingmao Wang wrote:
> On 6/4/25 03:21, Al Viro wrote:
>> On Wed, Jun 04, 2025 at 02:12:11AM +0100, Tingmao Wang wrote:
>>> On 6/4/25 01:55, Al Viro wrote:
>>>> On Wed, Jun 04, 2025 at 01:45:45AM +0100, Tingmao Wang wrote:
>>>>> +		rename_seqcount = read_seqbegin(&rename_lock);
>>>>> +		if (rename_seqcount % 2 == 1) {
>>>>
>>>> Please, describe the condition when that can happen, preferably
>>>> along with a reproducer.
>>>
>>> My understanding is that when a rename is in progress the seqcount is odd,
>>> is that correct?
>>>
>>> If that's the case, then the fs_race_test in patch 2 should act as a
>>> reproducer, since it's constantly moving the directory.
>>>
>>> I can add a comment to explain this, thanks for pointing out.
>>
>> Please, read through the header declaring those primitives and read the
>> documentation it refers to - it's useful for background.
> 
> Ok, so I didn't realize read_seqbegin actually waits for the seqcount to
> turn even.  I did read the header earlier when following dget_parent but
> probably misremembered and mixed raw_seqcount_begin with read_seqbegin.

Right, after more careful looking I think what I actually want here is
raw_read_seqcount.  My apologies.

> 
>>
>> What's more, look at the area covered by rename_lock - I seriously suspect
>> that you are greatly overestimating it.
> 
> Admittedly "when a rename is in progress" is a vague statement.  Looking
> at what takes rename_lock in the code, it's only when we actually do
> d_move where we take this lock (plus some other places), and the critical
> section isn't very large, and does not contain any waits etc.
> 
> If we keep read_seqbegin, then that gives landlock more opportunity to do
> a reference-less parent walk, but at the expense that a d_move anywhere,
> even if it doesn't affect anything we're currently looking at, will
> temporarily block this landlocked application (even if not for very long),
> and multiple concurrent renames might cause us to wait for longer (but
> probably won't starve us since we just need one "cycle" where rename
> seqcount is even).
> 
> Since we can still safely do a parent walk, just needing to take dentry
> references on our way, we could simply fallback to that in this situation.
> i.e.  we can use raw_seqcount_begin and keep the seqcount & 1 check.

This will be raw_read_seqcount(&rename_lock.seqcount)

> 
> Now, there is the argument that if d_move is very quick, then it might be
> worth waiting for it to finish, and we will fallback to the original
> parent walk if the seqcount changes again.  I'm not sure which is best,
> but I'm inclining towards changing this to raw_seqcount_begin, as this is
> purely an optimization, and we do not _need_ to avoid concurrent renames.

