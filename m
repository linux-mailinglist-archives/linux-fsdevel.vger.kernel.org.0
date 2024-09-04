Return-Path: <linux-fsdevel+bounces-28631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3057196C7F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 21:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D65B287805
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 19:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBDB1E7647;
	Wed,  4 Sep 2024 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml2kvg2E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D891E6DF0;
	Wed,  4 Sep 2024 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479512; cv=none; b=O/gNAOgK+HYl6pqutt8V3zv7n6D+uZEWdIVC5kctpeBM1j3Wo7hFG+zZF+PU9256kfueZOQN8pl7PMLZwfPjd4DiSLBhwgIOPGssT4UfMTEd4na9ZArDxjT4X0UpVyVBL8zGDgwSvfuojr2WYLmJU4q7Aq26rjR/cwUMgboTjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479512; c=relaxed/simple;
	bh=7u+OzaZAl8rD18AqF1OOqxMGNuGjDR6eApR2mv9VXX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehBhPyWkxqWmcBLFTM4gIYVq5W20q6W5YG2EzjZJJshoMU4RGlVHEluCA0Ta96POjGt68WmKYEQ2xfY7J2gE2KbQH/gKulKVjPqjWuyM7uZ2A+j3GktGJhjUF7oCVO1l2usY6cV0S5t7gwSGsD9gRTC0lCJ5ZEoQbV4k580t9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ml2kvg2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BC4C4CECB;
	Wed,  4 Sep 2024 19:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725479511;
	bh=7u+OzaZAl8rD18AqF1OOqxMGNuGjDR6eApR2mv9VXX0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Ml2kvg2ESFcH63DACNbfg1RsssvBXqo1yRot5cn8AeYxOtC+/oHI7HHhFGNNf+cbJ
	 cc4jj0GhSprRMPyD0yeTe7MLl/fbDtLwPOtEsgOaNiBSc/+A76ggfKdCiDSFQEFD/V
	 guddzLjFWfLDHpormi9GzoBxKcNg9M67gha68L4SRvdTprnlGir0KRWFY38JgX1zKV
	 lT5irx8EXFd1D0IW4JQD8nv1Y05+/nYZcOiWpEz7AgC3NNp6p7ibxot9igU1YS29wt
	 eaDi4G2jFTPu4ohVIEnGAHqWEJ+xUQBAKjInPUCejQrTOayUUUg7tAtEWQebWecPlU
	 elgtQbz0jeRYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 575D6CE16CC; Wed,  4 Sep 2024 12:51:51 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:51:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jon Kohler <jon@nutanix.com>
Cc: Jan Kara <jack@suse.cz>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	"josh@joshtriplett.org" <josh@joshtriplett.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: SRCU hung task on 5.10.y on synchronize_srcu(&fsnotify_mark_srcu)
Message-ID: <1693a7fa-7fb5-4786-bfa6-6cf3bb24a640@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1E829024-48BF-4647-A1DD-AC7E8BFA0FA2@nutanix.com>
 <20240904091912.orpkwemgpsgcongo@quack3>
 <CBB4A7F7-81F0-44E8-96D4-E1035E21BDE1@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CBB4A7F7-81F0-44E8-96D4-E1035E21BDE1@nutanix.com>

On Wed, Sep 04, 2024 at 02:40:07PM +0000, Jon Kohler wrote:
> 
> 
> > On Sep 4, 2024, at 5:19 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Tue 27-08-24 20:01:27, Jon Kohler wrote:
> >> Hey Paul, Lai, Josh, and the RCU list and Jan/FS list -
> >> Reaching out about a tricky hung task issue that I'm running into. I've
> >> got a virtualized Linux guest on top of a KVM based platform, running
> >> a 5.10.y based kernel. The issue we're running into is a hung task that
> >> *only* happens on shutdown/reboot of this particular VM once every 
> >> 20-50 times.
> >> 
> >> The signature of the hung task is always similar to the output below,
> >> where we appear to hang on the call to 
> >>    synchronize_srcu(&fsnotify_mark_srcu)
> >> in fsnotify_connector_destroy_workfn / fsnotify_mark_destroy_workfn,
> >> where two kernel threads are both calling synchronize_srcu, then
> >> scheduling out in wait_for_completion, and completely going out to
> >> lunch for over 4 minutes. This then triggers the hung task timeout and
> >> things blow up.
> > 
> > Well, the most obvious reason for this would be that some process is
> > hanging somewhere with fsnotify_mark_srcu held. When this happens, can you
> > trigger sysrq-w in the VM and send here its output?
> 
> Jan - Thanks for the ping, that is *exactly* what is happening here.
> Some developments since my last note, the patch Neeraj pointed out
> wasn't the issue, but rather a confluence of realtime thread configurations
> that ended up completely starving whatever CPU was processing per-CPU
> callbacks. So, one thread would go out to lunch completely, and it would
> just never yield. This particular system was configured with RT_RUNTIME_SHARE
> unfortunately, so that realtime thread going out to lunch ate the entire system.
> 
> What was odd is that this never, ever happened during runtime on some
> of these systems that have been up for years and getting beat up heavily,
> but rather only on shutdown. We’ve got more to chase down internally on
> that.
> 
> One thing I wanted to bring up here though while I have you, I have
> noticed through various hits on google, mailing lists, etc over the years that
> this specific type of lockup with fsnotify_mark_srcu seems to happen now
> and then for various oddball reasons, with various root causes. 
> 
> It made me think that I wonder if there is a better structure that could be
> used here that might be a bit more durable. To be clear, I’m not saying that
> SRCU *is not* durable or anything of the sort (I promise!) but rather
> wondering if there was anything we could think about tweaking on the
> fsnotify side of the house to be more efficient.
> 
> Thoughts?

For RCU in real-time environments, we have RCU priority boosting, which
boost RCU readers that have been preempted for too long.  However, this is
SRCU, in which readers can simply block, in addition to being preempted.
Of course, boosting the priority of a task that ha blocked (as opposed
to being preempted) cannot help -- the task will remain blocked until
awakened, regardless of its priority.

But your case takes this one step further, in that the workqueue invoking
callbacks is being preempted and starved, correct?

The usual advice is to make sure that your housekeeping CPUs get
sufficient CPU time.  Easy to say, easy to do, harder to keep done
uniformly across a large number of systems running diverse workloads.
Still, this is the preferred approach.

Just out of curiosity, is this a CONFIG_PREEMPT_RT kernel?

							Thanx, Paul

> >> We are running audit=1 for this system and are using an el8 based
> >> userspace.
> >> 
> >> I've flipped through the fs/notify code base for both 5.10 as well as
> >> upstream mainline to see if something jumped off the page, and I
> >> haven't yet spotted any particular suspect code from the caller side.
> >> 
> >> This hang appears to come up at the very end of the shutdown/reboot
> >> process, seemingly after the system starts to unwind through initrd.
> >> 
> >> What I'm working on now is adding some instrumentation to the dracut
> >> shutdown initrd scripts to see if I can how far we get down that path
> >> before the system fails to make forward progress, which may give some
> >> hints. TBD on that. I've also enabled lockdep with CONFIG_PROVE_RCU and
> >> a plethora of DEBUG options [2], and didn't get anything interesting.
> >> To be clear, we haven't seen lockdep spit out any complaints as of yet.
> > 
> > The fact that lockdep doesn't report anything is interesting but then
> > lockdep doesn't track everything. In particular I think SRCU itself isn't
> > tracked by lockdep.
> > 
> > Honza
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> 
> 

