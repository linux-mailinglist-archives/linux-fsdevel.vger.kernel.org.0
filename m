Return-Path: <linux-fsdevel+bounces-58752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0DDB31376
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 11:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0CA56274C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E8F2F0660;
	Fri, 22 Aug 2025 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euDu6Rsj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEF92FABF0;
	Fri, 22 Aug 2025 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854967; cv=none; b=PDOxuP4GkG66S2wIt+wZT9u28+sDb9Go1SclF4W6GGNdohSkVZdwXo4/6JNmGSW8owzVFklE5xH2RtEcBXUa/qKSQotGP/WQBvP8HgTO0oEfl4I6JwNpGv0CQQaew4iRrTVA6bzT1lONAFsY6ztAxVS0Hx/sgsl7RMlukWV8ST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854967; c=relaxed/simple;
	bh=CfKrq5QkiedU+xlmiVUmkVN2mw3x49TJsoVaLdQ6fFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6Fd2deRCTy+4E257YB//P3CPZn6iluSctWpZ9ZA7k3UEirj7vTG/laJica7T+hYuTD4aZY18Adusc25YhTc4Xv6eRvHs+THembmg9/Hn03hFJeesKvF4Inzj6LLoZxs4YZstwxvhbahbkXjSNmDthnWcMfwVkYdq94GUNk/p7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euDu6Rsj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b0ce15fso1925995e9.3;
        Fri, 22 Aug 2025 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755854963; x=1756459763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+EnH/VSEGlluJ4BD0faCMmagpwL1mCpFcxo1StPT+Ao=;
        b=euDu6Rsj+GhkRrQQ6UplhHqc8UwzSOdM19V/nZXnwoPtQ9O5ThSxJWR5sWgdY7hjgZ
         JNa7+cpkva2IbqzvvojrmhOKGRSKldsdmzisnFRGD1/HlO0MXuJ4SdQ+mcn2Md4KMcI4
         Fn6c5O40KUCu3yB7xVJ4zSLDg+1mirUCaQ9NroDaWJG+1wH/wPErm3zOITo87Lm13nnF
         FdoUZz1+3EhjebbRr3DtEYQuDy92+7MfoENUeef1HJHfqQN1R61Nc8qqmc80KjVDLAph
         //qtV8//Ft00mISB7Y2axdiAQ8wC6g8kgZo5+QUDNX9C0UHAKAQ9j6ftBBZKQZlZXkpU
         Gkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854963; x=1756459763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+EnH/VSEGlluJ4BD0faCMmagpwL1mCpFcxo1StPT+Ao=;
        b=pEW1AVGz/aCQwY/eXfajTIxokTI0pR++6dsFBSE3hnGJT52c566+5RlE2kUyMvE5Jt
         xBFyXxBCOhexTYkReQX3FGepgjdzU+FoJD0qIKukERiJN8orMhSi1gY/bjBzg0rg4Q9x
         oafApEQWe12tg7vqd9+kKbWnM17+rb5xqoeLjv5n9Or0PJXDF5KXN0Zxl99yCpliAZCQ
         x8mzRppoy2FGY6kypS5Skr0bd3Pp2siO02A6csjj+k4NsHOtBWskgzf9PUX2cQ6a6c9S
         EmnB1LaJ7kSdtvqNM/K3hFhkkv1CMgHuCeIYuqTl6o1nVL5bEDD1B+eLClJmwJJjCZE/
         CBhg==
X-Forwarded-Encrypted: i=1; AJvYcCWVC5tdTOlweYOX+eAEcRIaHPvhzWm+/PDfswKnIAsviT9022vVAz47lQ3xPmhmdrri9GEJk7OA@vger.kernel.org
X-Gm-Message-State: AOJu0YzRSCM39RcvSDRC++6/EtIYOHwBf8cz3WAfJ/97IEhreOTMk/nH
	Ci3Ff8IRf4IFWWgDadr/Wn8/2jLFCVsHDTj1M2YJbXMBV/2mIEjtlpfl
X-Gm-Gg: ASbGncty9JbGEsGULB4DsG37U7yTVHrAu+NrrRHwmP51dq/hWt+A/SAM+b/UYR8VEJg
	A1k1RlHIeR1HmgN8TypPqDJsqqpEy/cirVjxja4tyPIV3pyfZSU0kFOml+J60OGNVUgB6nJhqJN
	P2pf53x6AeK14vjU90n6ja08Qm/ZjoFksntqnaHepJ3Yp9a1Du58cv4cPUOynNpzeqI1r1X+pCP
	BttvKDhn+as1Csqo4Dw5xNkNPgwBuW9tsZ5a+GeA3adVSmifh4UqYWlt6U+A8gFxSVMLDEn4ehh
	HWjJVMrNbw1XyvWmo6YrSij2MyPfWbygns1WP1wT9UKVsoGwqGZLMW3ScZdl4vIooHmpms6JPAU
	sTw8DHeDPo6C6WJeBIChY+hmK06GjdkqGRUdIk4NWcqdxOda27PEJfADmaiTp9VEH46iZ4DQ8CJ
	KbW8SiaL/o
X-Google-Smtp-Source: AGHT+IEeFhCgKs//0TYPpq0tr4htOV8qx42B9wgXqgLJ+zxDdcN5KH4lqW/B9Qr2BTax1Xm0EqzTVg==
X-Received: by 2002:a05:600c:3ba7:b0:456:7cf:5268 with SMTP id 5b1f17b1804b1-45b517ca4bfmr8096065e9.4.1755854962861;
        Fri, 22 Aug 2025 02:29:22 -0700 (PDT)
Received: from [192.168.100.6] ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50dc40b7sm31644325e9.2.2025.08.22.02.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 02:29:22 -0700 (PDT)
Message-ID: <e5ef25e7-e4bd-40d4-9f0a-f1d4c1c8acbe@gmail.com>
Date: Fri, 22 Aug 2025 13:29:18 +0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH 0/3] memcg, writeback: Don't wait writeback
 completion
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-mm@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 axboe@kernel.dk, tj@kernel.org
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <24119aa3-f6ef-4467-80a0-475989e19625@gmail.com>
 <CAHSKhtch+eT2ehQ5weRGEJwTj1sw0vo0_4Tu=bfBuSsHXGm3ZQ@mail.gmail.com>
Content-Language: en-US
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
In-Reply-To: <CAHSKhtch+eT2ehQ5weRGEJwTj1sw0vo0_4Tu=bfBuSsHXGm3ZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


`memory.stat:writeback` already gives you the exact real-time count of 
pages still waiting to finish write-back for that cgroup, and it is 
updated atomically in the hot path (`set_page_writeback()` / 
`end_page_writeback()`). Reading it is just an `atomic_long_read()` (or 
per-cpu equivalent), so the extra CPU cost of exposing it is essentially 
zero. I was thinking that extra additional info would help us

Thanks,
Giorgi

On 8/21/2025 6:37 AM, Julian Sun wrote:
> Hi, thanks for your review.
> 
> On Wed, Aug 20, 2025 at 8:17 PM Giorgi Tchankvetadze
> <giorgitchankvetadze1997@gmail.com> wrote:
>>
>> Could we add wb_pending_pages to memory.events?
>> Very cheap and useful.
>> A single atomic counter is already kept internally; exposing it is one
>> line in memcontrol.c plus one line in the ABI doc.
> 
> Not sure what do you mean by wb_pending_pages? Another counter besides
> existing MEMCG_LOW MEMCG_HIGH MEMCG_MAX, etc.? And AFAIK there's no
> pending pages in this patch set. Could you give more details?
> 
> Thanks,
>>
>>
>> On 8/20/2025 3:19 PM, Julian Sun wrote:
>>> This patch series aims to eliminate task hangs in mem_cgroup_css_free()
>>> caused by calling wb_wait_for_completion().
>>> This is because there may be a large number of writeback tasks in the
>>> foreign memcg, involving millions of pages, and the situation is
>>> exacerbated by WBT rate limiting—potentially leading to task hangs
>>> lasting several hours.
>>>
>>> Patch 1 is preparatory work and involves no functional changes.
>>> Patch 2 implements the automatic release of wb_completion.
>>> Patch 3 removes wb_wait_for_completion() from mem_cgroup_css_free().
>>>
>>>
>>> Julian Sun (3):
>>>     writeback: Rename wb_writeback_work->auto_free to free_work.
>>>     writeback: Add wb_writeback_work->free_done
>>>     memcg: Don't wait writeback completion when release memcg.
>>>
>>>    fs/fs-writeback.c                | 22 ++++++++++++++--------
>>>    include/linux/backing-dev-defs.h |  6 ++++++
>>>    include/linux/memcontrol.h       |  2 +-
>>>    mm/memcontrol.c                  | 29 ++++++++++++++++++++---------
>>>    4 files changed, 41 insertions(+), 18 deletions(-)
>>>
>>


