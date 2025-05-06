Return-Path: <linux-fsdevel+bounces-48179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6427EAABC2C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC63F50544F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 07:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BA9220F2E;
	Tue,  6 May 2025 07:39:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053321A8F98;
	Tue,  6 May 2025 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517174; cv=none; b=fd9PZeXpm3d6kvd6u10s8j7ZMoJzTSP63uQC8sarils/nHETOpk9bPHNtsidl6p7XY6gpANG1G7qy0bBiKCTkx8nNUglhstZvO5FKX2PqTA3NELKjWlRVUXearJkHSmxMEM4yFtWX2lPvkntQQ2ATU0JhQGGrQ1KN6XRM/Zmf5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517174; c=relaxed/simple;
	bh=0o3EaABDzLjJKUA/d9bH15nVFsp9JHg3owNInp78noU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n4w6z2Tcqr9TY1cwY6g02cjRiRpC1g94/ZdAlnDAkg71votDQKx4+M3PBC60T/NK1ejwF1yOJSbwndbTvWGdyzCJBPLyiyrGNQNGqXR6V1MsBbr3Amt9fjCRcFeH0W4yot25Rj45WVQcd+wQZUzu9LrzdzwP7F8ovFIq2e9Nrkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Zs9Hz6Fbdz2TSFS;
	Tue,  6 May 2025 15:38:55 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id E41D0180044;
	Tue,  6 May 2025 15:39:28 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 6 May
 2025 15:39:27 +0800
Message-ID: <a40b2f88-8590-485b-9542-3a7b120a1b17@huawei.com>
Date: Tue, 6 May 2025 15:39:27 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] ext4: fix incorrect punch max_end
To: Zhang Yi <yi.zhang@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <wanghaichi0403@gmail.com>, <yi.zhang@huawei.com>,
	<yukuai3@huawei.com>, <yangerkun@huawei.com>
References: <20250506012009.3896990-1-yi.zhang@huaweicloud.com>
 <20250506012009.3896990-2-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250506012009.3896990-2-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/5/6 9:20, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> For the extents based inodes, the maxbytes should be sb->s_maxbytes
> instead of sbi->s_bitmap_maxbytes. Additionally, for the calculation of
> max_end, the -sb->s_blocksize operation is necessary only for
> indirect-block based inodes. Correct the maxbytes and max_end value to
> correct the behavior of punch hole.
>
> Fixes: 2da376228a24 ("ext4: limit length to bitmap_maxbytes - blocksize in punch_hole")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Looks good to me.

Reviewed-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/ext4/inode.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 4ec4a80b6879..5691966a19e1 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4006,7 +4006,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>   	struct inode *inode = file_inode(file);
>   	struct super_block *sb = inode->i_sb;
>   	ext4_lblk_t start_lblk, end_lblk;
> -	loff_t max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
> +	loff_t max_end = sb->s_maxbytes;
>   	loff_t end = offset + length;
>   	handle_t *handle;
>   	unsigned int credits;
> @@ -4015,14 +4015,20 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>   	trace_ext4_punch_hole(inode, offset, length, 0);
>   	WARN_ON_ONCE(!inode_is_locked(inode));
>   
> +	/*
> +	 * For indirect-block based inodes, make sure that the hole within
> +	 * one block before last range.
> +	 */
> +	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> +		max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
> +
>   	/* No need to punch hole beyond i_size */
>   	if (offset >= inode->i_size || offset >= max_end)
>   		return 0;
>   
>   	/*
>   	 * If the hole extends beyond i_size, set the hole to end after
> -	 * the page that contains i_size, and also make sure that the hole
> -	 * within one block before last range.
> +	 * the page that contains i_size.
>   	 */
>   	if (end > inode->i_size)
>   		end = round_up(inode->i_size, PAGE_SIZE);



