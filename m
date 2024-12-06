Return-Path: <linux-fsdevel+bounces-36627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 185E99E6DD4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 13:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0B42833CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 12:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDFF201001;
	Fri,  6 Dec 2024 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHnP+EuE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D545464A;
	Fri,  6 Dec 2024 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487124; cv=none; b=pvxx6+rj3V8zLwGih1GLRjKBiFhu9CelizT4QJ3txFISQGC/3BUHz6V7PSV7REQ8WfXLRPHVmloVOyWNJatnKd0TKduSkuwhcYmIrX1b0D5p1ZVpOnF0Z+q5HxQ0wZNmMv6/cTlCvz6UKmDZVy8zpmk4pqfoi70+Z91Lc+NLoPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487124; c=relaxed/simple;
	bh=m99ASBIH43LbvrnqvVVOQ7T34Jd6lNSx5ahSUrxuA5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXjuxrmxfVtjNSwPj6eq5sD9Ku/k82cqmYXYBMPrr0KQtX54zAL35uZywEvJLO3lJZ/k7xiUZYfIOpXjgf+SNrJxsE6guPNMco8yuRpptb/gTlCv7QVEWGGpIstCybMRihTDVb4N+ouB65LGgxyil4iJS2vkt4H7SgTW3i2P6QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHnP+EuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3525C4CED1;
	Fri,  6 Dec 2024 12:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733487123;
	bh=m99ASBIH43LbvrnqvVVOQ7T34Jd6lNSx5ahSUrxuA5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BHnP+EuE68C3ERSXdQVxE7FtLPfCQ+pRXgrB999Od1t8lvjGPHNAlfei8KtAn5fvE
	 QF04BdTpXF0Cbn8+wb3E/6CSH4A6AicS3JkrBkwgsNY4ESOVN2yqAXcyGwS/0CbIWf
	 CipCyfEdPn+t9qtN3SI6rv0khQqEEX1yXYdEU7wXiYYMFbQiyf/PYkqoMdWF+GEakn
	 ns8t4ay9Z9dwJU1oWK8quiPnhwAN9BLFxjTQHDUbPbTh854+0rkLysNsvXaDQnf7oT
	 R1Q82ysc25iWcue4IY2d0XW7hV8meRvfj3429U0llbTGr7d+afEyIlR0CaoVx99Boo
	 wAeEmsHxheixQ==
Date: Fri, 6 Dec 2024 13:11:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, edumazet@google.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
Message-ID: <20241206-vierbeinig-bezog-be97cb012fb8@brauner>
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com>
 <20241205141850.GS3387508@ZenIV>
 <CAGudoHH3HFDgu61S4VW2H2DXj1GMJzFRstTWhDx=jjHcb-ArwQ@mail.gmail.com>
 <a9b7f0a0-bd15-4990-b67b-48986c2eb31d@paulmck-laptop>
 <CAHk-=wjNb1G19p3efTsD9SmM3PzWdde1K2=nYb6OUgUdmmgS=g@mail.gmail.com>
 <CAGudoHHRGrQc5ezOLytq1dwmpGkXYyysBut0SqGveuLwrGaTRg@mail.gmail.com>
 <68e9807d-bf70-48ea-98eb-600f359e126f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68e9807d-bf70-48ea-98eb-600f359e126f@paulmck-laptop>

On Thu, Dec 05, 2024 at 12:11:57PM -0800, Paul E. McKenney wrote:
> On Thu, Dec 05, 2024 at 08:47:24PM +0100, Mateusz Guzik wrote:
> > On Thu, Dec 5, 2024 at 8:26 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Thu, 5 Dec 2024 at 10:41, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > > To my understanding this is the idiomatic way of spelling out the
> > > > > non-existent in Linux smp_consume_load, for the resize_in_progress
> > > > > flag.
> > > >
> > > > In Linus, "smp_consume_load()" is named rcu_dereference().
> > >
> > > Linux.
> > >
> > > But yes and no.
> > >
> > > It's worth making it really really clear that "rcu_dereference()" is
> > > *not* just a different name for some "smp_consume_load()" operation.
> > >
> > > Why? Because a true smp_consume_load() would work with any random kind
> > > of flags etc. And rcu_dereference() works only because it's a pointer,
> > > and there's an inherent data dependency to what the result points to.
> > >
> > > Paul obviously knows this, but let's make it very clear in this
> > > discussion, because if somebody decided "I want a smp_consume_load(),
> > > and I'll use rcu_dereference() to do that", the end result would
> > > simply not work for arbitrary data, like a flags field or something,
> > > where comparing it against a value will only result in a control
> > > dependency, not an actual data dependency.
> > 
> > So I checked for kicks and rcu_dereference comes with type checking,
> > as in passing something which is not a pointer even fails to compile.
> 
> That is by design, keeping in mind that consume loads order only
> later dereferences against the pointer load.
> 
> > I'll note thought that a smp_load_consume_ptr or similarly named
> > routine would be nice and I'm rather confused why it was not added
> > given smp_load_acquire and smp_store_release being there.
> 
> In recent kernels, READ_ONCE() is your smp_load_consume_ptr().  Or things
> like rcu_dereference_check(p, 1).  But these can be used only when the
> pointed-to object is guaranteed to live (as in not be freed) for the
> full duration of the read-side use of that pointer.

Both true in the case of mnt_idmap(). All mounts start with mnt_idmap set to:
extern struct mnt_idmap nop_mnt_idmap which doesn't go away ever. And we
only allow to change the idmaping of a mount once. 
So the READ_ONCE() will always retrieve an object that is guaranteed to
stay alive for at least as long as the mount stays alive (in the
nop_mnt_idmap case obviously "forever").

I wanted to avoid a) pushing complicated RCU dances all through
filesystems and the VFS and b) taking any reference counts whatsoever on
mnt_idmap (other than sharing the same mnt_idmap between different
mounts at creation time). (Though I do have long-standing ideas how that
would work without changing the mnt_idmap pointer.).

