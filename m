Return-Path: <linux-fsdevel+bounces-53327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F072AEDB49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C47189B5A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26AC25E46A;
	Mon, 30 Jun 2025 11:38:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047AB257ACF;
	Mon, 30 Jun 2025 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283514; cv=none; b=PdBenUtH2TiEL0yiWNKbC5d/xIyLCyTkErp1MtcfsuUaM4cTPfl9HGc8RXLBQJAi0+vOZ5GxnGzRLO4AOouOH0fOCyKRn0337YYmiPdHyCHzrsQmYvIyIq5eWQf45t7QHF/w56q5kV8rM/jfEYiuhkGbZBiP0Szywh+WcKtOkG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283514; c=relaxed/simple;
	bh=ukEt+0KMj+EJld1+vNkKCXDtzuWT33i85lO3++F/2i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LatVeZBD1iT/fmMfVDNkWT8+jgGpO7nWxUBEAs8hjObKfCPVgmeRrso1RcRQVFPCxckUzLRuo1DG8LBDJ5STejD1LP94PR+qcikwY2Ljq9ELEa0scGJ7a9DhuKvVguT9Hw/J62BQr0wOOqmwHoNgMIrFnB4HyqAX/WSlZOFDmw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bW3vc2pcQz14Lq7;
	Mon, 30 Jun 2025 19:33:48 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 0801E1800B1;
	Mon, 30 Jun 2025 19:38:28 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Jun
 2025 19:38:26 +0800
Message-ID: <8ffabe04-b12c-4d1c-8e09-f1db8c72e6d5@huawei.com>
Date: Mon, 30 Jun 2025 19:38:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/libfs: don't assume blocksize <= PAGE_SIZE in
 generic_check_addressable
To: Pankaj Raghav <p.raghav@samsung.com>
CC: Christian Brauner <brauner@kernel.org>, <mcgrof@kernel.org>, Jan Kara
	<jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	<linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>, Zhang Yi
	<yi.zhang@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<gost.dev@samsung.com>, Yang Erkun <yangerkun@huawei.com>
References: <20250630104018.213985-1-p.raghav@samsung.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250630104018.213985-1-p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/6/30 18:40, Pankaj Raghav wrote:
> Since [1], it is possible for filesystems to have blocksize > PAGE_SIZE
> of the system.
>
> Remove the assumption and make the check generic for all blocksizes in
> generic_check_addressable().
>
> [1] https://lore.kernel.org/linux-xfs/20240822135018.1931258-1-kernel@pankajraghav.com/
>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Looks good. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
> Changes since v1:
> - Removed the unnecessary parantheses.
> - Added RVB from Jan Kara (Thanks).
>
>   fs/libfs.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 4d1862f589e8..f99ecc300647 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1584,13 +1584,17 @@ EXPORT_SYMBOL(generic_file_fsync);
>   int generic_check_addressable(unsigned blocksize_bits, u64 num_blocks)
>   {
>   	u64 last_fs_block = num_blocks - 1;
> -	u64 last_fs_page =
> -		last_fs_block >> (PAGE_SHIFT - blocksize_bits);
> +	u64 last_fs_page, max_bytes;
> +
> +	if (check_shl_overflow(num_blocks, blocksize_bits, &max_bytes))
> +		return -EFBIG;
> +
> +	last_fs_page = (max_bytes >> PAGE_SHIFT) - 1;
>   
>   	if (unlikely(num_blocks == 0))
>   		return 0;
>   
> -	if ((blocksize_bits < 9) || (blocksize_bits > PAGE_SHIFT))
> +	if (blocksize_bits < 9)
>   		return -EINVAL;
>   
>   	if ((last_fs_block > (sector_t)(~0ULL) >> (blocksize_bits - 9)) ||
>
> base-commit: b39f7d75dc41b5f5d028192cd5d66cff71179f35



