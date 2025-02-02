Return-Path: <linux-fsdevel+bounces-40553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8608EA25021
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 22:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F163A4D7C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 21:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755401F5437;
	Sun,  2 Feb 2025 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgBhu83p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A35442F
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Feb 2025 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738532402; cv=none; b=E5iUqOBE/RJvS9uzPTSR5ZHC0ivkbJTu7XrozCc7+2F10FHQSzSt4qnIzfo92wBwBRfzuA3XCTdokb7o3CmBMpl59zzCGhlXdMwFTq+8Te4jrGj6Ipw8N0NSMadfNGRYfdnwYGOqpnetr/pv1oRP2c1dQLPrLHUgUUMcYu5Lzfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738532402; c=relaxed/simple;
	bh=I00sUFnMMXX0Uelot14NAckd4n3BBuDbNCHHacyMaCE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UyALY+SKfnFk8Cg5gDf3JIFQxrc5wswbFMhbMvzGrjhD5T15BzaL/1iS7JRltIiupp3H6usd+t9yIiP931pGeB3Bi8iOsiLZ7eVpPutgZTOLkW4lD/aq8Hqm/67ZOgHS3fEWwJbYbOO1gdGVfQ6R2vTRg3CZmRiXUHNOmuirDGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgBhu83p; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaedd529ba1so523042966b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Feb 2025 13:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738532399; x=1739137199; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cK5MbjpirNDd9HYR6PR9rj4JlpOGPhKTG8gNFMp1wwg=;
        b=HgBhu83pJYBlrFg9QvMX9Lmjy3zMeLe4PFXwyU1Xf+ibM5HE1+bP/klRqJN/c6rMek
         eSyx9RKQIlwtTDdZH11sOaI256lPLbI5TR//d1dpmlgqWpoMT8Qyphvuulu423BxkIwp
         WOcTLajsejDNf7/RunRU9jJP5Gy82vXyFFkGcS6DH4q1dEfsiK9AnToT7JSH38W8HbKS
         Ekp+bAeu4ZssxX0KY31xp3D07IdsCrxZyIGiwkLX1UiLi5anxx1b4/gx2J8N9cbAz7Z3
         zWptpi6wwto83lXiLWhB5LgAkX5zOXiatzCKznE/luglS7d3vjrulPDVK76QlT80yX5k
         cavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738532399; x=1739137199;
        h=content-transfer-encoding:subject:from:cc:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cK5MbjpirNDd9HYR6PR9rj4JlpOGPhKTG8gNFMp1wwg=;
        b=h87VSlGZamkpukxpAcxqzWZXiYelbJlyB0F80MLOfTXu8M5mnHxzFcAWxtvf4gSEyq
         e7IRzLxXu0hYt52b32OC2ClM2vuvlgfYFp2cuhh7isHFmtr/KT+xd3NWRkoUFJwD3jJj
         /TvE7c6v0HRWqdPTVWFOqs8mLlOYCACavkGwEN3crMfF8VJ2u+UbRokF7PR2XNlIL0jC
         kyDxpzzabFcFELz/MRTuPJt3mOxv7DNHvEIxATygvJK1vXptEt1Kk3XPHlpAGYEdBO3b
         KrebDuJfjqJhNNv0VHj53Yg0Fh1mpZsmXdJuQyqc4ntusG+R91CEUKc7VPR2YVeV3iaU
         1tmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIcdC1OhixwhVuMR0oxnU1nZllTtV/EWzxWkVFZEOcHtgT2uqWzUN60fMqfwZjZzkKBcLbw8Nil2pyszH4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5FeazPvs3Qu7OfF+8tU7sXB5HEiDk8l36Yhx4t4cerae1gQwD
	UHLRk0XIGN4t4Z11+iRUOxPUIlkJAbDAjjraxGz4+cDYUITwSgoq
X-Gm-Gg: ASbGncvIKm7AYlcRnea4EAUGZ0nQtk7tiJ5egNeOb7z6pzwnQzYAjHE6lqxrW8RHq1z
	Co9RGCmMZyh+PyXcsFM901NZJ3acxbvTVFYEsx4cnN6X2pYn3U5gdkGdFbtUMm+Pf1N+RuZ4Mmn
	J7dCQb+RxmyMggQdv2JYNF7DjxPZHTYpKyUlKXCu9LfiwybahK1u94aa3Maugrx9weKMvH/SuS7
	tUT6l1M3vVeJCXlbRae21p16Ypq1IC78Xm0ac1mwqWDzUNnBnww2x9JV3qhdbNpPp+NpIb7eK7W
	Ab73o096Hebqrq8mFp47
X-Google-Smtp-Source: AGHT+IFHrk1aRT4+xsgjJ9G5xXp6rpNnLHgRGgm3kJiR638gF/O6QqfnbR9LHAJ4FlLq74a8ErJPKQ==
X-Received: by 2002:a05:6402:90d:b0:5dc:58c8:3154 with SMTP id 4fb4d7f45d1cf-5dc5effe4bfmr54777098a12.28.1738532398704;
        Sun, 02 Feb 2025 13:39:58 -0800 (PST)
Received: from [10.43.22.95] ([213.246.238.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a5b5ebsm638774166b.181.2025.02.02.13.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 13:39:57 -0800 (PST)
Message-ID: <048dc2db-3d1f-4ada-ac4b-b54bf7080275@gmail.com>
Date: Sun, 2 Feb 2025 22:39:57 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Content-Language: en-US
Cc: Zach Brown <zab@zabbo.net>
From: RIc Wheeler <ricwheeler@gmail.com>
Subject: [LSF/MM/BPF TOPIC] Design challenges for a new file system that needs
 to support multiple billions of file
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


I have always been super interested in how much we can push the 
scalability limits of file systems and for the workloads we need to 
support, we need to scale up to supporting absolutely ridiculously large 
numbers of files (a few billion files doesn't meet the need of the 
largest customers we support).

Zach Brown is leading a new project on ngnfs (FOSDEM talk this year gave 
a good background on this - 
https://www.fosdem.org/2025/schedule/speaker/zach_brown/).  We are 
looking at taking advantage of modern low latency NVME devices and 
today's networks to implement a distributed file system that provides  
better concurrency that high object counts need and still have the 
bandwidth needed to support the backend archival systems we feed.

ngnfs as a topic would go into the coherence design (and code) that 
underpins the increased concurrency it aims to deliver.

Clear that the project is in early days compared to most of the proposed 
content, but it can be useful to spend some of the time on new ideas.





