Return-Path: <linux-fsdevel+bounces-16324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D39D889B255
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 15:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877C4281A59
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 13:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30C438DF9;
	Sun,  7 Apr 2024 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDYAzz9Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AB6339A0;
	Sun,  7 Apr 2024 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712497450; cv=none; b=ebgcaEhGzN/UzAShzCWicksN6mEzPbuq0fBXIB4m7Ej+qaxunKexu+2pZuE04zGs35ouWSTi1N1bBEEaBFzB5p8dMRyyoxg0RRjOsNXMs108+G8S+f6fC8SDsCqNLjUIw6oETIblD2G08h6oS2U9McYBk/Jb+awkVEAIHPACieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712497450; c=relaxed/simple;
	bh=VdrEm2AMUievje1IBtVIWuqaTv59oFX4wo7oe1qYON4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZK4O1T91VhQXBm+ZhoQZOmfvd46s5f5NZqs0atvUZpWAhrujYHLypbJt64Im5TE+7pU2cMBg/fOQPMJhcNNr/Pz0aYs9Fh0PflA53GYcezLt/aoyPOSVQ505XP0K67j64E28U0AjkcQp7eHl70FY6sXaB9AKa7gceA2JnyhZ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDYAzz9Q; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d82713f473so61839891fa.3;
        Sun, 07 Apr 2024 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712497447; x=1713102247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMqdQCAzDlHOX8MsoDGfkIgox0Bxd5XntMdzXg60cqY=;
        b=KDYAzz9QZJWf6UO0C3NNzx8xCKBsv7iXn22l3Faa5356+9Kc/nDI4xA00fg8CZbN6t
         amEd0kZR3RRnBe49VrCbt3s788g6fSd9RFnxJp07Ww2eaG0g52wkJdo2mm7JvEMktN+a
         eKFq/vfx/vQgq4SX658EEK4VdgCnS+XjRFycRkO54lJ+Kv1tIQlQMGaaCGhCmQGZxlJx
         Dl72F3wNfj1Bf4ecNenWSsiZxCQX1cXwAJm4cIVNAapnSL3v7TpJ6PhG5yIpGumdQasX
         BYUm5EJKgRuVe2GVdIDSnTjcHgfNwiPWDkWAJ3cr3h1YI7sRwsANacdRWN8lK8S/OjB4
         56fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712497447; x=1713102247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMqdQCAzDlHOX8MsoDGfkIgox0Bxd5XntMdzXg60cqY=;
        b=e7aJ3WoOQy0YDXK3J6xvwJGg18FrOa8yRChcidj4cwu4gvwoQ/AaDxZUncJDlGf60u
         T3LXNIJmd3k01lSv/7De64q8gcZNpcHME3BdpnDYUIrR7Kzh4+s/1ldcwpLkAnMBpvJU
         SdwvuJ0OBLBBxok0iaMFp/4aasflIq/Y+eDgT+APXnOmraEbHgbp8NTORZV/0YVIEaAh
         mhZjeVhxjt81oEHMtt/bha1O+nfD85HaodkMWP63evUwTbzSMiduMxsijztapYTg3Dfj
         /rua2BYq017YhcwNcrdWkrylv/drE4uQzsSMtkv6a9V0ojd/9K7fUbAJd54xGMfbDzkQ
         wPdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIk5u/tiGHBiRqA7E9QLj5tnRjPMc4rbwBEcpSEYNDeS21HQYHvmDybg52k3guaO6gAlfEKhiZo26jvmg2JoYmlg1c8MR8Lds3q2vWDgrNdnVNCxFKyiAoG30lL3zS4px95scGEm8YeLtUj0fWmYGl9ApHWgSauMk+VUKQIz6EuwhlMJYL6dOhyz0/WFPN6xiAZaaX52Njuu8PfgJ/ZbbHkBZlJMJ0vZzIbLhxCcFANJapMKpVeOdWzUIdOEaIqNBeMX2uiLqyyXSqDyZM8mX1nnBNU3IfgAEyyQ==
X-Gm-Message-State: AOJu0YxJ1NEA2584ItkXWXhkpZclfkJshEa+MxGFDxrJHMOtIMiStZIu
	Jds4qS9uOYSEb/EQiR5FJ+b9D1EuCGJ37kLuFoQX22Fq6DqYHCQL
X-Google-Smtp-Source: AGHT+IE1tiO7siqzwDY0v+GklkSmpzuhad4k1luOgBNgpb3uenlVhwlfg4Y/viQAF8R6/S24mcdO8A==
X-Received: by 2002:a19:ee19:0:b0:516:cc2f:41d4 with SMTP id g25-20020a19ee19000000b00516cc2f41d4mr5209382lfb.25.1712497446573;
        Sun, 07 Apr 2024 06:44:06 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:2659:d6e4:5d55:b864? (soda.int.kasm.eu. [2001:678:a5c:1202:2659:d6e4:5d55:b864])
        by smtp.gmail.com with ESMTPSA id n5-20020a056512310500b00516cd482c44sm799770lfb.198.2024.04.07.06.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 06:44:06 -0700 (PDT)
Message-ID: <acfdf9d8-630b-41d1-9ae0-b3b6442df82c@gmail.com>
Date: Sun, 7 Apr 2024 15:44:03 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/37] lib: add allocation tagging support for memory
 allocation profiling
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com,
 penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, juri.lelli@redhat.com,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 peterx@redhat.com, david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
 masahiroy@kernel.org, Nathan Chancellor <nathan@kernel.org>,
 dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org,
 muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
 pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
 David Howells <dhowells@redhat.com>, hughd@google.com, andreyknvl@gmail.com,
 keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
 gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
 glider@google.com, elver@google.com, dvyukov@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com,
 rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
 kernel-team@android.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org
References: <6b8149f3-80e6-413c-abcb-1925ecda9d8c@gmail.com>
 <76nf3dl4cqptqv5oh54njnp4rizot7bej32fufjjtreizzcw3w@rkbjbgujk6pk>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <76nf3dl4cqptqv5oh54njnp4rizot7bej32fufjjtreizzcw3w@rkbjbgujk6pk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-06 23:47, Kent Overstreet wrote:
> On Fri, Apr 05, 2024 at 03:54:45PM +0200, Klara Modin wrote:
>> Hi,
>>
>> On 2024-03-21 17:36, Suren Baghdasaryan wrote:
>>> Introduce CONFIG_MEM_ALLOC_PROFILING which provides definitions to easily
>>> instrument memory allocators. It registers an "alloc_tags" codetag type
>>> with /proc/allocinfo interface to output allocation tag information when
>>> the feature is enabled.
>>> CONFIG_MEM_ALLOC_PROFILING_DEBUG is provided for debugging the memory
>>> allocation profiling instrumentation.
>>> Memory allocation profiling can be enabled or disabled at runtime using
>>> /proc/sys/vm/mem_profiling sysctl when CONFIG_MEM_ALLOC_PROFILING_DEBUG=n.
>>> CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT enables memory allocation
>>> profiling by default.
>>>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
>>> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>>
>> With this commit (9e2dcefa791e9d14006b360fba3455510fd3325d in
>> next-20240404), randconfig with KCONFIG_SEED=0xE6264236 fails to build
>> with the attached error. The following patch fixes the build error for me,
>> but I don't know if it's correct.
> 
> Looks good - if you sound out an official patch I'll ack it.
> 

I gave it a try and sent out a patch [1]. This is my first time doing 
that and it's likely not without mistakes.

1. 
https://lore.kernel.org/lkml/20240407133252.173636-1-klarasmodin@gmail.com/T/#u

