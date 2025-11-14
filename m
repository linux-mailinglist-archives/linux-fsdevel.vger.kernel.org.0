Return-Path: <linux-fsdevel+bounces-68497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A784CC5D6AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D2734EAAE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F3431CA5B;
	Fri, 14 Nov 2025 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="GQTHsMBr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bco0FTAi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA37231A54F;
	Fri, 14 Nov 2025 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763127772; cv=none; b=JS+C0eXXGEilGdkqa89T3WNHKbqCZAlzhGHB4yxTB8/SbnLDz59dzNFXNTBw6m6EVpqSl1G9yeVEOTG9/d7bPeDIW1t8deSRMKtiYaQ0ousN5dEplkHG1jGquLoLu8jCiFNGn5k3yTJbK4xK/Wv6b0uzb3RLHlRqEWvhyOq+exc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763127772; c=relaxed/simple;
	bh=uN7iPKWgAHcPSmZ45ZHmJ8+VSSPSNzNVjEh4tZ887ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4GqViGYR2/EXxntQFaYeCXSp9yTTB8s7z+vazuOGTJKHeAjv1w/BL54GjcKV0+ZIPjS/jAL0lMNhEc1QRh9ScFTnz5Aw6+GYUOgg/m2oYJXaIFLjhDk+kWaHX+ErADeYAuz6Y2EZrQ6OPOHkI21hZdYzygCOEUjZbUD5BHOX+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=GQTHsMBr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bco0FTAi; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id DFB5D1D00117;
	Fri, 14 Nov 2025 08:42:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 14 Nov 2025 08:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763127768;
	 x=1763214168; bh=7fX2/nqmQOIukIZ2NvWUwmdSP2AbmziSkbTOtAoVc1c=; b=
	GQTHsMBrNyirNTy+QyVWdgpR76TGJ23ROXvZ/WTCMQputFWLoV5wnD5hVYXCljkv
	oGfGlXyKZ/5fT/7Nc8ztsOdSuKlJ24y+TCSbD71VGKhkk/1+ih8aWu/AZaPyxNt9
	pmbJIY9W4ONjquCABD8AKMXNl8g7NNWhnLCugU2+3KBHXx25GmnsGkKhxQnJpFg8
	PSRnv4Ppbm4vgiPjtyDdPBrvpLTKZA59uPjCJS8fQYI5BbrnTL8gHzbA1WLcxh2J
	5LLrD7SKoVVTKbxNoGlLcJCjadS9ZsZpyL9Z011GHv+jZ/hAezP5xX4EyVbmKGNF
	ypFgUOPCzPcDaP2/uhTvKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763127768; x=
	1763214168; bh=7fX2/nqmQOIukIZ2NvWUwmdSP2AbmziSkbTOtAoVc1c=; b=b
	co0FTAi/gWiak/0ZwIZIfwxpIzkO8U9dlqF7Csk3EfIQXO+Vdr7ZJFxxL755jyrz
	TYKcigKXWxXDZdMKF2ewIo/DTBRZbmV7do6JwxtJlCoMr5Yk/YZQd82cLurbLhAh
	R24jds9288ilir5ox/TPAUJ8/BKJb7AZoDVmUaxoikifp4IfPG36zjXad0Ux0Uqa
	lkKuSSquNrlXfdA3UxQ8Rzlt8v/7qgkuhACgY88CPZRGc1VuqSUUnMbko5hb1fEc
	dlj4E6vWBl8EUQwQ7+IV5mMVZYsRn1GgdKNJKT5J3u1VuwKkoR34pU45gdLI1/V+
	U1DodLnitVqZRX+W81ALQ==
X-ME-Sender: <xms:2DEXadKH_GZCJ7lbH3fdXEqSMBXcf1b_xWbsI8DLEGeXDdJwosYRhw>
    <xme:2DEXaZ5PmnNUunOEi3I_y1Eb85LUHADSqHGboXneief0_L2ZPYfoeia5XtPWSTtyc
    SqZ3oKEl_gSDJtP9hS_PfmrT0IMk2mYXxEx-A567112z_v3>
X-ME-Received: <xmr:2DEXaR35E9XaOgfdERdryWqbN8oxs-YiDoHIZ956Lux7MZY0kTgqjaoZARkfCLn73Dx0r0E6TDhJsKjgHA3vThbPbBc3oA8x-fv4R8togs3qny8h72lBL7M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdelleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ekhfegieegteelffegleetjeekuddvhfehjefhheeuiedtheeuhfekueekffehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvih
    hrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghuthhofh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2DEXafeVFYZt1xw7MUPoYSQonUPzwmiJCbMjQB_4Z20EupALS6VSdQ>
    <xmx:2DEXaXfIbuzymYfRR2l10dV3QmQN9wOlHSx3RtYF585IZv-uJrEZWw>
    <xmx:2DEXaawgPh6Rodbmt72gArL4yMXoJQ20imL_VKi6xTxIRgtfh8DiBg>
    <xmx:2DEXaW_fDYfZZvNJT8LAu5EH34QH_3aU9zmUKou6oxdCOQEhtdCUgQ>
    <xmx:2DEXabTnLTVniUb3WayF_O3AeevUXpFVrag4EmIynsdxNarMJL3bbIoc>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 08:42:46 -0500 (EST)
Message-ID: <8b8f9293-a088-4a0d-bc22-35e7cec60f8a@themaw.net>
Date: Fri, 14 Nov 2025 21:42:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] autofs: dont trigger mount if it cant succeed
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
 autofs mailing list <autofs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20251111060439.19593-1-raven@themaw.net>
 <20251111060439.19593-3-raven@themaw.net>
 <20251111-zunahm-endeffekt-c8fb3f90a365@brauner>
 <20251111102435.GW2441659@ZenIV>
 <20251111-ortseinfahrt-lithium-21455428ab30@brauner>
 <bd4fc8ce-ca3f-4e0f-86c0-f9aaa931a066@themaw.net>
 <20251112-kleckern-gebinde-d8dbe0d50e03@brauner>
 <0dfa7fc6-3a15-4adc-ad1d-81bb43f62919@themaw.net>
 <20251113-gechartert-klargemacht-542a0630c88b@brauner>
 <7e040a12-3070-4fad-8b1a-985e71426d41@themaw.net>
 <20251114-rechnen-variieren-aaeb36bb57a0@brauner>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20251114-rechnen-variieren-aaeb36bb57a0@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 14/11/25 19:44, Christian Brauner wrote:
> On Fri, Nov 14, 2025 at 07:49:53AM +0800, Ian Kent wrote:
>> On 13/11/25 21:19, Christian Brauner wrote:
>>> On Thu, Nov 13, 2025 at 08:14:36AM +0800, Ian Kent wrote:
>>>> On 12/11/25 19:01, Christian Brauner wrote:
>>>>> On Tue, Nov 11, 2025 at 08:27:42PM +0800, Ian Kent wrote:
>>>>>> On 11/11/25 18:55, Christian Brauner wrote:
>>>>>>> On Tue, Nov 11, 2025 at 10:24:35AM +0000, Al Viro wrote:
>>>>>>>> On Tue, Nov 11, 2025 at 11:19:59AM +0100, Christian Brauner wrote:
>>>>>>>>
>>>>>>>>>> +	sbi->owner = current->nsproxy->mnt_ns;
>>>>>>>>> ns_ref_get()
>>>>>>>>> Can be called directly on the mount namespace.
>>>>>>>> ... and would leak all mounts in the mount tree, unless I'm missing
>>>>>>>> something subtle.
>>>>>>> Right, I thought you actually wanted to pin it.
>>>>>>> Anyway, you could take a passive reference but I think that's nonsense
>>>>>>> as well. The following should do it:
>>>>>> Right, I'll need to think about this for a little while, I did think
>>>>>>
>>>>>> of using an id for the comparison but I diverged down the wrong path so
>>>>>>
>>>>>> this is a very welcome suggestion. There's still the handling of where
>>>>>>
>>>>>> the daemon goes away (crash or SIGKILL, yes people deliberately do this
>>>>>>
>>>>>> at times, think simulated disaster recovery) which I've missed in this
>>>>> Can you describe the problem in more detail and I'm happy to help you
>>>>> out here. I don't yet understand what the issue is.
>>>> I thought the patch description was ok but I'll certainly try.
>>> I'm sorry, we're talking past each other: I was interested in your
>>> SIGKILL problem when the daemon crashes. You seemed to say that you
>>> needed additional changes for that case. So I'm trying to understand
>>> what the fundamental additional problem is with a crashing daemon that
>>> would require additional changes here.
>> Right, sorry.
>>
>> It's pretty straight forward.
>>
>>
>> If the daemon is shutdown (or killed summarily) and there are busy
>>
>> mounts left mounted then when started again they are "re-connected to"
>>
>> by the newly running daemon. So there's a need to update the mnt_ns_id in
>>
>> the ioctl that is used to set the new pipefd.
>>
>>
>> I can't provide a patch fragment because I didn't realise the id in
>> ns_common
> Before that you can grab it from the mount namespace directly from the
> mntns->seq field.

I'd noticed some of that type of usage, using that will certainly help

with the backports I need to do too but I've started looking at the series

so I'll probably back port it for most recent kernel.


I'll send my current path once I get a kernel built that boots in my

VM ...


Thanks for your help.

Ian


