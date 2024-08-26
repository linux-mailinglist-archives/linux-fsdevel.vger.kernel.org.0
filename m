Return-Path: <linux-fsdevel+bounces-27083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C81495E734
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 05:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD231F217C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 03:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074CD29408;
	Mon, 26 Aug 2024 03:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UrWSmUbt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E839282F4
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724641821; cv=none; b=m82xlNQqbSwHrpAjk+svn8drVUc+ACo7OOA+Z7Gi+i57r8SVyScGQC3N47LLlCzB7Oq56/ieDewkntx2sM2jLfvynz+2eWH8D0RKwTXmFaTbQIZdGIZ1wNoyD7M166P+aikNN3iPVx1Ze7dpmssai32bEi16RI9qwLTC0RCSXSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724641821; c=relaxed/simple;
	bh=ymoHqCnNaqHf5BP4l9SD/NwH7hYr7nMOhTkoBsyQBHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTxov4udsRrgH9ZBSBnLQL1QJ0yL9MtBy0DoT8YQPM9EN5b8jyoQUQEPV5sXkbH0Y/k7RXw3OpBw1FFmgootptUt73lgIWzPGi6m6wJtSdp3kd0W5IZS1v/MwVjXZ0Fv3NpKjSCDJLrIdtK712HNCOjBmOaaWXVzxPv2VVT2Bxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UrWSmUbt; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3d58d6e08so2933070a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Aug 2024 20:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724641818; x=1725246618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oZX6x/egC07tqWD7jsgxOkn/l2ecZwyFmUDqkxj05sI=;
        b=UrWSmUbtpl91yMDi1NSn24KKQ2+EPFrC8AtiJtbx/48z6Yy7Wk8JfAmm1m7UdHrzNf
         KMu7KWJbCDugasqX56SxlzGxFKZb2DobHhPCuAdKQopRZ+PMPHMD9sEYkQdeYzVNsP+A
         WK6UgHA7HSs6IeQ/NrOxSHELuK9eN9nbW88iyDtM9UocoB1jMiHUHv5LVv3HsLwgIEyX
         mX7wKEKrSfqz+guqlrKD9zCZox5l8X+SW2zE/NKQhoCbOhPNFbypYslPjgm4UttHlMsT
         Px6CPsS6GOovCNnGABGHzxE8w/hnsDvgED+SyUX0folH8VwkBAOOK7coC0NCMPNXKeYB
         x5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724641818; x=1725246618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZX6x/egC07tqWD7jsgxOkn/l2ecZwyFmUDqkxj05sI=;
        b=fd4r69kYU+urD35XxHoARwj/puNpqgpZZRYT458wAaST38u0aLDKNL7oqDube7UB7R
         gTtgTXtinxfNfZY9FYM1D4z3UElH01LJ1EdL/liJoSO2LSVvtzpXbnQ3wRpQmz2qQva1
         CscW3sPH//rFOgFIGoiVb9JA1wFBuKZSOLf4OkQvWAD1mN3R86+VAS/YDBBS3l65rxui
         fLfeSt9O70rRd595SoAOCgAUJ79o62W/OlDXaPcmc7Ety58ZoFuhT+2qQmXhrlEK9G7g
         rVWYuAMf1R2OASvqmWOjNywRwNe5ndvpEcFnYdznDwEjPYp37Ez9jnSw++CjmkrxGgQN
         5Ong==
X-Forwarded-Encrypted: i=1; AJvYcCUKnW/3SRV1YIgzju3KF0GMOB5G0gasOataMct7wApwCiNvmk6QaWZADvpc/Dhq//eMrUwEOl0N9mGCIgr4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0qCxpZZh20Ujd+icpuegRMMyhFqYDkO0LWR0ZQgrBHpKcbt4o
	eIbnZQy9bcuJWX4Csgu94DjbuHopqhx7Rd6hd2FmqXlCAQUYfItXuIqYBtZpp+w=
X-Google-Smtp-Source: AGHT+IExSEXEeBc7eCz5/YTr9FjB6mRKMNWSRtKvcbkNd+JY/e0M+CtATZZ02S9q3FxIUNWQsqd7rw==
X-Received: by 2002:a17:90b:115:b0:2d3:dcc1:f98f with SMTP id 98e67ed59e1d1-2d646bf282bmr9381893a91.10.1724641818564;
        Sun, 25 Aug 2024 20:10:18 -0700 (PDT)
Received: from [10.4.59.158] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613af1496sm8560863a91.40.2024.08.25.20.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 20:10:18 -0700 (PDT)
Message-ID: <4733d230-0935-4bff-a17e-8c6735ad16b4@bytedance.com>
Date: Mon, 26 Aug 2024 11:10:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] mm: shrinker: Add a .to_text() method for shrinkers
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: david@fromorbit.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20240824191020.3170516-1-kent.overstreet@linux.dev>
 <20240824191020.3170516-3-kent.overstreet@linux.dev>
 <122be87e-132f-4944-88d9-3d13fd1050ad@bytedance.com>
 <h4i4wn5xnics2wjuwzjmx6pscfuajhrkwbz2sceiihktgzuefr@llohtbim43jg>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <h4i4wn5xnics2wjuwzjmx6pscfuajhrkwbz2sceiihktgzuefr@llohtbim43jg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/26 11:04, Kent Overstreet wrote:
> On Mon, Aug 26, 2024 at 11:01:50AM GMT, Qi Zheng wrote:
>>
>>
>> On 2024/8/25 03:10, Kent Overstreet wrote:
>>> This adds a new callback method to shrinkers which they can use to
>>> describe anything relevant to memory reclaim about their internal state,
>>> for example object dirtyness.
>>>
>>> This patch also adds shrinkers_to_text(), which reports on the top 10
>>> shrinkers - by object count - in sorted order, to be used in OOM
>>> reporting.
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
>>> Cc: Roman Gushchin <roman.gushchin@linux.dev>
>>> Cc: linux-mm@kvack.org
>>> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>>> ---
>>>    include/linux/shrinker.h |  7 +++-
>>>    mm/shrinker.c            | 73 +++++++++++++++++++++++++++++++++++++++-
>>>    2 files changed, 78 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>>> index 1a00be90d93a..6193612617a1 100644
>>> --- a/include/linux/shrinker.h
>>> +++ b/include/linux/shrinker.h
>>> @@ -24,6 +24,8 @@ struct shrinker_info {
>>>    	struct shrinker_info_unit *unit[];
>>>    };
>>> +struct seq_buf;
>>> +
>>>    /*
>>>     * This struct is used to pass information from page reclaim to the shrinkers.
>>>     * We consolidate the values for easier extension later.
>>> @@ -80,10 +82,12 @@ struct shrink_control {
>>>     * @flags determine the shrinker abilities, like numa awareness
>>>     */
>>>    struct shrinker {
>>> +	const char *name;
>>>    	unsigned long (*count_objects)(struct shrinker *,
>>>    				       struct shrink_control *sc);
>>>    	unsigned long (*scan_objects)(struct shrinker *,
>>>    				      struct shrink_control *sc);
>>> +	void (*to_text)(struct seq_buf *, struct shrinker *);
>>>    	long batch;	/* reclaim batch size, 0 = default */
>>>    	int seeks;	/* seeks to recreate an obj */
>>> @@ -110,7 +114,6 @@ struct shrinker {
>>>    #endif
>>>    #ifdef CONFIG_SHRINKER_DEBUG
>>>    	int debugfs_id;
>>> -	const char *name;
>>>    	struct dentry *debugfs_entry;
>>>    #endif
>>>    	/* objs pending delete, per node */
>>> @@ -135,6 +138,8 @@ __printf(2, 3)
>>>    struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
>>>    void shrinker_register(struct shrinker *shrinker);
>>>    void shrinker_free(struct shrinker *shrinker);
>>> +void shrinker_to_text(struct seq_buf *, struct shrinker *);
>>> +void shrinkers_to_text(struct seq_buf *);
>>>    static inline bool shrinker_try_get(struct shrinker *shrinker)
>>>    {
>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>> index dc5d2a6fcfc4..ad52c269bb48 100644
>>> --- a/mm/shrinker.c
>>> +++ b/mm/shrinker.c
>>> @@ -1,8 +1,9 @@
>>>    // SPDX-License-Identifier: GPL-2.0
>>>    #include <linux/memcontrol.h>
>>> +#include <linux/rculist.h>
>>>    #include <linux/rwsem.h>
>>> +#include <linux/seq_buf.h>
>>>    #include <linux/shrinker.h>
>>> -#include <linux/rculist.h>
>>>    #include <trace/events/vmscan.h>
>>>    #include "internal.h"
>>> @@ -807,3 +808,73 @@ void shrinker_free(struct shrinker *shrinker)
>>>    	call_rcu(&shrinker->rcu, shrinker_free_rcu_cb);
>>>    }
>>>    EXPORT_SYMBOL_GPL(shrinker_free);
>>> +
>>> +void shrinker_to_text(struct seq_buf *out, struct shrinker *shrinker)
>>> +{
>>> +	struct shrink_control sc = { .gfp_mask = GFP_KERNEL, };
>>> +
>>> +	seq_buf_puts(out, shrinker->name);
>>> +	seq_buf_printf(out, " objects: %lu\n", shrinker->count_objects(shrinker, &sc));
>>> +
>>> +	if (shrinker->to_text) {
>>> +		shrinker->to_text(out, shrinker);
>>> +		seq_buf_puts(out, "\n");
>>> +	}
>>> +}
>>> +
>>> +/**
>>> + * shrinkers_to_text - Report on shrinkers with highest usage
>>> + *
>>> + * This reports on the top 10 shrinkers, by object counts, in sorted order:
>>> + * intended to be used for OOM reporting.
>>> + */
>>> +void shrinkers_to_text(struct seq_buf *out)
>>> +{
>>> +	struct shrinker *shrinker;
>>> +	struct shrinker_by_mem {
>>> +		struct shrinker	*shrinker;
>>> +		unsigned long	mem;
>>> +	} shrinkers_by_mem[10];
>>> +	int i, nr = 0;
>>> +
>>> +	if (!mutex_trylock(&shrinker_mutex)) {
>>> +		seq_buf_puts(out, "(couldn't take shrinker lock)");
>>> +		return;
>>> +	}
>>
>> I remember I pointed out that the RCU + refcount method should be used
>> here. Otherwise you will block other shrinkers from
>> registering/unregistering, etc.
> 
> The more complex iteration isn't needed here - this is a slowpath
> function and we're not doing anything blocking inside it.

The shrinker list may be very long, and can you guarantee that shrinkers
other than bcachefs won't do anything blocking? ;)

