Return-Path: <linux-fsdevel+bounces-37106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4C19ED947
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 23:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236D5282F52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 22:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0FE1F0E50;
	Wed, 11 Dec 2024 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juDa5SFr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9EB1F0E59
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 22:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954650; cv=none; b=lF2PBqh9m2gmNQxy/hj4mvsRuQtSWao4tzF4edffmnKiG8kwehYH/s7zkBrCf5Mx6KzCoZgGLXXQkxuyrgQg6SOlg2XmNE8DNnbk2P39R25IQXRyqwdAm+7snKdgGS7jsrEFRAaBlWV5hVyRQqAuMcG5kFGr7ou/Pf+xoC0iTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954650; c=relaxed/simple;
	bh=zIwBrciRJFklx3QIyP9FVah2SIik1TesgRpWg8DAdtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlCIzpK07+6jY89TZRdM8uxP6WHglWL3cR5ipsqZTfh8Y+rnwKyoXo6z6/Zc6geFDXv6B8O6kf1rCAmYY4KtsEewgU6Srw69igCaYEGHjx7Tfub7nU0hdGlFC9NSQkR2o/SYNEX9X/ujOHawEYqRn1rFbIfWKiVlILjpHc63veo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juDa5SFr; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-467631f3ae3so25032081cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 14:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733954648; x=1734559448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyzZJCX5BE0v+KBN4r0qd+4eEfcgirzmGS5XW8nfLmY=;
        b=juDa5SFr4IYAriJd7icFcexXrAGQ3wjrXRbA2kIq0DU4+28aTKCpSwSDAH8kbhLDy9
         GFd0NGymnp3V99rqJGkQEZeU72yr0ti7aIRzpZA6Dw6Pqna0DkBP6hLkmm2uBm1wc5hA
         889d0Yx14fBdFLEDkn3j07pLdWQ+GUEln8aFre4RNDT+Bow7nYpQ+XoY3pEY20QnA02K
         2JKR/DhROdX4/5kXKzgy9+YHZkmCdrzXB5sOM3o46Ah6mluoyRTeo57KwFwuNPF4x4NN
         mhg18Bn7ZBxiUHwNaYJb1UFz6HJPXN6e+ZdNIl+sKmXwegRjKhQtReuuUbN3nstvyhwg
         AFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954648; x=1734559448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyzZJCX5BE0v+KBN4r0qd+4eEfcgirzmGS5XW8nfLmY=;
        b=h8//kTQMFEC13F/E+hAylABXfMm+ObvBaHYCiNzjfH+gHQGvWsLmWqKIb1gweNty24
         jTeyLnKa72lAXcxDwYrlSu+7IZd0E48UttPK5S18knBt2uZdhbxs8BU6dESRpyqsXTPc
         7zq/o8BfRbMlTSkpKM+ib/1NcNqMJKo7UybL2TNE/Ff/P2fU8yrq6MlySHMpeW1boDFS
         IYoIU1mfVFrOpmLHaFVdOPXl22jxL1pShyD0EzyePZ4PDrlq0Rvh5sx4zfw0L2jjT0xv
         SXqbS9BJtiGu5HsO4ZEoXX1yNm9e4Q5CI48AXUrnJOmJsPOp/UTR0dk6slMJTBi7KbIx
         Fuwg==
X-Gm-Message-State: AOJu0YyXjLEiQ7VVDdrJdzZsLXZ2xwtWe0g5cJRrioh/skwON1TDC5tL
	IM6v4HBVnpPA2+5s1KCDw5PfA7yMTLB7SCRfbIxfHuGarwsg4WXEmZtk5uCH0k+HWxI6BR4W8Jr
	P5fGMeYe+XCPTQWaWh+ZyUuvID9g=
X-Gm-Gg: ASbGncuO43fseNfUjZvc7LcdtfU62yoByL6Q0wrUn8UCXHWENR9AL8bg1Ws+hJjgu92
	5loqQk/OZ+htnE3VkG31f43W1ZV5GseHvvUaVg18QyRLRnUX0v0s=
X-Google-Smtp-Source: AGHT+IFbQqJrbzIdxi76XVOzx+6J4YkR7qTYBvkek7offODcJBGJskYjiFfOlcVHmRtXwI32nodZvBi6rkkXLNgcXDA=
X-Received: by 2002:ac8:5d48:0:b0:467:87f6:383 with SMTP id
 d75a77b69052e-46796271493mr22151961cf.52.1733954647569; Wed, 11 Dec 2024
 14:04:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211194522.31977-1-etmartin4313@gmail.com> <20241211194522.31977-2-etmartin4313@gmail.com>
In-Reply-To: <20241211194522.31977-2-etmartin4313@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 11 Dec 2024 14:03:56 -0800
Message-ID: <CAJnrk1bE5UxUC1R1+FpPBt_BTPcO_E9A6n6684rEpGOC4xBvNw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Abort connection if FUSE server get stuck
To: etmartin4313@gmail.com
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	laoar.shao@gmail.com, senozhatsky@chromium.org, etmartin@cisco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 11:45=E2=80=AFAM <etmartin4313@gmail.com> wrote:
>
> From: Etienne Martineau <etmartin4313@gmail.com>
>
> This patch abort connection if HUNG_TASK_PANIC is set and a FUSE server
> is getting stuck for too long. A slow FUSE server may tripped the
> hang check timer for legitimate reasons hence consider disabling
> HUNG_TASK_PANIC in that scenario.
>
> Without this patch, an unresponsive / buggy / malicious FUSE server can
> leave the clients in D state for a long period of time and on system wher=
e
> HUNG_TASK_PANIC is set, trigger a catastrophic reload.
>
> So, if HUNG_TASK_PANIC checking is enabled, we should wake up periodicall=
y
> to abort connections that exceed the timeout value which is define to be
> half the HUNG_TASK_TIMEOUT period, which keeps overhead low. The timer
> is per connection and runs only if there are active FUSE request pending.

Hi Etienne,

For your use case, does the generic request timeouts logic and
max_request_timeout systemctl implemented in [1] and [2] not suffice?
IMO I don't think we should have logic specifically checking for hung
task timeouts in fuse, if the generic solution can be used.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20241114191332.669127-1-joannelko=
ong@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20241114191332.669127-4-joannelko=
ong@gmail.com/

>
> A FUSE client can get into D state as such ( see below scenario #1 / #2 )
>  1) request_wait_answer() -> wait_event() is UNINTERRUPTIBLE
>     OR
>  2) request_wait_answer() -> wait_event_(interruptible / killable) is hea=
d
>     of line blocking for subsequent clients accessing the same file
>
>         scenario #1:
>         2716 pts/2    D+     0:00 cat
>         $ cat /proc/2716/stack
>                 [<0>] request_wait_answer+0x22e/0x340
>                 [<0>] __fuse_simple_request+0xd8/0x2c0
>                 [<0>] fuse_perform_write+0x3ec/0x760
>                 [<0>] fuse_file_write_iter+0x3d5/0x3f0
>                 [<0>] vfs_write+0x313/0x430
>                 [<0>] ksys_write+0x6a/0xf0
>                 [<0>] __x64_sys_write+0x19/0x30
>                 [<0>] x64_sys_call+0x18ab/0x26f0
>                 [<0>] do_syscall_64+0x7c/0x170
>                 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>         scenario #2:
>         2962 pts/2    S+     0:00 cat
>         2963 pts/3    D+     0:00 cat
>         $ cat /proc/2962/stack
>                 [<0>] request_wait_answer+0x140/0x340
>                 [<0>] __fuse_simple_request+0xd8/0x2c0
>                 [<0>] fuse_perform_write+0x3ec/0x760
>                 [<0>] fuse_file_write_iter+0x3d5/0x3f0
>                 [<0>] vfs_write+0x313/0x430
>                 [<0>] ksys_write+0x6a/0xf0
>                 [<0>] __x64_sys_write+0x19/0x30
>                 [<0>] x64_sys_call+0x18ab/0x26f0
>                 [<0>] do_syscall_64+0x7c/0x170
>                 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>         $ cat /proc/2963/stack
>                 [<0>] fuse_file_write_iter+0x252/0x3f0
>                 [<0>] vfs_write+0x313/0x430
>                 [<0>] ksys_write+0x6a/0xf0
>                 [<0>] __x64_sys_write+0x19/0x30
>                 [<0>] x64_sys_call+0x18ab/0x26f0
>                 [<0>] do_syscall_64+0x7c/0x170
>                 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Please note that this patch doesn't prevent the HUNG_TASK_WARNING.
>
> Signed-off-by: Etienne Martineau <etmartin4313@gmail.com>
> ---
>  fs/fuse/dev.c                | 100 +++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h             |   8 +++
>  fs/fuse/inode.c              |   3 ++
>  include/linux/sched/sysctl.h |   8 ++-
>  kernel/hung_task.c           |   3 +-
>  5 files changed, 119 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 27ccae63495d..73d19de14e51 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -21,6 +21,8 @@
>  #include <linux/swap.h>
>  #include <linux/splice.h>
>  #include <linux/sched.h>
> +#include <linux/completion.h>
> +#include <linux/sched/sysctl.h>
>
>  #define CREATE_TRACE_POINTS
>  #include "fuse_trace.h"
> @@ -45,14 +47,104 @@ static struct fuse_dev *fuse_get_dev(struct file *fi=
le)
>         return READ_ONCE(file->private_data);
>  }
>
> +static bool request_expired(struct fuse_conn *fc, struct fuse_req *req,
> +               int timeout)
> +{
> +       return time_after(jiffies, req->create_time + timeout);
> +}
> +
> +/*
> + * Prevent hung task timer from firing at us
> + * Check if any requests aren't being completed by the specified request
> + * timeout. To do so, we:
> + * - check the fiq pending list
> + * - check the bg queue
> + * - check the fpq io and processing lists
> + *
> + * To make this fast, we only check against the head request on each lis=
t since
> + * these are generally queued in order of creation time (eg newer reques=
ts get
> + * queued to the tail). We might miss a few edge cases (eg requests tran=
sitioning
> + * between lists, re-sent requests at the head of the pending list havin=
g a
> + * later creation time than other requests on that list, etc.) but that =
is fine
> + * since if the request never gets fulfilled, it will eventually be caug=
ht.
> + */
> +void fuse_check_timeout(struct work_struct *wk)
> +{
> +       unsigned long hang_check_timer =3D sysctl_hung_task_timeout_secs =
* (HZ / 2);
> +       struct fuse_conn *fc =3D container_of(wk, struct fuse_conn, work.=
work);
> +       struct fuse_iqueue *fiq =3D &fc->iq;
> +       struct fuse_req *req;
> +       struct fuse_dev *fud;
> +       struct fuse_pqueue *fpq;
> +       bool expired =3D false;
> +       int i;
> +
> +       spin_lock(&fiq->lock);
> +       req =3D list_first_entry_or_null(&fiq->pending, struct fuse_req, =
list);
> +       if (req)
> +               expired =3D request_expired(fc, req, hang_check_timer);
> +       spin_unlock(&fiq->lock);
> +       if (expired)
> +               goto abort_conn;
> +
> +       spin_lock(&fc->bg_lock);
> +       req =3D list_first_entry_or_null(&fc->bg_queue, struct fuse_req, =
list);
> +       if (req)
> +               expired =3D request_expired(fc, req, hang_check_timer);
> +       spin_unlock(&fc->bg_lock);
> +       if (expired)
> +               goto abort_conn;
> +
> +       spin_lock(&fc->lock);
> +       if (!fc->connected) {
> +               spin_unlock(&fc->lock);
> +               return;
> +       }
> +       list_for_each_entry(fud, &fc->devices, entry) {
> +               fpq =3D &fud->pq;
> +               spin_lock(&fpq->lock);
> +               req =3D list_first_entry_or_null(&fpq->io, struct fuse_re=
q, list);
> +               if (req && request_expired(fc, req, hang_check_timer))
> +                       goto fpq_abort;
> +
> +               for (i =3D 0; i < FUSE_PQ_HASH_SIZE; i++) {
> +                       req =3D list_first_entry_or_null(&fpq->processing=
[i], struct fuse_req, list);
> +                       if (req && request_expired(fc, req, hang_check_ti=
mer))
> +                               goto fpq_abort;
> +               }
> +               spin_unlock(&fpq->lock);
> +       }
> +       /* Keep the ball rolling */
> +       if (atomic_read(&fc->num_waiting) !=3D 0)
> +               queue_delayed_work(system_wq, &fc->work, hang_check_timer=
);
> +       spin_unlock(&fc->lock);
> +       return;
> +
> +fpq_abort:
> +       spin_unlock(&fpq->lock);
> +       spin_unlock(&fc->lock);
> +abort_conn:
> +       fuse_abort_conn(fc);
> +}
> +
>  static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *re=
q)
>  {
> +       struct fuse_conn *fc =3D fm->fc;
>         INIT_LIST_HEAD(&req->list);
>         INIT_LIST_HEAD(&req->intr_entry);
>         init_waitqueue_head(&req->waitq);
>         refcount_set(&req->count, 1);
>         __set_bit(FR_PENDING, &req->flags);
>         req->fm =3D fm;
> +       req->create_time =3D jiffies;
> +
> +       if (sysctl_hung_task_panic) {
> +               spin_lock(&fc->lock);
> +               /* Get the ball rolling */
> +               queue_delayed_work(system_wq, &fc->work,
> +                               sysctl_hung_task_timeout_secs * (HZ / 2))=
;
> +               spin_unlock(&fc->lock);
> +       }
>  }
>
>  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t =
flags)
> @@ -200,6 +292,14 @@ static void fuse_put_request(struct fuse_req *req)
>                         fuse_drop_waiting(fc);
>                 }
>
> +               if (sysctl_hung_task_panic) {
> +                       spin_lock(&fc->lock);
> +                       /* Stop the timeout check if we are the last requ=
est */
> +                       if (atomic_read(&fc->num_waiting) =3D=3D 0)
> +                               cancel_delayed_work_sync(&fc->work);
> +                       spin_unlock(&fc->lock);
> +               }
> +
>                 fuse_request_free(req);
>         }
>  }
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 74744c6f2860..aba3ffd0fb67 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -438,6 +438,9 @@ struct fuse_req {
>
>         /** fuse_mount this request belongs to */
>         struct fuse_mount *fm;
> +
> +       /** When (in jiffies) the request was created */
> +       unsigned long create_time;
>  };
>
>  struct fuse_iqueue;
> @@ -923,6 +926,9 @@ struct fuse_conn {
>         /** IDR for backing files ids */
>         struct idr backing_files_map;
>  #endif
> +
> +       /** Request wait timeout check */
> +       struct delayed_work work;
>  };
>
>  /*
> @@ -1190,6 +1196,8 @@ void fuse_request_end(struct fuse_req *req);
>  /* Abort all requests */
>  void fuse_abort_conn(struct fuse_conn *fc);
>  void fuse_wait_aborted(struct fuse_conn *fc);
> +/* Connection timeout */
> +void fuse_check_timeout(struct work_struct *wk);
>
>  /**
>   * Invalidate inode attributes
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 3ce4f4e81d09..ed96154df0fd 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -23,6 +23,7 @@
>  #include <linux/exportfs.h>
>  #include <linux/posix_acl.h>
>  #include <linux/pid_namespace.h>
> +#include <linux/completion.h>
>  #include <uapi/linux/magic.h>
>
>  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> @@ -964,6 +965,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse=
_mount *fm,
>         INIT_LIST_HEAD(&fc->entry);
>         INIT_LIST_HEAD(&fc->devices);
>         atomic_set(&fc->num_waiting, 0);
> +       INIT_DELAYED_WORK(&fc->work, fuse_check_timeout);
>         fc->max_background =3D FUSE_DEFAULT_MAX_BACKGROUND;
>         fc->congestion_threshold =3D FUSE_DEFAULT_CONGESTION_THRESHOLD;
>         atomic64_set(&fc->khctr, 0);
> @@ -1015,6 +1017,7 @@ void fuse_conn_put(struct fuse_conn *fc)
>                 if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>                         fuse_backing_files_free(fc);
>                 call_rcu(&fc->rcu, delayed_release);
> +               cancel_delayed_work_sync(&fc->work);
>         }
>  }
>  EXPORT_SYMBOL_GPL(fuse_conn_put);
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index 5a64582b086b..1ed3a511060d 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -5,11 +5,15 @@
>  #include <linux/types.h>
>
>  #ifdef CONFIG_DETECT_HUNG_TASK
> -/* used for hung_task and block/ */
> +/* used for hung_task, block/ and fuse */
>  extern unsigned long sysctl_hung_task_timeout_secs;
> +extern unsigned int sysctl_hung_task_panic;
>  #else
>  /* Avoid need for ifdefs elsewhere in the code */
> -enum { sysctl_hung_task_timeout_secs =3D 0 };
> +enum {
> +       sysctl_hung_task_timeout_secs =3D 0,
> +       sysctl_hung_task_panic =3D 0,
> +};
>  #endif
>
>  enum sched_tunable_scaling {
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index c18717189f32..16602d3754b1 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -78,8 +78,9 @@ static unsigned int __read_mostly sysctl_hung_task_all_=
cpu_backtrace;
>   * Should we panic (and reboot, if panic_timeout=3D is set) when a
>   * hung task is detected:
>   */
> -static unsigned int __read_mostly sysctl_hung_task_panic =3D
> +unsigned int __read_mostly sysctl_hung_task_panic =3D
>         IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
> +EXPORT_SYMBOL_GPL(sysctl_hung_task_panic);
>
>  static int
>  hung_task_panic(struct notifier_block *this, unsigned long event, void *=
ptr)
> --
> 2.34.1
>

