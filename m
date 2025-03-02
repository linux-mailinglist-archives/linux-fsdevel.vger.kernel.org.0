Return-Path: <linux-fsdevel+bounces-42909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC7CA4B438
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 19:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3698416D1E9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 18:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4236D1EC01C;
	Sun,  2 Mar 2025 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3yn3n4h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC81EC017
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Mar 2025 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740941814; cv=none; b=AULsO1C2Pk0QYZO8UXQlZOveIKC5h3VdFNC+zDaftM4x0RZNk3VHSU1YeiVZ0qfcroyczKWTvhHPuRoCNRMJ8jVOHiir+RfCYCJyltVcnbncrOD9RkYO09z0Tuc0fkXc8fbZ/T4M1Y3P9pefN5VhyFyh/fG4PB5Im/jiwHjHzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740941814; c=relaxed/simple;
	bh=ApQkSukf00P0Z4XSSTdjE4TUBzaR7xb/kslnuW+5nUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBowb20PHV7OK6MJCfqLtLdbwEHI+Trzhn/9zdTcQUXWnplwnG+JZiCxi5lRm4Aov6DAvy85x2Ocd/HwHBjV/mF3FH4HSoUpYW8uv7K4EOLcI5q6bfABSu4j6Sme5W4cFY5prCNMqb+ADvba121ALj93/eoMBWRnnqqxCvza67U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3yn3n4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F9EC4CEE7;
	Sun,  2 Mar 2025 18:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740941814;
	bh=ApQkSukf00P0Z4XSSTdjE4TUBzaR7xb/kslnuW+5nUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a3yn3n4hqlju7BBYzYyyATtESQ2Gj2yo19swsySB2MbcU5S/VSkkkvaLmoPQuj98m
	 cpqDMhYz4qt+MrW98o622U94wiOwUaLGagtYgaUhe/UxAf/U6Ua98C3sS8C/SO3L+z
	 BWWF1NDhhplLLjSWLboGsEqBnj6nSNkGG7aF4cdPr8ziQw7sEyiqQmsnGN/0mjjyvP
	 2cVlwF6Nw+CzHIrG7EH6uOeoWBK0b+M5hmM3krStfXDTdwPUyAJSRvlvOa97ZA6ed5
	 dmnW3VgtbKZaKij/P53RSv4SSX8NiK/fBaTxOMtXIIIaPaPKFtKHOX5qSmp53Yg++o
	 aiWJD/34237uw==
Date: Sun, 2 Mar 2025 19:56:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH RFC 06/10] pidfs: allow to retrieve exit information
Message-ID: <20250302-eilzug-inkognito-b5c8447a7f34@brauner>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
 <20250228-work-pidfs-kill_on_last_close-v1-6-5bd7e6bb428e@kernel.org>
 <20250302155346.GD2664@redhat.com>
 <20250302-sperling-tagebuch-49c1b4996c5f@brauner>
 <20250302172149.GF2664@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250302172149.GF2664@redhat.com>

On Sun, Mar 02, 2025 at 06:21:49PM +0100, Oleg Nesterov wrote:
> On 03/02, Christian Brauner wrote:
> >
> > On Sun, Mar 02, 2025 at 04:53:46PM +0100, Oleg Nesterov wrote:
> > > On 02/28, Christian Brauner wrote:
> > > >
> > > > Some tools like systemd's jounral need to retrieve the exit and cgroup
> > > > information after a process has already been reaped.
> > >               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >
> > > But unless I am totally confused do_exit() calls pidfd_exit() even
> > > before exit_notify(), the exiting task is not even zombie yet. It
> > > will reaped only when it passes exit_notify() and its parent does
> > > wait().
> >
> > The overall goal is that it's possible to retrieve exit status and
> > cgroupid even if the task has already been reaped.
> 
> OK, please see below...
> 
> > It's intentionally placed before exit_notify(), i.e., before the task is
> > a zombie because exit_notify() wakes pidfd-pollers. Ideally, pidfd
> > pollers would be woken and then could use the PIDFD_GET_INFO ioctl to
> > retrieve the exit status.
> 
> This was more a less clear to me. But this doesn't match the "the task has
> already been reaped" goal above...
> 
> > It would however be fine to place it into exit_notify() if it's a better
> > fit there. If you have a preference let me know.
> >
> > I don't see a reason why seeing the exit status before that would be an
> > issue.
> 
> The problem is that it is not clear how can we do this correctly.
> Especialy considering the problem with exec...
> 
> > > But what if this file was created without PIDFD_THREAD? If another
> > > thread does exit_group(1) after that, the process's exit code is
> > > 1 << 8, but it can't be retrieved.
> >
> > Yes, I had raised that in an off-list discussion about this as well and
> > was unsure what the cleanest way of dealing with this would be.
> 
> I am not sure too, but again, please see below.
> 
> > > Now, T is very much alive, but pidfs_i(inode)->exit_info != NULL.
> 
> ...
> 
> > What's the best way of handling the de_thread() case? Would moving this
> > into exit_notify() be enough where we also handle
> > PIDFD_THREAD/~PIDFD_THREAD waking?
> 
> I don't think that moving pidfd_exit() into exit_notify() can solve any
> problem.
> 
> But what if we move pidfd_exit() into release_task() paths? Called when
> the task is reaped by the parent/debugger, or if a sub-thread auto-reaps.
> 
> Can the users of pidfd_info(PIDFD_INFO_EXIT) rely on POLLHUP from
> release_task() -> detach_pid() -> __change_pid(new => NULL) ?

Ok, so:

release_task()
-> __exit_signal()
   -> detach_pid()
      -> __change_pid()

That sounds good. So could we do something like:

diff --git a/kernel/exit.c b/kernel/exit.c
index cae475e7858c..66bb5c53454f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -127,8 +127,10 @@ static void __unhash_process(struct task_struct *p, bool group_dead)
 {
        nr_threads--;
        detach_pid(p, PIDTYPE_PID);
+       pidfs_exit(p); // record exit information for individual thread
        if (group_dead) {
                detach_pid(p, PIDTYPE_TGID);
+               pidfs_exit(p); // record exit information for thread-group leader
                detach_pid(p, PIDTYPE_PGID);
                detach_pid(p, PIDTYPE_SID);

I know, as written this won't work but I'm just trying to get the idea
across of recording exit information for both the individual thread and
the thread-group leader in __unhash_process().

That should tackle both problems, i.e., recording exit information for
both thread and thread-group leader as well as exec?

