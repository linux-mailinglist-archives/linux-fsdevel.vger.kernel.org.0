Return-Path: <linux-fsdevel+bounces-20058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D138CD595
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 16:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0244E1C21C14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 14:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC414B95B;
	Thu, 23 May 2024 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oFTNxQVK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F21DFF0;
	Thu, 23 May 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474094; cv=none; b=Kq0mAuB8h/p5D5O4tU80IH7C/Wp1D9qCfgJdJOod12JiAacnnL5oQY7ao4epuIvdHzwRzh12WWugUuqFkaVcHzuxas0hDRRuCt6/WP0vCQN0Kdn9Ang+qqy0qR15VDOagvt3J3yhg9FspyPS41IQaNPtq+OCGHLNXvQc0iMX5Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474094; c=relaxed/simple;
	bh=FThYKozjn//4H2MpuuNRgDAHcvOBXsbMlqwA0ybup00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6m+AJMXqjbfYz2A1xb14fS8Ce3uhM6WN1+phfa8LzvIGQE28NaPtdewxThgNjbn0OBEpf3YPWKScC7XmlxxwD72vDCkmuFrdXOTxByykuEnsFnAsR/B4qy8SgGSPJGgf8hF7sUsDyKCNdYuzNOVbQciLRaiopC+aJ8wFijpBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oFTNxQVK; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716474088; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P7HnNkBnQuCqmu8zTIccJJaTZgTQr1fKN1BShJAXcUA=;
	b=oFTNxQVKXbIitYgvQgV4eyRK+sreKUySjtNe67CyaLI+yH5EDpimOIdC0/LommVVFVR9gRXYRyoV4WCpKm0TH7RskaIyEYu1AOFjktlmqP/x43q8AJGFh1yLlIZQ43e8v5TIfPXiROVqEPYqEdv0Dzs8xZ6PwmPj0cf5vh8bWR4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W739MMQ_1716474086;
Received: from 30.39.171.189(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W739MMQ_1716474086)
          by smtp.aliyun-inc.com;
          Thu, 23 May 2024 22:21:27 +0800
Message-ID: <9945b390-3572-4808-b08f-56af9cd3918e@linux.alibaba.com>
Date: Thu, 23 May 2024 22:21:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] cachefiles: remove err_put_fd label in
 cachefiles_ondemand_daemon_read()
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
 <20240522114308.2402121-6-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240522114308.2402121-6-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/22/24 7:43 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The err_put_fd label is only used once, so remove it to make the code
> more readable. In addition, the logic for deleting error request and
> CLOSE request is merged to simplify the code.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/cachefiles/ondemand.c | 45 ++++++++++++++--------------------------
>  1 file changed, 16 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 3dd002108a87..bb94ef6a6f61 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -305,7 +305,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  {
>  	struct cachefiles_req *req;
>  	struct cachefiles_msg *msg;
> -	unsigned long id = 0;
>  	size_t n;
>  	int ret = 0;
>  	XA_STATE(xas, &cache->reqs, cache->req_id_next);
> @@ -340,49 +339,37 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	cachefiles_grab_object(req->object, cachefiles_obj_get_read_req);
>  	xa_unlock(&cache->reqs);
>  
> -	id = xas.xa_index;
> -
>  	if (msg->opcode == CACHEFILES_OP_OPEN) {
>  		ret = cachefiles_ondemand_get_fd(req);
>  		if (ret) {
>  			cachefiles_ondemand_set_object_close(req->object);
> -			goto error;
> +			goto out;
>  		}
>  	}
>  
> -	msg->msg_id = id;
> +	msg->msg_id = xas.xa_index;
>  	msg->object_id = req->object->ondemand->ondemand_id;
>  
>  	if (copy_to_user(_buffer, msg, n) != 0) {
>  		ret = -EFAULT;
> -		goto err_put_fd;
> -	}
> -
> -	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
> -	/* CLOSE request has no reply */
> -	if (msg->opcode == CACHEFILES_OP_CLOSE) {
> -		xa_erase(&cache->reqs, id);
> -		complete(&req->done);
> +		if (msg->opcode == CACHEFILES_OP_OPEN)
> +			close_fd(((struct cachefiles_open *)msg->data)->fd);
>  	}
> -
> -	cachefiles_req_put(req);
> -	return n;
> -
> -err_put_fd:
> -	if (msg->opcode == CACHEFILES_OP_OPEN)
> -		close_fd(((struct cachefiles_open *)msg->data)->fd);
> -error:
> +out:
>  	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
> -	xas_reset(&xas);
> -	xas_lock(&xas);
> -	if (xas_load(&xas) == req) {
> -		req->error = ret;
> -		complete(&req->done);
> -		xas_store(&xas, NULL);
> +	/* Remove error request and CLOSE request has no reply */
> +	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
> +		xas_reset(&xas);
> +		xas_lock(&xas);
> +		if (xas_load(&xas) == req) {
> +			req->error = ret;
> +			complete(&req->done);
> +			xas_store(&xas, NULL);
> +		}
> +		xas_unlock(&xas);
>  	}
> -	xas_unlock(&xas);
>  	cachefiles_req_put(req);
> -	return ret;
> +	return ret ? ret : n;
>  }
>  
>  typedef int (*init_req_fn)(struct cachefiles_req *req, void *private);

-- 
Thanks,
Jingbo

