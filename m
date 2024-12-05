Return-Path: <linux-fsdevel+bounces-36562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E80A9E5E5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 19:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279D21634B1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 18:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C5F22B8D3;
	Thu,  5 Dec 2024 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9DgpFgZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0344221461;
	Thu,  5 Dec 2024 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733424081; cv=none; b=CUBh378js2UwpS2wET5WFe5hx8w4knXmCPwnENItIeE6xs3K6A5cBABSC9Zdf0Fs7lg/QKmKnQ7zCUDOtc2TGRnskrkBVPtgg8DibfIBbw5JUCKsNj5ia176hSnBnpTc+NsuLvCClQKIWSbenm8uzt4wC018v/EnRRRA/hXKTeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733424081; c=relaxed/simple;
	bh=0YBNkypV8E/T1JTlxwqRN6rbYdmmeKiFzaa+dqxPaCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rcuae/JRzOXTjbBn/faBUXdYevuwP0QROWK689L4Yuc65XV4HbwNsdfYeqfYozT8RdvzWylCXyyf0Rux0guhvdt5PUNcaYx8wyBMXwYzFhsHYWS+KyfiDZemtp+5dwNEAtrg4PLNih0w8Ssvzdjjtj8LnAi2NevJELfls9Ik35c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9DgpFgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C01EC4CEDC;
	Thu,  5 Dec 2024 18:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733424079;
	bh=0YBNkypV8E/T1JTlxwqRN6rbYdmmeKiFzaa+dqxPaCE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=B9DgpFgZP2hg4PfSRiHH1z8WrSNl2SoVqunygTgEQk68hwNvKX9BgLjYy50x8ePwq
	 Fjnru7HmOxwrIb9KlP11fdaTMRIyG3awLRQ6HMfVWqyA3d4aJB8CzgK+Mb56JgrMKb
	 FCCdD9Yg0WK4l+aW5C+P3qdscwyY04GQVwOtUKeovfzuniZpQbKHGQh0edVYXAdxXD
	 Nmgov/FjslB2NT8PcAIvp9q0kWVII6So1sf3Jrkev7n6S/qS1V1RHD6Xm/0oopVyQD
	 0GAn6+H+MZTBm751kZPnM379dsjqUNm/1/pxlomNQiJG85grd8EINfJW0ICYnlMGJR
	 55PP54tjAFqzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C2EDFCE08E1; Thu,  5 Dec 2024 10:41:17 -0800 (PST)
Date: Thu, 5 Dec 2024 10:41:17 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	edumazet@google.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
Message-ID: <a9b7f0a0-bd15-4990-b67b-48986c2eb31d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com>
 <20241205141850.GS3387508@ZenIV>
 <CAGudoHH3HFDgu61S4VW2H2DXj1GMJzFRstTWhDx=jjHcb-ArwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHH3HFDgu61S4VW2H2DXj1GMJzFRstTWhDx=jjHcb-ArwQ@mail.gmail.com>

On Thu, Dec 05, 2024 at 03:43:41PM +0100, Mateusz Guzik wrote:
> On Thu, Dec 5, 2024 at 3:18 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, Dec 05, 2024 at 01:03:32PM +0100, Mateusz Guzik wrote:
> > >  void fd_install(unsigned int fd, struct file *file)
> > >  {
> > > -     struct files_struct *files = current->files;
> > > +     struct files_struct *files;
> > >       struct fdtable *fdt;
> > >
> > >       if (WARN_ON_ONCE(unlikely(file->f_mode & FMODE_BACKING)))
> > >               return;
> > >
> > > +     /*
> > > +      * Synchronized with expand_fdtable(), see that routine for an
> > > +      * explanation.
> > > +      */
> > >       rcu_read_lock_sched();
> > > +     files = READ_ONCE(current->files);
> >
> > What are you trying to do with that READ_ONCE()?  current->files
> > itself is *not* changed by any of that code; current->files->fdtab is.
> 
> To my understanding this is the idiomatic way of spelling out the
> non-existent in Linux smp_consume_load, for the resize_in_progress
> flag.

In Linus, "smp_consume_load()" is named rcu_dereference().

> Anyway to elaborate I'm gunning for a setup where the code is
> semantically equivalent to having a lock around the work.

Except that rcu_read_lock_sched() provides mutual-exclusion guarantees
only with later RCU grace periods, such as those implemented by
synchronize_rcu().

> Pretend ->resize_lock exists, then:
> fd_install:
> files = current->files;
> read_lock(files->resize_lock);
> fdt = rcu_dereference_sched(files->fdt);
> rcu_assign_pointer(fdt->fd[fd], file);
> read_unlock(files->resize_lock);
> 
> expand_fdtable:
> write_lock(files->resize_lock);
> [snip]
> rcu_assign_pointer(files->fdt, new_fdt);
> write_unlock(files->resize_lock);
> 
> Except rcu_read_lock_sched + appropriately fenced resize_in_progress +
> synchronize_rcu do it.

OK, good, you did get the grace-period part of the puzzle.

Howver, please keep in mind that synchronize_rcu() has significant
latency by design.  There is a tradeoff between CPU consumption and
latency, and synchronize_rcu() therefore has latencies ranging upwards of
several milliseconds (not microseconds or nanoseconds).  I would be very
surprised if expand_fdtable() users would be happy with such a long delay.
Or are you using some trick to hide this delay?

