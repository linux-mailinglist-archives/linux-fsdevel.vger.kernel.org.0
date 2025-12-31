Return-Path: <linux-fsdevel+bounces-72267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A285ECEB603
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 07:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0DCC300B255
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 06:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902933112B4;
	Wed, 31 Dec 2025 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xsgpvpKP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD54921578D;
	Wed, 31 Dec 2025 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767163212; cv=none; b=HZggcpGrq8z7uFbZaDiZhrKZM5VqmeukpD46LYWocrMgo62FYsvdP0xQtRvpwxyO3cHbdCZth/pCydN72ChnKa/juukOj1LWI7SqgZ+ILc7Qa+W40eZlkhAubuUKeMBeHN5Wgl/hA8/M/teX3XemQfykd7kPt98Q4YO3dhWnkLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767163212; c=relaxed/simple;
	bh=/bvwbuuELkihog4EF4DY+Ti4QAnGYT3s8/RfgPPbsT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jfsifLNcOAGp6B2yZYOZ72bpszsa0//wCEN/L0+6O0u7SWjlbzdsx3EbvYMreluhIeVjwtfGRksjaiaG7E0bPB4rlVzwBz+K38ueW0U+dNwn26oq/ptNP46xwBsYAix7OL9rYwtTvQzQgQTfM8nWpREfyncJU3fixBkrogM5Y1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xsgpvpKP; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Jdthaagf021AsgaBQY1QRdgzR+AponLCg5fBTEpUPes=;
	b=xsgpvpKP+rKBqcej9UBpGcJGItFxS6qYLaCdtf97vItPZBcqBTaUrqZqpezMuxwRVOWkfjNJe
	y31TIYS3eC/uFlNE2TzAAXdyAbjGpigsfNoJFxkpnut3sF027tEGkM+mhWgVjgF8scp47EYrKQe
	qkCFr0WcjEa3bYEVauzvIKY=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dh0by24bjzKm5N;
	Wed, 31 Dec 2025 14:36:46 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 1820F40565;
	Wed, 31 Dec 2025 14:39:58 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Dec
 2025 14:39:56 +0800
Message-ID: <cca2fc6c-3c54-418d-935e-779e60833f87@huawei.com>
Date: Wed, 31 Dec 2025 14:39:55 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ext4: don't order data when zeroing unwritten or
 delayed block
To: Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ojaswin@linux.ibm.com>, <ritesh.list@gmail.com>, <yi.zhang@huawei.com>,
	<yizhang089@gmail.com>, <yangerkun@huawei.com>, <yukuai@fnnas.com>
References: <20251223011927.34042-1-yi.zhang@huaweicloud.com>
Content-Language: en-GB
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251223011927.34042-1-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-12-23 09:19, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> When zeroing out a written partial block, it is necessary to order the
> data to prevent exposing stale data on disk. However, if the buffer is
> unwritten or delayed, it is not allocated as written, so ordering the
> data is not required. This can prevent strange and unnecessary ordered
> writes when appending data across a region within a block.
>
> Assume we have a 2K unwritten file on a filesystem with 4K blocksize,
> and buffered write from 3K to 4K. Before this patch,
> __ext4_block_zero_page_range() would add the range [2k,3k) to the
> ordered range, and then the JBD2 commit process would write back this
> block. However, it does nothing since the block is not mapped as
> written, this folio will be redirtied and written back agian through the
> normal write back process.
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Makes sense. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/inode.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 2e79b09fe2f0..f2d70c9af446 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4109,9 +4109,13 @@ static int __ext4_block_zero_page_range(handle_t *handle,
>  	if (ext4_should_journal_data(inode)) {
>  		err = ext4_dirty_journalled_data(handle, bh);
>  	} else {
> -		err = 0;
>  		mark_buffer_dirty(bh);
> -		if (ext4_should_order_data(inode))
> +		/*
> +		 * Only the written block requires ordered data to prevent
> +		 * exposing stale data.
> +		 */
> +		if (!buffer_unwritten(bh) && !buffer_delay(bh) &&
> +		    ext4_should_order_data(inode))
>  			err = ext4_jbd2_inode_add_write(handle, inode, from,
>  					length);
>  	}



