Return-Path: <linux-fsdevel+bounces-37112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D259F9EDAD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 00:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3B91687FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 23:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FCF1F237E;
	Wed, 11 Dec 2024 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzKjigxi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5198632B
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958289; cv=none; b=PytukAvW0FGEHNcuolKTLm5tNatlWNca2GggIbuoOiYbPEoePsbauenuVGKaN6tXdqA0hbx5ET34L7REaIHPmolnpL86tVaUg6pRuky2N3/YFpEjWM/Y6tY7GeDSFjU7dlS/xc/rRvyJZROyyXCBmmidvoPYvjNHeor+l9nvcpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958289; c=relaxed/simple;
	bh=DTMG6IdCrt5gSkFUor9GMPISAOkiGd6jQsnMneQszHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwz0hw62+3U6pEmPNtVOSpxyXSQwmyUr5boWK2RCneBNri0Gm31ioxJQ6fQWHqIZB9E753GMLjk4bVqF18FR+8wEjs6mViIqg+YiNRzNMf0otxbupBbKho5k35UAcDW4uAO7XoMon91OZpsK4oXUyjRxiqX1eOSGjL1KnBgkjXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzKjigxi; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46779ae3139so21483851cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 15:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733958286; x=1734563086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+E0tXVzmv0fe+8pCSGeUGCJ6xXxY5shDFgN7290oyo=;
        b=SzKjigxis+GPlk0QMIzlhDenR9fRVffGV0ZpjjD0pLUEJVKBad1AT8EEhtFIr4pV7S
         ydQEmgcGg3eHYGyvRj6IPeWAXDcGjW9w80ui6jAZ0hU1L1PTDgl0KgRBzCqgb8LAHutl
         +qCQGR4TIPIZ0Cue90Fsy0MNWK5LPHCIufR0TL222v6XBzVQP7JnJAdJ27rvYtygSlwV
         QFNRndGy7xtICsE97BJv45ZN4rSjwSYnCdZPch5+ncWQ/z/7zH7D1iVXImqv2i1yk9yY
         ChRqhe3VijojIz/a3wQgFWdD6ddCqIO/OE8OZLOCRz/YnGE11uMicBUZ5INfoDgXov5G
         STPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733958286; x=1734563086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+E0tXVzmv0fe+8pCSGeUGCJ6xXxY5shDFgN7290oyo=;
        b=fr7ywht57vMeg4zx7EYQWh9owqcxcBEitKqTHt4/1hFBobcogVi1gPBMblvG46fmFh
         Ov2zu2wIjXEW4FGczOV/ke6kBfVcUeAghesKwXS0mfaZ4HwH0MuyTEJdMMbkqOH/g0RT
         7T8YUwWvVhijqMGSOaULgZm/akp9uHBbqpo6WP4y5XLimpTJuJjcX73c4SKG/J9zYGRl
         gE6rmbbM2x6lpFa98sGpnOhbuDf4LwuritvqJF+8VpAU7PnLsad8XEjqwHQ08qfE2egd
         f/WO5xcdNjzIVBcc+xB4qcdIexb8j6ZDwFI/RGdMTkJtWgiRl7IwKQspYvCCPZNNEKyK
         +rTA==
X-Gm-Message-State: AOJu0YxWQ5EwKBkUgBxuLFUjBrj8VfKkKFHJ+pdAqi4HjBzB3EXX1xZ/
	/sxYqc0sg5MIeqa2tu4Bf5bWmSTki+vb+uNf78rJT/8byHiFgPYIrPbsPWW30oWDJnhTfcWkbOe
	25X/+tIR2Ykhbc+HQwU0B2Q1c8kM=
X-Gm-Gg: ASbGncvBAAl5PWZZJu0jh+dyH9XE+rM/EghSPyRBF5Oa6VexflVG3l/lsnz1ppF83P7
	6E7Jq5Kwr/K+y+T2IXr1wU+I6hz8zLHnKCRda6Og=
X-Google-Smtp-Source: AGHT+IFrCLzFgtkXfyApAQ+EDVfGhf5TAn8JLI7DSOcBA3GYDwQLkvHKlga1vMXwzg2hbF/hCEBWjHlzPclLZsntrDY=
X-Received: by 2002:a05:622a:1e1a:b0:460:4027:601 with SMTP id
 d75a77b69052e-4679614de4emr20799511cf.6.1733958286234; Wed, 11 Dec 2024
 15:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211194522.31977-1-etmartin4313@gmail.com>
 <20241211194522.31977-2-etmartin4313@gmail.com> <CAJnrk1bE5UxUC1R1+FpPBt_BTPcO_E9A6n6684rEpGOC4xBvNw@mail.gmail.com>
In-Reply-To: <CAJnrk1bE5UxUC1R1+FpPBt_BTPcO_E9A6n6684rEpGOC4xBvNw@mail.gmail.com>
From: Etienne Martineau <etmartin4313@gmail.com>
Date: Wed, 11 Dec 2024 18:04:34 -0500
Message-ID: <CAMHPp_SqSRRpZO8j6TTskrCCjoRNcco+3mceUHwUxQ0aG_0G-A@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Abort connection if FUSE server get stuck
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	laoar.shao@gmail.com, senozhatsky@chromium.org, etmartin@cisco.com, 
	"ioworker0@gmail.com" <ioworker0@gmail.com>, joel.granados@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:04=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Wed, Dec 11, 2024 at 11:45=E2=80=AFAM <etmartin4313@gmail.com> wrote:
> >
> > From: Etienne Martineau <etmartin4313@gmail.com>
> >
> > This patch abort connection if HUNG_TASK_PANIC is set and a FUSE server
> > is getting stuck for too long. A slow FUSE server may tripped the
> > hang check timer for legitimate reasons hence consider disabling
> > HUNG_TASK_PANIC in that scenario.
> >
> > Without this patch, an unresponsive / buggy / malicious FUSE server can
> > leave the clients in D state for a long period of time and on system wh=
ere
> > HUNG_TASK_PANIC is set, trigger a catastrophic reload.
> >
> > So, if HUNG_TASK_PANIC checking is enabled, we should wake up periodica=
lly
> > to abort connections that exceed the timeout value which is define to b=
e
> > half the HUNG_TASK_TIMEOUT period, which keeps overhead low. The timer
> > is per connection and runs only if there are active FUSE request pendin=
g.
>
> Hi Etienne,
>
> For your use case, does the generic request timeouts logic and
> max_request_timeout systemctl implemented in [1] and [2] not suffice?
> IMO I don't think we should have logic specifically checking for hung
> task timeouts in fuse, if the generic solution can be used.
>
> Thanks,
> Joanne

We need a way to avoid catastrophic reloads on systems where HUNG_TASK_PANI=
C
is set while a buggy / malicious FUSE server stops responding.
I would argue that this is much needed in stable branches as well...

For that reason, I believe we need to keep things simple for step #1
e.g. there is no
need to introduce another knob as we already have HUNG_TASK_TIMEOUT which
holds the source of truth.

IMO introducing those new knobs will put an unnecessary burden on sysadmins=
 into
something that is error prone because unlike
  CONFIG_DETECT_HUNG_TASK=3Dy
  CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
which is built-in, the "default_request_timeout" /
"max_request_timeout" needs to be
set appropriately after every reboot and failure to do so may have
nasty consequences.

For the more generic cases then yes those timeouts make sense to me.

Thanks,
Etienne

>
> [1] https://lore.kernel.org/linux-fsdevel/20241114191332.669127-1-joannel=
koong@gmail.com/
> [2] https://lore.kernel.org/linux-fsdevel/20241114191332.669127-4-joannel=
koong@gmail.com/
>
> >
> > A FUSE client can get into D state as such ( see below scenario #1 / #2=
 )
> >  1) request_wait_answer() -> wait_event() is UNINTERRUPTIBLE
> >     OR
> >  2) request_wait_answer() -> wait_event_(interruptible / killable) is h=
ead
> >     of line blocking for subsequent clients accessing the same file
> >
> >         scenario #1:
> >         2716 pts/2    D+     0:00 cat
> >         $ cat /proc/2716/stack
> >                 [<0>] request_wait_answer+0x22e/0x340
> >                 [<0>] __fuse_simple_request+0xd8/0x2c0
> >                 [<0>] fuse_perform_write+0x3ec/0x760
> >                 [<0>] fuse_file_write_iter+0x3d5/0x3f0
> >                 [<0>] vfs_write+0x313/0x430
> >                 [<0>] ksys_write+0x6a/0xf0
> >                 [<0>] __x64_sys_write+0x19/0x30
> >                 [<0>] x64_sys_call+0x18ab/0x26f0
> >                 [<0>] do_syscall_64+0x7c/0x170
> >                 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> >         scenario #2:
> >         2962 pts/2    S+     0:00 cat
> >         2963 pts/3    D+     0:00 cat
> >         $ cat /proc/2962/stack
> >                 [<0>] request_wait_answer+0x140/0x340
> >                 [<0>] __fuse_simple_request+0xd8/0x2c0
> >                 [<0>] fuse_perform_write+0x3ec/0x760
> >                 [<0>] fuse_file_write_iter+0x3d5/0x3f0
> >                 [<0>] vfs_write+0x313/0x430
> >                 [<0>] ksys_write+0x6a/0xf0
> >                 [<0>] __x64_sys_write+0x19/0x30
> >                 [<0>] x64_sys_call+0x18ab/0x26f0
> >                 [<0>] do_syscall_64+0x7c/0x170
> >                 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >         $ cat /proc/2963/stack
> >                 [<0>] fuse_file_write_iter+0x252/0x3f0
> >                 [<0>] vfs_write+0x313/0x430
> >                 [<0>] ksys_write+0x6a/0xf0
> >                 [<0>] __x64_sys_write+0x19/0x30
> >                 [<0>] x64_sys_call+0x18ab/0x26f0
> >                 [<0>] do_syscall_64+0x7c/0x170
> >                 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > Please note that this patch doesn't prevent the HUNG_TASK_WARNING.
> >
> > Signed-off-by: Etienne Martineau <etmartin4313@gmail.com>
> > ---
> >  fs/fuse/dev.c                | 100 +++++++++++++++++++++++++++++++++++
> >  fs/fuse/fuse_i.h             |   8 +++
> >  fs/fuse/inode.c              |   3 ++
> >  include/linux/sched/sysctl.h |   8 ++-
> >  kernel/hung_task.c           |   3 +-
> >  5 files changed, 119 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 27ccae63495d..73d19de14e51 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -21,6 +21,8 @@
> >  #include <linux/swap.h>
> >  #include <linux/splice.h>
> >  #include <linux/sched.h>
> > +#include <linux/completion.h>
> > +#include <linux/sched/sysctl.h>
> >
> >  #define CREATE_TRACE_POINTS
> >  #include "fuse_trace.h"
> > @@ -45,14 +47,104 @@ static struct fuse_dev *fuse_get_dev(struct file *=
file)
> >         return READ_ONCE(file->private_data);
> >  }
> >
> > +static bool request_expired(struct fuse_conn *fc, struct fuse_req *req=
,
> > +               int timeout)
> > +{
> > +       return time_after(jiffies, req->create_time + timeout);
> > +}
> > +
> > +/*
> > + * Prevent hung task timer from firing at us
> > + * Check if any requests aren't being completed by the specified reque=
st
> > + * timeout. To do so, we:
> > + * - check the fiq pending list
> > + * - check the bg queue
> > + * - check the fpq io and processing lists
> > + *
> > + * To make this fast, we only check against the head request on each l=
ist since
> > + * these are generally queued in order of creation time (eg newer requ=
ests get
> > + * queued to the tail). We might miss a few edge cases (eg requests tr=
ansitioning
> > + * between lists, re-sent requests at the head of the pending list hav=
ing a
> > + * later creation time than other requests on that list, etc.) but tha=
t is fine
> > + * since if the request never gets fulfilled, it will eventually be ca=
ught.
> > + */
> > +void fuse_check_timeout(struct work_struct *wk)
> > +{
> > +       unsigned long hang_check_timer =3D sysctl_hung_task_timeout_sec=
s * (HZ / 2);
> > +       struct fuse_conn *fc =3D container_of(wk, struct fuse_conn, wor=
k.work);
> > +       struct fuse_iqueue *fiq =3D &fc->iq;
> > +       struct fuse_req *req;
> > +       struct fuse_dev *fud;
> > +       struct fuse_pqueue *fpq;
> > +       bool expired =3D false;
> > +       int i;
> > +
> > +       spin_lock(&fiq->lock);
> > +       req =3D list_first_entry_or_null(&fiq->pending, struct fuse_req=
, list);
> > +       if (req)
> > +               expired =3D request_expired(fc, req, hang_check_timer);
> > +       spin_unlock(&fiq->lock);
> > +       if (expired)
> > +               goto abort_conn;
> > +
> > +       spin_lock(&fc->bg_lock);
> > +       req =3D list_first_entry_or_null(&fc->bg_queue, struct fuse_req=
, list);
> > +       if (req)
> > +               expired =3D request_expired(fc, req, hang_check_timer);
> > +       spin_unlock(&fc->bg_lock);
> > +       if (expired)
> > +               goto abort_conn;
> > +
> > +       spin_lock(&fc->lock);
> > +       if (!fc->connected) {
> > +               spin_unlock(&fc->lock);
> > +               return;
> > +       }
> > +       list_for_each_entry(fud, &fc->devices, entry) {
> > +               fpq =3D &fud->pq;
> > +               spin_lock(&fpq->lock);
> > +               req =3D list_first_entry_or_null(&fpq->io, struct fuse_=
req, list);
> > +               if (req && request_expired(fc, req, hang_check_timer))
> > +                       goto fpq_abort;
> > +
> > +               for (i =3D 0; i < FUSE_PQ_HASH_SIZE; i++) {
> > +                       req =3D list_first_entry_or_null(&fpq->processi=
ng[i], struct fuse_req, list);
> > +                       if (req && request_expired(fc, req, hang_check_=
timer))
> > +                               goto fpq_abort;
> > +               }
> > +               spin_unlock(&fpq->lock);
> > +       }
> > +       /* Keep the ball rolling */
> > +       if (atomic_read(&fc->num_waiting) !=3D 0)
> > +               queue_delayed_work(system_wq, &fc->work, hang_check_tim=
er);
> > +       spin_unlock(&fc->lock);
> > +       return;
> > +
> > +fpq_abort:
> > +       spin_unlock(&fpq->lock);
> > +       spin_unlock(&fc->lock);
> > +abort_conn:
> > +       fuse_abort_conn(fc);
> > +}
> > +
> >  static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *=
req)
> >  {
> > +       struct fuse_conn *fc =3D fm->fc;
> >         INIT_LIST_HEAD(&req->list);
> >         INIT_LIST_HEAD(&req->intr_entry);
> >         init_waitqueue_head(&req->waitq);
> >         refcount_set(&req->count, 1);
> >         __set_bit(FR_PENDING, &req->flags);
> >         req->fm =3D fm;
> > +       req->create_time =3D jiffies;
> > +
> > +       if (sysctl_hung_task_panic) {
> > +               spin_lock(&fc->lock);
> > +               /* Get the ball rolling */
> > +               queue_delayed_work(system_wq, &fc->work,
> > +                               sysctl_hung_task_timeout_secs * (HZ / 2=
));
> > +               spin_unlock(&fc->lock);
> > +       }
> >  }
> >
> >  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_=
t flags)
> > @@ -200,6 +292,14 @@ static void fuse_put_request(struct fuse_req *req)
> >                         fuse_drop_waiting(fc);
> >                 }
> >
> > +               if (sysctl_hung_task_panic) {
> > +                       spin_lock(&fc->lock);
> > +                       /* Stop the timeout check if we are the last re=
quest */
> > +                       if (atomic_read(&fc->num_waiting) =3D=3D 0)
> > +                               cancel_delayed_work_sync(&fc->work);
> > +                       spin_unlock(&fc->lock);
> > +               }
> > +
> >                 fuse_request_free(req);
> >         }
> >  }
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 74744c6f2860..aba3ffd0fb67 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -438,6 +438,9 @@ struct fuse_req {
> >
> >         /** fuse_mount this request belongs to */
> >         struct fuse_mount *fm;
> > +
> > +       /** When (in jiffies) the request was created */
> > +       unsigned long create_time;
> >  };
> >
> >  struct fuse_iqueue;
> > @@ -923,6 +926,9 @@ struct fuse_conn {
> >         /** IDR for backing files ids */
> >         struct idr backing_files_map;
> >  #endif
> > +
> > +       /** Request wait timeout check */
> > +       struct delayed_work work;
> >  };
> >
> >  /*
> > @@ -1190,6 +1196,8 @@ void fuse_request_end(struct fuse_req *req);
> >  /* Abort all requests */
> >  void fuse_abort_conn(struct fuse_conn *fc);
> >  void fuse_wait_aborted(struct fuse_conn *fc);
> > +/* Connection timeout */
> > +void fuse_check_timeout(struct work_struct *wk);
> >
> >  /**
> >   * Invalidate inode attributes
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 3ce4f4e81d09..ed96154df0fd 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/exportfs.h>
> >  #include <linux/posix_acl.h>
> >  #include <linux/pid_namespace.h>
> > +#include <linux/completion.h>
> >  #include <uapi/linux/magic.h>
> >
> >  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> > @@ -964,6 +965,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fu=
se_mount *fm,
> >         INIT_LIST_HEAD(&fc->entry);
> >         INIT_LIST_HEAD(&fc->devices);
> >         atomic_set(&fc->num_waiting, 0);
> > +       INIT_DELAYED_WORK(&fc->work, fuse_check_timeout);
> >         fc->max_background =3D FUSE_DEFAULT_MAX_BACKGROUND;
> >         fc->congestion_threshold =3D FUSE_DEFAULT_CONGESTION_THRESHOLD;
> >         atomic64_set(&fc->khctr, 0);
> > @@ -1015,6 +1017,7 @@ void fuse_conn_put(struct fuse_conn *fc)
> >                 if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> >                         fuse_backing_files_free(fc);
> >                 call_rcu(&fc->rcu, delayed_release);
> > +               cancel_delayed_work_sync(&fc->work);
> >         }
> >  }
> >  EXPORT_SYMBOL_GPL(fuse_conn_put);
> > diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.=
h
> > index 5a64582b086b..1ed3a511060d 100644
> > --- a/include/linux/sched/sysctl.h
> > +++ b/include/linux/sched/sysctl.h
> > @@ -5,11 +5,15 @@
> >  #include <linux/types.h>
> >
> >  #ifdef CONFIG_DETECT_HUNG_TASK
> > -/* used for hung_task and block/ */
> > +/* used for hung_task, block/ and fuse */
> >  extern unsigned long sysctl_hung_task_timeout_secs;
> > +extern unsigned int sysctl_hung_task_panic;
> >  #else
> >  /* Avoid need for ifdefs elsewhere in the code */
> > -enum { sysctl_hung_task_timeout_secs =3D 0 };
> > +enum {
> > +       sysctl_hung_task_timeout_secs =3D 0,
> > +       sysctl_hung_task_panic =3D 0,
> > +};
> >  #endif
> >
> >  enum sched_tunable_scaling {
> > diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> > index c18717189f32..16602d3754b1 100644
> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -78,8 +78,9 @@ static unsigned int __read_mostly sysctl_hung_task_al=
l_cpu_backtrace;
> >   * Should we panic (and reboot, if panic_timeout=3D is set) when a
> >   * hung task is detected:
> >   */
> > -static unsigned int __read_mostly sysctl_hung_task_panic =3D
> > +unsigned int __read_mostly sysctl_hung_task_panic =3D
> >         IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
> > +EXPORT_SYMBOL_GPL(sysctl_hung_task_panic);
> >
> >  static int
> >  hung_task_panic(struct notifier_block *this, unsigned long event, void=
 *ptr)
> > --
> > 2.34.1
> >

