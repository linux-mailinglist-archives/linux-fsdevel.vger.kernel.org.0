Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E790517D7BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 02:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgCIBY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Mar 2020 21:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgCIBY1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Mar 2020 21:24:27 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D08D2064A;
        Mon,  9 Mar 2020 01:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583717066;
        bh=72wt6abTXdZd2tpt0WJygez8l4q6+2mLPxpP0Bktgfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sY2+Le5tLiyDZnWmMEU3521ZHiJ+JtD4RRWsVmldqyDoY/2DSOYNmxBMMvOCWf1Qj
         9SM2dDoueJkLxaSmrfFd/gv8Z7V1w8NlWeKluCtrMNhcPEKBuBijZd02ktJOV22lwl
         xP1q+dVQRNJvGAEmWcHVA94mvngCpvMPsVu2Y83U=
Date:   Sun, 8 Mar 2020 18:24:24 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs/direct-io.c: avoid workqueue allocation race
Message-ID: <20200309012424.GB371527@sol.localdomain>
References: <CACT4Y+Zt+fjBwJk-TcsccohBgxRNs37Hb4m6ZkZGy7u5P2+aaA@mail.gmail.com>
 <20200308055221.1088089-1-ebiggers@kernel.org>
 <20200308231253.GN10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308231253.GN10776@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 09, 2020 at 10:12:53AM +1100, Dave Chinner wrote:
> On Sat, Mar 07, 2020 at 09:52:21PM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > When a thread loses the workqueue allocation race in
> > sb_init_dio_done_wq(), lockdep reports that the call to
> > destroy_workqueue() can deadlock waiting for work to complete.  This is
> > a false positive since the workqueue is empty.  But we shouldn't simply
> > skip the lockdep check for empty workqueues for everyone.
> 
> Why not? If the wq is empty, it can't deadlock, so this is a problem
> with the workqueue lockdep annotations, not a problem with code that
> is destroying an empty workqueue.

Skipping the lockdep check when flushing an empty workqueue would reduce the
ability of lockdep to detect deadlocks when flushing that workqueue.  I.e., it
could cause lots of false negatives, since there are many cases where workqueues
are *usually* empty when flushed/destroyed but it's still possible that they are
nonempty.

> 
> > Just avoid this issue by using a mutex to serialize the workqueue
> > allocation.  We still keep the preliminary check for ->s_dio_done_wq, so
> > this doesn't affect direct I/O performance.
> > 
> > Also fix the preliminary check for ->s_dio_done_wq to use READ_ONCE(),
> > since it's a data race.  (That part wasn't actually found by syzbot yet,
> > but it could be detected by KCSAN in the future.)
> > 
> > Note: the lockdep false positive could alternatively be fixed by
> > introducing a new function like "destroy_unused_workqueue()" to the
> > workqueue API as previously suggested.  But I think it makes sense to
> > avoid the double allocation anyway.
> 
> Fix the infrastructure, don't work around it be placing constraints
> on how the callers can use the infrastructure to work around
> problems internal to the infrastructure.

Well, it's also preferable not to make our debugging tools less effective to
support people doing weird things that they shouldn't really be doing anyway.

(BTW, we need READ_ONCE() on ->sb_init_dio_done_wq anyway to properly annotate
the data race.  That could be split into a separate patch though.)

Another idea that came up is to make each workqueue_struct track whether work
has been queued on it or not yet, and make flush_workqueue() skip the lockdep
check if the workqueue has always been empty.  (That could still cause lockdep
false negatives, but not as many as if we checked if the workqueue is
*currently* empty.)  Would you prefer that solution?  Adding more overhead to
workqueues would be undesirable though, so I think it would have to be
conditional on CONFIG_LOCKDEP, like (untested):

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 301db4406bc37..72222c09bcaeb 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -263,6 +263,7 @@ struct workqueue_struct {
 	char			*lock_name;
 	struct lock_class_key	key;
 	struct lockdep_map	lockdep_map;
+	bool			used;
 #endif
 	char			name[WQ_NAME_LEN]; /* I: workqueue name */
 
@@ -1404,6 +1405,9 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	lockdep_assert_irqs_disabled();
 
 	debug_work_activate(work);
+#ifdef CONFIG_LOCKDEP
+	WRITE_ONCE(wq->used, true);
+#endif
 
 	/* if draining, only works from the same workqueue are allowed */
 	if (unlikely(wq->flags & __WQ_DRAINING) &&
@@ -2772,8 +2776,12 @@ void flush_workqueue(struct workqueue_struct *wq)
 	if (WARN_ON(!wq_online))
 		return;
 
-	lock_map_acquire(&wq->lockdep_map);
-	lock_map_release(&wq->lockdep_map);
+#ifdef CONFIG_LOCKDEP
+	if (READ_ONCE(wq->used)) {
+		lock_map_acquire(&wq->lockdep_map);
+		lock_map_release(&wq->lockdep_map);
+	}
+#endif
 
 	mutex_lock(&wq->mutex);
