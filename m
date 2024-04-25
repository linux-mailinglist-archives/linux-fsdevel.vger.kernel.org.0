Return-Path: <linux-fsdevel+bounces-17710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 313338B1A11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 06:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B48284D25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 04:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB97F39FD6;
	Thu, 25 Apr 2024 04:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SIkE3VWH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957EF2C697
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 04:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714021016; cv=none; b=q08IOfypob+bC02bCYHCIFAv6Na2hjbBpnWbTtQoJxdGL/G3gH+cP0qfJBGPux2QrdssDAfFztFhRqHM5y33ZV1ga5IZgnFP57amiPN7n7G1EYiBDsy5BX8Vkz2pg/mVt4vdAeJgIL64Bo6HBoZ6StKbn2wPgHiQpHiLEmBRrgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714021016; c=relaxed/simple;
	bh=Pli5F8AnSKspK5aT0/lVVdtVxvdyhbgTwOdQGvsPv/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEjcnMxqti1JvdmTPSQj+LGMXhBY6Z2S0v6cnKumqJ5dNj4n/wmEO+FqZwHuNa6eOEibUFd64AfjOxzbC7oxBQq9F4oj5tbWLsAR29b3alCzNmbj3jq3a+YMYrA5edbJ0gt8NURx1kkOpI0LatDQG5lsGl/hO3WTs/YXGKRZXFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SIkE3VWH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f043f9e6d7so630134b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 21:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714021014; x=1714625814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKeDMR/VAwY6KFTp7q+D4M4FMjxN7DS4mVLtRqQA6Ps=;
        b=SIkE3VWHuphvLl7NOhjQq7Nkh9WeBBu84dzIf1WYHLMCfhSz6cIo1AAb9gtEEN+V09
         j3XgFvLtTx4P3kaJzs6PtylnirDue+lnKo7b2F7nCSPQndL4HzG3oPasG2NjjNqvVkCM
         T+BGd9N2l6xgty705iubHWpa9UJOdIbA43XeCGFjkTfmbrVOF/r4VlEzMurm9QUpGXI3
         diSOy/n0mkFg1cbGq1yiF6M0gXzrHl+6SUqCAGHD/0txT8SF334h8YrakG/Y61+BYusQ
         6SY6kVKLZN2NzfpaxNI3cX/yGc7km4phtFbMKBaBtMWlKJepK8WBNy0ErU8uOKTV+p61
         YO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714021014; x=1714625814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BKeDMR/VAwY6KFTp7q+D4M4FMjxN7DS4mVLtRqQA6Ps=;
        b=LOxNQGk3fa4Ce+JqrOFLvMTh19IWVSHc50QgSsPDoiir8vvNtzmaV7C+aCF93j8ZjA
         bpAMJIbmsUMsiseV0eWfzj16Jei5rD0R8Leys6YrXHaiKPV2SuQ5O/dQNN6SsxFdDb7i
         DC62D7lpc8i94B9pOIaMMOzAbyz3t+IBRojwrfFjX/QciKWR+5JZeWMu9CJSceaMRqLY
         2xaskqpLDzRPBonuy7t/wlUZ59T/oAWDIU5FkyXbN/EoEDc1KJ6rvnGnOLZjXPKSEIXO
         qpNxJZOKvTlN8q7PUHWoIvhD0WRLea147thuH50GymtIjuU0b3aGlf3tkoPVGcerztYK
         5Xgw==
X-Forwarded-Encrypted: i=1; AJvYcCVHUlzVH3W5GdSxUpuQd0Siqggpiiik6VL7oXNpskk766HRUq5/0y1WU12aPggcrJeWTiNgasvNpe/5bs9hHhgmi3GUz9Oh37khuOHdBA==
X-Gm-Message-State: AOJu0YySnxzQMjIMrwmBgcaCcbEnv0CWhiXYNPTi5nvCWIXbwtF0Mo0A
	ZyLbv0pDO59uv0dWX23v80dp2XT2ZMN7dDGj7kAwDi4hcQLnx0HxkGJ2ViUpurI=
X-Google-Smtp-Source: AGHT+IFhv2H4/vzmguAbVa1ZZdUzUVWqiOvj6TC3VDCEFSUjKANEKZ1zNzViwGoIP2V0IpdAALwTxQ==
X-Received: by 2002:a05:6a20:840a:b0:1a7:7818:720e with SMTP id c10-20020a056a20840a00b001a77818720emr5781273pzd.21.1714021013910;
        Wed, 24 Apr 2024 21:56:53 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id r6-20020a17090a5c8600b002ade3490b4asm6319376pji.22.2024.04.24.21.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 21:56:53 -0700 (PDT)
Message-ID: <32f04cea-1c41-4c16-98fb-86be6ecefc87@bytedance.com>
Date: Thu, 25 Apr 2024 12:56:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] cachefiles: Set object to close if ondemand_id < 0
 in copen
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zizhi Wo <wozizhi@huawei.com>,
 Baokun Li <libaokun1@huawei.com>, zhujia.zj@bytedance.com
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-11-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240424033916.2748488-11-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/24 11:39, libaokun@huaweicloud.com 写道:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> If copen is maliciously called in the user mode, it may delete the request
> corresponding to the random id. And the request may have not been read yet.
> 
> Note that when the object is set to reopen, the open request will be done
> with the still reopen state in above case. As a result, the request
> corresponding to this object is always skipped in select_req function, so
> the read request is never completed and blocks other process.
> 
> Fix this issue by simply set object to close if its id < 0 in copen.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/ondemand.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 7c2d43104120..673e7ad52041 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -182,6 +182,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>   	xas_store(&xas, NULL);
>   	xa_unlock(&cache->reqs);
>   
> +	info = req->object->ondemand;
>   	/* fail OPEN request if copen format is invalid */
>   	ret = kstrtol(psize, 0, &size);
>   	if (ret) {
> @@ -201,7 +202,6 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>   		goto out;
>   	}
>   
> -	info = req->object->ondemand;
>   	spin_lock(&info->lock);
>   	/* The anonymous fd was closed before copen ? */
>   	if (info->ondemand_id == CACHEFILES_ONDEMAND_ID_CLOSED) {
> @@ -222,6 +222,11 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>   	wake_up_all(&cache->daemon_pollwq);
>   
>   out:
> +	spin_lock(&info->lock);
> +	/* Need to set object close to avoid reopen status continuing */
> +	if (info->ondemand_id == CACHEFILES_ONDEMAND_ID_CLOSED)
> +		cachefiles_ondemand_set_object_close(req->object);
> +	spin_unlock(&info->lock);
>   	complete(&req->done);
>   	return ret;
>   }

