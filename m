Return-Path: <linux-fsdevel+bounces-48181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82946AABC6D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 10:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2811BC105A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 07:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF994221FD5;
	Tue,  6 May 2025 07:42:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0BA1FDE19;
	Tue,  6 May 2025 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517356; cv=none; b=n7gJVSa3o2vp48CJ9rUuZT8Sp6olHyhx/lHHYJu//Rw1DkUI/Q52k6TgXvVPS6O2WgVBP5bLgl2FycR/qlcUzHdFafV7xZ9yblnFXOjsAAGqAiE4EEU6zdQEmW0XJergTOrg5AiUryIw8UtAByIf8tK/LR9sfO5kQu5aP8NkSVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517356; c=relaxed/simple;
	bh=dN3JxzmzfKQx5txosk3Kwvhw4v7wSJvxF0+5OyofU4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QWTK4TgozkrTguaxFOordTJtd4FNU37PXOGYZErzrHeeWvbodprd6FBlSMG4Z8Ydf4AMivM9Xa4RBH0GLR+tucmdfnsEAxgXXyMtfKm5vmAp4lA2BMeYLQ+pKRRctcdvXFB75LYDiSzUd+4nYSuLa7HPCT0+iWDIO087dKB75S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Zs9Kj3sbPz1R7d5;
	Tue,  6 May 2025 15:40:25 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 0125A140137;
	Tue,  6 May 2025 15:42:31 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 6 May
 2025 15:42:29 +0800
Message-ID: <1fd6eaa8-6e8a-44df-a00d-dfa42f2b81ce@huawei.com>
Date: Tue, 6 May 2025 15:42:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] ext4: ensure i_size is smaller than maxbytes
To: Zhang Yi <yi.zhang@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <wanghaichi0403@gmail.com>, <yi.zhang@huawei.com>,
	<yukuai3@huawei.com>, <yangerkun@huawei.com>
References: <20250506012009.3896990-1-yi.zhang@huaweicloud.com>
 <20250506012009.3896990-4-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250506012009.3896990-4-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/5/6 9:20, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> The inode i_size cannot be larger than maxbytes, check it while loading
> inode from the disk.
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
Looks good to me.

Reviewed-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/ext4/inode.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5691966a19e1..072b61140d12 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4922,7 +4922,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>   		ei->i_file_acl |=
>   			((__u64)le16_to_cpu(raw_inode->i_file_acl_high)) << 32;
>   	inode->i_size = ext4_isize(sb, raw_inode);
> -	if ((size = i_size_read(inode)) < 0) {
> +	size = i_size_read(inode);
> +	if (size < 0 || size > ext4_get_maxbytes(inode)) {
>   		ext4_error_inode(inode, function, line, 0,
>   				 "iget: bad i_size value: %lld", size);
>   		ret = -EFSCORRUPTED;



