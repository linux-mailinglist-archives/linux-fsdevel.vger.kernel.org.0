Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F77E53DF3F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 03:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351923AbiFFBKK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 21:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351909AbiFFBKJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:10:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8F44E3AE;
        Sun,  5 Jun 2022 18:10:07 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LGb2r0h3XzgYch;
        Mon,  6 Jun 2022 09:08:20 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 09:10:06 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 09:10:05 +0800
Subject: Re: [PATCH -next] mm/filemap: fix that first page is not mark
 accessed in filemap_read()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <kent.overstreet@gmail.com>,
        <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220602082129.2805890-1-yukuai3@huawei.com>
 <YpkB1+PwIZ3AKUqg@casper.infradead.org>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <c49af4f7-5005-7cf1-8b58-a398294472ab@huawei.com>
Date:   Mon, 6 Jun 2022 09:10:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YpkB1+PwIZ3AKUqg@casper.infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/06/03 2:30, Matthew Wilcox wrote:
> On Thu, Jun 02, 2022 at 04:21:29PM +0800, Yu Kuai wrote:
>> In filemap_read(), 'ra->prev_pos' is set to 'iocb->ki_pos + copied',
>> while it should be 'iocb->ki_ops'.
> 
> Can you walk me through your reasoning which leads you to believe that
> it should be ki_pos instead of ki_pos + copied?  As I understand it,
> prev_pos is the end of the previous read, not the beginning of the
> previous read.

Hi, Matthew

The main reason is the following judgement in flemap_read():

if (iocb->ki_pos >> PAGE_SHIFT !=	-> current page
     ra->prev_pos >> PAGE_SHIFT)		-> previous page
         folio_mark_accessed(fbatch.folios[0]);

Which means if current page is the same as previous page, don't mark
page accessed. However, prev_pos is set to 'ki_pos + copied' during last
read, which will cause 'prev_pos >> PAGE_SHIFT' to be current page
instead of previous page.

I was thinking that if prev_pos is set to the begining of the previous
read, 'prev_pos >> PAGE_SHIFT' will be previous page as expected. Set to
the end of previous read is ok, however, I think the caculation of
previous page should be '(prev_pos - 1) >> PAGE_SHIFT' instead.

> 
> For consequence,
>> folio_mark_accessed() will not be called for 'fbatch.folios[0]' since
>> 'iocb->ki_pos' is always equal to 'ra->prev_pos'.
> 
> I don't follow this, but maybe I'm just being slow.

I mssing a condition here:

Under small io sequential read, folio_mark_accessed() will not be called
for 'fbatch.folios[0]' since 'iocb->ki_pos' is always equal to
'ra->prev_pos'.

Thanks,
Kuai
> 
> .
> 
