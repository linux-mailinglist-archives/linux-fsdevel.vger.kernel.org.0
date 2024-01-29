Return-Path: <linux-fsdevel+bounces-9400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 792DE840AA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7CE281B13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C541552E9;
	Mon, 29 Jan 2024 15:57:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F77154BEE
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543838; cv=none; b=l6q966NXtJBE7K2aWv53x4Noz66Fdlf42K2pTUZH2Pz9sZvZY77dIpmJRYEYE1kN0iqFVfdZnKcpmYrvgCyx/R7jEp5X5wmTrLZKrqet+7BTIOFbGjrcotrBCE9821qaTYjM6vKsklOVIHJtY07YJUsnKQAGOhVkP4wmQfeTMVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543838; c=relaxed/simple;
	bh=P5BJJHYP04vZ0v4XwFwSxRMwPfvyzhMqoNXjpxG219s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjF9hMLeulHKCdk7jYyBiojFM1mdilTdeaR1k7iQGb1UGx02BIPleVkv5+fz7b2Vp816vV/fEFFMtXDqqXitPOJKEvSo+e4nV+fY5k/YuSmaNOwm6YSs3BMTr5tVHfDUJGV8Xrl2xzGxeRZkEp1i6miPVeAnS8tX+IqFiUeBUw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A73C433C7;
	Mon, 29 Jan 2024 15:57:16 +0000 (UTC)
Date: Mon, 29 Jan 2024 10:57:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox
 <willy@infradead.org>, James Bottomley
 <James.Bottomley@hansenpartnership.com>, Amir Goldstein
 <amir73il@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more
 like normal file systems
Message-ID: <20240129105726.2c2f77f0@gandalf.local.home>
In-Reply-To: <20240129-umrechnen-kaiman-cb591bc22fc5@brauner>
References: <2024012528-caviar-gumming-a14b@gregkh>
	<20240125214007.67d45fcf@rorschach.local.home>
	<2024012634-rotten-conjoined-0a98@gregkh>
	<20240126101553.7c22b054@gandalf.local.home>
	<2024012600-dose-happiest-f57d@gregkh>
	<20240126114451.17be7e15@gandalf.local.home>
	<CAOQ4uxjRxp4eGJtuvV90J4CWdEftusiQDPb5rFoBC-Ri7Nr8BA@mail.gmail.com>
	<d661e4a68a799d8ae85f0eab67b1074bfde6a87b.camel@HansenPartnership.com>
	<ZbVGLXu4DuomEvJH@casper.infradead.org>
	<CAHk-=whXg6zAHWZ7f+CdOg5GOMffR3RSDVyvORTZhipxp5iAFQ@mail.gmail.com>
	<20240129-umrechnen-kaiman-cb591bc22fc5@brauner>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 16:08:33 +0100
Christian Brauner <brauner@kernel.org> wrote:

> > But no. You should *not* look at a virtual filesystem as a guide how
> > to write a filesystem, or how to use the VFS. Look at a real FS. A
> > simple one, and preferably one that is built from the ground up to
> > look like a POSIX one, so that you don't end up getting confused by
> > all the nasty hacks to make it all look ok.
> > 
> > IOW, while FAT is a simple filesystem, don't look at that one, just
> > because then you end up with all the complications that come from
> > decades of non-UNIX filesystem history.
> > 
> > I'd say "look at minix or sysv filesystems", except those may be
> > simple but they also end up being so legacy that they aren't good
> > examples. You shouldn't use buffer-heads for anything new. But they
> > are still probably good examples for one thing: if you want to
> > understand the real power of dentries, look at either of the minix or
> > sysv 'namei.c' files. Just *look* at how simple they are. Ignore the
> > internal implementation of how a directory entry is then looked up on
> > disk - because that's obviously filesystem-specific - and instead just
> > look at the interface.  
> 
> I agree and I have to say I'm getting annoyed with this thread.
> 
> And I want to fundamentally oppose the notion that it's too difficult to
> write a virtual filesystem. Just one look at how many virtual

I guess you mean pseudo file systems? Somewhere along the discussion we
switched from saying pseudo to virtual. I may have been the culprit, I
don't remember and I'm not re-reading the thread to find out.

> filesystems we already have and how many are proposed. Recent example is
> that KVM wanted to implement restricted memory as a stacking layer on
> top of tmpfs which I luckily caught early and told them not to do.
> 
> If at all a surprising amount of people that have nothing to do with
> filesystems manage to write filesystem drivers quickly and propose them
> upstream. And I hope people take a couple of months to write a decently
> sized/complex (virtual) filesystem.

I spent a lot of time on this. Let me give you a bit of history of where
tracefs/eventfs came from.

When we first started the tracing infrastructure, I wanted it to be easy to
debug embedded devices. I use to have my own tracer called "logdev" which
was a character device in /dev called /dev/logdev. I was able to write into
it for simple control actions.

But we needed a more complex system when we started integrating the
PREEMPT_RT latency tracer which eventually became the ftrace infrastructure.

As I wanted to still only need busybox to interact with it, I wanted to use
files and not system calls. I was recommended to use debugfs, and I did. It
became /sys/kernel/debug/tracing.

After a while, when tracing started to become useful in production systems,
people wanted access to tracing without having to have debugfs mounted.
That's because debugfs is a dumping ground to a lot of interactions with
the kernel, and people were legitimately worried about security
vulnerabilities it could expose.

I then asked about how to make /sys/kernel/debug/tracing its own file
system and was recommended to just start with debugfs (it's the easiest
concept of all the files systems to understand) and since tracing was
already used the debugfs API (with dentries as the handle) it made sense.

That created tracefs. Now you could mount tracefs at /sys/kernel/tracing
and even have debugfs configured out.

When the eBPF folks were using trace_printk directly into the main trace
buffer, I asked them to please use an instance instead. They told me that
an instance adds too much memory overhead. Over 20MBs! When I investigated,
I found that they were right. And most of that overhead was all the dentry
and inodes that were created for every directory and file that was used for
events. As there's 10s of thousands of files and directories that adds up.
And if you create a new instance, you create another 10s of thousands of
files and directories that are basically all the same.

This lead to the effort to create eventfs that would remove the overhead of
these inodes and dentries with just a light weight descriptor for every
directory. As there's just around 2000 directories, its the files that take
up most of the memory.

What got us here is the evolution of changes that were made. Now you can
argue that when tracefs was first moved out of debugfs I should have based
it on kernfs. I actually did look at that, but because it behaved so much
differently than debugfs (which was the only thing in VFS that I was
familiar with), I chose debugfs instead.

The biggest savings in eventfs is the fact that it has no meta data for
files. All the directories in eventfs has a fixed number of files when they
are created. The creating of a directory passes in an array that has a list
of names and callbacks to call when the file needs to be accessed. Note,
this array is static for all events. That is, there's one array for all
event files, and one array for all event systems, they are not allocated per
directory.


> 
> And specifically for virtual filesystems they often aren't alike at
> all. And that's got nothing to do with the VFS abstractions. It's
> simply because a virtual filesystem is often used for purposes when
> developers think that they want a filesystem like userspace interface
> but don't want all of the actual filesystem semantics that come with it.
> So they all differ from each other and what functionality they actually
> implement.

I agree with the above.

> 
> And I somewhat oppose the notion that the VFS isn't documented. We do
> have extensive documentation for locking rules, a constantly updated
> changelog with fundamental changes to all VFS APIs and expectations
> around it. Including very intricate details for the reader that really
> needs to know everything. I wrote a whole document just on permission
> checking and idmappings when we added that to the VFS. Both
> implementation and theoretical background. 

I spent a lot of time reading the VFS documentation. The problem I had was
that it's very much focused for its main purpose. That is for real file
systems. It was hard to know what would apply to a pseudo file system and
what would not.

So I don't want to say that VFS isn't well documented. I would say that VFS
is a very big beast, and there's documentation that is focused on what the
majority want to do with it.

It's us outliers (pseudo file systems) that are screwing this up. And when
you come from an approach of "I just want an file systems like interface"
you really just want to know the bare minimum of VFS to get that done.

I've been approach countless of times by the embedded community (including
those that worked on the Mars helicopter) thanking me for having such a
nice file system like interface into tracing.

-- Steve

