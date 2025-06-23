Return-Path: <linux-fsdevel+bounces-52492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4AEAE3805
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC0F169009
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 08:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC0321638A;
	Mon, 23 Jun 2025 08:12:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F711531C1;
	Mon, 23 Jun 2025 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666333; cv=none; b=ieOAfVaHIWX6qU/xb3g+cD6d1B8cRQdnTcerqPrrLgrCRu7Vex+8LJ7MuT9rpbtS5n4nbRiV12ehHob54H4YyYIo85+u839d2OCVHfBgOQiRrbxmhujg14qfvqI2gJgDsAfteUTrK1uyHyj7/jTTmUGnt2Dd5d5XZSIYlH+NG4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666333; c=relaxed/simple;
	bh=hXKhHlHNMk7pOoXGAd2+6KTe9i9btpDxdYwJ8ahEF+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mbe0wOkyeV6YTmPqvwseN55RqoQZ+5B00mIeF1jM5vDzClHgMEMo/Uv+YCcdSQ6MARTuSgdKIFMUOhKUJ9Zd89Min8rFKLjJXSZGyrquv7jC6eeoTGVxrjEOYOylAI3gYG87hRbD8pJ2bH3GXUybipxdrIlFw4aVeMc0Qfn1b9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bQgkp3x8QztSLy;
	Mon, 23 Jun 2025 16:10:58 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 09C6414027D;
	Mon, 23 Jun 2025 16:12:08 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Jun
 2025 16:12:06 +0800
Message-ID: <df82bd94-3fe8-41ab-9a3b-b3fe75bdc0c4@huawei.com>
Date: Mon, 23 Jun 2025 16:12:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] ext4: correct the reserved credits for extent
 conversion
To: Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ojaswin@linux.ibm.com>, <yi.zhang@huawei.com>, <yukuai3@huawei.com>,
	<yangerkun@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
 <20250611111625.1668035-5-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250611111625.1668035-5-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/6/11 19:16, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> Now, we reserve journal credits for converting extents in only one page
> to written state when the I/O operation is complete. This is
> insufficient when large folio is enabled.
>
> Fix this by reserving credits for converting up to one extent per block in
> the largest 2MB folio, this calculation should only involve extents index
> and leaf blocks, so it should not estimate too many credits.
>
> Fixes: 7ac67301e82f ("ext4: enable large folio for regular file")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good to me. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>   fs/ext4/inode.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index b51de58518b2..67e37dd546eb 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2848,12 +2848,12 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>   	mpd->journalled_more_data = 0;
>   
>   	if (ext4_should_dioread_nolock(inode)) {
> +		int bpf = ext4_journal_blocks_per_folio(inode);
>   		/*
>   		 * We may need to convert up to one extent per block in
> -		 * the page and we may dirty the inode.
> +		 * the folio and we may dirty the inode.
>   		 */
> -		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
> -						PAGE_SIZE >> inode->i_blkbits);
> +		rsv_blocks = 1 + ext4_ext_index_trans_blocks(inode, bpf);
>   	}
>   
>   	if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)



