Return-Path: <linux-fsdevel+bounces-7473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22AF82563A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 15:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153DC1C20B70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 14:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA962E3FF;
	Fri,  5 Jan 2024 14:58:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B099F2E3EC;
	Fri,  5 Jan 2024 14:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402CCC433C8;
	Fri,  5 Jan 2024 14:58:47 +0000 (UTC)
Date: Fri, 5 Jan 2024 09:59:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Al Viro
 <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as
 default ownership
Message-ID: <20240105095954.67de63c2@gandalf.local.home>
In-Reply-To: <20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
References: <20240103203246.115732ec@gandalf.local.home>
	<20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jan 2024 15:26:28 +0100
Christian Brauner <brauner@kernel.org> wrote:

> On Wed, Jan 03, 2024 at 08:32:46PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > Instead of walking the dentries on mount/remount to update the gid values of
> > all the dentries if a gid option is specified on mount, just update the root
> > inode. Add .getattr, .setattr, and .permissions on the tracefs inode
> > operations to update the permissions of the files and directories.
> > 
> > For all files and directories in the top level instance:
> > 
> >  /sys/kernel/tracing/*
> > 
> > It will use the root inode as the default permissions. The inode that
> > represents: /sys/kernel/tracing (or wherever it is mounted).
> > 
> > When an instance is created:
> > 
> >  mkdir /sys/kernel/tracing/instance/foo
> > 
> > The directory "foo" and all its files and directories underneath will use
> > the default of what foo is when it was created. A remount of tracefs will
> > not affect it.  
> 
> That kinda sounds like eventfs should actually be a separate filesystem.
> But I don't know enough about the relationship between the two concepts.

It may someday become one, as eventfs is used by perf where the rest of the
tracefs system is not.

> 
> > 
> > If a user were to modify the permissions of any file or directory in
> > tracefs, it will also no longer be modified by a change in ownership of a
> > remount.  
> 
> Very odd semantics and I would recommend to avoid that. It's just plain
> weird imo.
> 
> > 
> > The events directory, if it is in the top level instance, will use the
> > tracefs root inode as the default ownership for itself and all the files and
> > directories below it.
> > 
> > For the events directory in an instance ("foo"), it will keep the ownership
> > of what it was when it was created, and that will be used as the default
> > ownership for the files and directories beneath it.
> > 
> > Link: https://lore.kernel.org/linux-trace-kernel/CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com/
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---  
> 
> So tracefs supports remounting with different uid/gid mount options and
> then actually wades through _all_ of the inodes and changes their
> ownership internally? What's the use-case for this? Containers?

No, in fact tracing doesn't work well with containers as tracing is global
to the entire machine. It can work with privileged containers though.

The reason for this is because tracefs was based off of debugfs where the
files and directores are created at boot up and mounted later. The reason
to do this was to allow users to mount with gid=GID to allow a given group
to have access to tracing. Without this update, tracefs would ignore it
like debugfs and proc does today.

I think its time I explain the purpose of tracefs and how it came to be.

The tracing system required a way to control tracing and read the traces.
It could have just used a new system like perf (although
/sys/kernel/debug/tracing predates perf), where it created a single ioctl()
like system call do do everything.

As the ftrace tracing came from PREEMPT_RT latency tracer and my own logdev
tracer, which both have an embedded background, I chose an interface that
could work with just an unmodified version of busybox. That is, I wanted it
to work with just cat and echo.

The main difference with tracefs compared to other file systems is that it
is a control interface, where writes happen as much as reads. The data read
is controlled. The closest thing I can think of is how cgroups work.

As tracing is a privileged operation, but something that could be changed
to allow a group to have access to, I wanted to make it easy for an admin
to decide who gets to do what at boot up via the /etc/fstab file.

> 
> Aside from optimizing this and the special semantics for this eventfs
> stuff that you really should think twice of doing, here's one idea for
> an extension that might alleviate some of the pain:
> 
> If you need flexible dynamic ownership change to e.g., be able to
> delegate (all, a directory, a single file of) tracefs to
> unprivileged/containers/whatever then you might want to consider
> supporting idmapped mounts for tracefs. Because then you can do stuff
> like:

I'm a novice here and have no idea on how id maps work ;-)

> 
> user1@localhost:~/data/scripts$ sudo mount --bind -o X-mount.idmap='g:0:1000:1 u:0:1234:1' /run/ /mnt
> user1@localhost:~/data/scripts$ ls -ln /run/
> total 12
> drwxr-xr-x  2 0  0   40 Jan  5 12:12 credentials
> drwx------  2 0  0   40 Jan  5 11:57 cryptsetup
> drwxr-xr-x  2 0  0   60 Jan  5 11:57 dbus
> drwx------  6 0  0  280 Jan  5 11:57 incus_agent
> prw-------  1 0  0    0 Jan  5 11:57 initctl
> drwxrwxrwt  4 0  0   80 Jan  5 11:57 lock
> drwxr-xr-x  3 0  0   60 Jan  5 11:57 log
> drwx------  2 0  0   40 Jan  5 11:57 lvm
> -r--r--r--  1 0  0   33 Jan  5 11:57 machine-id
> -rw-r--r--  1 0  0  101 Jan  5 11:58 motd.dynamic
> drwxr-xr-x  2 0  0   40 Jan  5 11:57 mount
> drwx------  2 0  0   40 Jan  5 11:57 multipath
> drwxr-xr-x  2 0  0   40 Jan  5 11:57 sendsigs.omit.d
> lrwxrwxrwx  1 0  0    8 Jan  5 11:57 shm -> /dev/shm
> drwx--x--x  2 0  0   40 Jan  5 11:57 sudo
> drwxr-xr-x 24 0  0  660 Jan  5 14:30 systemd
> drwxr-xr-x  6 0  0  140 Jan  5 14:30 udev
> drwxr-xr-x  4 0  0   80 Jan  5 11:58 user
> -rw-rw-r--  1 0 43 2304 Jan  5 15:15 utmp
> 
> user1@localhost:~/data/scripts$ ls -ln /mnt/
> total 12
> drwxr-xr-x  2 1234  1000   40 Jan  5 12:12 credentials
> drwx------  2 1234  1000   40 Jan  5 11:57 cryptsetup
> drwxr-xr-x  2 1234  1000   60 Jan  5 11:57 dbus
> drwxr-xr-x  2 1234  1000   40 Jan  5 11:57 incus_agent
> prw-------  1 1234  1000    0 Jan  5 11:57 initctl
> drwxr-xr-x  2 1234  1000   40 Jan  5 11:57 lock
> drwxr-xr-x  3 1234  1000   60 Jan  5 11:57 log
> drwx------  2 1234  1000   40 Jan  5 11:57 lvm
> -r--r--r--  1 1234  1000   33 Jan  5 11:57 machine-id
> -rw-r--r--  1 1234  1000  101 Jan  5 11:58 motd.dynamic
> drwxr-xr-x  2 1234  1000   40 Jan  5 11:57 mount
> drwx------  2 1234  1000   40 Jan  5 11:57 multipath
> drwxr-xr-x  2 1234  1000   40 Jan  5 11:57 sendsigs.omit.d
> lrwxrwxrwx  1 1234  1000    8 Jan  5 11:57 shm -> /dev/shm
> drwx--x--x  2 1234  1000   40 Jan  5 11:57 sudo
> drwxr-xr-x 24 1234  1000  660 Jan  5 14:30 systemd
> drwxr-xr-x  6 1234  1000  140 Jan  5 14:30 udev
> drwxr-xr-x  4 1234  1000   80 Jan  5 11:58 user
> -rw-rw-r--  1 1234 65534 2304 Jan  5 15:15 utmp
> 
> Where you can see that ownership of this tmpfs instance in this example
> is changed. I'm not trying to advocate here but this will probably
> ultimately be nicer for your users because it means that a container
> manager or whatever can be handed a part of tracefs (or all of it) and
> the ownership and access rights for that thing is correct. And you can
> get rid of that gid based access completely.
> 
> You can change uids, gids, or both. You can specify up to 340 individual
> mappings it's quite flexible.
> 
> Because then you can have a single tracefs superblock and have multiple
> mounts with different ownership for the relevant parts of tracefs that
> you want to delegate to whoever. If you need an ownership change you can
> then just create another idmapped mount with the new ownership and then
> use MOVE_MOUNT_BENEATH + umount to replace that mount.
> 
> Probably even know someone that would implement this for you (not me) if
> that sounds like something that would cover some of the use-case for the
> proposed change here. But maybe I just misunderstood things completely.

That actually sounds nice. I have no idea how to implement it, but having a
way to bind mount with different permissions looks like a nifty feature to
have. Now, can we do that and still keep the dynamic creation of inodes and
dentries? Does this require having more than one dentry per inode?

-- Steve

