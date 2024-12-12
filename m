Return-Path: <linux-fsdevel+bounces-37179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A38E69EEA82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 16:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA30616C430
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 15:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDD9218EB5;
	Thu, 12 Dec 2024 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPVFSswl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC8A21639F
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016163; cv=none; b=Z8HapdBMLsIRzHsLtum+A1Mhn7hirf3KYU8gV6XODPY+ft2zH6Ds9RbiYcOEC8HH+C3bdbqUL5UD7f+ETZp7RSeb2dT9OQGnfGWAf7Kjit5hPXhHm7YW/Z0XepnLi7CQY87Pc/sY/RogH/ddPNare3lkzHTq9h+5D84TDT7FOqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016163; c=relaxed/simple;
	bh=MoBWhATly+AqK8UNre6xSyPNDSTdu/mlq38CLTFcI2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EeF9FHx/iKXOSgibHsHonKxdYy8jvDnk7lEkhzL7uNpQ8j4ojhQoa+PhBs+OS7SqGrbNY7nCItIkGoVfkdycAZqXRrlnGmcYkjdAuHE43UYtr9nkbxP+xvnyaIxHo/bhAmjNyQ5kFAAF0DY19pRxcKrXo05IQtIbMF+u6IapAOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPVFSswl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so82975366b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 07:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734016159; x=1734620959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDdwfPf7jKkf6z19srbI7UKd/L/USagEM+Uc258G21M=;
        b=bPVFSswlkU09kbtl307otRoP7eqmnalW937VIWEIp/1juyQA5QIZohbwdiYbUHhwTc
         EwfP1RDtCNFBYMzT8aHCrHai6GUsdte7npg86yK5mMhKvsu2qLvbbXiiEJV6IbH2fnUI
         T2ZQQ1a8quaCxwYSzfP5BxsWUyK3ltJEZ5MFdRBfKcl0HuZZMBWpC+LAjhMZnNhNm+eS
         vWCBNxhUv466gWe4JjaaSMPxVpGB5e4hBZS/DZIyajsdahlg4mqP6GToFs7PnSyPvugX
         GNHZ77gKUCTBkbVqI4qNX1qWrRpLsFW67oxbbhFrhUBxqq0EEx3KOjVmv3DCOI3B8wP9
         V5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734016159; x=1734620959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDdwfPf7jKkf6z19srbI7UKd/L/USagEM+Uc258G21M=;
        b=nqQynuEj37Uj5ym1thiRiG3O5amrrU0Khfi36sjC0aPLOF5roXv+1XsClr1Gytj9hf
         fM4IMOQzHAw15n2E12s23HAnOhnu5bVMQ0ViqjTTp6pfJ+/EZ+D5lMaD9zl2sRm6+YvX
         RpU7XW1EunI4/MsOIMv4a4/goEFx5zMhj6r9nU3a8qxUYihwd7GMrTtAQGd3JdLs3rMz
         kkfv+JMh6eTwCUOvJeEL2yoFF21PRuI1SYnO1Zjc5YpaILwpOga9vw0/C460VnjZJ6Y5
         SApELUkA7+fufivUtAxCbZxAceJzhLZ/IcQ8rPxNWLm/m1A5Vk0EkCh8rOZ8hheVBZNa
         BBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRtJWfkutYk5M+hgm1Yai5wjU1gYd43tsxuV7yBbNpBYJTFfhhglJJroCaNDQ1RXI/u9wrkJEB7VbXxdPx@vger.kernel.org
X-Gm-Message-State: AOJu0YzvVZtoIhnxiwnYIXh2a+dbBMxLMM1WSjywr034MK3yltHtMn4s
	1hshNFsL+1RZA+7kInBHNdwYmRYdULF75mn6MN0uzSQBZ/5OwLgO3ZWypU6n1M9sN+nKuZ3WiwH
	+eBPsk7u25/osmQ0ZbvBSihx/f/7G6cjpc7Y=
X-Gm-Gg: ASbGnctwaEuBW3zNw7yTk93SpqV0g+fbkWiu4A74hHPP1GKuxgXRt8aducHn98I7BbK
	79wpqrGR+fAm2mTDGRpnVs6mCS3UTKfQboqmVgg==
X-Google-Smtp-Source: AGHT+IGcr9CgeSYSnZfgIT7SnUJ8RfNiklwHV71W0le/Crp7h8MgtPH95V5R2HMYQQNOC8F3yaWBwb6IecBswDCsWB0=
X-Received: by 2002:a05:6402:5191:b0:5d4:35c7:cd7a with SMTP id
 4fb4d7f45d1cf-5d63237c3e9mr1205782a12.10.1734016158675; Thu, 12 Dec 2024
 07:09:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211194522.31977-1-etmartin4313@gmail.com>
 <20241211194522.31977-2-etmartin4313@gmail.com> <CAJnrk1bE5UxUC1R1+FpPBt_BTPcO_E9A6n6684rEpGOC4xBvNw@mail.gmail.com>
 <CAMHPp_SqSRRpZO8j6TTskrCCjoRNcco+3mceUHwUxQ0aG_0G-A@mail.gmail.com>
 <CAK1f24=SjvSg0EFjvB29zUySRN7BR4O45XkcsL5Ob8jLebYTaQ@mail.gmail.com> <CAMHPp_SFP9s0rjZRG_V6m8SF09Oi5Tb9tQaiP3p=UhbCKg_2+A@mail.gmail.com>
In-Reply-To: <CAMHPp_SFP9s0rjZRG_V6m8SF09Oi5Tb9tQaiP3p=UhbCKg_2+A@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 12 Dec 2024 23:08:42 +0800
Message-ID: <CAK1f24knsHBi4hShGPP4KrEv=Erk5XOQ5CQv_e7VrK0RfirGkg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Abort connection if FUSE server get stuck
To: Etienne Martineau <etmartin4313@gmail.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	miklos@szeredi.hu, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, laoar.shao@gmail.com, senozhatsky@chromium.org, 
	etmartin@cisco.com, joel.granados@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Barry Song <21cnbao@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC+ Andrew
CC+ David
CC+ Matthew
CC+ Barry
CC+ Ryan

On Thu, Dec 12, 2024 at 9:30=E2=80=AFPM Etienne Martineau
<etmartin4313@gmail.com> wrote:
>
> On Thu, Dec 12, 2024 at 12:27=E2=80=AFAM Lance Yang <ioworker0@gmail.com>=
 wrote:
> >
> > On Thu, Dec 12, 2024 at 7:04=E2=80=AFAM Etienne Martineau
> > <etmartin4313@gmail.com> wrote:
> > >
> > > On Wed, Dec 11, 2024 at 5:04=E2=80=AFPM Joanne Koong <joannelkoong@gm=
ail.com> wrote:
> > > >
> > > > On Wed, Dec 11, 2024 at 11:45=E2=80=AFAM <etmartin4313@gmail.com> w=
rote:
> > > > >
> > > > > From: Etienne Martineau <etmartin4313@gmail.com>
> > > > >
> > > > > This patch abort connection if HUNG_TASK_PANIC is set and a FUSE =
server
> > > > > is getting stuck for too long. A slow FUSE server may tripped the
> >
> > A FUSE server is getting stuck for longer than hung_task_timeout_secs
> > (the default is two minutes). Is it not buggy in the real-world?
> Can be buggy OR malicious yes. FUSE server is a user-space process so all
> bets are off.

Yep, all bets are off ;)

>
> > > > > hang check timer for legitimate reasons hence consider disabling
> > > > > HUNG_TASK_PANIC in that scenario.
> >
> > Why not just consider increasing hung_task_timeout_secs if necessary?
> What value is the right value then?
>
> The timeout is global, so by increasing the timeout it will take
> longer for the kernel
> to report and act on different hung task scenarios.
>
> HUNG_TASK_PANIC is a failsafe mechanism that helps prevent your system fr=
om
> running headless for too long. Say you are in crypto-mining and your
> box is getting
> stuck on some FPGA drivers -- the process calling into that driver is
> stuck in an
> UNINTERRUPTIBLE wait somehow. Without HUNG_TASK_PANIC you'll lose
> money because your box may end up sitting idling for hours doing nothing.

Agreed, which is why HUNG_TASK_PANIC is enabled by default, IIRC.

>
> >
> > > > >
> > > > > Without this patch, an unresponsive / buggy / malicious FUSE serv=
er can
> > > > > leave the clients in D state for a long period of time and on sys=
tem where
> > > > > HUNG_TASK_PANIC is set, trigger a catastrophic reload.
> >
> > Sorry, I don't see any sense in knowing whether HUNG_TASK_PANIC is enab=
led for
> > FUSE servers. Or am I possibly missing something important?
> Regular file-system drivers handles everything internally but FUSE on
> the other hands,
> delegate the file system operation to a user process ( FUSE server )
> If the FUSE server is turning bad, you don't want to reload right?

To me, it makes sense to reload the system if HUNG_TASK_PANIC is
enabled. Doing so allows me to notice the issue in time and resolve it
through the kernel dump, IHMO.

>
> A non-privileged user can  potentially exploit this flaw and trigger a
> reload. I'm
> surprised that this didn't get flagged before ( maybe I'm missing somethi=
ng ? )
> IMO this is why I think something needs to be done for the stable
> branch as well.

AFAIK, besides this, a non-privileged user has other ways to cause some
processes to stay in the D state for a long period of time.

>
> >
> > If HUNG_TASK_PANIC is set, we should do a reload when a hung task is de=
tected;
> > this is working as expected IHMO.
> Say when your browser hangs on your system, do you reload? FUSE server
> is just another
> process.

Hmm... the choice to enable HUNG_TASK_PANIC should be up to the user, while
the decision to reload the system should be up to the hung task detector ;)

Thanks a lot for including me. It seems like we're not on the same page and=
 I'm
also not a FUSE expert. So, let's hear the views of others.

Thanks,
Lance


>
> thanks
> Etienne
>
> > Thanks,
> > Lance
> >
> > > > >
> > > > > So, if HUNG_TASK_PANIC checking is enabled, we should wake up per=
iodically
> > > > > to abort connections that exceed the timeout value which is defin=
e to be
> > > > > half the HUNG_TASK_TIMEOUT period, which keeps overhead low. The =
timer
> > > > > is per connection and runs only if there are active FUSE request =
pending.
> > > >
> > > > Hi Etienne,
> > > >
> > > > For your use case, does the generic request timeouts logic and
> > > > max_request_timeout systemctl implemented in [1] and [2] not suffic=
e?
> > > > IMO I don't think we should have logic specifically checking for hu=
ng
> > > > task timeouts in fuse, if the generic solution can be used.
> > > >
> > > > Thanks,
> > > > Joanne
> > >
> > > We need a way to avoid catastrophic reloads on systems where HUNG_TAS=
K_PANIC
> > > is set while a buggy / malicious FUSE server stops responding.
> > > I would argue that this is much needed in stable branches as well...
> > >
> > > For that reason, I believe we need to keep things simple for step #1
> > > e.g. there is no
> > > need to introduce another knob as we already have HUNG_TASK_TIMEOUT w=
hich
> > > holds the source of truth.
> > >
> > > IMO introducing those new knobs will put an unnecessary burden on sys=
admins into
> > > something that is error prone because unlike
> > >   CONFIG_DETECT_HUNG_TASK=3Dy
> > >   CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
> > > which is built-in, the "default_request_timeout" /
> > > "max_request_timeout" needs to be
> > > set appropriately after every reboot and failure to do so may have
> > > nasty consequences.
> > >
> > > For the more generic cases then yes those timeouts make sense to me.
> > >
> > > Thanks,
> > > Etienne
> > >
> > > >
> > > > [1] https://lore.kernel.org/linux-fsdevel/20241114191332.669127-1-j=
oannelkoong@gmail.com/
> > > > [2] https://lore.kernel.org/linux-fsdevel/20241114191332.669127-4-j=
oannelkoong@gmail.com/
> > > >
> > > > >
> > > > > A FUSE client can get into D state as such ( see below scenario #=
1 / #2 )
> > > > >  1) request_wait_answer() -> wait_event() is UNINTERRUPTIBLE
> > > > >     OR
> > > > >  2) request_wait_answer() -> wait_event_(interruptible / killable=
) is head
> > > > >     of line blocking for subsequent clients accessing the same fi=
le
> > > > >
> > > > >         scenario #1:
> > > > >         2716 pts/2    D+     0:00 cat
> > > > >         $ cat /proc/2716/stack
> > > > >                 [<0>] request_wait_answer+0x22e/0x340
> > > > >                 [<0>] __fuse_simple_request+0xd8/0x2c0
> > > > >                 [<0>] fuse_perform_write+0x3ec/0x760
> > > > >                 [<0>] fuse_file_write_iter+0x3d5/0x3f0
> > > > >                 [<0>] vfs_write+0x313/0x430
> > > > >                 [<0>] ksys_write+0x6a/0xf0
> > > > >                 [<0>] __x64_sys_write+0x19/0x30
> > > > >                 [<0>] x64_sys_call+0x18ab/0x26f0
> > > > >                 [<0>] do_syscall_64+0x7c/0x170
> > > > >                 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > >
> > > > >         scenario #2:
> > > > >         2962 pts/2    S+     0:00 cat
> > > > >         2963 pts/3    D+     0:00 cat
> > > > >         $ cat /proc/2962/stack
> > > > >                 [<0>] request_wait_answer+0x140/0x340
> > > > >                 [<0>] __fuse_simple_request+0xd8/0x2c0
> > > > >                 [<0>] fuse_perform_write+0x3ec/0x760
> > > > >                 [<0>] fuse_file_write_iter+0x3d5/0x3f0
> > > > >                 [<0>] vfs_write+0x313/0x430
> > > > >                 [<0>] ksys_write+0x6a/0xf0
> > > > >                 [<0>] __x64_sys_write+0x19/0x30
> > > > >                 [<0>] x64_sys_call+0x18ab/0x26f0
> > > > >                 [<0>] do_syscall_64+0x7c/0x170
> > > > >                 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > >         $ cat /proc/2963/stack
> > > > >                 [<0>] fuse_file_write_iter+0x252/0x3f0
> > > > >                 [<0>] vfs_write+0x313/0x430
> > > > >                 [<0>] ksys_write+0x6a/0xf0
> > > > >                 [<0>] __x64_sys_write+0x19/0x30
> > > > >                 [<0>] x64_sys_call+0x18ab/0x26f0
> > > > >                 [<0>] do_syscall_64+0x7c/0x170
> > > > >                 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > >
> > > > > Please note that this patch doesn't prevent the HUNG_TASK_WARNING=
.
> > > > >
> > > > > Signed-off-by: Etienne Martineau <etmartin4313@gmail.com>
> > > > > ---
> > > > >  fs/fuse/dev.c                | 100 +++++++++++++++++++++++++++++=
++++++
> > > > >  fs/fuse/fuse_i.h             |   8 +++
> > > > >  fs/fuse/inode.c              |   3 ++
> > > > >  include/linux/sched/sysctl.h |   8 ++-
> > > > >  kernel/hung_task.c           |   3 +-
> > > > >  5 files changed, 119 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > > > index 27ccae63495d..73d19de14e51 100644
> > > > > --- a/fs/fuse/dev.c
> > > > > +++ b/fs/fuse/dev.c
> > > > > @@ -21,6 +21,8 @@
> > > > >  #include <linux/swap.h>
> > > > >  #include <linux/splice.h>
> > > > >  #include <linux/sched.h>
> > > > > +#include <linux/completion.h>
> > > > > +#include <linux/sched/sysctl.h>
> > > > >
> > > > >  #define CREATE_TRACE_POINTS
> > > > >  #include "fuse_trace.h"
> > > > > @@ -45,14 +47,104 @@ static struct fuse_dev *fuse_get_dev(struct =
file *file)
> > > > >         return READ_ONCE(file->private_data);
> > > > >  }
> > > > >
> > > > > +static bool request_expired(struct fuse_conn *fc, struct fuse_re=
q *req,
> > > > > +               int timeout)
> > > > > +{
> > > > > +       return time_after(jiffies, req->create_time + timeout);
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * Prevent hung task timer from firing at us
> > > > > + * Check if any requests aren't being completed by the specified=
 request
> > > > > + * timeout. To do so, we:
> > > > > + * - check the fiq pending list
> > > > > + * - check the bg queue
> > > > > + * - check the fpq io and processing lists
> > > > > + *
> > > > > + * To make this fast, we only check against the head request on =
each list since
> > > > > + * these are generally queued in order of creation time (eg newe=
r requests get
> > > > > + * queued to the tail). We might miss a few edge cases (eg reque=
sts transitioning
> > > > > + * between lists, re-sent requests at the head of the pending li=
st having a
> > > > > + * later creation time than other requests on that list, etc.) b=
ut that is fine
> > > > > + * since if the request never gets fulfilled, it will eventually=
 be caught.
> > > > > + */
> > > > > +void fuse_check_timeout(struct work_struct *wk)
> > > > > +{
> > > > > +       unsigned long hang_check_timer =3D sysctl_hung_task_timeo=
ut_secs * (HZ / 2);
> > > > > +       struct fuse_conn *fc =3D container_of(wk, struct fuse_con=
n, work.work);
> > > > > +       struct fuse_iqueue *fiq =3D &fc->iq;
> > > > > +       struct fuse_req *req;
> > > > > +       struct fuse_dev *fud;
> > > > > +       struct fuse_pqueue *fpq;
> > > > > +       bool expired =3D false;
> > > > > +       int i;
> > > > > +
> > > > > +       spin_lock(&fiq->lock);
> > > > > +       req =3D list_first_entry_or_null(&fiq->pending, struct fu=
se_req, list);
> > > > > +       if (req)
> > > > > +               expired =3D request_expired(fc, req, hang_check_t=
imer);
> > > > > +       spin_unlock(&fiq->lock);
> > > > > +       if (expired)
> > > > > +               goto abort_conn;
> > > > > +
> > > > > +       spin_lock(&fc->bg_lock);
> > > > > +       req =3D list_first_entry_or_null(&fc->bg_queue, struct fu=
se_req, list);
> > > > > +       if (req)
> > > > > +               expired =3D request_expired(fc, req, hang_check_t=
imer);
> > > > > +       spin_unlock(&fc->bg_lock);
> > > > > +       if (expired)
> > > > > +               goto abort_conn;
> > > > > +
> > > > > +       spin_lock(&fc->lock);
> > > > > +       if (!fc->connected) {
> > > > > +               spin_unlock(&fc->lock);
> > > > > +               return;
> > > > > +       }
> > > > > +       list_for_each_entry(fud, &fc->devices, entry) {
> > > > > +               fpq =3D &fud->pq;
> > > > > +               spin_lock(&fpq->lock);
> > > > > +               req =3D list_first_entry_or_null(&fpq->io, struct=
 fuse_req, list);
> > > > > +               if (req && request_expired(fc, req, hang_check_ti=
mer))
> > > > > +                       goto fpq_abort;
> > > > > +
> > > > > +               for (i =3D 0; i < FUSE_PQ_HASH_SIZE; i++) {
> > > > > +                       req =3D list_first_entry_or_null(&fpq->pr=
ocessing[i], struct fuse_req, list);
> > > > > +                       if (req && request_expired(fc, req, hang_=
check_timer))
> > > > > +                               goto fpq_abort;
> > > > > +               }
> > > > > +               spin_unlock(&fpq->lock);
> > > > > +       }
> > > > > +       /* Keep the ball rolling */
> > > > > +       if (atomic_read(&fc->num_waiting) !=3D 0)
> > > > > +               queue_delayed_work(system_wq, &fc->work, hang_che=
ck_timer);
> > > > > +       spin_unlock(&fc->lock);
> > > > > +       return;
> > > > > +
> > > > > +fpq_abort:
> > > > > +       spin_unlock(&fpq->lock);
> > > > > +       spin_unlock(&fc->lock);
> > > > > +abort_conn:
> > > > > +       fuse_abort_conn(fc);
> > > > > +}
> > > > > +
> > > > >  static void fuse_request_init(struct fuse_mount *fm, struct fuse=
_req *req)
> > > > >  {
> > > > > +       struct fuse_conn *fc =3D fm->fc;
> > > > >         INIT_LIST_HEAD(&req->list);
> > > > >         INIT_LIST_HEAD(&req->intr_entry);
> > > > >         init_waitqueue_head(&req->waitq);
> > > > >         refcount_set(&req->count, 1);
> > > > >         __set_bit(FR_PENDING, &req->flags);
> > > > >         req->fm =3D fm;
> > > > > +       req->create_time =3D jiffies;
> > > > > +
> > > > > +       if (sysctl_hung_task_panic) {
> > > > > +               spin_lock(&fc->lock);
> > > > > +               /* Get the ball rolling */
> > > > > +               queue_delayed_work(system_wq, &fc->work,
> > > > > +                               sysctl_hung_task_timeout_secs * (=
HZ / 2));
> > > > > +               spin_unlock(&fc->lock);
> > > > > +       }
> > > > >  }
> > > > >
> > > > >  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm=
, gfp_t flags)
> > > > > @@ -200,6 +292,14 @@ static void fuse_put_request(struct fuse_req=
 *req)
> > > > >                         fuse_drop_waiting(fc);
> > > > >                 }
> > > > >
> > > > > +               if (sysctl_hung_task_panic) {
> > > > > +                       spin_lock(&fc->lock);
> > > > > +                       /* Stop the timeout check if we are the l=
ast request */
> > > > > +                       if (atomic_read(&fc->num_waiting) =3D=3D =
0)
> > > > > +                               cancel_delayed_work_sync(&fc->wor=
k);
> > > > > +                       spin_unlock(&fc->lock);
> > > > > +               }
> > > > > +
> > > > >                 fuse_request_free(req);
> > > > >         }
> > > > >  }
> > > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > > index 74744c6f2860..aba3ffd0fb67 100644
> > > > > --- a/fs/fuse/fuse_i.h
> > > > > +++ b/fs/fuse/fuse_i.h
> > > > > @@ -438,6 +438,9 @@ struct fuse_req {
> > > > >
> > > > >         /** fuse_mount this request belongs to */
> > > > >         struct fuse_mount *fm;
> > > > > +
> > > > > +       /** When (in jiffies) the request was created */
> > > > > +       unsigned long create_time;
> > > > >  };
> > > > >
> > > > >  struct fuse_iqueue;
> > > > > @@ -923,6 +926,9 @@ struct fuse_conn {
> > > > >         /** IDR for backing files ids */
> > > > >         struct idr backing_files_map;
> > > > >  #endif
> > > > > +
> > > > > +       /** Request wait timeout check */
> > > > > +       struct delayed_work work;
> > > > >  };
> > > > >
> > > > >  /*
> > > > > @@ -1190,6 +1196,8 @@ void fuse_request_end(struct fuse_req *req)=
;
> > > > >  /* Abort all requests */
> > > > >  void fuse_abort_conn(struct fuse_conn *fc);
> > > > >  void fuse_wait_aborted(struct fuse_conn *fc);
> > > > > +/* Connection timeout */
> > > > > +void fuse_check_timeout(struct work_struct *wk);
> > > > >
> > > > >  /**
> > > > >   * Invalidate inode attributes
> > > > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > > > index 3ce4f4e81d09..ed96154df0fd 100644
> > > > > --- a/fs/fuse/inode.c
> > > > > +++ b/fs/fuse/inode.c
> > > > > @@ -23,6 +23,7 @@
> > > > >  #include <linux/exportfs.h>
> > > > >  #include <linux/posix_acl.h>
> > > > >  #include <linux/pid_namespace.h>
> > > > > +#include <linux/completion.h>
> > > > >  #include <uapi/linux/magic.h>
> > > > >
> > > > >  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> > > > > @@ -964,6 +965,7 @@ void fuse_conn_init(struct fuse_conn *fc, str=
uct fuse_mount *fm,
> > > > >         INIT_LIST_HEAD(&fc->entry);
> > > > >         INIT_LIST_HEAD(&fc->devices);
> > > > >         atomic_set(&fc->num_waiting, 0);
> > > > > +       INIT_DELAYED_WORK(&fc->work, fuse_check_timeout);
> > > > >         fc->max_background =3D FUSE_DEFAULT_MAX_BACKGROUND;
> > > > >         fc->congestion_threshold =3D FUSE_DEFAULT_CONGESTION_THRE=
SHOLD;
> > > > >         atomic64_set(&fc->khctr, 0);
> > > > > @@ -1015,6 +1017,7 @@ void fuse_conn_put(struct fuse_conn *fc)
> > > > >                 if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> > > > >                         fuse_backing_files_free(fc);
> > > > >                 call_rcu(&fc->rcu, delayed_release);
> > > > > +               cancel_delayed_work_sync(&fc->work);
> > > > >         }
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(fuse_conn_put);
> > > > > diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/s=
ysctl.h
> > > > > index 5a64582b086b..1ed3a511060d 100644
> > > > > --- a/include/linux/sched/sysctl.h
> > > > > +++ b/include/linux/sched/sysctl.h
> > > > > @@ -5,11 +5,15 @@
> > > > >  #include <linux/types.h>
> > > > >
> > > > >  #ifdef CONFIG_DETECT_HUNG_TASK
> > > > > -/* used for hung_task and block/ */
> > > > > +/* used for hung_task, block/ and fuse */
> > > > >  extern unsigned long sysctl_hung_task_timeout_secs;
> > > > > +extern unsigned int sysctl_hung_task_panic;
> > > > >  #else
> > > > >  /* Avoid need for ifdefs elsewhere in the code */
> > > > > -enum { sysctl_hung_task_timeout_secs =3D 0 };
> > > > > +enum {
> > > > > +       sysctl_hung_task_timeout_secs =3D 0,
> > > > > +       sysctl_hung_task_panic =3D 0,
> > > > > +};
> > > > >  #endif
> > > > >
> > > > >  enum sched_tunable_scaling {
> > > > > diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> > > > > index c18717189f32..16602d3754b1 100644
> > > > > --- a/kernel/hung_task.c
> > > > > +++ b/kernel/hung_task.c
> > > > > @@ -78,8 +78,9 @@ static unsigned int __read_mostly sysctl_hung_t=
ask_all_cpu_backtrace;
> > > > >   * Should we panic (and reboot, if panic_timeout=3D is set) when=
 a
> > > > >   * hung task is detected:
> > > > >   */
> > > > > -static unsigned int __read_mostly sysctl_hung_task_panic =3D
> > > > > +unsigned int __read_mostly sysctl_hung_task_panic =3D
> > > > >         IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
> > > > > +EXPORT_SYMBOL_GPL(sysctl_hung_task_panic);
> > > > >
> > > > >  static int
> > > > >  hung_task_panic(struct notifier_block *this, unsigned long event=
, void *ptr)
> > > > > --
> > > > > 2.34.1
> > > > >

