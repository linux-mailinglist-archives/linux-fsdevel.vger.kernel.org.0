Return-Path: <linux-fsdevel+bounces-5173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AE5809056
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 19:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DBB4B20DA5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 18:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B522C4E63A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 18:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7oCaU1T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A46446C6;
	Thu,  7 Dec 2023 17:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAEDC433C9;
	Thu,  7 Dec 2023 17:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701969684;
	bh=rU4hXuTRF4ao1EdgYtEDoWkxEgC/yPUpYU2EmGERI4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7oCaU1T1HDC9USQplwo3comKIzmFXmkgpaHgB2ZQ3ZgxuK/Wy7T8iWQQCLLfyMQY
	 MCrkPq3w/O/9bEwBTkgICNqqKjG7YMerjpQlqtgog2N/fmAqHenhsHuO+EuG2IcM/9
	 FJufej2gyhvuRAyn109CWUG/LS7ir1r/nUV6M6zzsPHcJwgaorT92Pynj1tm4FxUBj
	 IU7QZDr9c5Zu/87uolSb5woHx03nAnj49kBFh4AXoO1uPmqBdGG4Pt7yvj+4zqCzE9
	 xm794EjdURSSuIsKtXD/p2zYpQiIi9ThyFkAEiks8IyGJHwjYxfZqYDETuG01WoyLP
	 9p0FditxUunIg==
Date: Thu, 7 Dec 2023 18:21:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <20231207-netzhaut-wachen-81c34f8ee154@brauner>
References: <20231130163946.277502-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231130163946.277502-1-tycho@tycho.pizza>

[Cc fsdevel & Jan because we had some discussions about fanotify
returning non-thread-group pidfds. That's just for awareness or in case
this might need special handling.]

On Thu, Nov 30, 2023 at 09:39:44AM -0700, Tycho Andersen wrote:
> From: Tycho Andersen <tandersen@netflix.com>
> 
> We are using the pidfd family of syscalls with the seccomp userspace
> notifier. When some thread triggers a seccomp notification, we want to do
> some things to its context (munge fd tables via pidfd_getfd(), maybe write
> to its memory, etc.). However, threads created with ~CLONE_FILES or
> ~CLONE_VM mean that we can't use the pidfd family of syscalls for this
> purpose, since their fd table or mm are distinct from the thread group
> leader's. In this patch, we relax this restriction for pidfd_open().
> 
> In order to avoid dangling poll() users we need to notify pidfd waiters
> when individual threads die, but once we do that all the other machinery
> seems to work ok viz. the tests. But I suppose there are more cases than
> just this one.
> 
> Another weirdness is the open-coding of this vs. exporting using
> do_notify_pidfd(). This particular location is after __exit_signal() is
> called, which does __unhash_process() which kills ->thread_pid, so we need
> to use the copy we have locally, vs do_notify_pid() which accesses it via
> task_pid(). Maybe this suggests that the notification should live somewhere
> in __exit_signals()? I just put it here because I saw we were already
> testing if this task was the leader.
> 
> Signed-off-by: Tycho Andersen <tandersen@netflix.com>
> ---

So we've always said that if there's a use-case for this then we're
willing to support it. And I think that stance hasn't changed. I know
that others have expressed interest in this as well.

So currently the series only enables pidfds for threads to be created
and allows notifications for threads. But all places that currently make
use of pidfds refuse non-thread-group leaders. We can certainly proceed
with a patch series that only enables creation and exit notification but
we should also consider unlocking additional functionality:

* audit of all callers that use pidfd_get_task()

  (1) process_madvise()
  (2) process_mrlease()

  I expect that both can handle threads just fine but we'd need an Ack
  from mm people.

* pidfd_prepare() is used to create pidfds for:

  (1) CLONE_PIDFD via clone() and clone3()
  (2) SCM_PIDFD and SO_PEERPIDFD
  (3) fanotify
  
  (1) is what this series here is about.

  For (2) we need to check whether fanotify would be ok to handle pidfds
  for threads. It might be fine but Jan will probably know more.

  For (3) the change doesn't matter because SCM_CREDS always use the
  thread-group leader. So even if we allowed the creation of pidfds for
  threads it wouldn't matter.
* audit all callers of pidfd_pid() whether they could simply be switched
  to handle individual threads:

  (1) setns() handles threads just fine so this is safe to allow.
  (2) pidfd_getfd() I would like to keep restricted and essentially
      freeze new features for it.

      I'm not happy that we did didn't just implement it as an ioctl to
      the seccomp notifier. And I wouldn't oppose a patch that would add
      that functionality to the seccomp notifier itself. But that's a
      separate topic.
  (3) pidfd_send_signal(). I think that one is the most interesting on
      to allow signaling individual threads. I'm not sure that you need
      to do this right now in this patch but we need to think about what
      we want to do there.

