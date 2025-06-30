Return-Path: <linux-fsdevel+bounces-53328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CFBAEDC1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2F418977EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 11:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2315F28641E;
	Mon, 30 Jun 2025 11:57:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3DC28640B;
	Mon, 30 Jun 2025 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284634; cv=none; b=drR1Y2/0ZrFSvraywePkfkHmxqG63cqpCaNu9m+OgTdiPzCA367oNsaxLE2DM3yjhkrwZw9lIY7t530wms8NzhnVJHrp46WHILsuazRyPov5BKUndHaIvS6sxp02kXtgA4sqJAcLvZdU+zCF+QGJGKwwoVRFzecZFhAAjds/jfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284634; c=relaxed/simple;
	bh=k4b30wy86niFYnjeLt6fAZ5xe54pStRVreSw97NvVO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFb+VomZJlt+gn4WqnDkBbukdZoOMK+sfW1wPnsR6W8Q+9sHeb0zKfrUBxjuzwf+IL5V9aghkF1/kTbSvpm4oRExT8XRPQhy7xTs28IpCYSCF3ecXAttwn/ZLu5OmzcXQPLMZQFeQSPtDUfnsodhCdZ1Ne2l3pa3bhVrEUssCzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bW4QY6ZwKzYQvYv;
	Mon, 30 Jun 2025 19:57:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C618A1A0A3D;
	Mon, 30 Jun 2025 19:57:08 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP3 (Coremail) with SMTP id _Ch0CgA3mSaRe2Jo3_bUAA--.59770S3;
	Mon, 30 Jun 2025 19:57:07 +0800 (CST)
Message-ID: <f81aab8c-50f5-40b2-86b5-59ed33f20c02@huaweicloud.com>
Date: Mon, 30 Jun 2025 19:57:05 +0800
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
Cc: Baokun Li <libaokun1@huawei.com>, linux-kernel@vger.kernel.org,
 kernel@pankajraghav.com, linux-fsdevel@vger.kernel.org,
 gost.dev@samsung.com, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, mcgrof@kernel.org,
 Christian Brauner <brauner@kernel.org>
References: <20250630104018.213985-1-p.raghav@samsung.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250630104018.213985-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgA3mSaRe2Jo3_bUAA--.59770S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1rGF1xuF18CF43AF1kXwb_yoW8Xw4rpa
	yvqw1Ykr1rGFyxWF42gr1vqry8Canxta17WrWjqr15Z343Jr4IgryqkryYvanFqrWfAa9r
	WF4rJF43GFWUJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

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

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
> Changes since v1:
> - Removed the unnecessary parantheses.
> - Added RVB from Jan Kara (Thanks).
> 
>  fs/libfs.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 4d1862f589e8..f99ecc300647 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1584,13 +1584,17 @@ EXPORT_SYMBOL(generic_file_fsync);
>  int generic_check_addressable(unsigned blocksize_bits, u64 num_blocks)
>  {
>  	u64 last_fs_block = num_blocks - 1;
> -	u64 last_fs_page =
> -		last_fs_block >> (PAGE_SHIFT - blocksize_bits);
> +	u64 last_fs_page, max_bytes;
> +
> +	if (check_shl_overflow(num_blocks, blocksize_bits, &max_bytes))
> +		return -EFBIG;
> +
> +	last_fs_page = (max_bytes >> PAGE_SHIFT) - 1;
>  
>  	if (unlikely(num_blocks == 0))
>  		return 0;
>  
> -	if ((blocksize_bits < 9) || (blocksize_bits > PAGE_SHIFT))
> +	if (blocksize_bits < 9)
>  		return -EINVAL;
>  
>  	if ((last_fs_block > (sector_t)(~0ULL) >> (blocksize_bits - 9)) ||
> 
> base-commit: b39f7d75dc41b5f5d028192cd5d66cff71179f35


