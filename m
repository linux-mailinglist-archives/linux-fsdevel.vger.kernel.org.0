Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A877424106C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 21:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgHJT3u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 15:29:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22785 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729454AbgHJT3t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597087787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dcoyHjjvNSHTFrWcUCA+seEOF/h9/vEn94GBe2ClYh8=;
        b=KsCcpsfVzMdatKmCNUow35pgnDH98wVRq5Jssoy3QIOZJZByRXf6Rjt0pSEfl3d4GkQaV4
        5+53DLOIU+w2INTGhUa6y99yIrS+y3AZ9EdyTSwvtc4TDFnsYz+TsKU4RVHWdNTKcEFeNj
        wMr1j6MS7W598OGcdGjTr8ObI3l2ylU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-KsQG-zhgNkmoQQ5-o649Rw-1; Mon, 10 Aug 2020 15:29:43 -0400
X-MC-Unique: KsQG-zhgNkmoQQ5-o649Rw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24B951902EA7;
        Mon, 10 Aug 2020 19:29:42 +0000 (UTC)
Received: from mail (ovpn-114-184.rdu2.redhat.com [10.10.114.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDF6B6111F;
        Mon, 10 Aug 2020 19:29:41 +0000 (UTC)
Date:   Mon, 10 Aug 2020 15:29:41 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+96cc7aba7e969b1d305c@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: INFO: task hung in pipe_read (2)
Message-ID: <20200810192941.GA16925@redhat.com>
References: <00000000000045b3fe05abcced2f@google.com>
 <fc097a54-0384-9d21-323f-c3ca52cdb956@I-love.SAKURA.ne.jp>
 <CAHk-=wj15SDiHjP2wPiC=Ru-RrUjOuT4AoULj6N_9pVvSXaWiw@mail.gmail.com>
 <20200807053148.GA10409@redhat.com>
 <e673cccb-1b67-802a-84e3-6aeea4513a09@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e673cccb-1b67-802a-84e3-6aeea4513a09@i-love.sakura.ne.jp>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Tetsuo,

On Sat, Aug 08, 2020 at 10:01:21AM +0900, Tetsuo Handa wrote:
> use of killable waits disables ability to detect possibility of deadlock (because
> lockdep can't check possibility of deadlock which involves actions in userspace), for
> syzkaller process is SIGKILLed after 5 seconds while khungtaskd's timeout is 140 seconds.
> 
> If we encounter a deadlock in an unattended operation (e.g. some server process),
> we don't have a method for resolving the deadlock. Therefore, I consider that
> t->state == TASK_UNINTERRUPTIBLE check is a bad choice. Unless a sleep is neutral
> (e.g. no lock is held, or obviously safe to sleep with that specific lock held),
> sleeping for 140 seconds inside the kernel is a bad sign even if interruptible/killable.

Task in killable state for seconds as result of another task taking
too long to do something in kernel sounds bad, if the other task had a
legitimate reason to take a long time in normal operations, i.e. like
if the other task was just doing an getdents of a large directory.

Nobody force any app to use userfaultfd, if an app uses it and the
other side of the pipe trusts to read from it, and it gets stuck for
seconds in uninterruptible and killable state, it's either an app bug
resolvable with kill -9. We also can't enforce all signals to run in
presence of other bugs, for example if the task that won't respond to
any signal other than CONT and KILL was blocked in stopped state by a
buggy SIGSTOP. The pipe also can get stuck if the network is down and
it's swapping in from NFS and nobody is forced to take the risk of
using network attached storage as swap device either.

The hangcheck is currently correct to report a concern, because the
other side of the pipe may be another process of another user that
cannot SIGKILL the task blocked in the userfault. That sounds far
fetched and it's not particular concerning anyway, but it's not
technically impossible so I agree with the hangcheck timer reporting
an issue that needs correction.

However once the mutex is killable there's no concern anymore and the
hangcheck timer is correct also not reporting any misbehavior anymore.

Instead of userfaultfd, you can think at 100% kernel faults backed by
swapin from NFS or swaping from attached network storage or swapin
from scsi with a scsi fibre channel accidentally pulled out of a few
seconds. It's nice if uffd can survive as well as nfs or scsi would by
retrying and waiting more than 1sec.

> Can we do something like this?
> 
>   bool retried = false;
> retry:
>   lock();
>   disable_fault();
>   ret = access_memory_that_might_fault();
>   enable_fault();
>   if (ret == -EWOULDFAULT && !retried)
>     goto retry_without_lock;
>   if (ret == 0)
>     ret = do_something();
>   unlock();
>   return ret;
> retry_without_lock:
>   unlock();
>   ret = access_memory_that_might_fault();
>   retried = true;
>   goto retry;

This would work, but it'll make the kernel more complex than using a
killable mutex.

It'd also give a worse runtime than the killable mutex, if the only
source of blocking events while holding the mutex wouldn't be the page
fault.

With just 2 processes in this case probably it would be fine and there
are likely won't be other sources of contention, so the main cons is
just the code complexity to be maintained and the fact it won't
provide any measurable practical benefit, if something it'll run
slower by having to repeat the same fault in blocking and non blocking
mode.

With regard to the reporting of the hangcheck timer most modern paging
code uses killable mutex because unlike the pipe code, there can be
other sources of blockage and you don't want to wait for shared
resources to unblock a process that is waiting on a mutex. I think
trying to reduce the usage of killable mutex overall is a ship that
has sailed, it won't move the needle to just avoid it in pipe code
since it'll remain everywhere else.

So I'm certainly not against your proposal, but if we increase the
complexity like above then I'd find it more attractive if it was for
some other benefit unrelated to userfaultfd, or swapin from NFS or
network attached storage for that matter, and I don't see a big enough
benefit to justify it.

Thanks!
Andrea

PS. I'll be busy until Wed sorry if I don't answer promptly to
    followups. If somebody could give a try to add the killable mutex
    bailout failure paths that return to userland direct, or your more
    complex alternative it'd be great.

