Return-Path: <linux-fsdevel+bounces-67692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA1EC471E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E176A4EC98A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 14:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FE431281D;
	Mon, 10 Nov 2025 14:13:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF73126C7;
	Mon, 10 Nov 2025 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784018; cv=none; b=du4mQUpU/BJ9dvcZIfd7MGwc1f2eMvW+iMWvf21kp4Oi2RMU91C7R0NA5/KEOi7y+3znh8Y5r9m5+2PbWoqUeCuQkitJ81oRDqIzi77nLARdO4o3oJhAn4H3VewPkX/eD+VwcCN+8CGKSAKV5GLMls7b2j+DnIlHK8krBkC/HY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784018; c=relaxed/simple;
	bh=7tIWrGouMUaytXUKW8IlvpRs6GDUMAJ2YsLhkWoK6Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krVQJdh62V9pBUI/FLoMnjj86uH5B7T3NdWGO2V/bOxeHGpOWSq+d7NvgkJAAY5Bd0q6TgvvZFoiZ1iPWHXRZD1SbsLZjvDnpA6VR4XWuF1Hmm0bJ8UH1sUe5XN9nc4o0Va+PmAxOduF+ZkpRmf7eqa7wNjQkKillC+EUe7cXqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d4s8F02v6zKHMjR;
	Mon, 10 Nov 2025 22:13:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B160E1A0847;
	Mon, 10 Nov 2025 22:13:31 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgAHZXsH8xFp7DgWAQ--.14837S3;
	Mon, 10 Nov 2025 22:13:29 +0800 (CST)
Message-ID: <2b8a6767-5e37-48e1-b75c-cd16005580a7@huaweicloud.com>
Date: Mon, 10 Nov 2025 22:13:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bdev: add hint prints in sb_set_blocksize() for LBS
 dependency on THP
To: libaokun@huaweicloud.com, linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk,
 axboe@kernel.dk, linux-block@vger.kernel.org, yangerkun@huawei.com,
 libaokun1@huawei.com, Theodore Ts'o <tytso@mit.edu>
References: <20251110124714.1329978-1-libaokun@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251110124714.1329978-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAHZXsH8xFp7DgWAQ--.14837S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47Wr4xGFyrKr4fXrWxXrb_yoW8ur18pF
	y8Gr1rAr18KF1xuFy7Z3ZxJasa9ws5JFyUJ34xuFyjvryDt34fGr93Kry5XF4IvrsxCrZ3
	XFsrKFWI9r1UW3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 11/10/2025 8:47 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Support for block sizes greater than the page size depends on large
> folios, which in turn require CONFIG_TRANSPARENT_HUGEPAGE to be enabled.
> 
> Because the code is wrapped in multiple layers of abstraction, this
> dependency is rather obscure, so users may not realize it and may be
> unsure how to enable LBS.
> 
> As suggested by Theodore, I have added hint messages in sb_set_blocksize
> so that users can distinguish whether a mount failure with block size
> larger than page size is due to lack of filesystem support or the absence
> of CONFIG_TRANSPARENT_HUGEPAGE.
> 
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Link: https://patch.msgid.link/20251110043226.GD2988753@mit.edu
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  block/bdev.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 810707cca970..4888831acaf5 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -217,9 +217,26 @@ int set_blocksize(struct file *file, int size)
>  
>  EXPORT_SYMBOL(set_blocksize);
>  
> +static int sb_validate_large_blocksize(struct super_block *sb, int size)
> +{
> +	const char *err_str = NULL;
> +
> +	if (!(sb->s_type->fs_flags & FS_LBS))
> +		err_str = "not supported by filesystem";
> +	else if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		err_str = "is only supported with CONFIG_TRANSPARENT_HUGEPAGE";
> +
> +	if (!err_str)
> +		return 0;
> +
> +	pr_warn_ratelimited("%s: block size(%d) > page size(%lu) %s\n",
> +				sb->s_type->name, size, PAGE_SIZE, err_str);
> +	return -EINVAL;
> +}
> +
>  int sb_set_blocksize(struct super_block *sb, int size)
>  {
> -	if (!(sb->s_type->fs_flags & FS_LBS) && size > PAGE_SIZE)
> +	if (size > PAGE_SIZE && sb_validate_large_blocksize(sb, size))
>  		return 0;
>  	if (set_blocksize(sb->s_bdev_file, size))
>  		return 0;


