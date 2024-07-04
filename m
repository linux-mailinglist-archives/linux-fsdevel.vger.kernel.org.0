Return-Path: <linux-fsdevel+bounces-23128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1079277AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 16:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF0928330D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 14:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C576A1AED56;
	Thu,  4 Jul 2024 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jq9YLrUf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2951D1822E2;
	Thu,  4 Jul 2024 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101846; cv=none; b=qV+TIxCFzcUnN4yhaUvp6+0wXL8RIksk8tSJUltJft0mREksaDw+3XNSnFY0TaSa+KfRV5qSTqS519tMezHVXNWGlDYj5wTFoYSiHR6ijsZ9h2Z+3JWn4U4IuJvHNA6GcujOo1Y3zvWmQDNVB6HzMEzooGKoVpHn883uCcoz060=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101846; c=relaxed/simple;
	bh=wZYTKnFz/gwAFTRm5C60rPGzgtSUfuPJ/lymJgtVcEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWxx048mBOgLAET7d5xK4qBBr+2EVluJv+yzZbfS4zQSqjOXkqupD6gT2o5kM2wB6UtPkwswPCImvWtOWcn1KJ7nhItDr3X0kbbScofj3W974v516/PTGzkwmN3ZPpBoG/GVNsfz8F06sart7P94JdpJRsdSSn3LOTQ4i3+hYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jq9YLrUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81F0C3277B;
	Thu,  4 Jul 2024 14:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720101845;
	bh=wZYTKnFz/gwAFTRm5C60rPGzgtSUfuPJ/lymJgtVcEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jq9YLrUfdXj7LHp7+oLnavu16y5PMMM+Ls1RDM2mCFsudxLRBEnIQnhnEw/Yax01j
	 D1uaZu2rZlZZg2fCHUOvS+778jbN+Ryvg4AS77YPSfmGwLygcG6U3W/p2Ra3BoPVRJ
	 JB39gllQ/2jL6bFJncsyYPFq3rXi+MoMZXxk7wLvt2b/02neOuhn+8dQgYdPAO3Arj
	 6Wys57sfhenLpp0PPbNozfBmLUgaJpPFzCz9F5T679QS5cWvjrcmvPpOZi+M2PXfXp
	 m2q4/aGMlgNCeMuYt5AL98nYuNzpqDrXcBFh6oqNdnJAFE+Sx4pnXK2N7/+gXcMVS8
	 C7FYkTa2P4HUQ==
Date: Thu, 4 Jul 2024 16:03:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: tglx@linutronix.de, jstultz@google.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, saravanak@google.com, mjguzik@gmail.com, 
	Manish Varma <varmam@google.com>, Kelly Rossmoyer <krossmo@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6] fs: Improve eventpoll logging to stop indicting
 timerfd
Message-ID: <20240704-umsatz-drollig-38db6b84da7b@brauner>
References: <20240703214315.454407-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240703214315.454407-1-isaacmanjarres@google.com>

On Wed, Jul 03, 2024 at 02:43:14PM GMT, Isaac J. Manjarres wrote:
> From: Manish Varma <varmam@google.com>
> 
> We'll often see aborted suspend operations that look like:
> 
>  PM: suspend entry 2024-07-03 15:55:15.372419634 UTC
>  PM: PM: Pending Wakeup Sources: [timerfd]
>  Abort: Pending Wakeup Sources: [timerfd]
>  PM: suspend exit 2024-07-03 15:55:15.445281857 UTC
> 
> From this, it seems a timerfd caused the abort, but that can be
> confusing, as timerfds don't create wakeup sources. However,
> eventpoll can, and when it does, it names them after the underlying
> file descriptor. Unfortunately, all the file descriptors are called
> "[timerfd]", and a system may have many timerfds, so this isn't very
> useful to debug what's going on to cause the suspend to abort.
> 
> To improve this, change the way eventpoll wakeup sources are named:
> 
> 1) The top-level per-process eventpoll wakeup source is now named
> "epollN:P" (instead of just "eventpoll"), where N is a unique ID token,
> and P is the PID of the creating process.
> 
> 2) Individual eventpoll item wakeup sources are now named
> "epollitemN:P.F", where N is a unique ID token, P is PID of the creating
> process, and F is the name of the underlying file descriptor.

Fyi, that PID is meaningless or even actively misleading in the face of
pid namespaces. And since such wakeups seem to be registered in sysfs
globally they are visible to all containers. That means a container will
now see some timerfd wakeup source with a PID that might just accidently
correspond to a process inside the container. Which in turn also means
you're leaking the info about the creating process into the container.
IOW, if PID 1 ends up registering some wakeup source the container gets
to know about it.

> 
> Now, when the scenario described earlier is encountered, the following
> kernel logs are emitted:
> 
>  PM: suspend entry 2024-07-03 15:39:24.945791824 UTC
>  PM: PM: Pending Wakeup Sources: epollitem30:6375.[timerfd]
>  Abort: Pending Wakeup Sources: epollitem30:6375.[timerfd]
>  PM: suspend exit 2024-07-03 15:39:25.017775019 UTC
> 
> There are various benefits to this new naming convention:
> 
> 1) It is clear that the wakeup source is linked to an eventpoll
> item.
> 
> 2) Now that the PID of the process associated with that timerfd
> instance is known, it is easy to map the PID of the process to the
> name of the process. With this information, it is easy to start
> debugging which process is causing this issue to occur.
> 
> 3) Even if process 6375 creates multiple timerfd instances, the
> ID token is useful in identifying which timerfd instance associated
> with the process is causing suspend to abort, as it is monotonically
> increasing. So if the order in which the timerfd instances for the
> process is known, then one can pinpoint which timerfd instance is
> causing this issue.
> 
> Co-developed-by: Kelly Rossmoyer <krossmo@google.com>
> Signed-off-by: Kelly Rossmoyer <krossmo@google.com>
> Signed-off-by: Manish Varma <varmam@google.com>
> Co-developed-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> ---
>  drivers/base/power/wakeup.c | 12 +++++++++---
>  fs/eventpoll.c              | 11 +++++++++--
>  include/linux/pm_wakeup.h   |  8 ++++----
>  3 files changed, 22 insertions(+), 9 deletions(-)
> 
>  v1 -> v2:
>  - Renamed instance count to wakesource_create_id to better describe
>    its purpose.
>  - Changed the wakeup source naming convention for wakeup sources
>    created by eventpoll to avoid changing the timerfd names.
>  - Used the PID of the process instead of the process name for the
>    sake of uniqueness when creating wakeup sources.
> 
> v2 -> v3:
>  - Changed wakeup_source_register() to take in a format string
>    and arguments to avoid duplicating code to construct wakeup
>    source names.
>  - Moved the definition of wakesource_create_id so that it is
>    always defined to fix an compilation error.
> 
> v3 -> v4:
>  - Changed the naming convention for the top-level epoll wakeup
>    sources to include an ID for uniqueness. This is needed in
>    cases where a process is using two epoll fds.
>  - Edited commit log to reflect new changes and add new tags.
> 
> v4 -> v5:
>  - Added the format attribute to the wakeup_source_register()
>    function to address a warning from the kernel test robot:
>    https://lore.kernel.org/all/202406050504.UvdlPAQ0-lkp@intel.com/
> 
> v5 -> v6:
>  - Reworded the commit text to clarify the scenarios in which this
>    patch is helpful, as per feedback from
>    John Stultz <jstultz@google.com>
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 752b417e8129..04a808607b62 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -209,13 +209,19 @@ EXPORT_SYMBOL_GPL(wakeup_source_remove);
>  /**
>   * wakeup_source_register - Create wakeup source and add it to the list.
>   * @dev: Device this wakeup source is associated with (or NULL if virtual).
> - * @name: Name of the wakeup source to register.
> + * @fmt: format string for the wakeup source name
>   */
> -struct wakeup_source *wakeup_source_register(struct device *dev,
> -					     const char *name)
> +__printf(2, 3) struct wakeup_source *wakeup_source_register(struct device *dev,
> +							    const char *fmt, ...)
>  {
>  	struct wakeup_source *ws;
>  	int ret;
> +	char name[128];
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	vsnprintf(name, sizeof(name), fmt, args);
> +	va_end(args);
>  
>  	ws = wakeup_source_create(name);
>  	if (ws) {
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index f53ca4f7fced..941df15208a4 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -338,6 +338,7 @@ static void __init epoll_sysctls_init(void)
>  #define epoll_sysctls_init() do { } while (0)
>  #endif /* CONFIG_SYSCTL */
>  
> +static atomic_t wakesource_create_id  = ATOMIC_INIT(0);
>  static const struct file_operations eventpoll_fops;
>  
>  static inline int is_file_epoll(struct file *f)
> @@ -1545,15 +1546,21 @@ static int ep_create_wakeup_source(struct epitem *epi)
>  {
>  	struct name_snapshot n;
>  	struct wakeup_source *ws;
> +	pid_t task_pid;
> +	int id;
> +
> +	task_pid = task_pid_nr(current);
>  
>  	if (!epi->ep->ws) {
> -		epi->ep->ws = wakeup_source_register(NULL, "eventpoll");
> +		id = atomic_inc_return(&wakesource_create_id);
> +		epi->ep->ws = wakeup_source_register(NULL, "epoll:%d:%d", id, task_pid);
>  		if (!epi->ep->ws)
>  			return -ENOMEM;
>  	}
>  
> +	id = atomic_inc_return(&wakesource_create_id);
>  	take_dentry_name_snapshot(&n, epi->ffd.file->f_path.dentry);
> -	ws = wakeup_source_register(NULL, n.name.name);
> +	ws = wakeup_source_register(NULL, "epollitem%d:%d.%s", id, task_pid, n.name.name);
>  	release_dentry_name_snapshot(&n);
>  
>  	if (!ws)
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index 76cd1f9f1365..1fb6dca981c2 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -99,8 +99,8 @@ extern struct wakeup_source *wakeup_source_create(const char *name);
>  extern void wakeup_source_destroy(struct wakeup_source *ws);
>  extern void wakeup_source_add(struct wakeup_source *ws);
>  extern void wakeup_source_remove(struct wakeup_source *ws);
> -extern struct wakeup_source *wakeup_source_register(struct device *dev,
> -						    const char *name);
> +extern __printf(2, 3) struct wakeup_source *wakeup_source_register(struct device *dev,
> +								   const char *fmt, ...);
>  extern void wakeup_source_unregister(struct wakeup_source *ws);
>  extern int wakeup_sources_read_lock(void);
>  extern void wakeup_sources_read_unlock(int idx);
> @@ -140,8 +140,8 @@ static inline void wakeup_source_add(struct wakeup_source *ws) {}
>  
>  static inline void wakeup_source_remove(struct wakeup_source *ws) {}
>  
> -static inline struct wakeup_source *wakeup_source_register(struct device *dev,
> -							   const char *name)
> +static inline __printf(2, 3) struct wakeup_source *wakeup_source_register(struct device *dev,
> +									  const char *fmt, ...)
>  {
>  	return NULL;
>  }
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

