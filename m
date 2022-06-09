Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E905440C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 03:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbiFIA7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 20:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbiFIA7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 20:59:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818AE27CE1;
        Wed,  8 Jun 2022 17:59:50 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LJQjF3fPzz8wyG;
        Thu,  9 Jun 2022 08:59:29 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 08:59:48 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 08:59:47 +0800
Subject: Re: [PATCH -next] mm/filemap: fix that first page is not mark
 accessed in filemap_read()
To:     <willy@infradead.org>, <akpm@linux-foundation.org>,
        <kent.overstreet@gmail.com>
CC:     <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220602082129.2805890-1-yukuai3@huawei.com>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <abb3ec4c-ee22-0132-4c60-bc15e9871527@huawei.com>
Date:   Thu, 9 Jun 2022 08:59:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220602082129.2805890-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

friendly ping ...

ÔÚ 2022/06/02 16:21, Yu Kuai Ð´µÀ:
> In filemap_read(), 'ra->prev_pos' is set to 'iocb->ki_pos + copied',
> while it should be 'iocb->ki_ops'. For consequence,
> folio_mark_accessed() will not be called for 'fbatch.folios[0]' since
> 'iocb->ki_pos' is always equal to 'ra->prev_pos'.
> 
> Fixes: 06c0444290ce ("mm/filemap.c: generic_file_buffered_read() now uses find_get_pages_contig")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   mm/filemap.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 9daeaab36081..0b776e504d35 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2728,10 +2728,11 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>   				flush_dcache_folio(folio);
>   
>   			copied = copy_folio_to_iter(folio, offset, bytes, iter);
> -
> -			already_read += copied;
> -			iocb->ki_pos += copied;
> -			ra->prev_pos = iocb->ki_pos;
> +			if (copied) {
> +				ra->prev_pos = iocb->ki_pos;
> +				already_read += copied;
> +				iocb->ki_pos += copied;
> +			}
>   
>   			if (copied < bytes) {
>   				error = -EFAULT;
> 
