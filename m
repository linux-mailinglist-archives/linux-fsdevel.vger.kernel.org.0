Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A785A66B5EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 04:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjAPDQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Jan 2023 22:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjAPDQ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:16:29 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0FDB6A55;
        Sun, 15 Jan 2023 19:16:18 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8Cxd+mBwcRjucsBAA--.385S3;
        Mon, 16 Jan 2023 11:16:17 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxnb59wcRj8QQaAA--.53346S3;
        Mon, 16 Jan 2023 11:16:14 +0800 (CST)
Message-ID: <4b140bd0-9b7f-50b5-9e3b-16d8afe52a50@loongson.cn>
Date:   Mon, 16 Jan 2023 11:16:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] pipe: use __pipe_{lock,unlock} instead of spinlock
To:     Hongchen Zhang <zhanghongchen@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230107012324.30698-1-zhanghongchen@loongson.cn>
 <9fcb3f80-cb55-9a72-0e74-03ace2408d21@loongson.cn>
Content-Language: en-US
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <9fcb3f80-cb55-9a72-0e74-03ace2408d21@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxnb59wcRj8QQaAA--.53346S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Kr1UAFWfXry3GrW8KF4UJwb_yoWkAF1Upr
        1ktryUJrWUAr1kGr1UJr1UXryUJryUJ3WDJr18JF1UJr1UJr1jqr4UWryYgr1UJr48Jr1U
        Jr1UJr1UZr1UJr7anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hongchen,

I have a glance with this patch, it simply replaces with
spinlock_irqsave with mutex lock. There may be performance
improvement with two processes competing with pipe, however
for N processes, there will be complex context switches
and ipi interruptts.

Can you find some cases with more than 2 processes competing
pipe, rather than only unixbench?

regards
bibo, mao

在 2023/1/13 11:19, Hongchen Zhang 写道:
> Hi All,
> any question about this patch, can it be merged?
> 
> Thanks
> On 2023/1/7 am 9:23, Hongchen Zhang wrote:
>> Use spinlock in pipe_read/write cost too much time,IMO
>> pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
>> On the other hand, we can use __pipe_{lock,unlock} to protect
>> the pipe->{head,tail} in pipe_resize_ring and
>> post_one_notification.
>>
>> Reminded by Matthew, I tested this patch using UnixBench's pipe
>> test case on a x86_64 machine,and get the following data:
>> 1) before this patch
>> System Benchmarks Partial Index  BASELINE       RESULT    INDEX
>> Pipe Throughput                   12440.0     493023.3    396.3
>>                                                          ========
>> System Benchmarks Index Score (Partial Only)              396.3
>>
>> 2) after this patch
>> System Benchmarks Partial Index  BASELINE       RESULT    INDEX
>> Pipe Throughput                   12440.0     507551.4    408.0
>>                                                          ========
>> System Benchmarks Index Score (Partial Only)              408.0
>>
>> so we get ~3% speedup.
>>
>> Reminded by Andrew, I tested this patch with the test code in
>> Linus's 0ddad21d3e99 add get following result:
>> 1) before this patch
>>           13,136.54 msec task-clock           #    3.870 CPUs utilized
>>           1,186,779      context-switches     #   90.342 K/sec
>>             668,867      cpu-migrations       #   50.917 K/sec
>>                 895      page-faults          #   68.131 /sec
>>      29,875,711,543      cycles               #    2.274 GHz
>>      12,372,397,462      instructions         #    0.41  insn per cycle
>>       2,480,235,723      branches             #  188.804 M/sec
>>          47,191,943      branch-misses        #    1.90% of all branches
>>
>>         3.394806886 seconds time elapsed
>>
>>         0.037869000 seconds user
>>         0.189346000 seconds sys
>>
>> 2) after this patch
>>
>>           12,395.63 msec task-clock          #    4.138 CPUs utilized
>>           1,193,381      context-switches    #   96.274 K/sec
>>             585,543      cpu-migrations      #   47.238 K/sec
>>               1,063      page-faults         #   85.756 /sec
>>      27,691,587,226      cycles              #    2.234 GHz
>>      11,738,307,999      instructions        #    0.42  insn per cycle
>>       2,351,299,522      branches            #  189.688 M/sec
>>          45,404,526      branch-misses       #    1.93% of all branches
>>
>>         2.995280878 seconds time elapsed
>>
>>         0.010615000 seconds user
>>         0.206999000 seconds sys
>> After adding this patch, the time used on this test program becomes less.
>>
>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>>
>> v3:
>>    - fixes the error reported by kernel test robot <oliver.sang@intel.com>
>>      Link: https://lore.kernel.org/oe-lkp/202301061340.c954d61f-oliver.sang@intel.com
>>    - add perf stat data for the test code in Linus's 0ddad21d3e99 in
>>      commit message.
>> v2:
>>    - add UnixBench test data in commit message
>>    - fixes the test error reported by kernel test robot <lkp@intel.com>
>>      by adding the missing fs.h header file.
>> ---
>>   fs/pipe.c                 | 22 +---------------------
>>   include/linux/pipe_fs_i.h | 12 ++++++++++++
>>   kernel/watch_queue.c      |  8 ++++----
>>   3 files changed, 17 insertions(+), 25 deletions(-)
>>
>> diff --git a/fs/pipe.c b/fs/pipe.c
>> index 42c7ff41c2db..4355ee5f754e 100644
>> --- a/fs/pipe.c
>> +++ b/fs/pipe.c
>> @@ -98,16 +98,6 @@ void pipe_unlock(struct pipe_inode_info *pipe)
>>   }
>>   EXPORT_SYMBOL(pipe_unlock);
>>   -static inline void __pipe_lock(struct pipe_inode_info *pipe)
>> -{
>> -    mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
>> -}
>> -
>> -static inline void __pipe_unlock(struct pipe_inode_info *pipe)
>> -{
>> -    mutex_unlock(&pipe->mutex);
>> -}
>> -
>>   void pipe_double_lock(struct pipe_inode_info *pipe1,
>>                 struct pipe_inode_info *pipe2)
>>   {
>> @@ -253,8 +243,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>>        */
>>       was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
>>       for (;;) {
>> -        /* Read ->head with a barrier vs post_one_notification() */
>> -        unsigned int head = smp_load_acquire(&pipe->head);
>> +        unsigned int head = pipe->head;
>>           unsigned int tail = pipe->tail;
>>           unsigned int mask = pipe->ring_size - 1;
>>   @@ -322,14 +311,12 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>>                 if (!buf->len) {
>>                   pipe_buf_release(pipe, buf);
>> -                spin_lock_irq(&pipe->rd_wait.lock);
>>   #ifdef CONFIG_WATCH_QUEUE
>>                   if (buf->flags & PIPE_BUF_FLAG_LOSS)
>>                       pipe->note_loss = true;
>>   #endif
>>                   tail++;
>>                   pipe->tail = tail;
>> -                spin_unlock_irq(&pipe->rd_wait.lock);
>>               }
>>               total_len -= chars;
>>               if (!total_len)
>> @@ -506,16 +493,13 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>>                * it, either the reader will consume it or it'll still
>>                * be there for the next write.
>>                */
>> -            spin_lock_irq(&pipe->rd_wait.lock);
>>                 head = pipe->head;
>>               if (pipe_full(head, pipe->tail, pipe->max_usage)) {
>> -                spin_unlock_irq(&pipe->rd_wait.lock);
>>                   continue;
>>               }
>>                 pipe->head = head + 1;
>> -            spin_unlock_irq(&pipe->rd_wait.lock);
>>                 /* Insert it into the buffer array */
>>               buf = &pipe->bufs[head & mask];
>> @@ -1260,14 +1244,12 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
>>       if (unlikely(!bufs))
>>           return -ENOMEM;
>>   -    spin_lock_irq(&pipe->rd_wait.lock);
>>       mask = pipe->ring_size - 1;
>>       head = pipe->head;
>>       tail = pipe->tail;
>>         n = pipe_occupancy(head, tail);
>>       if (nr_slots < n) {
>> -        spin_unlock_irq(&pipe->rd_wait.lock);
>>           kfree(bufs);
>>           return -EBUSY;
>>       }
>> @@ -1303,8 +1285,6 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
>>       pipe->tail = tail;
>>       pipe->head = head;
>>   -    spin_unlock_irq(&pipe->rd_wait.lock);
>> -
>>       /* This might have made more room for writers */
>>       wake_up_interruptible(&pipe->wr_wait);
>>       return 0;
>> diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
>> index 6cb65df3e3ba..f5084daf6eaf 100644
>> --- a/include/linux/pipe_fs_i.h
>> +++ b/include/linux/pipe_fs_i.h
>> @@ -2,6 +2,8 @@
>>   #ifndef _LINUX_PIPE_FS_I_H
>>   #define _LINUX_PIPE_FS_I_H
>>   +#include <linux/fs.h>
>> +
>>   #define PIPE_DEF_BUFFERS    16
>>     #define PIPE_BUF_FLAG_LRU    0x01    /* page is on the LRU */
>> @@ -223,6 +225,16 @@ static inline void pipe_discard_from(struct pipe_inode_info *pipe,
>>   #define PIPE_SIZE        PAGE_SIZE
>>     /* Pipe lock and unlock operations */
>> +static inline void __pipe_lock(struct pipe_inode_info *pipe)
>> +{
>> +    mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
>> +}
>> +
>> +static inline void __pipe_unlock(struct pipe_inode_info *pipe)
>> +{
>> +    mutex_unlock(&pipe->mutex);
>> +}
>> +
>>   void pipe_lock(struct pipe_inode_info *);
>>   void pipe_unlock(struct pipe_inode_info *);
>>   void pipe_double_lock(struct pipe_inode_info *, struct pipe_inode_info *);
>> diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
>> index a6f9bdd956c3..92e46cfe9419 100644
>> --- a/kernel/watch_queue.c
>> +++ b/kernel/watch_queue.c
>> @@ -108,7 +108,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
>>       if (!pipe)
>>           return false;
>>   -    spin_lock_irq(&pipe->rd_wait.lock);
>> +    __pipe_lock(pipe);
>>         mask = pipe->ring_size - 1;
>>       head = pipe->head;
>> @@ -135,17 +135,17 @@ static bool post_one_notification(struct watch_queue *wqueue,
>>       buf->offset = offset;
>>       buf->len = len;
>>       buf->flags = PIPE_BUF_FLAG_WHOLE;
>> -    smp_store_release(&pipe->head, head + 1); /* vs pipe_read() */
>> +    pipe->head = head + 1;
>>         if (!test_and_clear_bit(note, wqueue->notes_bitmap)) {
>> -        spin_unlock_irq(&pipe->rd_wait.lock);
>> +        __pipe_unlock(pipe);
>>           BUG();
>>       }
>>       wake_up_interruptible_sync_poll_locked(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
>>       done = true;
>>     out:
>> -    spin_unlock_irq(&pipe->rd_wait.lock);
>> +    __pipe_unlock(pipe);
>>       if (done)
>>           kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>>       return done;
>>
>> base-commit: c8451c141e07a8d05693f6c8d0e418fbb4b68bb7
>>

