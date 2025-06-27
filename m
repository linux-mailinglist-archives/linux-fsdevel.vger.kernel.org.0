Return-Path: <linux-fsdevel+bounces-53123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FAAAEAC7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 04:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367A84E304D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 02:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588A7185955;
	Fri, 27 Jun 2025 02:02:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74360146A60;
	Fri, 27 Jun 2025 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750989765; cv=none; b=utHrv758g2xJu6H6iqllmO24CZk17o7r57VCB9MqdayqQyBpA62yEcgyYdBO5bxCRW6V47zX/GwFNl65kYsWPoelpOB/Oqy2MXxr1Z/9VW0s3r4n1Chx868yxssWQ6zrXH/2KVi6/a/gh7hrfNB9NUNVOCfgZJ4FaTQhpW1mgUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750989765; c=relaxed/simple;
	bh=Wvk2LUcGoFfjQos10WntkQegPwBeF5dyU/R+7fzYubU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sD1+Cu3wgb4LX1XHDLurKgjzIywC6l5aZFf+QDEFlip5evFmGwxZ2jpcS4ucK8Nyw5mYawuGwBLlXAIBDYOmgxSwq7h3geJrCyC8zttpdnATd5QwvwCVt7UIZ7n5I3KBppiKBzdhwrZr9ojGAg0wK27wO7aTwvdCz8+BM5sqSFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bSzGr3SXJzCsBL;
	Fri, 27 Jun 2025 09:58:12 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id BCBCA18006C;
	Fri, 27 Jun 2025 10:02:32 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Jun
 2025 10:02:31 +0800
Message-ID: <3398cb62-3666-4a79-84c1-3b967059cd77@huawei.com>
Date: Fri, 27 Jun 2025 10:02:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fs/buffer: remove the min and max limit checks in
 __getblk_slow()
To: Pankaj Raghav <p.raghav@samsung.com>
CC: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	<mcgrof@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<kernel@pankajraghav.com>, <gost.dev@samsung.com>, Matthew Wilcox
	<willy@infradead.org>, Zhang Yi <yi.zhang@huawei.com>, Yang Erkun
	<yangerkun@huawei.com>
References: <20250626113223.181399-1-p.raghav@samsung.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250626113223.181399-1-p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/6/26 19:32, Pankaj Raghav wrote:
> All filesystems will already check the max and min value of their block
> size during their initialization. __getblk_slow() is a very low-level
> function to have these checks. Remove them and only check for logical
> block size alignment.
>
> As this check with logical block size alignment might never trigger, add
> WARN_ON_ONCE() to the check. As WARN_ON_ONCE() will already print the
> stack, remove the call to dump_stack().
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Makes sense. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
> Changes since v3:
> - Use WARN_ON_ONCE on the logical block size check and remove the call
>    to dump_stack.
> - Use IS_ALIGNED() to check for aligned instead of open coding the
>    check.
>
>   fs/buffer.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index d61073143127..565fe88773c2 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1122,14 +1122,9 @@ __getblk_slow(struct block_device *bdev, sector_t block,
>   {
>   	bool blocking = gfpflags_allow_blocking(gfp);
>   
> -	if (unlikely(size & (bdev_logical_block_size(bdev) - 1) ||
> -		     (size < 512 || size > PAGE_SIZE))) {
> -		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
> -					size);
> -		printk(KERN_ERR "logical block size: %d\n",
> -					bdev_logical_block_size(bdev));
> -
> -		dump_stack();
> +	if (WARN_ON_ONCE(!IS_ALIGNED(size, bdev_logical_block_size(bdev)))) {
> +		printk(KERN_ERR "getblk(): block size %d not aligned to logical block size %d\n",
> +		       size, bdev_logical_block_size(bdev));
>   		return NULL;
>   	}
>   
>
> base-commit: b39f7d75dc41b5f5d028192cd5d66cff71179f35



