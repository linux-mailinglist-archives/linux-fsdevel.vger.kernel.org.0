Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408D547C93A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 23:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbhLUWcn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 17:32:43 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59678 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230085AbhLUWcm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:32:42 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BLMWI6o015985
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 17:32:18 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 188E815C33A4; Tue, 21 Dec 2021 17:32:18 -0500 (EST)
Date:   Tue, 21 Dec 2021 17:32:18 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+9c3fb12e9128b6e1d7eb@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] INFO: task hung in jbd2_journal_commit_transaction (3)
Message-ID: <YcJV8p/1XRGOQurz@mit.edu>
References: <00000000000032992d05d370f75f@google.com>
 <20211219023540.1638-1-hdanton@sina.com>
 <Yb6zKVoxuD3lQMA/@casper.infradead.org>
 <20211221090804.1810-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221090804.1810-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 05:08:04PM +0800, Hillf Danton wrote:
> 
> I am trying to find the cause of same jbd2 journal thread blocked for
> more than 120 seconds on a customer's system of linux-4.18 with RT
> turned on and 12 CPUs in total bootup.

So here's the tricky bit with trying to use ext4 (or any file system,
really; the details will be different but the fundamental issues will
remain the same).  When a thread either calls fsync(2) or tries to
initiate a flie system mutation by creating a jbd2 handle and there
isn't enough space, the process will wake up the jbd2 thread and block
until a new transaction has been started.

In the jbd2 thread, the first thing it does is wait for all currently
open handles to close, since it can only commit the current
transaction when all handles attached to the current transaction have
been closed.  If some non-real-time process happens to have an open
handle, but it can't make forward progress for some reason, then this
will prevent the commit from completing, and this in turn will cause
any other process which needs to make changes to the file system from
making forward progress, since they will be blocked by jbd2 commit
thread, which in turn is blocked waiting low-priority process to make
forward progress --- and if that process is blocked behind some high
priority process, then that's the classic definition of "priority
inversion".

> Without both access to it and
> clue of what RT apps running in the system, what I proposed is to
> launch one more FIFO task of priority MAX_RT_PRIO-1 in the system like
> 
> 	for (;;) {
> 		unsigned long i;
> 
> 		for (;;) /* spin for 150 seconds */
> 			i++;
> 		sleep a second;
> 	}
> 
> in bid to observe the changes in behavior of underlying hardware using
> the diff below.

I'm not sure what you hope to learn by doing something like that.
That will certainly perturb the system, but every 150 seconds, the
task is going to let other tasks/threads run --- but it will be
whatever is the next highest priority thread. 

What you want to do is to figure out which thread is still holding a
handle open, and why it can't run --- is it because there are
sufficient higher priority threads that are running that it can't get
a time slice to run, so it can complete its file system operation and
release its handle?  Is it blocked behind a memory allocation (perhaps
because it is in a memory-constrained cgroup)?  Is it blocked waiting
on some mutex perhaps because it's doing something crazy like
sendfile()?  Or some kind of I/O Uring system call?  Etc, Etc., Etc.

What would probably make sense is to use "ps -eLcl" before the system
hangs so you can see what processes and threads are running with which
real-time or non-real-time priorities.  Or if the system has hung,
uses the magic sysrq key to find out what threads are running on each
CPU, and grab a stack trace from all of the running processes so you
can figure out where some task might be blocked, and figure out which
task might be blocked inside a codepath where it would be holding a
handle.

If that level of access means you have to get a government security
clearance, or get permission from a finance company's vice president
for that kind of access --- get that clearance ahead of time, even if
it takes months and involves background investigations and polygraph
tests.  Because you *will* need that kind of access to debug these
sorts of real-time locking issues.  There is an extremely high (99.9%)
probability that the bug is in the system configuration or application
logic, so you will need full source code access to the workload to
understand what might have gone wrong.  It's almost never a kernel
bug, but rather a fundamental application design or system
configuration problem.

> Is it a well-designed system in general if it would take more than
> three seconds for the IO to complete with hardware glitch ruled out?

Well, it depends on your definition of "well-designed" and "the I/O",
doesn't it?  If you are using a cost-optimized cheap-sh*t flash device
from Shenzhen, it can minutes for I/O to complete.  Just try copying
DVD's worth of data using buffered writes to said slow USB device, and
run "sync" or "umount /mnt", and watch the process hang for a long,
long time.

Or if you are using a cloud environment, and you are using virtual
block device which is provisioned for a small number of IOPS, whose
fault is it?  The cloud system, for throttling I/O the IOPS that was
provisioned for the device?  The person who created the VM, for not
appropriately provisioning enough IOPS?  Or the application
programmer?  Or the kernel programmer?  (And if you've ever worked at
a Linux distro or a cloud provider, you can be sure that at least one
platinum customer will try to blame the kernel programmer.  :-)

Or if you are using a storage area network, and you have a real time
process which is logging to a file, and battle damage takes out part
of the storage area network, and now the real-time process (which
might be responsible for ship navigation or missle defense) hangs
because file write is hanging, is that a "well-designed system"?  This
is why you never, never, *NEVER* write to a file from a mission or
life-critical real-time thread.  Instead you log to a ring buffer
which is shared by non-real-time process, and that non-realtime
process will save the log information to a file.  And if the
non-real-time process can't keep up with writing the log, which is
worse?  Missing log information?  Or a laggy or deadlocked missile
defense system?

The bottom line is especially if you are trying to use real-time
threads, the entire system configuration, including choice of
hardware, as well as the overall system architecture, all needs to be
part of a holistic design.  You can't just be "the OS person" but
instead you need to be part of the overall system architecture team.

Cheers,

						- Ted
