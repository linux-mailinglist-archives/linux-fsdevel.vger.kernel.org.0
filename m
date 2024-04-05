Return-Path: <linux-fsdevel+bounces-16206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393DD89A175
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 17:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFC31C23847
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1636F16D32C;
	Fri,  5 Apr 2024 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDJqVZLF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE92916F827;
	Fri,  5 Apr 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331487; cv=none; b=bU9JkAR2x4C1ednzPuCe/Wudzt6d9smHsrUWZ1mbFHD3lnLXub+o4HG2o+HtqQf5w97FSjOkvGjmNkgCdYqbM7Aqp+rH3j8J8QBciD18XFxUNkW+Y8+uN0FVS6m2ldGEQL5SlauLtTEG7976KUI3xRhqbiV7EXZEYYEqiDS8eJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331487; c=relaxed/simple;
	bh=dPM81dfP4eacKZ5qLTkJlDyNq94WsZPQVAMWDYyYoJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHO7LxAtm52WLatNGql5xMzCEjApaOvCpd1PAxINsJ7JXoxsBCoZsYSCKLJitoGkIyUReL7j8+O0EvQ75EzbwoR3Fo6RE1I4v7BOlrEhpNF9uvAVvOUDOiEwTDIELTTX3tMS5UNJdoP7Y+wLsnuQKtqYgdeABnDAgbtBnuQbJcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDJqVZLF; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so3084756e87.0;
        Fri, 05 Apr 2024 08:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712331484; x=1712936284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5HKjia/bBxV9bwJewCR86FUIvkQ6YbpSmsf0h/yiVw=;
        b=bDJqVZLFSigRf74BaNCNTlJ2WMgFDsWC2nIF3nMfUUAaBDwsRWuW/gGb8JipCeHwWO
         38PHPh7JUxy/0TBDb6lAjj36QXfx1vCLJXOLUKTDKNO3LN4zHGpTcuX6htW9uWlvpr/w
         W6l7N45UQnK18ae/EEFfelcrX25KWAuQekgUPV17Pu20l9bGR3QFSO8w+mc9IZzWcBne
         IkEL/Dp8rf4osO7PUptNNoCXrgVJDliuM0T5fQAiQGGVRJMFicEynEucCGiKkWbFwQ1W
         Vn7nlE+PL63HOiRYAY7jNXjOTFg0P1wvBGeg1HSPvHJ3NWoSqVCYrx6GVLKnqkkRhEwX
         8lDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331484; x=1712936284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5HKjia/bBxV9bwJewCR86FUIvkQ6YbpSmsf0h/yiVw=;
        b=XjNRwRORDeaseB4SmI6PllnDHiCKTe35NzVkoZhkcyRA8P6AloH4vG/o8bepmBu5os
         N1C2iHr29w/mLXoqxcCf/KXFxkF8/zpNfl16x2RIORvngV0NXvyLjrOVpNQS03KKxISj
         3R8lwGtUpSXgXA31anVBdrnaKtMFNEEzOQlVvBldgP+EM89gDDf9wa4XYebMnhWzvoTd
         RcXyUkHr1Z/c+noeSkvpLSmMJen9D2hsH2aY2Y9bG3NPm12ZK6f0ZqHJlINQg9xMm+Ep
         ggNNoi2NFNd+qFp8dJ0X2rM1OeFrrutJv2a8rbglC8qEttx9eUGMcX2lywbmC040GUpq
         ukcA==
X-Forwarded-Encrypted: i=1; AJvYcCWOdB/+o6gdhoqa2nySt/mWKM3eA8DBv5y4QqIK5kuasJCKkr34+GS4WHWnBPluOy9BBXBB1CEoEjDy1gXE7jffeh+rc1MAjVaYBRUJEZDSeW8ugwgJy04JR+wsUFwDg8CJgCbzOW/2mHGqdcK5te+rH5lhcKQGt2B71OFx1HFKC29IMiseNCmy4eLkaZOc3nSgkbq+pAIlCRIL3IGjxH9FfQ3BnCO0sidL/eUujQ6lmNucbthZS/H9Kr2R/wIqrYiBNMNhMIBeW8T5Q4Vz0EbLX4tgQ2mpLMtf8Q==
X-Gm-Message-State: AOJu0YxhSOl30Z4CnRLXmfFl5QaARPd04/mggMd2kaT/8WsDqJE9gZvs
	j1JoOqPrPWqGgtZJPfta2njNrlMVhkmdhJ2l5WReXPCU2qSmuz+3
X-Google-Smtp-Source: AGHT+IEIEEmughiSiBHY8eCIsSnqVoMqZUWDTHfuKcBEPEydDjJRjHpHyQHuQL28VLtLT7iqCSGbkw==
X-Received: by 2002:a05:6512:2fa:b0:516:d029:b513 with SMTP id m26-20020a05651202fa00b00516d029b513mr1341784lfq.69.1712331483357;
        Fri, 05 Apr 2024 08:38:03 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:2659:d6e4:5d55:b864? (soda.int.kasm.eu. [2001:678:a5c:1202:2659:d6e4:5d55:b864])
        by smtp.gmail.com with ESMTPSA id j11-20020a056512344b00b0051589cc26afsm218610lfr.72.2024.04.05.08.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 08:38:02 -0700 (PDT)
Message-ID: <3d496797-4173-43de-b597-af3668fd0eca@gmail.com>
Date: Fri, 5 Apr 2024 17:37:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/37] Memory allocation profiling
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
 vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
 liam.howlett@oracle.com, penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net,
 void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 peterx@redhat.com, david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
 masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
 jhubbard@nvidia.com, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
 paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com,
 yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
 andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com,
 vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com,
 ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
 vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, songmuchun@bytedance.com,
 jbaron@akamai.com, aliceryhl@google.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
References: <20240321163705.3067592-1-surenb@google.com>
 <c14cd89b-c879-4474-a800-d60fc29c1820@gmail.com>
 <CAJuCfpHEt2n6sA7m5zvc-F+z=3-twVEKfVGCa0+y62bT10b0Bw@mail.gmail.com>
 <41328d5a-3e41-4936-bcb7-c0a85e6ce332@gmail.com>
 <CAJuCfpERj52X8DB64b=6+9WLcnuEBkpjnfgYBgvPs0Rq7kxOkw@mail.gmail.com>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <CAJuCfpERj52X8DB64b=6+9WLcnuEBkpjnfgYBgvPs0Rq7kxOkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024-04-05 17:20, Suren Baghdasaryan wrote:
> On Fri, Apr 5, 2024 at 7:30 AM Klara Modin <klarasmodin@gmail.com> wrote:
>>
>> On 2024-04-05 16:14, Suren Baghdasaryan wrote:
>>> On Fri, Apr 5, 2024 at 6:37 AM Klara Modin <klarasmodin@gmail.com> wrote:
>>>> If I enable this, I consistently get percpu allocation failures. I can
>>>> occasionally reproduce it in qemu. I've attached the logs and my config,
>>>> please let me know if there's anything else that could be relevant.
>>>
>>> Thanks for the report!
>>> In debug_alloc_profiling.log I see:
>>>
>>> [    7.445127] percpu: limit reached, disable warning
>>>
>>> That's probably the reason. I'll take a closer look at the cause of
>>> that and how we can fix it.
>>
>> Thanks!
> 
> In the build that produced debug_alloc_profiling.log I think we are
> consuming all the per-cpu memory reserved for the modules. Could you
> please try this change and see if that fixes the issue:
> 
>   include/linux/percpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> index a790afba9386..03053de557cf 100644
> --- a/include/linux/percpu.h
> +++ b/include/linux/percpu.h
> @@ -17,7 +17,7 @@
>   /* enough to cover all DEFINE_PER_CPUs in modules */
>   #ifdef CONFIG_MODULES
>   #ifdef CONFIG_MEM_ALLOC_PROFILING
> -#define PERCPU_MODULE_RESERVE (8 << 12)
> +#define PERCPU_MODULE_RESERVE (8 << 13)
>   #else
>   #define PERCPU_MODULE_RESERVE (8 << 10)
>   #endif
> 

Yeah, that patch fixes the issue for me.

Thanks,
Tested-by: Klara Modin

