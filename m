Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99D0476BF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 09:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbhLPIbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 03:31:32 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15745 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbhLPIba (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:31:30 -0500
Received: from kwepemi100005.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JF4y34LtRzZd4C;
        Thu, 16 Dec 2021 16:28:27 +0800 (CST)
Received: from kwepemm600019.china.huawei.com (7.193.23.64) by
 kwepemi100005.china.huawei.com (7.221.188.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 16:31:28 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemm600019.china.huawei.com (7.193.23.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 16:31:28 +0800
Subject: Re: [PATCH] pipe: remove needless spin_lock in pipe_read/pipe_write
From:   yangerkun <yangerkun@huawei.com>
To:     <dhowells@redhat.com>, <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>
References: <20211122041135.2450220-1-yangerkun@huawei.com>
 <22dd76ec-a50d-a2f1-8001-2a86de1d50c0@huawei.com>
Message-ID: <559be9c0-96da-24bd-2a2b-e87808a522c5@huawei.com>
Date:   Thu, 16 Dec 2021 16:31:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <22dd76ec-a50d-a2f1-8001-2a86de1d50c0@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600019.china.huawei.com (7.193.23.64)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping...

On 2021/11/29 14:22, yangerkun wrote:
> ping
> 
> On 2021/11/22 12:11, yangerkun wrote:
>> Once enable CONFIG_WATCH_QUEUE, we should protect pipe with
>> pipe->rd_wait.lock since post_one_notification may write pipe from
>> contexts where pipe->mutex cannot be token. But nowdays we will try
>> take it for anycase, it seems needless. Besides, pipe_write will break
>> once it's pipe with O_NOTIFICATION_PIPE, pipe->rd_wait.lock seems no
>> need at all. We make some change base on that, and it can help improve
>> performance for some case like pipe_pst1 in libMicro.
>>
>> ARMv7 for our scene, before this patch:
>>    5483 nsecs/call
>> After this patch:
>>    4854 nsecs/call
>>
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> ---
>>   fs/pipe.c | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/pipe.c b/fs/pipe.c
>> index 6d4342bad9f1..e8ced0c50824 100644
>> --- a/fs/pipe.c
>> +++ b/fs/pipe.c
>> @@ -320,14 +320,18 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>>               if (!buf->len) {
>>                   pipe_buf_release(pipe, buf);
>> -                spin_lock_irq(&pipe->rd_wait.lock);
>>   #ifdef CONFIG_WATCH_QUEUE
>> +                if (pipe->watch_queue)
>> +                    spin_lock_irq(&pipe->rd_wait.lock);
>>                   if (buf->flags & PIPE_BUF_FLAG_LOSS)
>>                       pipe->note_loss = true;
>>   #endif
>>                   tail++;
>>                   pipe->tail = tail;
>> -                spin_unlock_irq(&pipe->rd_wait.lock);
>> +#ifdef CONFIG_WATCH_QUEUE
>> +                if (pipe->watch_queue)
>> +                    spin_unlock_irq(&pipe->rd_wait.lock);
>> +#endif
>>               }
>>               total_len -= chars;
>>               if (!total_len)
>> @@ -504,16 +508,11 @@ pipe_write(struct kiocb *iocb, struct iov_iter 
>> *from)
>>                * it, either the reader will consume it or it'll still
>>                * be there for the next write.
>>                */
>> -            spin_lock_irq(&pipe->rd_wait.lock);
>> -
>>               head = pipe->head;
>> -            if (pipe_full(head, pipe->tail, pipe->max_usage)) {
>> -                spin_unlock_irq(&pipe->rd_wait.lock);
>> +            if (pipe_full(head, pipe->tail, pipe->max_usage))
>>                   continue;
>> -            }
>>               pipe->head = head + 1;
>> -            spin_unlock_irq(&pipe->rd_wait.lock);
>>               /* Insert it into the buffer array */
>>               buf = &pipe->bufs[head & mask];
>>
> .
