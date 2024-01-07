Return-Path: <linux-fsdevel+bounces-7512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1102C826570
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jan 2024 19:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC9EB213FD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jan 2024 18:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A894A13FEE;
	Sun,  7 Jan 2024 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1JJUUct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5613FE0;
	Sun,  7 Jan 2024 18:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C534C433C7;
	Sun,  7 Jan 2024 18:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704650511;
	bh=OKmshA2l4n6o6z7uWqL+UJpUgByybbRvwWTD/bLY2YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s1JJUUctn9+GpXapycqkTfQDBnBlfSMnyhWZGU0ouOdP0/M9+Hd6tVvBPz/EzvmPA
	 nTr9FAffbRJVAd//zh8kwlTK713yMU/4FN3gv0isVRDl+FT892a/znKCKrl/ep4dH+
	 fwCV4s/CPkyioQ9t7Owz4qYd3TwOmCQUWfubrMYQdJpA/hrJZqaidpSlVQJe8QAiRb
	 hJCXsKLjRI3ZNMKRXFTFhy8B/WX+7qN7b3ew9z4fICDMiqHBAO/lol06ZYhiYAijtu
	 IaL5f67DHycoqxMJhHD/IeglMktY5Jw+WMKhFEmA10fbqRiE2xAdZzKEmuYgQTlDNo
	 eYqC6WmRpWZnw==
Date: Sun, 7 Jan 2024 19:01:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default
 ownership
Message-ID: <20240107-verzichten-knauf-dfbbec566fdb@brauner>
References: <20240103203246.115732ec@gandalf.local.home>
 <20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
 <20240105095954.67de63c2@gandalf.local.home>
 <20240107-getrickst-angeeignet-049cea8cad13@brauner>
 <20240107-ernennen-braumeister-c443c5dc6946@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240107-ernennen-braumeister-c443c5dc6946@brauner>

On Sun, Jan 07, 2024 at 06:42:33PM +0100, Christian Brauner wrote:
> On Sun, Jan 07, 2024 at 01:42:39PM +0100, Christian Brauner wrote:
> > > > So tracefs supports remounting with different uid/gid mount options and
> > > > then actually wades through _all_ of the inodes and changes their
> > > > ownership internally? What's the use-case for this? Containers?
> > > 
> > > No, in fact tracing doesn't work well with containers as tracing is global
> > > to the entire machine. It can work with privileged containers though.
> > 
> > At least the tracefs interface is easily supportable within a delegation
> > model. IOW, you have a privileged process that delegates relevant
> > portions to a container via idmapped mounts _without_ doing the insane thing
> > and making it mountable by a container aka the fs-to-CVE pipeline.
> > 
> > > 
> > > The reason for this is because tracefs was based off of debugfs where the
> > > files and directores are created at boot up and mounted later. The reason
> > > to do this was to allow users to mount with gid=GID to allow a given group
> > > to have access to tracing. Without this update, tracefs would ignore it
> > > like debugfs and proc does today.
> > > 
> > > I think its time I explain the purpose of tracefs and how it came to be.
> > > 
> > > The tracing system required a way to control tracing and read the traces.
> > > It could have just used a new system like perf (although
> > > /sys/kernel/debug/tracing predates perf), where it created a single ioctl()
> > > like system call do do everything.
> > > 
> > > As the ftrace tracing came from PREEMPT_RT latency tracer and my own logdev
> > > tracer, which both have an embedded background, I chose an interface that
> > > could work with just an unmodified version of busybox. That is, I wanted it
> > > to work with just cat and echo.
> > > 
> > > The main difference with tracefs compared to other file systems is that it
> > > is a control interface, where writes happen as much as reads. The data read
> > > is controlled. The closest thing I can think of is how cgroups work.
> > > 
> > > As tracing is a privileged operation, but something that could be changed
> > > to allow a group to have access to, I wanted to make it easy for an admin
> > > to decide who gets to do what at boot up via the /etc/fstab file.
> > 
> > Yeah, ok. I think you could achieve the same thing via idmapped mounts. You
> > just need to swap out the mnt on /sys/kernel/tracing with an idmapped mount.
> > 
> > mount(8) should just give you the ability to specify "map the ids I explicitly
> > want to remap to something else and for the rest use the identity mapping". I
> > wanted that for other reasons anyway.
> > 
> > So in one of the next versions of mount(8) you can then do (where --beneath
> > means place the mount beneath the current one and --replace is
> > self-explanatory):
> > 
> > sudo mount --beneath -o X-mount.idmap='g:0:1234:1 u:0:0:1' /sys/kernel/tracing
> > sudo umount /sys/kernel/tracing
> > 
> > or as a shortcut provided by mount(8):
> > 
> > sudo mount --replace -o X-mount.idmap='g:0:1234:1 u:0:0:1' /sys/kernel/tracing 
> > 
> > In both cases you replace the mount without unmounting tracefs.
> > 
> > I can illustrate this right now though:
> > 
> > user1@localhost:~$ sudo mount --bind -o X-mount.idmap='g:0:1000:1 u:0:1000:1' /sys/kernel/tracing/ /mnt/
> > 
> > # This is a tool I wrote for testing the patchset I wrote back then.
> > user1@localhost:~/data/move-mount-beneath$ sudo ./move-mount --beneath --detached /mnt /sys/kernel/tracing
> > Mounting beneath top mount
> > Creating anonymous mount
> > Attaching mount /mnt -> /sys/kernel/tracing
> > Creating single detached mount
> > 
> > user1@localhost:~/data/move-mount-beneath$
> > 
> > # Now there's two mounts stacked on top of each other.
> > user1@localhost:~/data/move-mount-beneath$ findmnt | grep tracing
> > | `-/sys/kernel/tracing        tracefs        tracefs     rw,nosuid,nodev,noexec,relatime,idmapped
> > |   `-/sys/kernel/tracing      tracefs        tracefs     rw,nosuid,nodev,noexec,relatime
> > 
> > user1@localhost:~/data/move-mount-beneath$ sudo ls -al /sys/kernel/tracing/| head
> > total 0
> > drwx------  6 root root 0 Jan  7 13:33 .
> > drwxr-xr-x 16 root root 0 Jan  7 13:33 ..
> > -r--r-----  1 root root 0 Jan  7 13:33 README
> > -r--r-----  1 root root 0 Jan  7 13:33 available_events
> > -r--r-----  1 root root 0 Jan  7 13:33 available_filter_functions
> > -r--r-----  1 root root 0 Jan  7 13:33 available_filter_functions_addrs
> > -r--r-----  1 root root 0 Jan  7 13:33 available_tracers
> > -rw-r-----  1 root root 0 Jan  7 13:33 buffer_percent
> > -rw-r-----  1 root root 0 Jan  7 13:33 buffer_size_kb
> > 
> > # Reveal updated mount
> > user1@localhost:~/data/move-mount-beneath$ sudo umount /sys/kernel/tracing
> > 
> > user1@localhost:~/data/move-mount-beneath$ findmnt | grep tracing
> > | `-/sys/kernel/tracing        tracefs        tracefs     rw,nosuid,nodev,noexec,relatime,idmapped
> > 
> > user1@localhost:~/data/move-mount-beneath$ sudo ls -al /sys/kernel/tracing/| head
> > total 0
> > drwx------  6 user1 user1 0 Jan  7 13:33 .
> > drwxr-xr-x 16 root  root  0 Jan  7 13:33 ..
> > -r--r-----  1 user1 user1 0 Jan  7 13:33 README
> > -r--r-----  1 user1 user1 0 Jan  7 13:33 available_events
> > -r--r-----  1 user1 user1 0 Jan  7 13:33 available_filter_functions
> > -r--r-----  1 user1 user1 0 Jan  7 13:33 available_filter_functions_addrs
> > -r--r-----  1 user1 user1 0 Jan  7 13:33 available_tracers
> > -rw-r-----  1 user1 user1 0 Jan  7 13:33 buffer_percent
> > -rw-r-----  1 user1 user1 0 Jan  7 13:33 buffer_size_kb
> > 
> > sudo umount -l /sys/kernel/tracing
> > 
> > and reveal the new mount with updated permissions and at no point in time will
> > you have had to unmount tracefs itself. No chown needed, no remount needed that
> > has to touch all inodes.
> > 
> > I did perf numbers for this when I implemented this and there's no meaningful
> > perf impact for anything below 5 mappings. which covers 80% of the use-cases.
> > 
> > I mean, there are crazy people out there that do have 30 mappings, maybe. And
> > maybe there's 3 users that go into the hundreds (340 is maximum so struct idmap
> > still fits into cacheline) because of some LDAP crap or something.
> > 
> > See an ext4 filesystem to open/create 1,000,000 files. Then I looped through
> > all of the files calling fstat() on each of them 1000 times and calculated the
> > mean fstat() time for a single file.
> > 
> > |   # MAPPINGS | PATCH-NEW |
> > |--------------|-----------|
> > |   0 mappings |   158 ns  |
> > |   1 mappings |   157 ns  |
> > |   2 mappings |   158 ns  |
> > |   3 mappings |   161 ns  |
> > |   5 mappings |   165 ns  |
> > |  10 mappings |   199 ns  |
> > |  50 mappings |   218 ns  |
> > | 100 mappings |   229 ns  |
> > | 200 mappings |   239 ns  |
> > | 300 mappings |   240 ns  |
> > | 340 mappings |   248 ns  |
> > 
> > > 
> > > > 
> > > > Aside from optimizing this and the special semantics for this eventfs
> > > > stuff that you really should think twice of doing, here's one idea for
> > > > an extension that might alleviate some of the pain:
> > > > 
> > > > If you need flexible dynamic ownership change to e.g., be able to
> > > > delegate (all, a directory, a single file of) tracefs to
> > > > unprivileged/containers/whatever then you might want to consider
> > > > supporting idmapped mounts for tracefs. Because then you can do stuff
> > > > like:
> > > 
> > > I'm a novice here and have no idea on how id maps work ;-)
> > 
> > It's no magic and you don't even need to care about it. If you're on
> > util-linux 2.39 and any kernel post 5.12 the -o X-mount.idmap option
> > does all the details for you.
> > 
> > Though I still want an api where you can just pass the idmappings directly to
> > mount_setattr(). That's another topic though.
> > 
> > > have. Now, can we do that and still keep the dynamic creation of inodes and
> > > dentries?
> > 
> > Yes.
> > 
> > > Does this require having more than one dentry per inode?
> > 
> > No. It's just a topological change. The same subtree exposed at different
> > locations with the ability of exposing it with different permissions (without
> > any persistent filesystem-level changes).
> > 
> > So, I tried to do an exploratory patch even though I promised myself not
> > to do it. But hey...
> > 
> > Some notes:
> > 
> > * Permission handling for idmapped mounts is done completely in the
> >   VFS. That's the case for all filesytems that don't have a custom
> >   ->permission() handler. So there's nothing to do for us here.
> > 
> > * Idmapped mount handling for ->getattr() is done completely by the VFS
> >   if the filesystem doesn't have a custom ->getattr() handler. So we're
> >   done here.
> > 
> > * Tracefs doesn't support attribute changes via ->setattr() (chown(),
> >   chmod etc.). So there's nothing to here.
> > 
> > * Eventfs does support attribute changes via ->setattr(). But it relies
> >   on simple_setattr() which is already idmapped mount aware. So there's
> >   nothing for us to do.
> > 
> > * Ownership is inherited from the parent inode (tracefs) or optionally
> >   from stashed ownership information (eventfs). That means the idmapping
> >   is irrelevant here. It's similar to the "inherit gid from parent
> >   directory" logic we have in some circumstances. TL;DR nothing to do
> >   here as well.
> > 
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
> > 
> > Here, all possible entries beneath foo including "events" and further
> > below are recorded and stored. So once mkdir returns it basically means
> > that it succeeded with the creation of all the necessary directories and
> > files. For all purposes the foo/events/ directory and below have all the
> > entries that matter. They have been created. It's comparable to them not
> > being in the {d,i}cache, I guess.
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
> > 
> > IOW, the inode_permission() in lookup_one_len() that eventfs does is
> > redundant and just wrong.
> > 
> > Luckily, I don't think we need to even change anything because all
> > directories that eventfs creates always grant exec permissions to the
> > other group so lookup_one_len() will trivially succeed. IIUC.
> > 
> > Drafted-by-with-no-guarantees-whatsoever-that-this-wont-burn-the-house-down: Christian Brauner <brauner@kernel.org>
> 
> Actually, I think that patch can be way simpler for a similar reason
> than I mentioned before. In the regular system call for tracefs we have:
> 
> mkdir /sys/kernel/tracing/instances/foo
> 
> -> do_mkdirat("foo")
>    -> i_op->mkdir::tracefs_syscall_mkdir(child_dentry::foo, parent_inode)
>       -> char *name = get_dname(child_dentry::foo) // duplicate the dentries name
>       -> tracefs_ops.mkdir::instance_mkdir("foo")
>         -> trace_array_create("foo")
> 	   -> trace_array_create_dir("foo")
> 	      -> tracefs_create_dir("foo", trace_instance_dir)
> 	         -> __create_dir("foo", trace_instance_dir)
>         	    -> tracefs_start_creating("foo", trace_instance_dir)
> 		       -> lookup_one_len("foo", trace_instance_dir) // perform the lookup again and find @child_dentry again that the vfs already created
> 
> So afaict, the vfs has created you the correct target dentry and
> performed the required permission checks already.
> 
> You then go on to retrieve and duplicate the name of the dentry and pass
> that name down. And then you perform a lookup via lookup_one_len() on
> the instances directory. And here lookup_one_len() performs the
> permission checking again that the vfs already did in may_lookup() when
> it walked up to the "instances" directory.
> 
> The reason I'm saying this is that for tracefs _the only reason_ we need
> that idmapping in any of these helpers at all is because of the
> superfluous permission check in lookup_one_len(). Because for actual
> ownership of the inode it's completely irrelevant because you inherit
> the ownership anyway. IOW, the callers fs{g,u}id etc is entirely
> irrelevant.
> 
> So basically if you massage the system call path to simply reuse the
> dentry that the vfs already given you instead of looking it up again
> later the whole patch is literally (baring anything minor I forgot):
> 
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index ae648deed019..2de3ec114793 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -439,6 +439,7 @@ static struct file_system_type trace_fs_type = {
>         .name =         "tracefs",
>         .mount =        trace_mount,
>         .kill_sb =      kill_litter_super,
> +       .fs_flags =     FS_ALLOW_IDMAP,
>  };
>  MODULE_ALIAS_FS("tracefs");
> 
> Because tracefs simply inherits ownership from parent directories or
> from stashed info the idmapping is entirely immaterial on the creation
> side of things. As soon as the permission checking in the VFS has
> succeeded we know that things are alright.
> 
> So really, the complexity is getting in your way here. The
> tracefs_ops.mkdir thing is only used in a single location and that is
> 
> kernel/trace/trace.c:   trace_instance_dir = tracefs_create_instance_dir("instances", d_tracer,
> 
> and there's only one callback instance_mkdir().
> 
> otherwise that callback ops stuff is completely unused iiuc. If that's
> the case it would make a lot more sense to just reuse everything that
> the VFS has given you in the regular system call path than to do that
> "copy the name and do the lookup again including permission checks
> later" dance.
> 
> Idk, maybe I'm seeing things and there's an obvious reason why my
> thinking is all wrong and that permission check is required. I just
> don't see it though. But I'm sure people will tell me what my error is.
> 
> At least for the system call path it shouldn't be.

I guess an argument would be that the check is somewhat required because
you create a whole hierarchy of directories and files beneath the top
level directory that the system call path creates.

But then would you ever want to fail creating any directories or files
beneath /sys/kernel/tracing/instances/foo/* if the VFS told you that you
have the required permission to create the top level directory
/sys/kernel/tracing/instances/foo?

I think that isn't the case and it isn't even possible currently. So
even for the directories and files beneath the top level directory the
permission check is irrelevant iiuc.

Anyway, I don't think you necessarily need to change any of what you do
right now. The first version of the patch will work with what you
currently have and is correct. It's just more complex because of that
additional permission checking that I think isn't needed. Because it's
not that the user has any control over the creation of the subtree
beneath /sys/kernel/tracing/instances/foo/*. But again, I might be
completely off.

