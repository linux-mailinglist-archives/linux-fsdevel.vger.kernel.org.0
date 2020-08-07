Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858F823E70C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 07:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgHGFb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 01:31:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45478 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725379AbgHGFb7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 01:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596778316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qE3AQC88ybbZXSV6i1eK7/q3sJlMno8WZMq0jGptd7M=;
        b=GcoJo3tNz4B4vHyB67d6bQBYZ0SlEccJZOsBZ7T/i9htNInl+BU7imKbpMOGV+vkYu8FMt
        z+mKW2OVNzeN0ypq+ikWlEZ9rvLsyojhBiEYrGfIGHihUw+6qenu2eTB5FZdNJKHYMiPLC
        PS7klYM9JFseG9UNHLt4630IjaW1cqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-7cMgRDB0MRCH973SukvGog-1; Fri, 07 Aug 2020 01:31:51 -0400
X-MC-Unique: 7cMgRDB0MRCH973SukvGog-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94FB457;
        Fri,  7 Aug 2020 05:31:49 +0000 (UTC)
Received: from mail (ovpn-114-184.rdu2.redhat.com [10.10.114.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 191E75DA7A;
        Fri,  7 Aug 2020 05:31:49 +0000 (UTC)
Date:   Fri, 7 Aug 2020 01:31:48 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+96cc7aba7e969b1d305c@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: INFO: task hung in pipe_read (2)
Message-ID: <20200807053148.GA10409@redhat.com>
References: <00000000000045b3fe05abcced2f@google.com>
 <fc097a54-0384-9d21-323f-c3ca52cdb956@I-love.SAKURA.ne.jp>
 <CAHk-=wj15SDiHjP2wPiC=Ru-RrUjOuT4AoULj6N_9pVvSXaWiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj15SDiHjP2wPiC=Ru-RrUjOuT4AoULj6N_9pVvSXaWiw@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Sat, Aug 01, 2020 at 10:39:00AM -0700, Linus Torvalds wrote:
> On Sat, Aug 1, 2020 at 8:30 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > Waiting for response at https://lkml.kernel.org/r/45a9b2c8-d0b7-8f00-5b30-0cfe3e028b28@I-love.SAKURA.ne.jp .
> 
> I think handle_userfault() should have a (shortish) timeout, and just
> return VM_FAULT_RETRY.

The 1sec timeout if applied only to kernel faults (not the case yet
but it'd be enough to solve the hangcheck timer), will work perfectly
for Android, but it will break qemu.

[  916.954313] INFO: task syz-executor.0:61593 blocked for more than 40 seconds.

If you want to enforce a timeout, 40 seconds or something of the order
of the hangcheck timer would be more reasonable.

1sec is of the same order of magnitude of latency that you'd get with
an host kernel upgrade in place with kexec (with the guest memory
being preserved in RAM) that you'd suffer occasionally from in most public clouds.

So postcopy live migration should be allowed to take 1 sec latency and
it shouldn't become a deal breaker, that results in the VM getting killed.

> The code is overly complex anyway, because it predates the "just return RETRY".
> 
> And because we can't wait forever when the source of the fault is a
> kernel exception, I think we should add some extra logic to just say
> "if this is a retry, we've already done this once, just return an
> error".

Until the uffp-wp was merged recently, we never needed more than one
VM_FAULT_RETRY to handle uffd-missing faults, you seem to want to go
back to that which again would be fine for uffd-missing faults.

I haven't had time to read and test the testcase properly yet, but at
first glance from reading the hangcheck report it looks like there
would be just one userfault? So I don't see an immediate connection.

The change adding a 1sec timeout would definitely fix this issue, but
it'll also break qemu and probably the vast majority of the users.

> This is a TEST PATCH ONLY. I think we'll actually have to do something
> like this, but I think the final version might need to allow a couple
> of retries, rather than just give up after just one second.
> 
> But for testing your case, this patch might be enough to at least show
> that "yeah, this kind of approach works".
> 
> Andrea? Comments? As mentioned, this is probably much too aggressive,
> but I do think we need to limit the time that the kernel will wait for
> page faults.

Why is pipe preventing to SIGKILL the task that is blocked on the
mutex_lock? Is there any good reason for it or it simply has margin
for improvement regardless of the hangcheck report? It'd be great if
we can look into that before looking into the uffd specific bits.

The hangcheck timer would have zero issues with tasks that can be
killed, if only the pipe code could be improved to use mutex_lock_killable.

		/* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
		if (t->state == TASK_UNINTERRUPTIBLE)
			check_hung_task(t, timeout);

The hangcheck report is just telling us one task was in D state a
little too long, but it wasn't fatal error and the kernel wasn't
actually destabilized and the only malfunction reported is that a task
was unkillable for too long.

Now if it's impossible to improve the pipe code so it works better not
just for uffd, there's still no reason to worry: we could disable uffd
in the pipe context. For example ptrace opts-out of uffds, so that gdb
doesn't get stuck if you read a pointer that should be handled by the
process that is under debug. I hope it won't be necessary but it
wouldn't be a major issue, certainly it wouldn't risk breaking qemu
(and non-cooperative APIs are privileged so it could still skip the
timeout).

> Because userfaultfd has become a huge source of security holes as a
> way to time kernel faults or delay them indefinitely.

I assume you refer to the below:

https://duasynt.com/blog/cve-2016-6187-heap-off-by-one-exploit
https://blog.lizzie.io/using-userfaultfd.html

These reports don't happen to mention CONFIG_SLAB_FREELIST_RANDOM=y
which is already enabled by default in enterprise kernels for a reason
and they don't mention the more recent CONFIG_SLAB_FREELIST_HARDENED
and CONFIG_SHUFFLE_PAGE_ALLOCATOR.

Can they test it with those options enabled again, does it still work
so good or not anymore? That would be very helpful to know.

Randomizing which is the next page that gets allocated is much more
important than worrying about uffd because if you removed uffd you may
still have other ways to temporarily stop the page fault depending on
the setup. Example:

https://bugs.chromium.org/p/project-zero/issues/detail?id=808

The above one doesn't use uffd, but it uses fuse. So is fuse also a
source of security holes given they even use it for the exploit in a
preferential way instead of uffd?

"This can be done by abusing the writev() syscall and FUSE: The
attacker mounts a FUSE filesystem that artificially delays read
accesses, then mmap()s a file containing a struct iovec from that FUSE
filesystem and passes the result of mmap() to writev(). (Another way
to do this would be to use the userfaultfd() syscall.)"

It's not just uffd and fuse: even if you set
/proc/sys/vm/unprivileged_userfaultfd to 0 and you drop fuse, swapin
and pagein from NFS can be attacked through the network. The fact
there's a timeout won't make those less useful.

Enlarging the race window to 1sec or 40sec won't help much. What would
be useful if something is to add a delay to the wakeup event, not to
add a timeout, but even if we do that, the bug may still be
reproducible and it may eventually win the race regardless, by just
waiting longer.

It's impossible to obtain maximum features, maximum security and
maximum performance all at the same time, something has to give in and
we clearly want to support the enhanced-robustness secure setup where
all other unprivileged_* sysctl are tweaked too (not just uffd), and
we already do with the sysctl we added for it. In this respect uffd is
not different from other features that also shouldn't be accessible
without privilege in those setup. It's part of the tradeoff.

Most important the default container runtime seccomp filters blocks
uffd so all containers are at zero risk unless they use uffd actively
and opt-in explicitly using the OCI schema seccomp filter, in which
case the previous sentence applies.

Anybody running a secure setup but not wrapping everything under at
least the default seccomp filter of the container runtime, is not
really secure anyway so even the sysctl is meaningless in reality. Way
more useful than the sysctl in practice is that container runtime
needs an hard denylist/allowlist that cannot be opted out of the OCI
schema and in paranoid setups some syscalls could be added to it,
despite it may break stuff.

Randomizing the allocations so the timing don't matter anymore is most
certainly worth it because it will work not just for uffd, but also
for fuse, swapin from nfs under malicious network flood and any other
source of page fault controllable stalls.

The last complaint received on the uffd security topic was the
suggestion that uffd being allowed to block kernel faults was a
concern for lockdown confidentiality mode. I answered to that here and
I repeated some part in the above as well:

https://lkml.kernel.org/r/20200520040608.GB26186@redhat.com

(if no time to read the above: the short version is that lockdown
confidentiality is not a robustness/probabilistic feature. It's a
black and white feature and such it shouldn't even try to be robust
against kernel bugs by design. If we turn confidentiality mode in an
"hardening" kernel feature, then the sky is the limit and it'll become
a growing black hole that will drop more and more and it won't be
possible to draw a sure line where to stop dropping, until what's left
will be too little or too slow to be useful)

Thanks,
Andrea

(On the seccomp topic, and this would open a new huge thread,
absolutely we need to change the default of spec_store_bypass_disable
and spectre_v2_user to prctl, we can't keep it to seccomp, most
userland including the container runtimes already opted-out with
SECCOMP_FILTER_FLAG_SPEC_ALLOW, the longer we wait the more it'll be
pointless to even leave a =seccomp option as opt-in later, I'll try to
work on submitting something soon to fix this)

