Return-Path: <linux-fsdevel+bounces-11894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F65A8587F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 22:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA4FB2B69A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 21:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF87145B07;
	Fri, 16 Feb 2024 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAWsNU7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBAB433BA;
	Fri, 16 Feb 2024 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117886; cv=none; b=Lxnrbgq3mtzWxGoTwDbLVgi+9vqGbpKFYRQD1Rt3ZJTFoO+6w9OeT4sOjZcjVsBFitSMSlMQr5BpsAvsG3mQ9gsy7BwLxHlJMBJALR/z/wFIT7M7da9j7kJHZUieb8+OaSbR/DpHf6VMZNxlclPGo9NzLu1K6WSrlGID8DZtAhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117886; c=relaxed/simple;
	bh=AkC1P132tfVIuk1ccKLjyhMgmdgIScAa8YEatwxUsRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3JKZxS7rY8jsxseq9ims1RQFxiAxz6s0w5ucUrj2feo14EwrY5xCbT0LragRiDdftRao+xZ8Ctw1ay5Xq0XD+XNdQwk76tQtxwXcM7y4dqVvzMurf+JzXFKyyoMDukaxM1K2giMjMwH8NJla21azi7ZggMmxTtNo3XivqFY4qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAWsNU7L; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6869e87c8d8so10844036d6.2;
        Fri, 16 Feb 2024 13:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708117883; x=1708722683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cei1sBmTCzFrZDMNjx54WFqFzKt6CM7WEQ8atTA9u6Q=;
        b=LAWsNU7LRtgKG9peEOMif/G8UezCvadtLBFjPqMvf2U+zqgsoLpCnZKb/Pd7U4Wh/3
         rGcXnKR9PEHXcdHMVqYeMx3yiOSXk33rHv4RvyEsqa3zlhn3M0cSeMjQxz78KdpVHa2O
         UcGhxaZEQCcGC8+MpfEtAfAOpIwTS2E0PBPo4Zt0b9pVM4KvhAEjGpyuY0yUQSZ5sMgz
         ijYlaGvIYKgYEodhsWziL+CBSo6ZrLD98MSxh71uZZE3M2k1pSkD/lTxhN8K9dX8BiNG
         7Snp058Ab8UwgUQyl6cIoZlZ0Qqrsr0Nb6iPApEX8epFmXj+0QWMmnYUCHmcZkcPU1mI
         PP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708117883; x=1708722683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cei1sBmTCzFrZDMNjx54WFqFzKt6CM7WEQ8atTA9u6Q=;
        b=lujmfGRwoffqPDLRWCLz/ObiC3a0LWfLQcZPA+ISigwdUKzaLiSgKOBGoH/OIRMNdz
         eT4XxNI5vkmlUM8eD1bxx4g8j+aiZ/l9+mvPJuaXZF/i1Hvg52bJy6tUNc7yf22Hw1O6
         0SUxJN3shgux4CreZSGFJrXP5wiYe30w24tqnsiwcgzIID77TyrxbwRb3XUrOcWqJeoS
         7dKVAUSET97U1e4JqZ/kCCT89+bzEvMNgdnZNoTGIAQk943D5GClDx6mzPQnSDAq+mod
         QgiWW7EOBpLI0jlFgG/nxKSdpoAJqi+RgCd8FVYCWu42tq8ThICrHb//bKQG0f90QWor
         7GCg==
X-Forwarded-Encrypted: i=1; AJvYcCXZMw8xLqjROTHgOya9hDLYcqWIuNJCQl/3Ta+HKGrtcxwAOvhoOUiOaTsXLBVd1Kt7hBW67T3+TpuQb3yvPTllAi+HmjFETZRMuMXU39qH1rQ/kGFHHhgL+sapD2VQnPMPZ5ggaA3K9UbAXpfoI+QP7YCH+N4wL2Q42XgqP0UT64A2x94boMc=
X-Gm-Message-State: AOJu0Yy/owyzxq63a1eGfkQ6oc6VeHuwzpKdf2FbS1cwu+1Pxprl8/4u
	Pc8Uehn/PTnbiYLJixTzHzAYlQEggBlieqrbfRSV+vVU77E5cAD8
X-Google-Smtp-Source: AGHT+IGGIyZYXqrrPYvYwagwXBP6J2L6EbwB9vuTUs8ITekdgs15UOF+4pXhOOBIbV91a80Xa+NuYA==
X-Received: by 2002:a05:6214:d81:b0:68f:385d:1f9b with SMTP id e1-20020a0562140d8100b0068f385d1f9bmr2295034qve.21.1708117882573;
        Fri, 16 Feb 2024 13:11:22 -0800 (PST)
Received: from [10.56.180.189] (184-057-057-014.res.spectrum.com. [184.57.57.14])
        by smtp.gmail.com with ESMTPSA id c12-20020a0cf2cc000000b0068f1258a16asm284591qvm.42.2024.02.16.13.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 13:11:22 -0800 (PST)
Message-ID: <67eef60c-b0fe-4034-a2e5-b09c7ef38a5a@gmail.com>
Date: Fri, 16 Feb 2024 16:11:20 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: init_on_alloc digression: [LSF/MM/BPF TOPIC] Dropping page cache
 of individual fs
Content-Language: en-US
To: John Hubbard <jhubbard@nvidia.com>, Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, lsf-pc@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <20240116114519.jcktectmk2thgagw@quack3>
 <20240117-tupfen-unqualifiziert-173af9bc68c8@brauner>
 <20240117143528.idmyeadhf4yzs5ck@quack3>
 <ZafpsO3XakIekWXx@casper.infradead.org>
 <3107a023-3173-4b3d-9623-71812b1e7eb6@gmail.com>
 <20240215135709.4zmfb7qlerztbq6b@quack3>
 <da1e04bf-7dcc-46c8-af30-d1f92941740d@gmail.com>
 <Zc6biamtwBxICqWO@dread.disaster.area>
 <10c3b162-265b-442b-80e9-8563c0168a8b@gmail.com>
 <edec0ef8-00f5-4457-a1aa-59fd6bc9f6bf@nvidia.com>
From: Adrian Vovk <adrianvovk@gmail.com>
In-Reply-To: <edec0ef8-00f5-4457-a1aa-59fd6bc9f6bf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/16/24 15:38, John Hubbard wrote:
> On 2/15/24 17:14, Adrian Vovk wrote:
> ...
>>> Typical distro configuration is:
>>>
>>> $ sudo dmesg |grep auto-init
>>> [    0.018882] mem auto-init: stack:all(zero), heap alloc:on, heap 
>>> free:off
>>> $
>>>
>>> So this kernel zeroes all stack memory, page and heap memory on
>>> allocation, and does nothing on free...
>>
>> I see. Thank you for all the information.
>>
>> So ~5% performance penalty isn't trivial, especially to protect against 
>
> And it's more like 600% or more, on some systems. For example, imagine if
> someone had a memory-coherent system that included both CPUs and GPUs,
> each with their own NUMA memory nodes. The GPU has fast DMA engines that
> can zero a lot of that memory very very quickly, order(s) of magnitude
> faster than the CPU can clear it.
>
> So, the GPU driver is going to clear that memory before handing it
> out to user space, and all is well so far.
>
> But init_on_alloc forces the CPU to clear the memory first, because of
> the belief here that this is somehow required in order to get defense
> in depth. (True, if you can convince yourself that some parts of the
> kernel are in a different trust boundary than others. I lack faith
> here and am not a believer in such make belief boundaries.)

As far as I can tell init_on_alloc isn't about drawing a trust boundary 
between parts of the kernel, but about hardening the kernel against 
mistakes made by developers, i.e. if they forget to initialize some 
memory. If the memory isn't zero'd and the developer forgets to 
initialize it, then potentially memory under user control (from page 
cache or so) can control flow of execution in the kernel. Thus, zeroing 
out the memory provides a second layer of defense even in situations 
where the first layer (not using uninitialized memory) failed. Thus, 
defense in depth.

Is this just an NVIDIA embedded thing (AFAIK your desktop/laptop cards 
don't share memory with the CPU), or would it affect something like 
Intel/AMD APUs as well?

If the GPU is so much faster at zeroing out blocks of memory in these 
systems, maybe the kernel should use the GPU's DMA engine whenever it 
needs to zero out some blocks of memory (I'm joking, mostly; I can 
imagine it's not quite so simple)

> Anyway, this situation has wasted much time, and at this point, I
> wish I could delete the whole init_on_alloc feature.
>
> Just in case you wanted an alt perspective. :)

This is all good to know, thanks.

I'm not particularly interested in init_on_alloc since it doesn't help 
against cold-boot scenarios. Does init_on_free have similar performance 
issues on such systems? (i.e. are you often freeing memory and then 
immediately allocating the same memory in the GPU driver?)

Either way, I'd much prefer to have both turned off and only zero out 
free'd memory periodically / on user request. Not on every allocation/free.

> thanks,

Best,
Adrian


