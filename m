Return-Path: <linux-fsdevel+bounces-17606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A050F8B0146
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 07:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4005FB21A3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 05:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245AF15687B;
	Wed, 24 Apr 2024 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HLrEp3zX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1307E13CFAD
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 05:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937617; cv=none; b=Ieo2gU6vpQo9BLfqFL98WwmFqxyaOSy87gEk+j45eLXe9LSe/6KUHm6pw2gkfwNhb4XgPsE7Yqc+beAb80eR9lYjYEilqyuVE9OPoo0Sp6cK8oWHcZ4DBDqFuVa1epHR194aeW5wCrhG/LT+8yYbTe5F4muK4EAEx3L1fBWKFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937617; c=relaxed/simple;
	bh=CF+ts3A4hUIMuGaFQFIzKuPMzImW0nVYFO6/BZ05kUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAw/OYmbnDefBjdv+a0PKYdsXSbkOSV+pad6AkKD6TksJjZlRM/+x4eFy/JuY2aV2HvLD1aAS7D6OMiCcvlTx2D/0zgOfcyEqCs3rbmQZyhA38SfBCoY2Bk+48javoUU8LZ5SbTepSkeSrWQyJGEwvEhHzhoQxAAbroc+qw4dzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HLrEp3zX; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c74b27179dso2603380b6e.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 22:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713937615; x=1714542415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oav/nBjbNQkJSHj491t5Rtmwwi8lc2zcpFduDWDdqHo=;
        b=HLrEp3zXElsNeQq5ghg+IbasyFUOY45JCFvnv8QXVgdKv7Uw064/zhoP7EkxwZd3cB
         3vStyImj8UcsrgCirsRHfA1KwMU02SRFfkei+kbZV4mXigck8n4yxUZIsXDV53baxfmH
         +cxlMjHNEvDlGN/DJh2MqZU/qyucQazE5ULCU9SH9+VkH1iiuhMXbiFKJeZ8KwYnBL1Y
         bNdWl1mNSphqNJKn7HVmCQO6AM7R4tOyoHya0iQdphoibzsej9U2w5Ej0VKLkWNVirrN
         kJIZUCrvWi7Bb3z9Pbc8Kw7wkNoeFbgLkhdCHBWYsKpNpuC/fNQsVk7mSWdOxUDfemXx
         tm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713937615; x=1714542415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oav/nBjbNQkJSHj491t5Rtmwwi8lc2zcpFduDWDdqHo=;
        b=gjA3Gh/i7xf6eoKJoXNsLKXkHYeSq2ey3focyXu2nzn5TjdcqMtFJDy9m0OYRHLwmN
         PeHxukC60dZZCUf1PdrH0NJMo3loo84tp8rgLmGXkQqRUEfhR/LU3TZU5zf4XaSZLBIB
         Db8xWxAsG7elIPgxJ1I4Eh4k0GPSLHy6RkuIibE7S1aT2yxpa/iBB5IVXcoSvKqIwg+x
         725gPab7M39PI9B2drAbmUMDNb/Q7jaUM7SgSLS47fkEVwASXNayL199R6kurcN494XI
         rI3fJ7Iag1ecSJXVvn7AsuS/8s5MV47/LxX9NGwRKQr8lYyRuvmF4Nu1g5bFQnZwCy3I
         QJuA==
X-Forwarded-Encrypted: i=1; AJvYcCUn6zGlDuqsudfQa81qK7qFbmOTVCkq7N4syDFTkT7/tjD9oALr6ORB+DXVmBvDJ2CvOuVxIBFAWGRb43NWP5ZjEzmBamH/0FKGKFVFSA==
X-Gm-Message-State: AOJu0Yy/zfPPfB0ZouyxQNM3TLqkUunTXhEZeT5iSZmZL71XkI2s4hCE
	L3sZDdu7NuZgHmlJUqtnKmLAc/JiNSlS6JKLXT+q49832erMPLEoOXPafKDQUwE=
X-Google-Smtp-Source: AGHT+IGXNptk+olxPRJcLAW0W9h984MMeb0Lybawe6fqDXiy7gt7eKH1E3YmxBnctdni7giQ3i6BUw==
X-Received: by 2002:a05:6808:170e:b0:3c6:6e1:b166 with SMTP id bc14-20020a056808170e00b003c606e1b166mr1792336oib.28.1713937615179;
        Tue, 23 Apr 2024 22:46:55 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b006eae2d9298esm10560634pfu.194.2024.04.23.22.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 22:46:54 -0700 (PDT)
Message-ID: <a2593b0a-1ddc-4f87-8b6d-68900fdcf612@bytedance.com>
Date: Wed, 24 Apr 2024 13:46:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] cachefiles: add missing lock protection when polling
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, Baokun Li <libaokun1@huawei.com>
References: <20240424033409.2735257-1-libaokun@huaweicloud.com>
 <20240424033409.2735257-6-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240424033409.2735257-6-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/24 11:34, libaokun@huaweicloud.com 写道:
> From: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> Add missing lock protection in poll routine when iterating xarray,
> otherwise:
> 
> Even with RCU read lock held, only the slot of the radix tree is
> ensured to be pinned there, while the data structure (e.g. struct
> cachefiles_req) stored in the slot has no such guarantee.  The poll
> routine will iterate the radix tree and dereference cachefiles_req
> accordingly.  Thus RCU read lock is not adequate in this case and
> spinlock is needed here.
> 
> Fixes: b817e22b2e91 ("cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thanks for catching this.

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/daemon.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 6465e2574230..73ed2323282a 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -365,14 +365,14 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
>   
>   	if (cachefiles_in_ondemand_mode(cache)) {
>   		if (!xa_empty(&cache->reqs)) {
> -			rcu_read_lock();
> +			xas_lock(&xas);
>   			xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
>   				if (!cachefiles_ondemand_is_reopening_read(req)) {
>   					mask |= EPOLLIN;
>   					break;
>   				}
>   			}
> -			rcu_read_unlock();
> +			xas_unlock(&xas);
>   		}
>   	} else {
>   		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))

