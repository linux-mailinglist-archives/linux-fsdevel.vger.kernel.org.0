Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D5965CC39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 04:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjADDqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Jan 2023 22:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjADDqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Jan 2023 22:46:33 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A688183AE;
        Tue,  3 Jan 2023 19:46:30 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.185])
        by gateway (Coremail) with SMTP id _____8BxE_CV9rRjB0wKAA--.22796S3;
        Wed, 04 Jan 2023 11:46:29 +0800 (CST)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxyuaT9rRjAHsTAA--.62435S3;
        Wed, 04 Jan 2023 11:46:28 +0800 (CST)
Subject: Re: [PATCH v2] pipe: use __pipe_{lock,unlock} instead of spinlock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230103063303.23345-1-zhanghongchen@loongson.cn>
 <Y7RrGOE65XKkzJuz@casper.infradead.org>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <fda0ca43-55b4-0192-bcee-281f5a1dda5a@loongson.cn>
Date:   Wed, 4 Jan 2023 11:46:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Y7RrGOE65XKkzJuz@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxyuaT9rRjAHsTAA--.62435S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3XFykGw43tFy8Ww13Xr13urg_yoWxXF48pa
        n8KF47uFWUAr10gryxGrsxZFn2g390gF17CrWxGa4FvF9FkryFgF4qkFyakFn5Ars7CryY
        vF4UXa4F9r1UArJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On 2023/1/4 am 1:51, Matthew Wilcox wrote:
> On Tue, Jan 03, 2023 at 02:33:03PM +0800, Hongchen Zhang wrote:
>> Use spinlock in pipe_read/write cost too much time,IMO
> 
> Everybody has an opinion.  Do you have data?
> 
I tested this patch using UnixBench's pipe test case on a x86_64 
machine,and get the following data:
1) before this patch
System Benchmarks Partial Index  BASELINE       RESULT    INDEX
Pipe Throughput                   12440.0     493023.3    396.3
                                                                    ========
System Benchmarks Index Score (Partial Only)              396.3

2) after this patch
System Benchmarks Partial Index  BASELINE       RESULT    INDEX
Pipe Throughput                   12440.0     507551.4    408.0
                                                                    ========
System Benchmarks Index Score (Partial Only)              408.0

so we get ~3% speedup.

>> pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
>> On the other hand, we can use __pipe_lock/unlock to protect the
>> pipe->head/tail in pipe_resize_ring and post_one_notification.
>>
>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>> ---
> 
> you're supposed to write here what changes you made between v1 and v2.
> 
I added the linux/fs.h in v2 to fix the linux-test-robot test error in v1.
>>   fs/pipe.c                 | 24 ++++--------------------
>>   include/linux/pipe_fs_i.h | 12 ++++++++++++
>>   kernel/watch_queue.c      |  8 ++++----
>>   3 files changed, 20 insertions(+), 24 deletions(-)
>>
>> diff --git a/fs/pipe.c b/fs/pipe.c
>> index 42c7ff41c2db..cf449779bf71 100644
>> --- a/fs/pipe.c
>> +++ b/fs/pipe.c
>> @@ -98,16 +98,6 @@ void pipe_unlock(struct pipe_inode_info *pipe)
>>   }
>>   EXPORT_SYMBOL(pipe_unlock);
>>   
>> -static inline void __pipe_lock(struct pipe_inode_info *pipe)
>> -{
>> -	mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
>> -}
>> -
>> -static inline void __pipe_unlock(struct pipe_inode_info *pipe)
>> -{
>> -	mutex_unlock(&pipe->mutex);
>> -}
>> -
>>   void pipe_double_lock(struct pipe_inode_info *pipe1,
>>   		      struct pipe_inode_info *pipe2)
>>   {
>> @@ -253,8 +243,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>>   	 */
>>   	was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
>>   	for (;;) {
>> -		/* Read ->head with a barrier vs post_one_notification() */
>> -		unsigned int head = smp_load_acquire(&pipe->head);
>> +		unsigned int head = pipe->head;
>>   		unsigned int tail = pipe->tail;
>>   		unsigned int mask = pipe->ring_size - 1;
>>   
>> @@ -322,14 +311,12 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>>   
>>   			if (!buf->len) {
>>   				pipe_buf_release(pipe, buf);
>> -				spin_lock_irq(&pipe->rd_wait.lock);
>>   #ifdef CONFIG_WATCH_QUEUE
>>   				if (buf->flags & PIPE_BUF_FLAG_LOSS)
>>   					pipe->note_loss = true;
>>   #endif
>>   				tail++;
>>   				pipe->tail = tail;
>> -				spin_unlock_irq(&pipe->rd_wait.lock);
>>   			}
>>   			total_len -= chars;
>>   			if (!total_len)
>> @@ -506,16 +493,13 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>>   			 * it, either the reader will consume it or it'll still
>>   			 * be there for the next write.
>>   			 */
>> -			spin_lock_irq(&pipe->rd_wait.lock);
>>   
>>   			head = pipe->head;
>>   			if (pipe_full(head, pipe->tail, pipe->max_usage)) {
>> -				spin_unlock_irq(&pipe->rd_wait.lock);
>>   				continue;
>>   			}
>>   
>>   			pipe->head = head + 1;
>> -			spin_unlock_irq(&pipe->rd_wait.lock);
>>   
>>   			/* Insert it into the buffer array */
>>   			buf = &pipe->bufs[head & mask];
>> @@ -1260,14 +1244,14 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
>>   	if (unlikely(!bufs))
>>   		return -ENOMEM;
>>   
>> -	spin_lock_irq(&pipe->rd_wait.lock);
>> +	__pipe_lock(pipe);
>>   	mask = pipe->ring_size - 1;
>>   	head = pipe->head;
>>   	tail = pipe->tail;
>>   
>>   	n = pipe_occupancy(head, tail);
>>   	if (nr_slots < n) {
>> -		spin_unlock_irq(&pipe->rd_wait.lock);
>> +		__pipe_unlock(pipe);
>>   		kfree(bufs);
>>   		return -EBUSY;
>>   	}
>> @@ -1303,7 +1287,7 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
>>   	pipe->tail = tail;
>>   	pipe->head = head;
>>   
>> -	spin_unlock_irq(&pipe->rd_wait.lock);
>> +	__pipe_unlock(pipe);
>>   
>>   	/* This might have made more room for writers */
>>   	wake_up_interruptible(&pipe->wr_wait);
>> diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
>> index 6cb65df3e3ba..f5084daf6eaf 100644
>> --- a/include/linux/pipe_fs_i.h
>> +++ b/include/linux/pipe_fs_i.h
>> @@ -2,6 +2,8 @@
>>   #ifndef _LINUX_PIPE_FS_I_H
>>   #define _LINUX_PIPE_FS_I_H
>>   
>> +#include <linux/fs.h>
>> +
>>   #define PIPE_DEF_BUFFERS	16
>>   
>>   #define PIPE_BUF_FLAG_LRU	0x01	/* page is on the LRU */
>> @@ -223,6 +225,16 @@ static inline void pipe_discard_from(struct pipe_inode_info *pipe,
>>   #define PIPE_SIZE		PAGE_SIZE
>>   
>>   /* Pipe lock and unlock operations */
>> +static inline void __pipe_lock(struct pipe_inode_info *pipe)
>> +{
>> +	mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
>> +}
>> +
>> +static inline void __pipe_unlock(struct pipe_inode_info *pipe)
>> +{
>> +	mutex_unlock(&pipe->mutex);
>> +}
>> +
>>   void pipe_lock(struct pipe_inode_info *);
>>   void pipe_unlock(struct pipe_inode_info *);
>>   void pipe_double_lock(struct pipe_inode_info *, struct pipe_inode_info *);
>> diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
>> index a6f9bdd956c3..92e46cfe9419 100644
>> --- a/kernel/watch_queue.c
>> +++ b/kernel/watch_queue.c
>> @@ -108,7 +108,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
>>   	if (!pipe)
>>   		return false;
>>   
>> -	spin_lock_irq(&pipe->rd_wait.lock);
>> +	__pipe_lock(pipe);
>>   
>>   	mask = pipe->ring_size - 1;
>>   	head = pipe->head;
>> @@ -135,17 +135,17 @@ static bool post_one_notification(struct watch_queue *wqueue,
>>   	buf->offset = offset;
>>   	buf->len = len;
>>   	buf->flags = PIPE_BUF_FLAG_WHOLE;
>> -	smp_store_release(&pipe->head, head + 1); /* vs pipe_read() */
>> +	pipe->head = head + 1;
>>   
>>   	if (!test_and_clear_bit(note, wqueue->notes_bitmap)) {
>> -		spin_unlock_irq(&pipe->rd_wait.lock);
>> +		__pipe_unlock(pipe);
>>   		BUG();
>>   	}
>>   	wake_up_interruptible_sync_poll_locked(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
>>   	done = true;
>>   
>>   out:
>> -	spin_unlock_irq(&pipe->rd_wait.lock);
>> +	__pipe_unlock(pipe);
>>   	if (done)
>>   		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>>   	return done;
>>
>> base-commit: c8451c141e07a8d05693f6c8d0e418fbb4b68bb7
>> -- 
>> 2.31.1
>>

