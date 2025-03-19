Return-Path: <linux-fsdevel+bounces-44410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709B8A685C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3CB421BA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 07:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C0324F5A7;
	Wed, 19 Mar 2025 07:30:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A695B24EF98;
	Wed, 19 Mar 2025 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742369438; cv=none; b=dToP1fiigGdiYuVDH4A2tAt4eLdHzPdpn0awbpLbPsFAUhGScudEReeGe5Dqu38MtictZl3OX4iUMPfsqCzdNisVu9gdLzOVoqC+vysc/CAJ/9v7ZBUb/4nhxIPWdIDLQe7BW178fYti0mgigq4uwKdwpW519ymno5GPa/s3+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742369438; c=relaxed/simple;
	bh=0hGOOWdmOgCf+5kxUESmr9tUbSrvuY55OjKWBrFI4Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=teOOLJrABKO6UrcVnqJXJy8RRk7eUgJokkjeJ7aAGhsG4kHwt5DHxym6iaEmaZ+PGbVF1Zxlok3kyGvEhevpA4UudsxhAHgBh1UQNmgB4GPG2pJhAldr4IwMauRfKVp++g8DnavEZeScnwPRWGUvYR3Q0uzEiPheaN12lQOTemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZHgNC53CWz13Kjc;
	Wed, 19 Mar 2025 15:30:19 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 36C05140383;
	Wed, 19 Mar 2025 15:30:33 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 19 Mar
 2025 15:30:32 +0800
Message-ID: <9687c245-57ec-40c5-9d64-58bca09118ee@huawei.com>
Date: Wed, 19 Mar 2025 15:30:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ext4: correct the error handle in ext4_fallocate()
To: Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<yi.zhang@huawei.com>, <yukuai3@huawei.com>, <yangerkun@huawei.com>
References: <20250319023557.2785018-1-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250319023557.2785018-1-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/3/19 10:35, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> The error out label of file_modified() should be out_inode_lock in
> ext4_fallocate().
>
> Fixes: 2890e5e0f49e ("ext4: move out common parts into ext4_fallocate()")
> Reported-by: Baokun Li <libaokun1@huawei.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
Looks good. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>
>   fs/ext4/extents.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 1b028be19193..dcc49df190ed 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4744,7 +4744,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>   
>   	ret = file_modified(file);
>   	if (ret)
> -		return ret;
> +		goto out_inode_lock;
>   
>   	if ((mode & FALLOC_FL_MODE_MASK) == FALLOC_FL_ALLOCATE_RANGE) {
>   		ret = ext4_do_fallocate(file, offset, len, mode);



