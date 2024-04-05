Return-Path: <linux-fsdevel+bounces-16199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6111899FBA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 16:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4073E1F22DF5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 14:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25D816F29A;
	Fri,  5 Apr 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4+ZKBqS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80A016F29D;
	Fri,  5 Apr 2024 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327426; cv=none; b=Kw6KnGRS6bVXbI3+JwzIB7a4RIUyoXMv5elkEJbIWnBQr78bmhR76KpkeLl5/ZiVgdwGlUESEJasvFLa79aZDEiB0DP9ui0pZwwwD/JLvOax2ekx9JKIfqqAMBu7eq1e4VP1aRaVoqQAD6sPlFCJ6p+ZulHOsvHEsONx7+MKVdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327426; c=relaxed/simple;
	bh=d6E90p4bY3Pr9+59Qwy7mMmf8dYZiw9X4VNjgS82La8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yij1DQ2I3Oj1ZuwJn1wcWJUAzlk9hQNgsH4Sdabs0+0BbdzfIGaZpv5NRgYJsX7INMRqO6poTy5zk32NZNMsWNFb68q4Xop4w4DqU0iBqH462JdGcS9hmG5rvmdnC5POG3+qih6Agw5LzkPUS62cJ5Z6THQlDSjxA974zi/nAKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4+ZKBqS; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51381021af1so3630562e87.0;
        Fri, 05 Apr 2024 07:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712327423; x=1712932223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/hnq3sCt2H7lY5oSS405R1id2Z+jwtM4OI26amI8Aeo=;
        b=b4+ZKBqS9Rs/d0WFYerSCcfRuRlksD72fefsbm5Z3zpvmpAYlLNo5DNKtnbg0JCPS9
         bPJ2b6/dsPOuc4LldV8NOtmcLCyZ7du0h7jg6WLRl2gd0a0jcbq3L7M6arMGl/0v0MMd
         DeOOIkkBD80qC6CdQBE8pfOP2M3ClBkW8JVUfg91G/VO2D17edz1Uj5ZHoLtFB6S4dUe
         qOHPUYeBbbnXZt2OcEYy0V4F7savklVuaNfrV+O0FeqkJSqnYpm2g3KHX4glMu/Nbwbv
         WLYNuCtCK0JiaZKUl/zCVCm2BMwfb7aZ/3sdVsCDj2QpM6CkyjJ05boPf8I4FBAQj7FD
         IrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712327423; x=1712932223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hnq3sCt2H7lY5oSS405R1id2Z+jwtM4OI26amI8Aeo=;
        b=e5nKpbba9tGi7oD739Vyh/EiQF5bleOM5AMrJ+HPD+01qTk1PlubnDKH880BDBqJEj
         GCpDnAXKkfhloz2p7FzLPZSzw6NFyrPjgq0ZHbuEHWnSDK8hDviz8Q9tm723D4QwzyRW
         VPR+Y819LcWiV1TTFZ6cnMpl9lvEOyBYMqjpvcNOxBCabzUl8BkvkkGl478KP7wdh3iw
         rL0CL/YlV/aqSwNjLJ7vldJ0y0c3RJqHM9z5U/ve1jRMoZTf/FUEHkco9Aa7UwxcfX1t
         grmPDIkw0aPdxcdM+RC0ylyY68xgM23gRijCKxEBOdG1XikIkgZPGVL1YL/wmhqpbAi4
         6avA==
X-Forwarded-Encrypted: i=1; AJvYcCWF56GMz/kMN8i3WEfVY5FBc9tLuw0p27omlaKCb1kmo+w9PzYY5cEEXWXEBpo8KuvsVwfauOkqbs8qdf5ttZCYYeNFHo8lM8dsak+76/GMangp9D5XMCV3KXewk1VF8WIEMSH1c3sfh5ZXTUH8u74WItvomdJlevlT7PP5xc68EJAfF0vHveSPswfMueWZXicJmg47vBsiNdks+APyHl5ic/3bo4KRBsyu1BV93xZXFS8iuIqGCzvd6yTlMFswz7wb5ilWs+yMIXzeVBVa3wg3E2JiT8atRj9azQ==
X-Gm-Message-State: AOJu0YxYVZMWBMB7hf4IKglpQ2D+Grm4DE0FKgSt7ISNqRq1yDYeU6H2
	tI3YO8/7qI/40D+6HejBsa26fynx9R7Eao80J6gaNYb80fGKkdyf
X-Google-Smtp-Source: AGHT+IEN7LuOfybxnTQmCx4kMrf3SVJjqvCauomGfGiCeZbO2kceAhX5eC2lsiS+gBj9j+xLKcrlpA==
X-Received: by 2002:ac2:454b:0:b0:516:ce0f:738e with SMTP id j11-20020ac2454b000000b00516ce0f738emr1466474lfm.19.1712327422562;
        Fri, 05 Apr 2024 07:30:22 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:2659:d6e4:5d55:b864? (soda.int.kasm.eu. [2001:678:a5c:1202:2659:d6e4:5d55:b864])
        by smtp.gmail.com with ESMTPSA id 23-20020ac24837000000b00516be080873sm207196lft.8.2024.04.05.07.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 07:30:22 -0700 (PDT)
Message-ID: <41328d5a-3e41-4936-bcb7-c0a85e6ce332@gmail.com>
Date: Fri, 5 Apr 2024 16:30:19 +0200
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
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <CAJuCfpHEt2n6sA7m5zvc-F+z=3-twVEKfVGCa0+y62bT10b0Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-04-05 16:14, Suren Baghdasaryan wrote:
> On Fri, Apr 5, 2024 at 6:37 AM Klara Modin <klarasmodin@gmail.com> wrote:
>> If I enable this, I consistently get percpu allocation failures. I can
>> occasionally reproduce it in qemu. I've attached the logs and my config,
>> please let me know if there's anything else that could be relevant.
> 
> Thanks for the report!
> In debug_alloc_profiling.log I see:
> 
> [    7.445127] percpu: limit reached, disable warning
> 
> That's probably the reason. I'll take a closer look at the cause of
> that and how we can fix it.

Thanks!

> 
>   In qemu-alloc3.log I see couple of warnings:
> 
> [    1.111620] alloc_tag was not set
> [    1.111880] WARNING: CPU: 0 PID: 164 at
> include/linux/alloc_tag.h:118 kfree (./include/linux/alloc_tag.h:118
> (discriminator 1) ./include/linux/alloc_tag.h:161 (discriminator 1)
> mm/slub.c:2043 ...
> 
> [    1.161710] alloc_tag was not cleared (got tag for fs/squashfs/cache.c:413)
> [    1.162289] WARNING: CPU: 0 PID: 195 at
> include/linux/alloc_tag.h:109 kmalloc_trace_noprof
> (./include/linux/alloc_tag.h:109 (discriminator 1)
> ./include/linux/alloc_tag.h:149 (discriminator 1) ...
> 
> Which means we missed to instrument some allocation. Can you please
> check if disabling CONFIG_MEM_ALLOC_PROFILING_DEBUG fixes QEMU case?
> In the meantime I'll try to reproduce and fix this.
> Thanks,
> Suren.

That does seem to be the case from what I can tell. I didn't get the 
warning in qemu consistently, but it hasn't reappeared for a number of 
times at least with the debugging option off.

Regards,
Klara Modin

