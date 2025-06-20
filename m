Return-Path: <linux-fsdevel+bounces-52283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6039BAE10D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 03:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E4B4A05C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 01:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C6C86334;
	Fri, 20 Jun 2025 01:51:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8A7A59;
	Fri, 20 Jun 2025 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750384277; cv=none; b=K/PWzfJIqS10IXTJP3fheCBVxEdHEu0SrKXB9P3AnAJnBa2tv5kO8/QUVE+a+jcwZABxglf1mruB4P9X5Qu4j6+bZJkfUcHwH7GR3Q1ZFUU9L9MFXWVgSINgl9jbE/JDOyc5qVYUnBgLSOCGDXimUu98Z4GhdCOr/GbD28MMXjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750384277; c=relaxed/simple;
	bh=OzTYdDM5QOAK90iSCpBC+SNf3hrDZRU2+8gRs9tim1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qNbjLivFdR+l/OsYzfRxDhUtD5XL2PSlwmCt3J3YKWqHGpNw53aw6VXjeqkmRKYC0sQiipPBEOEeVhZ+wYX07v7x9KrNlRln8jZYbtYNxeidGWMdZVLCBmnycY5MO+BeXMdV/Se/jXSsSQ3kpWPio+bO1oxyN+iepskMNtgNqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bNgLh25Hwz10XKF;
	Fri, 20 Jun 2025 09:46:36 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C80D180B34;
	Fri, 20 Jun 2025 09:51:11 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Jun
 2025 09:51:09 +0800
Message-ID: <50b9d0ce-df97-498f-8750-8a9e41a60f9c@huawei.com>
Date: Fri, 20 Jun 2025 09:51:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] ext4: move the calculation of wbc->nr_to_write to
 mpage_folio_done()
To: Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ojaswin@linux.ibm.com>, <yi.zhang@huawei.com>, <yukuai3@huawei.com>,
	<yangerkun@huawei.com>
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
 <20250611111625.1668035-2-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250611111625.1668035-2-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/6/11 19:16, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> mpage_folio_done() should be a more appropriate place than
> mpage_submit_folio() for updating the wbc->nr_to_write after we have
> submitted a fully mapped folio. Preparing to make mpage_submit_folio()
> allows to submit partially mapped folio that is still under processing.
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Makes sense. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/ext4/inode.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index be9a4cba35fd..3a086fee7989 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2024,7 +2024,10 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
>   
>   static void mpage_folio_done(struct mpage_da_data *mpd, struct folio *folio)
>   {
> -	mpd->first_page += folio_nr_pages(folio);
> +	unsigned long nr_pages = folio_nr_pages(folio);
> +
> +	mpd->first_page += nr_pages;
> +	mpd->wbc->nr_to_write -= nr_pages;
>   	folio_unlock(folio);
>   }
>   
> @@ -2055,8 +2058,6 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
>   	    !ext4_verity_in_progress(mpd->inode))
>   		len = size & (len - 1);
>   	err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
> -	if (!err)
> -		mpd->wbc->nr_to_write -= folio_nr_pages(folio);
>   
>   	return err;
>   }



