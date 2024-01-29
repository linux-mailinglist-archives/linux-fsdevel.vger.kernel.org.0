Return-Path: <linux-fsdevel+bounces-9283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F18F83FC05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 03:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90582811FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 02:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC48E55F;
	Mon, 29 Jan 2024 02:09:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85DADF44;
	Mon, 29 Jan 2024 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706494180; cv=none; b=Edj/qNs5xPwBE91yBypj7Eu6sU4m1ByiGy31P5l8HikBsnb0cuwpJCm9LTUuagmQtuUiZgzXTtKhkqiaonwHi1/d/nUFb8c6LMRxZ3yqzzy8l/3wZUVo1eDVcFJqQbgkbTDTRX7Sp0GH83ZDFJ+zd3Atb7+FVr5w5yztsyzZ9ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706494180; c=relaxed/simple;
	bh=ZI5bfeMiWLdc2ODGRFM8dJyUMH39PhBXqP6SHy8L1Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDFeYx47GtOG3l5kbo0nP3dypI4ofqm2kqmKdhYyqprOmFqwgxEqetGLB2lod2l46mxIEhcb/btDQjiyl0JB6gsoIRafwcjan0XzfAKNuEqJLktTFq7BuONYkUC2lOpVZ00p9WWp6DarEHBvJBOSe9fA15YEjHecAVZBzcLdVZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7607FC433C7;
	Mon, 29 Jan 2024 02:09:39 +0000 (UTC)
Date: Sun, 28 Jan 2024 21:09:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner
 <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240128210938.436fc3b4@rorschach.local.home>
In-Reply-To: <CAHk-=wg7tML8L+27j=7fh8Etk4Wvo0Ay3mS5U7JOTEGxjy1viA@mail.gmail.com>
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
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 17:00:08 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 28 Jan 2024 at 16:21, Steven Rostedt <rostedt@goodmis.org> wrote:
> >  
> > >
> > > Wouldn't it be bad if the dentry hung around after the rmdir. You don't
> > > want to be able to access files after rmdir has finished.  
> 
> Steven, I already told you that that is NORMAL.
> 
> This is how UNIX filesystems work. Try this:
> 
>    mkdir dummy
>    cd dummy
>    echo "Hello" > hello
>    ( sleep 10; cat ) < hello &

Running strace on the above we have:

openat(AT_FDCWD, "hello", O_RDONLY)     = 3
dup2(3, 0)                              = 0
close(3)                                = 0
newfstatat(AT_FDCWD, "/usr/local/sbin/sleep", 0x7ffee0e44a60, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/usr/local/bin/sleep", 0x7ffee0e44a60, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/usr/sbin/sleep", 0x7ffee0e44a60, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/usr/bin/sleep", {st_mode=S_IFREG|0755, st_size=43888, ...}, 0) = 0
rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) = 0

So the file is ***opened*** and gets a referenced. YES I DEAL WITH THIS!!!

This works fine! I have no problems with this.


>    rm hello
>    cd ..
>    rmdir dummy
> 
> and guess what? It will print "hello" after that file has been
> removed, and the whole directory is gone.
> 
> YOU NEED TO DEAL WITH THIS.

And I do very well THANK YOU!

But if this does not call that simple_recursive_removal() the dentry
*STAYS AROUND* and things CAN OPEN IT AFTER IT HAS BEEN REMOVED!
That's equivalent to doing an ls on a directory you just deleted with
rmdir and you still see the files.

Note, eventfs has no call to rmdir here. It's a virtual file system. The
directories disappear without user accessing the directory.

Same for /proc. The directories for pids come and go when processes
fork and exit. You don't want someone to be able to access /proc/1234
*after* the task 1234 exited and was cleaned up by its parent. Do you?

And I'm not talking about if something opened the files in /proc/1234
before the task disappeared. That is dealt with. Just like if a file in
eventfs is opened and the backing data is to be deleted. It either
prevents the deletion, or in some cases it uses ref counts to know that
something still has one of its files open. And it won't delete the data
until everything has closed it. But after a file or directory has been
deleted, NO file system allows it to be opened again.

This isn't about something opening a file in eventfs and getting a
reference to it, and then the file or directory is being deleted.
That's covered. I'm talking about the directory being deleted and then
allowing something to open a file within it AFTER the deletion has
occurred. If a dentry is still around, THAT CAN HAPPEN! 

With a dentry still around with nothing accessing it, and you remove the
data it represents, if you don't make that dentry invisible to user
space, it can be opened AFTER it has been deleted. Without calling
d_invalidate (which calls shrink_dcache_parent) on the dentry, it is
still visible. Even with a ref count of zero and nothing has it opened.
That means you can open that file again AFTER it has been deleted. The
vfs_rmdir() calls shrink_dcache_parent() that looks to prune the dcache
to make it not visible any more. But vfs_rmdir isn't ever called for
eventfs.

procfs calls d_invalidate which removes the dentry from being visible
to the file system. I *use* to do that too until Al Viro suggested that
I use the simple_recursive_removal() call that does all that for me.

> 
> > And thinking about this more, this is one thing that is different with
> > eventfs than a normal file system. The rmdir in most cases where
> > directories are deleted in eventfs will fail if there's any open files
> > within it.  
> 
> No.
> 
> Stop thinking that eventfs is special. It's not.

It's not special with respect to other virtual file systems, but
virtual file systems *are* special compared to regular file systems.
Why? Because regular file systems go through the VFS layer for pretty
much *all* interactions with them.

Virtual file systems interact with the kernel without going through VFS
layer. In normal file systems, to remove a directory you have to go
through rmdir which does all the nice things your are telling me about.

But virtual file systems directories (except for tmpfs) have their
directories removed by other means. The VFS layer *has no idea* that a
directory is removed. With eventfs calling that simple_recursive_removal()
tells the VFS layer this directory is being deleted, just as if someone
called rmdir(). If I don't call that function VFS will think the
directory is still around and be happy to allow users to open files in
it AFTER the directory has been deleted.

Your example above does not do what I'm talking about here. It shows
something OPENING a file and then deleting the directory. Yes, if you
have an opened reference to something and it gets deleted, you still
have access to that reference. But you should not be able to get a new
reference to something after it has been deleted.

> 
> You need to deal with the realities of having made a filesystem. And
> one of those realities is that you don't control the dentries, and you
> can't randomly cache dentry state and then do things behind the VFS
> layer's back.

I'm not. I'm trying to let VFS know a directory is deleted. Because
when you delete a kprobe, the directory that has the control files for
that kprobe (like enabling it) go away too. I have to let VFS know that
the directory is deleted, just like procfs has to tell it when a
directory for a process id is no more.

You don't kill tasks with: rmdir /proc/1234

And you don't delete kprobes with: rmdir events/kprobe/sched

> 
> So remove that broken function. Really.  You did a filesystem, and
> that means that you had better play by the VFS rules.
> 
> End of discussion.

And I do it just like debugfs when it deletes files outside of VFS or
procfs, and pretty much most virtual file systems.

> 
> Now, you can then make your own "read" and "lookup" etc functions say
> "if the backing store data has been marked dead, I'll not do this".
> That's *YOUR* data structures, and that's your choice.
> 
> But you need to STOP thinking you can play games with dentries.  And
> you need to stop making up BS arguments for why  you should be able
> to.
> 
> So if you are thinking of a "Here's how to do a virtual filesystem"
> talk, I would suggest you start with one single word: "Don't".
> 
> I'm convinced that we have made it much too easy to do a half-arsed
> virtual filesystem. And eventfs is way beyond half-arsed.
> 
> It's now gone from half-arsed to "I told you how to do this right, and
> you are still arguing". That makes it full-arsed.
> 
> So just stop the arsing around, and just get rid of those _broken_ dentry games.

Sorry, but you didn't prove your point. The example you gave me is
already covered. Please tell me when a kprobe goes away, how do I let
VFS know? Currently the tracing code (like kprobes and synthetic
events) calls eventfs_remove_dir() with just a reference to that ei
eventfs_inode structure. I currently use the ei->dentry to tell VFS
"this directory is being deleted". What other means do I have to
accomplish the same thing?

-- Steve

