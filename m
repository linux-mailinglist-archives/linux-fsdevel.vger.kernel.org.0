Return-Path: <linux-fsdevel+bounces-73040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8D6D08B3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 11:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F64630D32BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 10:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C18933A9F6;
	Fri,  9 Jan 2026 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="AmNU3Cch";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N9T5BOz8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D299033A717;
	Fri,  9 Jan 2026 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955541; cv=none; b=Dk7ERWh1/wu5O7Hco4/WKEhC7cWj9Swzw4tEUKIlE2MbCfIpqcgYIjcF23ZOUOyTWtfamJKMRoCr9KxcpVrHysux1vGwr9G+bleMABIIARXCuUQ5jrUwbRCLSlDF6g3Ee9NxcrMIJFxSEtkejq1Sovqbuizn6qfJKICmyn9j5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955541; c=relaxed/simple;
	bh=crtQGlPYSKaVYNPlIMaMeHxFjwYUJR00tiBNRplY4b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPygW/laJZ0Mn+ePA/EE3Nhs5Zgfu08n5SbRlyYEHAoRSzcGqEaxDQPiDHnQua0t1w5WBlA/UApTLQlKOUb2+jn2IqrTfo2z5FCwMBFCw+ZwQGXdRW+z5wHspRsS5x5KsHN4qj0DsaJ/+R2rGGEZqeCn3hInnJw6uEhkjMXyrik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=AmNU3Cch; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N9T5BOz8; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A4077A00FF;
	Fri,  9 Jan 2026 05:45:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Jan 2026 05:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767955536;
	 x=1768041936; bh=q7HpZ71gH5LZVV1HCkESJTUxYkqZoc6bt+gn6Od4/Hc=; b=
	AmNU3CchaIWpBga1f7kXqFSkUi+O56N0VxUZnWaub/aGgaRGSC57u9+4x6pAfp+S
	/IwrOZ55f7HX9TxC/ZslilEc/4aCf6ZENRhAxgK9GVqm/xJ+1J7xqgSn+sGIEC2j
	bVNP1HJdNTYBzCTP2nDhNQuvdkg/Cmf2jTVsOG3GjGice7O9dBSr8TEBOdTIflTW
	+kqJaTKqtqDzTXLz4C/QZh5ZsEMe9iy6gZGAwfX9Z4Z+ZwSRrK3xtpTqS7xsXiKA
	QoRS85O8kIk2iszjs9KUn7e+uLS5kvjFQRbv+QjxQ4Ptl/nOSOzNN1IHkXpQ6+DY
	7Y2tWvzjhQ41uLSX1UOvoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767955536; x=
	1768041936; bh=q7HpZ71gH5LZVV1HCkESJTUxYkqZoc6bt+gn6Od4/Hc=; b=N
	9T5BOz8mke0cUKPNhUL/jFDV5z+Ig8cfkk/T8ZKCFbsEDH49/xy/9BF1TW6uc7XE
	PWxabylp4G3VphTm8TGzApKYfS4yqrFQz3JWqqeWaFXauTUYVWbOkXkYMKsdKLCr
	Kb8vQtkZAeuHkiKmR0uob+VpmtbtB7/mbGKvyfenb4o2vq2ieZbLO76JrclvdIYt
	Wx/T9iG79bQf+lSCtUa74oUcxOSpdGz3l0bcAlamNHKF0r7zlT1Uj/MDCHfbL9On
	LEJ7d/w+2U+oDAKGtFkzinejQggzyK3/fv7l64o9/PZoRKfcUXJiBkxv0sfunMou
	NEnXn4TFR5KDGc99Mb40g==
X-ME-Sender: <xms:UNxgaZ-1norToejwzS6pLydq1Ks3WN2Wkg6KkSpXkRgyh0MGbCmd2A>
    <xme:UNxgaXCeQdFXJ_NizCI9jWQp5m8R7oM1Oh1aSPr9w_sf0dm2txDteCZR0l8qPRD_l
    8XPoLbjWd2h93l5msnlIuMVLA6wzqRm4KIHc8N4w_yB_4_PGic3>
X-ME-Received: <xmr:UNxgaeTk_qJ2YXq1zLbjGR2KRF2dkuunFdWHrqn-Dtx9gQbm7L6IHhMXXhO42V3i4wvVJoi31RukIG4nVWxQyrEGZVbzJnme34l3cC0LOe3PvLcRMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeejffdutdeghfffgffgjeehteejueekieetieehveehteeuiefgieeuleek
    jeekueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    grvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    thhhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhnihigrdguvgdprhgtph
    htthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohepmhhikhhlohhssehsiigv
    rhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UNxgaetrjLHJ9dkIuhE4kqinhZW2PBac-4H7OQvac2IpPhmWrF1QsQ>
    <xmx:UNxgaa2LaxaWMZpEKdp7jr3rGRqkV9CNZN-HhGgAzzMOYNo92RSADA>
    <xmx:UNxgafXqkfNfjWMxzAw2wGv8sjN37dG3BNd84ztKrNsyYYzvlWB-fQ>
    <xmx:UNxgaVIEWck65Q9RVcM6MGlEVYaecuN-vNWcSVxjqSQGBdelzlBKSA>
    <xmx:UNxgaa5683jIsqTY8lj4Z9kHykoACob58binwx1gLjSeAY5XDE-FDdqy>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 05:45:35 -0500 (EST)
Message-ID: <ccdbf9b8-68d1-4af6-9ed4-f2259d1cecb4@bsbernd.com>
Date: Fri, 9 Jan 2026 11:45:33 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
To: David Laight <david.laight.linux@gmail.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
 <8efcbf41-7c74-4baf-9d75-1512f4f3fb03@bsbernd.com>
 <b975404f-fd6d-42aa-9743-c11e0088596b@bsbernd.com>
 <20260105092847-f05669a4-f8a1-498d-a8b4-dc1c5a0ac1f8@linutronix.de>
 <51731990-37fe-4821-9feb-7ee75829d3a0@bsbernd.com>
 <2c1dc014-e5aa-4c1d-a301-e10f47c74c7d@app.fastmail.com>
 <e22544a1-dea4-44d0-9a72-b60d38eeac19@bsbernd.com>
 <20260109085917-e316ce57-5e78-4827-96d7-4a48a68aa752@linutronix.de>
 <20260109103827.1dc704f2@pumpkin>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260109103827.1dc704f2@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/9/26 11:38, David Laight wrote:
> On Fri, 9 Jan 2026 09:11:28 +0100
> Thomas Weißschuh <thomas.weissschuh@linutronix.de> wrote:
> 
>> On Thu, Jan 08, 2026 at 11:12:29PM +0100, Bernd Schubert wrote:
>>>
>>>
>>> On 1/5/26 13:09, Arnd Bergmann wrote:  
>>>> On Mon, Jan 5, 2026, at 09:50, Bernd Schubert wrote:  
> ...
>>>> I don't think we'll find a solution that won't break somewhere,
>>>> and using the kernel-internal types at least makes it consistent
>>>> with the rest of the kernel headers.
>>>>
>>>> If we can rely on compiling with a modern compiler (any version of
>>>> clang, or gcc-4.5+), it predefines a __UINT64_TYPE__ macro that
>>>> could be used for custom typedef:
>>>>
>>>> #ifdef __UINT64_TYPE__
>>>> typedef __UINT64_TYPE__		fuse_u64;
>>>> typedef __INT64_TYPE__		fuse_s64;
>>>> typedef __UINT32_TYPE__		fuse_u32;
>>>> typedef __INT32_TYPE__		fuse_s32;
>>>> ...
>>>> #else
>>>> #include <stdint.h>
>>>> typedef uint64_t		fuse_u64;
>>>> typedef int64_t			fuse_s64;
>>>> typedef uint32_t		fuse_u32;
>>>> typedef int32_t			fuse_s32;
>>>> ...
>>>> #endif  
>>>
>>> I personally like this version.  
>>
>> Ack, I'll use this. Although I am not sure why uint64_t and __UINT64_TYPE__
>> should be guaranteed to be identical.
> 
> Indeed, on 64bit the 64bit types could be 'long' or 'long long'.
> You've still got the problem of the correct printf format specifier.
> On 32bit the 32bit types could be 'int' or 'long'.
> 
> stdint.h 'solves' the printf issue with the (horrid) PRIu64 defines.
> But I don't know how you find out what gcc's format checking uses.
> So you might have to cast all the values to underlying C types in
> order pass the printf format checks.
> At which point you might as well have:
> typedef unsigned int fuse_u32;
> typedef unsigned long long fuse_u64;
> _Static_assert(sizeof (fuse_u32) == 4 && sizeof (fuse_u64) == 8);
> And then use %x and %llx in the format strings.


The test PR from Thomas succeeds in compilation and build testing. Which
includes 32-bit cross compilation

https://github.com/libfuse/libfuse/pull/1417

Checkpatch complains a bit, but I would ignore that - I had mostly only
added checkpatch to ensure people are submitting with the right
formatting (lots of commits with spaces, but the project follows kernel
style).


Thanks,
Bernd1

