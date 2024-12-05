Return-Path: <linux-fsdevel+bounces-36568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5D19E5F4A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 21:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181DC188421D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 20:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5203322F399;
	Thu,  5 Dec 2024 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCDezH4e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBEC21323B;
	Thu,  5 Dec 2024 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733429518; cv=none; b=fG84uHxlVvPvw/m9l6MwoKJY3YqsMAtA/s2FLYMoXkOcXIKKlpPLe+PKk70LgFazGGa8eNTJU5yreCaW4OTqsa5nV+S23Bnuy5PayVKxyqzb/tLdWgIIt0I43FX3iiEtkAFJn9EMNif52jo2w7urOWx7OwJ00ERJTGdRRA/vwuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733429518; c=relaxed/simple;
	bh=E06WAnvuY6WpUs80jMq6YSXsoOK8EwYWpJo+ocyhNrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKlWa/0B0YUpA1Bel14EPEYBrKGZOV0uDRXuFxbs/6FjMYBxzTreusd1aHQ70eZ8yhwtwa1FOc2PMe4JjCI0tcQ1c+FuUC2Lssswax+3xWVe0Gevw/FdiwhmzADoZ61qRuIyIDldsdF6bjOZSzGsGcwzkrmJtIxCwpWxpH86IoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCDezH4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC5CC4CED1;
	Thu,  5 Dec 2024 20:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733429518;
	bh=E06WAnvuY6WpUs80jMq6YSXsoOK8EwYWpJo+ocyhNrw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=SCDezH4ey9ho0l+bKpJi+34SWnoQZd4JUdYRbmhNXaaWhyaxMgPfppiFnQkrjkA5h
	 1lci5+eYDb0uqSX1q6MdsdoPaQEWq19resylUy2BM8ij+SJaxnx0FisS6KKmcSudrG
	 dMBW3Yc7/7S2KcmdWGjnAXx+cAKA2sQipacO8zGpjUb8kKXIvGhI86RRhT1eTIL/xU
	 syV/1EI7KrzYqM8J7zfA0FlU3b/9xzUZl3jPYaAWm7G/ocQx+Ad19yySQCGyiz3KhU
	 PoALbUYXbt4FtyD8oWmAYBC2vlvOVfD3wo0+/1wDan7lDBuOm54E11fd2/3ToamPzz
	 VuABlLavK5Cpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DC0CCCE0774; Thu,  5 Dec 2024 12:11:57 -0800 (PST)
Date: Thu, 5 Dec 2024 12:11:57 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, edumazet@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
Message-ID: <68e9807d-bf70-48ea-98eb-600f359e126f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com>
 <20241205141850.GS3387508@ZenIV>
 <CAGudoHH3HFDgu61S4VW2H2DXj1GMJzFRstTWhDx=jjHcb-ArwQ@mail.gmail.com>
 <a9b7f0a0-bd15-4990-b67b-48986c2eb31d@paulmck-laptop>
 <CAHk-=wjNb1G19p3efTsD9SmM3PzWdde1K2=nYb6OUgUdmmgS=g@mail.gmail.com>
 <CAGudoHHRGrQc5ezOLytq1dwmpGkXYyysBut0SqGveuLwrGaTRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHRGrQc5ezOLytq1dwmpGkXYyysBut0SqGveuLwrGaTRg@mail.gmail.com>

On Thu, Dec 05, 2024 at 08:47:24PM +0100, Mateusz Guzik wrote:
> On Thu, Dec 5, 2024 at 8:26 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, 5 Dec 2024 at 10:41, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > > To my understanding this is the idiomatic way of spelling out the
> > > > non-existent in Linux smp_consume_load, for the resize_in_progress
> > > > flag.
> > >
> > > In Linus, "smp_consume_load()" is named rcu_dereference().
> >
> > Linux.
> >
> > But yes and no.
> >
> > It's worth making it really really clear that "rcu_dereference()" is
> > *not* just a different name for some "smp_consume_load()" operation.
> >
> > Why? Because a true smp_consume_load() would work with any random kind
> > of flags etc. And rcu_dereference() works only because it's a pointer,
> > and there's an inherent data dependency to what the result points to.
> >
> > Paul obviously knows this, but let's make it very clear in this
> > discussion, because if somebody decided "I want a smp_consume_load(),
> > and I'll use rcu_dereference() to do that", the end result would
> > simply not work for arbitrary data, like a flags field or something,
> > where comparing it against a value will only result in a control
> > dependency, not an actual data dependency.
> 
> So I checked for kicks and rcu_dereference comes with type checking,
> as in passing something which is not a pointer even fails to compile.

That is by design, keeping in mind that consume loads order only
later dereferences against the pointer load.

> I'll note thought that a smp_load_consume_ptr or similarly named
> routine would be nice and I'm rather confused why it was not added
> given smp_load_acquire and smp_store_release being there.

In recent kernels, READ_ONCE() is your smp_load_consume_ptr().  Or things
like rcu_dereference_check(p, 1).  But these can be used only when the
pointed-to object is guaranteed to live (as in not be freed) for the
full duration of the read-side use of that pointer.

> One immediate user would be mnt_idmap(), like so:
> iff --git a/include/linux/mount.h b/include/linux/mount.h
> index 33f17b6e8732..4d3486ff67ed 100644
> --- a/include/linux/mount.h
> +++ b/include/linux/mount.h
> @@ -76,7 +76,7 @@ struct vfsmount {
>  static inline struct mnt_idmap *mnt_idmap(const struct vfsmount *mnt)
>  {
>         /* Pairs with smp_store_release() in do_idmap_mount(). */
> -       return READ_ONCE(mnt->mnt_idmap);
> +       return smp_load_consume_ptr(mnt->mnt_idmap);
>  }
> 
>  extern int mnt_want_write(struct vfsmount *mnt);

These would have the same semantics.  And in v6.12, this is instead
smp_load_acquire().

							Thanx, Paul

