Return-Path: <linux-fsdevel+bounces-16077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629ED897B07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 23:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD4A0B282A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 21:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556DD156966;
	Wed,  3 Apr 2024 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiyvBdNC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC46156897
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180901; cv=none; b=oQxV5aezbAbpP1e2xjI5GRmZAhfoenQoSjLxiaXEdfCOBSDPFv6b3aloSYNzCFS1u1mpI2SbSLjeeahbrvtncVxOOf4KfRDZU0+uo/0JCTsQmNX8Zzi0GJerJgR4KAKKWlkwmZqilz1Tv4cYxFmwXTajism+qU2+brsVm4exLEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180901; c=relaxed/simple;
	bh=BqZpofoUBdW4e3DpxG0Cp4X48XFGsT+PuZo9ERGPPnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9Wl0rqn022iAQDYilIklbHmsr5D9ZYtf8gd0jrE9IuV9vyDTYHmFAUdFMQvIAmNZOsKKAuM7a525TBn0mUZ93KChvTTjNvwZgQOpJJuPVqDDxISl7ob3q1VdqGjqPFsYe5BXjw9BWQpgVrVMiyFw6ONhoxG7PRuFI9DRG4L/8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiyvBdNC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712180899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LM3COUWIzPT7dnAZypNco51j1yiA/TG+7IxlzkxR5z4=;
	b=SiyvBdNCpKNnFrVxfrdm/pIUqZiOkizX6MfdWslMVEdk2m2OEXL1N35SGN7Sl5VZfI1aDk
	kFs0fQmSmmCzeBBX4/1I9PWh7q1alMzAHFfezKkMEkoMZCF/SLwkNCGVi+CMJGhi0uEwQO
	olV2638SlS1DbRtZCzTb4efgTcJwfJM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-LbD1LtAVMeaASL1DkhVB3A-1; Wed, 03 Apr 2024 17:48:17 -0400
X-MC-Unique: LbD1LtAVMeaASL1DkhVB3A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3437574111dso103093f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 14:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712180896; x=1712785696;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LM3COUWIzPT7dnAZypNco51j1yiA/TG+7IxlzkxR5z4=;
        b=IxYhNXBj7P4kOlKq10Am98b/Ez1IMHRnAqinyYyhcVlVYTs01hfIXQoXXAEf2i0I4v
         mCTV9YiwEA3NU9zZfe7dPFO4sJn3xVHLP/DVOhRwOkcNbbsT9QnN54zO98UR6urqxw5D
         OtJuOV+lQ+Al5DfgaB8w9qaZQ4pj5ex7nZMt+OlFTZoAWnOZYWvTwiXzN+yifzwAmoKq
         7Rq/m2pDOQyo3ucc+uFPoo7sClDHoJddfMPYJJfJ2UrXs6SQtVnsPnXKpLtK4BICRwzL
         B+AXjD7bgyUj0Erhp5sIc3zepBTM4RoVqhKcyGIxNbWP4B7KhNxphO5SiIK+B1p62KBT
         DM0g==
X-Forwarded-Encrypted: i=1; AJvYcCUBYSYuO3KhT5HnHeHEAypXeJHvdQa9YLCxIf2ZhOoYafjR7s2lGD2GLWFzmCl3vsm9LnFKlYocT8ujaFkwxJCNmjiWhPytXEFaJp6zug==
X-Gm-Message-State: AOJu0Yx8SH3A2XwSOvgyt1pn4RGDybXGaOrhYcWUuQCWEC906j7FEQgH
	adq142I9khAaXqOkxghpX2PVw7tsRkYN4+ao8d/LBB5kFiq/CIAaJDj23gT1vIv7vFUq5TpfS0W
	9azonCyo/wgKkjLRdZUrP42gQUyK5Com4zT67hRVaHCc6xbkXks5624Vw3ksOv20=
X-Received: by 2002:adf:f58e:0:b0:343:6ffe:7a64 with SMTP id f14-20020adff58e000000b003436ffe7a64mr563222wro.59.1712180896606;
        Wed, 03 Apr 2024 14:48:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcHLAy/Z6o0Hkvw9Wda226gD8YrfteXQTpOHNQRcERsL2HGuS0fhig80i4ous83U5tg72ANQ==
X-Received: by 2002:adf:f58e:0:b0:343:6ffe:7a64 with SMTP id f14-20020adff58e000000b003436ffe7a64mr563157wro.59.1712180896166;
        Wed, 03 Apr 2024 14:48:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73b:3100:2d28:e0b7:1254:b2f6? (p200300cbc73b31002d28e0b71254b2f6.dip0.t-ipconnect.de. [2003:cb:c73b:3100:2d28:e0b7:1254:b2f6])
        by smtp.gmail.com with ESMTPSA id bx6-20020a5d5b06000000b00341e67a7a90sm18519899wrb.19.2024.04.03.14.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 14:48:15 -0700 (PDT)
Message-ID: <9e2d09f8-2234-42f3-8481-87bbd9ad4def@redhat.com>
Date: Wed, 3 Apr 2024 23:48:12 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/37] fix missing vmalloc.h includes
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Nathan Chancellor <nathan@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com,
 penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, dennis@kernel.org,
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
 <20240321163705.3067592-2-surenb@google.com>
 <20240403211240.GA307137@dev-arch.thelio-3990X>
 <4qk7f3ra5lrqhtvmipmacgzo5qwnugrfxn5dd3j4wubzwqvmv4@vzdhpalbmob3>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4qk7f3ra5lrqhtvmipmacgzo5qwnugrfxn5dd3j4wubzwqvmv4@vzdhpalbmob3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.04.24 23:41, Kent Overstreet wrote:
> On Wed, Apr 03, 2024 at 02:12:40PM -0700, Nathan Chancellor wrote:
>> On Thu, Mar 21, 2024 at 09:36:23AM -0700, Suren Baghdasaryan wrote:
>>> From: Kent Overstreet <kent.overstreet@linux.dev>
>>>
>>> The next patch drops vmalloc.h from a system header in order to fix
>>> a circular dependency; this adds it to all the files that were pulling
>>> it in implicitly.
>>>
>>> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>>
>> I bisected an error that I see when building ARCH=loongarch allmodconfig
>> to commit 302519d9e80a ("asm-generic/io.h: kill vmalloc.h dependency")
>> in -next, which tells me that this patch likely needs to contain
>> something along the following lines, as LoongArch was getting
>> include/linux/sizes.h transitively through the vmalloc.h include in
>> include/asm-generic/io.h.
> 
> gcc doesn't appear to be packaged for loongarch for debian (most other
> cross compilers are), so that's going to make it hard for me to test
> anything...

The latest cross-compilers from Arnd [1] include a 13.2.0 one for 
loongarch64 that works for me. Just in case you haven't heard of Arnds 
work before and want to give it a shot.

[1] https://mirrors.edge.kernel.org/pub/tools/crosstool/

-- 
Cheers,

David / dhildenb


