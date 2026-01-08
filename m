Return-Path: <linux-fsdevel+bounces-72952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C13D06687
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 23:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 866473010576
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 22:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45688311C38;
	Thu,  8 Jan 2026 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="d+9yP513";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VQR9qazy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5192D63F6;
	Thu,  8 Jan 2026 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767910353; cv=none; b=j1amE4aFGC0t4e6KR5pgQzD4AulOPQtjLUQ1DPoIBaU3TWzHdJMwYTIZXoRoPSkQfIlSM2xeGFgCpYT4z6BkfcocrnVnmibNvbuUi1hQWZ2pfpWIN1q0jD3LOmpWJO4PH9ycT3BmI5eujXjqOzSsWiTtwwVHv7EmWSlrr7DfZrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767910353; c=relaxed/simple;
	bh=rY7d6+bH4SV2BRhspJhNJmviM6SrzTxsfVnv3GUb9+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdL4vLy6LvlfLpr+1fPevfmrevC4pIuq6x/XW4gtPKtXT6P4536TsHppzLcM2QfT+iwLROtXXH3aUiUh4LZsXKCI7dZiU8lD9IcKTkOCkVucAWWZjbFWnOQkyLr+ANN5b+8+VJUHpCNsJNYH1Gt47B8+W+y2ss5BuW9Kj5Le0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=d+9yP513; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VQR9qazy; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7E0661400046;
	Thu,  8 Jan 2026 17:12:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 08 Jan 2026 17:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767910351;
	 x=1767996751; bh=9MvSdeaIYXQW5v2iFRkT6Y0Ik1RUmSFz6nbVqr/IMWY=; b=
	d+9yP513pgNdlPRunSu8pP2UwKT5rZx5FlQ9Z65GWuxaGR0+jdqhV1kNs6wtdeue
	lqDZm7gN4lcj4d8TwxuPu9+9W77uEjNYVrBuaKxRroerNg2aHnGTLKfNPv10lgmy
	4rEw3W3BzQa8HcN1y4eOKdQxkkyolvTMpknsMkX6DTUlTCl/btCK/K3ypD7fUskA
	ixoBgz8B2R7eBAYYNEAWLgiIXbZedQv6jocHgr1+8NaxW+wRjZ0UvxJa4ZXa+3Cr
	Kjb9CdSbVnn9Iz/ooO1Ophl9p98HhjK7WN3y7Yc0+GY8ZzEqfhsOnDfzDMTZMl8f
	CIjz/fT26AQcale3933pWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767910351; x=
	1767996751; bh=9MvSdeaIYXQW5v2iFRkT6Y0Ik1RUmSFz6nbVqr/IMWY=; b=V
	QR9qazy5q3JI+Bf8F7SQY6jUr5McIWeLqcm/IoSDgPZcdTv699Yye2AVJjRWoN76
	L00NiovVsM8LHLiE/wv7ZFjWrQH7m3ygufhx72aKuCgomhHiF3a1AZ+XttBSJxfN
	Bn/IiyoxofaLClOEXTicaGacMXtEQVKqkYBKScP+BWgwLS7S0gViZ8DhBymmhc1J
	JoqbHNST9R8tSsc3wGeHCw3KhdOA9E34TbjWxF/u6AAhrgQPVGFfoDeuXKKf9TEB
	MjTqWklPFdaiJzBEpB/+OL1FxFNlb/fNzkWJcmwJb60b7WHn5GdGY90FOrq8ILWl
	H4+VFUPUwDu9ATqqG5eUg==
X-ME-Sender: <xms:zytgaT6RfUHlRAnQmabR7eH4O5w99flZUm_SU0Aj81WuH6AU8CXdPg>
    <xme:zytgaaa1veE5eCyYI79DNBRIqP_rRkLCyHhZnZjOsoEfsf2UzlG4Vzak4MLyBJZ0R
    YO8ThGvQFbNziu4m5vJwPmPT_j1wG8y07gomcfnVOm4G64xKrs>
X-ME-Received: <xmr:zytgaag4Fy0-7uSpVjk2FOct7A1EDT4wceFNa5Q8YZ-ubeDuTAMXovmLMAaw2GuEJbJ4Bn5zRPB6hrdLgktKVgHd9PPKRiHxhrBfuQI5EjZOrrav3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdejuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtoh
    epthhhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhnihigrdguvgdprhgt
    phhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugi
    dqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zytgaT9ppv75uJmX2eRQe_PtRKMLpLJPeIyvaOxC0ious3hNR0508g>
    <xmx:zytgadqxtu3t4EEIlGtI9vdo3hKoW-Qdith63Uu58cByoNerLZjSUQ>
    <xmx:zytgaTXX_FJzxhA2TFSzcoHY82tqm2oIr9NmqPQrkEZQxpTZbRajtA>
    <xmx:zytgaUCaoCIgRVEHcS-SchF_5bLR6Wt1_9GilArtgp4dKbqjfDj0Lw>
    <xmx:zytgaT30x28wKVB7vo_9WONIVfqyXJeYlOtIcHjbAKOAfOQRGFxpm1jH>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 17:12:30 -0500 (EST)
Message-ID: <e22544a1-dea4-44d0-9a72-b60d38eeac19@bsbernd.com>
Date: Thu, 8 Jan 2026 23:12:29 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
To: Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
 <8efcbf41-7c74-4baf-9d75-1512f4f3fb03@bsbernd.com>
 <b975404f-fd6d-42aa-9743-c11e0088596b@bsbernd.com>
 <20260105092847-f05669a4-f8a1-498d-a8b4-dc1c5a0ac1f8@linutronix.de>
 <51731990-37fe-4821-9feb-7ee75829d3a0@bsbernd.com>
 <2c1dc014-e5aa-4c1d-a301-e10f47c74c7d@app.fastmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <2c1dc014-e5aa-4c1d-a301-e10f47c74c7d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/5/26 13:09, Arnd Bergmann wrote:
> On Mon, Jan 5, 2026, at 09:50, Bernd Schubert wrote:
>> On 1/5/26 09:40, Thomas Weißschuh wrote:
>>> On Sat, Jan 03, 2026 at 01:44:49PM +0100, Bernd Schubert wrote:
>>>
>>>>> libfuse3.so.3.19.0.p/fuse_uring.c.o -c
>>>>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c
>>>>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c:197:5: error:
>>>>> format specifies type 'unsigned long' but the argument has type '__u64'
>>>>> (aka 'unsigned long long') [-Werror,-Wformat]
>>>>>   196 |                 fuse_log(FUSE_LOG_DEBUG, "    unique: %" PRIu64
>>>>> ", result=%d\n",
>>>>>       |                                                       ~~~~~~~~~
>>>>>   197 |                          out->unique, ent_in_out->payload_sz);
>>>>>       |                          ^~~~~~~~~~~
>>>>> 1 error generated.
>>>>>
>>>>>
>>>>> I can certainly work it around in libfuse by adding a cast, IMHO,
>>>>> PRIu64 is the right format.
>>>
>>> PRIu64 is indeed the right format for uint64_t. Unfortunately not necessarily
>>> for __u64. As the vast majority of the UAPI headers to use the UAPI types,
>>> adding a cast in this case is already necessary for most UAPI users.
> 
> Which target did the warning show up on? I would expect the patch
> to not have changed anything for BSD, since not defining __linux__
> makes it use the stdint types after all.
> 
> On alpha/mips/powerpc, the default is to use 'unsigned long' unless
> the __SANE_USERSPACE_TYPES__ macro is defined before linux/types.h
> gets included, and we may be able to do the same on other
> architectures as well for consistency. All the other 64-bit
> architectures (x86-64, arm64, riscv64, s390x, parisc64, sparc64)
> only provide the ll64 types from uapi but seem to use the l64
> version both in gcc's predefined types and in glibc.
> 
>>>> I think what would work is the attached version. Short interesting part
>>>>
>>>> #if defined(__KERNEL__)
>>>> #include <linux/types.h>
>>>> typedef __u8	fuse_u8;
>>>> typedef __u16	fuse_u16;
>>>> typedef __u32	fuse_u32;
>>>> typedef __u64	fuse_u64;
>>>> typedef __s8	fuse_s8;
>>>> typedef __s16	fuse_s16;
>>>> typedef __s32	fuse_s32;
>>>> typedef __s64	fuse_s64;
>>>> #else
>>>> #include <stdint.h>
>>>> typedef uint8_t		fuse_u8;
>>>> typedef uint16_t	fuse_u16;
>>>> typedef uint32_t	fuse_u32;
>>>> typedef uint64_t	fuse_u64;
>>>> typedef int8_t		fuse_s8;
>>>> typedef int16_t		fuse_s16;
>>>> typedef int32_t		fuse_s32;
>>>> typedef int64_t		fuse_s64;
>>>> #endif
>>>
>>> Unfortunately this is equivalent to the status quo.
>>> It contains a dependency on the libc header stdint.h when used from userspace.
>>>
>>> IMO the best way forward is to use the v2 patch and add a cast in fuse_uring.c.
>>
>> libfuse is easy, but libfuse is just one library that might use/copy the
>> header. If libfuse breaks the others might as well.
> 
> I don't think we'll find a solution that won't break somewhere,
> and using the kernel-internal types at least makes it consistent
> with the rest of the kernel headers.
> 
> If we can rely on compiling with a modern compiler (any version of
> clang, or gcc-4.5+), it predefines a __UINT64_TYPE__ macro that
> could be used for custom typedef:
> 
> #ifdef __UINT64_TYPE__
> typedef __UINT64_TYPE__		fuse_u64;
> typedef __INT64_TYPE__		fuse_s64;
> typedef __UINT32_TYPE__		fuse_u32;
> typedef __INT32_TYPE__		fuse_s32;
> ...
> #else
> #include <stdint.h>
> typedef uint64_t		fuse_u64;
> typedef int64_t			fuse_s64;
> typedef uint32_t		fuse_u32;
> typedef int32_t			fuse_s32;
> ...
> #endif

I personally like this version.

> 
> The #else side could perhaps be left out here.

Maybe we should keep it for safety? Less for kernel, but more for
userspace- we don't know in which environments/libs the header is used.

> 
>> Maybe you could explain your issue more detailed? I.e. how are you using
>> this include exactly?
> 
> I'm interested specifically in two aspects:
> 
> - being able to build-test all kernel headers for continuous
>   integration testing, without having to have access to libc
>   headers for each target architecture when cross compiling.
> 
> - layering kernel headers such that kernel headers never depend
>   on libc headers and (in a later stage) any kernel header
>   can be included without clashing with libc definitions. 

Thank you, I think it would good to add these details to the commit message.

Thanks,
Bernd

