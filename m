Return-Path: <linux-fsdevel+bounces-9340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 140D18401C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95FCC1F21902
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FED57865;
	Mon, 29 Jan 2024 09:32:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD155730E;
	Mon, 29 Jan 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520778; cv=none; b=M2dCUsbmmBSLwJzccu0LTOBZ2JVM3OxUP4V3hSiFOkqAnYPhnWZGGrDQk0ZJY6YIGCelgXdMciqBIirlYVysE1LSYvRuNB4pUqPuRcNYROf1zDKCLqO0AIwrK6UXsCbSyoJiMjKWuOLow64e1B8cUbZm5cyveU9cM6XPCIJ9c6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520778; c=relaxed/simple;
	bh=RNCTIC1LHxN8TP52KyYN51dpjEvqeKfPe48AkEi5JGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIbN9FYk43nQ8XG1zXkUfuvXuUidTE2LJPrCUPescBRxlk3l7VL6Ud4nzmI2SsrBoc0Vb9Bm74fIb+8eay29ljnvFxlPcTpu6XltrzV/D3IXWhNLN7N6hO3NWAs6/nD+4tz1KY00cuLZQEvZQM8+0APOFmZBp8JAf/ZKe3i1ZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A35C43394;
	Mon, 29 Jan 2024 09:32:56 +0000 (UTC)
Date: Mon, 29 Jan 2024 04:32:55 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 LKML <linux-kernel@vger.kernel.org>, Linux Trace Devel
 <linux-trace-devel@vger.kernel.org>, Christian Brauner
 <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Al
 Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240129043255.0487d864@rorschach.local.home>
In-Reply-To: <CAOQ4uxikMN9EapL5+6jtMn5Ahe4h7wGZOgEsdsjy87v72FxJDw@mail.gmail.com>
References: <20240126150209.367ff402@gandalf.local.home>
	<CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
	<20240126162626.31d90da9@gandalf.local.home>
	<CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
	<CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
	<CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
	<20240128175111.69f8b973@rorschach.local.home>
	<CAHk-=wjHc48QSGWtgBekej7F+Ln3b0j1tStcqyEf3S-Pj_MHHw@mail.gmail.com>
	<20240128185943.6920388b@rorschach.local.home>
	<20240128192108.6875ecf4@rorschach.local.home>
	<CAHk-=wg7tML8L+27j=7fh8Etk4Wvo0Ay3mS5U7JOTEGxjy1viA@mail.gmail.com>
	<20240128210938.436fc3b4@rorschach.local.home>
	<CAOQ4uxikMN9EapL5+6jtMn5Ahe4h7wGZOgEsdsjy87v72FxJDw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 08:44:29 +0200
Amir Goldstein <amir73il@gmail.com> wrote:

Hi Amir,

[ Suffering a bit of insomnia, I made the mistake of reading email from
  bed, and now I have to reply :-p ]

> >
> > And I do it just like debugfs when it deletes files outside of VFS or
> > procfs, and pretty much most virtual file systems.
> >  
> 
> I think it is better if we used the term "pseudo" file systems, because
> to me VFS already stands for "virtual file system".

Oops, you are absolutely correct. I meant "pseudo" but somehow switch
to saying "virtual". :-p

> >
> > Sorry, but you didn't prove your point. The example you gave me is
> > already covered. Please tell me when a kprobe goes away, how do I let
> > VFS know? Currently the tracing code (like kprobes and synthetic
> > events) calls eventfs_remove_dir() with just a reference to that ei
> > eventfs_inode structure. I currently use the ei->dentry to tell VFS
> > "this directory is being deleted". What other means do I have to
> > accomplish the same thing?
> >  
> 
> Would kernfs_node_dentry() have been useful in that case?
> Just looking at kernfs_node and eventfs_inode gives a very strong
> smell of reinventing.

Close, but looking at kernfs real quick, I think I see the difference
and why eventfs relies on the dentry, and why it doesn't need to.

> 
> Note that the fact that eventfs has no rename makes the whole dentry
> business a lot less complicated than it is in the general VFS case -
> IIUC, an eventfs path either exists or it does not exist, but if it exists,
> it conceptually always refers to the same underlying object (kprobe).
> 
> I am not claiming that kernfs can do everything that eventfs needs  -
> I don't know, because I did not look into it.

eventfs has one other major simplicity that kernfs does not. Not only
does it not have renames, but files are not created or deleted
individually. That is, when a directory is created, it will have a
fixed number of files. It will have those same files until the
directory is deleted.

That means I have no meta data saving anything about the files, except
a fixed array that that holds only a name and a callback for each file
in that directory.

> 
> But the concept of detaching the pseudo filesystem backing objects
> from the vfs objects was already invented once and Greg has also
> said the same thing.
> 
> My *feeling* at this point is that the best course of action is to use
> kernfs and to improve kernfs to meet eventfs needs, if anything needs
> improving at all.
> 
> IMO, the length and content of this correspondence in itself
> is proof that virtual file systems should use an abstraction that
> is much less flexible than the VFS.
> 
> Think of it this way - kernefs and VFS are both under-documented,
> but the chances of getting kernfs well documented are far better
> than ever being able to document all the subtleties of VFS for mortals.
> 
> IOW, I would be happy if instead of the LSFMM topic
> "Making pseudo file systems inodes/dentries more like normal file systems"
> We would be talking about
> "Best practices for writing a pseudo filesystem" and/or
> "Missing kernfs functionality for writing pseudo filesystems"

I'm fine with that, and I think I also understand how to solve the
issue with Linus here.

Linus hates the fact that eventfs_inode has a reference to the dentry.
The reason I do that is because when the dentry is created, it happens
in lookup with a given file name. The registered callback for the file
name will return back a "data" pointer that gets assigned to the
dentry's inode->i_private data. This gets returned directly to the
open function calls.

That is, the kprobe will register a handle that gets assigned to the
inode->i_private data just like it did when it was in debugfs. Then the
open() call would get the kprode data via the inode->i_private.

This is why reference counters do not work here. If I don't make the
dentry and inode go away after the last reference, it is possible to
call that open function with the i_private data directly.

I noticed that kernfs assigns the kernfs_inode to the i_private data.
Thus it has some control over what's in the i_private.

I use that simple_recursive_removal() to clear out any inodes that have
a dentry ref count of zero so that there will be no inode->i_private
references in the open.

I'll have to look more at kernfs to see how it works. Perhaps it can
give me some ideas on not having to use dentry.

Hmm, I may have been looking at this all wrong. I don't need the
dentry. I need the inode! Instead of keeping a pointer to the dentry in
the eventfs_inode, I should just be keeping a pointer to the inode. As
then I could remove the inode->i_private to NULL on the last reference.
The open() calls will have to check for NULL in that case.

Are inodes part of the VFS system like dentry is?

I would think not as tracefs has a "container_of" around the inode to
get to the tracefs_inode, just like many other file systems do.

That would remove my need to have to keep around any dentry.

I first need to know why I'm seeing "ghost" files. That is without that
simple_recursive_removal() call, I get:

 # echo 'p:sched schedule' >> /sys/kernel/tracing/kprobe_events 
 # echo 'p:timer read_current_timer' >> kprobe_events 
 # ls events/kprobes/
enable  filter  sched  timer

 # cat events/kprobes/sched/enable
0

 # ls events/kprobes/sched
enable  filter  format  hist  hist_debug  id  inject  trigger

 # echo '-:sched schedule' >> /sys/kernel/tracing/kprobe_events 
 # ls events/kprobes
enable  filter  timer

 # ls events/kprobes/sched/enable
events/kprobes/sched/enable

  ??

The sched directory has been deleted but I can still "ls" the files
within it.

-- Steve

