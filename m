Return-Path: <linux-fsdevel+bounces-52493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0191AE3809
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC217A853E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 08:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B98821638A;
	Mon, 23 Jun 2025 08:12:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C21E0DD8;
	Mon, 23 Jun 2025 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666363; cv=none; b=utnEYgIwOc1q0o2CJB0FGR48MEwYrPUfWFzDS8ZQ6OlFYgdTznnbPH3xMiXftMb886FTDOLdyN07l8jn8V7RSBGpi6pM8r3Dj/Th2I86TyN0g2icoEwfczfkPW6nSjIKxSc/oKaMmgMyS2hSU9jNnAfQKBSSKOzFzwN2AnwySrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666363; c=relaxed/simple;
	bh=GlRv4e6jn0lrwjfx31u6KdO0Bvae9xSwKyzJfOxW1YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PYI3DEBXDRqhZLFPYAChnynLNNFRatVDGYICKqN2uhTjRIFXO8TeEP3PAVgusBY/2bV5ti43/WVZuydGqqzlDqB3vuPncxzR6xPIX6MZP4aHM99p/6amCTo+JLxpxBOaZUe2O0puikCK9oD7eqiYxDgtXjdudATtqurLFsEPTzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bQgkw0mjSz2TSLJ;
	Mon, 23 Jun 2025 16:11:04 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id BEB1014027A;
	Mon, 23 Jun 2025 16:12:38 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Jun
 2025 16:12:37 +0800
Message-ID: <f71c6d59-8d5f-46c0-bf17-51b0e7c9a6c8@huawei.com>
Date: Mon, 23 Jun 2025 16:12:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] ext4: fix insufficient credits calculation in
 ext4_meta_trans_blocks()
To: Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ojaswin@linux.ibm.com>, <yi.zhang@huawei.com>, <yukuai3@huawei.com>,
	<yangerkun@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
 <20250611111625.1668035-7-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250611111625.1668035-7-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/6/11 19:16, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> The calculation of journal credits in ext4_meta_trans_blocks() should
> include pextents, as each extent separately may be allocated from a
> different group and thus need to update different bitmap and group
> descriptor block.
>
> Fixes: 0e32d8617012 ("ext4: correct the journal credits calculations of allocating blocks")
> Reported-by: Jan Kara <jack@suse.cz>
> Closes: https://lore.kernel.org/linux-ext4/nhxfuu53wyacsrq7xqgxvgzcggyscu2tbabginahcygvmc45hy@t4fvmyeky33e/
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good to me. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>   fs/ext4/inode.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 9835145b1b27..9b6ebf823740 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -6218,7 +6218,7 @@ int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
>   	int ret;
>   
>   	/*
> -	 * How many index and lead blocks need to touch to map @lblocks
> +	 * How many index and leaf blocks need to touch to map @lblocks
>   	 * logical blocks to @pextents physical extents?
>   	 */
>   	idxblocks = ext4_index_trans_blocks(inode, lblocks, pextents);
> @@ -6227,7 +6227,7 @@ int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
>   	 * Now let's see how many group bitmaps and group descriptors need
>   	 * to account
>   	 */
> -	groups = idxblocks;
> +	groups = idxblocks + pextents;
>   	gdpblocks = groups;
>   	if (groups > ngroups)
>   		groups = ngroups;



