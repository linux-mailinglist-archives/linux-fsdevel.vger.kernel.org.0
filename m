Return-Path: <linux-fsdevel+bounces-29678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 384AD97C332
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 05:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94084283A3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 03:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BB21B7FD;
	Thu, 19 Sep 2024 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IHzOdL0z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ACF11711
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 03:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726717131; cv=none; b=NrJVKBjdpuk5W4WlLqRzU0aoLWDVKSDy+2Zi74oqXjCuhgSMJszk2xFy0f9q4Bid0aaTK+sEvkQs+WaeuiaS6SGWOmlfW8trZPAxbLrbJ3/8k9dsWQTH1LWPTKu/LlIg8UbbRYex3p2Wo24IyFFUEUWHVHkL2s7Zi6jYzTYcKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726717131; c=relaxed/simple;
	bh=LoMi13A4AfE43GdKZNtf5scV3hXW2dBvlxD8UDU1VWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMo6JmJUakbHcm8nHanY7ni830UzUUqoJga/FRSsmg9TVzwynT8FcFzTE7NKUYfmYS4NTh29lAYlsPbWhoWOJAPmmFpcant2wvCf6lvVvvanqGN0C61HEhAZ0Kf2yvhAlhXbz3biWrVGTwwHAgisPtUZTkiXbzbVLYDxpPGQCOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IHzOdL0z; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so2238173a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 20:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726717126; x=1727321926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ip2Z9ZN8QnSQEWnaDGGUtbvLzJ9Kl1C8B/3QvjgaEU=;
        b=IHzOdL0ziPLBBqO2t+zRmtnE/yrtmkqD9LiWh0z93E+ZUW17YSGzOaMpm1ii+zzkfY
         dj1wMECQjOXkIm7nswPVJ55vS11ASWcAL0jzRGULO47JXgVSzbdUNVo6i9cdVxKLKAhI
         9DCJToJG0LbKVlDjId8sayrJ142cbV1YnwlI8kHgl2J8EPcSs2lM7IZMI6+zJYG9jfOr
         3UrR/EieI+O/3m0Hh+28ewlPaYKTomHdmUHHQlbdOEUUypBlzYXAz90IBlX99rnvzOtn
         dY8g4SXKmgNKkXhvuz7H/vg6W7WGoIFXIE0pPoeYHI6XsADDLLWYMjeBEbJ9nLUiPk7b
         wmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726717126; x=1727321926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ip2Z9ZN8QnSQEWnaDGGUtbvLzJ9Kl1C8B/3QvjgaEU=;
        b=AZHG4bB8d0MKL5mURzZlLM5u0Mb56kClbag8e35nZ7k49RUfXb8r2teVZX73jDgY5y
         w8pvLyxSx2UsE16Am6ZmkNWlQ+LL1zR6OHzUVi+hVNijUmIcNPfnDnnnKxiyG4tFDEMz
         cf31GOA2ez19tKkjH8MrxA+kljqwxdgPhvrY/yaT6xuKBgh5TPcHEVrKp7o8xpzlRwmi
         8QBPno9Ue463uG0zYE5DadF6ZkjBB6xU1AJ46CV5lSDTAikk7n0l5y0d+wcmYF0tNleP
         p5qjD7eRu39o1Pzlemz5PEe/cA4zZdCMD/XSRIQqowcTwr3MQShJqi9W1/pDYQF8MPz/
         a9yg==
X-Forwarded-Encrypted: i=1; AJvYcCX/RyDZsSOS2F4msDBmnOCmKFzlwH5fW3k8wHP6xRRcaV2iOvSvX19GVEoCHDtoHRHOkTFTGtqMevO9Vntf@vger.kernel.org
X-Gm-Message-State: AOJu0YwoILGAQw9IPcTUXJOUa6eE+e52gH3qxFu0LUCpBlx2WXwOr+oS
	HDgnNh/513qaqYeYLn8k4mNu5Y3VRrhWRS4GVuiPRCRUoxdA45ZrCZzbVJC0fJo2Yc2L8q8CR1U
	010aqpg==
X-Google-Smtp-Source: AGHT+IEoH3Dhv73LGspYMYEfg6SjReNg6iDMuoDHAeKmrMPg6QH84CSbwClYlsxjJrTcrRMZ7RzAJg==
X-Received: by 2002:a17:907:3f88:b0:a8d:6372:2d38 with SMTP id a640c23a62f3a-a90c1cba61emr142785266b.18.1726717125742;
        Wed, 18 Sep 2024 20:38:45 -0700 (PDT)
Received: from [192.168.0.216] ([185.44.53.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4375sm666457166b.73.2024.09.18.20.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 20:38:43 -0700 (PDT)
Message-ID: <8697e349-d22f-43a0-8469-beb857eb44a1@kernel.dk>
Date: Wed, 18 Sep 2024 21:38:41 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@meta.com>,
 Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
 regressions@leemhuis.info
References: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
 <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/24 9:12 PM, Linus Torvalds wrote:
> On Thu, 19 Sept 2024 at 05:03, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I think we should just do the simple one-liner of adding a
>> "xas_reset()" to after doing xas_split_alloc() (or do it inside the
>> xas_split_alloc()).
> 
> .. and obviously that should be actually *verified* to fix the issue
> not just with the test-case that Chris and Jens have been using, but
> on Christian's real PostgreSQL load.
> 
> Christian?
> 
> Note that the xas_reset() needs to be done after the check for errors
> - or like Willy suggested, xas_split_alloc() needs to be re-organized.
> 
> So the simplest fix is probably to just add a
> 
>                         if (xas_error(&xas))
>                                 goto error;
>                 }
> +               xas_reset(&xas);
>                 xas_lock_irq(&xas);
>                 xas_for_each_conflict(&xas, entry) {
>                         old = entry;
> 
> in __filemap_add_folio() in mm/filemap.c
> 
> (The above is obviously a whitespace-damaged pseudo-patch for the
> pre-6758c1128ceb state. I don't actually carry a stable tree around on
> my laptop, but I hope it's clear enough what I'm rambling about)

I kicked off a quick run with this on 6.9 with my debug patch as well,
and it still fails for me... I'll double check everything is sane. For
reference, below is the 6.9 filemap patch.

diff --git a/mm/filemap.c b/mm/filemap.c
index 30de18c4fd28..88093e2b7256 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -883,6 +883,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 		if (order > folio_order(folio))
 			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
 					order, gfp);
+		xas_reset(&xas);
 		xas_lock_irq(&xas);
 		xas_for_each_conflict(&xas, entry) {
 			old = entry;

-- 
Jens Axboe

