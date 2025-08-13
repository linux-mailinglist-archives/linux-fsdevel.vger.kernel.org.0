Return-Path: <linux-fsdevel+bounces-57659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 768FDB243B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 10:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A2947A43B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 08:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90B226FDB3;
	Wed, 13 Aug 2025 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4/AMASI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80972BCF75;
	Wed, 13 Aug 2025 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072432; cv=none; b=px4YlZ2uFOx4fNZQyZlc8fQgC0bjoYL1B3oeiV1xW3bDbEODx2gN1SVUwskm+DFp+9ZFDw0DN5M7myCsB7v1lEEeIZITHXFN1Izw8aMrxiP4Am0K4iKcaAjvfTQq6xFCalrSiPr/cx1v/4UzFtDzaTHkYcKlSp5g9ahgHNrSdTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072432; c=relaxed/simple;
	bh=OUMJOI0Ha5+pB2VtsSwgb3N13p0Nqt6Y7Y1h7BSr1EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxHyZ3BgRVE+9sC3CBjHZ/hloXcqUqIW/xwO2LAIYRKhGQM13ndImljNZ/0EqlRhuB+TCRjBQtzi7SKJ3olOGRB/8N86zCq3w2zQQdrMZUC4tenmQvu7hfsnashqglUjh/ke2ubCYwIIvBhtbE7PE/O5hmL1UL9c4b4RLb/a5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4/AMASI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b8de193b60so3534203f8f.0;
        Wed, 13 Aug 2025 01:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755072429; x=1755677229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=maMRjoqJXCK/+GFkp6ApW3O21rIqKnM3FTWwDItdMGw=;
        b=m4/AMASIWGTWcTTzWrUvm+sDazFxOuvVqJP3HvHujRRD4CjTzIo+wvaUQ0/GSaT3jn
         Gq97K4HkFkVqBJT1BW5aXKEqnRiCUwhpcVfnf1MKbb+ySzzYfu88Skk3apwrFm6jE+CR
         8CS2mWSh5vYmAJdkSzo81Opk21bCP7X2w5rgUw+LErtlmiBNOihTQKYHpiXO5XYRX7uA
         aktSJEVnVKYJ5uOjnnwFEVQ7hqMHIyKflD2aTpPbVkRTBUUZKtOS3/jwBjMaiQLfMCVw
         QiE0IjEm2LE+2A8gB5/3JqoxxXD84Ia0tz7ujlj+OEU4Ex0zRfVAYDB+1p96CT47oQe4
         a2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755072429; x=1755677229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maMRjoqJXCK/+GFkp6ApW3O21rIqKnM3FTWwDItdMGw=;
        b=NlnluhiTerhP0mpIs6ZW+b5twiPXhhxl3Uex8Vjs/5QEHXQB4gdjrWKwumX6HVtxb/
         xZQomM/uXeJKF5j/iFCTKDI02L+X5Z44S2b88G/U7Jd1xB/L9Ey/owwdmQiU1o4TRaj+
         wpTQul/d/cC7HbgfCViriTZ6ScSP0T9iu8JsE3dHyhja93XiEWhTLsp6Coyb7BnWRQhA
         3X/tVzUZgXmBU2mnn9gjTNYIguNOxmaY4KchDWlWW8+/H4+qN0JDF6b0CsSu3AaVI56Z
         QsKeGUcGDkqy4KcPtuSUMyavPM4qnLknIbgUw1Z8nbMPECoN241YjZKZNYMkfLv5fVJl
         u/qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNORQxlrRNjsGNo2vwb1eG+Hgo3GpnpxgWWilx5WnYDPr+TJrb/v3Rwxbe/4TdwDdc19Arn6PUaMNjUvE0@vger.kernel.org, AJvYcCUlR2lyEQqoyOVHZRouZhfOCMadLrQ04EH0PfTkYTt26MPVAHxjfoBbYJpFSm12myLga3qxaQE5E/A=@vger.kernel.org, AJvYcCWL7hx+SwRqP3fKprNyUbZ7Fk8P+Ht+QyYe2lhbCc/54pDmY4BqWEZgy3nuk80gMP8EDGGcvE9WGUFWDw4yMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz24N6+j957fs4+AsiJXQF1W5POEMRse5cv+eOtz7U/uwxu/yDF
	MEBQAWMuAZ+gLnGLEJAXyNd6UJ8sh8RhlM5wKuF93ivFAjb1I/LaQvSz
X-Gm-Gg: ASbGnctQ4hOsW28ih4/Bythd+rER4hXglTOZQoKQQEV9i+vR8YGnnNRrsp7nujhJPUX
	AZnzzmQROkmKRihsyDSpUSgiMbVy8trBgvY5Dz64TeY1yk92SjgVf5U8aizUbRXtAdPbOaJbLwy
	zWy6bvjOEl/MbLhYI3VJU+OK2R7/T1frXXjphee6v7pBGYdTwuGJfSlxy19PPurcqCleUlybqhK
	f93hStzEdqId6ih/tLKEykVhC4Oru5rmCdmw2bvNGEyk/kpHmdj7RNKMtt1S9IwZRjkgWJZcGYG
	gj97W1BpVbpJXPV0LtG1LgSkWr3zAhsByhvOssyGTJl2dqf5Va6wCvxEFkxuyeh4SRx65HGC8V7
	WIBNW3boMQ0UA9WBVl27glLXYPlB/AXvia8rP6ddQht3ugOFNUf/KRDNiwaUlNssVUejR3CNQxP
	h+a8OgFssOwLyDNGRApXMj
X-Google-Smtp-Source: AGHT+IG21U8BYsNzqLWav/ytlWcEyoyWQmL1EXaTaANw9uatg14wjY4T/4or/U27usDsLhFE+I8vug==
X-Received: by 2002:a5d:584e:0:b0:3b7:dd87:d730 with SMTP id ffacd0b85a97d-3b917ed493bmr1488118f8f.52.1755072428736;
        Wed, 13 Aug 2025 01:07:08 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4? ([2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48105csm47122956f8f.64.2025.08.13.01.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 01:07:07 -0700 (PDT)
Message-ID: <d3d1b812-066a-4124-83ca-df96fa75e3b1@gmail.com>
Date: Wed, 13 Aug 2025 09:07:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] prctl: extend PR_SET_THP_DISABLE to only provide
 THPs when advised
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
 baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
 <0f8b7e64-d08b-44d6-8a1b-2b4b8d64cbe6@lucifer.local>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <0f8b7e64-d08b-44d6-8a1b-2b4b8d64cbe6@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/08/2025 07:06, Lorenzo Stoakes wrote:
> Usama - did we plan another respin here? I ask as not in mm-new.
> 

Yes, I have the changes ready since last week, was just waiting for a respin of
the selftest cleanup series that David mentioned in [1], but I dont see it
in the mailing list. I will just do the cleanup in my series and send it.


> Also heads up, my mm flags series will break this one, so if you're
> respinning, please make sure to use the mm flag helpers described in [0].

Sounds good, Thanks for the heads up!

I do see this in mm-new, so will just send the next revision today tested
on latest mm-new.


> 
> It's really simple, you just do:
> 
> mm_flags_test(MMF_xxx, mm) instead of test_bit(MMF_xxx, &mm->flags)
> mm_flags_set(MMF_xxx, mm) instead of set_bit(MMF_xxx, &mm->flags)
> mm_flags_clear(MMF_xxx, mm) instead of clear_bit(MMF_xxx, &mm->flags)
> 
> So should be very quick to fixup.
> 
> Sorry about that, but should be super simple to sort out.
> 
> Cheers, Lorenzo
> 
> [0]: https://lore.kernel.org/linux-mm/cover.1755012943.git.lorenzo.stoakes@oracle.com/
[1] https://lore.kernel.org/all/eec7e868-a61f-41ed-a8ef-7ff80548089f@redhat.com/



