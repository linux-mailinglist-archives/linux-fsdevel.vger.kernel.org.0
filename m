Return-Path: <linux-fsdevel+bounces-62484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242A9B94B8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 09:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1D23AC918
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 07:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336343112C1;
	Tue, 23 Sep 2025 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i/vFblrX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539430F7FE;
	Tue, 23 Sep 2025 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611792; cv=none; b=Hb11jqLm+lEJylViVLXJN7/YsJe5V7R+MeRJXGs+hLsrmZsnSXNRZcIgDoG9kfDxYRj4qdPiEdj7dBxiMZaG2DonNfTvLoBJhpNaASOuijFl7gfQoEOqmMPUx9Zg+xibw9U7mI85rMTUGxMNeKzVPkp7PWFrMw5j0Bietn3jHq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611792; c=relaxed/simple;
	bh=5fDKVF0izRWroWruPprDXuZ/aZYH/dSrSsguDThEDK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YN8gflZW+rQoOdUETs1w/aNfDp8LesnZYEP9iderT+NXDK+A5mYYfnzI2GTiLHuRuen80m63ZP6kdQYdk8CUlEYg32nwofTFM0K4qcjWb9G4EEeh96XIwH2MAUqijRtcdvtteVgCgnrSIwcJabNBF7u17VZ6vLoXUuzrzrV12cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i/vFblrX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gr21sE64KSAPJhmA+bz5GYsvn97jNvphWwGOnPhZYQg=; b=i/vFblrX/G8e6OLXGvktviUrqu
	/dRaH+KC6I+ldSGmqV3SNGsnvCGwKxxSjC/TZXOWTGXpu4M3dsH17R6MkBkL/d8egR7H16VbAeirY
	Ej6qwCrx8QSEpuTVex8yVeSs2Owfi2RgeO7SIohXpFb3yaspKtUnnyoBw8GETWq0R+tZPqh/zooX5
	xYKtBQiZF3wgomx3Bku5NXcBN2yrtijVKq+1WTMU3t1Q+20sVRACkOLDCWHWusoJ85isXxfd5XQqh
	LRKaggUGUYY/30UY6nFEJQ7YcBf90Tv3/Y/P3sqsLoBsgRIH+ebgSP1KtoCOE6wX9mkIgxktnUWAz
	rY4pPfig==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0xFw-00000008Ti2-468P;
	Tue, 23 Sep 2025 07:16:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A3CC530049C; Tue, 23 Sep 2025 09:16:07 +0200 (CEST)
Date: Tue, 23 Sep 2025 09:16:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Julian Sun <sunjunchao@bytedance.com>, cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, lance.yang@linux.dev,
	mhiramat@kernel.org, agruenba@redhat.com, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
Message-ID: <20250923071607.GR3245006@noisy.programming.kicks-ass.net>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
 <20250922132718.GB49638@noisy.programming.kicks-ass.net>
 <aNGQoPFTH2_xrd9L@infradead.org>
 <20250922145045.afc6593b4e91c55d8edefabb@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922145045.afc6593b4e91c55d8edefabb@linux-foundation.org>

On Mon, Sep 22, 2025 at 02:50:45PM -0700, Andrew Morton wrote:
> On Mon, 22 Sep 2025 11:08:32 -0700 Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Mon, Sep 22, 2025 at 03:27:18PM +0200, Peter Zijlstra wrote:
> > > > Julian Sun (3):
> > > >   sched: Introduce a new flag PF_DONT_HUNG.
> > > >   writeback: Introduce wb_wait_for_completion_no_hung().
> > > >   memcg: Don't trigger hung task when memcg is releasing.
> > > 
> > > This is all quite terrible. I'm not at all sure why a task that is
> > > genuinely not making progress and isn't killable should not be reported.
> > 
> > The hung device detector is way to aggressive for very slow I/O.
> > See blk_wait_io, which has been around for a long time to work
> > around just that.  Given that this series targets writeback I suspect
> > it is about an overloaded device as well.
> 
> Yup, it's writeback - the bug report is in
> https://lkml.kernel.org/r/20250917212959.355656-1-sunjunchao@bytedance.com
> 
> Memory is big and storage is slow, there's nothing wrong if a task
> which is designed to wait for writeback waits for a long time.
> 
> Of course, there's something wrong if some other task which isn't
> designed to wait for writeback gets stuck waiting for the task which
> *is* designed to wait for writeback, but we'll still warn about that.
> 
> 
> Regarding an implementation, I'm wondering if we can put a flag in
> `struct completion' telling the hung task detector that this one is
> expected to wait for long periods sometimes.  Probably messy and it
> only works for completions (not semaphores, mutexes, etc).  Just
> putting it out there ;)

So the problem is that there *is* progress (albeit rather slowly), the
watchdog just doesn't see that. Perhaps that is the thing we should look
at fixing.

How about something like the below? That will 'spuriously' wake up the
waiters as long as there is some progress being made. Thereby increasing
the context switch counters of the tasks and thus the hung_task watchdog
sees progress.

This approach should be safer than the blk_wait_io() hack, which has a
timer ticking, regardless of actual completions happening or not.

---

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a07b8cf73ae2..1326193b4d95 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -174,9 +174,10 @@ static void finish_writeback_work(struct wb_writeback_work *work)
 		kfree(work);
 	if (done) {
 		wait_queue_head_t *waitq = done->waitq;
+		bool force_wake = (jiffies - done->stamp) > HZ/2;
 
 		/* @done can't be accessed after the following dec */
-		if (atomic_dec_and_test(&done->cnt))
+		if (atomic_dec_and_test(&done->cnt) || force_wake)
 			wake_up_all(waitq);
 	}
 }
@@ -213,7 +214,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
 void wb_wait_for_completion(struct wb_completion *done)
 {
 	atomic_dec(&done->cnt);		/* put down the initial count */
-	wait_event(*done->waitq, !atomic_read(&done->cnt));
+	wait_event(*done->waitq, ({ done->stamp = jiffies; !atomic_read(&done->cnt); }));
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 2ad261082bba..197593193ce3 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -63,6 +63,7 @@ enum wb_reason {
 struct wb_completion {
 	atomic_t		cnt;
 	wait_queue_head_t	*waitq;
+	unsigned long		stamp;
 };
 
 #define __WB_COMPLETION_INIT(_waitq)	\

