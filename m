Return-Path: <linux-fsdevel+bounces-60932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBC2B5305C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950C91C8439C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D094317712;
	Thu, 11 Sep 2025 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6ffVzN2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED59314B8A
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589959; cv=none; b=jc7FH46mcigRjXy/SlyRl2G3Kq41Be+w+EBCBzYLvCjw8VEPBiDvcnxMQQPDjuDurAG5tvKzEwIglZe60gfSTmm56h9BPIKbaEZOJmJkTmv8xoHWIy74uAfREYFZID78+8MA3HcmzB4iUgB4Xe9oLDei4Hcia5L8MBslTTcq0lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589959; c=relaxed/simple;
	bh=GotpAAqocMx0Egmc2McURTndpbxrZCwB/hT3wVfvtGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jU6ozQiXyM3qq/UZHdIIl1jT/aiSScHaf5BpTXYVnTUbk/ax9+YXUgX6anzMqDrBXmR0vXGtqqki6jsGUP4y2xAq2Eo9jfnE0xd9HpY/x9WIa4Yu5w7ykv8de1O+vVmwP7/AxVMEo6WFvN1viT6rp1zmnuKOtN/aVwKmnQWrYs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6ffVzN2; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62ec7fe6e35so743862a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 04:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757589956; x=1758194756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anHHp3MqUkZENXn5CxtIJ1wxRgWVQ8q81pe5TFvy2CE=;
        b=m6ffVzN2FAXmC7jjIK3fpgcQ6ApmVPTYnvF09WJumIFXrfXh0oKr0Xhlbk9NQYZtD6
         CyHGG9JN6u78HnpEa78Qvoz0wCJycQLPuxiFu64DGLSEUYdWohuwvrM5jasoho2kwAhU
         tRAF6GwIZJ5ThIqHREME1Xhn8a2vQi+32fEm04Da3UrcHSRNzCAS+zHmiFQxhBK/KtME
         bZZldl9LsdxprlZbI2B08ZZVWORr65VU4VqjU+6j0HyxhqGZOYx44V4sqm13DKtBXtzH
         BoSi9rv7PmHo/NlSTIzAzTLI+BQCeGqrNDsbzyHKa44N1ZIiYVipQkEObijVVmCuDfF7
         9XKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757589956; x=1758194756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anHHp3MqUkZENXn5CxtIJ1wxRgWVQ8q81pe5TFvy2CE=;
        b=sBdegQNcTqgPUyVzkZhZokObc8NuEG+0nnzwGYyrqK0gXrIbP+nZl7xmo+ecpOZo4N
         8JsDAWDRoX2X9SFKwFLe8bKNT2PZyAhy+GEY9kyd1U7E1qeXsUF+wQrm8L9Nz9T4TVOr
         leL30CL7qjcdtjFRqR1kf/SY+kPOgXkSQL5S25YBf6tb952guk0eH5yLSQa5H1ZKCrqQ
         hJc6NArevNHboU5/m5MK/0xBTanFbUhRJ/3mqZkqG6E34wF8WyO7P6IhtXLuRM589TNl
         y4wig1Tm8uCricEL3f13pss68RZ+0rfKEI0vlyocbyVi81vabaekkHK3mK3SP/JhTz2F
         QbKA==
X-Forwarded-Encrypted: i=1; AJvYcCVsG/6kSEx2EG9ICS8K2NoEt4jQa1qIHzMExmJt9kIZNBL0PKplgL5aRuBUca0KdI0wBFikKDkHPwWS3W+Y@vger.kernel.org
X-Gm-Message-State: AOJu0YynB4/zCb7y04oB/V3YNN7M1xfXkAtyFt6HAjSzwNuIzLdGzwlq
	rvskDMJbr3nxgTLcaR6pmI5WaQQmuHXRm7vnoaBgBNwEPhYQdHqN0TaSHUXngfhbt+LM+VM7tJ4
	OlqNNcv0jE1B+ghmscpZh3NKme+hSeQY=
X-Gm-Gg: ASbGncvvEzORFVbH+Pvjw0HJ1LiyQxlEZOC9yeMfKw/2am3qYDFFn5VKIHuBILRqo4C
	drbYhue+S3aix5aorJiXbd/kDi+xojUykSUUlZ9arvtW+h5Y+TsGltk/1EMEUdDO9W7YkZAQAEU
	WphNdUWG0KVzFUay5TCWvlokc7sve+7Rcsqq5OY9V5GnZgSJ6VCymNPT26HNbLmbSOH2uN9jHtr
	1WwIYbpZ/k3pYeTVA==
X-Google-Smtp-Source: AGHT+IGRwHDEgEzhfJwiBqYhcqLxNI1Do0J634Sv8BPtzoX3tfls31zFkDoYkPTgC35+qEAjTkpiECiH+3RvoAPOOzA=
X-Received: by 2002:a05:6402:1ecd:b0:62c:6a07:97d7 with SMTP id
 4fb4d7f45d1cf-62c6a079996mr9330783a12.34.1757589955854; Thu, 11 Sep 2025
 04:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909143053.112171-1-mszeredi@redhat.com> <fyvzypw7ywz4mmqd7vtw34wa7k6gsicvtsjro5mnu6uggy2aeg@3e4p7l3q6gfm>
In-Reply-To: <fyvzypw7ywz4mmqd7vtw34wa7k6gsicvtsjro5mnu6uggy2aeg@3e4p7l3q6gfm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 11 Sep 2025 13:25:44 +0200
X-Gm-Features: Ac12FXxTvzXk3ha_PPE8O8EjElg658vMYM92OeRxIshhv_lTk8KsdwauWokZm3Q
Message-ID: <CAOQ4uxhm30cSt=9BV9WEjfgv-fTNEgDCDQGKGBKZCsXO_NU0kQ@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify: add watchdog for permission events
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 12:12=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 09-09-25 16:30:47, Miklos Szeredi wrote:
> > This is to make it easier to debug issues with AV software, which time =
and
> > again deadlocks with no indication of where the issue comes from, and t=
he
> > kernel being blamed for the deadlock.  Then we need to analyze dumps to
> > prove that the kernel is not in fact at fault.
> >
> > The deadlock comes from recursion: handling the event triggers another
> > permission event, in some roundabout way, obviously, otherwise it would
> > have been found in testing.
> >
> > With this patch a warning is printed when permission event is received =
by
> > userspace but not answered for more than the timeout specified in
> > /proc/sys/fs/fanotify/watchdog_timeout.  The watchdog can be turned off=
 by
> > setting the timeout to zero (which is the default).
> >
> > The timeout is very coarse (T <=3D t < 2T) but I guess it's good enough=
 for
> > the purpose.
> >
> > Overhead should be minimal.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>
> Overall looks good. Just some nits below, I'll fix them up on commit if y=
ou
> won't object.

No comments beyond what you wrote.

Feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>
> > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotif=
y.h
> > index b78308975082..1a007e211bae 100644
> > --- a/fs/notify/fanotify/fanotify.h
> > +++ b/fs/notify/fanotify/fanotify.h
> > @@ -437,11 +437,13 @@ FANOTIFY_ME(struct fanotify_event *event)
> >  struct fanotify_perm_event {
> >       struct fanotify_event fae;
> >       struct path path;
> > -     const loff_t *ppos;             /* optional file range info */
> > +     const loff_t *ppos;     /* optional file range info */
>
> Stray modification.
>
> >       size_t count;
> >       u32 response;                   /* userspace answer to the event =
*/
> >       unsigned short state;           /* state of the event */
> > +     unsigned short watchdog_cnt;    /* already scanned by watchdog? *=
/
> >       int fd;         /* fd we passed to userspace for this event */
> > +     pid_t recv_pid; /* pid of task receiving the event */
> >       union {
> >               struct fanotify_response_info_header hdr;
> >               struct fanotify_response_info_audit_rule audit_rule;
> ...
> > @@ -95,6 +104,84 @@ static void __init fanotify_sysctls_init(void)
> >  #define fanotify_sysctls_init() do { } while (0)
> >  #endif /* CONFIG_SYSCTL */
> >
> > +static LIST_HEAD(perm_group_list);
> > +static DEFINE_SPINLOCK(perm_group_lock);
> > +static void perm_group_watchdog(struct work_struct *work);
> > +static DECLARE_DELAYED_WORK(perm_group_work, perm_group_watchdog);
> > +
> > +static void perm_group_watchdog_schedule(void)
> > +{
> > +     schedule_delayed_work(&perm_group_work, secs_to_jiffies(perm_grou=
p_timeout));
> > +}
> > +
> > +static void perm_group_watchdog(struct work_struct *work)
> > +{
> > +     struct fsnotify_group *group;
> > +     struct fanotify_perm_event *event;
> > +     struct task_struct *task;
> > +     pid_t failed_pid =3D 0;
> > +
> > +     guard(spinlock)(&perm_group_lock);
> > +     if (list_empty(&perm_group_list))
> > +             return;
> > +
> > +     list_for_each_entry(group, &perm_group_list, fanotify_data.perm_g=
roup) {
> > +             /*
> > +              * Ok to test without lock, racing with an addition is
> > +              * fine, will deal with it next round
> > +              */
> > +             if (list_empty(&group->fanotify_data.access_list))
> > +                     continue;
> > +
> > +             scoped_guard(spinlock, &group->notification_lock) {
>
> Frankly, I don't see the scoped guard bringing benefit here. It just shif=
ts
> indentation level by 1 which makes some of the lines below longer than I
> like :)
>
> > +                     list_for_each_entry(event, &group->fanotify_data.=
access_list, fae.fse.list) {
> > +                             if (likely(event->watchdog_cnt =3D=3D 0))=
 {
> > +                                     event->watchdog_cnt =3D 1;
> > +                             } else if (event->watchdog_cnt =3D=3D 1) =
{
> > +                                     /* Report on event only once */
> > +                                     event->watchdog_cnt =3D 2;
> > +
> > +                                     /* Do not report same pid repeate=
dly */
> > +                                     if (event->recv_pid =3D=3D failed=
_pid)
> > +                                             continue;
> > +
> > +                                     failed_pid =3D event->recv_pid;
> > +                                     rcu_read_lock();
> > +                                     task =3D find_task_by_pid_ns(even=
t->recv_pid, &init_pid_ns);
> > +                                     pr_warn_ratelimited("PID %u (%s) =
failed to respond to fanotify queue for more than %i seconds\n",
>
> Use %d instead of %i here? IMHO we use %d everywhere in the kernel. I had
> to look up whether %i is really signed int.
>
> > +                                                         event->recv_p=
id, task ? task->comm : NULL, perm_group_timeout);
> > +                                     rcu_read_unlock();
> > +                             }
> > +                     }
>
> I'm wondering if we should cond_resched() somewhere in these loops. There
> could be *many* events pending... OTOH continuing the iteration afterward=
s
> would be non-trivial so probably let's keep our fingers crossed that
> softlockups won't trigger...
>
> > +             }
> > +     }
> > +     perm_group_watchdog_schedule();
> > +}
> > +
> > +static void fanotify_perm_watchdog_group_remove(struct fsnotify_group =
*group)
> > +{
> > +     if (!list_empty(&group->fanotify_data.perm_group)) {
> > +             /* Perm event watchdog can no longer scan this group. */
> > +             spin_lock(&perm_group_lock);
> > +             list_del(&group->fanotify_data.perm_group);
>
> list_del_init() here would give me a better peace of mind... It's not lik=
e
> the performance matters here.
>
> > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_=
backend.h
> > index d4034ddaf392..7f7fe4f3aa34 100644
> > --- a/include/linux/fsnotify_backend.h
> > +++ b/include/linux/fsnotify_backend.h
> > @@ -273,6 +273,8 @@ struct fsnotify_group {
> >                       int f_flags; /* event_f_flags from fanotify_init(=
) */
> >                       struct ucounts *ucounts;
> >                       mempool_t error_events_pool;
> > +                     /* chained on perm_group_list */
> > +                     struct list_head perm_group;
>
> Can we call this perm_group_list, perm_list or simply something with 'lis=
t'
> in the name, please? We follow this naming convention throughout the
> fsnotify subsystem.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

