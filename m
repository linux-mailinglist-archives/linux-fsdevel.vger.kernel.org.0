Return-Path: <linux-fsdevel+bounces-23122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92824927610
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 14:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9348B218DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 12:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73EE1AE847;
	Thu,  4 Jul 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHFCjWiu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8C11822FB;
	Thu,  4 Jul 2024 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720096283; cv=none; b=UhIQeRMCFvNUXBWG1v0ZJb+FwmfxJ3nkpWmvqI7HifVnvpItWJXXO91nYNJN17/RpOQiWj4o7xMLpdsTuSkBTJc/xv8H+1rZVW1WZVM7TnFN7+1ko5Fcj4sGi7YgapfHyyo6eWQZBJXYEm+pC6XB7EUcOnN2PwmhFnnHv8+Eu8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720096283; c=relaxed/simple;
	bh=NrMOdvTHRfD6/EsYygG6xW5j1RcLbOwnQz82914Hkto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tH3Mk3T6g8W4aLEzeoJaCQl8O/P1lkVrqiWvsT3GCqp5nK3WY5NvrOHrdJnNFRzuExMR6Lj14NTsjQmVbvJZE2lon621IaSof53rJiRdrl5qX+1EPCNJfYQJZ0RoXLObu5+gIZo4sZdF3rYfGQCkGCDs/wrHP8Rm/Hrk/7uHLhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHFCjWiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8336EC4AF10;
	Thu,  4 Jul 2024 12:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720096282;
	bh=NrMOdvTHRfD6/EsYygG6xW5j1RcLbOwnQz82914Hkto=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EHFCjWiuLWsNEZEzppNdUTY4pbRY24icGXWiW+La46jmCSQuOWEiKrLLQmNGx/7tm
	 n8vozMQ91ujB44hYlDZ65PguTZ9a8zrtwZvlsMrfrT65mVqPfhWpEmTfFQd/GbWbbR
	 xVr4P33izq0nzf7wPvuRJdAkTAYn/0c5SVkQ4V06nmK2+4NL++SCdoL/KETAGda9uf
	 /tj40T4Riv+yQaLGwLuo5xLPnhu6X0uyAEdx+FZzgEkwmvvHtohpbe7Wyxmjk7agUv
	 x0OXP73bCElTl3O7Z4L9MOiTUa+G8XLS5Dzp77RbDeofrSa15TiKDSgdvL2T6r4YNd
	 q9lEeqDSAKJlQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25cb5ee9d2dso100855fac.1;
        Thu, 04 Jul 2024 05:31:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBY7YkKj9g/7vB5bPxX/9oFGuIU17OIwJZfr5BZIzulPB50yBFolAnp1wr96LjmKkA6s+EFvcgVi470V3VgjJzKeGpXvLHkRXjf7Xp287W3KbgnGL9r+b3XPk0V2F5YM59LIj3ZGyDOOzKfJj1fRyWmwtC8jeEdQk5oDYecb9lyLbPsZrY
X-Gm-Message-State: AOJu0YxPAnQh6XG9OS9LlP0oYrZdFpp8ffY/tW6cZZ8g/Jf4m3YUiyZF
	Iq3DLgZfAxptA/j/rX5CELpi2cdVoWJB6RYjAbX3e0aGf+u70DvbPbvlVMcNcO6k3xbqZiZDNOW
	12GyqvNSyDs2ovDNl5D5XQj97PUw=
X-Google-Smtp-Source: AGHT+IGvQjd8yj5g2VnXn6ZjT/Wc4/TD5l5l8Rj/Lpm695mm8KbI+B1Rfuqz3a2+DNIfcwRnKsG29Drd7eA2IMD48J8=
X-Received: by 2002:a4a:9219:0:b0:5c2:20aa:db25 with SMTP id
 006d021491bc7-5c646ec7d4bmr1689927eaf.1.1720096281712; Thu, 04 Jul 2024
 05:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703214315.454407-1-isaacmanjarres@google.com>
In-Reply-To: <20240703214315.454407-1-isaacmanjarres@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jul 2024 14:31:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j6xSD4FJGe1=hb=A4UsCqOqBczQ5QNN_0VJAd-7ePZWQ@mail.gmail.com>
Message-ID: <CAJZ5v0j6xSD4FJGe1=hb=A4UsCqOqBczQ5QNN_0VJAd-7ePZWQ@mail.gmail.com>
Subject: Re: [PATCH v6] fs: Improve eventpoll logging to stop indicting timerfd
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: tglx@linutronix.de, jstultz@google.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, saravanak@google.com, 
	mjguzik@gmail.com, Manish Varma <varmam@google.com>, Kelly Rossmoyer <krossmo@google.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 11:43=E2=80=AFPM Isaac J. Manjarres
<isaacmanjarres@google.com> wrote:
>
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

For the changes in wakeup.c

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

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
>   * @dev: Device this wakeup source is associated with (or NULL if virtua=
l).
> - * @name: Name of the wakeup source to register.
> + * @fmt: format string for the wakeup source name
>   */
> -struct wakeup_source *wakeup_source_register(struct device *dev,
> -                                            const char *name)
> +__printf(2, 3) struct wakeup_source *wakeup_source_register(struct devic=
e *dev,
> +                                                           const char *f=
mt, ...)
>  {
>         struct wakeup_source *ws;
>         int ret;
> +       char name[128];
> +       va_list args;
> +
> +       va_start(args, fmt);
> +       vsnprintf(name, sizeof(name), fmt, args);
> +       va_end(args);
>
>         ws =3D wakeup_source_create(name);
>         if (ws) {
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index f53ca4f7fced..941df15208a4 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -338,6 +338,7 @@ static void __init epoll_sysctls_init(void)
>  #define epoll_sysctls_init() do { } while (0)
>  #endif /* CONFIG_SYSCTL */
>
> +static atomic_t wakesource_create_id  =3D ATOMIC_INIT(0);
>  static const struct file_operations eventpoll_fops;
>
>  static inline int is_file_epoll(struct file *f)
> @@ -1545,15 +1546,21 @@ static int ep_create_wakeup_source(struct epitem =
*epi)
>  {
>         struct name_snapshot n;
>         struct wakeup_source *ws;
> +       pid_t task_pid;
> +       int id;
> +
> +       task_pid =3D task_pid_nr(current);
>
>         if (!epi->ep->ws) {
> -               epi->ep->ws =3D wakeup_source_register(NULL, "eventpoll")=
;
> +               id =3D atomic_inc_return(&wakesource_create_id);
> +               epi->ep->ws =3D wakeup_source_register(NULL, "epoll:%d:%d=
", id, task_pid);
>                 if (!epi->ep->ws)
>                         return -ENOMEM;
>         }
>
> +       id =3D atomic_inc_return(&wakesource_create_id);
>         take_dentry_name_snapshot(&n, epi->ffd.file->f_path.dentry);
> -       ws =3D wakeup_source_register(NULL, n.name.name);
> +       ws =3D wakeup_source_register(NULL, "epollitem%d:%d.%s", id, task=
_pid, n.name.name);
>         release_dentry_name_snapshot(&n);
>
>         if (!ws)
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index 76cd1f9f1365..1fb6dca981c2 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -99,8 +99,8 @@ extern struct wakeup_source *wakeup_source_create(const=
 char *name);
>  extern void wakeup_source_destroy(struct wakeup_source *ws);
>  extern void wakeup_source_add(struct wakeup_source *ws);
>  extern void wakeup_source_remove(struct wakeup_source *ws);
> -extern struct wakeup_source *wakeup_source_register(struct device *dev,
> -                                                   const char *name);
> +extern __printf(2, 3) struct wakeup_source *wakeup_source_register(struc=
t device *dev,
> +                                                                  const =
char *fmt, ...);
>  extern void wakeup_source_unregister(struct wakeup_source *ws);
>  extern int wakeup_sources_read_lock(void);
>  extern void wakeup_sources_read_unlock(int idx);
> @@ -140,8 +140,8 @@ static inline void wakeup_source_add(struct wakeup_so=
urce *ws) {}
>
>  static inline void wakeup_source_remove(struct wakeup_source *ws) {}
>
> -static inline struct wakeup_source *wakeup_source_register(struct device=
 *dev,
> -                                                          const char *na=
me)
> +static inline __printf(2, 3) struct wakeup_source *wakeup_source_registe=
r(struct device *dev,
> +                                                                        =
 const char *fmt, ...)
>  {
>         return NULL;
>  }
> --
> 2.45.2.803.g4e1b14247a-goog
>

