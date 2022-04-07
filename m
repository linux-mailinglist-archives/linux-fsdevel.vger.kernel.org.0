Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9DA4F7F6E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 14:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245409AbiDGMt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 08:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242785AbiDGMtX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:49:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141C392D33;
        Thu,  7 Apr 2022 05:47:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649335640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l0I9I6WV1S1O6FTGGqs5ZdqvRo5lJvmEwFUVwH/oV+U=;
        b=MFHvGLPyrEoJXZikbzZN3w0JkZL6HSMRqGDnxPZ0KuA+DjMOYwrtIciTJ/okXOHwd+xXGT
        BS4/9j1Jtv6EydYqmn+NA7XwdxGwk0VHxeU97XC3/uTzDvD/iJ0ZHETNmEJ9XPwpDRRMPh
        tl0RgLxWSlEdRnagx0ReNDZLDgauxJJUaJZHPxBRProolKPF0nK+t2pMdNSrHwbmH0PoCd
        6YfqCiBPXZJwT3E9WfQYp0/gWZFHXUEhr5Nqr4Yt/QfldP7BuruBkZaeQneBe5kZz7uWMW
        jvdLcIgbClBBzW2jYbxYilmgWGQuD6nZEyi0UIbl6BLqTX0zioLrbb4aNirpRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649335640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l0I9I6WV1S1O6FTGGqs5ZdqvRo5lJvmEwFUVwH/oV+U=;
        b=/2Ta+A6nKdnPawgIIqaCCFMIwPuuCPkTSrEj1P9rXDj3vBarf6uOD00BPIt438DyBa5QmM
        x8XkxiU/QG1YePDg==
To:     Matthew Wilcox <willy@infradead.org>,
        Liao Chang <liaochang1@huawei.com>
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        clg@kaod.org, nitesh@redhat.com, edumazet@google.com,
        peterz@infradead.org, joshdon@google.com, masahiroy@kernel.org,
        nathan@kernel.org, akpm@linux-foundation.org, vbabka@suse.cz,
        gustavoars@kernel.org, arnd@arndb.de, chris@chrisdown.name,
        dmitry.torokhov@gmail.com, linux@rasmusvillemoes.dk,
        daniel@iogearbox.net, john.ogness@linutronix.de, will@kernel.org,
        dave@stgolabs.net, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        heying24@huawei.com, guohanjun@huawei.com, weiyongjun1@huawei.com
Subject: Re: [RFC 0/3] softirq: Introduce softirq throttling
In-Reply-To: <Yk2ppI60P98E2Qj5@casper.infradead.org>
References: <20220406025241.191300-1-liaochang1@huawei.com>
 <Yk2ppI60P98E2Qj5@casper.infradead.org>
Date:   Thu, 07 Apr 2022 14:47:20 +0200
Message-ID: <877d81jc13.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 06 2022 at 15:54, Matthew Wilcox wrote:
> On Wed, Apr 06, 2022 at 10:52:38AM +0800, Liao Chang wrote:
>> Kernel check for pending softirqs periodically, they are performed in a
>> few points of kernel code, such as irq_exit() and __local_bh_enable_ip(),
>> softirqs that have been activated by a given CPU must be executed on the
>> same CPU, this characteristic of softirq is always a potentially
>> "dangerous" operation, because one CPU might be end up very busy while
>> the other are most idle.
>> 
>> Above concern is proven in a networking user case: recenlty, we
>> engineer find out the time used for connection re-establishment on
>> kernel v5.10 is 300 times larger than v4.19, meanwhile, softirq
>> monopolize almost 99% of CPU. This problem stem from that the connection
>> between Sender and Receiver node get lost, the NIC driver on Sender node
>> will keep raising NET_TX softirq before connection recovery. The system
>> log show that most of softirq is performed from __local_bh_enable_ip(),
>> since __local_bh_enable_ip is used widley in kernel code, it is very
>> easy to run out most of CPU, and the user-mode application can't obtain
>> enough CPU cycles to establish connection as soon as possible.
>
> Shouldn't you fix that bug instead?  This seems like papering over the
> bad effects of a bug and would make it harder to find bugs like this in
> the future.  Essentially, it's the same as a screaming hardware interrupt,
> except that it's a software interrupt, so we can fix the bug instead of
> working around broken hardware.

It's not necessarily broken hardware. It's a fundamental issue of our
softirq processing magic which can happen in those contexts:

   1) On return from interrupt

   2) In local_bh_enable()

   3) In ksoftirqd

We have heuristics in place which delegate processing to ksoftirqd,
which brings softirq processing under scheduler control to some extent,
but those heuristics are rather easy to evade.

Delegation to ksoftirqd happens when the runtime of the __do_softirq()
loop exceeds a threshold. But if that is not exceeded then you still can
get into a situation where softirq processing eats up a large quantity
of CPU time in #1 and #2 which is the real problem because it prevents
the scheduler from applying fairness.

That's a known issue and attempts to fix that are popping up on a
regular base. There are several issues here:

  1) The runtime check in __do_softirq() is jiffies based and depending
     on CONFIG_HZ it's easy to stay under the threshold for one
     invocation, but still eat a large amount of CPU time.

     Also the runtime check happens at the end of the loop, which means
     that if a single softirq callback runs too long we still process
     all other pending ones.

  2) The decision to process softirqs directly on return from interrupt
     or in local_bh_enable() is error prone.

     The logic is:

         if (!ksoftirq_running() ||
             local_softirq_pending() & (SOFTIRQ_HI | SOFTIRQ_TASKLET))
         	process_direct();

     The reason for the HI/TASKLET exception is documented here:

         3c53776e29f8 ("Mark HI and TASKLET softirq synchronous")

     But this is nasty because tasklets are widely used in networking,
     crypto and quite some of them are self rearming when they take too
     long. See mlx5_cq_tasklet_cb() as one example, which also uses
     jiffies for time limiting...

     With the HI/TASKLET exception this means that there is no
     delegation to ksoftirqd simply because on the next return from
     interrupt or the next local_bh_enable() in task context softirqs
     are processed. And this processes _all_ pending bits not only the
     HI/TASKLET ones...

The approach of just not running softirqs at all via a throttle
mechanism as proposed with these patches here, is definitely wrong and
going nowhere.

The proper solution for load accounting is a moving average with
exponential decay based on sched_clock() and not on jiffies. That gives
a reasonable decision to enforce ksoftirqd processing, but of course
that does neither solve the tasklet issues nor any of the other problems
vs. softirqs at all.

We've tried splitting ksoftirqd into different threads a couple of years
ago in RT, but that turned out to be problematic in some cases. Frederic
did some experiments to make local_bh_disable() take a mask argument to
disable only particular softirqs, but that ran into a dead end and is
problematic because quite some code, esp. networking relies on multiple
softirqs being disabled.

Softirqs are semantically ill defined and that's known for a very long
time, but of course they are conveniant and with a few hacks piled on
top to address the most urgent horrors they work by some definition of
work. IOW, we are accumulating technical depth with a fast pace.

TBH, I have no real good plan how to address this proper, but it's about
time to tackle this in a concerted effort.

Thanks,

        tglx
