Return-Path: <linux-fsdevel+bounces-37126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCED9EDEE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 06:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D8C283B3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 05:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C271A178383;
	Thu, 12 Dec 2024 05:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3AsfZhG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0A116DC28
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 05:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981247; cv=none; b=obyTlOzus9124ti4ymJHfb3H27V1Q3Kb+N2DpJi5NSGG9N/eHADjZAZ4cKb2JLkf8wSit5aKknIBiqvIMPyKQqsrccygq9wILuKlnJz93EmKb18B7HDL9d02wC+sdvehoreQIKo/AisuVR0qmx5soHAlUtAB52SIrYZ4wU4/E88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981247; c=relaxed/simple;
	bh=mxdZPsVyYyV7cuEIEhtiSTGvxYSD89VNwiN57oLsYH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxVIb2I4gxihMiT85cJTDwe9fztkGGgkhxLbTWlwa5L8ftzho8I2vOEaaKBAo8fRQVVF8AUWawWwJhMe3UrCpx0kTR5zGw3HRss8uq9bAF+KtTvO4zLwt0fyrvgoktpQ90CR9/5BD5fDzTnRY7yMYNbNHXvF+hCC/1BPXpYpi+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3AsfZhG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so230114a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 21:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733981243; x=1734586043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1pNrpiGH+kFOsv2NX0sznySy3UL+5fKk10p0E+hdW8=;
        b=P3AsfZhGAMPGXk+cVKaD500TI1p2UtMEBbcWB+KgnknqexlqjccBKvphR653mQJgeV
         J2PFwMCsBMh7feT8yqHGmA4bPxN2CyLznFtsK9HATHxb7A9DBdCsVpdlikN3y+5n2uQF
         MDUEhW4U0sDPpIR98FPjkvV1yxNSDhEyGbnEW9VvfpPnB4xIlXU3OGxnao5q324TedCt
         Cab8ioNqVmXIifq993lX4x0TAgEv5rAs/hqSc+XglY033kqO1KormhVlFSlYpfFa2L5C
         RUvd/sRoeyxbY0W23VVl3r2jNCyxTJnqGOOgBbIgxf/Ei+C8W7thozZ6KXdI0i8qs8gI
         yRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733981243; x=1734586043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1pNrpiGH+kFOsv2NX0sznySy3UL+5fKk10p0E+hdW8=;
        b=RJQhF3eWW9qR4xn0QNT3Z4k3OpApLi/qQm+csAsTp0vBPHfR2URRqruUXfaf3Rpkik
         +U/uqnut3UUPQE+eekpCgTgddHU9phrZpewFFcT5i2GBOCnEOO5ixCiIWT/lVOLcdpY3
         k6QiAg9qxDMqMnHjuFLprvJXnlRfQqtXGiscFdI0ikhMs3E86fcsVDJcHiKmmbTJaAhh
         WZH+I0PspjJFFlA7wLW1salrUAOS+3r31ch6JQ8efR87om7wqJcCKxCRLmvBiFbb0JnT
         ISbst/cWKF28vwUgNciOncSrj9P/JEL+tp+6cVu3nUp1bMFY6prjSc3JvmD1mO+jCJG6
         WqOw==
X-Forwarded-Encrypted: i=1; AJvYcCVWgIfqSFRJ72xSM0/aifEDFgfJemZdCTvtvlI3UIsRxdlF58HKi63yffwPQRvP1zJbYpj8PkMiOeWRosN4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+QZ7gIn4gIg5ASosmeuesYNJ2/Gsppbql1KSESw2OYhkkN2S9
	pTbpQ7LoqKwwjVirnHs1POreLC7cwEGHnRRgzYpIA014L0e6uooxHk5ezjR5fEu5LM4PYOI6kF0
	BFOa9CYH9JykX/vfC++wkv3nt8lM=
X-Gm-Gg: ASbGncuqIghuVuqiUJJyAB+H67oPJetFExdxAMGOFEErZKZePm3U6gtRmOPashkLnez
	vLPw4OBF6kXHBgMbDAN1Npq4LSfGCASWwgAt5oQ==
X-Google-Smtp-Source: AGHT+IEiMlL8Wh3S46NOWayIL9iR61EuH+OWEimzhZgRDvBpCe0ezCJP6j/qe7/JkF8C6dKk0MGp5cZBzQhSOexTBRo=
X-Received: by 2002:a05:6402:40ca:b0:5cf:c0d2:698 with SMTP id
 4fb4d7f45d1cf-5d433109174mr6086416a12.18.1733981242986; Wed, 11 Dec 2024
 21:27:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211194522.31977-1-etmartin4313@gmail.com>
 <20241211194522.31977-2-etmartin4313@gmail.com> <CAJnrk1bE5UxUC1R1+FpPBt_BTPcO_E9A6n6684rEpGOC4xBvNw@mail.gmail.com>
 <CAMHPp_SqSRRpZO8j6TTskrCCjoRNcco+3mceUHwUxQ0aG_0G-A@mail.gmail.com>
In-Reply-To: <CAMHPp_SqSRRpZO8j6TTskrCCjoRNcco+3mceUHwUxQ0aG_0G-A@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 12 Dec 2024 13:26:46 +0800
Message-ID: <CAK1f24=SjvSg0EFjvB29zUySRN7BR4O45XkcsL5Ob8jLebYTaQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Abort connection if FUSE server get stuck
To: Etienne Martineau <etmartin4313@gmail.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	miklos@szeredi.hu, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, laoar.shao@gmail.com, senozhatsky@chromium.org, 
	etmartin@cisco.com, joel.granados@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 7:04=E2=80=AFAM Etienne Martineau
<etmartin4313@gmail.com> wrote:
>
> On Wed, Dec 11, 2024 at 5:04=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > On Wed, Dec 11, 2024 at 11:45=E2=80=AFAM <etmartin4313@gmail.com> wrote=
:
> > >
> > > From: Etienne Martineau <etmartin4313@gmail.com>
> > >
> > > This patch abort connection if HUNG_TASK_PANIC is set and a FUSE serv=
er
> > > is getting stuck for too long. A slow FUSE server may tripped the

A FUSE server is getting stuck for longer than hung_task_timeout_secs
(the default is two minutes). Is it not buggy in the real-world?

> > > hang check timer for legitimate reasons hence consider disabling
> > > HUNG_TASK_PANIC in that scenario.

Why not just consider increasing hung_task_timeout_secs if necessary?

> > >
> > > Without this patch, an unresponsive / buggy / malicious FUSE server c=
an
> > > leave the clients in D state for a long period of time and on system =
where
> > > HUNG_TASK_PANIC is set, trigger a catastrophic reload.

Sorry, I don't see any sense in knowing whether HUNG_TASK_PANIC is enabled =
for
FUSE servers. Or am I possibly missing something important?

If HUNG_TASK_PANIC is set, we should do a reload when a hung task is detect=
ed;
this is working as expected IHMO.

Thanks,
Lance

> > >
> > > So, if HUNG_TASK_PANIC checking is enabled, we should wake up periodi=
cally
> > > to abort connections that exceed the timeout value which is define to=
 be
> > > half the HUNG_TASK_TIMEOUT period, which keeps overhead low. The time=
r
> > > is per connection and runs only if there are active FUSE request pend=
ing.
> >
> > Hi Etienne,
> >
> > For your use case, does the generic request timeouts logic and
> > max_request_timeout systemctl implemented in [1] and [2] not suffice?
> > IMO I don't think we should have logic specifically checking for hung
> > task timeouts in fuse, if the generic solution can be used.
> >
> > Thanks,
> > Joanne
>
> We need a way to avoid catastrophic reloads on systems where HUNG_TASK_PA=
NIC
> is set while a buggy / malicious FUSE server stops responding.
> I would argue that this is much needed in stable branches as well...
>
> For that reason, I believe we need to keep things simple for step #1
> e.g. there is no
> need to introduce another knob as we already have HUNG_TASK_TIMEOUT which
> holds the source of truth.
>
> IMO introducing those new knobs will put an unnecessary burden on sysadmi=
ns into
> something that is error prone because unlike
>   CONFIG_DETECT_HUNG_TASK=3Dy
>   CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
> which is built-in, the "default_request_timeout" /
> "max_request_timeout" needs to be
> set appropriately after every reboot and failure to do so may have
> nasty consequences.
>
> For the more generic cases then yes those timeouts make sense to me.
>
> Thanks,
> Etienne
>
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20241114191332.669127-1-joann=
elkoong@gmail.com/
> > [2] https://lore.kernel.org/linux-fsdevel/20241114191332.669127-4-joann=
elkoong@gmail.com/
> >
> > >
> > > A FUSE client can get into D state as such ( see below scenario #1 / =
#2 )
> > >  1) request_wait_answer() -> wait_event() is UNINTERRUPTIBLE
> > >     OR
> > >  2) request_wait_answer() -> wait_event_(interruptible / killable) is=
 head
> > >     of line blocking for subsequent clients accessing the same file
> > >
> > >         scenario #1:
> > >         2716 pts/2    D+     0:00 cat
> > >         $ cat /proc/2716/stack
> > >                 [<0>] request_wait_answer+0x22e/0x340
> > >                 [<0>] __fuse_simple_request+0xd8/0x2c0
> > >                 [<0>] fuse_perform_write+0x3ec/0x760
> > >                 [<0>] fuse_file_write_iter+0x3d5/0x3f0
> > >                 [<0>] vfs_write+0x313/0x430
> > >                 [<0>] ksys_write+0x6a/0xf0
> > >                 [<0>] __x64_sys_write+0x19/0x30
> > >                 [<0>] x64_sys_call+0x18ab/0x26f0
> > >                 [<0>] do_syscall_64+0x7c/0x170
> > >                 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >
> > >         scenario #2:
> > >         2962 pts/2    S+     0:00 cat
> > >         2963 pts/3    D+     0:00 cat
> > >         $ cat /proc/2962/stack
> > >                 [<0>] request_wait_answer+0x140/0x340
> > >                 [<0>] __fuse_simple_request+0xd8/0x2c0
> > >                 [<0>] fuse_perform_write+0x3ec/0x760
> > >                 [<0>] fuse_file_write_iter+0x3d5/0x3f0
> > >                 [<0>] vfs_write+0x313/0x430
> > >                 [<0>] ksys_write+0x6a/0xf0
> > >                 [<0>] __x64_sys_write+0x19/0x30
> > >                 [<0>] x64_sys_call+0x18ab/0x26f0
> > >                 [<0>] do_syscall_64+0x7c/0x170
> > >                 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >         $ cat /proc/2963/stack
> > >                 [<0>] fuse_file_write_iter+0x252/0x3f0
> > >                 [<0>] vfs_write+0x313/0x430
> > >                 [<0>] ksys_write+0x6a/0xf0
> > >                 [<0>] __x64_sys_write+0x19/0x30
> > >                 [<0>] x64_sys_call+0x18ab/0x26f0
> > >                 [<0>] do_syscall_64+0x7c/0x170
> > >                 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >
> > > Please note that this patch doesn't prevent the HUNG_TASK_WARNING.
> > >
> > > Signed-off-by: Etienne Martineau <etmartin4313@gmail.com>
> > > ---
> > >  fs/fuse/dev.c                | 100 +++++++++++++++++++++++++++++++++=
++
> > >  fs/fuse/fuse_i.h             |   8 +++
> > >  fs/fuse/inode.c              |   3 ++
> > >  include/linux/sched/sysctl.h |   8 ++-
> > >  kernel/hung_task.c           |   3 +-
> > >  5 files changed, 119 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > index 27ccae63495d..73d19de14e51 100644
> > > --- a/fs/fuse/dev.c
> > > +++ b/fs/fuse/dev.c
> > > @@ -21,6 +21,8 @@
> > >  #include <linux/swap.h>
> > >  #include <linux/splice.h>
> > >  #include <linux/sched.h>
> > > +#include <linux/completion.h>
> > > +#include <linux/sched/sysctl.h>
> > >
> > >  #define CREATE_TRACE_POINTS
> > >  #include "fuse_trace.h"
> > > @@ -45,14 +47,104 @@ static struct fuse_dev *fuse_get_dev(struct file=
 *file)
> > >         return READ_ONCE(file->private_data);
> > >  }
> > >
> > > +static bool request_expired(struct fuse_conn *fc, struct fuse_req *r=
eq,
> > > +               int timeout)
> > > +{
> > > +       return time_after(jiffies, req->create_time + timeout);
> > > +}
> > > +
> > > +/*
> > > + * Prevent hung task timer from firing at us
> > > + * Check if any requests aren't being completed by the specified req=
uest
> > > + * timeout. To do so, we:
> > > + * - check the fiq pending list
> > > + * - check the bg queue
> > > + * - check the fpq io and processing lists
> > > + *
> > > + * To make this fast, we only check against the head request on each=
 list since
> > > + * these are generally queued in order of creation time (eg newer re=
quests get
> > > + * queued to the tail). We might miss a few edge cases (eg requests =
transitioning
> > > + * between lists, re-sent requests at the head of the pending list h=
aving a
> > > + * later creation time than other requests on that list, etc.) but t=
hat is fine
> > > + * since if the request never gets fulfilled, it will eventually be =
caught.
> > > + */
> > > +void fuse_check_timeout(struct work_struct *wk)
> > > +{
> > > +       unsigned long hang_check_timer =3D sysctl_hung_task_timeout_s=
ecs * (HZ / 2);
> > > +       struct fuse_conn *fc =3D container_of(wk, struct fuse_conn, w=
ork.work);
> > > +       struct fuse_iqueue *fiq =3D &fc->iq;
> > > +       struct fuse_req *req;
> > > +       struct fuse_dev *fud;
> > > +       struct fuse_pqueue *fpq;
> > > +       bool expired =3D false;
> > > +       int i;
> > > +
> > > +       spin_lock(&fiq->lock);
> > > +       req =3D list_first_entry_or_null(&fiq->pending, struct fuse_r=
eq, list);
> > > +       if (req)
> > > +               expired =3D request_expired(fc, req, hang_check_timer=
);
> > > +       spin_unlock(&fiq->lock);
> > > +       if (expired)
> > > +               goto abort_conn;
> > > +
> > > +       spin_lock(&fc->bg_lock);
> > > +       req =3D list_first_entry_or_null(&fc->bg_queue, struct fuse_r=
eq, list);
> > > +       if (req)
> > > +               expired =3D request_expired(fc, req, hang_check_timer=
);
> > > +       spin_unlock(&fc->bg_lock);
> > > +       if (expired)
> > > +               goto abort_conn;
> > > +
> > > +       spin_lock(&fc->lock);
> > > +       if (!fc->connected) {
> > > +               spin_unlock(&fc->lock);
> > > +               return;
> > > +       }
> > > +       list_for_each_entry(fud, &fc->devices, entry) {
> > > +               fpq =3D &fud->pq;
> > > +               spin_lock(&fpq->lock);
> > > +               req =3D list_first_entry_or_null(&fpq->io, struct fus=
e_req, list);
> > > +               if (req && request_expired(fc, req, hang_check_timer)=
)
> > > +                       goto fpq_abort;
> > > +
> > > +               for (i =3D 0; i < FUSE_PQ_HASH_SIZE; i++) {
> > > +                       req =3D list_first_entry_or_null(&fpq->proces=
sing[i], struct fuse_req, list);
> > > +                       if (req && request_expired(fc, req, hang_chec=
k_timer))
> > > +                               goto fpq_abort;
> > > +               }
> > > +               spin_unlock(&fpq->lock);
> > > +       }
> > > +       /* Keep the ball rolling */
> > > +       if (atomic_read(&fc->num_waiting) !=3D 0)
> > > +               queue_delayed_work(system_wq, &fc->work, hang_check_t=
imer);
> > > +       spin_unlock(&fc->lock);
> > > +       return;
> > > +
> > > +fpq_abort:
> > > +       spin_unlock(&fpq->lock);
> > > +       spin_unlock(&fc->lock);
> > > +abort_conn:
> > > +       fuse_abort_conn(fc);
> > > +}
> > > +
> > >  static void fuse_request_init(struct fuse_mount *fm, struct fuse_req=
 *req)
> > >  {
> > > +       struct fuse_conn *fc =3D fm->fc;
> > >         INIT_LIST_HEAD(&req->list);
> > >         INIT_LIST_HEAD(&req->intr_entry);
> > >         init_waitqueue_head(&req->waitq);
> > >         refcount_set(&req->count, 1);
> > >         __set_bit(FR_PENDING, &req->flags);
> > >         req->fm =3D fm;
> > > +       req->create_time =3D jiffies;
> > > +
> > > +       if (sysctl_hung_task_panic) {
> > > +               spin_lock(&fc->lock);
> > > +               /* Get the ball rolling */
> > > +               queue_delayed_work(system_wq, &fc->work,
> > > +                               sysctl_hung_task_timeout_secs * (HZ /=
 2));
> > > +               spin_unlock(&fc->lock);
> > > +       }
> > >  }
> > >
> > >  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gf=
p_t flags)
> > > @@ -200,6 +292,14 @@ static void fuse_put_request(struct fuse_req *re=
q)
> > >                         fuse_drop_waiting(fc);
> > >                 }
> > >
> > > +               if (sysctl_hung_task_panic) {
> > > +                       spin_lock(&fc->lock);
> > > +                       /* Stop the timeout check if we are the last =
request */
> > > +                       if (atomic_read(&fc->num_waiting) =3D=3D 0)
> > > +                               cancel_delayed_work_sync(&fc->work);
> > > +                       spin_unlock(&fc->lock);
> > > +               }
> > > +
> > >                 fuse_request_free(req);
> > >         }
> > >  }
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > index 74744c6f2860..aba3ffd0fb67 100644
> > > --- a/fs/fuse/fuse_i.h
> > > +++ b/fs/fuse/fuse_i.h
> > > @@ -438,6 +438,9 @@ struct fuse_req {
> > >
> > >         /** fuse_mount this request belongs to */
> > >         struct fuse_mount *fm;
> > > +
> > > +       /** When (in jiffies) the request was created */
> > > +       unsigned long create_time;
> > >  };
> > >
> > >  struct fuse_iqueue;
> > > @@ -923,6 +926,9 @@ struct fuse_conn {
> > >         /** IDR for backing files ids */
> > >         struct idr backing_files_map;
> > >  #endif
> > > +
> > > +       /** Request wait timeout check */
> > > +       struct delayed_work work;
> > >  };
> > >
> > >  /*
> > > @@ -1190,6 +1196,8 @@ void fuse_request_end(struct fuse_req *req);
> > >  /* Abort all requests */
> > >  void fuse_abort_conn(struct fuse_conn *fc);
> > >  void fuse_wait_aborted(struct fuse_conn *fc);
> > > +/* Connection timeout */
> > > +void fuse_check_timeout(struct work_struct *wk);
> > >
> > >  /**
> > >   * Invalidate inode attributes
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index 3ce4f4e81d09..ed96154df0fd 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -23,6 +23,7 @@
> > >  #include <linux/exportfs.h>
> > >  #include <linux/posix_acl.h>
> > >  #include <linux/pid_namespace.h>
> > > +#include <linux/completion.h>
> > >  #include <uapi/linux/magic.h>
> > >
> > >  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> > > @@ -964,6 +965,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct =
fuse_mount *fm,
> > >         INIT_LIST_HEAD(&fc->entry);
> > >         INIT_LIST_HEAD(&fc->devices);
> > >         atomic_set(&fc->num_waiting, 0);
> > > +       INIT_DELAYED_WORK(&fc->work, fuse_check_timeout);
> > >         fc->max_background =3D FUSE_DEFAULT_MAX_BACKGROUND;
> > >         fc->congestion_threshold =3D FUSE_DEFAULT_CONGESTION_THRESHOL=
D;
> > >         atomic64_set(&fc->khctr, 0);
> > > @@ -1015,6 +1017,7 @@ void fuse_conn_put(struct fuse_conn *fc)
> > >                 if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> > >                         fuse_backing_files_free(fc);
> > >                 call_rcu(&fc->rcu, delayed_release);
> > > +               cancel_delayed_work_sync(&fc->work);
> > >         }
> > >  }
> > >  EXPORT_SYMBOL_GPL(fuse_conn_put);
> > > diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysct=
l.h
> > > index 5a64582b086b..1ed3a511060d 100644
> > > --- a/include/linux/sched/sysctl.h
> > > +++ b/include/linux/sched/sysctl.h
> > > @@ -5,11 +5,15 @@
> > >  #include <linux/types.h>
> > >
> > >  #ifdef CONFIG_DETECT_HUNG_TASK
> > > -/* used for hung_task and block/ */
> > > +/* used for hung_task, block/ and fuse */
> > >  extern unsigned long sysctl_hung_task_timeout_secs;
> > > +extern unsigned int sysctl_hung_task_panic;
> > >  #else
> > >  /* Avoid need for ifdefs elsewhere in the code */
> > > -enum { sysctl_hung_task_timeout_secs =3D 0 };
> > > +enum {
> > > +       sysctl_hung_task_timeout_secs =3D 0,
> > > +       sysctl_hung_task_panic =3D 0,
> > > +};
> > >  #endif
> > >
> > >  enum sched_tunable_scaling {
> > > diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> > > index c18717189f32..16602d3754b1 100644
> > > --- a/kernel/hung_task.c
> > > +++ b/kernel/hung_task.c
> > > @@ -78,8 +78,9 @@ static unsigned int __read_mostly sysctl_hung_task_=
all_cpu_backtrace;
> > >   * Should we panic (and reboot, if panic_timeout=3D is set) when a
> > >   * hung task is detected:
> > >   */
> > > -static unsigned int __read_mostly sysctl_hung_task_panic =3D
> > > +unsigned int __read_mostly sysctl_hung_task_panic =3D
> > >         IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
> > > +EXPORT_SYMBOL_GPL(sysctl_hung_task_panic);
> > >
> > >  static int
> > >  hung_task_panic(struct notifier_block *this, unsigned long event, vo=
id *ptr)
> > > --
> > > 2.34.1
> > >

