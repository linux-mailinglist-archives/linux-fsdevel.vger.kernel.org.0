Return-Path: <linux-fsdevel+bounces-37234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3E09EFEA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 22:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AEC18889B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 21:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0ED1D88DB;
	Thu, 12 Dec 2024 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSjnmc3N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241572F2F
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734040104; cv=none; b=lCGhbtpGXt0G9nlEtpTQH3Nm9yuQKBiOGRM3K+nZw4s5r3Ndttaffp114dyz6KLLC8rbv5+WE9rD+fw1CYSU8DSAtU+eBwDxcE3MxPjFWrO0xMSe/UTOFNzOHiItPGki80N1mb7TsL0YWB7tZxXNQ7i8llAC7f87akTcJMD+smw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734040104; c=relaxed/simple;
	bh=a61xizf5kUFTDSTbnE7HMREuwejbzge3IYzLDL8KFX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeUpS/PgqQGmD10zk0szo/+qz4ejUTRAL4lwluR/ElLjx0Jnf3L4q8pW/pqd2bLuCj/LZFCHmmDuYCVbDwb4nUE7lMsvksU3haZDBsxHqyvRG/LkR4BmGIG9h+mc+MzXqR7h1CSRTh+SGW6HNT6AvoQ1ItXTEV8BMJDB3cyKTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSjnmc3N; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46761d91f7aso11813521cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 13:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734040101; x=1734644901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J20skqicAhQM+TVE9jEuCM9T8dBJK361igxj2itDWHI=;
        b=GSjnmc3NrWkD4DKL97Ng5KiapUGM1nM5Z1WCUCeDwiS3+WesMvXf+YQzomgcjZ/LQM
         76qidQv5EYX9Ma26KrFIepf9/kkSSwqu0CxSfTosWlV4lw4J/x9+S90KcXmm4bWxuGaG
         dBdfBomVNhnjWuzX9cHRyRwwXX1uYTRcAG6m8T9ky/my/eEP1SM1d+AukwDHrgkZpVnb
         hyRy7uwA3FwPb+b2kbP7oW+C3NtCbWFXgM4xw47aEdbFr3YPBtQO6qlT46Z/lWjmz2z8
         umnTeAIm/g1ZxvBRDHheOpglK0ML6urNYHypbFqkuc5Padm1slR7xBeJq3HGCH0VMLN4
         mgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734040101; x=1734644901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J20skqicAhQM+TVE9jEuCM9T8dBJK361igxj2itDWHI=;
        b=ZecxGH2LSmlSpu/dCdqQiZXFtAp0QQwacCA/tiOrHlv5AzOuL42Gr75EwMsFavu4Js
         CSc+JYmGMx0AeNO46ugHvg8R6p84SgvhqnaqdD2VvUwCzAwyb/3lvFDbO/6IjzPanZ+h
         CmqzEgfb9KrCEckYWmR0cjGN7iT4FSuW2dEbvO4/BNH/mpwPhLlvuqUdUDNRy+qpJUvv
         16Qp4GanxKGTJpbWvQjIO+vonRtxKxUG5Df45E2wesKZIZ7qhkfJvmzpOznGSYDA/mXq
         chnYqiWL5QOg3MrZs4ztWwIGFHWbJ2Qfgo9fjidkrufVIsnFzD0KhVRImEO6LjRxRzEu
         fl2g==
X-Gm-Message-State: AOJu0YxbBxPuzzxfLhI3eHBiud2jRXiE03mV/zb3vXYmvlQ8f0POkvnF
	W0JaLcyQokyTcbQEQRdFa0XjvlOStAnmbdz30/I7hOSqICzo+1RZIdhu3BQeCGglEq77njT3GJ1
	61A1z8zpbS0jg21SYDoOiV0EdLJ8=
X-Gm-Gg: ASbGncuBeNLTGCL5ocvvH9Wdn9ZSCpyPudJTuu14cIRcNZ5rqBBDtqB6baoRd8F1nNo
	5k/RA7c5iVzu9vb1jLnXy0zEBH3oAAogxx48hMNBUDN3nRzfz5EHk
X-Google-Smtp-Source: AGHT+IGHZwU8YHMn0tQO6FEgPDLI4DTXjSDRtGx/igA6fsiliytX/sZCyPsMdedd1lcppTfzfTPkb9MmC6u6n60Y4v0=
X-Received: by 2002:a05:622a:1986:b0:466:94d8:926c with SMTP id
 d75a77b69052e-467a57569f3mr2363511cf.13.1734040100801; Thu, 12 Dec 2024
 13:48:20 -0800 (PST)
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
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 12 Dec 2024 13:48:10 -0800
Message-ID: <CAJnrk1bBFGA8SQ+LvhENVb5n+MOgg=X3Ft-9g=T_3JN4aot7Mg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Abort connection if FUSE server get stuck
To: Etienne Martineau <etmartin4313@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	laoar.shao@gmail.com, senozhatsky@chromium.org, etmartin@cisco.com, 
	"ioworker0@gmail.com" <ioworker0@gmail.com>, joel.granados@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 3:04=E2=80=AFPM Etienne Martineau
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
> > > hang check timer for legitimate reasons hence consider disabling
> > > HUNG_TASK_PANIC in that scenario.
> > >
> > > Without this patch, an unresponsive / buggy / malicious FUSE server c=
an
> > > leave the clients in D state for a long period of time and on system =
where
> > > HUNG_TASK_PANIC is set, trigger a catastrophic reload.
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

imo, it is not important to directly defend against the hung task case
inside the fuse code itself. imo, the generic timeout should be used
instead. As I understand it, hung task panic is mostly enabled for
debug purposes and is enabled through a sysctl. imo, if the system
admin enables the hung task panic sysctl value, then it is not too
much of a burden for them to also set the fuse max request timeout
sysctl.


Thanks,
Joanne

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

