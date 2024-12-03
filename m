Return-Path: <linux-fsdevel+bounces-36387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73DA9E2F8D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 00:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 784EFB2F323
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 22:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C241E209F38;
	Tue,  3 Dec 2024 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rJ6q74F0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5C1D8E1E
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733265718; cv=none; b=uyvRRp3xJ5knq1ByCvAdqmTL7sihG8+2kiOmUiyv6imnkj1dWmHitPA793eelPdRUfx/OGjUHNBr1qUGdxn2Jhbi6qetCzY9iSaCe0pHMyBcH6bTlwXeGplTYci4wnHR26KNT01LihQA81A9oroawOV0ZKt676JgcapnZcIkQqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733265718; c=relaxed/simple;
	bh=B/liPQIb4IzDwgFk2HZsoN0QEq45CrAM90ifIAL3cls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRMNGqKTNNgB4BIxNMccjyiwhxf41eagB/gRvEsQEoWpkyUmatoyXMNrx3sUpDqHd3Om1Jp8dXvuMXkthl6t/BblqMxhQIaSdaINGkv73orjekdVRUzGE8y26cBkgFsnYAN22jk9k0aU5fXh+NSdq93fknANzPfLRzJQkIGVdj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rJ6q74F0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7258bce5289so264743b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2024 14:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733265715; x=1733870515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYz4wZQ4ozLWoz6WcLIf1w2/FEfERq16Hm/9zLb1izY=;
        b=rJ6q74F0a1GtpeslnPcoTa6X1rlURgz9WJ410a5qU5btiNFQ1bI1tEkf381woZxx5t
         86HTGbkhIvWSxI2xGkaTBrQj/EtD5L4d6cWVv0Ugj9qqqQpMQJeQ1nNIzghXVXI70E5u
         4YvuMGk/oBvuFOEmqwBbP5Z5htteuX9fWOEW73pg6wnc0vm4FpuPP7iuFspTy19R2NAk
         KK/VqAN+1dGwLdxFeNlJWbT0i0/2yMuJbwPWV4l+98yC2Eb1okNNK5iNIeU0uaIbzo7p
         PG8M/fitP0f/NMYFeLy5ekX4jHlNVCOu5tVul6YgiSXLnDmToTDxcWBFABSf+L82AugO
         jjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733265715; x=1733870515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYz4wZQ4ozLWoz6WcLIf1w2/FEfERq16Hm/9zLb1izY=;
        b=D8bAhhCkVv3Ai4A7HpP4IaVkn8e7a4tBOussfEZcW0dwQjaxbo7prN5qgz8bFy4bHH
         ldrKr+4KBSaCxmgDiX3ECp7HMUpl3qEA1X6HGHPttDVqE9vJ8roocXN4NkXvhMOUVKY2
         asaM/LSKSn+USxjc9b/UtyTnDaqD5ms0DPI5UqFH7JXx5JP1P1toMxKIvqnXPPbVB49F
         kcFgFNDUHYNQ2YuEhUl34rR0u31IXJMQm80RHKq2udP1Av50zGfrIrZbIS4EFZH9itnj
         Gbi5YeaKlFvEnb9V2Ku1RWZQnnT/95RWClsDdMRWCvebu+LCDEhMBum49sjE7q9HBRUV
         sBcw==
X-Forwarded-Encrypted: i=1; AJvYcCU1PEJ3UPhQkVfs6tpGJICZR3c0J8+BAqsQ8gisPJ3i7s1fuAFfk2HuYr/RQYs1MznNBzwlTCn04j3gPqyw@vger.kernel.org
X-Gm-Message-State: AOJu0YyOcGLUt7ksHTUMs30H8tymre1WCieDIEl1PDVoo0w9rbOpR74E
	2lPvSSbYSnjKD5MfGWhdLn6HTcXvT9cL/y5j97xJTVVoJD0v3eb0FiVcG7p3Fx0=
X-Gm-Gg: ASbGnctj4ZSeB6qL1UWpi8xXegEGnxuT0LQjLXn4pSoDkjztq1OoZ/UWQtogmRnpSWP
	65tUIGK1/lWpLzRKxvxzJqJAREzYUDslkf23JjKBHDMx6FYs1pgPpZeUsxgEucE1d0Gqw1k+Eq6
	d7fkIm4cH89cKq5o9TvTsir0oXnAnhHdl830RaVTVHwJwSjvYhEPVoCAGVKFe5Ppyxo/ZZn3STx
	+5QT6qoLczHh986/M0tXzHy0pUNELBixVxz4LOrFb7SUHP+/XKdAQ==
X-Google-Smtp-Source: AGHT+IE8Dqnok8jV5g7L3OmAsLx6cL87LuT/Gjx6JQItfNyi0KdCrRDg1xS89T6jOLdCSXuSD9q10w==
X-Received: by 2002:a05:6a00:3a04:b0:724:5815:62c1 with SMTP id d2e1a72fcca58-72587f6c48emr3492918b3a.19.1733265714946;
        Tue, 03 Dec 2024 14:41:54 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:18a::47e? ([2620:10d:c090:600::1:fe53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417616ddsm11083162b3a.13.2024.12.03.14.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 14:41:54 -0800 (PST)
Message-ID: <f70b7fa7-f88e-4692-ad07-c1da4aba9300@kernel.dk>
Date: Tue, 3 Dec 2024 15:41:53 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, bfoster@redhat.com
References: <20241203153232.92224-2-axboe@kernel.dk>
 <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org>
 <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk>
 <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/24 3:16 PM, Christoph Lameter (Ampere) wrote:
> On Tue, 3 Dec 2024, Jens Axboe wrote:
> 
>> I actually did consider using some form of temporal, as it's the only
>> other name I liked. But I do think cached_uncached becomes pretty
>> unwieldy. Which is why I just stuck with uncached. Yes I know it means
>> different things in different circles, but probably mostly an overlap
>> with deeper technical things like that. An honestly almost impossible to
>> avoid overlap these days, everything has been used already :-)
>>
>> IOW, I think uncached is probably still the most descriptive thing out
>> there, even if I'm certainly open to entertaining other names. Just not
>> anything yet that has really resonated with me.
> 
> How about calling this a "transitory" page? It means fleeting, not
> persistent and I think we have not used that term with a page/folio yet.

I also hit the thesaurus ;-)

I'm honestly not too worried about the internal name, as developers can
figure that out. It's more about presenting an external name that sys
developers will not need a lot of explaining to know what it's about.
And something that isn't too long. BRIEFLY_CACHED? TRANSIENT_CACHE?

Dunno, I keep going back to uncached as it's pretty easy to grok!

-- 
Jens Axboe


