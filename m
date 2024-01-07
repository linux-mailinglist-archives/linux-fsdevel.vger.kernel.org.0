Return-Path: <linux-fsdevel+bounces-7507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5746826411
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jan 2024 13:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAAA7B2173D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jan 2024 12:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D71134A6;
	Sun,  7 Jan 2024 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxxonLFV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C71F134A1;
	Sun,  7 Jan 2024 12:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023F7C433C7;
	Sun,  7 Jan 2024 12:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704631366;
	bh=xvOVRQ+haIgdBZrYLJ9fE513XIRmDYJ8HdUxFTVJh/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxxonLFVI3tAgpowr3UjxlmkjZM4iQFUsMWh0QpUgDETfPH170GzeHhK+IOZ2twok
	 oePa11c1S6Djag+IpzxMm4WBhPRMqgl+UM9kBXhQSgmtiFl96NaxUwl3vcXBP/43pN
	 ywJIW5380e50RbWIqZM1zdQpKBf9CgiTZcCBsZzn5oKpzwXKoDAXsI+laB0oWRyTed
	 V8UclYHRdLlwy7flSKtyKWFctQmnEwI5Th5t4JdO6QBZvjFoq/75p0WnvhUaiYvxSm
	 qlDxEqMkF3Qnhcop2GvaM3FDixjIQv7Y7NGvajak68Z0XVVdeR0mPBqW7CVeLs84Gb
	 Y1MQSC1SJrbjQ==
Date: Sun, 7 Jan 2024 13:42:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default
 ownership
Message-ID: <20240107-getrickst-angeeignet-049cea8cad13@brauner>
References: <20240103203246.115732ec@gandalf.local.home>
 <20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
 <20240105095954.67de63c2@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240105095954.67de63c2@gandalf.local.home>

> > So tracefs supports remounting with different uid/gid mount options and
> > then actually wades through _all_ of the inodes and changes their
> > ownership internally? What's the use-case for this? Containers?
> 
> No, in fact tracing doesn't work well with containers as tracing is global
> to the entire machine. It can work with privileged containers though.

At least the tracefs interface is easily supportable within a delegation
model. IOW, you have a privileged process that delegates relevant
portions to a container via idmapped mounts _without_ doing the insane thing
and making it mountable by a container aka the fs-to-CVE pipeline.

> 
> The reason for this is because tracefs was based off of debugfs where the
> files and directores are created at boot up and mounted later. The reason
> to do this was to allow users to mount with gid=GID to allow a given group
> to have access to tracing. Without this update, tracefs would ignore it
> like debugfs and proc does today.
> 
> I think its time I explain the purpose of tracefs and how it came to be.
> 
> The tracing system required a way to control tracing and read the traces.
> It could have just used a new system like perf (although
> /sys/kernel/debug/tracing predates perf), where it created a single ioctl()
> like system call do do everything.
> 
> As the ftrace tracing came from PREEMPT_RT latency tracer and my own logdev
> tracer, which both have an embedded background, I chose an interface that
> could work with just an unmodified version of busybox. That is, I wanted it
> to work with just cat and echo.
> 
> The main difference with tracefs compared to other file systems is that it
> is a control interface, where writes happen as much as reads. The data read
> is controlled. The closest thing I can think of is how cgroups work.
> 
> As tracing is a privileged operation, but something that could be changed
> to allow a group to have access to, I wanted to make it easy for an admin
> to decide who gets to do what at boot up via the /etc/fstab file.

Yeah, ok. I think you could achieve the same thing via idmapped mounts. You
just need to swap out the mnt on /sys/kernel/tracing with an idmapped mount.

mount(8) should just give you the ability to specify "map the ids I explicitly
want to remap to something else and for the rest use the identity mapping". I
wanted that for other reasons anyway.

So in one of the next versions of mount(8) you can then do (where --beneath
means place the mount beneath the current one and --replace is
self-explanatory):

sudo mount --beneath -o X-mount.idmap='g:0:1234:1 u:0:0:1' /sys/kernel/tracing
sudo umount /sys/kernel/tracing

or as a shortcut provided by mount(8):

sudo mount --replace -o X-mount.idmap='g:0:1234:1 u:0:0:1' /sys/kernel/tracing 

In both cases you replace the mount without unmounting tracefs.

I can illustrate this right now though:

user1@localhost:~$ sudo mount --bind -o X-mount.idmap='g:0:1000:1 u:0:1000:1' /sys/kernel/tracing/ /mnt/

# This is a tool I wrote for testing the patchset I wrote back then.
user1@localhost:~/data/move-mount-beneath$ sudo ./move-mount --beneath --detached /mnt /sys/kernel/tracing
Mounting beneath top mount
Creating anonymous mount
Attaching mount /mnt -> /sys/kernel/tracing
Creating single detached mount

user1@localhost:~/data/move-mount-beneath$

# Now there's two mounts stacked on top of each other.
user1@localhost:~/data/move-mount-beneath$ findmnt | grep tracing
| `-/sys/kernel/tracing        tracefs        tracefs     rw,nosuid,nodev,noexec,relatime,idmapped
|   `-/sys/kernel/tracing      tracefs        tracefs     rw,nosuid,nodev,noexec,relatime

user1@localhost:~/data/move-mount-beneath$ sudo ls -al /sys/kernel/tracing/| head
total 0
drwx------  6 root root 0 Jan  7 13:33 .
drwxr-xr-x 16 root root 0 Jan  7 13:33 ..
-r--r-----  1 root root 0 Jan  7 13:33 README
-r--r-----  1 root root 0 Jan  7 13:33 available_events
-r--r-----  1 root root 0 Jan  7 13:33 available_filter_functions
-r--r-----  1 root root 0 Jan  7 13:33 available_filter_functions_addrs
-r--r-----  1 root root 0 Jan  7 13:33 available_tracers
-rw-r-----  1 root root 0 Jan  7 13:33 buffer_percent
-rw-r-----  1 root root 0 Jan  7 13:33 buffer_size_kb

# Reveal updated mount
user1@localhost:~/data/move-mount-beneath$ sudo umount /sys/kernel/tracing

user1@localhost:~/data/move-mount-beneath$ findmnt | grep tracing
| `-/sys/kernel/tracing        tracefs        tracefs     rw,nosuid,nodev,noexec,relatime,idmapped

user1@localhost:~/data/move-mount-beneath$ sudo ls -al /sys/kernel/tracing/| head
total 0
drwx------  6 user1 user1 0 Jan  7 13:33 .
drwxr-xr-x 16 root  root  0 Jan  7 13:33 ..
-r--r-----  1 user1 user1 0 Jan  7 13:33 README
-r--r-----  1 user1 user1 0 Jan  7 13:33 available_events
-r--r-----  1 user1 user1 0 Jan  7 13:33 available_filter_functions
-r--r-----  1 user1 user1 0 Jan  7 13:33 available_filter_functions_addrs
-r--r-----  1 user1 user1 0 Jan  7 13:33 available_tracers
-rw-r-----  1 user1 user1 0 Jan  7 13:33 buffer_percent
-rw-r-----  1 user1 user1 0 Jan  7 13:33 buffer_size_kb

sudo umount -l /sys/kernel/tracing

and reveal the new mount with updated permissions and at no point in time will
you have had to unmount tracefs itself. No chown needed, no remount needed that
has to touch all inodes.

I did perf numbers for this when I implemented this and there's no meaningful
perf impact for anything below 5 mappings. which covers 80% of the use-cases.

I mean, there are crazy people out there that do have 30 mappings, maybe. And
maybe there's 3 users that go into the hundreds (340 is maximum so struct idmap
still fits into cacheline) because of some LDAP crap or something.

See an ext4 filesystem to open/create 1,000,000 files. Then I looped through
all of the files calling fstat() on each of them 1000 times and calculated the
mean fstat() time for a single file.

|   # MAPPINGS | PATCH-NEW |
|--------------|-----------|
|   0 mappings |   158 ns  |
|   1 mappings |   157 ns  |
|   2 mappings |   158 ns  |
|   3 mappings |   161 ns  |
|   5 mappings |   165 ns  |
|  10 mappings |   199 ns  |
|  50 mappings |   218 ns  |
| 100 mappings |   229 ns  |
| 200 mappings |   239 ns  |
| 300 mappings |   240 ns  |
| 340 mappings |   248 ns  |

> 
> > 
> > Aside from optimizing this and the special semantics for this eventfs
> > stuff that you really should think twice of doing, here's one idea for
> > an extension that might alleviate some of the pain:
> > 
> > If you need flexible dynamic ownership change to e.g., be able to
> > delegate (all, a directory, a single file of) tracefs to
> > unprivileged/containers/whatever then you might want to consider
> > supporting idmapped mounts for tracefs. Because then you can do stuff
> > like:
> 
> I'm a novice here and have no idea on how id maps work ;-)

It's no magic and you don't even need to care about it. If you're on
util-linux 2.39 and any kernel post 5.12 the -o X-mount.idmap option
does all the details for you.

Though I still want an api where you can just pass the idmappings directly to
mount_setattr(). That's another topic though.

> have. Now, can we do that and still keep the dynamic creation of inodes and
> dentries?

Yes.

> Does this require having more than one dentry per inode?

No. It's just a topological change. The same subtree exposed at different
locations with the ability of exposing it with different permissions (without
any persistent filesystem-level changes).

So, I tried to do an exploratory patch even though I promised myself not
to do it. But hey...

Some notes:

* Permission handling for idmapped mounts is done completely in the
  VFS. That's the case for all filesytems that don't have a custom
  ->permission() handler. So there's nothing to do for us here.

* Idmapped mount handling for ->getattr() is done completely by the VFS
  if the filesystem doesn't have a custom ->getattr() handler. So we're
  done here.

* Tracefs doesn't support attribute changes via ->setattr() (chown(),
  chmod etc.). So there's nothing to here.

* Eventfs does support attribute changes via ->setattr(). But it relies
  on simple_setattr() which is already idmapped mount aware. So there's
  nothing for us to do.

* Ownership is inherited from the parent inode (tracefs) or optionally
  from stashed ownership information (eventfs). That means the idmapping
  is irrelevant here. It's similar to the "inherit gid from parent
  directory" logic we have in some circumstances. TL;DR nothing to do
  here as well.

* Tracefs supports the creation of instances from userspace via mkdir.
  For example,

	mkdir /sys/kernel/tracing/instances/foo

  And here the idmapping is relevant so we need to make the helpers
  aware of the idmapping.

  I just went and plumbed this through to most helpers.

There's some subtlety in eventfs. Afaict, the directories and files for
the individual events are created on-demand during lookup or readdir.

The ownership of these events is again inherited from the parent inode
or recovered from stored state. In both cases the actual idmapping is
irrelevant.

The callchain here is:

eventfs_root_lookup("xfs", "events")
-> create_{dir,file}_dentry("xfs", "events")
   -> create_{dir,file}("xfs", "events")
      -> eventfs_start_creating("xfs", "events")
         -> lookup_one_len("xfs", "events")

And the subtlety is that lookup_one_len() does permission checking on
the parent inode (IOW, if you want a dentry for "blech" under "events"
it'll do a permission check on events->d_inode) for exec permissions
and then goes on to give you a new dentry.

Usually this call would have to be changed to lookup_one() and the
idmapping be handed down to it. But I think that's irrelevant here.

Lookup generally doesn't need to be aware of idmappings at all. The
permission checking is done purely in the vfs via may_lookup() and the
idmapping is irrelevant because we always initialize inodes with the
filesystem level ownership (see the idmappings.rst) documentation if
you're interested in excessive details (otherwise you get inode aliases
which you really don't want).

For tracefs it would not matter for lookup per se but only because
tracefs seemingly creates inodes/dentries during lookup (and readdir()).

But imho the permission checking done in current eventfs_root_lookup()
via lookup_one_len() is meaningless in any way; possibly even
(conceptually) wrong.

Because, the actual permission checking for the creation of the eventfs
entries isn't really done during lookup or readdir, it's done when mkdir
is called:

        mkdir /sys/kernel/tracing/instances/foo

Here, all possible entries beneath foo including "events" and further
below are recorded and stored. So once mkdir returns it basically means
that it succeeded with the creation of all the necessary directories and
files. For all purposes the foo/events/ directory and below have all the
entries that matter. They have been created. It's comparable to them not
being in the {d,i}cache, I guess.

When one goes and looksup stuff under foo/events/ or readdir the entries
in that directory:

fd = open("foo/events")
readdir(fd, ...)

then they are licensed to list an entry in that directory. So all that
needs to be done is to actually list those files in that directory. And
since they already exist (they were created during mkdir) we just need
to splice in inodes and dentries for them. But for that we shouldn't
check permissions on the directory again. Because we've done that
already correctly when the VFS called may_lookup().

IOW, the inode_permission() in lookup_one_len() that eventfs does is
redundant and just wrong.

Luckily, I don't think we need to even change anything because all
directories that eventfs creates always grant exec permissions to the
other group so lookup_one_len() will trivially succeed. IIUC.

Drafted-by-with-no-guarantees-whatsoever-that-this-wont-burn-the-house-down: Christian Brauner <brauner@kernel.org>
---
 fs/tracefs/event_inode.c             |   8 +-
 fs/tracefs/inode.c                   |  38 +++--
 fs/tracefs/internal.h                |   3 +-
 include/linux/tracefs.h              |  20 +--
 kernel/trace/ftrace.c                |  43 +++---
 kernel/trace/trace.c                 | 201 ++++++++++++++-------------
 kernel/trace/trace.h                 |  22 +--
 kernel/trace/trace_dynevent.c        |   2 +-
 kernel/trace/trace_events.c          |  27 ++--
 kernel/trace/trace_events_synth.c    |   5 +-
 kernel/trace/trace_functions.c       |   6 +-
 kernel/trace/trace_functions_graph.c |   4 +-
 kernel/trace/trace_hwlat.c           |   8 +-
 kernel/trace/trace_kprobe.c          |   4 +-
 kernel/trace/trace_osnoise.c         |  48 ++++---
 kernel/trace/trace_printk.c          |   4 +-
 kernel/trace/trace_stack.c           |  11 +-
 kernel/trace/trace_stat.c            |   6 +-
 kernel/trace/trace_uprobe.c          |   4 +-
 19 files changed, 251 insertions(+), 213 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 2ccc849a5bda..e2f352bd8779 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -852,11 +852,11 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
  *
  * See eventfs_create_dir() for use of @entries.
  */
-struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry *parent,
-						const struct eventfs_entry *entries,
-						int size, void *data)
+struct eventfs_inode *eventfs_create_events_dir(
+	struct mnt_idmap *idmap, const char *name, struct dentry *parent,
+	const struct eventfs_entry *entries, int size, void *data)
 {
-	struct dentry *dentry = tracefs_start_creating(name, parent);
+	struct dentry *dentry = tracefs_start_creating(idmap, name, parent);
 	struct eventfs_inode *ei;
 	struct tracefs_inode *ti;
 	struct inode *inode;
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index ae648deed019..f4f4904eb3a0 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -68,7 +68,7 @@ static const struct file_operations tracefs_file_operations = {
 };
 
 static struct tracefs_dir_ops {
-	int (*mkdir)(const char *name);
+	int (*mkdir)(struct mnt_idmap *idmap, const char *name);
 	int (*rmdir)(const char *name);
 } tracefs_ops __ro_after_init;
 
@@ -104,7 +104,7 @@ static int tracefs_syscall_mkdir(struct mnt_idmap *idmap,
 	 * mkdir routine to handle races.
 	 */
 	inode_unlock(inode);
-	ret = tracefs_ops.mkdir(name);
+	ret = tracefs_ops.mkdir(idmap, name);
 	inode_lock(inode);
 
 	kfree(name);
@@ -439,10 +439,12 @@ static struct file_system_type trace_fs_type = {
 	.name =		"tracefs",
 	.mount =	trace_mount,
 	.kill_sb =	kill_litter_super,
+	.fs_flags =	FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("tracefs");
 
-struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
+struct dentry *tracefs_start_creating(struct mnt_idmap *idmap, const char *name,
+				      struct dentry *parent)
 {
 	struct dentry *dentry;
 	int error;
@@ -466,7 +468,7 @@ struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
 	if (unlikely(IS_DEADDIR(d_inode(parent))))
 		dentry = ERR_PTR(-ENOENT);
 	else
-		dentry = lookup_one_len(name, parent, strlen(name));
+		dentry = lookup_one(idmap, name, parent, strlen(name));
 	if (!IS_ERR(dentry) && d_inode(dentry)) {
 		dput(dentry);
 		dentry = ERR_PTR(-EEXIST);
@@ -589,8 +591,9 @@ struct dentry *eventfs_end_creating(struct dentry *dentry)
  * If tracefs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
  */
-struct dentry *tracefs_create_file(const char *name, umode_t mode,
-				   struct dentry *parent, void *data,
+struct dentry *tracefs_create_file(struct mnt_idmap *idmap, const char *name,
+				   umode_t mode, struct dentry *parent,
+				   void *data,
 				   const struct file_operations *fops)
 {
 	struct dentry *dentry;
@@ -602,7 +605,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	if (!(mode & S_IFMT))
 		mode |= S_IFREG;
 	BUG_ON(!S_ISREG(mode));
-	dentry = tracefs_start_creating(name, parent);
+	dentry = tracefs_start_creating(idmap, name, parent);
 
 	if (IS_ERR(dentry))
 		return NULL;
@@ -621,10 +624,11 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	return tracefs_end_creating(dentry);
 }
 
-static struct dentry *__create_dir(const char *name, struct dentry *parent,
+static struct dentry *__create_dir(struct mnt_idmap *idmap, const char *name,
+				   struct dentry *parent,
 				   const struct inode_operations *ops)
 {
-	struct dentry *dentry = tracefs_start_creating(name, parent);
+	struct dentry *dentry = tracefs_start_creating(idmap, name, parent);
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
@@ -649,6 +653,10 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
 	return tracefs_end_creating(dentry);
 }
 
+const struct inode_operations tracefs_default_dir_inode_operations = {
+	.lookup		= simple_lookup,
+};
+
 /**
  * tracefs_create_dir - create a directory in the tracefs filesystem
  * @name: a pointer to a string containing the name of the directory to
@@ -666,12 +674,14 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
  * If tracing is not enabled in the kernel, the value -%ENODEV will be
  * returned.
  */
-struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
+struct dentry *tracefs_create_dir(struct mnt_idmap *idmap, const char *name,
+				  struct dentry *parent)
 {
 	if (security_locked_down(LOCKDOWN_TRACEFS))
 		return NULL;
 
-	return __create_dir(name, parent, &simple_dir_inode_operations);
+	return __create_dir(idmap, name, parent,
+			    &tracefs_default_dir_inode_operations);
 }
 
 /**
@@ -693,7 +703,8 @@ struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
  */
 __init struct dentry *tracefs_create_instance_dir(const char *name,
 					  struct dentry *parent,
-					  int (*mkdir)(const char *name),
+					  int (*mkdir)(struct mnt_idmap *idmap,
+						       const char *name),
 					  int (*rmdir)(const char *name))
 {
 	struct dentry *dentry;
@@ -702,7 +713,8 @@ __init struct dentry *tracefs_create_instance_dir(const char *name,
 	if (WARN_ON(tracefs_ops.mkdir || tracefs_ops.rmdir))
 		return NULL;
 
-	dentry = __create_dir(name, parent, &tracefs_dir_inode_operations);
+	dentry = __create_dir(&nop_mnt_idmap, name, parent,
+			      &tracefs_dir_inode_operations);
 	if (!dentry)
 		return NULL;
 
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index ccee18ca66c7..64abc5fcc62f 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -70,8 +70,9 @@ static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
 	return container_of(inode, struct tracefs_inode, vfs_inode);
 }
 
-struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);
 struct dentry *tracefs_end_creating(struct dentry *dentry);
+struct dentry *tracefs_start_creating(struct mnt_idmap *idmap, const char *name,
+				      struct dentry *parent);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
 struct dentry *eventfs_start_creating(const char *name, struct dentry *parent);
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 7a5fe17b6bf9..0457afbafc94 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -76,9 +76,9 @@ struct eventfs_entry {
 
 struct eventfs_inode;
 
-struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry *parent,
-						const struct eventfs_entry *entries,
-						int size, void *data);
+struct eventfs_inode *eventfs_create_events_dir(
+	struct mnt_idmap *idmap, const char *name, struct dentry *parent,
+	const struct eventfs_entry *entries, int size, void *data);
 
 struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode *parent,
 					 const struct eventfs_entry *entries,
@@ -87,16 +87,20 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 void eventfs_remove_events_dir(struct eventfs_inode *ei);
 void eventfs_remove_dir(struct eventfs_inode *ei);
 
-struct dentry *tracefs_create_file(const char *name, umode_t mode,
-				   struct dentry *parent, void *data,
+struct dentry *tracefs_create_file(struct mnt_idmap *idmap, const char *name,
+				   umode_t mode, struct dentry *parent,
+				   void *data,
 				   const struct file_operations *fops);
 
-struct dentry *tracefs_create_dir(const char *name, struct dentry *parent);
+struct dentry *tracefs_create_dir(struct mnt_idmap *idmap, const char *name,
+				  struct dentry *parent);
 
 void tracefs_remove(struct dentry *dentry);
 
-struct dentry *tracefs_create_instance_dir(const char *name, struct dentry *parent,
-					   int (*mkdir)(const char *name),
+struct dentry *tracefs_create_instance_dir(const char *name,
+					   struct dentry *parent,
+					   int (*mkdir)(struct mnt_idmap *idmap,
+							const char *name),
 					   int (*rmdir)(const char *name));
 
 bool tracefs_initialized(void);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8de8bec5f366..6bf9dc7c5c29 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1015,7 +1015,7 @@ static __init void ftrace_profile_tracefs(struct dentry *d_tracer)
 		}
 	}
 
-	trace_create_file("function_profile_enabled",
+	trace_create_file(&nop_mnt_idmap, "function_profile_enabled",
 			  TRACE_MODE_WRITE, d_tracer, NULL,
 			  &ftrace_profile_fops);
 }
@@ -6380,14 +6380,14 @@ static const struct file_operations ftrace_graph_notrace_fops = {
 };
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
-void ftrace_create_filter_files(struct ftrace_ops *ops,
+void ftrace_create_filter_files(struct mnt_idmap *idmap, struct ftrace_ops *ops,
 				struct dentry *parent)
 {
 
-	trace_create_file("set_ftrace_filter", TRACE_MODE_WRITE, parent,
+	trace_create_file(idmap, "set_ftrace_filter", TRACE_MODE_WRITE, parent,
 			  ops, &ftrace_filter_fops);
 
-	trace_create_file("set_ftrace_notrace", TRACE_MODE_WRITE, parent,
+	trace_create_file(idmap, "set_ftrace_notrace", TRACE_MODE_WRITE, parent,
 			  ops, &ftrace_notrace_fops);
 }
 
@@ -6413,28 +6413,26 @@ void ftrace_destroy_filter_files(struct ftrace_ops *ops)
 
 static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
 {
+	trace_create_file(&nop_mnt_idmap, "available_filter_functions",
+			  TRACE_MODE_READ, d_tracer, NULL, &ftrace_avail_fops);
 
-	trace_create_file("available_filter_functions", TRACE_MODE_READ,
-			d_tracer, NULL, &ftrace_avail_fops);
+	trace_create_file(&nop_mnt_idmap, "available_filter_functions_addrs",
+			  TRACE_MODE_READ, d_tracer, NULL,
+			  &ftrace_avail_addrs_fops);
 
-	trace_create_file("available_filter_functions_addrs", TRACE_MODE_READ,
-			d_tracer, NULL, &ftrace_avail_addrs_fops);
-
-	trace_create_file("enabled_functions", TRACE_MODE_READ,
+	trace_create_file(&nop_mnt_idmap, "enabled_functions", TRACE_MODE_READ,
 			d_tracer, NULL, &ftrace_enabled_fops);
 
-	trace_create_file("touched_functions", TRACE_MODE_READ,
-			d_tracer, NULL, &ftrace_touched_fops);
+	trace_create_file(&nop_mnt_idmap, "touched_functions", TRACE_MODE_READ,
+			  d_tracer, NULL, &ftrace_touched_fops);
 
-	ftrace_create_filter_files(&global_ops, d_tracer);
+	ftrace_create_filter_files(&nop_mnt_idmap, &global_ops, d_tracer);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	trace_create_file("set_graph_function", TRACE_MODE_WRITE, d_tracer,
-				    NULL,
-				    &ftrace_graph_fops);
-	trace_create_file("set_graph_notrace", TRACE_MODE_WRITE, d_tracer,
-				    NULL,
-				    &ftrace_graph_notrace_fops);
+	trace_create_file(&nop_mnt_idmap, "set_graph_function",
+			  TRACE_MODE_WRITE, d_tracer, NULL, &ftrace_graph_fops);
+	trace_create_file(&nop_mnt_idmap, "set_graph_notrace", TRACE_MODE_WRITE,
+			  d_tracer, NULL, &ftrace_graph_notrace_fops);
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
 	return 0;
@@ -7858,11 +7856,12 @@ static const struct file_operations ftrace_no_pid_fops = {
 	.release	= ftrace_pid_release,
 };
 
-void ftrace_init_tracefs(struct trace_array *tr, struct dentry *d_tracer)
+void ftrace_init_tracefs(struct mnt_idmap *idmap, struct trace_array *tr,
+			 struct dentry *d_tracer)
 {
-	trace_create_file("set_ftrace_pid", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file(idmap, "set_ftrace_pid", TRACE_MODE_WRITE, d_tracer,
 			    tr, &ftrace_pid_fops);
-	trace_create_file("set_ftrace_notrace_pid", TRACE_MODE_WRITE,
+	trace_create_file(idmap, "set_ftrace_notrace_pid", TRACE_MODE_WRITE,
 			  d_tracer, tr, &ftrace_no_pid_fops);
 }
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 199df497db07..c0bd4b0dfe85 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1766,12 +1766,13 @@ static void latency_fsnotify_workfn_irq(struct irq_work *iwork)
 	queue_work(fsnotify_wq, &tr->fsnotify_work);
 }
 
-static void trace_create_maxlat_file(struct trace_array *tr,
+static void trace_create_maxlat_file(struct mnt_idmap *idmap,
+				     struct trace_array *tr,
 				     struct dentry *d_tracer)
 {
 	INIT_WORK(&tr->fsnotify_work, latency_fsnotify_workfn);
 	init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
-	tr->d_max_latency = trace_create_file("tracing_max_latency",
+	tr->d_max_latency = trace_create_file(idmap, "tracing_max_latency",
 					      TRACE_MODE_WRITE,
 					      d_tracer, tr,
 					      &tracing_max_lat_fops);
@@ -1804,8 +1805,8 @@ void latency_fsnotify(struct trace_array *tr)
 
 #else /* !LATENCY_FS_NOTIFY */
 
-#define trace_create_maxlat_file(tr, d_tracer)				\
-	trace_create_file("tracing_max_latency", TRACE_MODE_WRITE,	\
+#define trace_create_maxlat_file(idmap, tr, d_tracer)				\
+	trace_create_file(idmap, "tracing_max_latency", TRACE_MODE_WRITE,	\
 			  d_tracer, tr, &tracing_max_lat_fops)
 
 #endif
@@ -2124,7 +2125,8 @@ static inline int do_run_tracer_selftest(struct tracer *type)
 }
 #endif /* CONFIG_FTRACE_STARTUP_TEST */
 
-static void add_tracer_options(struct trace_array *tr, struct tracer *t);
+static void add_tracer_options(struct mnt_idmap *idmap, struct trace_array *tr,
+			       struct tracer *t);
 
 static void __init apply_trace_boot_options(void);
 
@@ -2191,7 +2193,7 @@ int __init register_tracer(struct tracer *type)
 
 	type->next = trace_types;
 	trace_types = type;
-	add_tracer_options(&global_trace, type);
+	add_tracer_options(&nop_mnt_idmap, &global_trace, type);
 
  out:
 	mutex_unlock(&trace_types_lock);
@@ -6245,14 +6247,14 @@ trace_insert_eval_map_file(struct module *mod, struct trace_eval_map **start,
 	mutex_unlock(&trace_eval_mutex);
 }
 
-static void trace_create_eval_file(struct dentry *d_tracer)
+static void trace_create_eval_file(struct mnt_idmap *idmap, struct dentry *d_tracer)
 {
-	trace_create_file("eval_map", TRACE_MODE_READ, d_tracer,
+	trace_create_file(idmap, "eval_map", TRACE_MODE_READ, d_tracer,
 			  NULL, &tracing_eval_map_fops);
 }
 
 #else /* CONFIG_TRACE_EVAL_MAP_FILE */
-static inline void trace_create_eval_file(struct dentry *d_tracer) { }
+static inline void trace_create_eval_file(struct mnt_idmap *idmap, struct dentry *d_tracer) { }
 static inline void trace_insert_eval_map_file(struct module *mod,
 			      struct trace_eval_map **start, int len) { }
 #endif /* !CONFIG_TRACE_EVAL_MAP_FILE */
@@ -6454,7 +6456,7 @@ int tracing_update_buffers(struct trace_array *tr)
 struct trace_option_dentry;
 
 static void
-create_trace_option_files(struct trace_array *tr, struct tracer *tracer);
+create_trace_option_files(struct mnt_idmap *idmap, struct trace_array *tr, struct tracer *tracer);
 
 /*
  * Used to clear out the tracer before deletion of an instance.
@@ -6475,7 +6477,8 @@ static void tracing_set_nop(struct trace_array *tr)
 
 static bool tracer_options_updated;
 
-static void add_tracer_options(struct trace_array *tr, struct tracer *t)
+static void add_tracer_options(struct mnt_idmap *idmap, struct trace_array *tr,
+			       struct tracer *t)
 {
 	/* Only enable if the directory has been created already. */
 	if (!tr->dir)
@@ -6485,7 +6488,7 @@ static void add_tracer_options(struct trace_array *tr, struct tracer *t)
 	if (!tracer_options_updated)
 		return;
 
-	create_trace_option_files(tr, t);
+	create_trace_option_files(idmap, tr, t);
 }
 
 int tracing_set_tracer(struct trace_array *tr, const char *buf)
@@ -8845,7 +8848,8 @@ static struct dentry *tracing_get_dentry(struct trace_array *tr)
 	return tr->dir;
 }
 
-static struct dentry *tracing_dentry_percpu(struct trace_array *tr, int cpu)
+static struct dentry *tracing_dentry_percpu(struct mnt_idmap *idmap,
+					    struct trace_array *tr, int cpu)
 {
 	struct dentry *d_tracer;
 
@@ -8856,7 +8860,7 @@ static struct dentry *tracing_dentry_percpu(struct trace_array *tr, int cpu)
 	if (IS_ERR(d_tracer))
 		return NULL;
 
-	tr->percpu_dir = tracefs_create_dir("per_cpu", d_tracer);
+	tr->percpu_dir = tracefs_create_dir(idmap, "per_cpu", d_tracer);
 
 	MEM_FAIL(!tr->percpu_dir,
 		  "Could not create tracefs directory 'per_cpu/%d'\n", cpu);
@@ -8864,11 +8868,13 @@ static struct dentry *tracing_dentry_percpu(struct trace_array *tr, int cpu)
 	return tr->percpu_dir;
 }
 
-static struct dentry *
-trace_create_cpu_file(const char *name, umode_t mode, struct dentry *parent,
-		      void *data, long cpu, const struct file_operations *fops)
+static struct dentry *trace_create_cpu_file(struct mnt_idmap *idmap,
+					    const char *name, umode_t mode,
+					    struct dentry *parent, void *data,
+					    long cpu,
+					    const struct file_operations *fops)
 {
-	struct dentry *ret = trace_create_file(name, mode, parent, data, fops);
+	struct dentry *ret = trace_create_file(idmap, name, mode, parent, data, fops);
 
 	if (ret) /* See tracing_get_cpu() */
 		d_inode(ret)->i_cdev = (void *)(cpu + 1);
@@ -8876,9 +8882,9 @@ trace_create_cpu_file(const char *name, umode_t mode, struct dentry *parent,
 }
 
 static void
-tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
+tracing_init_tracefs_percpu(struct mnt_idmap *idmap, struct trace_array *tr, long cpu)
 {
-	struct dentry *d_percpu = tracing_dentry_percpu(tr, cpu);
+	struct dentry *d_percpu = tracing_dentry_percpu(idmap, tr, cpu);
 	struct dentry *d_cpu;
 	char cpu_dir[30]; /* 30 characters should be more than enough */
 
@@ -8886,34 +8892,34 @@ tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
 		return;
 
 	snprintf(cpu_dir, 30, "cpu%ld", cpu);
-	d_cpu = tracefs_create_dir(cpu_dir, d_percpu);
+	d_cpu = tracefs_create_dir(idmap, cpu_dir, d_percpu);
 	if (!d_cpu) {
 		pr_warn("Could not create tracefs '%s' entry\n", cpu_dir);
 		return;
 	}
 
 	/* per cpu trace_pipe */
-	trace_create_cpu_file("trace_pipe", TRACE_MODE_READ, d_cpu,
+	trace_create_cpu_file(idmap, "trace_pipe", TRACE_MODE_READ, d_cpu,
 				tr, cpu, &tracing_pipe_fops);
 
 	/* per cpu trace */
-	trace_create_cpu_file("trace", TRACE_MODE_WRITE, d_cpu,
+	trace_create_cpu_file(idmap, "trace", TRACE_MODE_WRITE, d_cpu,
 				tr, cpu, &tracing_fops);
 
-	trace_create_cpu_file("trace_pipe_raw", TRACE_MODE_READ, d_cpu,
+	trace_create_cpu_file(idmap, "trace_pipe_raw", TRACE_MODE_READ, d_cpu,
 				tr, cpu, &tracing_buffers_fops);
 
-	trace_create_cpu_file("stats", TRACE_MODE_READ, d_cpu,
+	trace_create_cpu_file(idmap, "stats", TRACE_MODE_READ, d_cpu,
 				tr, cpu, &tracing_stats_fops);
 
-	trace_create_cpu_file("buffer_size_kb", TRACE_MODE_READ, d_cpu,
+	trace_create_cpu_file(idmap, "buffer_size_kb", TRACE_MODE_READ, d_cpu,
 				tr, cpu, &tracing_entries_fops);
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-	trace_create_cpu_file("snapshot", TRACE_MODE_WRITE, d_cpu,
+	trace_create_cpu_file(idmap, "snapshot", TRACE_MODE_WRITE, d_cpu,
 				tr, cpu, &snapshot_fops);
 
-	trace_create_cpu_file("snapshot_raw", TRACE_MODE_READ, d_cpu,
+	trace_create_cpu_file(idmap, "snapshot_raw", TRACE_MODE_READ, d_cpu,
 				tr, cpu, &snapshot_raw_fops);
 #endif
 }
@@ -9088,23 +9094,21 @@ static const struct file_operations trace_options_core_fops = {
 	.llseek = generic_file_llseek,
 };
 
-struct dentry *trace_create_file(const char *name,
-				 umode_t mode,
-				 struct dentry *parent,
-				 void *data,
-				 const struct file_operations *fops)
+struct dentry *trace_create_file(struct mnt_idmap *idmap, const char *name,
+				 umode_t mode, struct dentry *parent,
+				 void *data, const struct file_operations *fops)
 {
 	struct dentry *ret;
 
-	ret = tracefs_create_file(name, mode, parent, data, fops);
+	ret = tracefs_create_file(idmap, name, mode, parent, data, fops);
 	if (!ret)
 		pr_warn("Could not create tracefs '%s' entry\n", name);
 
 	return ret;
 }
 
-
-static struct dentry *trace_options_init_dentry(struct trace_array *tr)
+static struct dentry *trace_options_init_dentry(struct mnt_idmap *idmap,
+						struct trace_array *tr)
 {
 	struct dentry *d_tracer;
 
@@ -9115,7 +9119,7 @@ static struct dentry *trace_options_init_dentry(struct trace_array *tr)
 	if (IS_ERR(d_tracer))
 		return NULL;
 
-	tr->options = tracefs_create_dir("options", d_tracer);
+	tr->options = tracefs_create_dir(idmap, "options", d_tracer);
 	if (!tr->options) {
 		pr_warn("Could not create tracefs directory 'options'\n");
 		return NULL;
@@ -9125,14 +9129,14 @@ static struct dentry *trace_options_init_dentry(struct trace_array *tr)
 }
 
 static void
-create_trace_option_file(struct trace_array *tr,
+create_trace_option_file(struct mnt_idmap *idmap, struct trace_array *tr,
 			 struct trace_option_dentry *topt,
 			 struct tracer_flags *flags,
 			 struct tracer_opt *opt)
 {
 	struct dentry *t_options;
 
-	t_options = trace_options_init_dentry(tr);
+	t_options = trace_options_init_dentry(idmap, tr);
 	if (!t_options)
 		return;
 
@@ -9140,13 +9144,14 @@ create_trace_option_file(struct trace_array *tr,
 	topt->opt = opt;
 	topt->tr = tr;
 
-	topt->entry = trace_create_file(opt->name, TRACE_MODE_WRITE,
+	topt->entry = trace_create_file(idmap, opt->name, TRACE_MODE_WRITE,
 					t_options, topt, &trace_options_fops);
 
 }
 
-static void
-create_trace_option_files(struct trace_array *tr, struct tracer *tracer)
+static void create_trace_option_files(struct mnt_idmap *idmap,
+				      struct trace_array *tr,
+				      struct tracer *tracer)
 {
 	struct trace_option_dentry *topts;
 	struct trace_options *tr_topts;
@@ -9198,7 +9203,7 @@ create_trace_option_files(struct trace_array *tr, struct tracer *tracer)
 	tr->nr_topts++;
 
 	for (cnt = 0; opts[cnt].name; cnt++) {
-		create_trace_option_file(tr, &topts[cnt], flags,
+		create_trace_option_file(idmap, tr, &topts[cnt], flags,
 					 &opts[cnt]);
 		MEM_FAIL(topts[cnt].entry == NULL,
 			  "Failed to create trace option: %s",
@@ -9207,34 +9212,34 @@ create_trace_option_files(struct trace_array *tr, struct tracer *tracer)
 }
 
 static struct dentry *
-create_trace_option_core_file(struct trace_array *tr,
+create_trace_option_core_file(struct mnt_idmap *idmap, struct trace_array *tr,
 			      const char *option, long index)
 {
 	struct dentry *t_options;
 
-	t_options = trace_options_init_dentry(tr);
+	t_options = trace_options_init_dentry(idmap, tr);
 	if (!t_options)
 		return NULL;
 
-	return trace_create_file(option, TRACE_MODE_WRITE, t_options,
+	return trace_create_file(idmap, option, TRACE_MODE_WRITE, t_options,
 				 (void *)&tr->trace_flags_index[index],
 				 &trace_options_core_fops);
 }
 
-static void create_trace_options_dir(struct trace_array *tr)
+static void create_trace_options_dir(struct mnt_idmap *idmap, struct trace_array *tr)
 {
 	struct dentry *t_options;
 	bool top_level = tr == &global_trace;
 	int i;
 
-	t_options = trace_options_init_dentry(tr);
+	t_options = trace_options_init_dentry(idmap, tr);
 	if (!t_options)
 		return;
 
 	for (i = 0; trace_options[i]; i++) {
 		if (top_level ||
 		    !((1 << i) & TOP_LEVEL_TRACE_FLAGS))
-			create_trace_option_core_file(tr, trace_options[i], i);
+			create_trace_option_core_file(idmap, tr, trace_options[i], i);
 	}
 }
 
@@ -9342,8 +9347,8 @@ static const struct file_operations buffer_percent_fops = {
 
 static struct dentry *trace_instance_dir;
 
-static void
-init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
+static void init_tracer_tracefs(struct mnt_idmap *idmap, struct trace_array *tr,
+				struct dentry *d_tracer);
 
 static int
 allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size)
@@ -9426,19 +9431,20 @@ static void init_trace_flags_index(struct trace_array *tr)
 		tr->trace_flags_index[i] = i;
 }
 
-static void __update_tracer_options(struct trace_array *tr)
+static void __update_tracer_options(struct mnt_idmap *idmap,
+				    struct trace_array *tr)
 {
 	struct tracer *t;
 
 	for (t = trace_types; t; t = t->next)
-		add_tracer_options(tr, t);
+		add_tracer_options(idmap, tr, t);
 }
 
 static void update_tracer_options(struct trace_array *tr)
 {
 	mutex_lock(&trace_types_lock);
 	tracer_options_updated = true;
-	__update_tracer_options(tr);
+	__update_tracer_options(&nop_mnt_idmap, tr);
 	mutex_unlock(&trace_types_lock);
 }
 
@@ -9470,27 +9476,28 @@ struct trace_array *trace_array_find_get(const char *instance)
 	return tr;
 }
 
-static int trace_array_create_dir(struct trace_array *tr)
+static int trace_array_create_dir(struct mnt_idmap *idmap, struct trace_array *tr)
 {
 	int ret;
 
-	tr->dir = tracefs_create_dir(tr->name, trace_instance_dir);
+	tr->dir = tracefs_create_dir(idmap, tr->name, trace_instance_dir);
 	if (!tr->dir)
 		return -EINVAL;
 
-	ret = event_trace_add_tracer(tr->dir, tr);
+	ret = event_trace_add_tracer(idmap, tr->dir, tr);
 	if (ret) {
 		tracefs_remove(tr->dir);
 		return ret;
 	}
 
-	init_tracer_tracefs(tr, tr->dir);
-	__update_tracer_options(tr);
+	init_tracer_tracefs(idmap, tr, tr->dir);
+	__update_tracer_options(idmap, tr);
 
 	return ret;
 }
 
-static struct trace_array *trace_array_create(const char *name)
+static struct trace_array *trace_array_create(struct mnt_idmap *idmap,
+					      const char *name)
 {
 	struct trace_array *tr;
 	int ret;
@@ -9539,7 +9546,7 @@ static struct trace_array *trace_array_create(const char *name)
 	init_trace_flags_index(tr);
 
 	if (trace_instance_dir) {
-		ret = trace_array_create_dir(tr);
+		ret = trace_array_create_dir(idmap, tr);
 		if (ret)
 			goto out_free_tr;
 	} else
@@ -9562,7 +9569,7 @@ static struct trace_array *trace_array_create(const char *name)
 	return ERR_PTR(ret);
 }
 
-static int instance_mkdir(const char *name)
+static int instance_mkdir(struct mnt_idmap *idmap, const char *name)
 {
 	struct trace_array *tr;
 	int ret;
@@ -9574,7 +9581,7 @@ static int instance_mkdir(const char *name)
 	if (trace_array_find(name))
 		goto out_unlock;
 
-	tr = trace_array_create(name);
+	tr = trace_array_create(idmap, name);
 
 	ret = PTR_ERR_OR_ZERO(tr);
 
@@ -9612,7 +9619,7 @@ struct trace_array *trace_array_get_by_name(const char *name)
 			goto out_unlock;
 	}
 
-	tr = trace_array_create(name);
+	tr = trace_array_create(&nop_mnt_idmap, name);
 
 	if (IS_ERR(tr))
 		tr = NULL;
@@ -9728,7 +9735,7 @@ static __init void create_trace_instances(struct dentry *d_tracer)
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		if (!tr->name)
 			continue;
-		if (MEM_FAIL(trace_array_create_dir(tr) < 0,
+		if (MEM_FAIL(trace_array_create_dir(&nop_mnt_idmap, tr) < 0,
 			     "Failed to create instance directory\n"))
 			break;
 	}
@@ -9737,81 +9744,81 @@ static __init void create_trace_instances(struct dentry *d_tracer)
 	mutex_unlock(&event_mutex);
 }
 
-static void
-init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
+static void init_tracer_tracefs(struct mnt_idmap *idmap, struct trace_array *tr,
+				struct dentry *d_tracer)
 {
 	int cpu;
 
-	trace_create_file("available_tracers", TRACE_MODE_READ, d_tracer,
+	trace_create_file(idmap, "available_tracers", TRACE_MODE_READ, d_tracer,
 			tr, &show_traces_fops);
 
-	trace_create_file("current_tracer", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file(idmap, "current_tracer", TRACE_MODE_WRITE, d_tracer,
 			tr, &set_tracer_fops);
 
-	trace_create_file("tracing_cpumask", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file(idmap, "tracing_cpumask", TRACE_MODE_WRITE, d_tracer,
 			  tr, &tracing_cpumask_fops);
 
-	trace_create_file("trace_options", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file(idmap, "trace_options", TRACE_MODE_WRITE, d_tracer,
 			  tr, &tracing_iter_fops);
 
-	trace_create_file("trace", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file(idmap, "trace", TRACE_MODE_WRITE, d_tracer,
 			  tr, &tracing_fops);
 
-	trace_create_file("trace_pipe", TRACE_MODE_READ, d_tracer,
+	trace_create_file(idmap, "trace_pipe", TRACE_MODE_READ, d_tracer,
 			  tr, &tracing_pipe_fops);
 
-	trace_create_file("buffer_size_kb", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file(idmap, "buffer_size_kb", TRACE_MODE_WRITE, d_tracer,
 			  tr, &tracing_entries_fops);
 
-	trace_create_file("buffer_total_size_kb", TRACE_MODE_READ, d_tracer,
+	trace_create_file(idmap, "buffer_total_size_kb", TRACE_MODE_READ, d_tracer,
 			  tr, &tracing_total_entries_fops);
 
-	trace_create_file("free_buffer", 0200, d_tracer,
+	trace_create_file(idmap, "free_buffer", 0200, d_tracer,
 			  tr, &tracing_free_buffer_fops);
 
-	trace_create_file("trace_marker", 0220, d_tracer,
+	trace_create_file(idmap, "trace_marker", 0220, d_tracer,
 			  tr, &tracing_mark_fops);
 
 	tr->trace_marker_file = __find_event_file(tr, "ftrace", "print");
 
-	trace_create_file("trace_marker_raw", 0220, d_tracer,
+	trace_create_file(idmap, "trace_marker_raw", 0220, d_tracer,
 			  tr, &tracing_mark_raw_fops);
 
-	trace_create_file("trace_clock", TRACE_MODE_WRITE, d_tracer, tr,
+	trace_create_file(idmap, "trace_clock", TRACE_MODE_WRITE, d_tracer, tr,
 			  &trace_clock_fops);
 
-	trace_create_file("tracing_on", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file(idmap, "tracing_on", TRACE_MODE_WRITE, d_tracer,
 			  tr, &rb_simple_fops);
 
-	trace_create_file("timestamp_mode", TRACE_MODE_READ, d_tracer, tr,
+	trace_create_file(idmap, "timestamp_mode", TRACE_MODE_READ, d_tracer, tr,
 			  &trace_time_stamp_mode_fops);
 
 	tr->buffer_percent = 50;
 
-	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file(idmap, "buffer_percent", TRACE_MODE_WRITE, d_tracer,
 			tr, &buffer_percent_fops);
 
-	create_trace_options_dir(tr);
+	create_trace_options_dir(idmap, tr);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	trace_create_maxlat_file(tr, d_tracer);
+	trace_create_maxlat_file(idmap, tr, d_tracer);
 #endif
 
-	if (ftrace_create_function_files(tr, d_tracer))
+	if (ftrace_create_function_files(idmap, tr, d_tracer))
 		MEM_FAIL(1, "Could not allocate function filter files");
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-	trace_create_file("snapshot", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file(idmap, "snapshot", TRACE_MODE_WRITE, d_tracer,
 			  tr, &snapshot_fops);
 #endif
 
-	trace_create_file("error_log", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file(idmap, "error_log", TRACE_MODE_WRITE, d_tracer,
 			  tr, &tracing_err_log_fops);
 
 	for_each_tracing_cpu(cpu)
-		tracing_init_tracefs_percpu(tr, cpu);
+		tracing_init_tracefs_percpu(idmap, tr, cpu);
 
-	ftrace_init_tracefs(tr, d_tracer);
+	ftrace_init_tracefs(idmap, tr, d_tracer);
 }
 
 static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
@@ -9991,32 +9998,32 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 
 	event_trace_init();
 
-	init_tracer_tracefs(&global_trace, NULL);
+	init_tracer_tracefs(&nop_mnt_idmap, &global_trace, NULL);
 	ftrace_init_tracefs_toplevel(&global_trace, NULL);
 
-	trace_create_file("tracing_thresh", TRACE_MODE_WRITE, NULL,
+	trace_create_file(&nop_mnt_idmap, "tracing_thresh", TRACE_MODE_WRITE, NULL,
 			&global_trace, &tracing_thresh_fops);
 
-	trace_create_file("README", TRACE_MODE_READ, NULL,
+	trace_create_file(&nop_mnt_idmap, "README", TRACE_MODE_READ, NULL,
 			NULL, &tracing_readme_fops);
 
-	trace_create_file("saved_cmdlines", TRACE_MODE_READ, NULL,
+	trace_create_file(&nop_mnt_idmap, "saved_cmdlines", TRACE_MODE_READ, NULL,
 			NULL, &tracing_saved_cmdlines_fops);
 
-	trace_create_file("saved_cmdlines_size", TRACE_MODE_WRITE, NULL,
+	trace_create_file(&nop_mnt_idmap, "saved_cmdlines_size", TRACE_MODE_WRITE, NULL,
 			  NULL, &tracing_saved_cmdlines_size_fops);
 
-	trace_create_file("saved_tgids", TRACE_MODE_READ, NULL,
+	trace_create_file(&nop_mnt_idmap, "saved_tgids", TRACE_MODE_READ, NULL,
 			NULL, &tracing_saved_tgids_fops);
 
-	trace_create_eval_file(NULL);
+	trace_create_eval_file(&nop_mnt_idmap, NULL);
 
 #ifdef CONFIG_MODULES
 	register_module_notifier(&trace_module_nb);
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-	trace_create_file("dyn_ftrace_total_info", TRACE_MODE_READ, NULL,
+	trace_create_file(&nop_mnt_idmap, "dyn_ftrace_total_info", TRACE_MODE_READ, NULL,
 			NULL, &tracing_dyn_info_fops);
 #endif
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 0489e72c8169..b8de94e4387d 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -622,9 +622,8 @@ bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
 void tracer_tracing_off(struct trace_array *tr);
-struct dentry *trace_create_file(const char *name,
-				 umode_t mode,
-				 struct dentry *parent,
+struct dentry *trace_create_file(struct mnt_idmap *idmap, const char *name,
+				 umode_t mode, struct dentry *parent,
 				 void *data,
 				 const struct file_operations *fops);
 
@@ -1025,7 +1024,7 @@ static inline int ftrace_trace_task(struct trace_array *tr)
 		FTRACE_PID_IGNORE;
 }
 extern int ftrace_is_dead(void);
-int ftrace_create_function_files(struct trace_array *tr,
+int ftrace_create_function_files(struct mnt_idmap *idmap, struct trace_array *tr,
 				 struct dentry *parent);
 void ftrace_destroy_function_files(struct trace_array *tr);
 int ftrace_allocate_ftrace_ops(struct trace_array *tr);
@@ -1033,7 +1032,8 @@ void ftrace_free_ftrace_ops(struct trace_array *tr);
 void ftrace_init_global_array_ops(struct trace_array *tr);
 void ftrace_init_array_ops(struct trace_array *tr, ftrace_func_t func);
 void ftrace_reset_array_ops(struct trace_array *tr);
-void ftrace_init_tracefs(struct trace_array *tr, struct dentry *d_tracer);
+void ftrace_init_tracefs(struct mnt_idmap *idmap, struct trace_array *tr,
+			 struct dentry *d_tracer);
 void ftrace_init_tracefs_toplevel(struct trace_array *tr,
 				  struct dentry *d_tracer);
 void ftrace_clear_pids(struct trace_array *tr);
@@ -1046,7 +1046,7 @@ static inline int ftrace_trace_task(struct trace_array *tr)
 }
 static inline int ftrace_is_dead(void) { return 0; }
 static inline int
-ftrace_create_function_files(struct trace_array *tr,
+ftrace_create_function_files(struct mnt_idmap *idmap, struct trace_array *tr,
 			     struct dentry *parent)
 {
 	return 0;
@@ -1060,7 +1060,7 @@ static inline void ftrace_destroy_function_files(struct trace_array *tr) { }
 static inline __init void
 ftrace_init_global_array_ops(struct trace_array *tr) { }
 static inline void ftrace_reset_array_ops(struct trace_array *tr) { }
-static inline void ftrace_init_tracefs(struct trace_array *tr, struct dentry *d) { }
+static inline void ftrace_init_tracefs(struct mnt_idmap *idmap, struct trace_array *tr, struct dentry *d) { }
 static inline void ftrace_init_tracefs_toplevel(struct trace_array *tr, struct dentry *d) { }
 static inline void ftrace_clear_pids(struct trace_array *tr) { }
 static inline int init_function_trace(void) { return 0; }
@@ -1114,7 +1114,7 @@ extern void clear_ftrace_function_probes(struct trace_array *tr);
 int register_ftrace_command(struct ftrace_func_command *cmd);
 int unregister_ftrace_command(struct ftrace_func_command *cmd);
 
-void ftrace_create_filter_files(struct ftrace_ops *ops,
+void ftrace_create_filter_files(struct mnt_idmap *idmap, struct ftrace_ops *ops,
 				struct dentry *parent);
 void ftrace_destroy_filter_files(struct ftrace_ops *ops);
 
@@ -1141,7 +1141,7 @@ static inline void clear_ftrace_function_probes(struct trace_array *tr)
  * The ops parameter passed in is usually undefined.
  * This must be a macro.
  */
-#define ftrace_create_filter_files(ops, parent) do { } while (0)
+#define ftrace_create_filter_files(idmap, ops, parent) do { } while (0)
 #define ftrace_destroy_filter_files(ops) do { } while (0)
 #endif /* CONFIG_FUNCTION_TRACER && CONFIG_DYNAMIC_FTRACE */
 
@@ -1541,7 +1541,9 @@ extern void trace_event_enable_tgid_record(bool enable);
 
 extern int event_trace_init(void);
 extern int init_events(void);
-extern int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr);
+extern int event_trace_add_tracer(struct mnt_idmap *idmap,
+				  struct dentry *parent,
+				  struct trace_array *tr);
 extern int event_trace_del_tracer(struct trace_array *tr);
 extern void __trace_early_add_events(struct trace_array *tr);
 
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 4376887e0d8a..c0caf4631f82 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -263,7 +263,7 @@ static __init int init_dynamic_event(void)
 	if (ret)
 		return 0;
 
-	trace_create_file("dynamic_events", TRACE_MODE_WRITE, NULL,
+	trace_create_file(&nop_mnt_idmap, "dynamic_events", TRACE_MODE_WRITE, NULL,
 			  NULL, &dynamic_events_ops);
 
 	return 0;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f29e815ca5b2..b41e0f26cee4 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3768,7 +3768,8 @@ static int events_callback(const char *name, umode_t *mode, void **data,
 
 /* Expects to have event_mutex held when called */
 static int
-create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
+create_event_toplevel_files(struct mnt_idmap *idmap, struct dentry *parent,
+			    struct trace_array *tr)
 {
 	struct eventfs_inode *e_events;
 	struct dentry *entry;
@@ -3788,15 +3789,15 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 		},
 	};
 
-	entry = trace_create_file("set_event", TRACE_MODE_WRITE, parent,
+	entry = trace_create_file(idmap, "set_event", TRACE_MODE_WRITE, parent,
 				  tr, &ftrace_set_event_fops);
 	if (!entry)
 		return -ENOMEM;
 
 	nr_entries = ARRAY_SIZE(events_entries);
 
-	e_events = eventfs_create_events_dir("events", parent, events_entries,
-					     nr_entries, tr);
+	e_events = eventfs_create_events_dir(idmap, "events", parent,
+					     events_entries, nr_entries, tr);
 	if (IS_ERR(e_events)) {
 		pr_warn("Could not create tracefs 'events' directory\n");
 		return -ENOMEM;
@@ -3804,12 +3805,11 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 
 	/* There are not as crucial, just warn if they are not created */
 
-	trace_create_file("set_event_pid", TRACE_MODE_WRITE, parent,
-			  tr, &ftrace_set_event_pid_fops);
+	trace_create_file(idmap, "set_event_pid", TRACE_MODE_WRITE, parent, tr,
+			  &ftrace_set_event_pid_fops);
 
-	trace_create_file("set_event_notrace_pid",
-			  TRACE_MODE_WRITE, parent, tr,
-			  &ftrace_set_event_notrace_pid_fops);
+	trace_create_file(idmap, "set_event_notrace_pid", TRACE_MODE_WRITE,
+			  parent, tr, &ftrace_set_event_notrace_pid_fops);
 
 	tr->event_dir = e_events;
 
@@ -3829,13 +3829,14 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
  *
  * Must be called with event_mutex held.
  */
-int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr)
+int event_trace_add_tracer(struct mnt_idmap *idmap, struct dentry *parent,
+			   struct trace_array *tr)
 {
 	int ret;
 
 	lockdep_assert_held(&event_mutex);
 
-	ret = create_event_toplevel_files(parent, tr);
+	ret = create_event_toplevel_files(idmap, parent, tr);
 	if (ret)
 		goto out;
 
@@ -3862,7 +3863,7 @@ early_event_add_tracer(struct dentry *parent, struct trace_array *tr)
 
 	mutex_lock(&event_mutex);
 
-	ret = create_event_toplevel_files(parent, tr);
+	ret = create_event_toplevel_files(&nop_mnt_idmap, parent, tr);
 	if (ret)
 		goto out_unlock;
 
@@ -4021,7 +4022,7 @@ __init int event_trace_init(void)
 	if (!tr)
 		return -ENODEV;
 
-	trace_create_file("available_events", TRACE_MODE_READ,
+	trace_create_file(&nop_mnt_idmap, "available_events", TRACE_MODE_READ,
 			  NULL, tr, &ftrace_avail_fops);
 
 	ret = early_event_add_tracer(NULL, tr);
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e7af286af4f1..f8fbb0f4ef87 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -2318,8 +2318,9 @@ static __init int trace_events_synth_init(void)
 	if (err)
 		goto err;
 
-	entry = tracefs_create_file("synthetic_events", TRACE_MODE_WRITE,
-				    NULL, NULL, &synth_events_fops);
+	entry = tracefs_create_file(&nop_mnt_idmap, "synthetic_events",
+				    TRACE_MODE_WRITE, NULL, NULL,
+				    &synth_events_fops);
 	if (!entry) {
 		err = -ENODEV;
 		goto err;
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 9f1bfbe105e8..266428151b60 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -77,8 +77,8 @@ void ftrace_free_ftrace_ops(struct trace_array *tr)
 	tr->ops = NULL;
 }
 
-int ftrace_create_function_files(struct trace_array *tr,
-				 struct dentry *parent)
+int ftrace_create_function_files(struct mnt_idmap *idmap,
+				 struct trace_array *tr, struct dentry *parent)
 {
 	/*
 	 * The top level array uses the "global_ops", and the files are
@@ -90,7 +90,7 @@ int ftrace_create_function_files(struct trace_array *tr,
 	if (!tr->ops)
 		return -EINVAL;
 
-	ftrace_create_filter_files(tr->ops, parent);
+	ftrace_create_filter_files(idmap, tr->ops, parent);
 
 	return 0;
 }
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index c35fbaab2a47..e7b4fa238eaf 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -1413,8 +1413,8 @@ static __init int init_graph_tracefs(void)
 	if (ret)
 		return 0;
 
-	trace_create_file("max_graph_depth", TRACE_MODE_WRITE, NULL,
-			  NULL, &graph_depth_fops);
+	trace_create_file(&nop_mnt_idmap, "max_graph_depth", TRACE_MODE_WRITE,
+			  NULL, NULL, &graph_depth_fops);
 
 	return 0;
 }
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index b791524a6536..7020ee831929 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -775,25 +775,25 @@ static int init_tracefs(void)
 	if (ret)
 		return -ENOMEM;
 
-	top_dir = tracefs_create_dir("hwlat_detector", NULL);
+	top_dir = tracefs_create_dir(&nop_mnt_idmap, "hwlat_detector", NULL);
 	if (!top_dir)
 		return -ENOMEM;
 
-	hwlat_sample_window = tracefs_create_file("window", TRACE_MODE_WRITE,
+	hwlat_sample_window = tracefs_create_file(&nop_mnt_idmap, "window", TRACE_MODE_WRITE,
 						  top_dir,
 						  &hwlat_window,
 						  &trace_min_max_fops);
 	if (!hwlat_sample_window)
 		goto err;
 
-	hwlat_sample_width = tracefs_create_file("width", TRACE_MODE_WRITE,
+	hwlat_sample_width = tracefs_create_file(&nop_mnt_idmap, "width", TRACE_MODE_WRITE,
 						 top_dir,
 						 &hwlat_width,
 						 &trace_min_max_fops);
 	if (!hwlat_sample_width)
 		goto err;
 
-	hwlat_thread_mode = trace_create_file("mode", TRACE_MODE_WRITE,
+	hwlat_thread_mode = trace_create_file(&nop_mnt_idmap, "mode", TRACE_MODE_WRITE,
 					      top_dir,
 					      NULL,
 					      &thread_mode_fops);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 52f8b537dd0a..c74f0524b5d4 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1914,11 +1914,11 @@ static __init int init_kprobe_trace(void)
 		return 0;
 
 	/* Event list interface */
-	trace_create_file("kprobe_events", TRACE_MODE_WRITE,
+	trace_create_file(&nop_mnt_idmap, "kprobe_events", TRACE_MODE_WRITE,
 			  NULL, NULL, &kprobe_events_ops);
 
 	/* Profile interface */
-	trace_create_file("kprobe_profile", TRACE_MODE_READ,
+	trace_create_file(&nop_mnt_idmap, "kprobe_profile", TRACE_MODE_READ,
 			  NULL, NULL, &kprobe_profile_ops);
 
 	setup_boot_kprobe_events();
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index bd0d01d00fb9..a7d073c2d97c 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2692,7 +2692,8 @@ static int init_timerlat_stack_tracefs(struct dentry *top_dir)
 {
 	struct dentry *tmp;
 
-	tmp = tracefs_create_file("print_stack", TRACE_MODE_WRITE, top_dir,
+	tmp = tracefs_create_file(&nop_mnt_idmap, "print_stack",
+				  TRACE_MODE_WRITE, top_dir,
 				  &osnoise_print_stack, &trace_min_max_fops);
 	if (!tmp)
 		return -ENOMEM;
@@ -2720,18 +2721,19 @@ static int osnoise_create_cpu_timerlat_fd(struct dentry *top_dir)
 	 * Because osnoise/timerlat have a single workload, having
 	 * multiple files like these are wast of memory.
 	 */
-	per_cpu = tracefs_create_dir("per_cpu", top_dir);
+	per_cpu = tracefs_create_dir(idmap, "per_cpu", top_dir);
 	if (!per_cpu)
 		return -ENOMEM;
 
 	for_each_possible_cpu(cpu) {
 		snprintf(cpu_str, 30, "cpu%ld", cpu);
-		cpu_dir = tracefs_create_dir(cpu_str, per_cpu);
+		cpu_dir = tracefs_create_dir(idmap, cpu_str, per_cpu);
 		if (!cpu_dir)
 			goto out_clean;
 
-		timerlat_fd = trace_create_file("timerlat_fd", TRACE_MODE_READ,
-						cpu_dir, NULL, &timerlat_fd_fops);
+		timerlat_fd = trace_create_file(&nop_mnt_idmap, "timerlat_fd",
+						TRACE_MODE_READ, cpu_dir, NULL,
+						&timerlat_fd_fops);
 		if (!timerlat_fd)
 			goto out_clean;
 
@@ -2754,8 +2756,9 @@ static int init_timerlat_tracefs(struct dentry *top_dir)
 	struct dentry *tmp;
 	int retval;
 
-	tmp = tracefs_create_file("timerlat_period_us", TRACE_MODE_WRITE, top_dir,
-				  &timerlat_period, &trace_min_max_fops);
+	tmp = tracefs_create_file(&nop_mnt_idmap, "timerlat_period_us",
+				  TRACE_MODE_WRITE, top_dir, &timerlat_period,
+				  &trace_min_max_fops);
 	if (!tmp)
 		return -ENOMEM;
 
@@ -2789,36 +2792,43 @@ static int init_tracefs(void)
 	if (ret)
 		return -ENOMEM;
 
-	top_dir = tracefs_create_dir("osnoise", NULL);
+	top_dir = tracefs_create_dir(&nop_mnt_idmap, "osnoise", NULL);
 	if (!top_dir)
 		return 0;
 
-	tmp = tracefs_create_file("period_us", TRACE_MODE_WRITE, top_dir,
-				  &osnoise_period, &trace_min_max_fops);
+	tmp = tracefs_create_file(&nop_mnt_idmap, "period_us", TRACE_MODE_WRITE,
+				  top_dir, &osnoise_period,
+				  &trace_min_max_fops);
 	if (!tmp)
 		goto err;
 
-	tmp = tracefs_create_file("runtime_us", TRACE_MODE_WRITE, top_dir,
-				  &osnoise_runtime, &trace_min_max_fops);
+	tmp = tracefs_create_file(&nop_mnt_idmap, "runtime_us",
+				  TRACE_MODE_WRITE, top_dir, &osnoise_runtime,
+				  &trace_min_max_fops);
 	if (!tmp)
 		goto err;
 
-	tmp = tracefs_create_file("stop_tracing_us", TRACE_MODE_WRITE, top_dir,
-				  &osnoise_stop_tracing_in, &trace_min_max_fops);
+	tmp = tracefs_create_file(&nop_mnt_idmap, "stop_tracing_us",
+				  TRACE_MODE_WRITE, top_dir,
+				  &osnoise_stop_tracing_in,
+				  &trace_min_max_fops);
 	if (!tmp)
 		goto err;
 
-	tmp = tracefs_create_file("stop_tracing_total_us", TRACE_MODE_WRITE, top_dir,
-				  &osnoise_stop_tracing_total, &trace_min_max_fops);
+	tmp = tracefs_create_file(&nop_mnt_idmap, "stop_tracing_total_us",
+				  TRACE_MODE_WRITE, top_dir,
+				  &osnoise_stop_tracing_total,
+				  &trace_min_max_fops);
 	if (!tmp)
 		goto err;
 
-	tmp = trace_create_file("cpus", TRACE_MODE_WRITE, top_dir, NULL, &cpus_fops);
+	tmp = trace_create_file(&nop_mnt_idmap, "cpus", TRACE_MODE_WRITE,
+				top_dir, NULL, &cpus_fops);
 	if (!tmp)
 		goto err;
 
-	tmp = trace_create_file("options", TRACE_MODE_WRITE, top_dir, NULL,
-				&osnoise_options_fops);
+	tmp = trace_create_file(&nop_mnt_idmap, "options", TRACE_MODE_WRITE,
+				top_dir, NULL, &osnoise_options_fops);
 	if (!tmp)
 		goto err;
 
diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index 29f6e95439b6..1a5cb6aa495e 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -384,8 +384,8 @@ static __init int init_trace_printk_function_export(void)
 	if (ret)
 		return 0;
 
-	trace_create_file("printk_formats", TRACE_MODE_READ, NULL,
-				    NULL, &ftrace_formats_fops);
+	trace_create_file(&nop_mnt_idmap, "printk_formats", TRACE_MODE_READ,
+			  NULL, NULL, &ftrace_formats_fops);
 
 	return 0;
 }
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 5a48dba912ea..06e63086a081 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -559,15 +559,16 @@ static __init int stack_trace_init(void)
 	if (ret)
 		return 0;
 
-	trace_create_file("stack_max_size", TRACE_MODE_WRITE, NULL,
-			&stack_trace_max_size, &stack_max_size_fops);
+	trace_create_file(&nop_mnt_idmap, "stack_max_size", TRACE_MODE_WRITE,
+			  NULL, &stack_trace_max_size, &stack_max_size_fops);
 
-	trace_create_file("stack_trace", TRACE_MODE_READ, NULL,
+	trace_create_file(&nop_mnt_idmap, "stack_trace", TRACE_MODE_READ, NULL,
 			NULL, &stack_trace_fops);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-	trace_create_file("stack_trace_filter", TRACE_MODE_WRITE, NULL,
-			  &trace_ops, &stack_trace_filter_fops);
+	trace_create_file(&nop_mnt_idmap, "stack_trace_filter",
+			  TRACE_MODE_WRITE, NULL, &trace_ops,
+			  &stack_trace_filter_fops);
 #endif
 
 	if (stack_trace_filter_buf[0])
diff --git a/kernel/trace/trace_stat.c b/kernel/trace/trace_stat.c
index bb247beec447..ca6e322468aa 100644
--- a/kernel/trace/trace_stat.c
+++ b/kernel/trace/trace_stat.c
@@ -282,7 +282,7 @@ static int tracing_stat_init(void)
 	if (ret)
 		return -ENODEV;
 
-	stat_dir = tracefs_create_dir("trace_stat", NULL);
+	stat_dir = tracefs_create_dir(&nop_mnt_idmap, "trace_stat", NULL);
 	if (!stat_dir) {
 		pr_warn("Could not create tracefs 'trace_stat' entry\n");
 		return -ENOMEM;
@@ -297,8 +297,8 @@ static int init_stat_file(struct stat_session *session)
 	if (!stat_dir && (ret = tracing_stat_init()))
 		return ret;
 
-	session->file = tracefs_create_file(session->ts->name, TRACE_MODE_WRITE,
-					    stat_dir, session,
+	session->file = tracefs_create_file(&nop_mnt_idmap, session->ts->name,
+					    TRACE_MODE_WRITE, stat_dir, session,
 					    &tracing_stat_fops);
 	if (!session->file)
 		return -ENOMEM;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 99c051de412a..060160c63f43 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1654,10 +1654,10 @@ static __init int init_uprobe_trace(void)
 	if (ret)
 		return 0;
 
-	trace_create_file("uprobe_events", TRACE_MODE_WRITE, NULL,
+	trace_create_file(&nop_mnt_idmap, "uprobe_events", TRACE_MODE_WRITE, NULL,
 				    NULL, &uprobe_events_ops);
 	/* Profile interface */
-	trace_create_file("uprobe_profile", TRACE_MODE_READ, NULL,
+	trace_create_file(&nop_mnt_idmap, "uprobe_profile", TRACE_MODE_READ, NULL,
 				    NULL, &uprobe_profile_ops);
 	return 0;
 }
-- 
2.43.0


