Return-Path: <linux-fsdevel+bounces-71960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 959A1CD8625
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 08:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4222530184CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 07:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CD730BF6C;
	Tue, 23 Dec 2025 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o1h0nrTa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026CC2C08C4;
	Tue, 23 Dec 2025 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766474739; cv=none; b=cMS/UyYvNZbESsP2Vxf8aWMynXnyW8u2oJst9AcS45OIyqb6eAUgdlKsiU3Ai3cbhVIw0WaItAW/kgJ63amFSZlUttUnaIggJz7F1/u5mWba1LAvf6ahD/WDzsp3gjgrifkitWgk8M92ZKWwPgZS1vVvpWdRqRfcdFw1yR/g2xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766474739; c=relaxed/simple;
	bh=nFjX+Xsybyl+oeeOQMbEnjKO/ZrmACkWZus0H2twlDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMUA8VaCBgSD8LgRcxvDZnNFQPhOQYM06bOJXjlcsyDpFuUB50tTWHaBrqa50xS7aXyTGc9hxFwHvHsbwcsp65QcPchVmO44zoJ/1/37nxUHoPvjInKTo28SkzXkS0S305KDP7h42O9lfCiQIelzSChwP/0eBvpMAgh3Uree2Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o1h0nrTa; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766474732; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tQ5aaW+JIVi4pwu5f+2uAzYLLI/373W8689SDLPl7io=;
	b=o1h0nrTaRdQTl5yRD+CUCJjuDf83RjK233lj5qho8wy/ySDtC84NNM6t6HoCosbddyKYQKTHYLOuwpSPVifg4RCKDM2OUqsluah7UHLrFeQIqt9cOfG/nrodVusTuRG6j6pS0pqxA/JGMHDuOVjb0kaF2w/SprpReD2KLkEgh9g=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvWoHI2_1766474731 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 15:25:31 +0800
Message-ID: <94872052-84c3-4163-9bea-3ec9d5778b23@linux.alibaba.com>
Date: Tue, 23 Dec 2025 15:25:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/10] erofs: support domain-specific page cache share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-7-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223015618.485626-7-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/23 09:56, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> Only files in the same domain will share the page cache. Also modify
> the sysfs related content in preparation for the upcoming page cache
> share feature.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/super.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 68480f10e69d..be9f96252c6c 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -518,6 +518,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   		if (!sbi->fsid)
>   			return -ENOMEM;
>   		break;
> +#endif
> +#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
>   	case Opt_domain_id:
>   		kfree(sbi->domain_id);
>   		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
> @@ -618,7 +620,7 @@ static void erofs_set_sysfs_name(struct super_block *sb)
>   {
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   
> -	if (sbi->domain_id)
> +	if (sbi->domain_id && !erofs_sb_has_ishare_xattrs(sbi))
>   		super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
>   					     sbi->fsid);
>   	else if (sbi->fsid)
> @@ -1052,6 +1054,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>   #ifdef CONFIG_EROFS_FS_ONDEMAND

here.

>   	if (sbi->fsid)
>   		seq_printf(seq, ",fsid=%s", sbi->fsid);
> +#endif
> +#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)

I think we could just kill these `#if` entirely since
`sbi->domain_id` and `sbi->fsid` are defined
unconditionally.

Otherwise it looks good to me:
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

