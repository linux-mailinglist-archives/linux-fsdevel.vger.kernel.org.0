Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BC0597C14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 05:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243052AbiHRDON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 23:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243070AbiHRDNr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:13:47 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FABE2B1BD
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 20:13:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VMZ06Bv_1660792404;
Received: from 30.227.140.19(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VMZ06Bv_1660792404)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 11:13:25 +0800
Message-ID: <ba2b9f11-be74-fa32-9ee6-e1794bdc09a0@linux.alibaba.com>
Date:   Thu, 18 Aug 2022 11:13:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [RFC PATCH] mm/filemap.c: fix the timing of asignment of prev_pos
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <1660744317-8183-1-git-send-email-kanie@linux.alibaba.com>
 <Yv0IccKJ6Spk/zH4@casper.infradead.org>
From:   Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <Yv0IccKJ6Spk/zH4@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2022/8/17 23:25, Matthew Wilcox 写道:
> On Wed, Aug 17, 2022 at 09:51:57PM +0800, Guixin Liu wrote:
>> The prev_pos should be assigned before the iocb->ki_pos is incremented,
>> so that the prev_pos is the exact location of the last visit.
>>
>> Fixes: 06c0444290cec ("mm/filemap.c: generic_file_buffered_read() now
>> uses find_get_pages_contig")
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>>
>> ---
>> Hi guys,
>>      When I`m running repetitive 4k read io which has same offset,
>> I find that access to folio_mark_accessed is inevitable in the
>> read process, the reason is that the prev_pos is assigned after the
>> iocb->ki_pos is incremented, so that the prev_pos is always not equal
>> to the position currently visited.
>>      Is this a bug that needs fixing?
> I think you've misunderstood the purpose of 'prev_pos'.  But this has
> been the source of bugs, so let's go through it in detail.
>
> In general, we want to mark a folio as accessed each time we read from
> it.  So if we do this:
>
> 	read(fd, buf, 1024 * 1024);
>
> we want to mark each folio as having been accessed.
>
> But if we're doing lots of short reads, we don't want to mark a folio as
> being accessed multiple times (if you dive into the implementation,
> you'll see the first time, the 'referenced' flag is set and the second
> time, the folio is moved to the active list, so it matters how often
> we call mark_accessed).  IOW:
>
> 	for (i = 0; i < 1024 * 1024; i++)
> 		read(fd, buf, 1);
>
> should do the same amount of accessed/referenced/activation as the single
> read above.
>
> So when we store ki_pos in prev_pos, we don't want to know "Where did
> the previous read start?"  We want to know "Where did the previous read
> end".  That's why when we test it, we check whether prev_pos - 1 is in
> the same folio as the offset we're looking at:
>
>                  if (!pos_same_folio(iocb->ki_pos, ra->prev_pos - 1,
>                                                          fbatch.folios[0]))
>                          folio_mark_accessed(fbatch.folios[0]);
>
> I'm not super-proud of this code, and accept that it's confusing.
> But I don't think the patch below is right.  If you could share
> your actual test and show what's going wrong, I'm interested.
>
> I think what you're saying is that this loop:
>
> 	for (i = 0; i < 1000; i++)
> 		pread(fd, buf, 4096, 1024 * 1024);
>
> results in the folio at offset 1MB being marked as accessed more than
> once.  If so, then I think that's the algorithm behaving as designed.
> Whether that's desirable is a different question; when I touched this
> code last, I was trying to restore the previous behaviour which was
> inadvertently broken.  I'm not taking a position on what the right
> behaviour is for such code.
>
My thanks for your detailed description, I am wrong about this, I test 
not on the newest code, My fault.

The 5ccc944dce3d actually solved this problem.

Best regards,

Guixin Liu

>>   mm/filemap.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 660490c..68fd987 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -2703,8 +2703,8 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>>   			copied = copy_folio_to_iter(folio, offset, bytes, iter);
>>   
>>   			already_read += copied;
>> -			iocb->ki_pos += copied;
>>   			ra->prev_pos = iocb->ki_pos;
>> +			iocb->ki_pos += copied;
>>   
>>   			if (copied < bytes) {
>>   				error = -EFAULT;
>> -- 
>> 1.8.3.1
>>
