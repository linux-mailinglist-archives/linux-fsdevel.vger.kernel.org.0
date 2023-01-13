Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F24866932E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 10:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjAMJoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 04:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240887AbjAMJmi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:42:38 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F0B2BE9;
        Fri, 13 Jan 2023 01:32:59 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id g14so21862324ljh.10;
        Fri, 13 Jan 2023 01:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IhvS2SqXq2pUb5bw9UmK0RbvOS1oQlX0IkkKZEx5NFM=;
        b=CBqlFaIBC0G7av3u0uMubjgvwCE+3snsBVqJ1TYFHhidDSVNkcd82zRHGMI71MXZo+
         KKYmiXmb5Qv16y8WLSwFq4DEJ8Vbr8smeS7FeOvR6X0Qn+/3KzSvH/Gy22xyqIHW/CIo
         AuoswzlvroJxCeH+3GDZSRVw9RMh33csfCTim5yR8/U6/A0T6PSftl+e68MujXS7E4jy
         gnG0ZES++k594kDSjFOrpWjLQwuavnbCi3eOeS5kwzjnhnr+8c0QSH/e/36XZBafQEFH
         llx0GWROwR8Uu/7b0RtDuWAHE6kIa696xAFPzltXS/BAUhXz786H/YppNwV3hl3vNeMX
         uKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IhvS2SqXq2pUb5bw9UmK0RbvOS1oQlX0IkkKZEx5NFM=;
        b=23/U4KvuuTw6iNkMOgGZsJWOoBK0K3q4pmLTXjxRI3LckRVARhkek69TogJ1Ajasvx
         MDWG6H9oxDKt7InXJ3GC6AEJiZ/duZPuBkOTTZ44+TLXIlZpb10ct1ZLdPZmyCIDkvoA
         2C/DLoWgX58PpOfFobpA6eFX2rRBe+G4bYQ8EyMGipBPphkwu0n7YengWcvvkmntgVSY
         E2tmu140KtGHXpMIGmDbk78jObzN/HvsdElLmxVhnsqS943I6jyk0EqXpH6UQ0m5O+Vp
         OzBVvrdJa5b8jorWCNPamEQ1SpRrHJMe76hghNdOah6RPSYlLfXTgGwykQQP3ltKwnnE
         AoGg==
X-Gm-Message-State: AFqh2kpJkxd2OqyRKNgdwqosNCOneMr8XsOSDnfa1ze6Z3BKHAo0bH2Y
        3VUt1nuyDgf7WBKWVopVZXSoyzfjc5VxMchHJbzvNvyIwMdcjw==
X-Google-Smtp-Source: AMrXdXtwzl8z/0Lxv2na7K6vS50uGe2dnCxzR7Kv6IK+2QbrcNF6fvIkWngRqXuYlsBZ86gZWADO648RkqrtG7Ire9U=
X-Received: by 2002:a2e:bf19:0:b0:27f:ae14:6ac9 with SMTP id
 c25-20020a2ebf19000000b0027fae146ac9mr3293081ljr.300.1673602377606; Fri, 13
 Jan 2023 01:32:57 -0800 (PST)
MIME-Version: 1.0
References: <20230107012324.30698-1-zhanghongchen@loongson.cn> <9fcb3f80-cb55-9a72-0e74-03ace2408d21@loongson.cn>
In-Reply-To: <9fcb3f80-cb55-9a72-0e74-03ace2408d21@loongson.cn>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 13 Jan 2023 10:32:19 +0100
Message-ID: <CA+icZUU3-t0+NhdMQ39OeuwR13eMVOKVhLwS31WTHQ1ksaWgNg@mail.gmail.com>
Subject: Re: [PATCH v3] pipe: use __pipe_{lock,unlock} instead of spinlock
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 13, 2023 at 4:19 AM Hongchen Zhang
<zhanghongchen@loongson.cn> wrote:
>
> Hi All,
> any question about this patch, can it be merged?
>
> Thanks
> On 2023/1/7 am 9:23, Hongchen Zhang wrote:
> > Use spinlock in pipe_read/write cost too much time,IMO
> > pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
> > On the other hand, we can use __pipe_{lock,unlock} to protect
> > the pipe->{head,tail} in pipe_resize_ring and
> > post_one_notification.
> >
> > Reminded by Matthew, I tested this patch using UnixBench's pipe
> > test case on a x86_64 machine,and get the following data:
> > 1) before this patch
> > System Benchmarks Partial Index  BASELINE       RESULT    INDEX
> > Pipe Throughput                   12440.0     493023.3    396.3
> >                                                          ========
> > System Benchmarks Index Score (Partial Only)              396.3
> >
> > 2) after this patch
> > System Benchmarks Partial Index  BASELINE       RESULT    INDEX
> > Pipe Throughput                   12440.0     507551.4    408.0
> >                                                          ========
> > System Benchmarks Index Score (Partial Only)              408.0
> >
> > so we get ~3% speedup.
> >
> > Reminded by Andrew, I tested this patch with the test code in
> > Linus's 0ddad21d3e99 add get following result:

Happy new 2023 Hongchen Zhang,

Thanks for the update and sorry for the late response.

Should be "...s/add/and get following result:"

I cannot say much about the patch itself or tested it in my build-environment.

Best regards,
-Sedat-

> > 1) before this patch
> >           13,136.54 msec task-clock           #    3.870 CPUs utilized
> >           1,186,779      context-switches     #   90.342 K/sec
> >             668,867      cpu-migrations       #   50.917 K/sec
> >                 895      page-faults          #   68.131 /sec
> >      29,875,711,543      cycles               #    2.274 GHz
> >      12,372,397,462      instructions         #    0.41  insn per cycle
> >       2,480,235,723      branches             #  188.804 M/sec
> >          47,191,943      branch-misses        #    1.90% of all branches
> >
> >         3.394806886 seconds time elapsed
> >
> >         0.037869000 seconds user
> >         0.189346000 seconds sys
> >
> > 2) after this patch
> >
> >           12,395.63 msec task-clock          #    4.138 CPUs utilized
> >           1,193,381      context-switches    #   96.274 K/sec
> >             585,543      cpu-migrations      #   47.238 K/sec
> >               1,063      page-faults         #   85.756 /sec
> >      27,691,587,226      cycles              #    2.234 GHz
> >      11,738,307,999      instructions        #    0.42  insn per cycle
> >       2,351,299,522      branches            #  189.688 M/sec
> >          45,404,526      branch-misses       #    1.93% of all branches
> >
> >         2.995280878 seconds time elapsed
> >
> >         0.010615000 seconds user
> >         0.206999000 seconds sys
> > After adding this patch, the time used on this test program becomes less.
> >
> > Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> >
> > v3:
> >    - fixes the error reported by kernel test robot <oliver.sang@intel.com>
> >      Link: https://lore.kernel.org/oe-lkp/202301061340.c954d61f-oliver.sang@intel.com
> >    - add perf stat data for the test code in Linus's 0ddad21d3e99 in
> >      commit message.
> > v2:
> >    - add UnixBench test data in commit message
> >    - fixes the test error reported by kernel test robot <lkp@intel.com>
> >      by adding the missing fs.h header file.
> > ---
> >   fs/pipe.c                 | 22 +---------------------
> >   include/linux/pipe_fs_i.h | 12 ++++++++++++
> >   kernel/watch_queue.c      |  8 ++++----
> >   3 files changed, 17 insertions(+), 25 deletions(-)
> >
> > diff --git a/fs/pipe.c b/fs/pipe.c
> > index 42c7ff41c2db..4355ee5f754e 100644
> > --- a/fs/pipe.c
> > +++ b/fs/pipe.c
> > @@ -98,16 +98,6 @@ void pipe_unlock(struct pipe_inode_info *pipe)
> >   }
> >   EXPORT_SYMBOL(pipe_unlock);
> >
> > -static inline void __pipe_lock(struct pipe_inode_info *pipe)
> > -{
> > -     mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
> > -}
> > -
> > -static inline void __pipe_unlock(struct pipe_inode_info *pipe)
> > -{
> > -     mutex_unlock(&pipe->mutex);
> > -}
> > -
> >   void pipe_double_lock(struct pipe_inode_info *pipe1,
> >                     struct pipe_inode_info *pipe2)
> >   {
> > @@ -253,8 +243,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
> >        */
> >       was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
> >       for (;;) {
> > -             /* Read ->head with a barrier vs post_one_notification() */
> > -             unsigned int head = smp_load_acquire(&pipe->head);
> > +             unsigned int head = pipe->head;
> >               unsigned int tail = pipe->tail;
> >               unsigned int mask = pipe->ring_size - 1;
> >
> > @@ -322,14 +311,12 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
> >
> >                       if (!buf->len) {
> >                               pipe_buf_release(pipe, buf);
> > -                             spin_lock_irq(&pipe->rd_wait.lock);
> >   #ifdef CONFIG_WATCH_QUEUE
> >                               if (buf->flags & PIPE_BUF_FLAG_LOSS)
> >                                       pipe->note_loss = true;
> >   #endif
> >                               tail++;
> >                               pipe->tail = tail;
> > -                             spin_unlock_irq(&pipe->rd_wait.lock);
> >                       }
> >                       total_len -= chars;
> >                       if (!total_len)
> > @@ -506,16 +493,13 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
> >                        * it, either the reader will consume it or it'll still
> >                        * be there for the next write.
> >                        */
> > -                     spin_lock_irq(&pipe->rd_wait.lock);
> >
> >                       head = pipe->head;
> >                       if (pipe_full(head, pipe->tail, pipe->max_usage)) {
> > -                             spin_unlock_irq(&pipe->rd_wait.lock);
> >                               continue;
> >                       }
> >
> >                       pipe->head = head + 1;
> > -                     spin_unlock_irq(&pipe->rd_wait.lock);
> >
> >                       /* Insert it into the buffer array */
> >                       buf = &pipe->bufs[head & mask];
> > @@ -1260,14 +1244,12 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
> >       if (unlikely(!bufs))
> >               return -ENOMEM;
> >
> > -     spin_lock_irq(&pipe->rd_wait.lock);
> >       mask = pipe->ring_size - 1;
> >       head = pipe->head;
> >       tail = pipe->tail;
> >
> >       n = pipe_occupancy(head, tail);
> >       if (nr_slots < n) {
> > -             spin_unlock_irq(&pipe->rd_wait.lock);
> >               kfree(bufs);
> >               return -EBUSY;
> >       }
> > @@ -1303,8 +1285,6 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
> >       pipe->tail = tail;
> >       pipe->head = head;
> >
> > -     spin_unlock_irq(&pipe->rd_wait.lock);
> > -
> >       /* This might have made more room for writers */
> >       wake_up_interruptible(&pipe->wr_wait);
> >       return 0;
> > diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
> > index 6cb65df3e3ba..f5084daf6eaf 100644
> > --- a/include/linux/pipe_fs_i.h
> > +++ b/include/linux/pipe_fs_i.h
> > @@ -2,6 +2,8 @@
> >   #ifndef _LINUX_PIPE_FS_I_H
> >   #define _LINUX_PIPE_FS_I_H
> >
> > +#include <linux/fs.h>
> > +
> >   #define PIPE_DEF_BUFFERS    16
> >
> >   #define PIPE_BUF_FLAG_LRU   0x01    /* page is on the LRU */
> > @@ -223,6 +225,16 @@ static inline void pipe_discard_from(struct pipe_inode_info *pipe,
> >   #define PIPE_SIZE           PAGE_SIZE
> >
> >   /* Pipe lock and unlock operations */
> > +static inline void __pipe_lock(struct pipe_inode_info *pipe)
> > +{
> > +     mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
> > +}
> > +
> > +static inline void __pipe_unlock(struct pipe_inode_info *pipe)
> > +{
> > +     mutex_unlock(&pipe->mutex);
> > +}
> > +
> >   void pipe_lock(struct pipe_inode_info *);
> >   void pipe_unlock(struct pipe_inode_info *);
> >   void pipe_double_lock(struct pipe_inode_info *, struct pipe_inode_info *);
> > diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
> > index a6f9bdd956c3..92e46cfe9419 100644
> > --- a/kernel/watch_queue.c
> > +++ b/kernel/watch_queue.c
> > @@ -108,7 +108,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
> >       if (!pipe)
> >               return false;
> >
> > -     spin_lock_irq(&pipe->rd_wait.lock);
> > +     __pipe_lock(pipe);
> >
> >       mask = pipe->ring_size - 1;
> >       head = pipe->head;
> > @@ -135,17 +135,17 @@ static bool post_one_notification(struct watch_queue *wqueue,
> >       buf->offset = offset;
> >       buf->len = len;
> >       buf->flags = PIPE_BUF_FLAG_WHOLE;
> > -     smp_store_release(&pipe->head, head + 1); /* vs pipe_read() */
> > +     pipe->head = head + 1;
> >
> >       if (!test_and_clear_bit(note, wqueue->notes_bitmap)) {
> > -             spin_unlock_irq(&pipe->rd_wait.lock);
> > +             __pipe_unlock(pipe);
> >               BUG();
> >       }
> >       wake_up_interruptible_sync_poll_locked(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
> >       done = true;
> >
> >   out:
> > -     spin_unlock_irq(&pipe->rd_wait.lock);
> > +     __pipe_unlock(pipe);
> >       if (done)
> >               kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> >       return done;
> >
> > base-commit: c8451c141e07a8d05693f6c8d0e418fbb4b68bb7
> >
>
