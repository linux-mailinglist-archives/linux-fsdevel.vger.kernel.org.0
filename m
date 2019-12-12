Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4E011CA71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 11:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfLLKSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 05:18:08 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:58996 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728345AbfLLKSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:18:08 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 462D82E155F;
        Thu, 12 Dec 2019 13:18:04 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 6sBoM5pET9-I3KCvubY;
        Thu, 12 Dec 2019 13:18:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1576145884; bh=zaaqDW6B+Z+tvzrCtCpGdNpgn1+QS2zPkFpQlchb+uc=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=O7jE6t9nGVe3nijci/ma2dBmfXzaRRwbJzL0gnoucvmjPa8GRqXckdtG6Vfm8HlZV
         6xdqkOp5H7s9kt4ic2EcDZuLGRarEjD+jK7PCnZy2z43r9FXdQ0Q/qee0GkWJ5cOaO
         hEH897I9JrT7DQ66Cu3vieeQ10hvn8WOs6MnrOzI=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8007::1:d])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id DGpJEa6MbD-I2TS2axC;
        Thu, 12 Dec 2019 13:18:03 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz>
 <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <b2ae78da-1c29-8ef7-d0bb-376c52af37c3@yandex-team.ru>
Date:   Thu, 12 Dec 2019 13:18:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/12/2019 01.47, Linus Torvalds wrote:
> On Fri, Dec 6, 2019 at 7:50 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> The "make goes slow" problem bisects down to b667b8673443 ("pipe:
>> Advance tail pointer inside of wait spinlock in pipe_read()").
> 
> I'm not entirely sure that ends up being 100% true. It did bisect to
> that, but the behavior wasn't entirely stable. There definitely is
> some nasty timing trigger.
> 
> But I did finally figure out what seems to have been going on with at
> least the biggest part of the build performance regression. It's seems
> to be a nasty interaction with the scheduler and the GNU make
> jobserver, and in particular the pipe wakeups really _really_ do seem
> to want to be synchronous both for the readers and the writers.
> 
> When a writer wakes up a reader, we want the reader to react quickly
> and vice versa. The most obvious case was for the GNU make jobserver,
> where sub-makes would do a single-byte write to the jobserver pipe,
> and we want to wake up the reader *immediatly*, because the reader is
> actually a lot more important than the writer. The reader is what gets
> the next job going, the writer just got done with the last one.
> 
> And when a reader empties a full pipe, it's because the writer is
> generating data, and you want to just get the writer going again asap.
> 
> Anyway, I've spent way too much time looking at this and wondering
> about odd performance patterns. It seems to be mostly back up to
> normal.
> 
> I say "mostly", because I still see times of "not as many concurrent
> compiles going as I'd expect". It might be a kbuild problem, it might
> be an issue with GNU make (I've seen problems with the make jobserver
> wanting many more tokens than expected before and the kernel makefiles
> - it migth be about deep subdirectories etc), and it might be some
> remaining pipe issue. But my allmodconfig builds aren't _enormously_
> slower than they used to be.
> 
> But there's definitely some unhappy interaction with the jobserver. I
> have 16 threads (8 cores with HT), and I generally use "make -j32" to
> keep them busy because the jobserver isn't great. The pipe rework made
> even that 2x slop not work all that well. Something held on to tokens
> too long, and there was definitely some interaction with the pipe
> wakeup code. Using "-j64" hid the problem, but it was a problem.
> 
> It might be the new scheduler balancing changes that are interacting
> with the pipe thing. I'm adding PeterZ, Ingo and Vincent to the cc,
> because I hadn't realized just how important the sync wakeup seems to
> be for pipe performance even at a big level.
> 
> I've pushed out my pipe changes. I really didn't want to do that kind
> of stuff at the end of the merge window, but I spent a lot more time
> than I wanted looking at this code, because I was getting to the point
> where the alternative was to just revert it all.
> 
> DavidH, give these a look:
> 
b>    85190d15f4ea pipe: don't use 'pipe_wait() for basic pipe IO
>    a28c8b9db8a1 pipe: remove 'waiting_writers' merging logic
>    f467a6a66419 pipe: fix and clarify pipe read wakeup logic
>    1b6b26ae7053 pipe: fix and clarify pipe write wakeup logic
>    ad910e36da4c pipe: fix poll/select race introduced by the pipe rework

commit f467a6a66419 pipe: fix and clarify pipe read wakeup logic
killed "wake writer when buffer becomes half empty" part added by
commit cefa80ced57a ("pipe: Increase the writer-wakeup threshold to reduce context-switch count").

I suppose that was unintentional. Jobserver juggles with few bytes and
should never reach half/full buffer thresholds.

Also reader should wake writer with sync wakeup only if buffer is empty.
Otherwise sync wakeup adds couple unneeded context switches.

> 
> the top two of which are purely "I'm fed up looking at this code, this
> needs to go" kind of changes.
> 
> In particular, that last change is because I think the GNU jobserver
> problem is partly a thundering herd issue: when a job token becomes
> free (ie somebody does a one-byte write to an empty jobserver pipe),
> it wakes up *everybody* who is waiting for a token. One of them will
> get it, and the others will go to sleep again. And then it repeats all
> over. I didn't fix it, but it _could_ be fixed with exclusive waits
> for readers/writers, but that means more smarts than pipe_wait() can
> do. And because the jobserver isn't great at keeping everybody happy,
> I'm using a much bigger "make -jX" value than the number of CPU's I
> have, which makes the herd bigger. And I suspect none of this helps
> the scheduler pick the _right_ process to run, which just makes
> scheduling an even bigger problem.
> 
>              Linus
> 

