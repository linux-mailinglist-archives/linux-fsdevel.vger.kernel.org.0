Return-Path: <linux-fsdevel+bounces-72387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E55CF374B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 13:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E40AD3029C7A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 12:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C163330D43;
	Mon,  5 Jan 2026 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ra8OZUWj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IEvlATx9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610D92D97BF;
	Mon,  5 Jan 2026 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615007; cv=none; b=i6lBhWL/f4lOM3MRlrqNBm1TGx2cyoCQUuqgMD/YA3r8jnYVCgPsspnyEZUmJjy4J4yNjcpKSvOwdHveXw0rRY1iUqbtVzzz2SlYZCxkXaOuI80UO52Xy3NMXR2EOaPUysn9ncYWMB2BKw3vmmYmNQVrGXZKAUXftd3qJxJEBc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615007; c=relaxed/simple;
	bh=Ua7jqGnAV3hCGmm6gLcbdjKMuI/TOhkiIfupTFTTYTk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iMQ4YgTHJa99uhpuR2CB6GiBsX1RnFPxJIF04gDktEQYPGCpUMObHEd5ePIk0F6HB7cSXqYYf+AUm2vCWiLiKNTJmDJXWXEwVe5z53lRG7udHT/oxYNNHYib5IZcKfhS9OgWnkFAy5Pksdo//0gq0k2J0TrY3WtisirhKzJwWsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ra8OZUWj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IEvlATx9; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B3DF1D0011B;
	Mon,  5 Jan 2026 07:10:02 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 05 Jan 2026 07:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767615002;
	 x=1767701402; bh=VUlH5Fd3eshrGa0/+tBGxBPcY8Gy5T6ObBQTLNQL7/8=; b=
	ra8OZUWjdIhEwfgBPPWvalA0/3oz8jFbGm7SaeGGzUI3jZokPWFMPryrXqKp6Q1Q
	SBOM6XGO9vf7kdj3G1S63TqmjHZucqEv6trdPgV3x7ziueqqAo3f5xkEOOl70sR/
	LVvldbyewBsPLja7uzHsp8c0H8eThzdJiUdT261/SvBpEvLlVvFuVomJqmpjJqHJ
	MLYhfWGnAUdkQjsqnIW7AWdvW/uHgRH5MBEhXuy5DuGVog/gryWjomtEIf8HMeML
	6tEYrf9KTc+lu6+n4R7a1rr2RpP4ihbhSOSkgAqN2fBh/7sqRsJnydt9mzj3OF6S
	8sSFbCRAvwhxSZHR+q2hrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767615002; x=
	1767701402; bh=VUlH5Fd3eshrGa0/+tBGxBPcY8Gy5T6ObBQTLNQL7/8=; b=I
	EvlATx9AZ8bLoKgegHj9/oTQr8Xd92wlTrJ2ntaexX56OzEVILIvS2KZCmVoKNA1
	NCQLgrxFZl/UjP2l9ZcsrgW1B2vzv7uY2Y9fQQo5oNOy88jyqhnqseIsModTpaXB
	tVHBMst07HwMdBiQw/YIk0jLpGaet2BtrrVjT48OqNxpmdvM8AwjMt2eFkdKXdC7
	2PLWLokyMPXCzUmfMezre4NlMlcKeymK1s9wjt/1Cu/EfqsTqnB1X9BOuYBjrFaZ
	wewbr9yl9qJm66zwJZ7eb0hoCqA68MDhMQ3BvM7Qp4+Lc/1yk8ao43/WkRoORygb
	f0y4blN+u6NAGiuTB6SDw==
X-ME-Sender: <xms:GapbaVSeCkT0QTDdIlFem5mMBGZDZoRxp-9gyx397F0sV6eIOIOhFg>
    <xme:GapbaZm1wysIey68DOLnx7rUtVknv7cCrjuYYKn14IuizXBonTb1t3n8pNs_lIYoc
    b5CokYGuAv0iVBkqyfwN1VrbiOunIu3AdnlkqP37otTXmQDJpefJzI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegsvghrnhgusegsshgsvghrnhgurdgtohhmpdhrtghpthhtohepthhhoh
    hmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhnihigrdguvgdprhgtphhtthho
    pehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsug
    gvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GapbaQdr8SbZjKiXqvNQRQC2i_dGuC58LjuFgAGhuR5Ve3rRbee5nQ>
    <xmx:GapbabI1YzuH5CbuG8iNDqywMbSxzbomOI6H1xx0dn0g5I9bxt5ZPA>
    <xmx:GapbadEQzZ2fw5uR-zptL-raRfkaC7V7j3saBgZwB2msaePSDSCYcw>
    <xmx:GapbaWAwiSPqUtyy9vGMCxgct01HZ7KrEeYkwGOHfPExHpIJ8Y-W5Q>
    <xmx:GqpbaRoZJ8pVsBmJ4J9ziEe4J_p8y5XP1qZAR0XqeGSNlaFd1oO1bDyb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6856F700065; Mon,  5 Jan 2026 07:10:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APoYDRVQ8Zf-
Date: Mon, 05 Jan 2026 13:09:09 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bernd Schubert" <bernd@bsbernd.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <2c1dc014-e5aa-4c1d-a301-e10f47c74c7d@app.fastmail.com>
In-Reply-To: <51731990-37fe-4821-9feb-7ee75829d3a0@bsbernd.com>
References: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
 <8efcbf41-7c74-4baf-9d75-1512f4f3fb03@bsbernd.com>
 <b975404f-fd6d-42aa-9743-c11e0088596b@bsbernd.com>
 <20260105092847-f05669a4-f8a1-498d-a8b4-dc1c5a0ac1f8@linutronix.de>
 <51731990-37fe-4821-9feb-7ee75829d3a0@bsbernd.com>
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026, at 09:50, Bernd Schubert wrote:
> On 1/5/26 09:40, Thomas Wei=C3=9Fschuh wrote:
>> On Sat, Jan 03, 2026 at 01:44:49PM +0100, Bernd Schubert wrote:
>>=20
>>>> libfuse3.so.3.19.0.p/fuse_uring.c.o -c
>>>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c
>>>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c:197:5: e=
rror:
>>>> format specifies type 'unsigned long' but the argument has type '__=
u64'
>>>> (aka 'unsigned long long') [-Werror,-Wformat]
>>>>   196 |                 fuse_log(FUSE_LOG_DEBUG, "    unique: %" PR=
Iu64
>>>> ", result=3D%d\n",
>>>>       |                                                       ~~~~~=
~~~~
>>>>   197 |                          out->unique, ent_in_out->payload_s=
z);
>>>>       |                          ^~~~~~~~~~~
>>>> 1 error generated.
>>>>
>>>>
>>>> I can certainly work it around in libfuse by adding a cast, IMHO,
>>>> PRIu64 is the right format.
>>=20
>> PRIu64 is indeed the right format for uint64_t. Unfortunately not nec=
essarily
>> for __u64. As the vast majority of the UAPI headers to use the UAPI t=
ypes,
>> adding a cast in this case is already necessary for most UAPI users.

Which target did the warning show up on? I would expect the patch
to not have changed anything for BSD, since not defining __linux__
makes it use the stdint types after all.

On alpha/mips/powerpc, the default is to use 'unsigned long' unless
the __SANE_USERSPACE_TYPES__ macro is defined before linux/types.h
gets included, and we may be able to do the same on other
architectures as well for consistency. All the other 64-bit
architectures (x86-64, arm64, riscv64, s390x, parisc64, sparc64)
only provide the ll64 types from uapi but seem to use the l64
version both in gcc's predefined types and in glibc.

>>> I think what would work is the attached version. Short interesting p=
art
>>>
>>> #if defined(__KERNEL__)
>>> #include <linux/types.h>
>>> typedef __u8	fuse_u8;
>>> typedef __u16	fuse_u16;
>>> typedef __u32	fuse_u32;
>>> typedef __u64	fuse_u64;
>>> typedef __s8	fuse_s8;
>>> typedef __s16	fuse_s16;
>>> typedef __s32	fuse_s32;
>>> typedef __s64	fuse_s64;
>>> #else
>>> #include <stdint.h>
>>> typedef uint8_t		fuse_u8;
>>> typedef uint16_t	fuse_u16;
>>> typedef uint32_t	fuse_u32;
>>> typedef uint64_t	fuse_u64;
>>> typedef int8_t		fuse_s8;
>>> typedef int16_t		fuse_s16;
>>> typedef int32_t		fuse_s32;
>>> typedef int64_t		fuse_s64;
>>> #endif
>>=20
>> Unfortunately this is equivalent to the status quo.
>> It contains a dependency on the libc header stdint.h when used from u=
serspace.
>>=20
>> IMO the best way forward is to use the v2 patch and add a cast in fus=
e_uring.c.
>
> libfuse is easy, but libfuse is just one library that might use/copy t=
he
> header. If libfuse breaks the others might as well.

I don't think we'll find a solution that won't break somewhere,
and using the kernel-internal types at least makes it consistent
with the rest of the kernel headers.

If we can rely on compiling with a modern compiler (any version of
clang, or gcc-4.5+), it predefines a __UINT64_TYPE__ macro that
could be used for custom typedef:

#ifdef __UINT64_TYPE__
typedef __UINT64_TYPE__		fuse_u64;
typedef __INT64_TYPE__		fuse_s64;
typedef __UINT32_TYPE__		fuse_u32;
typedef __INT32_TYPE__		fuse_s32;
...
#else
#include <stdint.h>
typedef uint64_t		fuse_u64;
typedef int64_t			fuse_s64;
typedef uint32_t		fuse_u32;
typedef int32_t			fuse_s32;
...
#endif

The #else side could perhaps be left out here.

> Maybe you could explain your issue more detailed? I.e. how are you usi=
ng
> this include exactly?

I'm interested specifically in two aspects:

- being able to build-test all kernel headers for continuous
  integration testing, without having to have access to libc
  headers for each target architecture when cross compiling.

- layering kernel headers such that kernel headers never depend
  on libc headers and (in a later stage) any kernel header
  can be included without clashing with libc definitions.=20

      Arnd

