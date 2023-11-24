Return-Path: <linux-fsdevel+bounces-3788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDDA7F8645
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 23:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B30428173F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 22:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE1239FC8;
	Fri, 24 Nov 2023 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etw+B/63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3594828DA1
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 22:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37F8C433C7;
	Fri, 24 Nov 2023 22:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700866735;
	bh=6JB2cmvFWNvbLTHf+R4y9qgwUrffC1tyRDmPTqkNXIE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=etw+B/63RkQEOkN3ww9VTmsbXl6RL95UORtpGz/pklCS7bf/iLZqu75A0Ewn1upqz
	 I+9WQvDm1ZFVTW8LkTrncxRiX5PF7lwuFg0r+fACh8XBtmq/GGQUHLZWcEeiq1aSSw
	 10b/ANLJRbKEGKdnpMvz7vdDwTJ4VKM5dvomB9HLVNRLokrjMlTLg95IK0151ezd6V
	 IMSPDzxJ1kW0T03QuTDNwTGDuzvf11x0wL8CQYm8MMwuDVsB09MnjoOFbm2yJoLJcn
	 CPihLZOGYphImXMPIG9PWPMOjVeuPOnNpd32hbeita/ejg1hnLOcV6MfGJnUFPJqLh
	 yR9OeJJltquyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 33C03CE0BDB; Fri, 24 Nov 2023 14:58:55 -0800 (PST)
Date: Fri, 24 Nov 2023 14:58:55 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/21] coda_flag_children(): cope with dentries
 turning negative
Message-ID: <6435833a-bdcb-4114-b29d-28b7f436d47d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-2-viro@zeniv.linux.org.uk>
 <CAHk-=whGKvjHCtJ6W4pQ0_h_k9fiFQ8V2GpM=BqYnB2X=SJ+XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whGKvjHCtJ6W4pQ0_h_k9fiFQ8V2GpM=BqYnB2X=SJ+XQ@mail.gmail.com>

On Fri, Nov 24, 2023 at 01:22:19PM -0800, Linus Torvalds wrote:
> On Thu, 23 Nov 2023 at 22:04, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > ->d_lock on parent does not stabilize ->d_inode of child.
> > We don't do much with that inode in there, but we need
> > at least to avoid struct inode getting freed under us...
> 
> Gaah. We've gone back and forth on this. Being non-preemptible is
> already equivalent to rcu read locking.
> 
> >From Documentation/RCU/rcu_dereference.rst:
> 
>                             With the new consolidated
>         RCU flavors, an RCU read-side critical section is entered
>         using rcu_read_lock(), anything that disables bottom halves,
>         anything that disables interrupts, or anything that disables
>         preemption.
> 
> so I actually think the coda code is already mostly fine, because that
> parent spin_lock may not stabilize d_child per se, but it *does* imply
> a RCU read lock.
> 
> So I think you should drop the rcu_read_lock/rcu_read_unlock from that patch.
> 
> But that
> 
>                 struct inode *inode = d_inode_rcu(de);
> 
> conversion is required to get a stable inode pointer.
> 
> So half of this patch is unnecessary.
> 
> Adding Paul to the cc just to verify that the docs are up-to-date and
> that we're still good here.
> 
> Because we've gone back-and-forth on the "spinlocks are an implied RCU
> read-side critical section" a couple of times.

Yes, spinlocks are implied RCU read-side critical sections.  Even in -rt,
where non-raw spinlocks are preemptible, courtesy of this:

	static __always_inline void __rt_spin_lock(spinlock_t *lock)
	{
		rtlock_might_resched();
		rtlock_lock(&lock->lock);
		rcu_read_lock();
		migrate_disable();
	}

So given -rt's preemptible spinlocks still being RCU readers, I need to
explicitly call this out in the documentation.

How about as shown below for a start?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
index 659d5913784d..2524dcdadde2 100644
--- a/Documentation/RCU/rcu_dereference.rst
+++ b/Documentation/RCU/rcu_dereference.rst
@@ -408,7 +408,10 @@ member of the rcu_dereference() to use in various situations:
 	RCU flavors, an RCU read-side critical section is entered
 	using rcu_read_lock(), anything that disables bottom halves,
 	anything that disables interrupts, or anything that disables
-	preemption.
+	preemption.  Please note that spinlock critical sections
+	are also implied RCU read-side critical sections, even when
+	they are preemptible, as they are in kernels built with
+	CONFIG_PREEMPT_RT=y.
 
 2.	If the access might be within an RCU read-side critical section
 	on the one hand, or protected by (say) my_lock on the other,

