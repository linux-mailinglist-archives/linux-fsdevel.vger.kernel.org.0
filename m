Return-Path: <linux-fsdevel+bounces-29052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0022974361
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 21:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11AF1B25A43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 19:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0538C1A4F02;
	Tue, 10 Sep 2024 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="OBuNyM1D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gS//sU+p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11FE12CD96
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995987; cv=none; b=Tj5NLCdMyLyzJLR4JQ3h/6ZO4p2T3yN3NotwWxWt8Lf8Kyq0nkPrkJe8Eh7956nIjthiTy7t9hlDQw87s7d9LabU19zGLpVPldniJ1hGksHDXflukRz4sRPHJ4hlikrmFvuhFVy3mVQ5hadxXPxUTRDGGABOPm344E9zFgS1ypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995987; c=relaxed/simple;
	bh=xuMhYiB4Elt+cCAo6XQBA7mfA0ODN+q7ddAWiPo0M2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIySZxazqw5mhocUOFoK8apSrJfColqN7AOBocxoLk6DnEY5U+2zqC1DBn1n1VqaSYeKKCy6aT8GP9pPM7Owu2FBTbeIdFn8SqfErf/+SyUHnSnpCvJR5e9v4OibNFueGDz0uaPAbbGMOGCwl7etESWQraA+lXDnfgLuhh6IEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=OBuNyM1D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gS//sU+p; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F1FB2114018C;
	Tue, 10 Sep 2024 15:19:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 10 Sep 2024 15:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725995983;
	 x=1726082383; bh=ulyG36uxdIJlu+DJHmlQUhWu6sHbxNCHap6X/K+Qmuw=; b=
	OBuNyM1DCLG/Ny04vNor4AeqyqZPbxXZ0JCkkdkF5jLZyeKou+43QsPUqnF0dDhJ
	3JJww0g1cEmzaicW0eFLb0v0HpLUcBc4QOFlElENfQxkko3SamqJC32bftl5yfzO
	FM+E90rz2XLDsgfym/fiUGkkWVlyglY7NhUEF9XiBx9RhTGIwldVMP1TLFCv3S6M
	s0TZOmrLu8949xFPZyYlWrWbt1C9Ht28uM/P4SgDk09wQ5EjyjlSUhnkqEpS62pQ
	f6Oa2w8J4eXUvItXeOkS85LLP5XXUG5TdDA7ZPlvCBZshSt+Rg7Azl9nlW9GP4d+
	jSPzV476YPXkfikf8P2zIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725995983; x=
	1726082383; bh=ulyG36uxdIJlu+DJHmlQUhWu6sHbxNCHap6X/K+Qmuw=; b=g
	S//sU+pmr39lOuox6Rxl5VS3JJdL8AWThoFBR5W/8zZkM55UF/D5+kmKpcXvgokR
	XxlnyOXLHT4XiTXWgASybhnvLizFKk5OPwhJoJ8RsJg5xXCX37yYV8nfXG3JYxhK
	vZDQd7zgNyMBt5rY0v2TNSpOr7ASuLFRd/qfLB3rUXkVtAgYN7KOSDhclTfBtvyS
	O9/4Ldh/NaFUWLP76FcCZU0X0t0MJ0/PEQFSOIhdpmK1yc9y/SskkmxwvKIWBA9t
	wCjPlOE4S33cPDs4sGHUqh1jc/j0oOcZ7VyXhmGyNs4m5KFtLVj8KtsrntL2EQPV
	DOtYOUj/vtMrbTw0AEifw==
X-ME-Sender: <xms:z5vgZldlWOfUNy7TH380bdneiUKcS5EbPhokFsZyz19CoHMOyX6o4Q>
    <xme:z5vgZjNs2RHgEYAY3zSRP_P6pFIxx9l-iq1x6HA_Sa-Ukio3Odp7SKOMsqyabGqVk
    2xPE_-QQzy-yyVn>
X-ME-Received: <xmr:z5vgZug7LeGd2xQ5Lh1HAsfQR2h6IZruvheFEmpZxFn78pv67L_cDyKqZol_-1jrSROFWSq9U3mqlOa9Cbdh4ym806Fauvco_2r_DL1m6MP90jlfutWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeelfeefleejieej
    feduheelledtgfelheeuteeiteehffejfedvgffhjeefieeiveenucffohhmrghinhepsg
    hoohhtlhhinhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrnhif
    vghnnhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgv
    ughirdhhuh
X-ME-Proxy: <xmx:z5vgZu9d2DJCzl4FPjAN7vNNigfGLZ49IUIy2o8crN9xqDiWi9gmAw>
    <xmx:z5vgZht9HCF_kBUEz4yDgmZcsydZryzNdCP2MlKlWAwdLsCsjxacAg>
    <xmx:z5vgZtEiUvFP3U1KLoSomanGd6pUn55BZ5OGD7vFJgEhXOIxglUR7A>
    <xmx:z5vgZoMqilRvhZC8rAQfdEhPndSpHkYUs-9hs8sDyKS20574DVVzIw>
    <xmx:z5vgZpKxE9ws6_mk67_J1Zsmfh6fwjqbw4ETB3Fu_j7vraee9Xiaarr1>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 15:19:42 -0400 (EDT)
Message-ID: <ca209423-e9d2-4cf2-aef4-219e4ec7e254@fastmail.fm>
Date: Tue, 10 Sep 2024 21:19:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Interrupt on readdirplus?
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
References: <CAOw_e7bqrAkZtUcY=Q6ZSeh_bKo+jyQ=oNfuzKCJpRT=5s-Yqg@mail.gmail.com>
 <5012b62c-79f3-4ec4-af19-ace3f9b340e7@fastmail.fm>
 <CAOw_e7Yd7shq3oup-s3PVVQMyHE7rqFF8JNftnCU5Fyp8S5pYQ@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAOw_e7Yd7shq3oup-s3PVVQMyHE7rqFF8JNftnCU5Fyp8S5pYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/10/24 19:38, Han-Wen Nienhuys wrote:
> On Tue, Sep 10, 2024 at 5:58 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>> I have noticed Go-FUSE test failures of late, that seem to originate
>>> in (changed?) kernel behavior. The problems looks like this:
>>>
>>> 12:54:13.385435 rx 20: OPENDIR n1  p330882
>>> 12:54:13.385514 tx 20:     OK, {Fh 1 }
>>> 12:54:13.385838 rx 22: READDIRPLUS n1 {Fh 1 [0 +4096)  L 0 LARGEFILE}  p330882
>>> 12:54:13.385844 rx 23: INTERRUPT n0 {ix 22}  p0
>>> 12:54:13.386114 tx 22:     OK,  4000b data "\x02\x00\x00\x00\x00\x00\x00\x00"...
>>> 12:54:13.386642 rx 24: READDIRPLUS n1 {Fh 1 [1 +4096)  L 0 LARGEFILE}  p330882
>>> 12:54:13.386849 tx 24:     95=operation not supported
>>>
>>> As you can see, the kernel attempts to interrupt the READDIRPLUS
>>
>> do you where the interrupt comes from? Is your test interrupting
>> interrupting readdir?
> 
> I did not write code to issue interrupts, but it is possible that the
> Go runtime does something behind my back. The debug output lists "p0";
> is there a reason that the INTERRUPT opcode does not provide an
> originating PID ? How would I discover who or what is generating the
> interrupts? Will they show up if I run strace on the test binary?
> 
> I straced the test binary, below is a section where an interrupt
> happens just before a directory seek. Could tgkill(SIGURG) cause an
> interrupt? It happens just before the READDIRPLUS op (',') and the
> INTERRUPT operation ('$') are read.
> 
> [pid 371933] writev(10,
> [{iov_base="\260\17\0\0\0\0\0\0\20\0\0\0\0\0\0\0", iov_len=16},
> {iov_base="\2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\1\0\0\0\0\
> 0\0\0"..., iov_len=4000}], 2 <unfinished ...>
> [pid 371931] <... nanosleep resumed>NULL) = 0
> [pid 371933] <... writev resumed>)      = 4016
> [pid 371931] nanosleep({tv_sec=0, tv_nsec=20000},  <unfinished ...>
> [pid 371933] read(10,  <unfinished ...>
> [pid 371934] <... getdents64 resumed>0xc0002ee000 /* 25 entries */, 8192) = 800
> [pid 371931] <... nanosleep resumed>NULL) = 0
> [pid 371934] futex(0xc000059148, FUTEX_WAKE_PRIVATE, 1 <unfinished ...>
> [pid 371931] getpid( <unfinished ...>
> [pid 371934] <... futex resumed>)       = 1
> [pid 371932] <... futex resumed>)       = 0
> [pid 371931] <... getpid resumed>)      = 371930
> [pid 371934] getdents64(7,  <unfinished ...>
> [pid 371932] futex(0xc000059148, FUTEX_WAIT_PRIVATE, 0, NULL <unfinished ...>
> [pid 371931] tgkill(371930, 371934, SIGURG <unfinished ...>
> [pid 371935] <... read
> resumed>"P\0\0\0,\0\0\0\22\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 131200) = 80
>     # , = readdirplus
> [pid 371933] <... read
> resumed>"0\0\0\0$\0\0\0\23\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 131200) = 48
>     # $ = interrupt.
> [pid 371931] <... tgkill resumed>)      = 0
> [pid 371933] futex(0xc000059148, FUTEX_WAKE_PRIVATE, 1 <unfinished ...>
> [pid 371931] nanosleep({tv_sec=0, tv_nsec=20000},  <unfinished ...>
> [pid 371933] <... futex resumed>)       = 1
> [pid 371932] <... futex resumed>)       = 0
> [pid 371933] write(2, "19:24:40.813294 doInterrupt\n", 28 <unfinished ...>
> 19:24:40.813294 doInterrupt
> 
> A bit of browsing through the Go source code suggests that SIGURG is
> used to preempt long-running goroutines, so it could be issued more or
> less at random.
> 
> Nevertheless, FUSE should also not be reissuing the reads, even if
> there were interrupts, right?
> 
>>> operation, but go-fuse ignores the interrupt and returns 25 entries.
>>> The kernel somehow thinks that only 1 entry was consumed, and issues
>>> the next READDIRPLUS at offset 1. If go-fuse ignores the faulty offset
>>> and continues the listing (ie. continuing with entry 25), the test
>>> passes.
>>>
>>> Is this behavior of the kernel expected or a bug?
>>>
>>> I am redoing the API for directory listing to support cacheable and
>>> seekable directories, and in the new version, this looks like a
>>> directory seek. If the file system does not support seekable
>>> directories, I must return some kind of error (which is the ENOTSUP
>>> you can see in the log above).
>>
>> Is this with or without FOPEN_CACHE_DIR? Would be helpful to know
>> if FOPEN_CACHE_DIR - fuse kernel code is quite different when this
>> is set.
> 
> without FOPEN_CACHE_DIR.

So we should down to this function

https://elixir.bootlin.com/linux/v6.10.9/source/fs/fuse/readdir.c#L286

I still don't understand what is actually the failure in the test, does 
it show entries multiple times (I wouldn't understand how that could 
happen)? From the code, I would expect that you get missing entries if
you ignore the offset.

I'm not sure I ever looked into filldir64 before, but I find it
interesting that a pending signal is only checked when prev_reclen is
set.

https://elixir.bootlin.com/linux/v6.10.9/source/fs/readdir.c#L399

I.e. it accepts the first entry and then fails? parse_dirplusfile()
has to go over the entire list in the buffer, as you have a lookup
count on it. But it shouldn't list these entries - which is why
I'm confused what is the actual issue you are seeing

> 
>>> I started seeing this after upgrading to Fedora 40. My kernel is
>>> 6.10.7-200.fc40.x86_64
>>>
>>
>> Would be interesting to know your kernel version before? There is
>> commit cdf6ac2a03d2, which removes a readdir lock. Although the
>> commit message explains why it is not needed anymore.
> 
> The failure happens in single threaded loads, so a race condition
> seems unlikely.
> 
> Let me try with other kernel versions.
> 
> Also, I realize that Fedora 40 also upgraded the Go compiler, and may
> have made SIGURG be triggered more frequently?
> 


Thanks,
Bernd

