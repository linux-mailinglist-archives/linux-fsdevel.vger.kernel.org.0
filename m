Return-Path: <linux-fsdevel+bounces-7526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDC9826C0F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE156282355
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 11:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11581429A;
	Mon,  8 Jan 2024 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEs1ZNsN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8A1A271;
	Mon,  8 Jan 2024 11:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10868C433CC;
	Mon,  8 Jan 2024 11:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704711899;
	bh=ADZSz3svcvy4AE0ELj/OHAdWql4h0/MMJv4njtLcOQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEs1ZNsNkv1hZ7rvZ5yDtjX9ooa2ixnqvb4Lt3NzsFMPe0NI1ulO6GFDsaAnVY46A
	 tUCu9aWmz9Fq0LAW8jlic1dnzOOPAV3fEKKRvN2EgNUaEgRyNLDS2TYmqtnZ2vRqtJ
	 8G8TIAYNsGbIfyPZ/c0bEhfIGJK4Uxs7bH8wKvi3eEoGOcORi6jtC9hBK0eCx7j247
	 wGbg/dFaHlhpty+peUeOXy1NcOg8TksLY63xbLWs1pLAeY5Bwr3wG+ae6RtT4E1hXk
	 Jveorm9MUjFCsDmsCn1oRxafbYkUodH0uRxLnu0cd+6mARBJsU/NK42nqqC9SumzMM
	 H7u/PxmBtP4NQ==
Date: Mon, 8 Jan 2024 12:04:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default
 ownership
Message-ID: <20240108-ortsrand-ziehen-4e9a9a58e708@brauner>
References: <20240103203246.115732ec@gandalf.local.home>
 <20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
 <20240105095954.67de63c2@gandalf.local.home>
 <20240107-getrickst-angeeignet-049cea8cad13@brauner>
 <20240107132912.71b109d8@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240107132912.71b109d8@rorschach.local.home>

> > * Tracefs supports the creation of instances from userspace via mkdir.
> >   For example,
> > 
> > 	mkdir /sys/kernel/tracing/instances/foo
> > 
> >   And here the idmapping is relevant so we need to make the helpers
> >   aware of the idmapping.
> > 
> >   I just went and plumbed this through to most helpers.
> > 
> > There's some subtlety in eventfs. Afaict, the directories and files for
> > the individual events are created on-demand during lookup or readdir.
> > 
> > The ownership of these events is again inherited from the parent inode
> > or recovered from stored state. In both cases the actual idmapping is
> > irrelevant.
> > 
> > The callchain here is:
> > 
> > eventfs_root_lookup("xfs", "events")
> > -> create_{dir,file}_dentry("xfs", "events")
> >    -> create_{dir,file}("xfs", "events")
> >       -> eventfs_start_creating("xfs", "events")
> >          -> lookup_one_len("xfs", "events")  
> > 
> > And the subtlety is that lookup_one_len() does permission checking on
> > the parent inode (IOW, if you want a dentry for "blech" under "events"
> > it'll do a permission check on events->d_inode) for exec permissions
> > and then goes on to give you a new dentry.
> > 
> > Usually this call would have to be changed to lookup_one() and the
> > idmapping be handed down to it. But I think that's irrelevant here.
> > 
> > Lookup generally doesn't need to be aware of idmappings at all. The
> > permission checking is done purely in the vfs via may_lookup() and the
> > idmapping is irrelevant because we always initialize inodes with the
> > filesystem level ownership (see the idmappings.rst) documentation if
> > you're interested in excessive details (otherwise you get inode aliases
> > which you really don't want).
> > 
> > For tracefs it would not matter for lookup per se but only because
> > tracefs seemingly creates inodes/dentries during lookup (and readdir()).
> 
> tracefs creates the inodes/dentries at boot up, it's eventfs that does
> it on demand during lookup.
> 
> For inodes/dentries:
> 
>  /sys/kernel/tracing/* is all created at boot up, except for "events".

Yes.

>  /sys/kernel/tracing/events/* is created on demand.

Yes.

> 
> > 
> > But imho the permission checking done in current eventfs_root_lookup()
> > via lookup_one_len() is meaningless in any way; possibly even
> > (conceptually) wrong.
> > 
> > Because, the actual permission checking for the creation of the eventfs
> > entries isn't really done during lookup or readdir, it's done when mkdir
> > is called:
> > 
> >         mkdir /sys/kernel/tracing/instances/foo
> 
> No. that creates a entire new tracefs instance, which happens to
> include another eventfs directory.

Yes, I'm aware of all that.

> No. Only the meta data is created for the eventfs directory with a
> mkdir instances/foo. The inodes and dentries are not there.

I know, that is what I'm saying.

> 
> > 
> > When one goes and looksup stuff under foo/events/ or readdir the entries
> > in that directory:
> > 
> > fd = open("foo/events")
> > readdir(fd, ...)
> > 
> > then they are licensed to list an entry in that directory. So all that
> > needs to be done is to actually list those files in that directory. And
> > since they already exist (they were created during mkdir) we just need
> > to splice in inodes and dentries for them. But for that we shouldn't
> > check permissions on the directory again. Because we've done that
> > already correctly when the VFS called may_lookup().
> 
> No they do not exist.

I am aware.

> 
> > 
> > IOW, the inode_permission() in lookup_one_len() that eventfs does is
> > redundant and just wrong.
> 
> I don't think so.

I'm very well aware that the dentries and inode aren't created during
mkdir but the completely directory layout is determined. You're just
splicing in dentries and inodes during lookup and readdir.

If mkdir /sys/kernel/tracing/instances/foo has succeeded and you later
do a lookup/readdir on

ls -al /sys/kernel/tracing/instances/foo/events

Why should the creation of the dentries and inodes ever fail due to a
permission failure? The vfs did already verify that you had the required
permissions to list entries in that directory. Why should filling up
/sys/kernel/tracing/instances/foo/events ever fail then? It shouldn't
That tracefs instance would be half-functional. And again, right now
that inode_permission() check cannot even fail.

