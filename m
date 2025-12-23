Return-Path: <linux-fsdevel+bounces-71968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB63CD8762
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 09:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CF77301CE7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 08:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D2C31ED79;
	Tue, 23 Dec 2025 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gy8L26Y3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9E72E764B;
	Tue, 23 Dec 2025 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766479124; cv=none; b=HoDa3ApCKcEIY8qWbJi9HXWVHEpJQyYJyJwn+docjJ55x0RKVq7hDDPWmQJSkPi3I0avk11zqUTCnn1b4OhMGtrK+Bu8u5gH4tLzNisKb8JNhXsK6NWeVrBK6W301PYs4Qu27iax+20T/MWMDAyR7ZqCGPEF8rorzPMqB0/x5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766479124; c=relaxed/simple;
	bh=lhRBTJQgqwoEW62/N+lrF6xMNHa+KISsQvK3sbRSWnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Za68cEZrhPcwSgAw4z09Blnfha0Ih/VLEAEdZGvl9QK4vbPrGffsdT7HEOrsOW+7Se2JGQ8uIRqZhQ7a3qazG7srqhzqWIImgYaWgxmNyW90qK19XoaFEISZSP0JHLqwyE1RDdaX6iIgFhgm5btXaS78my2fz6pXMhZz8uXz92g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gy8L26Y3; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766479117; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+DP/2H+xQ/7iGwEiUHefMl7ZgQSgQwx2Uhv6QHxu8mg=;
	b=gy8L26Y3UvfqxK3C/WaeszRXeR4BwSlv+M/1/O1Ebkuw9KNuRMkGcq6PgHhu6INUn7TZ26NelMzlYpOlDaG64db8f8R+OzreTeKX4/QCQCS5lpOMcw9Mi7k5BCAEqZOAn4em0h2PPBK/3w6Y7ZbyxBTJiJmvnRpe3lSe1lppriE=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvX383x_1766479116 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 16:38:37 +0800
Message-ID: <5140f1e6-a669-479c-9e59-7bbf2191f546@linux.alibaba.com>
Date: Tue, 23 Dec 2025 16:38:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 10/10] erofs: implement .fadvise for page cache share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>, brauner@kernel.org,
 "Darrick J. Wong" <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 hch@lst.de
References: <20251223020008.485685-1-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223020008.485685-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/23 10:00, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This patch implements the .fadvise interface for page cache share.
> Similar to overlayfs, it drops those clean, unused pages through
> vfs_fadvise().
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

This should be sent out together within the series next time.

> ---
>   fs/erofs/ishare.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> index 269b53b3ed79..d7231953cba2 100644
> --- a/fs/erofs/ishare.c
> +++ b/fs/erofs/ishare.c
> @@ -187,6 +187,16 @@ static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
>   	return generic_file_readonly_mmap(file, vma);
>   }
>   
> +static int erofs_ishare_fadvise(struct file *file, loff_t offset,
> +				      loff_t len, int advice)
> +{
> +	struct file *realfile = file->private_data;
> +
> +	if (!realfile)
> +		return -EINVAL;

BTW, when file->private_data == NULL here?

I think it can only happen if buggy, so just:

	return vfs_fadvise((struct file *)file->private_data,
			   offset, len, advice);
Thanks,
Gao Xiang

> +	return vfs_fadvise(realfile, offset, len, advice);
> +}
> +
>   const struct file_operations erofs_ishare_fops = {
>   	.open		= erofs_ishare_file_open,
>   	.llseek		= generic_file_llseek,
> @@ -195,6 +205,7 @@ const struct file_operations erofs_ishare_fops = {
>   	.release	= erofs_ishare_file_release,
>   	.get_unmapped_area = thp_get_unmapped_area,
>   	.splice_read	= filemap_splice_read,
> +	.fadvise	= erofs_ishare_fadvise,
>   };
>   
>   /*


