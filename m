Return-Path: <linux-fsdevel+bounces-36491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439C59E3FCA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 17:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33EE81612B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CECE20CCC4;
	Wed,  4 Dec 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oBkh3P/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FEF4A28
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330173; cv=none; b=GEz+TM27q+HJQaiegHiXksgKYlENQbeD0NcqFp+gbzFcOj5WqzdXMHKu/1pO+DyACk5T6snlZ8qH69ZV7vPk2IjrwskGouNRp9bHIRu7LLeFsSwiRn2krKeHw05HFxUIOQl02riXQU3UITWOc0lL4W9Hf9P1k/jAl7XoE6pvLYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330173; c=relaxed/simple;
	bh=XIp2HnEBwxrCbQQ7Wteksg6Xj0ba4HtjLTdVyqpEJvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBhtGmI0CLZSUPitZMj004EWVCYh/WcwxcS2TroKVxYHJu2xqtl14+petBNaCUC41pKD0XNdCZ247scn5EAu40pzfm69aY47SiXRLZW5VrIes8azGqLvaz355wtFqz6BknEsMXa4jip6U8VaSUeAaqe6L/DVW38cApYWT2CxN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oBkh3P/J; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-215cc7b0c56so18807905ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 08:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733330171; x=1733934971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBbo3x7wMFASP+XmblVLwMY6/AMJyW6BW/SbEh64LkY=;
        b=oBkh3P/JffZWQNJJJ0csj7vVSOYBFU2zv58GYJm2LMH1maOToFJX84ltqLRPhLehgR
         F36h89bVg4FOuCI35Uq31MjY1yXIZjtP/WaJOm/rcb61GfVMUsajS2uMigEd+Jd8r7jz
         U4yJMZw0d6Zvt5N7F5l+LwaDlY0gCUGBLn15Xp4+KEvDAbpqFhhB+rRRoKyOEBS8WMKe
         uIbsl9bXKVD6zxjLFejmkycc500ITeQ4MaqGiStaHQHt+31K2vHhClh5yq7KDG7WdcGT
         Dv7mAh44HKiYkAyHexQZsAqEUKiSqzxvU6p87kFYjec93AC7xN1pGzNIKWfCAXibroeJ
         dtjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733330171; x=1733934971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBbo3x7wMFASP+XmblVLwMY6/AMJyW6BW/SbEh64LkY=;
        b=R20OwqxNHK8uOrcMytgZ/iba1a5vjSTa4A5ys0Rn6Lj/u83N6hZTuV4VlII2Gw4Nz3
         MDXJNZMQP+SA0UUJ9QXhjPdXhm71BtDZsP5gtoHbvUNHXwO6hts8CNy9f6Tsr+DXarXo
         F9pe39WPiS5YJoIEFdYAuYVR78EImD8X912qtCCkeshXgtipqpRZYNn6YZ5baY0v2YMN
         vSifoKZw8gX8DE8CAMVTM3aODBQ5ScD60HpHZq8/w7D2n03x/n4yiLVCvYWyv0f6pMch
         +0KZlQtgQy14x0Es+HJoLoQVuqIHMKm7Dgv0DqeBq+YHbvncqzkngv1wECOygC+wiEVw
         GFLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkcq0N0Gk8rinyZJ6gHW5ELJMxSMc38aITJ2wREXpvhIzNoUVBSOeHqm9D/9bmsw7EKaDnfjC/LH2eu5u0@vger.kernel.org
X-Gm-Message-State: AOJu0YzsNltLRDohzoqkHMi6drCb3ipP43eeZ11kbXrWMRJLsk7ZKi2m
	yUtlk1EK/WVbrvMMkloSTPY3kDCQ0NBe1439x2aCoINQh90apIzG3XD1ndW+4Is7Gx3TPeMLFOP
	T
X-Gm-Gg: ASbGncsww1AcOLBSI93qyqwqOKK0tNVOUsPqq8mqiULE4Cm3FNKZr8aXtSgclDGX8AD
	1Q5rUA4qc4vhbrV86My5Lr3oSHn7gf01wGWFr8aDPVIHy/jvaVQdpte86/ZOQYMlvXM5AviWo3y
	Joj9zNK0wo3MyDDzLCC/0SbGW+CfYsaiWUEDPPqMLPmZcJOuN/IHFm1RaeH9gqT+ge6uW6HUIrC
	gBgHx1Z9uUHKEQxjQr060n0vmgqFuO7ILBzfK3ZALh0K9OcLEoydX4QPQ==
X-Google-Smtp-Source: AGHT+IFq0BWXPoO7jWkTFXTi5lL/pCwZIadLDCF1MS35XKXYXClo4zLPDa/VIHisfmZxq+inWAb0tA==
X-Received: by 2002:a17:903:1c9:b0:215:6211:693 with SMTP id d9443c01a7336-215bd18ed72mr65189235ad.57.1733330171446;
        Wed, 04 Dec 2024 08:36:11 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:122::1:2343? ([2620:10d:c090:600::1:a7a9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219c52b6sm113227935ad.254.2024.12.04.08.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 08:36:10 -0800 (PST)
Message-ID: <2c851bce-a65e-4132-9e0b-e7519e22dbca@kernel.dk>
Date: Wed, 4 Dec 2024 09:36:09 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
 linux-kernel@vger.kernel.org, willy@infradead.org, kirill@shutemov.name,
 bfoster@redhat.com
References: <20241203153232.92224-2-axboe@kernel.dk>
 <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org>
 <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk>
 <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org>
 <f70b7fa7-f88e-4692-ad07-c1da4aba9300@kernel.dk>
 <20241204055241.GA7820@frogsfrogsfrogs>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241204055241.GA7820@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/24 10:52 PM, Darrick J. Wong wrote:
> On Tue, Dec 03, 2024 at 03:41:53PM -0700, Jens Axboe wrote:
>> On 12/3/24 3:16 PM, Christoph Lameter (Ampere) wrote:
>>> On Tue, 3 Dec 2024, Jens Axboe wrote:
>>>
>>>> I actually did consider using some form of temporal, as it's the only
>>>> other name I liked. But I do think cached_uncached becomes pretty
>>>> unwieldy. Which is why I just stuck with uncached. Yes I know it means
>>>> different things in different circles, but probably mostly an overlap
>>>> with deeper technical things like that. An honestly almost impossible to
>>>> avoid overlap these days, everything has been used already :-)
>>>>
>>>> IOW, I think uncached is probably still the most descriptive thing out
>>>> there, even if I'm certainly open to entertaining other names. Just not
>>>> anything yet that has really resonated with me.
>>>
>>> How about calling this a "transitory" page? It means fleeting, not
>>> persistent and I think we have not used that term with a page/folio yet.
>>
>> I also hit the thesaurus ;-)
>>
>> I'm honestly not too worried about the internal name, as developers can
>> figure that out. It's more about presenting an external name that sys
>> developers will not need a lot of explaining to know what it's about.
>> And something that isn't too long. BRIEFLY_CACHED? TRANSIENT_CACHE?
>>
>> Dunno, I keep going back to uncached as it's pretty easy to grok!
> 
> <shrug> RWF_DONTCACHE, to match {I,DCACHE}_DONTCACHE ? ;)
> 
> They sound pretty similar ("load this so I can do something with it,
> evict it immediately if possible") though I wouldn't rely on people
> outside the kernel being familiar with the existing dontcaches.

Naming is hard! Most people do seem to grok what uncached means, when
I've shopped it around. The fact that it does use the page cache is
pretty irrelevant, that's more of an implementation detail to solve
various issues around competing users of it. That it doesn't persist is
the important bit, and uncached does seem to relay that pretty nicely.

-- 
Jens Axboe

