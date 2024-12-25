Return-Path: <linux-fsdevel+bounces-38127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EF19FC621
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 18:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63B8163329
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860EC1428E7;
	Wed, 25 Dec 2024 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiPAsCdV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19BF45C1C;
	Wed, 25 Dec 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735147385; cv=none; b=q2D3nMG3U+wiMa97lzYrB8/JcKkcrONw+NNJjL/W/KDzqWWb2gJumkJ5+0TmIk9oW6RBjhoVmHhhF2MdEZZi8qsMudZGHiult7w12ZwTxJaiVgs1emJYZKFHWzNC50CWwM1fXkCPNIyXWvBxbqy5YOO9x02BlJXLTU43i/coU58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735147385; c=relaxed/simple;
	bh=LP81lLwUvBK3XaUesYYfWKDDNT/upROLgaDheJDnRHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXE8Jsu77XIjT8f794BmFiX49BT5ao8mbfnkUPWjfpkgK64Mux1F762RT2FmVwsnzZHbyMtxm512DF6CB+ZsuBBgkwqUNz2K15b0Xf/bG9fTNmqga86ShAW+H8bV/mJd3DXAddplxotxhW2a7HuAAX6IHkjq+dhC6s5luiVph9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiPAsCdV; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so7631151a12.1;
        Wed, 25 Dec 2024 09:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735147381; x=1735752181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxH6s2aKkYmSMRGaK6U17jVomQOo0sDpianrXJp6I1c=;
        b=UiPAsCdV9+UDvAwwZVohfxjf0SmiSxTNhvn9NIevmZYckG0T7xf0MmaXz68GAsFdmb
         FecMGj2EZdcwAr593abBbqrv5IM1HAuvWMZctqLDwtVjm6KNr0XuRH3AQbTGl/WJdqsC
         4V8q+/RJEjGutaHLpLY51K/P0Bv7cC//S9oRumSzLmO//JeYEm0QE/+4ZlBumK7Ow02R
         5KsjHG4YVQMW71IbEtnasFuOLEoxzw+mwqzsc7CQb2G886/PDzyZgyULm41zrrZXKoDn
         J2UFHCNHYskkuErNoeM0ODWG+kaRy145/efLkEZJrz15TQKIsUJUuSnISPDEYtzksiUw
         WwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735147381; x=1735752181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxH6s2aKkYmSMRGaK6U17jVomQOo0sDpianrXJp6I1c=;
        b=TljinKP1hU/ep6evBseGFSFj5BMKfSXIjL4+QbvAzwU+Iw3O5y2dKN5ltVxnqQwkRZ
         bV42VIq08sYBKru2jS5TmmY1oX5BTfHrH6eINZmwkdLnaW6qIJ4S9Ti2QLXdamd7gmwo
         2xORGYD5rN93Hb1QZfkSdcwLwoqIQL51zQxYbfj5Bd8W2dt5U2MqucmAOSfaOVjH5o9x
         ZM7FnYOBXa5ptvqEmG5eU75m6EgqgGs1aqnGyvZz42a01M69ATjfuv7euS2QSloVzdD8
         p2SKfdEojke4D67x1xq93GW/mzFjazqc29y2HmWOhcLMSm6swr9mkAoXq/NlAJ9w9wi0
         SF3A==
X-Forwarded-Encrypted: i=1; AJvYcCVNavOGbjWPJmSQH1TgLk0xohHACJYlDfzSS1V3GLfqTr1GL5EIVn6WcK3RfKfbwmMMfJAotPhyIXqZ1/WT@vger.kernel.org, AJvYcCXy0vKNi1J8yYNid5uHfjYLnV1g/K5Ldk9FFftEfc5GLwMQxr4IB5oszWJqwv36QM9MHoYe1JRQqfFxkuIr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4oIxNFjOuFNLd9u7eq4Tg6Xkn1J/fHGWFER6tMH43QBxaasQe
	uR3WaReMdkmBF0XECYsM0lrMh+UkvMFT5s6aUxm+aqKfxf8727COTNdPGhZhfcwMKAGM53122Kl
	FcD2em4J6ePBWdf/g45UXM/lwhGs=
X-Gm-Gg: ASbGncsecXpm/AuUPUO+YHqtxIgWPNu2z2LFC+t/cRHufQPlbIAEmmfrf/bYa91oSEn
	/ifXnQuuzmd31zoGKnBhWB0oF+LF5S1Y3Cxx5lA==
X-Google-Smtp-Source: AGHT+IE+g4qOWSywlDicEqlKvDR52sgGrqRCOuBsfoGRfHQWdRt+fWLiZGejBfZAO6QPVagxIIsn2+uyVPuuw2uLfDE=
X-Received: by 2002:a05:6402:5256:b0:5d3:ba42:ea03 with SMTP id
 4fb4d7f45d1cf-5d81dd8df7cmr18403966a12.8.1735147380825; Wed, 25 Dec 2024
 09:23:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <Z2wI3dmmrhMRT-48@smile.fi.intel.com> <am7mlhd67ymicifo6qi56pw4e34cj3623drir3rvtisezpl4eu@e5zpca7g5ayy>
 <4tee2rwpqjmx7jj5poxxelv4sp2jyw6nuhpiwrlpv2lurgvpmz@3paxwuit47i6> <gspf7guqczppgfrus5lfhinyl62xezc4h7nqcnd4m7243v4mna@hxmu2wousrh7>
In-Reply-To: <gspf7guqczppgfrus5lfhinyl62xezc4h7nqcnd4m7243v4mna@hxmu2wousrh7>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 25 Dec 2024 18:22:49 +0100
Message-ID: <CAGudoHGzNxOzXz78BXF4fOiDAYRpD0_dmLsyTWAAVq0ms2vVZg@mail.gmail.com>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, WangYuli <wangyuli@uniontech.com>, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yushengjin@uniontech.com, zhangdandan@uniontech.com, guanwentao@uniontech.com, 
	zhanjun@uniontech.com, oliver.sang@intel.com, ebiederm@xmission.com, 
	colin.king@canonical.com, josh@joshtriplett.org, penberg@cs.helsinki.fi, 
	manfred@colorfullife.com, mingo@elte.hu, jes@sgi.com, hch@lst.de, 
	aia21@cantab.net, arjan@infradead.org, jgarzik@pobox.com, 
	neukum@fachschaft.cup.uni-muenchen.de, oliver@neukum.name, 
	dada1@cosmosbay.com, axboe@kernel.dk, axboe@suse.de, nickpiggin@yahoo.com.au, 
	dhowells@redhat.com, nathans@sgi.com, rolandd@cisco.com, tytso@mit.edu, 
	bunk@stusta.de, pbadari@us.ibm.com, ak@linux.intel.com, ak@suse.de, 
	davem@davemloft.net, jsipek@cs.sunysb.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 25, 2024 at 5:32=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Wed, Dec 25, 2024 at 05:04:46PM +0100, Mateusz Guzik wrote:
> > On Wed, Dec 25, 2024 at 08:53:05AM -0500, Kent Overstreet wrote:
> > > On Wed, Dec 25, 2024 at 03:30:05PM +0200, Andy Shevchenko wrote:
> > > > Don't you think the Cc list is a bit overloaded?
> > >
> > > Indeed, my mail server doesn't let me reply-all.
> > >
> > > > On Wed, Dec 25, 2024 at 05:42:02PM +0800, WangYuli wrote:
> > > > > +config PIPE_SKIP_SLEEPER
> > > > > +       bool "Skip sleeping processes during pipe read/write"
> > > > > +       default n
> > > >
> > > > 'n' is the default 'default', no need to have this line.
> > >
> > > Actually, I'd say to skip the kconfig option for this. Kconfig option=
s
> > > that affect the behaviour of core code increase our testing burden, a=
nd
> > > are another variable to account for when chasing down bugs, and the
> > > potential overhead looks negligable.
> > >
> >
> > I agree the behavior should not be guarded by an option. However,
> > because of how wq_has_sleeper is implemented (see below) I would argue
> > this needs to show how often locking can be avoided in real workloads.
> >
> > The commit message does state this comes with a slowdown for cases whic=
h
> > can't avoid wakeups, but as is I thought the submitter just meant an
> > extra branch.
> >
> > > Also, did you look at adding this optimization to wake_up()? No-op
> > > wakeups are very common, I think this has wider applicability.
> >
> > I was going to suggest it myself, but then:
> >
> > static inline bool wq_has_sleeper(struct wait_queue_head *wq_head)
> > {
> >         /*
> >          * We need to be sure we are in sync with the
> >          * add_wait_queue modifications to the wait queue.
> >          *
> >          * This memory barrier should be paired with one on the
> >          * waiting side.
> >          */
> >         smp_mb();
> >         return waitqueue_active(wq_head);
> > }
> >
> > Which means this is in fact quite expensive.
> >
> > Since wakeup is a lock + an interrupt trip, it would still be
> > cheaper single-threaded to "merely" suffer a full fence and for cases
> > where the queue is empty often enough this is definitely the right thin=
g
> > to do.
>
> We're comparing against no-op wakeup. A real wakeup does an IPI, which
> completely dwarfs the cost of a barrier.
>
> And note that wake_up() is spin_lock_irqsave(), not spin_lock(). I
> assume it's gotten better, but back when I was looking at waitqueues
> nested pushf/popf was horrifically expensive.
>
> But perhaps can we do this with just a release barrier? Similar to how
> list_empty_careful() works.
>
> > On the other hand this executing when the queue is mostly *not* empty
> > would combat the point.
> >
> > So unfortunately embedding this in wake_up is a no-go.
>
> You definitely can't say that without knowing how often no-op
> wake_up()s occur. It wouldn't be hard to gather that (write a patch to
> add a pair of percpu counters, throw it on a few machines running random
> workloads) and I think the results might surprise you.

There is some talking past each other here.

I explicitly noted one needs to check what happens in real workloads.

I very much expect there will be consumers where there are no waiters
almost every time and consumers which almost always do have them.

My claim is that this should be handled on a case-by-case basis.

So i whipped out a bpftrace one liner do take a look at the kernel
build, details at the end.

In terms of the total (0 =3D=3D no waiters, 1 =3D=3D waiters):
[0, 1)            600191 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[1, ...)          457956 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@          =
   |

There is some funzies in the vfs layer which I'm going to sort out myself.

The kernel is tags/next-20241220

As far as pipes go:

@[
    wakeprobe+5
    __wake_up_common+63
    __wake_up_sync_key+59
    pipe_read+385
]:
[0, 1)             10629 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|

So this guy literally never had any waiters when wakeup was issued.
faddr2line claims line 405, which I presume is off by one:

   401         if (was_full)
   402                 wake_up_interruptible_sync_poll(&pipe->wr_wait,
EPOLLOUT | EPOLLWRNORM);
   403         if (wake_next_reader)
   404         =E2=94=82       wake_up_interruptible_sync_poll(&pipe->rd_wa=
it,
EPOLLIN | EPOLLRDNORM);
   405         kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);

I'm guessing the real empty queue is rd_wait. Definitely a candidate
depending on other workloads, personally I would just patch it as is.

@[
    wakeprobe+5
    __wake_up_common+63
    __wake_up+54
    pipe_release+92
]:
[0, 1)             12540 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[1, ...)            5330 |@@@@@@@@@@@@@@@@@@@@@@                           =
   |

a wash, would not touch that no matter what

@[
    wakeprobe+5
    __wake_up_common+63
    __wake_up+54
    pipe_release+110
]:
[0, 1)             17870 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|

again no waiters, line claimed is 737, again off by one:
   733         /* Was that the last reader or writer, but not the other sid=
e? */
   734         if (!pipe->readers !=3D !pipe->writers) {
   735         =E2=94=82       wake_up_interruptible_all(&pipe->rd_wait);
   736         =E2=94=82       wake_up_interruptible_all(&pipe->wr_wait);
   737         =E2=94=82       kill_fasync(&pipe->fasync_readers, SIGIO, PO=
LL_IN);
   738         =E2=94=82       kill_fasync(&pipe->fasync_writers, SIGIO, PO=
LL_OUT);

so I presume wr_wait? same comment as the entry at claimed line 405

@[
    wakeprobe+5
    __wake_up_common+63
    __wake_up_sync_key+59
    pipe_write+773
]:
[0, 1)             22237 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|

again no waiters, claimed line 606
   604         if (wake_next_writer)
   605         =E2=94=82       wake_up_interruptible_sync_poll(&pipe->wr_wa=
it,
EPOLLOUT | EPOLLWRNORM);
   606         if (ret > 0 && sb_start_write_trylock(file_inode(filp)->i_sb=
)) {

again would be inclined to patch as is

@[
    wakeprobe+5
    __wake_up_common+63
    __wake_up_sync_key+59
    pipe_read+943
]:
[0, 1)              9488 |@@@@@@@@@@@@@                                    =
   |
[1, ...)           35765 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|

majority of the time there were waiters, would not touch regardless of
other workloads, line 403

   401         if (was_full)
   402                 wake_up_interruptible_sync_poll(&pipe->wr_wait,
EPOLLOUT | EPOLLWRNORM);
   403         if (wake_next_reader)
   404         =E2=94=82       wake_up_interruptible_sync_poll(&pipe->rd_wa=
it,
EPOLLIN | EPOLLRDNORM);

the wr_wait thing

@[
    wakeprobe+5
    __wake_up_common+63
    __wake_up_sync_key+59
    pipe_write+729
]:
[0, 1)            199929 |@@@@@@@@@@@@@@@@@@@@@@@@@@@                      =
   |
[1, ...)          376586 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|

ditto concerning not touching, resolved to line 603

   601         if (was_empty || pipe->poll_usage)
   602         =E2=94=82       wake_up_interruptible_sync_poll(&pipe->rd_wa=
it,
EPOLLIN | EPOLLRDNORM);
   603         kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
   604         if (wake_next_writer)
   605                 wake_up_interruptible_sync_poll(&pipe->wr_wait,
EPOLLOUT | EPOLLWRNORM);

That is to say as far as this workload goes the submitted patch does
avoid some of the lock + irq trips by covering cases where there no
waiters seen in this workload, but also adds the smp_mb thing when it
does not help -- I would remove those spots from the submission.

While I agree a full service treatment would require a bunch of
different workloads, personally I would be inclined justify the change
merely based on the kernel build + leaving bpftrace running over some
a real-world box running random crap.

As for obtaining such info, I failed to convince bpftrace to check if
the waiter list is empty. Instead I resorted to adding a dedicated
func which grabs the bit and probing on that. The func is in a
different file because gcc decided to omit the call otherwise

one-liner:
bpftrace -e 'kprobe:wakeprobe { @[kstack(4)] =3D lhist(arg0, 0, 1, 1); }'

hack:
diff --git a/fs/file.c b/fs/file.c
index d868cdb95d1e..00d6a34eb174 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1442,3 +1442,11 @@ int iterate_fd(struct files_struct *files, unsigned =
n,
        return res;
 }
 EXPORT_SYMBOL(iterate_fd);
+
+
+void wakeprobe(int count);
+
+void wakeprobe(int count)
+{
+}
+EXPORT_SYMBOL(wakeprobe);
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 51e38f5f4701..8db7b0daf04b 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -57,6 +57,8 @@ void remove_wait_queue(struct wait_queue_head
*wq_head, struct wait_queue_entry
 }
 EXPORT_SYMBOL(remove_wait_queue);

+void wakeprobe(int count);
+
 /*
  * The core wakeup function. Non-exclusive wakeups (nr_exclusive =3D=3D 0)=
 just
  * wake everything up. If it's an exclusive wakeup (nr_exclusive =3D=3D sm=
all +ve
@@ -77,6 +79,8 @@ static int __wake_up_common(struct wait_queue_head
*wq_head, unsigned int mode,

        lockdep_assert_held(&wq_head->lock);

+       wakeprobe(wq_has_sleeper(wq_head));
+
        curr =3D list_first_entry(&wq_head->head, wait_queue_entry_t, entry=
);

        if (&curr->entry =3D=3D &wq_head->head)


--=20
Mateusz Guzik <mjguzik gmail.com>

