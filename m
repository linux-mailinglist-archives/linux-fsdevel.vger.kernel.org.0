Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35A635B859
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 03:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbhDLByt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Apr 2021 21:54:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16437 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbhDLByq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Apr 2021 21:54:46 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FJWvJ5xxlzwRFQ;
        Mon, 12 Apr 2021 09:52:12 +0800 (CST)
Received: from [10.67.77.175] (10.67.77.175) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Mon, 12 Apr 2021
 09:54:20 +0800
Subject: Re: [PATCH] fs/buffer.c: Delete redundant uptodate check for buffer
To:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Yang Guo <guoyang2@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1617260222-13797-1-git-send-email-zhangshaokun@hisilicon.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <d89bd95c-df22-9edd-e48e-0ac19cf1590b@hisilicon.com>
Date:   Mon, 12 Apr 2021 09:54:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1617260222-13797-1-git-send-email-zhangshaokun@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.77.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+Cc: Andrew Morton

On 2021/4/1 14:57, Shaokun Zhang wrote:
> From: Yang Guo <guoyang2@huawei.com>
> 
> The buffer uptodate state has been checked in function set_buffer_uptodate,
> there is no need use buffer_uptodate before calling set_buffer_uptodate and
> delete it.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk> 
> Signed-off-by: Yang Guo <guoyang2@huawei.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  fs/buffer.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 673cfbef9eec..2c0d0b3f3203 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2055,8 +2055,7 @@ int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
>  		block_end = block_start + blocksize;
>  		if (block_end <= from || block_start >= to) {
>  			if (PageUptodate(page)) {
> -				if (!buffer_uptodate(bh))
> -					set_buffer_uptodate(bh);
> +				set_buffer_uptodate(bh);
>  			}
>  			continue;
>  		}
> @@ -2088,8 +2087,7 @@ int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
>  			}
>  		}
>  		if (PageUptodate(page)) {
> -			if (!buffer_uptodate(bh))
> -				set_buffer_uptodate(bh);
> +			set_buffer_uptodate(bh);
>  			continue; 
>  		}
>  		if (!buffer_uptodate(bh) && !buffer_delay(bh) &&
> 
