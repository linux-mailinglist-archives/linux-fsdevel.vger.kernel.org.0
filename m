Return-Path: <linux-fsdevel+bounces-37169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25E09EE7AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 14:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72E816228F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E41621171A;
	Thu, 12 Dec 2024 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzPP/E6Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEAB1E531
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010250; cv=none; b=js6J6Gd6ZrStCsdqzZC3PCEirIKU2dGbuCtcTJE7AhpyNgytaBHpRP4RTT3ml/4JgKnlsfkPmLHhRA2zB3i525F58cWho62+DXqY3UJRM7Jf3o9/zG1pPj8QqUR/LtosQb82T6RaMBVI+4KykYZ5rktSdLy5oFsyZ2o4N3JQr5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010250; c=relaxed/simple;
	bh=hGQcJbLmU7Rq3h0p2C4tyr+8B+Zb2RieeXXueAyK6EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUtZzlLSNx+U1wN0zjZ3oZT6aLbNg421vuPs45Xe0M/vOXssTQMAvHBOmlL/RQ+kNdOOg6Lv/PS3A7c9DP7tiX5OPs9mR9bA/THgMhxIDHaLnK3DvyplhG/a7q9NZvBKPfQzrT1+CwkBlat7fCRxlzwj73VuvWtXrTPbwVV0WDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzPP/E6Z; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46783d44db0so5420511cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 05:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734010247; x=1734615047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qPMzkxJ88K5ZgLCxwEbevGGwoMR/i5VJCEa6Xf32T4=;
        b=DzPP/E6ZVAW8BHeTpDxzV+mdwqWE/9SL+1QEBAtg10ISK8/W6j8iijhb02LrKfMn+i
         Bt4OSoLS/FyOGoYdsH0JXlXAmIITOlpaz42me39Gh6uzuA/nrzHs1Wb7Asq7w16jAC22
         d1VB9SbJSk/ToyeqBZiXTMygwhn0l1U8dtJA2p02S4pSIzvtpKkka+/QxJ+XUHWsx4wi
         ySWZ037fZxTa4NgwfB1MgHND8/uohGWMTyEPW8edB0Ky2HjP7Y0/OuvG4w4hkrqq9Qnl
         O6tFJK0FXHuf7Ir40qVvxazG6j2ZLyidU2tSQXZh7CAQCcaNwR0k2tapaQmA+geD6S6K
         TK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734010247; x=1734615047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qPMzkxJ88K5ZgLCxwEbevGGwoMR/i5VJCEa6Xf32T4=;
        b=ejbpTFUpyMwwclVYUQGnsOuwjnVWho0yrrPykuQL8Q3YRreXZEcs6s7OMpBQZDCMCa
         B0szRDUsBo3bOkspci66op8bEK8wwu3AtdRgVi5MIVVqZFYiKNJMGxp6Cvub0PPR73K5
         GBEdgV/fb+Y/SkPPwKEnzTRwXU8OHb5PbjKxfsyZ1qL5nD45Lrgdx8Um4htj0k4uARSc
         ljYOEeiUxyZdROXZkjrzWN/LNzXhfFii/DsVRCywu/+0LI5zZxpRxVk65hR4SDeq69w5
         JEu9VC5i0LPbNTlBr7Snhg89anAsJsapUkrd/3/3BWTuP7c4/rc2/yKDc1eijyiVxVC2
         mcDA==
X-Forwarded-Encrypted: i=1; AJvYcCU3/pKdfSZOqvRwPzmOs/vCRLPIqqySSPviNWy5dAuHi0s87XbMwzVXYgpt27znuw7i285Y+Pukto0zaQ1H@vger.kernel.org
X-Gm-Message-State: AOJu0YzNVIsuG1aEoHlearBeO7YSLz85WjGLElCTpF/nOG+6Y1+wTN+C
	Ukhp8OlAYfYKJr3owC8V2h6+0ALhp+9ha1syYAYL6Li6FZZ1GI7Ey8K19S9eFY7yqZ6JQXitNS9
	Ls6oTiOdNEc8gFjPaLKtP9iO/SuU=
X-Gm-Gg: ASbGncsMuIMnknb8xcbr5beRbDaD+YF+ELRG2pMuy/yKBd9y0RPmLJvupjwKPqWEjKW
	qBYnUpJ87L13QDQs0StSrPglbeWtIfQaqh8Ybuxc=
X-Google-Smtp-Source: AGHT+IE+Ct2uHVkmXJg2Zp8W+E4HHEmsFe8sUJfpxXYVRiX3tioawfxiyzc8T10fwWgEVQ3WFDtQMsBOol41pbstjAM=
X-Received: by 2002:ac8:5d08:0:b0:467:5d7f:c683 with SMTP id
 d75a77b69052e-467a16d5abdmr3824741cf.34.1734010247399; Thu, 12 Dec 2024
 05:30:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211194522.31977-1-etmartin4313@gmail.com>
 <20241211194522.31977-2-etmartin4313@gmail.com> <CAJnrk1bE5UxUC1R1+FpPBt_BTPcO_E9A6n6684rEpGOC4xBvNw@mail.gmail.com>
 <CAMHPp_SqSRRpZO8j6TTskrCCjoRNcco+3mceUHwUxQ0aG_0G-A@mail.gmail.com> <CAK1f24=SjvSg0EFjvB29zUySRN7BR4O45XkcsL5Ob8jLebYTaQ@mail.gmail.com>
In-Reply-To: <CAK1f24=SjvSg0EFjvB29zUySRN7BR4O45XkcsL5Ob8jLebYTaQ@mail.gmail.com>
From: Etienne Martineau <etmartin4313@gmail.com>
Date: Thu, 12 Dec 2024 08:30:35 -0500
Message-ID: <CAMHPp_SFP9s0rjZRG_V6m8SF09Oi5Tb9tQaiP3p=UhbCKg_2+A@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Abort connection if FUSE server get stuck
To: Lance Yang <ioworker0@gmail.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	miklos@szeredi.hu, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, laoar.shao@gmail.com, senozhatsky@chromium.org, 
	etmartin@cisco.com, joel.granados@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 12:27=E2=80=AFAM Lance Yang <ioworker0@gmail.com> w=
rote:
>
> On Thu, Dec 12, 2024 at 7:04=E2=80=AFAM Etienne Martineau
> <etmartin4313@gmail.com> wrote:
> >
> > On Wed, Dec 11, 2024 at 5:04=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > >
> > > On Wed, Dec 11, 2024 at 11:45=E2=80=AFAM <etmartin4313@gmail.com> wro=
te:
> > > >
> > > > From: Etienne Martineau <etmartin4313@gmail.com>
> > > >
> > > > This patch abort connection if HUNG_TASK_PANIC is set and a FUSE se=
rver
> > > > is getting stuck for too long. A slow FUSE server may tripped the
>
> A FUSE server is getting stuck for longer than hung_task_timeout_secs
> (the default is two minutes). Is it not buggy in the real-world?
Can be buggy OR malicious yes. FUSE server is a user-space process so all
bets are off.

> > > > hang check timer for legitimate reasons hence consider disabling
> > > > HUNG_TASK_PANIC in that scenario.
>
> Why not just consider increasing hung_task_timeout_secs if necessary?
What value is the right value then?

The timeout is global, so by increasing the timeout it will take
longer for the kernel
to report and act on different hung task scenarios.

HUNG_TASK_PANIC is a failsafe mechanism that helps prevent your system from
running headless for too long. Say you are in crypto-mining and your
box is getting
stuck on some FPGA drivers -- the process calling into that driver is
stuck in an
UNINTERRUPTIBLE wait somehow. Without HUNG_TASK_PANIC you'll lose
money because your box may end up sitting idling for hours doing nothing.

>
> > > >
> > > > Without this patch, an unresponsive / buggy / malicious FUSE server=
 can
> > > > leave the clients in D state for a long period of time and on syste=
m where
> > > > HUNG_TASK_PANIC is set, trigger a catastrophic reload.
>
> Sorry, I don't see any sense in knowing whether HUNG_TASK_PANIC is enable=
d for
> FUSE servers. Or am I possibly missing something important?
Regular file-system drivers handles everything internally but FUSE on
the other hands,
delegate the file system operation to a user process ( FUSE server )
If the FUSE server is turning bad, you don't want to reload right?

A non-privileged user can  potentially exploit this flaw and trigger a
reload. I'm
surprised that this didn't get flagged before ( maybe I'm missing something=
 ? )
IMO this is why I think something needs to be done for the stable
branch as well.

>
> If HUNG_TASK_PANIC is set, we should do a reload when a hung task is dete=
cted;
> this is working as expected IHMO.
Say when your browser hangs on your system, do you reload? FUSE server
is just another
process.

thanks
Etienne

> Thanks,
> Lance
>
> > > >
> > > > So, if HUNG_TASK_PANIC checking is enabled, we should wake up perio=
dically
> > > > to abort connections that exceed the timeout value which is define =
to be
> > > > half the HUNG_TASK_TIMEOUT period, which keeps overhead low. The ti=
mer
> > > > is per connection and runs only if there are active FUSE request pe=
nding.
> > >
> > > Hi Etienne,
> > >
> > > For your use case, does the generic request timeouts logic and
> > > max_request_timeout systemctl implemented in [1] and [2] not suffice?
> > > IMO I don't think we should have logic specifically checking for hung
> > > task timeouts in fuse, if the generic solution can be used.
> > >
> > > Thanks,
> > > Joanne
> >
> > We need a way to avoid catastrophic reloads on systems where HUNG_TASK_=
PANIC
> > is set while a buggy / malicious FUSE server stops responding.
> > I would argue that this is much needed in stable branches as well...
> >
> > For that reason, I believe we need to keep things simple for step #1
> > e.g. there is no
> > need to introduce another knob as we already have HUNG_TASK_TIMEOUT whi=
ch
> > holds the source of truth.
> >
> > IMO introducing those new knobs will put an unnecessary burden on sysad=
mins into
> > something that is error prone because unlike
> >   CONFIG_DETECT_HUNG_TASK=3Dy
> >   CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
> > which is built-in, the "default_request_timeout" /
> > "max_request_timeout" needs to be
> > set appropriately after every reboot and failure to do so may have
> > nasty consequences.
> >
> > For the more generic cases then yes those timeouts make sense to me.
> >
> > Thanks,
> > Etienne
> >
> > >
> > > [1] https://lore.kernel.org/linux-fsdevel/20241114191332.669127-1-joa=
nnelkoong@gmail.com/
> > > [2] https://lore.kernel.org/linux-fsdevel/20241114191332.669127-4-joa=
nnelkoong@gmail.com/
> > >
> > > >
> > > > A FUSE client can get into D state as such ( see below scenario #1 =
/ #2 )
> > > >  1) request_wait_answer() -> wait_event() is UNINTERRUPTIBLE
> > > >     OR
> > > >  2) request_wait_answer() -> wait_event_(interruptible / killable) =
is head
> > > >     of line blocking for subsequent clients accessing the same file
> > > >
> > > >         scenario #1:
> > > >         2716 pts/2    D+     0:00 cat
> > > >         $ cat /proc/2716/stack
> > > >                 [<0>] request_wait_answer+0x22e/0x340
> > > >                 [<0>] __fuse_simple_request+0xd8/0x2c0
> > > >                 [<0>] fuse_perform_write+0x3ec/0x760
> > > >                 [<0>] fuse_file_write_iter+0x3d5/0x3f0
> > > >                 [<0>] vfs_write+0x313/0x430
> > > >                 [<0>] ksys_write+0x6a/0xf0
> > > >                 [<0>] __x64_sys_write+0x19/0x30
> > > >                 [<0>] x64_sys_call+0x18ab/0x26f0
> > > >                 [<0>] do_syscall_64+0x7c/0x170
> > > >                 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > >
> > > >         scenario #2:
> > > >         2962 pts/2    S+     0:00 cat
> > > >         2963 pts/3    D+     0:00 cat
> > > >         $ cat /proc/2962/stack
> > > >                 [<0>] request_wait_answer+0x140/0x340
> > > >                 [<0>] __fuse_simple_request+0xd8/0x2c0
> > > >                 [<0>] fuse_perform_write+0x3ec/0x760
> > > >                 [<0>] fuse_file_write_iter+0x3d5/0x3f0
> > > >                 [<0>] vfs_write+0x313/0x430
> > > >                 [<0>] ksys_write+0x6a/0xf0
> > > >                 [<0>] __x64_sys_write+0x19/0x30
> > > >                 [<0>] x64_sys_call+0x18ab/0x26f0
> > > >                 [<0>] do_syscall_64+0x7c/0x170
> > > >                 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > >         $ cat /proc/2963/stack
> > > >                 [<0>] fuse_file_write_iter+0x252/0x3f0
> > > >                 [<0>] vfs_write+0x313/0x430
> > > >                 [<0>] ksys_write+0x6a/0xf0
> > > >                 [<0>] __x64_sys_write+0x19/0x30
> > > >                 [<0>] x64_sys_call+0x18ab/0x26f0
> > > >                 [<0>] do_syscall_64+0x7c/0x170
> > > >                 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > >
> > > > Please note that this patch doesn't prevent the HUNG_TASK_WARNING.
> > > >
> > > > Signed-off-by: Etienne Martineau <etmartin4313@gmail.com>
> > > > ---
> > > >  fs/fuse/dev.c                | 100 +++++++++++++++++++++++++++++++=
++++
> > > >  fs/fuse/fuse_i.h             |   8 +++
> > > >  fs/fuse/inode.c              |   3 ++
> > > >  include/linux/sched/sysctl.h |   8 ++-
> > > >  kernel/hung_task.c           |   3 +-
> > > >  5 files changed, 119 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > > index 27ccae63495d..73d19de14e51 100644
> > > > --- a/fs/fuse/dev.c
> > > > +++ b/fs/fuse/dev.c
> > > > @@ -21,6 +21,8 @@
> > > >  #include <linux/swap.h>
> > > >  #include <linux/splice.h>
> > > >  #include <linux/sched.h>
> > > > +#include <linux/completion.h>
> > > > +#include <linux/sched/sysctl.h>
> > > >
> > > >  #define CREATE_TRACE_POINTS
> > > >  #include "fuse_trace.h"
> > > > @@ -45,14 +47,104 @@ static struct fuse_dev *fuse_get_dev(struct fi=
le *file)
> > > >         return READ_ONCE(file->private_data);
> > > >  }
> > > >
> > > > +static bool request_expired(struct fuse_conn *fc, struct fuse_req =
*req,
> > > > +               int timeout)
> > > > +{
> > > > +       return time_after(jiffies, req->create_time + timeout);
> > > > +}
> > > > +
> > > > +/*
> > > > + * Prevent hung task timer from firing at us
> > > > + * Check if any requests aren't being completed by the specified r=
equest
> > > > + * timeout. To do so, we:
> > > > + * - check the fiq pending list
> > > > + * - check the bg queue
> > > > + * - check the fpq io and processing lists
> > > > + *
> > > > + * To make this fast, we only check against the head request on ea=
ch list since
> > > > + * these are generally queued in order of creation time (eg newer =
requests get
> > > > + * queued to the tail). We might miss a few edge cases (eg request=
s transitioning
> > > > + * between lists, re-sent requests at the head of the pending list=
 having a
> > > > + * later creation time than other requests on that list, etc.) but=
 that is fine
> > > > + * since if the request never gets fulfilled, it will eventually b=
e caught.
> > > > + */
> > > > +void fuse_check_timeout(struct work_struct *wk)
> > > > +{
> > > > +       unsigned long hang_check_timer =3D sysctl_hung_task_timeout=
_secs * (HZ / 2);
> > > > +       struct fuse_conn *fc =3D container_of(wk, struct fuse_conn,=
 work.work);
> > > > +       struct fuse_iqueue *fiq =3D &fc->iq;
> > > > +       struct fuse_req *req;
> > > > +       struct fuse_dev *fud;
> > > > +       struct fuse_pqueue *fpq;
> > > > +       bool expired =3D false;
> > > > +       int i;
> > > > +
> > > > +       spin_lock(&fiq->lock);
> > > > +       req =3D list_first_entry_or_null(&fiq->pending, struct fuse=
_req, list);
> > > > +       if (req)
> > > > +               expired =3D request_expired(fc, req, hang_check_tim=
er);
> > > > +       spin_unlock(&fiq->lock);
> > > > +       if (expired)
> > > > +               goto abort_conn;
> > > > +
> > > > +       spin_lock(&fc->bg_lock);
> > > > +       req =3D list_first_entry_or_null(&fc->bg_queue, struct fuse=
_req, list);
> > > > +       if (req)
> > > > +               expired =3D request_expired(fc, req, hang_check_tim=
er);
> > > > +       spin_unlock(&fc->bg_lock);
> > > > +       if (expired)
> > > > +               goto abort_conn;
> > > > +
> > > > +       spin_lock(&fc->lock);
> > > > +       if (!fc->connected) {
> > > > +               spin_unlock(&fc->lock);
> > > > +               return;
> > > > +       }
> > > > +       list_for_each_entry(fud, &fc->devices, entry) {
> > > > +               fpq =3D &fud->pq;
> > > > +               spin_lock(&fpq->lock);
> > > > +               req =3D list_first_entry_or_null(&fpq->io, struct f=
use_req, list);
> > > > +               if (req && request_expired(fc, req, hang_check_time=
r))
> > > > +                       goto fpq_abort;
> > > > +
> > > > +               for (i =3D 0; i < FUSE_PQ_HASH_SIZE; i++) {
> > > > +                       req =3D list_first_entry_or_null(&fpq->proc=
essing[i], struct fuse_req, list);
> > > > +                       if (req && request_expired(fc, req, hang_ch=
eck_timer))
> > > > +                               goto fpq_abort;
> > > > +               }
> > > > +               spin_unlock(&fpq->lock);
> > > > +       }
> > > > +       /* Keep the ball rolling */
> > > > +       if (atomic_read(&fc->num_waiting) !=3D 0)
> > > > +               queue_delayed_work(system_wq, &fc->work, hang_check=
_timer);
> > > > +       spin_unlock(&fc->lock);
> > > > +       return;
> > > > +
> > > > +fpq_abort:
> > > > +       spin_unlock(&fpq->lock);
> > > > +       spin_unlock(&fc->lock);
> > > > +abort_conn:
> > > > +       fuse_abort_conn(fc);
> > > > +}
> > > > +
> > > >  static void fuse_request_init(struct fuse_mount *fm, struct fuse_r=
eq *req)
> > > >  {
> > > > +       struct fuse_conn *fc =3D fm->fc;
> > > >         INIT_LIST_HEAD(&req->list);
> > > >         INIT_LIST_HEAD(&req->intr_entry);
> > > >         init_waitqueue_head(&req->waitq);
> > > >         refcount_set(&req->count, 1);
> > > >         __set_bit(FR_PENDING, &req->flags);
> > > >         req->fm =3D fm;
> > > > +       req->create_time =3D jiffies;
> > > > +
> > > > +       if (sysctl_hung_task_panic) {
> > > > +               spin_lock(&fc->lock);
> > > > +               /* Get the ball rolling */
> > > > +               queue_delayed_work(system_wq, &fc->work,
> > > > +                               sysctl_hung_task_timeout_secs * (HZ=
 / 2));
> > > > +               spin_unlock(&fc->lock);
> > > > +       }
> > > >  }
> > > >
> > > >  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, =
gfp_t flags)
> > > > @@ -200,6 +292,14 @@ static void fuse_put_request(struct fuse_req *=
req)
> > > >                         fuse_drop_waiting(fc);
> > > >                 }
> > > >
> > > > +               if (sysctl_hung_task_panic) {
> > > > +                       spin_lock(&fc->lock);
> > > > +                       /* Stop the timeout check if we are the las=
t request */
> > > > +                       if (atomic_read(&fc->num_waiting) =3D=3D 0)
> > > > +                               cancel_delayed_work_sync(&fc->work)=
;
> > > > +                       spin_unlock(&fc->lock);
> > > > +               }
> > > > +
> > > >                 fuse_request_free(req);
> > > >         }
> > > >  }
> > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > index 74744c6f2860..aba3ffd0fb67 100644
> > > > --- a/fs/fuse/fuse_i.h
> > > > +++ b/fs/fuse/fuse_i.h
> > > > @@ -438,6 +438,9 @@ struct fuse_req {
> > > >
> > > >         /** fuse_mount this request belongs to */
> > > >         struct fuse_mount *fm;
> > > > +
> > > > +       /** When (in jiffies) the request was created */
> > > > +       unsigned long create_time;
> > > >  };
> > > >
> > > >  struct fuse_iqueue;
> > > > @@ -923,6 +926,9 @@ struct fuse_conn {
> > > >         /** IDR for backing files ids */
> > > >         struct idr backing_files_map;
> > > >  #endif
> > > > +
> > > > +       /** Request wait timeout check */
> > > > +       struct delayed_work work;
> > > >  };
> > > >
> > > >  /*
> > > > @@ -1190,6 +1196,8 @@ void fuse_request_end(struct fuse_req *req);
> > > >  /* Abort all requests */
> > > >  void fuse_abort_conn(struct fuse_conn *fc);
> > > >  void fuse_wait_aborted(struct fuse_conn *fc);
> > > > +/* Connection timeout */
> > > > +void fuse_check_timeout(struct work_struct *wk);
> > > >
> > > >  /**
> > > >   * Invalidate inode attributes
> > > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > > index 3ce4f4e81d09..ed96154df0fd 100644
> > > > --- a/fs/fuse/inode.c
> > > > +++ b/fs/fuse/inode.c
> > > > @@ -23,6 +23,7 @@
> > > >  #include <linux/exportfs.h>
> > > >  #include <linux/posix_acl.h>
> > > >  #include <linux/pid_namespace.h>
> > > > +#include <linux/completion.h>
> > > >  #include <uapi/linux/magic.h>
> > > >
> > > >  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> > > > @@ -964,6 +965,7 @@ void fuse_conn_init(struct fuse_conn *fc, struc=
t fuse_mount *fm,
> > > >         INIT_LIST_HEAD(&fc->entry);
> > > >         INIT_LIST_HEAD(&fc->devices);
> > > >         atomic_set(&fc->num_waiting, 0);
> > > > +       INIT_DELAYED_WORK(&fc->work, fuse_check_timeout);
> > > >         fc->max_background =3D FUSE_DEFAULT_MAX_BACKGROUND;
> > > >         fc->congestion_threshold =3D FUSE_DEFAULT_CONGESTION_THRESH=
OLD;
> > > >         atomic64_set(&fc->khctr, 0);
> > > > @@ -1015,6 +1017,7 @@ void fuse_conn_put(struct fuse_conn *fc)
> > > >                 if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> > > >                         fuse_backing_files_free(fc);
> > > >                 call_rcu(&fc->rcu, delayed_release);
> > > > +               cancel_delayed_work_sync(&fc->work);
> > > >         }
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(fuse_conn_put);
> > > > diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sys=
ctl.h
> > > > index 5a64582b086b..1ed3a511060d 100644
> > > > --- a/include/linux/sched/sysctl.h
> > > > +++ b/include/linux/sched/sysctl.h
> > > > @@ -5,11 +5,15 @@
> > > >  #include <linux/types.h>
> > > >
> > > >  #ifdef CONFIG_DETECT_HUNG_TASK
> > > > -/* used for hung_task and block/ */
> > > > +/* used for hung_task, block/ and fuse */
> > > >  extern unsigned long sysctl_hung_task_timeout_secs;
> > > > +extern unsigned int sysctl_hung_task_panic;
> > > >  #else
> > > >  /* Avoid need for ifdefs elsewhere in the code */
> > > > -enum { sysctl_hung_task_timeout_secs =3D 0 };
> > > > +enum {
> > > > +       sysctl_hung_task_timeout_secs =3D 0,
> > > > +       sysctl_hung_task_panic =3D 0,
> > > > +};
> > > >  #endif
> > > >
> > > >  enum sched_tunable_scaling {
> > > > diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> > > > index c18717189f32..16602d3754b1 100644
> > > > --- a/kernel/hung_task.c
> > > > +++ b/kernel/hung_task.c
> > > > @@ -78,8 +78,9 @@ static unsigned int __read_mostly sysctl_hung_tas=
k_all_cpu_backtrace;
> > > >   * Should we panic (and reboot, if panic_timeout=3D is set) when a
> > > >   * hung task is detected:
> > > >   */
> > > > -static unsigned int __read_mostly sysctl_hung_task_panic =3D
> > > > +unsigned int __read_mostly sysctl_hung_task_panic =3D
> > > >         IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
> > > > +EXPORT_SYMBOL_GPL(sysctl_hung_task_panic);
> > > >
> > > >  static int
> > > >  hung_task_panic(struct notifier_block *this, unsigned long event, =
void *ptr)
> > > > --
> > > > 2.34.1
> > > >

