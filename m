Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294F9547D72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 03:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiFMBbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jun 2022 21:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiFMBbU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jun 2022 21:31:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46CC10FFD;
        Sun, 12 Jun 2022 18:31:15 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LLvBp6Zk0zjXZc;
        Mon, 13 Jun 2022 09:30:10 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 09:31:13 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 09:31:12 +0800
Subject: Re: [PATCH -next] mm/filemap: fix that first page is not mark
 accessed in filemap_read()
To:     Matthew Wilcox <willy@infradead.org>
CC:     Kent Overstreet <kent.overstreet@gmail.com>,
        <akpm@linux-foundation.org>, <axboe@kernel.dk>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220602082129.2805890-1-yukuai3@huawei.com>
 <YpkB1+PwIZ3AKUqg@casper.infradead.org>
 <c49af4f7-5005-7cf1-8b58-a398294472ab@huawei.com>
 <YqNWY46ZRoK6Cwbu@casper.infradead.org>
 <YqNW8cYn9gM7Txg6@casper.infradead.org>
 <c5f97e2f-8a48-2906-91a2-1d84629b3641@gmail.com>
 <YqOOsHecZUWlHEn/@casper.infradead.org>
 <dfa6d60d-0efd-f12d-9e71-a6cd24188bba@huawei.com>
 <YqTUEZ+Pa24p09Uc@casper.infradead.org>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <7e9889b7-8eeb-5e97-3f4b-cdc914a032f4@huawei.com>
Date:   Mon, 13 Jun 2022 09:31:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YqTUEZ+Pa24p09Uc@casper.infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

ÔÚ 2022/06/12 1:42, Matthew Wilcox Ð´µÀ:
> On Sat, Jun 11, 2022 at 04:23:42PM +0800, Yu Kuai wrote:
>>> This is going to mark the folio as accessed multiple times if it's
>>> a multi-page folio.  How about this one?
>>>
>> Hi, Matthew
>>
>> Thanks for the patch, it looks good to me.
> 
> Did you test it?  This is clearly a little subtle ;-)

Yes, I confirmed that with this patch, small sequential read will mark
page accessed. However, multi-page folio is not tested yet.

> 
>> BTW, I still think the fix should be commit 06c0444290ce ("mm/filemap.c:
>> generic_file_buffered_read() now uses find_get_pages_contig").
> 
> Hmm, yes.  That code also has problems, but they're more subtle and
> probably don't amount to much.
> 
> -       iocb->ki_pos += copied;
> -
> -       /*
> -        * When a sequential read accesses a page several times,
> -        * only mark it as accessed the first time.
> -        */
> -       if (iocb->ki_pos >> PAGE_SHIFT != ra->prev_pos >> PAGE_SHIFT)
> -               mark_page_accessed(page);
> -
> -       ra->prev_pos = iocb->ki_pos;
> 
> This will mark the page accessed when we _exit_ a page.  So reading
> 512-bytes at a time from offset 0, we'll mark page 0 as accessed on the
> first read (because the prev_pos is initialised to -1).  Then on the
> eighth read, we'll mark page 0 as accessed again (because ki_pos will
> now be 4096 and prev_pos is 3584).  We'll then read chunks of page 1
> without marking it as accessed, until we're about to step into page 2.

You are right, I didn't think of that situation.
> 
> Marking page 0 accessed twice is bad; it'll set the referenced bit the
> first time, and then the second time, it'll activate it.  So it'll be
> thought to be part of the workingset when it's really just been part of
> a streaming read.
> 
> And the last page we read will never be marked accessed unless it
> happens to finish at the end of a page.
> 
> Before Kent started his refactoring, I think it worked:
> 
> -       pgoff_t prev_index;
> -       unsigned int prev_offset;
> ...
> -       prev_index = ra->prev_pos >> PAGE_SHIFT;
> -       prev_offset = ra->prev_pos & (PAGE_SIZE-1);
> ...
> -               if (prev_index != index || offset != prev_offset)
> -                       mark_page_accessed(page);
> -               prev_index = index;
> -               prev_offset = offset;
> ...
> -       ra->prev_pos = prev_index;
> -       ra->prev_pos <<= PAGE_SHIFT;
> -       ra->prev_pos |= prev_offset;
> 
> At least, I don't detect any bugs in this.

Sure, thanks for your explanation.
