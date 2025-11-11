Return-Path: <linux-fsdevel+bounces-67893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7185FC4CFF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E7842398A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07685338F20;
	Tue, 11 Nov 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="tyhVY50C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OLkIdpU2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD0D20C00C;
	Tue, 11 Nov 2025 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856008; cv=none; b=mHGAa2CX2hZgYcWQ2f9pA4LdMbWqECw+BoGNuxKPkKD67HC1ETVFfEo3P6K0PD2unw3J1LFOfINPgLDdbNv9C22xkA6ljR+DJqIz3xk5oDqI9cvNKRktfmnM20eB01dsZWOU2g7UPi/5lYtmMvPp5WuvIaZk7IkyUPL6cW8kIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856008; c=relaxed/simple;
	bh=b2tb4vNeTxBKP+2qsvprGO/rFMyQOvS1BTTRxCnEB7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKa202izg98X5NJ0GGdMXvNU8oPVKEpg3SLdNnqyMUPuA8dIpOLvdnVuKig5vycGCN73wYXRiSnPZG8twbmwVHRUjxPCEwwlUR2/T7npP9tHwRJ5DzeZ+2GLpN1mIbMj9uh58dDXCKkmzQt8d83OOm7dtI+nA/XZv3PWKzd132U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=tyhVY50C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OLkIdpU2; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A81387A008D;
	Tue, 11 Nov 2025 05:13:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 11 Nov 2025 05:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762856004;
	 x=1762942404; bh=yFaNrcCaUleBOCT1JaSY6Y7k8O9SW4zaCpInBRc85dc=; b=
	tyhVY50CAEq0YcgsAqrAJ5n31hQ5q7fXP+awJxP90fJjO6tovnKyuG4u1pVgylKA
	Svi5UdNCiIW/2yEnseiYdskX+uehSPuntJgotxOyqzjPa2wd5v3djGGllqkzv4+P
	EnEs8vekkI9KBK8lUngfKOLLYTsEzEYN4k6bBXuhrs4hdur04Ba1jvC/IE2qeyaJ
	7wAJFXSwa43kWe2P1eT9fpo0uJxl2PzE3nxTUIeqeuWLDgYDGEDIRG2dmLUQDLRx
	dyq5JwK96vn01yLSEYA8Ngh8KYE4kbo/8/7JLi87RHUKtH5HkZTGL0OGgaAknQ4I
	dZubb/p/mAZun22BB9ygjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762856004; x=
	1762942404; bh=yFaNrcCaUleBOCT1JaSY6Y7k8O9SW4zaCpInBRc85dc=; b=O
	LkIdpU26jDXyIJ2eINKOHLLaev7e5B16iWBCl0o0m32kqpO5hX3YoOG1qMbDw2lp
	fKHCQNn0SWoQKCu0s0u+K1IJyn3q8SOR7rcXeFRDzHQQ1E2PoTj733Rxjd+OaztH
	DsL5fcSSL3oQbRLEAdAVUiNIRPPQ3y9ybunwNg320O4HWkHEKSaNzZmOmf7Joj1T
	8ZOg7TPSKgXEnI6ePufELf4F6xRAuGHwT9feoXHKV1GzfEK2AwEb7PJlr72yr3GX
	XDsZtAMLdxlI2UT/Up29uhNFlFRZkJLWv+f90dbLo5kVqkTf4ANy4UdChCt+Datp
	3tyqaKROtUhEEk+aMJYhg==
X-ME-Sender: <xms:RAwTaaQAKc09Ae_Sb_HxXD7Sesw6EbQkJ9Vy-_od_Uc2lJ2c_kUKaQ>
    <xme:RAwTaZENJuQ4zvbWkUw-Px3qeXBHrdkmSdO8-Gr2bc4PwktE2jGjVZBXFGkFvOoOI
    g9JvOR2kfE6qo1ufTOYpCWsW0VxOJwzxmWWDkSKTU5YJqeX>
X-ME-Received: <xmr:RAwTafHbhfp3peikmVsqQk6JW6C9DARYHYtXrlmrL88gtyEmC_79z7OxnWO3PH44STOkIMV6R4Xcrav8sZuobmkAqkuw7GhgCQ9h5ObYgL_7tv8hOGbPYUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ekhfegieegteelffegleetjeekuddvhfehjefhheeuiedtheeuhfekueekffehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpth
    htohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghuthhofh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RAwTaXRK9T18st2KcQxrPkQCBn6vJgYqTiCcEcAY5_Orc3ERu7i9hQ>
    <xmx:RAwTaQJiTQtU7xVEiR4LRtashujmbVZxva3RDzlcHYO9qjI66_EKvg>
    <xmx:RAwTaSaLpmrhLYnjBb_Eejm8gOPxIBBxW0YQHKuuc62s9XVXesMnZQ>
    <xmx:RAwTaS8_OTDT2X-VZ048macRO1oGHvIZCf5jcCJApGw_ZpX6l5kr6A>
    <xmx:RAwTabMGL_MZVagvnAJgzz9IZBwr0e41OUgfSj4FIe4Ovc0R-S2yd5pw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 05:13:22 -0500 (EST)
Message-ID: <3b7aee07-cf68-4186-b81d-2c4d9e44cc55@themaw.net>
Date: Tue, 11 Nov 2025 18:13:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] autofs: dont trigger mount if it cant succeed
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
 autofs mailing list <autofs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20251111060439.19593-1-raven@themaw.net>
 <20251111060439.19593-3-raven@themaw.net> <20251111065951.GQ2441659@ZenIV>
 <d8040d10-3e2a-44d9-9df2-f275dc050fcd@themaw.net>
 <20251111090416.GR2441659@ZenIV>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20251111090416.GR2441659@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/11/25 17:04, Al Viro wrote:
> On Tue, Nov 11, 2025 at 04:25:29PM +0800, Ian Kent wrote:
>
>>> Huh?  What's to guarantee that superblock won't outlive the namespace?
>> Not 30 minutes after I posted these I was thinking about the case the daemon
>>
>> (that mounted this) going away, very loosely similar I think. Setting the
>>
>> mounting process's namespace when it mounts it is straight forward but what
>>
>> can I do if the process crashes ...
>>
>>
>> I did think that if the namespace is saved away by the process that mounts
>>
>> it that the mount namespace would be valid at least until it umounts it but
>>
>> yes there are a few things that can go wrong ...
> Umm...
>
> 1) super_block != mount; unshare(CLONE_NEWNS) by anyone in the namespace of
> that mount *will* create a clone of that mount, with exact same ->mnt_sb
> and yes, in a separate namespace.
>
> 2) mount does not pin a namespace.  chdir into it, umount -l and there you go...
>
> 3) mount(2) can bloody well create more than one struct mount, all with the
> same ->mnt_sb.
>
> So I'd say there's more than a few things that can go wrong here.
>
> Said that, this "we need a daemon in that namespace" has been a source of
> assorted headaches for decades now; could we do anything about that?
> After all, a thread can switch from one namespace to another these
> days (setns(2))...

Not sure the motivation here is "we need a daemon in that namespace", it's

more my struggling to find a suitable check for the problem case even though

it does look a lot like what you say.


Thinking back the problem has always been the amount of stuff that's not

appropriate for the kernel, automount map parsing is pretty ugly, for 
example.


A better split of duties is probably what we would need to do.


But if we did that then we'd probably want to re-define/re-write the user

space <-> kernel space communications as well to assist with the division

of labour. In the beginning there was a proposal to do just that, not sure

I still have that stuff, I'll have a look around ... or do you have 
something

else specific in mind?


Anyway, for the moment, I think your saying just taking an ns_common 
reference

will be problematic as well.


Ian


