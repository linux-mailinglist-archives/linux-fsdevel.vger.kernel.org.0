Return-Path: <linux-fsdevel+bounces-7815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0485182B657
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 22:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4F91C23B21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 21:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C192F58138;
	Thu, 11 Jan 2024 21:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r32DKUkB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF2858120;
	Thu, 11 Jan 2024 21:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B498C433C7;
	Thu, 11 Jan 2024 21:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705006897;
	bh=PFG8j0jT1BA4DMknUZxLa45oxU/YXg+wI9zseXQYOxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r32DKUkByB0o6slrF1vV6yCPkEIC2z4LTzr+yk9W8Q2ys1oqisAFBxYNJ/usR1bAn
	 90Vwr3HVPDaWDJQVlWeyQQWyI1vdF2gZEQT6a/xE1A40NUdfFWZFT7pYO5rxZETrgE
	 pOtqVHslXvfy1/hstXDFJlHAzwqy55L1fTB9Ipt/f5crzvZB69sjHOSCNutAyaTbcZ
	 v+3ABQi8Xor05EzVvqiRo81XuXKAXyQL92Lv5RauRJV07ezDcghTC6+9jeJDb32Hif
	 VW8IandweHxkA3zVq61KBqLq4Kz2cp0Nu8iniLqI+Pwc+VE11b8kzkvYDlC8Mssf8K
	 C4ei3FONAmegA==
Date: Thu, 11 Jan 2024 22:01:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default
 ownership
Message-ID: <20240111-unzahl-gefegt-433acb8a841d@brauner>
References: <20240103203246.115732ec@gandalf.local.home>
 <20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
 <20240105095954.67de63c2@gandalf.local.home>
 <20240107-getrickst-angeeignet-049cea8cad13@brauner>
 <20240107132912.71b109d8@rorschach.local.home>
 <20240108-ortsrand-ziehen-4e9a9a58e708@brauner>
 <20240108102331.7de98cab@gandalf.local.home>
 <20240110-murren-extra-cd1241aae470@brauner>
 <20240110080746.50f7767d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240110080746.50f7767d@gandalf.local.home>

On Wed, Jan 10, 2024 at 08:07:46AM -0500, Steven Rostedt wrote:
> On Wed, 10 Jan 2024 12:45:36 +0100
> Christian Brauner <brauner@kernel.org> wrote:
> 
> > So say you do:
> > 
> > mkdir /sys/kernel/tracing/instances/foo
> > 
> > After this has returned we know everything we need to know about the new
> > tracefs instance including the ownership and the mode of all inodes in
> > /sys/kernel/tracing/instances/foo/events/* and below precisely because
> > ownership is always inherited from the parent dentry and recorded in the
> > metadata struct eventfs_inode.
> > 
> > So say someone does:
> > 
> > open("/sys/kernel/tracing/instances/foo/events/xfs");
> > 
> > and say this is the first time that someone accesses that events/
> > directory.
> > 
> > When the open pathwalk is done, the vfs will determine via
> > 
> > [1] may_lookup(inode_of(events))
> > 
> > whether you are able to list entries such as "xfs" in that directory.
> > The vfs checks inode_permission(MAY_EXEC) on "events" and if that holds
> > it ends up calling i_op->eventfs_root_lookup(events).
> > 
> > At this point tracefs/eventfs adds the inodes for all entries in that
> > "events" directory including "xfs" based on the metadata it recorded
> > during the mkdir. Since now someone is actually interested in them. And
> > it initializes the inodes with ownership and everything and adds the
> > dentries that belong into that directory.
> > 
> > Nothing here depends on the permissions of the caller. The only
> > permission that mattered was done in the VFS in [1]. If the caller has
> > permissions to enter a directory they can lookup and list its contents.
> > And its contents where determined/fixed etc when mkdir was called.
> > 
> > So we just need to add the required objects into the caches (inode,
> > dentry) whose addition we intentionally defered until someone actually
> > needed them.
> > 
> > So, eventfs_root_lookup() now initializes the inodes with the ownership
> > from the stored metadata or from the parent dentry and splices in inodes
> > and dentries. No permission checking is needed for this because it is
> > always a recheck of what the vfs did in [1].
> > 
> > We now return to the vfs and path walk continues to the final component
> > that you actually want to open which is that "xfs" directory in this
> > example. We check the permissions on that inode via may_open("xfs") and
> > we open that directory returning an fd to userspace ultimately.
> > 
> > (I'm going by memory since I need to step out the door.)
> 
> So, let's say we do:
> 
>  chgrp -R rostedt /sys/kernel/tracing/

The rostedt group needs exec permissions and "other" cannot have exec
permissions otherwise you can trivially list the entries even if it's
owned by root:

chmod 750 /sys/kernel/tracing

user1@localhost:~$ ls -aln /sys/kernel/ | grep tracing
drwxr-x---   6 0 1000    0 Jan 11 18:23 tracing

> 
> But I don't want rostedt to have access to xfs
> 
>  chgrp -R root /sys/kernel/tracing/events/xfs

chmod 750 /sys/kernel/tracing/events/xfs

user1@localhost:~$ ls -aln /sys/kernel/tracing/events/ | grep xfs
drwxr-x--- 601 0 0 0 Jan 11 18:24 xfs

This ensure that if a user is in the group and the group has exec perms
lookup is possible (For root this will usually work because
CAP_DAC_READ_SEARCH overrides the exec requirement.).

> 
> Both actions will create the inodes and dentries of all files and
> directories (because of "-R"). But once that is done, the ref counts go to
> zero. They stay around until reclaim. But then I open Chrome ;-) and it
> reclaims all the dentries and inodes, so we are back to here we were on
> boot.
> 
> Now as rostedt I do:
> 
>  ls /sys/kernel/tracing/events/xfs
> 
> The VFS layer doesn't know if I have permission to that or not, because all
> the inodes and dentries have been freed. It has to call back to eventfs to
> find out. Which the eventfs_root_lookup() and eventfs_iterate_shared() will
> recreated the inodes with the proper permission.

Very roughly, ignoring most of the complexity of lookup and focussing on
the permission checking:

When a caller looks up an entry in a directory then the VFS will call
inode_permission(MAY_EXEC) on the directory the caller is trying to
perform that lookup in.

If the caller wants to lookup the "events" entry in the "tracing"
directory then the VFS will call inode_permission(MAY_EXEC, "tracing")
and then - assuming it's not in the cache - call into the lookup method
of the filesystem.

After the VFS has determined that the caller has the permissions to
lookup the "events" entry in the "tracing" directory no further
permission checks are needed.

Path lookup now moves on to the next part which is looking up the "xfs"
entry in the "events" directory. So again, VFS calls
inode_permission(MAY_EXEC, "events") finds that caller has the permissions
and then goes on to call into eventfs_root_lookup().

The VFS has already given the caller a dentry for "xfs" and is passing
that down to tracefs/eventfs. So eventfs gets
eventfs_rootfs_lookup(@dir[events], @dentry[xfs], ...)

eventfs now wades through the recorded metadata entries for the
@dir[events] directory and finds a matching metadata entry for "xfs". It
allocates an inode for it and initializes the owner, mode etc based on
the recorded information. The lookup_one_len() call finds the dentry
that was just added by the VFS.

The "xfs" dentry/inode is now in the cache. The VFS moves on. It calls
inode_permission(MAY_EXEC, "xfs"). It sees that based on the mode you
don't have access to that directory. Lookup fails.

What I'm pointing out in the current logic is that the caller is
taxed twice:

(1) Once when the VFS has done inode_permission(MAY_EXEC, "xfs")
(2) And again when you call lookup_one_len() in eventfs_start_creating()
    _because_ the permission check in lookup_one_len() is the exact
    same permission check again that the vfs has done
    inode_permission(MAY_EXEC, "xfs").

The readdir case is similar only that instead of generating an inode for
a single entry in the directory like in lookup, you're generating inodes
and dentries for multiple entries. And you might end up calling
eventfs_start_creating() like 600 times for xfs/ for example. So you end
up calling lookup_one_len() and thus inode_permission() 600 times.  And
this inode_permission() check is the same check that the VFS already
performed: inode_permission(MAY_EXEC, "xfs").

You can even break readdir semantics via tracefs right now:

// We managed to open the directory so we have permission to list
// directory entries in "xfs".
fd = open("/sys/kernel/tracing/events/xfs");

// Remove ownership so we can't open the directory anymore
chown("/sys/kernel/tracing/events/xfs", 0, 0);

// Or just remove exec bit for the group and restrict to owner
chmod("/sys/kernel/tracing/events/xfs", 700);

// Drop caches to force an eventfs_root_lookup() on everything
write("/proc/sys/vm/drop_caches", "3", 1);

// Returns 0 even though directory has a lot of entries and we should be
// able to list them
getdents64(fd, ...);

And the failure is in the inode_permission(MAY_EXEC, "xfs") call in
lookup_one_len() in eventfs_start_creating() which now fails.

But that's not how this is supposed to work. Once you hold an fd to a
directory you can read it's entries even if the permissions change.
There's no DAC read-time checks on the directory after that. But this is
exactly what happens on eventfs. So it's even broken right now imho.

I've tested this:

user1@localhost:~/data/scripts$ ./readdir_fail /sys/kernel/tracing/events/xfs/
inode#    file type  d_reclen  d_off   d_name
    4861  directory    24          1  .
    1027  directory    24          2  ..

So what I meant is something completely untested, possibly ugly, drafted
like the below.

But tbh, I suspect that eventfs_root_lookup() could even simply be
rewritten to reuse the dentry it was provided from the VFS directly
instead of even having to go through lookup_one_len() via
eventfs_start_creating() at all. Then only the ->iterate_shared
implementation needs to call the noperm lookup variant I hastily drafted
below. But idk, I haven't given that part much thought.

 fs/namei.c            | 46 ++++++++++++++++++++++++++++++++++++++++---
 fs/tracefs/inode.c    |  2 +-
 include/linux/namei.h |  1 +
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 963576e67f62..0bfd87e79c5d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2656,9 +2656,8 @@ int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
 }
 EXPORT_SYMBOL(vfs_path_lookup);
 
-static int lookup_one_common(struct mnt_idmap *idmap,
-			     const char *name, struct dentry *base, int len,
-			     struct qstr *this)
+static int lookup_one_common_noperm(const char *name, struct dentry *base,
+				    int len, struct qstr *this)
 {
 	this->name = name;
 	this->len = len;
@@ -2686,6 +2685,19 @@ static int lookup_one_common(struct mnt_idmap *idmap,
 			return err;
 	}
 
+	return 0;
+}
+
+static inline int lookup_one_common(struct mnt_idmap *idmap,
+			     const char *name, struct dentry *base, int len,
+			     struct qstr *this)
+{
+	int ret;
+
+	ret = lookup_one_common_noperm(name, base, len, this);
+	if (ret)
+		return ret;
+
 	return inode_permission(idmap, base->d_inode, MAY_EXEC);
 }
 
@@ -2776,6 +2788,34 @@ struct dentry *lookup_one(struct mnt_idmap *idmap, const char *name,
 }
 EXPORT_SYMBOL(lookup_one);
 
+/**
+ * lookup_one_noperm - filesystem helper to lookup single pathname component
+ * @name:	pathname component to lookup
+ * @base:	base directory to lookup from
+ * @len:	maximum length @len should be interpreted to
+ *
+ * Note that this routine is purely a helper for filesystem usage and should
+ * not be called by generic code. This performs no permission checking on @base.
+ *
+ * The caller must hold base->i_mutex.
+ */
+struct dentry *lookup_one_noperm(const char *name, struct dentry *base, int len)
+{
+	struct dentry *dentry;
+	struct qstr this;
+	int err;
+
+	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
+
+	err = lookup_one_common_noperm(name, base, len, &this);
+	if (err)
+		return ERR_PTR(err);
+
+	dentry = lookup_dcache(&this, base, 0);
+	return dentry ? dentry : __lookup_slow(&this, base, 0);
+}
+EXPORT_SYMBOL(lookup_one_noperm);
+
 /**
  * lookup_one_unlocked - filesystem helper to lookup single pathname component
  * @idmap:	idmap of the mount the lookup is performed from
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index e1b172c0e091..fa04aa6a5ce7 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -524,7 +524,7 @@ struct dentry *eventfs_start_creating(const char *name, struct dentry *parent)
 	if (unlikely(IS_DEADDIR(parent->d_inode)))
 		dentry = ERR_PTR(-ENOENT);
 	else
-		dentry = lookup_one_len(name, parent, strlen(name));
+		dentry = lookup_one_noperm(name, parent, strlen(name));
 
 	if (!IS_ERR(dentry) && dentry->d_inode) {
 		dput(dentry);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 3100371b5e32..a1491da37cbe 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -77,6 +77,7 @@ extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int);
 extern struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int);
 struct dentry *lookup_one(struct mnt_idmap *, const char *, struct dentry *, int);
+struct dentry *lookup_one_noperm(const char *, struct dentry *, int);
 struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
 				   const char *name, struct dentry *base,
 				   int len);
-- 
2.43.0


