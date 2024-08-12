Return-Path: <linux-fsdevel+bounces-25675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A60394ED4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 14:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF8B283618
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 12:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CD817BB01;
	Mon, 12 Aug 2024 12:47:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35A017B501;
	Mon, 12 Aug 2024 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466873; cv=none; b=gB0SL5M8EHw28Y2s0tysmuCu7yNhosoAtg2Vkf/F7SMdZJQ/YiG/xPdIOuCNwYd62UFYj2deXgWEeCSXLWB+ZJrrOcnOUwzDdOh+CT+bw+hxf+oDU+NoJdfu8J05XAQ5LAkeN459XLrOfzphgY6sXvSZXRIbuy4au+t+22+eYMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466873; c=relaxed/simple;
	bh=O4m+UYGqu6T4Onmz+MHv97vuuf+KeykpMVt+uLQVovI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jj0esBShMitRPPWyjH8e3DoEXNsnlomO0ybvUm18lCK3cUXjQTD9ebFihef08paB+Zzmx7N88nVm8UHl133yy8WzRCBBt/M1Khl10fyLl0XnFBwx/n5GuFFxMqgyYJkSrBBiaCb0B+0HVSblPNCKoWHxW4Nk5esNbrpV6q5LnKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WjDlR1rGZz3RrlX;
	Mon, 12 Aug 2024 20:45:55 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id C7854140202;
	Mon, 12 Aug 2024 20:47:45 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Aug 2024 20:47:44 +0800
Message-ID: <137c8c6e-ead3-51ed-be5a-c8eba0be3a2d@huawei.com>
Date: Mon, 12 Aug 2024 20:47:44 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 3/6] iomap: advance the ifs allocation if we have more
 than one blocks per folio
To: Zhang Yi <yi.zhang@huaweicloud.com>, <linux-xfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <djwong@kernel.org>, <hch@infradead.org>,
	<brauner@kernel.org>, <david@fromorbit.com>, <jack@suse.cz>,
	<willy@infradead.org>, <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
	<yukuai3@huawei.com>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-4-yi.zhang@huaweicloud.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <20240812121159.3775074-4-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2024/8/12 20:11, Zhang Yi 写道:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Now we allocate ifs if i_blocks_per_folio is larger than one when
> writing back dirty folios in iomap_writepage_map(), so we don't attach
> an ifs after buffer write to an entire folio until it starts writing
> back, if we partial truncate that folio, iomap_invalidate_folio() can't
> clear counterpart block's dirty bit as expected. Fix this by advance the
> ifs allocation to __iomap_write_begin().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>   fs/iomap/buffered-io.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 763deabe8331..79031b7517e5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -699,6 +699,12 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>   	size_t from = offset_in_folio(folio, pos), to = from + len;
>   	size_t poff, plen;
>   
> +	if (nr_blocks > 1) {
> +		ifs = ifs_alloc(iter->inode, folio, iter->flags);
> +		if ((iter->flags & IOMAP_NOWAIT) && !ifs)
> +			return -EAGAIN;
> +	}
> +
>   	/*
>   	 * If the write or zeroing completely overlaps the current folio, then
>   	 * entire folio will be dirtied so there is no need for

The comments upper need change too.


> @@ -710,10 +716,6 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>   	    pos + len >= folio_pos(folio) + folio_size(folio))
>   		return 0;
>   
> -	ifs = ifs_alloc(iter->inode, folio, iter->flags);
> -	if ((iter->flags & IOMAP_NOWAIT) && !ifs && nr_blocks > 1)
> -		return -EAGAIN;
> -
>   	if (folio_test_uptodate(folio))
>   		return 0;
>   
> @@ -1928,7 +1930,12 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>   	WARN_ON_ONCE(end_pos <= pos);
>   
>   	if (i_blocks_per_folio(inode, folio) > 1) {
> -		if (!ifs) {
> +		/*
> +		 * This should not happen since we always allocate ifs in
> +		 * iomap_folio_mkwrite_iter() and there is more than one
> +		 * blocks per folio in __iomap_write_begin().
> +		 */
> +		if (WARN_ON_ONCE(!ifs)) {
>   			ifs = ifs_alloc(inode, folio, 0);
>   			iomap_set_range_dirty(folio, 0, end_pos - pos);
>   		}

