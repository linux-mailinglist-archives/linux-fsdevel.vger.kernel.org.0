Return-Path: <linux-fsdevel+bounces-19754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195948C996E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 09:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BEA280A60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 07:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F9B1B970;
	Mon, 20 May 2024 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mpMWf3CO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B574F12B8B;
	Mon, 20 May 2024 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716190856; cv=none; b=CYgCSfRiDgxEqgRFix2SXN6/E898ZriHGCE2TKnnWYGSWRx53gCY+6rmudlQjJPIBGhzMiFho7MU0j1dugJfzYMhlnD6QyThAIk+tcSC7UwDMIAbHYB15gETydt5ad1vb8w4Hts+Ef6Hln6gUhX2rdGFRoKbkVwx5dTVy5GTVM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716190856; c=relaxed/simple;
	bh=rEglyoG4FdJOKzE03IYMWtomapTEwx50RRcDUiD5YFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnlrqRwF8F8q/zBUWesafyMxdSsCt0p2HzbjQMY8XK2Ov3EJIw/33TutYzyQmmhsvumHre+PvdMsaPUoMgx/ao5jIsdilKlZn+JwtW7Tp9mHdi+aVhnGQbJdFIt+ufE9fM3KmicimpdBMNCLLrNR7Z47TtunSm27THlHupQ0DBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mpMWf3CO; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716190851; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=crYhzYLF/Z9aGaDX2S1xu5VnG4QQ1Zxh17dm47AJQSo=;
	b=mpMWf3COln6H5eW4E6+uJXuWFMAHiKJVNqOz4yyUKFmqHKEtp8i6kkscxdZ+nNNl7HffD9vy8dvOAPjGB6HV35fPT1yvk+05O+vzLaPsKPDXR7G0it6koAnQe+a7UW5kYdg+C0Pt6vpWp7WhJ2ehWlANDqgfImKwwgYafHiMKuA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6nyCdl_1716190849;
Received: from 30.221.148.185(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W6nyCdl_1716190849)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 15:40:50 +0800
Message-ID: <af4b9591-d82e-4da3-b681-eb677369ced3@linux.alibaba.com>
Date: Mon, 20 May 2024 15:40:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] cachefiles: add output string to
 cachefiles_obj_[get|put]_ondemand_fd
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-6-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240515084601.3240503-6-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> This lets us see the correct trace output.
> 
> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>


Could we move this simple fix to the beginning of the patch set?

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  include/trace/events/cachefiles.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
> index 119a823fb5a0..bb56e3104b12 100644
> --- a/include/trace/events/cachefiles.h
> +++ b/include/trace/events/cachefiles.h
> @@ -130,6 +130,8 @@ enum cachefiles_error_trace {
>  	EM(cachefiles_obj_see_lookup_failed,	"SEE lookup_failed")	\
>  	EM(cachefiles_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\
>  	EM(cachefiles_obj_see_withdrawal,	"SEE withdrawal")	\
> +	EM(cachefiles_obj_get_ondemand_fd,      "GET ondemand_fd")      \
> +	EM(cachefiles_obj_put_ondemand_fd,      "PUT ondemand_fd")      \
>  	EM(cachefiles_obj_get_read_req,		"GET read_req")		\
>  	E_(cachefiles_obj_put_read_req,		"PUT read_req")
>  

-- 
Thanks,
Jingbo

