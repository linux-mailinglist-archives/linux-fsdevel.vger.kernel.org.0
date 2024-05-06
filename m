Return-Path: <linux-fsdevel+bounces-18799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C33B48BC64F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 05:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 145CEB21A9E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 03:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68A443AD2;
	Mon,  6 May 2024 03:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vekq48yL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7BE2D044;
	Mon,  6 May 2024 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714967343; cv=none; b=MNdTK8NS+7NgAZR7EI2qCgv7xwp1AXQsf83EaJvQhi3BB5dmZlvtX7cPYZtKQehTTl4lel2/1kAqJ4HS4LOIHjgeRD6s7j4hWREe42yamLjA0M58rdpOpBM6E5MTZWkoHukh85gtVbCWu6xr1vCsjfS84n3NZepntiI/rzsPLlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714967343; c=relaxed/simple;
	bh=kxz8UrFictU+NsZQY7c3vhSPA+qILia20awE6iLFv4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Isvdea/FF8ay1D+b8ivR5zdiXtkzGYqq7QXyOh0JE2MTYWTb7xpRaDMUEsFDz+xrkQfiw4emsqABGhITBc3eVJgGFEEKcsw3IsEbsZKQAoRQm67xW2mozyfyCYHLAfrZS5iwDqw+cGCQctXd4d796su7h/L4Z/daiGxxXZNNTNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vekq48yL; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714967337; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=j3Aqf3b+i7muF6AejD4CXK0yCEDvofmWz+0c/tM9NRY=;
	b=vekq48yL4AeTVEGP6yhx0BxoVI8nWWG3GGZK0j/IULUNFrC9TUOBDyyG8UptzxzxhufHvq0CISoQE7+TCLMM11fi8idzpRwJFPq4Hm+qrlc4VTHC5rwshQo9AZCB2Nu5ZTPORZUKn3sT1kWJs7PrndGF9Q2dgcmc8fpNnL2LEQA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5sGzlR_1714967335;
Received: from 30.221.146.217(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W5sGzlR_1714967335)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 11:48:56 +0800
Message-ID: <6e4a20f7-263a-46be-81cc-2667353c452d@linux.alibaba.com>
Date: Mon, 6 May 2024 11:48:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] cachefiles: remove request from xarry during flush
 requests
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-2-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240424033916.2748488-2-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> This prevents concurrency from causing access to a freed req.

Could you give more details on how the concurrent access will happen?
How could another process access the &cache->reqs xarray after it has
been flushed?

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

