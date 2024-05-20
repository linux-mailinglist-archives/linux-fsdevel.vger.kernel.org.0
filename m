Return-Path: <linux-fsdevel+bounces-19750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E444F8C9920
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 09:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217421C20D59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 07:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED83182DB;
	Mon, 20 May 2024 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aXET4ZKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58D91B7F4;
	Mon, 20 May 2024 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716188965; cv=none; b=gAHc2GFduqaGVWK2+n3uGPsFXHy9xFMJPaRk3zzH3Q4gkLYzC3l7yrsyJaeiiR9QjiwG1p8zE/NTtdhVYLop+ffVHUFZnX6CZzKLJFD3mOf3fyl+LV0EjNHQNdZ66cO1byM2yetj5uFqHCCUArUU5OGy9lWBfH7jh6NIaxom2Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716188965; c=relaxed/simple;
	bh=JmovHuASvA+p1UsintWL61loAHcJzRWLo3Jjwj74OjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbbRPMo4Fr28c3+KSIqq1TzFm190fDHjJFi6FXmtvh5t8lucn4lCqVlJXzqRJSDyJHYhF1nLWGUK3nIXndMoxdzi0THJuJtto9lnjm3L5JJKhJhLGzEPItQgDrjLzDBdc2LYJ7kZvHRbx7I6CI5xhtGYwZdTY73zIrDY8++9EuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aXET4ZKT; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716188954; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MDsSId074xo3EY1nI/gNouEZEC8qd9U9t2v9Vm9rIbo=;
	b=aXET4ZKTNGS4FY28AswQ7chQwxMwaiq285OgWDn7i+iV/yafqAbASX4rmkWBm0Ue11K4zTmDIRgcMaj/yaAtZFZnUp+eHFluI2Bz1446uMcYjtTw4N90uBQ+VC/Aq3/Fj0FCSL6Fv7xGvQh96P1rZof+yjZBquj8WbTgkzdE/P0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6ny017_1716188952;
Received: from 30.221.148.185(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W6ny017_1716188952)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 15:09:13 +0800
Message-ID: <764c7b94-9ca9-4288-b806-b3e99fbd05c5@linux.alibaba.com>
Date: Mon, 20 May 2024 15:09:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] cachefiles: remove request from xarry during
 flush requests
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-2-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240515084601.3240503-2-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Even with CACHEFILES_DEAD set, we can still read the requests, so in the
> following concurrency the request may be used after it has been freed:
> 
>      mount  |   daemon_thread1    |    daemon_thread2
> ------------------------------------------------------------
>  cachefiles_ondemand_init_object
>   cachefiles_ondemand_send_req
>    REQ_A = kzalloc(sizeof(*req) + data_len)
>    wait_for_completion(&REQ_A->done)
>             cachefiles_daemon_read
>              cachefiles_ondemand_daemon_read
>                                   // close dev fd
>                                   cachefiles_flush_reqs
>                                    complete(&REQ_A->done)
>    kfree(REQ_A)
>               xa_lock(&cache->reqs);
>               cachefiles_ondemand_select_req
>                 req->msg.opcode != CACHEFILES_OP_READ
>                 // req use-after-free !!!
>               xa_unlock(&cache->reqs);
>                                    xa_destroy(&cache->reqs)
> 
> Hence remove requests from cache->reqs when flushing them to avoid
> accessing freed requests.
> 
> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> ---
>  fs/cachefiles/daemon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 6465e2574230..ccb7b707ea4b 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -159,6 +159,7 @@ static void cachefiles_flush_reqs(struct cachefiles_cache *cache)
>  	xa_for_each(xa, index, req) {
>  		req->error = -EIO;
>  		complete(&req->done);
> +		__xa_erase(xa, index);
>  	}
>  	xa_unlock(xa);
>  

-- 
Thanks,
Jingbo

