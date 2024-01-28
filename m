Return-Path: <linux-fsdevel+bounces-9274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D05983FB1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 01:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450BC1C212AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 00:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3C845973;
	Sun, 28 Jan 2024 23:59:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD0F45955;
	Sun, 28 Jan 2024 23:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706486394; cv=none; b=dOvbRRBxK4K4U3vyc64IgUs6VVFZsc689YNlqc5cyXoGi3HlnycoBT8IHXaA1aL2XJZ4tCEQlore8AVa1tLpnJUYzTLus7UjshxdqpwHNz1vSpSkCTwxR5/hh2AwjDM7XmUUU4sGvGfrXTkec5iMHEx3pzCX3VKHGjFtAGnqhjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706486394; c=relaxed/simple;
	bh=up86wC8bCRQUbONGrMWxwGT7s8fe8Aqj1rj4oaNkE10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6BUGO7X25Jkt34e1T9PPn1cXLq9HHWdZ3vwZxAjVFMY4Odk3SnleenqTg7qMLLCVG8jkrQ0iLwQO7F7QGj7w1WVPGlfoqIU+86Ez7wj/d5IfMHdOf8r5SQ64U/MSmdsNJbKTgpi35ivZ19gCcX3xROz+DhPWPR86DI+ITzCikU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9228AC433C7;
	Sun, 28 Jan 2024 23:59:51 +0000 (UTC)
Date: Sun, 28 Jan 2024 18:59:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner
 <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240128185943.6920388b@rorschach.local.home>
In-Reply-To: <CAHk-=wjHc48QSGWtgBekej7F+Ln3b0j1tStcqyEf3S-Pj_MHHw@mail.gmail.com>
References: <20240126150209.367ff402@gandalf.local.home>
	<CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
	<20240126162626.31d90da9@gandalf.local.home>
	<CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
	<CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
	<CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
	<20240128175111.69f8b973@rorschach.local.home>
	<CAHk-=wjHc48QSGWtgBekej7F+Ln3b0j1tStcqyEf3S-Pj_MHHw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 15:24:09 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 28 Jan 2024 at 14:51, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I was working on getting rid of ei->dentry, but then I hit:
> >
> > void eventfs_remove_dir(struct eventfs_inode *ei)
> > { [..]
> >
> > Where it deletes the all the existing dentries in a tree. Is this a
> > valid place to keep ei->dentry?  
> 
> No, when you remove the directory, just leave the child dentries
> alone. Remember: they are purely caches, and you either have

My fear is that they can be accessed again when there's no file around.

Thus, the dentry and the inode are created when accessed with the fops
loaded that calls into the tracing code.

For example, when some creates a kprobe:

 # cd /sys/kernel/tracing
 # echo 'p:sched schedule' > kprobe_events
 # ls events/kprobes/sched/enable
enable

Now I do;

  # echo > kprobe_events

Currently if I do:

 # ls events/kprobes/sched/enable
ls: cannot access 'events/kprobes/sched/enable'

But because the dentry doesn't go away immediately, it can cause
issues. I rather not force them to be freed every time the dentry goes
to zero, as that could cause more overhead in tracing where the tooling
already does multiple scans of the eventfs directory for various
reasons.

If that dentry is still there, and someone does:

 echo 1 > events/kprobes/sched/enable

after the ei was removed, wouldn't it call back into the open callback
of the inode represented by that dentry?

If that happens, it will call into the kprobe code and reference
structures that have already been freed.

Note, before adding that simple_recursive_removal() or my open coded
version I had earlier, the kprobe files would stick around after the
kprobe was freed, and I was able to crash the kernel.

> 
>  - somebody is still using it (you can 'rmdir()' a directory that some
> other process has as its cwd, for example), which keeps it alive and
> active anyway

Wouldn't it be bad if the dentry hung around after the rmdir. You don't
want to be able to access files after rmdir has finished.

> 
>  - when the last user is done, the dcache code will just free the
> dentries anyway

But it doesn't. That debug code I had before that showed the ei->dentry
in show_event_dentries file would show that the dentries exist for some
time when their ref count was zero. They only got freed when on
drop_caches or memory reclaim.

I like the fact that they hang around that we are not constantly
allocating them for every reference.

> 
> so there's no reason to remove any of the dentries by hand - and in
> fact simple_recursive_removal() never did that anyway for anything
> that was still busy.
> 
> For a pure cached set of dentries (that have no users), doing the last
> "dput()" on a directory will free that directory dentry, but it will
> also automatically free all the unreachable children recursively.

But it doesn't free it. It just makes it available to be freed.

> 
> Sure, simple_recursive_removal() does other things (sets inode flags
> to S_DEAD, does fsnotify etc), but none of those should actually
> matter.
> 
> I think that whole logic is simply left-over from when the dentries
> weren't a filesystem cache, but were the *actual* filesystem. So it
> actually became actively wrong when you started doing your own backing
> store, but it just didn't hurt (except for code legibility).
> 
> Of course, eventfs is slightly odd and special in that this isn't a
> normal "rmdir()", so it can happen with files still populated. And
> those children will stick around  and be useless baggage until they
> are shrunk under memory pressure.
> 
> But I don't think it should *semantically* matter, exactly because
> they always could stay around anyway due to having users.

It does, because things like kprobes will call into tracefs to free its
files so that it can free its own resources as the open callback will
reference those resources. If those dentries sick around and allow the
user to open the file again, it will cause a use after free bug.

It does keep track of opens so the kprobe code will not be freed if a
task has a reference already. You get an -EBUSY on the removal of
kprobes if something has a reference to it.

But on deleting, the return from the eventfs code that deleted the
directory, is expected that there will be no more opens on the kprobe
files. With stale dentries hanging around after the directory is
deleted, that is not the case.

> 
> There are some cacheability knobs like
> 
>         .d_delete = always_delete_dentry,
> 
> which probably makes sense for any virtual filesystem (it limits
> caching of dentries with no more users - normally the dcache will
> happily keep caching dentries for the *next* user, but that may or may
> not make sense for virtual filesystems)

But if it were freed every time there's no more users, then when you do
a stat() it will get referenced then freed (as the dentry ref count
goes to zero after the stat() is completed). then the open/write/close
will create and delete it, and this could be done several times for the
same file. If the dentry is freed every time its ref count goes to
zero, then it will need to be created for every operation.

> 
> So there is tuning that can be done, but in general, I think you
> should actively think of the dcache as just "it's just a cache, leave
> stale stuff alone"

I would like to keep it as a cache, but deleting every time the ref
count goes to zero is not much of a cache.

-- Steve

