Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265B45472D8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 10:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiFKIXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 04:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiFKIXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:23:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390D5BA;
        Sat, 11 Jun 2022 01:23:45 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LKrQk5pw7zgYF0;
        Sat, 11 Jun 2022 16:21:50 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 11 Jun 2022 16:23:43 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 11 Jun 2022 16:23:42 +0800
Subject: Re: [PATCH -next] mm/filemap: fix that first page is not mark
 accessed in filemap_read()
To:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
CC:     <akpm@linux-foundation.org>, <axboe@kernel.dk>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220602082129.2805890-1-yukuai3@huawei.com>
 <YpkB1+PwIZ3AKUqg@casper.infradead.org>
 <c49af4f7-5005-7cf1-8b58-a398294472ab@huawei.com>
 <YqNWY46ZRoK6Cwbu@casper.infradead.org>
 <YqNW8cYn9gM7Txg6@casper.infradead.org>
 <c5f97e2f-8a48-2906-91a2-1d84629b3641@gmail.com>
 <YqOOsHecZUWlHEn/@casper.infradead.org>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <dfa6d60d-0efd-f12d-9e71-a6cd24188bba@huawei.com>
Date:   Sat, 11 Jun 2022 16:23:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YqOOsHecZUWlHEn/@casper.infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

ÔÚ 2022/06/11 2:34, Matthew Wilcox Ð´µÀ:
> On Fri, Jun 10, 2022 at 01:47:02PM -0400, Kent Overstreet wrote:
>> I think this is the fix we want - I think Yu basically had the right idea
>> and had the off by one fix, this should be clearer though:
>>
>> Yu, can you confirm the fix?
>>
>> -- >8 --
>> Subject: [PATCH] filemap: Fix off by one error when marking folios accessed
>>
>> In filemap_read() we mark pages accessed as we read them - but we don't
>> want to do so redundantly, if the previous read already did so.
>>
>> But there was an off by one error: we want to check if the current page
>> was the same as the last page we read from, but the last page we read
>> from was (ra->prev_pos - 1) >> PAGE_SHIFT.
>>
>> Reported-by: Yu Kuai <yukuai3@huawei.com>
>> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 9daeaab360..8d5c8043cb 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -2704,7 +2704,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct
>> iov_iter *iter,
>>                   * mark it as accessed the first time.
>>                   */
>>                  if (iocb->ki_pos >> PAGE_SHIFT !=
>> -                   ra->prev_pos >> PAGE_SHIFT)
>> +                   (ra->prev_pos - 1) >> PAGE_SHIFT)
>>                          folio_mark_accessed(fbatch.folios[0]);
>>
>>                  for (i = 0; i < folio_batch_count(&fbatch); i++) {
>>
> 
> This is going to mark the folio as accessed multiple times if it's
> a multi-page folio.  How about this one?
> 
Hi, Matthew

Thanks for the patch, it looks good to me.

BTW, I still think the fix should be commit 06c0444290ce ("mm/filemap.c:
generic_file_buffered_read() now uses find_get_pages_contig").
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 5f227b5420d7..a30587f2e598 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2599,6 +2599,13 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
>   	return err;
>   }
>   
> +static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
> +{
> +	unsigned int shift = folio_shift(folio);
> +
> +	return (pos1 >> shift == pos2 >> shift);
> +}
> +
>   /**
>    * filemap_read - Read data from the page cache.
>    * @iocb: The iocb to read.
> @@ -2670,11 +2677,11 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>   		writably_mapped = mapping_writably_mapped(mapping);
>   
>   		/*
> -		 * When a sequential read accesses a page several times, only
> +		 * When a read accesses the same folio several times, only
>   		 * mark it as accessed the first time.
>   		 */
> -		if (iocb->ki_pos >> PAGE_SHIFT !=
> -		    ra->prev_pos >> PAGE_SHIFT)
> +		if (!pos_same_folio(iocb->ki_pos, ra->prev_pos - 1,
> +							fbatch.folios[0]))
>   			folio_mark_accessed(fbatch.folios[0]);
>   
>   		for (i = 0; i < folio_batch_count(&fbatch); i++) {
> 
> .
> 
