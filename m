Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749D843C323
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 08:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239967AbhJ0Gou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 02:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhJ0Got (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 02:44:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBAEC061570
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Oct 2021 23:42:24 -0700 (PDT)
Date:   Wed, 27 Oct 2021 08:42:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635316942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5UMH8mrH+wG1Xu18KQSyfaYnndhtorvlL8kFMwF1nBs=;
        b=0Gr6iATjfU2zpCSJdLQKlmIMR79b+0M21GCJVDos3s11DFD6ljtGcOTLwnHpZw5N6sy1UB
        dhf1JJ1tFWW23R0aZEDHx2kU3cRp+DUjUl2/o+AK+Z1pIMsli5cp9zvDw38iFN3j1dcHmq
        7T9fDZvGCPJYloI+0GtTL1EL9wpMvMl3kID0O81s2JofGegmW9kDSonY0Vip5DgF1iHDsV
        y21Sn4esWi6QDQrd50vt8j2ei/+OHrc6wFcg4J8OcB2yScxr8gWLk3S/YnqTNL4Mmq3KLq
        TgRu5FiLyLqBYifLgmGLMVaCu+VjqB3AGWkcNNoTdOu+INUC8O9XfGBlFq5OXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635316942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5UMH8mrH+wG1Xu18KQSyfaYnndhtorvlL8kFMwF1nBs=;
        b=aOSzYwcQd3RQ5VfAdQb1kXrOHQ4xo7DQrQ1wb95BfitKawmQVE3voX4p4lObeeJ2W59Thk
        f2TycjkazQmE0WDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] fs/namespace: Boost the mount_lock.lock owner instead of
 spinning on PREEMPT_RT.
Message-ID: <20211027064220.sat5rawz3fsa7yq5@linutronix.de>
References: <20211021220102.bm5bvldjtzsabbfn@linutronix.de>
 <20211025091504.6k7d57awbfpqmmqs@wittgenstein>
 <20211025152218.opvcqfku2lhqvp4o@linutronix.de>
 <20211026210621.yeg56reluq2cqrqs@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211026210621.yeg56reluq2cqrqs@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-10-26 23:06:21 [+0200], Christian Brauner wrote:
> I'm not an expert in real-time locking but this solution is way less
> intrusive and easier to explain and understand than the first version.
> Based on how I understand priority inheritance this solution seems good.
> 
> The scenario that we seem to mostly worry is:
> Let's assume a low-priority task A is holding lock_mount_hash() and
> writes MNT_WRITE_HOLD to mnt->mnt_flags. Another high-priority task B is
> spinning waiting for MNT_WRITE_HOLD to be cleared.
> On rt kernels task A could be scheduled away causing the high-priority
> task B to spin for a long time. However, if we force the high-priority

s/for a long time/indefinitely

> task B to grab lock_mount_hash() we thereby priority boost low-priorty
> task A causing it to relinquish the lock quickly preventing task B from
> spinning for a long time.

Yes. Task B goes idle, Task A continues with B's priority until 
unlock_mount_hash(). After unlock A gets its old priority back and B
continues.

Side note: Because task A is holding a spinlock_t (lock_mount_hash()) it
can't be moved to another CPU (other reasons). Therefore if task B is on
the same CPU as A with higher priority then the scheduler can't move A
away and won't move B either because it is running. So the system locks
up.

> Under the assumption I got this right:
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks.

> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -343,8 +343,24 @@ int __mnt_want_write(struct vfsmount *m)
> >  	 * incremented count after it has set MNT_WRITE_HOLD.
> >  	 */
> >  	smp_mb();
> > -	while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD)
> > -		cpu_relax();
> > +	might_lock(&mount_lock.lock);
> > +	while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD) {
> > +		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > +			cpu_relax();
> 
> IS_ENABLED will have the same effect as using ifdef, i.e. compiling the
> irrelevant branch out, I hope.

Yes. It turns into if (0) or if (1) leading to an elimination of one of
the branches.

Sebastian
