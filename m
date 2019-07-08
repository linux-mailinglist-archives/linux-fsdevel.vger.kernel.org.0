Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740A56193C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 04:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfGHCMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jul 2019 22:12:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34880 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbfGHCMl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jul 2019 22:12:41 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 15E9EBFB2F30FA70EE2E;
        Mon,  8 Jul 2019 10:12:38 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 8 Jul 2019
 10:12:28 +0800
Subject: Re: [RFC PATCH] iomap: generalize IOMAP_INLINE to cover tail-packing
 case
To:     <hch@infradead.org>, <darrick.wong@oracle.com>
CC:     <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <andreas.gruenbacher@gmail.com>, <gaoxiang25@huawei.com>,
        <chao@kernel.org>
References: <20190703075502.79782-1-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a6d61ef9-0822-e5f4-cf06-a03151390958@huawei.com>
Date:   Mon, 8 Jul 2019 10:12:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190703075502.79782-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping, any comments on this patch?

On 2019/7/3 15:55, Chao Yu wrote:
> Some filesystems like erofs/reiserfs have the ability to pack tail
> data into metadata, e.g.:
> IOMAP_MAPPED [0, 8192]
> IOMAP_INLINE [8192, 8200]
> 
> However current IOMAP_INLINE type has assumption that:
> - inline data should be locating at page #0.
> - inline size should equal to .i_size
> Those restriction fail to convert to use iomap IOMAP_INLINE in erofs,
> so this patch tries to relieve above limits to make IOMAP_INLINE more
> generic to cover tail-packing case.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/iomap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 12654c2e78f8..d1c16b692d31 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -264,13 +264,12 @@ static void
>  iomap_read_inline_data(struct inode *inode, struct page *page,
>  		struct iomap *iomap)
>  {
> -	size_t size = i_size_read(inode);
> +	size_t size = iomap->length;
>  	void *addr;
>  
>  	if (PageUptodate(page))
>  		return;
>  
> -	BUG_ON(page->index);
>  	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
>  
>  	addr = kmap_atomic(page);
> @@ -293,7 +292,6 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	sector_t sector;
>  
>  	if (iomap->type == IOMAP_INLINE) {
> -		WARN_ON_ONCE(pos);
>  		iomap_read_inline_data(inode, page, iomap);
>  		return PAGE_SIZE;
>  	}
> 
