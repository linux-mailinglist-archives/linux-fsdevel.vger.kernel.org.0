Return-Path: <linux-fsdevel+bounces-53813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584F2AF7CB5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 17:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA446178F08
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 15:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968BF2D1F61;
	Thu,  3 Jul 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlC+guln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7A22A4DA
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557362; cv=none; b=LyHZz37ot1IH8dir8Ojn1l2Gc2OdImmfJ2fFo70ck9OODrKg2Uc/Z2oIxMnmvXhxODZTZ6LtQzDuiZAZxWNe8SAbVCfjRwmS4cyzEF/l2Rroly+ljClPdcsmLPbA3stApu81pJmSr6VeC2qp/5cgs0yhyYIajJz5kru7hOnW3Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557362; c=relaxed/simple;
	bh=yUDtToY+ze28DG0qEFOgkoNbkYCz3GTbIyaEeTkBRd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKYUYqNp6Tyki+I0yWjY7qzQRukP3nCIbw4DikPdYOs5IWyvpa1ZIWw6svkay/IzoRQ9YyOSUUpHO5Egx5SmVa+p8ZGbqwd4p2Eg32Mbgc5hgwDuiRwMyvH1ezxnB9Z1uG9UcDreFP2wSImDTRBnJYpamOe2IfIET/JA9U/7/uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlC+guln; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae35f36da9dso5574866b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751557357; x=1752162157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLRG/YJH4HZroyAUVnCCVBlhG5whe6AdwRfcpicbYyk=;
        b=XlC+gulnRLouyDHmmFeUEoPfZi/3O4TD2d0bvDBkzC7RmTnKQIxdgjx6NJs9ZgwtRx
         ItqLZqU0cAYojExJxwKIcOaY4daeEQJkD6uzAb6sXV377pXqFSms4Of78+Y8pRVbFEuO
         s0nIun70F+b3kLcHSc7/PM3Ti0bu9kMFgb/mnmST5Y6A2SP8lor439WSppqazfgF1Ijt
         GTt8uVFjf4UfEkmfqBiakvfX3vK8teLkuGJGusBPpFNldrF8icjTm3EBrgL7v1kZyctv
         ZTngeaJp9ciLbIpq/RNFIz1xdxZMqP4JSv0YJFnKhG2yrvupr+aeCcfNI5HKz8QbLcUl
         2v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751557357; x=1752162157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLRG/YJH4HZroyAUVnCCVBlhG5whe6AdwRfcpicbYyk=;
        b=iIDWKdvjaeGhquunDBFkFaOwwg+qlDc+mxUawb/VCHnnBbZdt2xkXKoubXmL08za0Z
         u0hSRcSVNQgTRVZxwEa43ttS5v+mXqZj2d3y423Dq9RxbYixAXEwuyxBCjXqUecwCMB0
         YiS0Vlyn+mfK9Twu9tyFtwR+6Pqmdu4XOq1HGR37ZUS1ZdKuoNg3DLoaXzQOB3A1+24V
         SM4vVPz9F4ntvJdvyHe+/seLk8OYJXP6GczWHn8MomRpavG4efBFaOGdl2+iQ2sPE69p
         t9U/mc8XIp/Eb+en/qEdR3q4W1+5sVKO8DyX6APviBT7RYGroau7wAuZHDnbXLyCHSEs
         fGag==
X-Gm-Message-State: AOJu0YzXYE76jfJCK4MigHk2D2RGQxUYnFoecMo5ImFBm04ihBbdfVAh
	J9QGqnzV37ieROTjYltNue2kmeAAKKLzSDlakKAw4X80mu89VbWyUyTon20OBbBVuTex1h1YLcN
	enuDc8cUyVJ3T1Yj0O1qETaCcANOydr4=
X-Gm-Gg: ASbGncut2squnUmoovey/9CZkpCeeZGJ5ApNHI6+Wgu2Ux1WFGzvVBcuiMoJ8Az6vAm
	tebyB8MKR/P8ASot+Y30c2hZH8gRmwiUOB2UB/gYAGpoJrv/7AqQMXDVR4cqt7IZtd6IZkXuh9h
	6lVA9n0vti7tfExNsCZdd3N0cPmKOiUZs1G5MbaHXdwHg=
X-Google-Smtp-Source: AGHT+IHmbgBxCbiKP5lRSU3DHKtSmNbNK6omES58GM3qoydjmFlRZp1khJYryUD+1zZmsUwYvcZO9jaxnIgU6sdrsBY=
X-Received: by 2002:a17:907:6d1f:b0:ade:cdec:7085 with SMTP id
 a640c23a62f3a-ae3d83f77ffmr424418066b.26.1751557356498; Thu, 03 Jul 2025
 08:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703130539.1696938-1-mszeredi@redhat.com>
In-Reply-To: <20250703130539.1696938-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 3 Jul 2025 17:42:24 +0200
X-Gm-Features: Ac12FXxG11PX2u5zmzwvBKPtvquHUsGbPKLCPCx85kx-0CwGf29KlBB1txy3yrU
Message-ID: <CAOQ4uxjC6scXXVi0dHv-UahL2hBXVqLtZvn4BDvT6o_9+LcA7Q@mail.gmail.com>
Subject: Re: [RFC PATCH] fanotify: add watchdog for permission events
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Ian Kent <raven@themaw.net>, Eric Sandeen <sandeen@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 3:05=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com>=
 wrote:
>
> This is to make it easier to debug issues with AV software, which time an=
d
> again deadlocks with no indication of where the issue comes from, and the
> kernel being blamed for the deadlock.  Then we need to analyze dumps to
> prove that the kernel is not in fact at fault.

Interesting.
Do you mean deadlock in userspace or deadlock on some kernel
lock because the server is operating on the filesystem and the
permission event was in a locked context?

>
> With this patch a warning is printed when permission event is received by
> userspace but not answered for more than 20 seconds.
>

There is a nuance here.
Your patch does not count the time from when the operation was queued
and blocked.

It counts the time from when the AV software *reads* the event.
If AV software went off to take a nap and does not read events,
you will not get a watchdog.

Is that good enough to catch the usual offenders?
That relates to my question above whether the deadlock
is inherently because of doing some fs work in the context
of handling a permission event.

If it is, then I wonder if you could share some details about the
analysis of the deadlocks.

Reason I am asking is because when working on pre-content
events, as a side effect, because they share the same hook
with FAN_ACCESS_PERM, the latter event should not be emitted
in the context of fs locks (unless I missed something).

When auditing FAN_OPEN_PERM I recall only one context that
seemed like a potential deadlock trap, which is the permission
hook called from finish_open() in atomic_open() in the context of
 inode_lock{,_shared}(dir->d_inode);

So are the deadlocks that you found happen on fs with atomic_open()?
Technically, we can release the dir inode lock in finish_open()
I think it's just a matter of code architecture to make this happen.

> The timeout is very coarse (20-40s) but I guess it's good enough for the
> purpose.
>
> Overhead should be minimal.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/notify/fanotify/Kconfig         |   5 ++
>  fs/notify/fanotify/fanotify.h      |   6 +-
>  fs/notify/fanotify/fanotify_user.c | 102 +++++++++++++++++++++++++++++
>  include/linux/fsnotify_backend.h   |   4 ++
>  4 files changed, 116 insertions(+), 1 deletion(-)
>
> diff --git a/fs/notify/fanotify/Kconfig b/fs/notify/fanotify/Kconfig
> index 0e36aaf379b7..eeb9c443254e 100644
> --- a/fs/notify/fanotify/Kconfig
> +++ b/fs/notify/fanotify/Kconfig
> @@ -24,3 +24,8 @@ config FANOTIFY_ACCESS_PERMISSIONS
>            hierarchical storage management systems.
>
>            If unsure, say N.
> +
> +config FANOTIFY_PERM_WATCHDOG
> +       bool "fanotify permission event watchdog"
> +       depends on FANOTIFY_ACCESS_PERMISSIONS
> +       default n

I think that's one of those features where sysctl knob is more useful to
distros and admin than Kconfig.
Might as well be a sysctl knob to control perm_group_timeout
where 0 means off.

> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
> index b44e70e44be6..8b60fbb9594f 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -438,10 +438,14 @@ FANOTIFY_ME(struct fanotify_event *event)
>  struct fanotify_perm_event {
>         struct fanotify_event fae;
>         struct path path;
> -       const loff_t *ppos;             /* optional file range info */
> +       union {
> +               const loff_t *ppos;     /* optional file range info */
> +               pid_t pid;              /* pid of task processing the eve=
nt */

It is a bit odd to have a pid_t pid field here as well as
struct pid *pid field in fae.pid (the event generating pid).
So I think, either reuse fae.pid to keep reference to reader task_pid
or leave this pid_t field here with a more specific name.

> +       };
>         size_t count;
>         u32 response;                   /* userspace answer to the event =
*/
>         unsigned short state;           /* state of the event */
> +       unsigned short watchdog_cnt;    /* already scanned by watchdog? *=
/
>         int fd;         /* fd we passed to userspace for this event */
>         union {
>                 struct fanotify_response_info_header hdr;
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 87f861e9004f..a9a34da2c864 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -95,6 +95,96 @@ static void __init fanotify_sysctls_init(void)
>  #define fanotify_sysctls_init() do { } while (0)
>  #endif /* CONFIG_SYSCTL */
>
> +#ifdef CONFIG_FANOTIFY_PERM_WATCHDOG
> +static LIST_HEAD(perm_group_list);
> +static DEFINE_SPINLOCK(perm_group_lock);
> +static void perm_group_watchdog(struct work_struct *work);
> +static DECLARE_DELAYED_WORK(perm_group_work, perm_group_watchdog);
> +static unsigned int perm_group_timeout =3D 20;
> +
> +static void perm_group_watchdog_schedule(void)
> +{
> +       schedule_delayed_work(&perm_group_work, secs_to_jiffies(perm_grou=
p_timeout));
> +}
> +
> +static void perm_group_watchdog(struct work_struct *work)
> +{
> +       struct fsnotify_group *group;
> +       struct fanotify_perm_event *event;
> +       struct task_struct *task;
> +       pid_t failed_pid =3D 0;
> +
> +       guard(spinlock)(&perm_group_lock);
> +       if (list_empty(&perm_group_list))
> +               return;
> +
> +       list_for_each_entry(group, &perm_group_list, fanotify_data.perm_g=
roup) {
> +               /*
> +                * Ok to test without lock, racing with an addition is
> +                * fine, will deal with it next round
> +                */
> +               if (list_empty(&group->fanotify_data.access_list))
> +                       continue;
> +
> +               scoped_guard(spinlock, &group->notification_lock) {
> +                       list_for_each_entry(event, &group->fanotify_data.=
access_list, fae.fse.list) {
> +                               if (likely(event->watchdog_cnt =3D=3D 0))=
 {
> +                                       event->watchdog_cnt =3D 1;
> +                               } else if (event->watchdog_cnt =3D=3D 1) =
{
> +                                       /* Report on event only once */
> +                                       event->watchdog_cnt =3D 2;
> +
> +                                       /* Do not report same pid repeate=
dly */
> +                                       if (event->pid =3D=3D failed_pid)
> +                                               continue;
> +
> +                                       failed_pid =3D event->pid;
> +                                       rcu_read_lock();
> +                                       task =3D find_task_by_pid_ns(even=
t->pid, &init_pid_ns);
> +                                       pr_warn_ratelimited("PID %u (%s) =
failed to respond to fanotify queue for more than %i seconds\n",
> +                                                           event->pid, t=
ask ? task->comm : NULL, perm_group_timeout);
> +                                       rcu_read_unlock();
> +                               }
> +                       }
> +               }
> +       }
> +       perm_group_watchdog_schedule();
> +}
> +
> +static void fanotify_perm_watchdog_group_remove(struct fsnotify_group *g=
roup)
> +{
> +       if (!list_empty(&group->fanotify_data.perm_group)) {
> +               /* Perm event watchdog can no longer scan this group. */
> +               spin_lock(&perm_group_lock);
> +               list_del(&group->fanotify_data.perm_group);
> +               spin_unlock(&perm_group_lock);
> +       }
> +}
> +
> +static void fanotify_perm_watchdog_group_add(struct fsnotify_group *grou=
p)
> +{
> +       if (list_empty(&group->fanotify_data.perm_group)) {
> +               /* Add to perm_group_list for monitoring by watchdog. */
> +               spin_lock(&perm_group_lock);
> +               if (list_empty(&perm_group_list))
> +                       perm_group_watchdog_schedule();
> +               list_add_tail(&group->fanotify_data.perm_group, &perm_gro=
up_list);
> +               spin_unlock(&perm_group_lock);
> +       }
> +}
> +
> +#else
> +
> +static void fanotify_perm_watchdog_group_remove(struct fsnotify_group *g=
roup)
> +{
> +}
> +
> +static void fanotify_perm_watchdog_group_add(struct fsnotify_group *grou=
p)
> +{
> +}
> +
> +#endif
> +
>  /*
>   * All flags that may be specified in parameter event_f_flags of fanotif=
y_init.
>   *
> @@ -210,6 +300,8 @@ static void fanotify_unhash_event(struct fsnotify_gro=
up *group,
>         hlist_del_init(&event->merge_list);
>  }
>
> +
> +
>  /*
>   * Get an fanotify notification event if one exists and is small
>   * enough to fit in "count". Return an error pointer if the count
> @@ -953,6 +1045,7 @@ static ssize_t fanotify_read(struct file *file, char=
 __user *buf,
>                                 spin_lock(&group->notification_lock);
>                                 list_add_tail(&event->fse.list,
>                                         &group->fanotify_data.access_list=
);
> +                               FANOTIFY_PERM(event)->pid =3D current->pi=
d;
>                                 spin_unlock(&group->notification_lock);
>                         }
>                 }
> @@ -1012,6 +1105,8 @@ static int fanotify_release(struct inode *ignored, =
struct file *file)
>          */
>         fsnotify_group_stop_queueing(group);
>
> +       fanotify_perm_watchdog_group_remove(group);
> +
>         /*
>          * Process all permission events on access_list and notification =
queue
>          * and simulate reply from userspace.
> @@ -1464,6 +1559,10 @@ static int fanotify_add_mark(struct fsnotify_group=
 *group,
>         fsnotify_group_unlock(group);
>
>         fsnotify_put_mark(fsn_mark);
> +
> +       if (!ret && (mask & FANOTIFY_PERM_EVENTS))
> +               fanotify_perm_watchdog_group_add(group);
> +

This ends up doing
       if (list_empty(&group->fanotify_data.perm_group)) {

Without holding the group lock nor the perm_group_lock.
it does not look safe against adding to fanotify_data.perm_group
twice.

It would have been more natural and balanced to add group
to watchdog list on fanotify_init().

You can do that based on (group->priority > FSNOTIFY_PRIO_NORMAL)
because while a program could create an fanotify group with
priority FAN_CLASS_CONTENT and not add permission event
watches, there is absolutely no reason to optimize for this case and
not add this group to the "permission events capable" perm_group list.

Thanks,
Amir.

