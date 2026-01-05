Return-Path: <linux-fsdevel+bounces-72383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EA5CF2861
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 09:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA21530155F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 08:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99081327C0F;
	Mon,  5 Jan 2026 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="lhyQ+ucO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m3h6PRXf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C0F29E116;
	Mon,  5 Jan 2026 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603039; cv=none; b=AC79CEOl6PDRYRwUt+X16HChDj8x/rFNjYUlW8UwR0U/wBCtQHveeywFVYatOV5Ahx4Rc5ZkD5VX3Eb5+TbCu+0Ti8jEAe9uziIT0DpOyUYwxwnIcUqgW6ygU3IZ0hCA19wDqE8eDiHr0tJE2o/xPC6v/KRUQpuIF6E2yJL5tRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603039; c=relaxed/simple;
	bh=Ptpg09qv7GRqrjY8tM/OFJgRQC86QQDKMY4KAqJ+Odw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xxu1hSHxvM9rHIhxgYXZJH7IAqmTTC4EV/vT4X2f1xcLVByN78cXxdhYZGhHoJw13lbOi1mClY8/mrI+jiTpB6Egz+n9CcXbJsrnbu+v3CeSIBC0lrmmzvyORvZ8Kx/oj4dMyi4SDk5fp/D9RBU7/WQKTP+PDPwmwAJuaRRE79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=lhyQ+ucO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m3h6PRXf; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EEA9D14000E9;
	Mon,  5 Jan 2026 03:50:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 05 Jan 2026 03:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1767603032;
	 x=1767689432; bh=nVVGK9NyA7zAlLY1WGcSPKrv+Cle+vJgog9CAQhl78I=; b=
	lhyQ+ucONyvXgKVuei4qpJF+LfPC/SCVu78ZGxDWdAgog6gSaCxMIjmGUD8WpHe+
	HlGAXQWJi4ByvcfAkT7i1sUo/mMGXH79y56go/iNpJ2Ab5pWVqkauWU9OMtlr1q1
	CWJLalwLVm45P8LhdK8s7U+0Ge2NS2y6fu4W4gqUlOmMpprMXAWZNU5tU8hbqdwU
	QiQh9QOhyZkVZwNpA5FshqiEv9qaLd5ooQXnArtEpbzNUgIXmaHkspqQXQONNFAP
	BRWYgZi7bxkyuZE1TNiTYdDx7KRVhBI35TaxQYSKYYFN1h5DGj7GIaAmOZKVOF0i
	OQZGBcqnIGykmXpT/qx41A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767603032; x=
	1767689432; bh=nVVGK9NyA7zAlLY1WGcSPKrv+Cle+vJgog9CAQhl78I=; b=m
	3h6PRXfXQYvZ8jpsAvJ7jH91zV2JFH9RZQzTA85z65R+PhnK1a9gG95CsbSLsFWB
	vHYLW7mqE82rZ89ifm6gzvDwcXyiM5Wi/ASfLmiSk0K3b0fCfDif0XE6tKNqcQaC
	goVcWYVBEeM8BtLpXKeR8bOU5YgRaiYeUy0sss+pO2UFX7t85XXg+G0YBLKxM2za
	hbRaoASGp4f7KEkblOn4NhhW5qOaqo2vE4M/f1gT36uK0YxDp+hstXEfg1i022hf
	wMmDr79g5V5U/b19xfQzaX8WBmLrDJYg3sP8apw6/OC++TgoesdmZ4XFbygNZU/8
	gsNn5/EE9qYrqCp5HXp6Q==
X-ME-Sender: <xms:WHtbaZYNOzLD8H48B2avuUk-kXfdrysbRAdgQtklm5xf3dtJQXZDjw>
    <xme:WHtbaR63QpHwXI5mSXrotzAaRgOaIMnBMQwngemAVDEqmwK8JrSGDR7Orp_62Wy6-
    _UtALH2J3oWyRy0E-YCAS3k8k0K8C5A7n2F0lwUt7ZgDSnVQ3s>
X-ME-Received: <xmr:WHtbacCoqtJw7A5iyqU_KNEhrHjk_lvXyUIs4c302DwIb1QNMBYlYJiGMETillner110XkTjHlMGbi_f3cXSeIYtokYAAQuUVmObNz35pL-v1IkWCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelieekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepteeigfekgfetgeelvdejieeuheffhfejkeejgfehjeejjeegueduhefgleeg
    vedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnuges
    sghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepthhhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhn
    ihigrdguvgdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:WHtbaXezQhsPS0IwvAnMK5RNnfqyk57oJHq8-0IGZlOdllICwmRs4w>
    <xmx:WHtbabKbkIIK0lEVtpkWK4DnT94r1T8J5zncMe7QpPnh-JCzeViSGg>
    <xmx:WHtbaS14_V47-VRUzs9d3xjdqKPXeFsSmstgeEJ0aa4EU7woEe2dfQ>
    <xmx:WHtbadjzI0Qq_FCWy_st1eWZtzyKmIwHPh1rkZRJm_ORs4Z4TTB5Tw>
    <xmx:WHtbaTViA1LbVJs5OUBTn6jemmMJy3yMqJq0V5UL2ZKPOtmee18wTzVG>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 03:50:31 -0500 (EST)
Message-ID: <51731990-37fe-4821-9feb-7ee75829d3a0@bsbernd.com>
Date: Mon, 5 Jan 2026 09:50:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
 <8efcbf41-7c74-4baf-9d75-1512f4f3fb03@bsbernd.com>
 <b975404f-fd6d-42aa-9743-c11e0088596b@bsbernd.com>
 <20260105092847-f05669a4-f8a1-498d-a8b4-dc1c5a0ac1f8@linutronix.de>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260105092847-f05669a4-f8a1-498d-a8b4-dc1c5a0ac1f8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/5/26 09:40, Thomas Weißschuh wrote:
> On Sat, Jan 03, 2026 at 01:44:49PM +0100, Bernd Schubert wrote:
>>
>>
>> On 1/2/26 23:27, Bernd Schubert wrote:
>>>
>>>
>>> On 12/30/25 13:10, Thomas Weißschuh wrote:
>>>> Using libc types and headers from the UAPI headers is problematic as it
>>>> introduces a dependency on a full C toolchain.
>>>>
>>>> Use the fixed-width integer types provided by the UAPI headers instead.
>>>> To keep compatibility with non-Linux platforms, add a stdint.h fallback.
>>>>
>>>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>>>> ---
>>>> Changes in v2:
>>>> - Fix structure member alignments
>>>> - Keep compatibility with non-Linux platforms
>>>> - Link to v1: https://lore.kernel.org/r/20251222-uapi-fuse-v1-1-85a61b87baa0@linutronix.de
>>>> ---
>>>>  include/uapi/linux/fuse.h | 626 +++++++++++++++++++++++-----------------------
>>>>  1 file changed, 319 insertions(+), 307 deletions(-)
>>>
>>> I tested this and it breaks libfuse compilation
>>>
>>> https://github.com/libfuse/libfuse/pull/1410
>>>
>>> Any chance you could test libfuse compilation for v3? Easiest way is to
>>> copy it to <libfuse>/include/fuse_kernel.h and then create PR. That
>>> includes a BSD test.
> 
> Ack.
> 
>>> libfuse3.so.3.19.0.p/fuse_uring.c.o -c
>>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c
>>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c:197:5: error:
>>> format specifies type 'unsigned long' but the argument has type '__u64'
>>> (aka 'unsigned long long') [-Werror,-Wformat]
>>>   196 |                 fuse_log(FUSE_LOG_DEBUG, "    unique: %" PRIu64
>>> ", result=%d\n",
>>>       |                                                       ~~~~~~~~~
>>>   197 |                          out->unique, ent_in_out->payload_sz);
>>>       |                          ^~~~~~~~~~~
>>> 1 error generated.
>>>
>>>
>>> I can certainly work it around in libfuse by adding a cast, IMHO,
>>> PRIu64 is the right format.
> 
> PRIu64 is indeed the right format for uint64_t. Unfortunately not necessarily
> for __u64. As the vast majority of the UAPI headers to use the UAPI types,
> adding a cast in this case is already necessary for most UAPI users.
> 
>> I think what would work is the attached version. Short interesting part
>>
>> #if defined(__KERNEL__)
>> #include <linux/types.h>
>> typedef __u8	fuse_u8;
>> typedef __u16	fuse_u16;
>> typedef __u32	fuse_u32;
>> typedef __u64	fuse_u64;
>> typedef __s8	fuse_s8;
>> typedef __s16	fuse_s16;
>> typedef __s32	fuse_s32;
>> typedef __s64	fuse_s64;
>> #else
>> #include <stdint.h>
>> typedef uint8_t		fuse_u8;
>> typedef uint16_t	fuse_u16;
>> typedef uint32_t	fuse_u32;
>> typedef uint64_t	fuse_u64;
>> typedef int8_t		fuse_s8;
>> typedef int16_t		fuse_s16;
>> typedef int32_t		fuse_s32;
>> typedef int64_t		fuse_s64;
>> #endif
> 
> Unfortunately this is equivalent to the status quo.
> It contains a dependency on the libc header stdint.h when used from userspace.
> 
> IMO the best way forward is to use the v2 patch and add a cast in fuse_uring.c.

libfuse is easy, but libfuse is just one library that might use/copy the
header. If libfuse breaks the others might as well.
Maybe you could explain your issue more detailed? I.e. how are you using
this include exactly?


Thanks,
Bernd

