Return-Path: <linux-fsdevel+bounces-46231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A963FA84E21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 22:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F551B63CBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 20:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931D128F945;
	Thu, 10 Apr 2025 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuos2pOD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8841E572F;
	Thu, 10 Apr 2025 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744316668; cv=none; b=e/OwjxZO8Vi8XDV5szv36OFhww/JROD/AZocFtFNnIAVFJza/N4xTURfqZ8K6yH/SgdjAYCyRlSpFEWdeFz0w59eJI7WsNL31046cOx9HME93tct8aXX2OohheBACy2o0tmxVsfGH3dNortAiYm+g+183W6x0PU0C+qOk2fgrB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744316668; c=relaxed/simple;
	bh=1mDwEovVKKM/u+OaIa4/q+5QqidtchBzXzC3jBMYQ7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaVwMb4ASItcSGr0GzGwhp0edEjjF7PmONn8nxhssP3zgyH7ioi06ElYr/GcPK3ZFWW8dsFW6fFjVZOeXL7AvXtjpsbHFfL4hj63BHah5x2dppT6aMEksBPgfMDwCyo6H/QWIR7f/G7/8GLNTXaxDTV0M5sNYxRjoxE/CThcqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuos2pOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38241C4CEDD;
	Thu, 10 Apr 2025 20:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744316667;
	bh=1mDwEovVKKM/u+OaIa4/q+5QqidtchBzXzC3jBMYQ7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tuos2pODt7ndB3uGIKBBn07blkZnFjh+IUQ72tojoXJjOnpXHP2zmgjC/YEjXUKZd
	 hbE3DDjxZIIStACWoXY6hemrp3KOyyN3jlRY7CAseLHp5beebvhJmPffj0XARuuxdG
	 DUCc/Hencz/LavS3KabLFXhhXOaNtwRoDDspvsGnhuUqNapN6+/3l40gZ8xz1o48kb
	 Hz/BKCIhW8i09QoWMyf+rwJwg9qBkJEN1oYLN6S5cbRt8xiwQu7YzzFcMhDvOQGwM0
	 8aKbRnzYmgJrr8hfgiArjIxc+YSafaUq9QBULTdBw+0xPrfmOruDawnhNqRg/epxGY
	 xXyaOoUxPLwMQ==
Date: Thu, 10 Apr 2025 22:24:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org, 
	Peter Ziljstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] pidfs: ensure consistent ENOENT/ESRCH reporting
Message-ID: <20250410-akademie-skaten-75bd4686ad6b@brauner>
References: <20250409-sesshaft-absurd-35d97607142c@brauner>
 <20250409-rohstoff-ungnade-d1afa571f32c@brauner>
 <20250409184040.GF32748@redhat.com>
 <20250410101801.GA15280@redhat.com>
 <20250410-barhocker-weinhandel-8ed2f619899b@brauner>
 <20250410131008.GB15280@redhat.com>
 <20250410-inklusive-kehren-e817ba060a34@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410-inklusive-kehren-e817ba060a34@brauner>

On Thu, Apr 10, 2025 at 10:05:58PM +0200, Christian Brauner wrote:
> On Thu, Apr 10, 2025 at 03:10:09PM +0200, Oleg Nesterov wrote:
> > On 04/10, Christian Brauner wrote:
> > >
> > > On Thu, Apr 10, 2025 at 12:18:01PM +0200, Oleg Nesterov wrote:
> > > > On 04/09, Oleg Nesterov wrote:
> > > > >
> > > > > On 04/09, Christian Brauner wrote:
> > > > > >
> > > > > > The seqcounter might be
> > > > > > useful independent of pidfs.
> > > > >
> > > > > Are you sure? ;) to me the new pid->pid_seq needs more justification...
> > >
> > > Yeah, pretty much. I'd make use of this in other cases where we need to
> > > detect concurrent changes to struct pid without having to take any
> > > locks. Multi-threaded exec in de_exec() comes to mind as well.
> > 
> > Perhaps you are right, but so far I am still not sure it makes sense.
> > And we can always add it later if we have another (more convincing)
> > use-case.
> > 
> > > > To remind, detach_pid(pid, PIDTYPE_PID) does wake_up_all(&pid->wait_pidfd) and
> > > > takes pid->wait_pidfd->lock.
> > > >
> > > > So if pid_has_task(PIDTYPE_PID) succeeds, __unhash_process() -> detach_pid(TGID)
> > > > is not possible until we drop pid->wait_pidfd->lock.
> > > >
> > > > If detach_pid(PIDTYPE_PID) was already called and have passed wake_up_all(),
> > > > pid_has_task(PIDTYPE_PID) can't succeed.
> > >
> > > I know. I was trying to avoid having to take the lock and just make this
> > > lockless. But if you think we should use this lock here instead I'm
> > > willing to do this. I just find the sequence counter more elegant than
> > > the spin_lock_irq().
> > 
> > This is subjective, and quite possibly I am wrong. But yes, I'd prefer
> > to (ab)use pid->wait_pidfd->lock in pidfd_prepare() for now and not
> > penalize __unhash_process(). Simply because this is simpler.

Looking close at this. Why is:

        if (type == PIDTYPE_PID) {
                WARN_ON_ONCE(pid_has_task(pid, PIDTYPE_PID));
                wake_up_all(&pid->wait_pidfd);
        }

located in __change_pid()? The only valid call to __change_pid() with a NULL
argument and PIDTYPE_PID is from __unhash_process(), no?

So why isn't this in __unhash_process() where it's immediately obvious
that it's the only valid place this can currently be called from?

diff --git a/kernel/exit.c b/kernel/exit.c
index 1b51dc099f1e..d92e8bee0ab7 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -135,6 +135,7 @@ static void __unhash_process(struct release_task_post *post, struct task_struct
 {
        nr_threads--;
        detach_pid(post->pids, p, PIDTYPE_PID);
+       wake_up_all(&post->pids[PIDTYPE_PID]->wait_pidfd);
        if (group_dead) {
                detach_pid(post->pids, p, PIDTYPE_TGID);
                detach_pid(post->pids, p, PIDTYPE_PGID);
diff --git a/kernel/pid.c b/kernel/pid.c
index 4ac2ce46817f..26f1e136f017 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -359,11 +359,6 @@ static void __change_pid(struct pid **pids, struct task_struct *task,
        hlist_del_rcu(&task->pid_links[type]);
        *pid_ptr = new;

-       if (type == PIDTYPE_PID) {
-               WARN_ON_ONCE(pid_has_task(pid, PIDTYPE_PID));
-               wake_up_all(&pid->wait_pidfd);
-       }
-
        for (tmp = PIDTYPE_MAX; --tmp >= 0; )
                if (pid_has_task(pid, tmp))
                        return;

I'm probably missing something obvious.

