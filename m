Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F0753DF42
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 03:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351926AbiFFBME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 21:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241008AbiFFBMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:12:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889293527D;
        Sun,  5 Jun 2022 18:12:00 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LGb5z52tczjXL2;
        Mon,  6 Jun 2022 09:11:03 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 09:11:58 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 09:11:57 +0800
Subject: Re: [PATCH -next] mm/filemap: fix that first page is not mark
 accessed in filemap_read()
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <kent.overstreet@gmail.com>,
        <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220602082129.2805890-1-yukuai3@huawei.com>
 <20220602112248.1e3cd871a87fe9df1ca13f08@linux-foundation.org>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <1a6128d2-d3cd-c922-3a01-d661eae104c3@huawei.com>
Date:   Mon, 6 Jun 2022 09:11:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220602112248.1e3cd871a87fe9df1ca13f08@linux-foundation.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2022/06/03 2:22, Andrew Morton wrote:
> On Thu, 2 Jun 2022 16:21:29 +0800 Yu Kuai <yukuai3@huawei.com> wrote:
> 
>> In filemap_read(), 'ra->prev_pos' is set to 'iocb->ki_pos + copied',
>> while it should be 'iocb->ki_ops'. For consequence,
>> folio_mark_accessed() will not be called for 'fbatch.folios[0]' since
>> 'iocb->ki_pos' is always equal to 'ra->prev_pos'.
>>
>> ...
>>
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -2728,10 +2728,11 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>>   				flush_dcache_folio(folio);
>>   
>>   			copied = copy_folio_to_iter(folio, offset, bytes, iter);
>> -
>> -			already_read += copied;
>> -			iocb->ki_pos += copied;
>> -			ra->prev_pos = iocb->ki_pos;
>> +			if (copied) {
>> +				ra->prev_pos = iocb->ki_pos;
>> +				already_read += copied;
>> +				iocb->ki_pos += copied;
>> +			}
>>   
>>   			if (copied < bytes) {
>>   				error = -EFAULT;
> 
> It seems tidier, but does it matter?  If copied==0 we're going to break
> out and return -EFAULT anyway?
Hi,

Please notice that I set 'prev_ops' to 'ki_pos' first here, instead of
'ki_pos + copied'.

Thanks,
Kuai
> .
> 
