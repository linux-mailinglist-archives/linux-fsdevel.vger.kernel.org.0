Return-Path: <linux-fsdevel+bounces-44027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A0BA6152F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 16:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7447D17EAFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71549201036;
	Fri, 14 Mar 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0z8wAAv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60F11EEA5D;
	Fri, 14 Mar 2025 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966951; cv=none; b=mpf5MK5EVXOKfN1HMEZHIuHbij54Wl3+5Y6bsZKCgjo/ClBoM7Zlu/vHitvZOv1/qberLc49gq1LlkggApwsXFA6GSPZwxlOWS1Eo9tmCxt/buT99JtsJEd60/gLChdn8yWi6EfAIzzzVZxgqDSVnNaSFGHPi55hCqkc2rH8wIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966951; c=relaxed/simple;
	bh=fY6NNdYXbkSUdnsh0gksJ+CeGLSLZTHOrTd9nCzEgKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQFUZX/6gn3fHqXhJQl6LCBk9wobq+LGHnyoE3PeIi561ssG2vql+1hMpROYrOCY23rXfO23FMoDbKbwtCyah6t5uPqAz/MD243VN1p9/Vjf9khiuShyqCrsXIysdY3eJVzCd0S4pjdmXVV1ah6i+Zk/W6Xfix/eYp4CzsM211c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0z8wAAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4687C4CEE3;
	Fri, 14 Mar 2025 15:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741966951;
	bh=fY6NNdYXbkSUdnsh0gksJ+CeGLSLZTHOrTd9nCzEgKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O0z8wAAvDMVbxhPFUO4yQ6mIyPoO/Nn61F0mub1Kts+IN+O0H2lhLc00FkF5RCXdZ
	 /gX7MSKa3eBqjnyu3j3+OQ+AaS8efjChjmH9Mmj1CB6+HvW3edQ8UiFz7cLKQxqJf0
	 ex0m+fEbSu82LjrS0qIC5Ur/X2w3p8JoNBm26mY0yvpqrHesS9AJHgHvsgCOQ9Gcsv
	 YU1+Uz073mk7x50KnMDkEymHyEJUfuPRsA1d+EEOYzAwuqVbQDbWIyVr6BoHGP4gff
	 bm9MD7U5mCkPHmQw1y4F6pHkc4PkEtbj0kRuCJomFXJsnX7ZKn/XsatVtmgPFfGr9n
	 dN2s4rlMztn/Q==
Date: Fri, 14 Mar 2025 16:42:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Kees Cook <kees@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1] landlock: Allow signals between threads of the
 same process
Message-ID: <20250314-unkritisch-triangel-b0c733841974@brauner>
References: <20250313145904.3238184-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313145904.3238184-1-mic@digikod.net>

On Thu, Mar 13, 2025 at 03:59:04PM +0100, Mickaël Salaün wrote:
> Because Linux credentials are managed per thread, user space relies on
> some hack to synchronize credential update across threads from the same
> process.  This is required by the Native POSIX Threads Library and
> implemented by set*id(2) wrappers and libcap(3) to use tgkill(2) to
> synchronize threads.  See nptl(7) and libpsx(3).  Furthermore, some
> runtimes like Go do not enable developers to have control over threads
> [1].
> 
> To avoid potential issues, and because threads are not security
> boundaries, let's relax the Landlock signal scoping to always allow
> signals sent between threads of the same process.  This exception is
> similar to the __ptrace_may_access() one.
> 
> hook_file_set_fowner() now checks if the target task is part of the same
> process as the caller.  If this is the case, then the related signal
> triggered by the socket will always be allowed.

Seems fine,
Acked-by: Christian Brauner <brauner@kernel.org>

> 
> Scoping of abstract UNIX sockets is not changed because kernel objects
> (e.g. sockets) should be tied to their creator's domain at creation
> time.
> 
> Note that creating one Landlock domain per thread puts each of these
> threads (and their future children) in their own scope, which is
> probably not what users expect, especially in Go where we do not control
> threads.  However, being able to drop permissions on all threads should
> not be restricted by signal scoping.  We are working on a way to make it
> possible to atomically restrict all threads of a process with the same
> domain [2].
> 
> Closes: https://github.com/landlock-lsm/go-landlock/issues/36
> Fixes: 54a6e6bbf3be ("landlock: Add signal scoping")
> Fixes: c8994965013e ("selftests/landlock: Test signal scoping for threads")
> Depends-on: 26f204380a3c ("fs: Fix file_set_fowner LSM hook inconsistencies")
> Link: https://pkg.go.dev/kernel.org/pub/linux/libs/security/libcap/psx [1]
> Link: https://github.com/landlock-lsm/linux/issues/2 [2]
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Tahera Fahimi <fahimitahera@gmail.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250313145904.3238184-1-mic@digikod.net
> ---
> 
> I'm still not sure how we could reliably detect if the running kernel
> has this fix or not, especially in Go.
> ---
>  security/landlock/fs.c                        | 22 +++++++++++++++----
>  security/landlock/task.c                      | 12 ++++++++++
>  .../selftests/landlock/scoped_signal_test.c   |  2 +-
>  3 files changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 71b9dc331aae..47c862fe14e4 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -27,7 +27,9 @@
>  #include <linux/mount.h>
>  #include <linux/namei.h>
>  #include <linux/path.h>
> +#include <linux/pid.h>
>  #include <linux/rcupdate.h>
> +#include <linux/sched/signal.h>
>  #include <linux/spinlock.h>
>  #include <linux/stat.h>
>  #include <linux/types.h>
> @@ -1630,15 +1632,27 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
>  
>  static void hook_file_set_fowner(struct file *file)
>  {
> -	struct landlock_ruleset *new_dom, *prev_dom;
> +	struct fown_struct *fown = file_f_owner(file);
> +	struct landlock_ruleset *new_dom = NULL;
> +	struct landlock_ruleset *prev_dom;
> +	struct task_struct *p;
>  
>  	/*
>  	 * Lock already held by __f_setown(), see commit 26f204380a3c ("fs: Fix
>  	 * file_set_fowner LSM hook inconsistencies").
>  	 */
> -	lockdep_assert_held(&file_f_owner(file)->lock);
> -	new_dom = landlock_get_current_domain();
> -	landlock_get_ruleset(new_dom);
> +	lockdep_assert_held(&fown->lock);
> +
> +	/*
> +	 * Always allow sending signals between threads of the same process.  This
> +	 * ensures consistency with hook_task_kill().
> +	 */
> +	p = pid_task(fown->pid, fown->pid_type);
> +	if (!same_thread_group(p, current)) {
> +		new_dom = landlock_get_current_domain();
> +		landlock_get_ruleset(new_dom);
> +	}
> +
>  	prev_dom = landlock_file(file)->fown_domain;
>  	landlock_file(file)->fown_domain = new_dom;
>  
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index dc7dab78392e..4578ce6e319d 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -13,6 +13,7 @@
>  #include <linux/lsm_hooks.h>
>  #include <linux/rcupdate.h>
>  #include <linux/sched.h>
> +#include <linux/sched/signal.h>
>  #include <net/af_unix.h>
>  #include <net/sock.h>
>  
> @@ -264,6 +265,17 @@ static int hook_task_kill(struct task_struct *const p,
>  		/* Dealing with USB IO. */
>  		dom = landlock_cred(cred)->domain;
>  	} else {
> +		/*
> +		 * Always allow sending signals between threads of the same process.
> +		 * This is required for process credential changes by the Native POSIX
> +		 * Threads Library and implemented by the set*id(2) wrappers and
> +		 * libcap(3) with tgkill(2).  See nptl(7) and libpsx(3).
> +		 *
> +		 * This exception is similar to the __ptrace_may_access() one.
> +		 */
> +		if (same_thread_group(p, current))
> +			return 0;
> +
>  		dom = landlock_get_current_domain();
>  	}
>  	dom = landlock_get_applicable_domain(dom, signal_scope);
> diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
> index 475ee62a832d..767f117703b7 100644
> --- a/tools/testing/selftests/landlock/scoped_signal_test.c
> +++ b/tools/testing/selftests/landlock/scoped_signal_test.c
> @@ -281,7 +281,7 @@ TEST(signal_scoping_threads)
>  	/* Restricts the domain after creating the first thread. */
>  	create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
>  
> -	ASSERT_EQ(EPERM, pthread_kill(no_sandbox_thread, 0));
> +	ASSERT_EQ(0, pthread_kill(no_sandbox_thread, 0));
>  	ASSERT_EQ(1, write(thread_pipe[1], ".", 1));
>  
>  	ASSERT_EQ(0, pthread_create(&scoped_thread, NULL, thread_func, NULL));
> 
> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
> -- 
> 2.48.1
> 

