Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4793B17C362
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 18:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgCFRAX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 12:00:23 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44440 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgCFRAX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:00:23 -0500
Received: by mail-io1-f68.google.com with SMTP id u17so2722290iog.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 09:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+z8CpGL4hEw9tnI3J6pWUFHBPp9qMxv+lu3HcSPP2RU=;
        b=fsdYdoQZ5rCWiofSNZCNLZv3gVD3fTVpRI8TqMIuS/vrbpJGX7PTSbikhc/cNJCaVH
         9tV9/GLCU4Ssb4XUmiIficXRMq/2Tc3YcohqbhIj1ZjS92770mfLq38aVCGn6lVq4iJq
         jbfwtl4JbLv5AiCufjzfFkIy5pAmSRSg+qzXDPF6ZIuVvoazqhlOaBu8ylbOOBxYI3Wk
         Q6Y3k4LxRSwMViRPxUcwzaYAF8eUTcqv+XEmgeSr/XAJSFIaqWfD4dK4o0mbkwkXSQkl
         Gp0HyNiXp06g2o/ueu/xXwDShqdpSgeli9LMC6ws1A8NGalMDyRzqSN65CoyySpfFwdt
         0bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+z8CpGL4hEw9tnI3J6pWUFHBPp9qMxv+lu3HcSPP2RU=;
        b=id6IJdq+1rCbbGsIfRJiMht5FJgJ0Vi2tA61eWxZ7qR0CE8aTzjmoogVkIrJMA5A3f
         Ksu+rAdcISFVKLeJ1WB9rpCSL5sB/JgfTZZqZ2YDeCC7QGylIXDB1k6p6yyK5jlojjWO
         XA69YIyx5dXsHwrq/yRsA6NB0VlYJsD647m6Xof2L4Cz2ihIp4eRa3npVAbnYIWHtopL
         gHkZQ7YVlr+TswdOwHI/h8oxP7XR8br+jod90v6A3yK2WkkP865pfgIqB/UfUZ8HZdk5
         V0ONDq9j0xJEHRjjnVctYIfTHRQsmwo7afDh3BovRJrJSENMpYXxLjqVOgAbmZbsauYW
         FpEA==
X-Gm-Message-State: ANhLgQ1GmSP77hSiNg6+4FZ2+GeCvJWngzPIUD1JKN/We+p88Ie8xfFs
        MtG3wbQVXhnSO7o4v/oteiUeFg==
X-Google-Smtp-Source: ADFU+vsf6953Rv2hazArjhQJ3IYWxGjDkAle2LIA5T+/HuZRwXQOjBNrKyc7WLBke9gRyFVWHHo5Wg==
X-Received: by 2002:a02:6947:: with SMTP id e68mr3984090jac.137.1583514022264;
        Fri, 06 Mar 2020 09:00:22 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q16sm6854366ioh.49.2020.03.06.09.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 09:00:21 -0800 (PST)
Subject: Re: KASAN: use-after-free Read in percpu_ref_switch_to_atomic_rcu
To:     paulmck@kernel.org, Jann Horn <jannh@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e017e49c39ab484ac87a@syzkaller.appspotmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, tony.luck@intel.com,
        the arch/x86 maintainers <x86@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <00000000000067c6df059df7f9f5@google.com>
 <CACT4Y+ZVLs7O84qixsvFqk_Nur1WOaCU81RiCwDf3wOqvHB-ag@mail.gmail.com>
 <3f805e51-1db7-3e57-c9a3-15a20699ea54@kernel.dk>
 <CAG48ez3DUAraFL1+agBX=1JVxzh_e2GR=UpX5JUaoyi+1gQ=6w@mail.gmail.com>
 <075e7fbe-aeec-cb7d-9338-8eb4e1576293@kernel.dk>
 <CAG48ez07bD4sr5hpDhUKe2g5ETk0iYb6PCWqyofPuJbXz1z+hw@mail.gmail.com>
 <20200306164443.GU2935@paulmck-ThinkPad-P72>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <11921f78-c6f2-660b-5e33-11599c2f9a4b@kernel.dk>
Date:   Fri, 6 Mar 2020 10:00:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200306164443.GU2935@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/6/20 9:44 AM, Paul E. McKenney wrote:
> On Fri, Mar 06, 2020 at 04:36:20PM +0100, Jann Horn wrote:
>> On Fri, Mar 6, 2020 at 4:34 PM Jens Axboe <axboe@kernel.dk> wrote:
>>> On 3/6/20 7:57 AM, Jann Horn wrote:
>>>> +paulmck
>>>>
>>>> On Wed, Mar 4, 2020 at 3:40 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>> On 3/4/20 12:59 AM, Dmitry Vyukov wrote:
>>>>>> On Fri, Feb 7, 2020 at 9:14 AM syzbot
>>>>>> <syzbot+e017e49c39ab484ac87a@syzkaller.appspotmail.com> wrote:
>>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> syzbot found the following crash on:
>>>>>>>
>>>>>>> HEAD commit:    4c7d00cc Merge tag 'pwm/for-5.6-rc1' of git://git.kernel.o..
>>>>>>> git tree:       upstream
>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=12fec785e00000
>>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e162021ddededa72
>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=e017e49c39ab484ac87a
>>>>>>> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>>>>>>>
>>>>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>>>>
>>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>>>>> Reported-by: syzbot+e017e49c39ab484ac87a@syzkaller.appspotmail.com
>>>>>>
>>>>>> +io_uring maintainers
>>>>>>
>>>>>> Here is a repro:
>>>>>> https://gist.githubusercontent.com/dvyukov/6b340beab6483a036f4186e7378882ce/raw/cd1922185516453c201df8eded1d4b006a6d6a3a/gistfile1.txt
>>>>>
>>>>> I've queued up a fix for this:
>>>>>
>>>>> https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.6&id=9875fe3dc4b8cff1f1b440fb925054a5124403c3
>>>>
>>>> I believe that this fix relies on call_rcu() having FIFO ordering; but
>>>> <https://www.kernel.org/doc/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html#Callback%20Registry>
>>>> says:
>>>>
>>>> | call_rcu() normally acts only on CPU-local state[...] It simply
>>>> enqueues the rcu_head structure on a per-CPU list,
> 
> Indeed.  For but one example, if there was a CPU-to-CPU migration between
> the two call_rcu() invocations, it would not be at all surprising for
> the two callbacks to execute out of order.
> 
>>>> Is this fix really correct?
>>>
>>> That's a good point, there's a potentially stronger guarantee we need
>>> here that isn't "nobody is inside an RCU critical section", but rather
>>> that we're depending on a previous call_rcu() to have happened. Hence I
>>> think you are right - it'll shrink the window drastically, since the
>>> previous callback is already queued up, but it's not a full close.
>>>
>>> Hmm...
>>
>> You could potentially hack up the semantics you want by doing a
>> call_rcu() whose callback does another call_rcu(), or something like
>> that - but I'd like to hear paulmck's opinion on this first.
> 
> That would work!
> 
> Or, alternatively, do an rcu_barrier() between the two calls to
> call_rcu(), assuming that the use case can tolerate rcu_barrier()
> overhead and latency.

If the nested call_rcu() works, that seems greatly preferable to needing
the rcu_barrier(), even if that would not be a showstopper for me. The
nested call_rcu() is just a bit odd, but with a comment it should be OK.

Incremental here I'm going to test, would just fold in of course.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index f3218fc81943..95ba95b4d8ec 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5330,7 +5330,7 @@ static void io_file_ref_kill(struct percpu_ref *ref)
 	complete(&data->done);
 }
 
-static void io_file_ref_exit_and_free(struct rcu_head *rcu)
+static void __io_file_ref_exit_and_free(struct rcu_head *rcu)
 {
 	struct fixed_file_data *data = container_of(rcu, struct fixed_file_data,
 							rcu);
@@ -5338,6 +5338,18 @@ static void io_file_ref_exit_and_free(struct rcu_head *rcu)
 	kfree(data);
 }
 
+static void io_file_ref_exit_and_free(struct rcu_head *rcu)
+{
+	/*
+	 * We need to order our exit+free call again the potentially
+	 * existing call_rcu() for switching to atomic. One way to do that
+	 * is to have this rcu callback queue the final put and free, as we
+	 * could otherwise a pre-existing atomic switch complete _after_
+	 * the free callback we queued.
+	 */
+	call_rcu(rcu, __io_file_ref_exit_and_free);
+}
+
 static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
 {
 	struct fixed_file_data *data = ctx->file_data;

-- 
Jens Axboe

