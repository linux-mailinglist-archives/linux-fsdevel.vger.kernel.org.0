Return-Path: <linux-fsdevel+bounces-18790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4918BC5C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 04:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84761C2145E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 02:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800372E62C;
	Mon,  6 May 2024 02:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kVN0+SDY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2580181;
	Mon,  6 May 2024 02:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714962678; cv=none; b=IbCg7YmD4vh3Xf2hqM3HNsF6QlYPdU7G5IdO4A4idxKBpfQ3e/FVr6RXgH2HLUjkVg1pwFSB+5oSeA2xhKymQg0skx2kAVjg3ElVrJzhtUhG7mnh1NWiQV+31DeVrPD48dJQjQnWmdDjPhAxcd7IzjvQaDbDVaI2fXA2rz+bAoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714962678; c=relaxed/simple;
	bh=2pFWK0MLTTo2t+NIWJC3RactBtGq7GIQL3dy2XWRsr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izPxN8uoj0tiNT02vX3H7KlTxhGD0iD7niSdGDn4zjZDoRalRjP0yo3ZDgiwrbf5tVVNMf2IxTiG9B1u1ZrkYWgyw+7RoAlIPQcokxlnqAR0pX6CyRH2gazL/YZUwBIavF9C/EWToOztbnCuyTDnNHMlfC2/wIFC6mTTLzrQzJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kVN0+SDY; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714962667; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ob0YO4yjvcUQvEjXT5JdBhT5d+S7+Y7wcj+uRXLaRgQ=;
	b=kVN0+SDYsDehP9TM9vSpzb6LdDo62Q7wKQJKieBS1tk04ViH6xf/HYdt8kwe8H1NuP1oFxRIk39xkcLIADiuI2FMvscB2GliayG39x3aedaX51tcxWKJkEOusT43GKSb+2xdLerbrsqhSzB23SyUfX9EMuLtR4sTUT0mdazM3ck=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5pq6Lp_1714962665;
Received: from 30.221.146.217(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W5pq6Lp_1714962665)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 10:31:06 +0800
Message-ID: <75566e68-bb5f-4458-8140-a59f263cc98a@linux.alibaba.com>
Date: Mon, 6 May 2024 10:31:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] cachefiles: add consistency check for copen/cread
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-7-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240424033916.2748488-7-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Baokun,

Thanks for improving on this!

On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> This prevents malicious processes from completing random copen/cread
> requests and crashing the system. Added checks are listed below:
> 
>   * Generic, copen can only complete open requests, and cread can only
>     complete read requests.
>   * For copen, ondemand_id must not be 0, because this indicates that the
>     request has not been read by the daemon.
>   * For cread, the object corresponding to fd and req should be the same.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/cachefiles/ondemand.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index bb94ef6a6f61..898fab68332b 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -82,12 +82,12 @@ static loff_t cachefiles_ondemand_fd_llseek(struct file *filp, loff_t pos,
>  }
>  
>  static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
> -					 unsigned long arg)
> +					 unsigned long id)
>  {
>  	struct cachefiles_object *object = filp->private_data;
>  	struct cachefiles_cache *cache = object->volume->cache;
>  	struct cachefiles_req *req;
> -	unsigned long id;
> +	XA_STATE(xas, &cache->reqs, id);
>  
>  	if (ioctl != CACHEFILES_IOC_READ_COMPLETE)
>  		return -EINVAL;
> @@ -95,10 +95,15 @@ static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
>  	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>  		return -EOPNOTSUPP;
>  
> -	id = arg;
> -	req = xa_erase(&cache->reqs, id);
> -	if (!req)
> +	xa_lock(&cache->reqs);
> +	req = xas_load(&xas);
> +	if (!req || req->msg.opcode != CACHEFILES_OP_READ ||
> +	    req->object != object) {
> +		xa_unlock(&cache->reqs);
>  		return -EINVAL;
> +	}
> +	xas_store(&xas, NULL);
> +	xa_unlock(&cache->reqs);
>  
>  	trace_cachefiles_ondemand_cread(object, id);
>  	complete(&req->done);
> @@ -126,6 +131,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  	unsigned long id;
>  	long size;
>  	int ret;
> +	XA_STATE(xas, &cache->reqs, 0);
>  
>  	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>  		return -EOPNOTSUPP;
> @@ -149,9 +155,16 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  	if (ret)
>  		return ret;
>  
> -	req = xa_erase(&cache->reqs, id);
> -	if (!req)
> +	xa_lock(&cache->reqs);
> +	xas.xa_index = id;
> +	req = xas_load(&xas);
> +	if (!req || req->msg.opcode != CACHEFILES_OP_OPEN ||
> +	    !req->object->ondemand->ondemand_id) {
> +		xa_unlock(&cache->reqs);
>  		return -EINVAL;
> +	}
> +	xas_store(&xas, NULL);
> +	xa_unlock(&cache->reqs);
>  
>  	/* fail OPEN request if copen format is invalid */
>  	ret = kstrtol(psize, 0, &size);

The code looks good to me, but I still have some questions.

First, what's the worst consequence if the daemon misbehaves like
completing random copen/cread requests? I mean, does that affect other
processes on the system besides the direct users of the ondemand mode,
e.g. will the misbehavior cause system crash?

Besides, it seems that the above security improvement is only "best
effort".  It can not completely prevent a malicious misbehaved daemon
from completing random copen/cread requests, right?

-- 
Thanks,
Jingbo

