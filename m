Return-Path: <linux-fsdevel+bounces-60356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D99C5B4599F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 15:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997BA1C26C77
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95E535E4CD;
	Fri,  5 Sep 2025 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJjFjj3P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E01B27AC5A;
	Fri,  5 Sep 2025 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080368; cv=none; b=n2YCUP2OUsNFuVEgqobzKM2f5ovNq2qhU7vt8U/4en8PHyGZYEVY89ZzyuDg8D+TpAV1+gUUZhcV1bFl4ya5syXM0izJNqnXU4I7GB9J8/MDH61sWRz1p6oTu7nHYRXv3tDo26tl9bq8f94qMYi46MAVkVQxGRTc0Z+2yeH4AaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080368; c=relaxed/simple;
	bh=ubo6F3VGGDgseE8VqlXM9lToPzfEZs6MtqOJNwZHb6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyYVJFeXlCMIcxTppXYhKySQ5i211UpcDz/eDW5MiHsKHW8iGsiLgoS6sReJZfRkyHC6n+37glx/4ax/ASpfGVQlXRu0LCcomf65q/kvg6japaxdS1oGqHQ6akVaKsB0/SUaQQPHRkx5ejPDdT/jRrxEDPGWtkOtULa2CIRnYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJjFjj3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563ABC4CEF1;
	Fri,  5 Sep 2025 13:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757080367;
	bh=ubo6F3VGGDgseE8VqlXM9lToPzfEZs6MtqOJNwZHb6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJjFjj3P28pgxzAYTBzIwegwRkgGVGKSJJWL88AGN16RFLeNkgcehOTPiqStWozET
	 yz6RNVktfDafOr+hSw1eqY9e3EhHL6nqFCeIIRJrW/bLT84XEeVjkaDAe/nXh/ZgVy
	 3bfDTVsBS2vwuY001THHHPe5W5omokghgHfP63t4iT/whbLifEm1V2pKwOG19236Zy
	 tqVu28MUAHSDSBxY9v5QuMhafJmnfX//lDERYOHw8tv0unPwAv9wpwf7VpRt2SEZDG
	 bjBHSyt+u717TaaEhjQ+Rle9EOoTErHl5iWqfwPvjPDx4EJPV79nlAorkugSr3uzOp
	 h2zWO91WCZOxg==
Date: Fri, 5 Sep 2025 15:52:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Nam Cao <namcao@linutronix.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Xi Ruoyao <xry111@xry111.site>, 
	Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, John Ogness <john.ogness@linutronix.de>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/1] eventpoll: Replace rwlock with spinlock
Message-ID: <20250905-abtun-nackt-dbd1f5accc55@brauner>
References: <cover.1752581388.git.namcao@linutronix.de>
 <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
 <20250826084320.XeTd6XAK@linutronix.de>
 <20250903084012.A8dd-A5z@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903084012.A8dd-A5z@linutronix.de>

On Wed, Sep 03, 2025 at 10:40:12AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-08-26 10:43:20 [+0200], Nam Cao wrote:
> > On Tue, Jul 15, 2025 at 02:46:34PM +0200, Nam Cao wrote:
> > > The ready event list of an epoll object is protected by read-write
> > > semaphore:
> > > 
> > >   - The consumer (waiter) acquires the write lock and takes items.
> > >   - the producer (waker) takes the read lock and adds items.
> > > 
> > > The point of this design is enabling epoll to scale well with large number
> > > of producers, as multiple producers can hold the read lock at the same
> > > time.
> > > 
> > > Unfortunately, this implementation may cause scheduling priority inversion
> > > problem. Suppose the consumer has higher scheduling priority than the
> > > producer. The consumer needs to acquire the write lock, but may be blocked
> > > by the producer holding the read lock. Since read-write semaphore does not
> > > support priority-boosting for the readers (even with CONFIG_PREEMPT_RT=y),
> > > we have a case of priority inversion: a higher priority consumer is blocked
> > > by a lower priority producer. This problem was reported in [1].
> > > 
> > > Furthermore, this could also cause stall problem, as described in [2].
> > > 
> > > Fix this problem by replacing rwlock with spinlock.
> > 
> > Hi Christian,
> > 
> > May I know your plan with this patch? Are you still waiting for something?
> > 
> > You may still understandably be paranoid about epoll due to the last
> > regression. But it's been weeks, and this patch is quite simple, so I start
> > to wonder if it is forgotten.
> 
> A friendly reminder.

Sorry, this apparently fell through the cracks. Taken care of now!

