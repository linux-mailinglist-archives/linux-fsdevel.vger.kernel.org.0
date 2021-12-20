Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF7247B51B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 22:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhLTVY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 16:24:56 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33218 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231239AbhLTVYw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:24:52 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BKLOQng007278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Dec 2021 16:24:27 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 69CAE15C33A4; Mon, 20 Dec 2021 16:24:26 -0500 (EST)
Date:   Mon, 20 Dec 2021 16:24:26 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+9c3fb12e9128b6e1d7eb@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] INFO: task hung in jbd2_journal_commit_transaction (3)
Message-ID: <YcD0itBAoOPNNKvX@mit.edu>
References: <00000000000032992d05d370f75f@google.com>
 <20211219023540.1638-1-hdanton@sina.com>
 <Yb6zKVoxuD3lQMA/@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yb6zKVoxuD3lQMA/@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 19, 2021 at 04:20:57AM +0000, Matthew Wilcox wrote:
> > Hey Willy
> > >
> > >sched_setattr(0x0, &(0x7f0000000080)={0x38, 0x1, 0x0, 0x0, 0x1}, 0x0)
> > >
> > >so you've set a SCHED_FIFO priority and then are surprised that some
> > >tasks are getting starved?
> > 
> > Can you speficy a bit more on how fifo could block journald waiting for
> > IO completion more than 120 seconds?
> 
> Sure!  You can see from the trace below that jbd2/sda1-8 is in D state,
> so we know nobody's called unlock_buffer() yet, which would have woken
> it.  That would happen in journal_end_buffer_io_sync(), which is
> the b_end_io for the buffer.
> 
> Learning more detail than that would require knowing the I/O path
> for this particular test system.  I suspect that the I/O was submitted
> and has even completed, but there's a kernel thread waiting to run which
> will call the ->b_end_io that hasn't been scheduled yet, because it's
> at a lower priority than all the threads which are running at
> SCHED_FIFO.
> 
> I'm disinclined to look at this report much further because syzbot is
> stumbling around trying things which are definitely in the category of
> "if you do this and things break, you get to keep both pieces".  You
> can learn some interesting things by playing with the various RT
> scheduling classes, but mostly what you can learn is that you need to
> choose your priorities carefully to have a functioning system.

In general, real-time threads (anything scheduled with SCHED_FIFO or
SCHED_RT) should never, *ever* try to do any kind of I/O.  After all,
I/O can block, and if a real-time thread blocks, so much for any kind
of real-time guarantee that you might have.

If you must use do I/O from soft real-time thread, one trick you *can*
do is to some number of CPU's which are reserved for real-time
threads, and a subset of threads which are reserved for non-real-time
threads, enforced using CPU pinning.  It's still not prefect, since
there are still priority inheritance issues, and while this protects
against a non-real-time thread holding some lock which is needed by a
real-time (SCHED_FIFO) thread, if there are two SCHED_FIFO running at
different priorities it's still possible to deadlock the entire
kernel.

Can it be done?  Sure; I was part of an effort to make it work for the
US Navy's DDG-1000 Zumwalt-class destroyer[1].  But it's tricky, and
it's why IBM got paid the big bucks. :-)  Certainly it's going to be
problematic for syzkaller if it's just going to be randomly trying to
set some threads to be real-time without doing any kind of formal
planning.

[1] https://dl.acm.org/doi/10.1147/sj.472.0207

Cheers,

						- Ted
