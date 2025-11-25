Return-Path: <linux-fsdevel+bounces-69794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C1EC8542A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 14:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5012A3AF9B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 13:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB15D24C68B;
	Tue, 25 Nov 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn23i8i/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F340238D22
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078745; cv=none; b=uXihlmB+ZtZWkeLCG4+FNopiUhnEtYDJj67SLaNVf7mxx3s4MVR0yQE2KaGQShy3NJ2zCBhaMvxcpmssiUXBDK3SmMjbMV9yXDrMXUIUTdajwvELeZrbveY5JkkJf+Arxia/aKtY3CgjGEKZ9JpRcm0isLeKe52AVf0jHwr8HfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078745; c=relaxed/simple;
	bh=f14XKdRLbAIaCqZKzl7GBicWGlFYtiJZvAmLderW2+o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JmZCXT0FZAaF8/u4htti8coiP0OCyuj60DpzlFFPdkE/NRjEdINv+LrVAyun19moc33ZPBlztBB0XvcE8bXE7FSpCIzeWYAW2PFtZGd9VrYMzIIGNTyhitlII+gBZpwveX+6yHMwg6JWCBHq0YwR7efyzADoFgVF+OeX+Q8tldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tn23i8i/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4775ae77516so53199745e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 05:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764078741; x=1764683541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kHOesweq24KF358s0vEumPsOYuhj+3ibk2FmOjZUv+4=;
        b=Tn23i8i/gAj7vqH1s1cK5d5zQm7b7yhVGSi/AE/Ivf2m+vkkXTZSCrGKTRHLTuQTa7
         +KvNFkU/QqK+sEYwmwE2Yb0UignIKpNtSGsqpMHs/CPGxcYMG/N8qiBawIMySNh8OD9L
         5CFkyX3nscW9U/c0Ixc1EDHO06SCrhsAKXgyg9EeZTPGrTiWs68K46R3tkvVE17xIQlY
         0Zwxtkt7V4Jn7BDMVmlugZm3dJgJc/uiAABbZzW2rEcSjTHEnOrqyDjv+jCOU9L7FiMM
         HA/ARVms1OdAi49sm7BTSYV6aRV0jfm40tamlOr9bgiYxozsxBCGcTL6bgfe+VIuWtOO
         M3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764078741; x=1764683541;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHOesweq24KF358s0vEumPsOYuhj+3ibk2FmOjZUv+4=;
        b=lswLYPLyDrGIdN8Lb5o2WoqWZRoKk9CyLS2cWPEc+yg7kgjMXXgHeri24jTu71VzQG
         dCEq1fzixpVhzqtPUbMay1Aw2PZA49BqW+hCRBQNbBjgZfyFhHOZnfeoY+SbhidsUNaq
         TVePN9oDbdyOJqxJRg5UPTbpzk53fhUm6Vv9DW4UasIl9pTnjAtDBszabjp6I89exUZN
         4TzK4UFYs9tM4669Y7dZGkzXDQ1eBa3oPgktCEtk29rVO5K19YZsStxJXhC8AANwjrS2
         9s86/hjzCAqnHOcdensCtW3aNHZ7Asr3YL+QCde2Im6JWvI/MeR61fZsFNSftMr943o9
         10pw==
X-Forwarded-Encrypted: i=1; AJvYcCWH9C9hufqeseb/azwor3oufprxyjupOzhI313ueDkgZQ2/tVnkbkBRUDNK8PrXjfApsGKlmgYsQw3xX6S4@vger.kernel.org
X-Gm-Message-State: AOJu0YxPiNAY4gEmmYKNrb/ak2iAa1H2QvYiec6oVpXKW2yZEk1EVXZt
	0szxrhsRImxa484Wh+UEmGxsPRutkeHgR6MpNYKLNZf1qENGNzRzSipx+wKKPQ==
X-Gm-Gg: ASbGncuZYjYnXAiC0WITXKydQFTJjZMFwTh3+rylzGfHEHYUPEWO9UCA/3pyzGI1AL5
	70mRbE77CVa4Zwy1OVMp5YvjY4oragEm9kwXQJ0toaddalve0K+MHhteBvKEqkTw8/W72qmcrx0
	+st7cEDvfEi2ViwIMjIx7vr2kEph54DGLbkQJSF1HITIqtCMtDClYAkKw8t0bDNtRReWkw1+1Di
	+6DDTdU839NnuSthDAo0p6+Ze/3BwdKl/t1fm+zVEG2JjeUoZpWdL7JFjLZS++/nf6rFcVwRdZt
	8IpVKCfutKL0itrau9oTFrIYa9UiX6dIy0ISruIyPfKGBhY5WMtKFkfrFdQ1+NnlW3rhGUl5TTg
	M3+0d9XCM179vII1nTFbXvapcBmvC4R5wdbyYH38fKU8T6mmodcqgecd9wEVKjvfGh3kZy5xTRZ
	X4YqYd20NBUv0VFRF2zUrwQKQh6lpHwZ3Ftb0KBvVR5GB3gBszoNsmztB/zdjcAJi4vq1oum9v
X-Google-Smtp-Source: AGHT+IFKl0FSWbmMlOH9ZWfAZWRSmX8BD6ohJLnDHz1PIktPZZElxLDCt4b4SkoYMkjbJJn+KqrIYg==
X-Received: by 2002:a5d:5d81:0:b0:42b:3ded:298d with SMTP id ffacd0b85a97d-42cc1d2d5ebmr16251211f8f.32.1764078741365;
        Tue, 25 Nov 2025 05:52:21 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3a81sm35280457f8f.26.2025.11.25.05.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 05:52:20 -0800 (PST)
Message-ID: <a80a1e7d-e387-448f-8095-0aa22a07af17@gmail.com>
Date: Tue, 25 Nov 2025 13:52:18 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC v2 00/11] Add dmabuf read/write via io_uring
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <fd10fe48-f278-4ed0-b96b-c4f5a91b7f95@amd.com>
 <905ff009-0e02-4a5b-aa8d-236bfc1a404e@gmail.com>
 <53be1078-4d67-470f-b1af-1d9ac985fbe2@amd.com>
Content-Language: en-US
In-Reply-To: <53be1078-4d67-470f-b1af-1d9ac985fbe2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/24/25 14:17, Christian König wrote:
> On 11/24/25 12:30, Pavel Begunkov wrote:
>> On 11/24/25 10:33, Christian König wrote:
>>> On 11/23/25 23:51, Pavel Begunkov wrote:
>>>> Picking up the work on supporting dmabuf in the read/write path.
>>>
>>> IIRC that work was completely stopped because it violated core dma_fence and DMA-buf rules and after some private discussion was considered not doable in general.
>>>
>>> Or am I mixing something up here?
>>
>> The time gap is purely due to me being busy. I wasn't CC'ed to those private
>> discussions you mentioned, but the v1 feedback was to use dynamic attachments
>> and avoid passing dma address arrays directly.
>>
>> https://lore.kernel.org/all/cover.1751035820.git.asml.silence@gmail.com/
>>
>> I'm lost on what part is not doable. Can you elaborate on the core
>> dma-fence dma-buf rules?
> 
> I most likely mixed that up, in other words that was a different discussion.
> 
> When you use dma_fences to indicate async completion of events you need to be super duper careful that you only do this for in flight events, have the fence creation in the right order etc...

I'm curious, what can happen if there is new IO using a
move_notify()ed mapping, but let's say it's guaranteed to complete
strictly before dma_buf_unmap_attachment() and the fence is signaled?
Is there some loss of data or corruption that can happen?

sg_table = map_attach()         |
move_notify()                   |
   -> add_fence(fence)           |
                                 | issue_IO(sg_table)
                                 | // IO completed
unmap_attachment(sg_table)      |
signal_fence(fence)             |

> For example once the fence is created you can't make any memory allocations any more, that's why we have this dance of reserving fence slots, creating the fence and then adding it.

Looks I have some terminology gap here. By "memory allocations" you
don't mean kmalloc, right? I assume it's about new users of the
mapping.

>>> Since I don't see any dma_fence implementation at all that might actually be the case.
>>
>> See Patch 5, struct blk_mq_dma_fence. It's used in the move_notify
>> callback and is signaled when all inflight IO using the current
>> mapping are complete. All new IO requests will try to recreate the
>> mapping, and hence potentially wait with dma_resv_wait_timeout().
> 
> Without looking at the code that approach sounds more or less correct to me.
> 
>>> On the other hand we have direct I/O from DMA-buf working for quite a while, just not upstream and without io_uring support.
>>
>> Have any reference?
> 
> There is a WIP feature in AMDs GPU driver package for ROCm.
> 
> But that can't be used as general purpose DMA-buf approach, because it makes use of internal knowledge about how the GPU driver is using the backing store.

Got it

> BTW when you use DMA addresses from DMA-buf always keep in mind that this memory can be written by others at the same time, e.g. you can't do things like compute a CRC first, then write to backing store and finally compare CRC.

Right. The direct IO path also works with user pages, so the
constraints are similar in this regard.

-- 
Pavel Begunkov


