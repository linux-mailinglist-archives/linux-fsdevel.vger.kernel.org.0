Return-Path: <linux-fsdevel+bounces-38129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D779FC629
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 18:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E1316337D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 17:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306641B4F1E;
	Wed, 25 Dec 2024 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HpN/p0tl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB0F1F602
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Dec 2024 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735148481; cv=none; b=SodFAiDR6jgVpCLB57AhmkvefNDOwaIlKGT28g9EAAPawFr+nttel7ppE3/cg/qPBC8qLMWS4Ssg33pPB0j7xQEL7Axw4PxZtDn8gPglGXMtQBqxCoGmhy4m+2xzIC084q6V0v7Z2a4a1iYDaeA73p12TXdXoP+naX0AzTviZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735148481; c=relaxed/simple;
	bh=Opmg+6zocmtsN1c4kzR+OKQn2K9N9rtc+4a1qL5K9BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rmh3NucOTlpzIPZES8TWOYkc2Re2hN5L1yZz0GnaQ3k4osp8+BGt3ftEVA0I1UfJCUoYJzAkm8YFSCBpFfKOwQEdCCsSwosISStAmUYBghAqOHFt+j3ZHcCNQMOvT/dH+NO07uaAzhlei9vQWxXU4fFSyTuq9fZ/0tpy36GYmm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HpN/p0tl; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Dec 2024 12:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735148476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZLlmVu/PPwyyt3dWORXTtbOXrBNCmYx7Otm+xiAn9g=;
	b=HpN/p0tlNCZOsgMa15L5gkI2s9Lvq5gKPUiXEVnNnA+GM0GT0sLp0WoI6ywz/DfSCCBRFb
	JCC30KtpBcI5kHG60uRFv4/ZhPDu9RFqW3vvSOW0EskrMBVZhkc1gdNFt7Kf7sis8HXKTg
	LW+J5XoNpUkDb63O73Fke744bMopwoc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	WangYuli <wangyuli@uniontech.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, yushengjin@uniontech.com, 
	zhangdandan@uniontech.com, guanwentao@uniontech.com, zhanjun@uniontech.com, 
	oliver.sang@intel.com, ebiederm@xmission.com, colin.king@canonical.com, 
	josh@joshtriplett.org, penberg@cs.helsinki.fi, manfred@colorfullife.com, mingo@elte.hu, 
	jes@sgi.com, hch@lst.de, aia21@cantab.net, arjan@infradead.org, 
	jgarzik@pobox.com, neukum@fachschaft.cup.uni-muenchen.de, oliver@neukum.name, 
	dada1@cosmosbay.com, axboe@kernel.dk, axboe@suse.de, nickpiggin@yahoo.com.au, 
	dhowells@redhat.com, nathans@sgi.com, rolandd@cisco.com, tytso@mit.edu, 
	bunk@stusta.de, pbadari@us.ibm.com, ak@linux.intel.com, ak@suse.de, 
	davem@davemloft.net, jsipek@cs.sunysb.edu
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <ac4d3fu6pjiz3x3cm4s4xkauohqiyunetrzoozsdo2bk523tql@4yw52tbo37hn>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <Z2wI3dmmrhMRT-48@smile.fi.intel.com>
 <am7mlhd67ymicifo6qi56pw4e34cj3623drir3rvtisezpl4eu@e5zpca7g5ayy>
 <4tee2rwpqjmx7jj5poxxelv4sp2jyw6nuhpiwrlpv2lurgvpmz@3paxwuit47i6>
 <gspf7guqczppgfrus5lfhinyl62xezc4h7nqcnd4m7243v4mna@hxmu2wousrh7>
 <CAGudoHGzNxOzXz78BXF4fOiDAYRpD0_dmLsyTWAAVq0ms2vVZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGzNxOzXz78BXF4fOiDAYRpD0_dmLsyTWAAVq0ms2vVZg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 25, 2024 at 06:22:49PM +0100, Mateusz Guzik wrote:
> On Wed, Dec 25, 2024 at 5:32 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Wed, Dec 25, 2024 at 05:04:46PM +0100, Mateusz Guzik wrote:
> > > On Wed, Dec 25, 2024 at 08:53:05AM -0500, Kent Overstreet wrote:
> > > > On Wed, Dec 25, 2024 at 03:30:05PM +0200, Andy Shevchenko wrote:
> > > > > Don't you think the Cc list is a bit overloaded?
> > > >
> > > > Indeed, my mail server doesn't let me reply-all.
> > > >
> > > > > On Wed, Dec 25, 2024 at 05:42:02PM +0800, WangYuli wrote:
> > > > > > +config PIPE_SKIP_SLEEPER
> > > > > > +       bool "Skip sleeping processes during pipe read/write"
> > > > > > +       default n
> > > > >
> > > > > 'n' is the default 'default', no need to have this line.
> > > >
> > > > Actually, I'd say to skip the kconfig option for this. Kconfig options
> > > > that affect the behaviour of core code increase our testing burden, and
> > > > are another variable to account for when chasing down bugs, and the
> > > > potential overhead looks negligable.
> > > >
> > >
> > > I agree the behavior should not be guarded by an option. However,
> > > because of how wq_has_sleeper is implemented (see below) I would argue
> > > this needs to show how often locking can be avoided in real workloads.
> > >
> > > The commit message does state this comes with a slowdown for cases which
> > > can't avoid wakeups, but as is I thought the submitter just meant an
> > > extra branch.
> > >
> > > > Also, did you look at adding this optimization to wake_up()? No-op
> > > > wakeups are very common, I think this has wider applicability.
> > >
> > > I was going to suggest it myself, but then:
> > >
> > > static inline bool wq_has_sleeper(struct wait_queue_head *wq_head)
> > > {
> > >         /*
> > >          * We need to be sure we are in sync with the
> > >          * add_wait_queue modifications to the wait queue.
> > >          *
> > >          * This memory barrier should be paired with one on the
> > >          * waiting side.
> > >          */
> > >         smp_mb();
> > >         return waitqueue_active(wq_head);
> > > }
> > >
> > > Which means this is in fact quite expensive.
> > >
> > > Since wakeup is a lock + an interrupt trip, it would still be
> > > cheaper single-threaded to "merely" suffer a full fence and for cases
> > > where the queue is empty often enough this is definitely the right thing
> > > to do.
> >
> > We're comparing against no-op wakeup. A real wakeup does an IPI, which
> > completely dwarfs the cost of a barrier.
> >
> > And note that wake_up() is spin_lock_irqsave(), not spin_lock(). I
> > assume it's gotten better, but back when I was looking at waitqueues
> > nested pushf/popf was horrifically expensive.
> >
> > But perhaps can we do this with just a release barrier? Similar to how
> > list_empty_careful() works.
> >
> > > On the other hand this executing when the queue is mostly *not* empty
> > > would combat the point.
> > >
> > > So unfortunately embedding this in wake_up is a no-go.
> >
> > You definitely can't say that without knowing how often no-op
> > wake_up()s occur. It wouldn't be hard to gather that (write a patch to
> > add a pair of percpu counters, throw it on a few machines running random
> > workloads) and I think the results might surprise you.
> 
> There is some talking past each other here.
> 
> I explicitly noted one needs to check what happens in real workloads.
> 
> I very much expect there will be consumers where there are no waiters
> almost every time and consumers which almost always do have them.
> 
> My claim is that this should be handled on a case-by-case basis.
> 
> So i whipped out a bpftrace one liner do take a look at the kernel
> build, details at the end.
> 
> In terms of the total (0 == no waiters, 1 == waiters):
> [0, 1)            600191 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [1, ...)          457956 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@             |
> 
> There is some funzies in the vfs layer which I'm going to sort out myself.
> 
> The kernel is tags/next-20241220
> 
> As far as pipes go:
> 
> @[
>     wakeprobe+5
>     __wake_up_common+63
>     __wake_up_sync_key+59
>     pipe_read+385
> ]:
> [0, 1)             10629 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 
> So this guy literally never had any waiters when wakeup was issued.
> faddr2line claims line 405, which I presume is off by one:
> 
>    401         if (was_full)
>    402                 wake_up_interruptible_sync_poll(&pipe->wr_wait,
> EPOLLOUT | EPOLLWRNORM);
>    403         if (wake_next_reader)
>    404         │       wake_up_interruptible_sync_poll(&pipe->rd_wait,
> EPOLLIN | EPOLLRDNORM);
>    405         kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> 
> I'm guessing the real empty queue is rd_wait. Definitely a candidate
> depending on other workloads, personally I would just patch it as is.
> 
> @[
>     wakeprobe+5
>     __wake_up_common+63
>     __wake_up+54
>     pipe_release+92
> ]:
> [0, 1)             12540 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [1, ...)            5330 |@@@@@@@@@@@@@@@@@@@@@@                              |
> 
> a wash, would not touch that no matter what
> 
> @[
>     wakeprobe+5
>     __wake_up_common+63
>     __wake_up+54
>     pipe_release+110
> ]:
> [0, 1)             17870 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 
> again no waiters, line claimed is 737, again off by one:
>    733         /* Was that the last reader or writer, but not the other side? */
>    734         if (!pipe->readers != !pipe->writers) {
>    735         │       wake_up_interruptible_all(&pipe->rd_wait);
>    736         │       wake_up_interruptible_all(&pipe->wr_wait);
>    737         │       kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>    738         │       kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> 
> so I presume wr_wait? same comment as the entry at claimed line 405
> 
> @[
>     wakeprobe+5
>     __wake_up_common+63
>     __wake_up_sync_key+59
>     pipe_write+773
> ]:
> [0, 1)             22237 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 
> again no waiters, claimed line 606
>    604         if (wake_next_writer)
>    605         │       wake_up_interruptible_sync_poll(&pipe->wr_wait,
> EPOLLOUT | EPOLLWRNORM);
>    606         if (ret > 0 && sb_start_write_trylock(file_inode(filp)->i_sb)) {
> 
> again would be inclined to patch as is
> 
> @[
>     wakeprobe+5
>     __wake_up_common+63
>     __wake_up_sync_key+59
>     pipe_read+943
> ]:
> [0, 1)              9488 |@@@@@@@@@@@@@                                       |
> [1, ...)           35765 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 
> majority of the time there were waiters, would not touch regardless of
> other workloads, line 403
> 
>    401         if (was_full)
>    402                 wake_up_interruptible_sync_poll(&pipe->wr_wait,
> EPOLLOUT | EPOLLWRNORM);
>    403         if (wake_next_reader)
>    404         │       wake_up_interruptible_sync_poll(&pipe->rd_wait,
> EPOLLIN | EPOLLRDNORM);
> 
> the wr_wait thing
> 
> @[
>     wakeprobe+5
>     __wake_up_common+63
>     __wake_up_sync_key+59
>     pipe_write+729
> ]:
> [0, 1)            199929 |@@@@@@@@@@@@@@@@@@@@@@@@@@@                         |
> [1, ...)          376586 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 
> ditto concerning not touching, resolved to line 603
> 
>    601         if (was_empty || pipe->poll_usage)
>    602         │       wake_up_interruptible_sync_poll(&pipe->rd_wait,
> EPOLLIN | EPOLLRDNORM);
>    603         kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>    604         if (wake_next_writer)
>    605                 wake_up_interruptible_sync_poll(&pipe->wr_wait,
> EPOLLOUT | EPOLLWRNORM);
> 
> That is to say as far as this workload goes the submitted patch does
> avoid some of the lock + irq trips by covering cases where there no
> waiters seen in this workload, but also adds the smp_mb thing when it
> does not help -- I would remove those spots from the submission.

Neat use of bpf, although if you had to patch the kernel anyways I
would've just gone the percpu counter route... :)

Based on those numbers, even in the cases where wake-up dominates it
doesn't dominate by enough that I'd expect the patch to cause a
regression, at least if we can do it with a proper release barrier.

Why is smp_load_release() not a thing? Unusual I suppose, but it is what
we want here...

