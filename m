Return-Path: <linux-fsdevel+bounces-62508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AF3B95DC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 14:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCB41887460
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 12:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4362A3233FE;
	Tue, 23 Sep 2025 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9yj99gL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9288A184;
	Tue, 23 Sep 2025 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758631486; cv=none; b=fPftpTwLrYVo2PqhpRBDK1UzF/1wvynNvKKGhDH0swUkxRyJPiTB6zUvuxHk7+KlMLM2PcENfUrudgza9+deB5TIRzLZApXy/j3myvCs/ClkYMZM8Wz78zutU2EL0qfmQCpEpLzrt8BTrBA+Xj79cEdhAdV9AMOwCxtU+/FAUxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758631486; c=relaxed/simple;
	bh=ov3x/Bv7oV50KFhrwrPMRC8zciwGASqntR7tTgePSD8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u7anxKOKzB/gXRGHtc0eLUyCGwtmYEJDtCTnPT/iZ/7M757nR9OKiS6VEdYeb6KweVp3aWCCaPzlDmFXVyIV2tgCROmk1vhFlM21u5ONEpUzO9yxU7qY+YsmvXkKUMm5R9K7UIdxUsq3Hj1Q+cf4kBb7W8V656RoP1MfHDg9zTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9yj99gL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0271BC4CEF5;
	Tue, 23 Sep 2025 12:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758631486;
	bh=ov3x/Bv7oV50KFhrwrPMRC8zciwGASqntR7tTgePSD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e9yj99gLWb6vn8o4oOOQNm7BxB6fejebVGtLUn5foBi7E6sibbmwebGzcvWzT0xVn
	 iPoL6hD2yYK/J+p1k24PmgEgOLSU3K23YbvEw8Q4dar6REJ4AzUBZy34YsVvCHgspa
	 9uu6c+ByYoGwJB4idWb2NC5/7mebyLOXtEPl29rHCGz5klbpViRW5jSIOZGk7cs9ro
	 pV7AAm65xazyrqHkCX3p7ynrT+pwh2PS7yNYnjeRrtqANx4Ke51A5qb7rQEA7FUqIT
	 5GSKi82jpchy/aJ6Qaa20A5IfjPbX6bTjznxF/o6djMwihOuqXxnL4wqkoWCGp/Aqu
	 hQ5oPy0iX+QRg==
Date: Tue, 23 Sep 2025 21:44:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig
 <hch@infradead.org>, Julian Sun <sunjunchao@bytedance.com>,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 lance.yang@linux.dev, mhiramat@kernel.org, agruenba@redhat.com,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
Message-Id: <20250923214438.95e34fc1bbd5cfe5ac0b9dde@kernel.org>
In-Reply-To: <20250923071607.GR3245006@noisy.programming.kicks-ass.net>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
	<20250922132718.GB49638@noisy.programming.kicks-ass.net>
	<aNGQoPFTH2_xrd9L@infradead.org>
	<20250922145045.afc6593b4e91c55d8edefabb@linux-foundation.org>
	<20250923071607.GR3245006@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 09:16:07 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Sep 22, 2025 at 02:50:45PM -0700, Andrew Morton wrote:
> > On Mon, 22 Sep 2025 11:08:32 -0700 Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > > On Mon, Sep 22, 2025 at 03:27:18PM +0200, Peter Zijlstra wrote:
> > > > > Julian Sun (3):
> > > > >   sched: Introduce a new flag PF_DONT_HUNG.
> > > > >   writeback: Introduce wb_wait_for_completion_no_hung().
> > > > >   memcg: Don't trigger hung task when memcg is releasing.
> > > > 
> > > > This is all quite terrible. I'm not at all sure why a task that is
> > > > genuinely not making progress and isn't killable should not be reported.
> > > 
> > > The hung device detector is way to aggressive for very slow I/O.
> > > See blk_wait_io, which has been around for a long time to work
> > > around just that.  Given that this series targets writeback I suspect
> > > it is about an overloaded device as well.
> > 
> > Yup, it's writeback - the bug report is in
> > https://lkml.kernel.org/r/20250917212959.355656-1-sunjunchao@bytedance.com
> > 
> > Memory is big and storage is slow, there's nothing wrong if a task
> > which is designed to wait for writeback waits for a long time.
> > 
> > Of course, there's something wrong if some other task which isn't
> > designed to wait for writeback gets stuck waiting for the task which
> > *is* designed to wait for writeback, but we'll still warn about that.
> > 
> > 
> > Regarding an implementation, I'm wondering if we can put a flag in
> > `struct completion' telling the hung task detector that this one is
> > expected to wait for long periods sometimes.  Probably messy and it
> > only works for completions (not semaphores, mutexes, etc).  Just
> > putting it out there ;)
> 
> So the problem is that there *is* progress (albeit rather slowly), the
> watchdog just doesn't see that. Perhaps that is the thing we should look
> at fixing.
> 
> How about something like the below? That will 'spuriously' wake up the
> waiters as long as there is some progress being made. Thereby increasing
> the context switch counters of the tasks and thus the hung_task watchdog
> sees progress.
> 
> This approach should be safer than the blk_wait_io() hack, which has a
> timer ticking, regardless of actual completions happening or not.

I like this idea, because this does not priotize any task, but priotize
context. The problem sounds like the kernel knows the operation
should be slow. Then what we need is a "progress bar" for the hung task
instead of an "ever-spinning circle".

It seems that the task hang detector can be triggered by an IO device
problem. This is not because IO is slow but in progress, but because
removable devices, etc., may not return from IO.

So, is it possible to reset such a watchdog only when it is confirmed
that some IO is slow but in progress? No matter how slow the IO is or
how throttled it is, I think it's rare for there to be no IO at all
within a few seconds.

Thank you,

> 
> ---
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index a07b8cf73ae2..1326193b4d95 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -174,9 +174,10 @@ static void finish_writeback_work(struct wb_writeback_work *work)
>  		kfree(work);
>  	if (done) {
>  		wait_queue_head_t *waitq = done->waitq;
> +		bool force_wake = (jiffies - done->stamp) > HZ/2;
>  
>  		/* @done can't be accessed after the following dec */
> -		if (atomic_dec_and_test(&done->cnt))
> +		if (atomic_dec_and_test(&done->cnt) || force_wake)
>  			wake_up_all(waitq);
>  	}
>  }
> @@ -213,7 +214,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
>  void wb_wait_for_completion(struct wb_completion *done)
>  {
>  	atomic_dec(&done->cnt);		/* put down the initial count */
> -	wait_event(*done->waitq, !atomic_read(&done->cnt));
> +	wait_event(*done->waitq, ({ done->stamp = jiffies; !atomic_read(&done->cnt); }));
>  }
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 2ad261082bba..197593193ce3 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -63,6 +63,7 @@ enum wb_reason {
>  struct wb_completion {
>  	atomic_t		cnt;
>  	wait_queue_head_t	*waitq;
> +	unsigned long		stamp;
>  };
>  
>  #define __WB_COMPLETION_INIT(_waitq)	\


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

