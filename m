Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2BF47CC2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Dec 2021 05:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbhLVEf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 23:35:58 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36401 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232166AbhLVEf6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 23:35:58 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BM4ZfWb010504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 23:35:42 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 70D0A15C33AD; Tue, 21 Dec 2021 23:35:41 -0500 (EST)
Date:   Tue, 21 Dec 2021 23:35:41 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+9c3fb12e9128b6e1d7eb@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] INFO: task hung in jbd2_journal_commit_transaction (3)
Message-ID: <YcKrHc11B/2tcfRS@mit.edu>
References: <00000000000032992d05d370f75f@google.com>
 <20211219023540.1638-1-hdanton@sina.com>
 <Yb6zKVoxuD3lQMA/@casper.infradead.org>
 <20211221090804.1810-1-hdanton@sina.com>
 <20211222022527.1880-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222022527.1880-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:25:27AM +0800, Hillf Danton wrote:
> > I'm not sure what you hope to learn by doing something like that.
> > That will certainly perturb the system, but every 150 seconds, the
> > task is going to let other tasks/threads run --- but it will be
> > whatever is the next highest priority thread. 
> 
> Without reproducer, I am trying to reproduce the issue using a FIFO CPU hog
> which is supposed to beat the watchdog to show me the victims like various
> kthreads, workqueue workers and user apps, despite I know zero about how the
> watchdog is configured except the report was down to watchdog bite.

It's really trivial to reproduce an issue that has the same symptom as
what has been reported to you.  Mount the file system using a
non-real-time (SCHED_OTHER) thread, such that the jbd2 and ext4 worker
threads are running SCHED_OTHER.  Then run some file system workload
(fsstress or fsmark) as SCHED_FIFO.  Then on an N CPU system, run N
processes as SCHED_FIFO at any priority (doesn't matter whether it's
MAX_PRI-1 or MIN_PRI; SCHED_FIFO will have priority over SCHED_OTHER
processes, so this will effectively starve the ext4 and jbd2 worker
threads from ever getting to run.  Once the ext4 journal fills up, any
SCHED_FIFO process which tries to write to the file system will hang.

The problem is that's *one* potential stupid configuration of the
real-time system.  It's not necessarily the *only* potentially stupid
way that you can get yourself into a system hang.  It appears the
syzkaller "repro" is another such "stupid way".  And the number of
ways you can screw up with a real-time system is practically
unbounded...

So getting back to syzkaller, Willy had the right approach, which is a
Syzcaller "repro" happens to use SCHED_FIFO or SCHED_RR, and the
symptom is a system hang, it's probably worth ignoring the report,
since it's going to be a waste of time to debug userspace bug.  If you
have anything that uses kernel threads, and SCHED_FIFO or SCHED_RR is
in play, it's probably a userspace bug.

Cheers,

					- Ted
