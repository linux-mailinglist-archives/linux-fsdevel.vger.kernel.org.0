Return-Path: <linux-fsdevel+bounces-72384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6580FCF2C4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 10:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 738623032F3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 09:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E952F3254B6;
	Mon,  5 Jan 2026 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWC0/LoN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7DE32D0E6
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jan 2026 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767605291; cv=none; b=SKtRZ4DeocMqcFQqEPX5aPpuWdzqAwZk2C7nZKY89M5IMX0GqDqaQWMD2W/XMF7KUuGyysWAnUcdkj9ko15uWxitN7CKWAltrjx+EjUiFx6lQvolWWSdEvBGTOcLAJ0ZoPx6tenAgrujlYD4Ehyg7tqee1Af31A0VhrC8NDkmiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767605291; c=relaxed/simple;
	bh=LUBqn4Ylu7k53HZu4lQqsEMpRTV2mIhD9a8O6isq6MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFeScvJN1SAieDm2vSt2ErB4GFrv7ptTphPi9PnyhW8UpbykkNMd4pz8orgYTpiZxyTozMPeM6LOB3hTtJm0UGvmdfZCnfXzUVU/ZD/cJxJf5v/j0O3AHNitGnWj4qeNxwvUo5Pp87ADYWkEE1yvLwKfBqC8T3wlQcZLW9zLwro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWC0/LoN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso11003675b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jan 2026 01:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767605279; x=1768210079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQIZ452wZXIK57t7CDqSPjoLHYNUHDQ+2nk1XIU16DM=;
        b=YWC0/LoNZnVjPDkmZYt659X7a3/xGc7NTkbSVt2F+3qfqjywE77kamuzBv6ilMNIF3
         lmrd9s7+Ff+8RGWcwfHBMp0t6+HqJYpVxLPisdrX5bWIp1eMC9qaR2/RB0JMvSnOcvMT
         JdHpd/QeY0GmxewsMsePEz8qRnXxKEJqL8f/aQeRGPHZomNSM9riYAhSIrVBeq6ap2kx
         Qg8U2L3S63ZFvIy0ZLT4Iq48Kti5L4PQuWuiNjzkE6DjI4OOd+Qrwz1kMzQx9qxngBgC
         o9zjXe4q+BJrAtj4lpCeuqjecZoKLAYaawBHQyaxv1J3LqMRHQgYGraCBbMTm86QLWtV
         iZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767605279; x=1768210079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQIZ452wZXIK57t7CDqSPjoLHYNUHDQ+2nk1XIU16DM=;
        b=ICR5Dsgp0z5zlo2uaZLUvCiWx4WM4mnbl2cVqKffAGmuHj6OMG7YftBIm49KnLA2n3
         gmyWMNps+FZCsl3OxLRrBeao1F3wA3WF5NPexUHZR6VxTB2B2p8yTiyjrPw2ikWte7Kc
         +wHYsEYp6tN/CovPwTJPJ4mO3c7BDpAgOzzcwH//RVdonEhnpOINdsws/0mBta9ZrBtg
         nTKMAPC8hTyR5Y6jqCR+HtrcA38vOAEKVMmrxAkjNMeOQlvHKy9pxLsFh9h4u7G4l+0g
         bVHsxWblfhMS/vLTHUnpO3CSEKEX3BJIwl1OUoAF4KZwVkLml4Qpvf58VajbD0lF8dd4
         zm0w==
X-Forwarded-Encrypted: i=1; AJvYcCWTEjSlpniPBFQflULUQupVcuOr7nGAMYESEFxuVx1Ze0ggXIs8RtAVQvNrJeDP85Oiz+qNBxEp3wb+sORT@vger.kernel.org
X-Gm-Message-State: AOJu0YyrtcXKxaIRAqc62HZF5DKOMPfFiyqnElhpGEw4jYBjOoCFdGOU
	X6rMjFeQfyTzOH3TqcsfryHuFX2ET7O8YkMtQL0lJUOrV5pQoEhWbphp
X-Gm-Gg: AY/fxX6xaJNbOTSlFXjsoNS1Gp6aMT47LVmvN4zEWH2jYZuw820hnzTPRNSF/ZJkVxz
	Enbvnx9nbHQ9RaERubJZUzO6f3qgCJ3DiPMpMS4m2P45hwZhV6dxweEZJkOSjHCKv+EWFLEPUNx
	CUV2llf/C9qhvyhT+q9xjNRxIzuqtagoAuL3Inr47iDk0hfdf5VZ8aPSbSst0uxDPPahek+WfT1
	IWhwSk++lONU5c5I47iVck6xQj8sq4hUDasCDG0bYqnEMwPcTnTa502+FNzcL9kHYPVNGyjX/dy
	ETc9CO5YxzUH3HYB2cKUf+ogKxF07901t4vurbZTwAxecaThQUbzVcyTI0vgliL8GB22Y0AEs3V
	0sOblhfQfV2oFSepbAY7wdrPCizKpL3eqbP8pA2RFuWlDa4EgBgsNqrjHt8sKGgg4ba/o3hspTh
	sDu6IT7z/hZ4P2kkVZtrq/7swq0uS958yD
X-Google-Smtp-Source: AGHT+IEZmNkq8Gl/dnJOg3s3RWvfca6b9cqNrss8LiqWrUnkpu+7dey1SrWISomWv3jO23drZv2kBA==
X-Received: by 2002:a05:6a00:4509:b0:7e8:4587:e8c1 with SMTP id d2e1a72fcca58-7ff6647983bmr40451269b3a.52.1767605279080;
        Mon, 05 Jan 2026 01:27:59 -0800 (PST)
Received: from [10.4.111.0] ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7af35f37sm47508520b3a.18.2026.01.05.01.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 01:27:58 -0800 (PST)
Message-ID: <dc92f814-043c-45b2-8d2a-403f462434d4@gmail.com>
Date: Mon, 5 Jan 2026 17:27:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: add allocation cache for iomap_dio
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 guzebing <guzebing@bytedance.com>, Fengnan Chang <changfengnan@bytedance.com>
References: <20251121090052.384823-1-guzebing1612@gmail.com>
 <aSA9VTO8vDPYZxNx@infradead.org>
From: guzebing <guzebing1612@gmail.com>
In-Reply-To: <aSA9VTO8vDPYZxNx@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/21 18:22, Christoph Hellwig 写道:
> On Fri, Nov 21, 2025 at 05:00:52PM +0800, guzebing wrote:
>> From: guzebing <guzebing@bytedance.com>
>>
>> As implemented by the bio structure, we do the same thing on the
>> iomap-dio structure. Add a per-cpu cache for iomap_dio allocations,
>> enabling us to quickly recycle them instead of going through the slab
>> allocator.
>>
>> By making such changes, we can reduce memory allocation on the direct
>> IO path, so that direct IO will not block due to insufficient system
>> memory. In addition, for direct IO, the read performance of io_uring
>> is improved by about 2.6%.
> 
> Have you checked how much of that you'd get by using a dedicated
> slab cache that should also do per-cpu allocations?  Note that even
> if we had a dedicated per-cpu cache we'd probably still want that.
I’m sorry for the long delay in replying to your email due to some other 
matters. I hope you still remember this revision. First, thank you for 
your response.

Yes, I try to use a dedicated kmem cache to allocate cache for iomap-dio 
structure. However, when system memory is sufficient, kmalloc and kmem 
cache deliver identical performance.

For direct I/O reads on the ext4 file system, the test command is:

./t/io_uring -p0 -d128 -b4096 -s32 -c32 -F1 -B1 -R1 -X1 -n1 -P1 /mnt/004.txt

The measured performance is:

kmalloc: 750K IOPS
kmem cache: 750K IOPS
per-CPU cache: 770K IOPS
> 
> Also any chance you could factor this into common code?
> 
For a mempool, we first allocate with kmalloc or kmem cache and finally 
fall back to a reserved cache—this is for reliability. It’s not a great 
fit for our high‑performance scenario.

Additionally, the current need for frequent allocation/free (hundreds of 
thousands to millions of times per second) may be more suitable for the 
bio or dio structures; beyond those, I’m not sure whether similar 
scenarios exist.

If we were to extract a generic implementation solely for this, would it 
yield significant benefits? Do you have any good suggestions?

I’d appreciate your review.


