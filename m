Return-Path: <linux-fsdevel+bounces-47988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C96AA8347
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 01:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC7217E1A5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 May 2025 23:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC161C54AA;
	Sat,  3 May 2025 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ky4MTvyl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7091FAA
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 May 2025 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746313378; cv=none; b=mNJrZx5ji3TO5jnKo+4WbMZNL4JdwFVanbp/cQYG9ozyfbVmHMM9RKwRuH86uJwRCyzKJ8XIQnyQfaxtH/NPX6arPyB5Sc5ZrbwnShd0VhEkhRYIJ10EWOG5qjwp4XD1GIrCJTM0a6UgIm9bd3eUtsTLaYekUe108jTFqbLoIuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746313378; c=relaxed/simple;
	bh=FlIWQyCmObeuWNRzI0fSy0ZUJRlJ2it3dgXG/JE9B88=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ldaY+jbDhHY2ts0r/gdrVUEjYIrG4r9xaXrIeIMPHfWzjWDuMtEXSQy+kEiGWukyxM8VvxmVOp12uAqf7JZp+nniZEv7f2bmfCMAuMJ9UHHi2fhGhU80YKnlLx5PSsw6Bfq8Tmgp9KBRublCFpbtFMmbCUMnWb6jaIhSgDS5L/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ky4MTvyl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=SkKwhAML8JXSnXowUr2+V7pBJaOW6+Dd4dupistZ3rY=; b=ky4MTvylvJ1IwCac2cTA8XnLiK
	1rfgDO+1WhAHJZIXPJDcSFyLuyWV/5bmhm8dXPBYREpiuocna5GHdgwMeABD68P3FNzwaJxo5Skun
	7W2Bb5OGaPbWby+C/y0G4XFHTUnLed6xvyN4afttGaFuaDTIuK5FlVKg9+uRl/JhfLZWJVOVPWOu2
	0t/9iB8tzTj83DxeLhC6bRy0Du4N+CVnuzv+4PsZrPlPjEy65ViDAPsT3YZUGZldrFFsqUlN6Q1R2
	T4FnoZIL2gLryKC3OcItk7cMT36R8LbNJt2YQGvwXxkIK4T3yt2uQLX1KS3ahGzA8kLHntlS6z0kx
	ZgUP1gaA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBLsh-0000000AWY4-2YZZ;
	Sat, 03 May 2025 23:02:51 +0000
Date: Sun, 4 May 2025 00:02:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Melissa Wen <mwen@igalia.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH][CFT][RFC] sanitize handling of long-term internal mounts
Message-ID: <20250503230251.GA2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[folks, review and testing would be very welcome; i915 and v3d conversions
are essentially untested and I would really like to hear from DRM people
before pushing those anywhere.  I've no problem with splitting these
parts off and putting the infrastructure bits into a never-rebased
branch, if somebody prefers to have those taken via drm tree]

Original rationale for those had been the reduced cost of mntput()
for the stuff that is mounted somewhere.  Mount refcount increments and
decrements are frequent; what's worse, they tend to concentrate on the
same instances and cacheline pingpong is quite noticable.

As the result, mount refcounts are per-cpu; that allows a very cheap
increment.  Plain decrement would be just as easy, but decrement-and-test
is anything but (we need to add the components up, with exclusion against
possible increment-from-zero, etc.).

Fortunately, there is a very common case where we can tell that decrement
won't be the final one - if the thing we are dropping is currently
mounted somewhere.  We have an RCU delay between the removal from mount
tree and dropping the reference that used to pin it there, so we can
just take rcu_read_lock() and check if the victim is mounted somewhere.
If it is, we can go ahead and decrement without and further checks -
the reference we are dropping is not the last one.  If it isn't, we
get all the fun with locking, carefully adding up components, etc.,
but the majority of refcount decrements end up taking the fast path.

There is a major exception, though - pipes and sockets.  Those live
on the internal filesystems that are not going to be mounted anywhere.
They are not going to be _un_mounted, of course, so having to take the
slow path every time a pipe or socket gets closed is really obnoxious.
Solution had been to mark them as long-lived ones - essentially faking
"they are mounted somewhere" indicator.

With minor modification that works even for ones that do eventually get
dropped - all it takes is making sure we have an RCU delay between
clearing the "mounted somewhere" indicator and dropping the reference.

There are some additional twists (if you want to drop a dozen of such
internal mounts, you'd be better off with clearing the indicator on
all of them, doing an RCU delay once, then dropping the references),
but in the basic form it had been
	* use kern_mount() if you want your internal mount to be
a long-term one.
	* use kern_unmount() to undo that.

Unfortunately, the things did rot a bit during the mount API reshuffling.
In several cases we have lost the "fake the indicator" part; kern_unmount()
on the unmount side remained (it doesn't warn if you use it on a mount
without the indicator), but all benefits regaring mntput() cost had been
lost.

To get rid of that bitrot, let's add a new helper that would work
with fs_context-based API: fc_mount_longterm().  It's a counterpart
of fc_mount() that does, on success, mark its result as long-term.
It must be paired with kern_unmount() or equivalents.

Converted:
	1) mqueue (it used to use kern_mount_data() and the umount side
is still as it used to be)
	2) hugetlbfs (used to use kern_mount_data(), internal mount is
never unmounted in this one)
	3) i915 gemfs (used to be kern_mount() + manual remount to set
options, still uses kern_unmount() on umount side)
	4) v3d gemfs (copied from i915)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
index 46b9a17d6abc..aae7c0a3c966 100644
--- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
+++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
@@ -6,16 +6,23 @@
 
 #include <linux/fs.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 
 #include "i915_drv.h"
 #include "i915_gemfs.h"
 #include "i915_utils.h"
 
+static int add_param(struct fs_context *fc, const char *key, const char *val)
+{
+	return vfs_parse_fs_string(fc, key, val, strlen(val));
+}
+
 void i915_gemfs_init(struct drm_i915_private *i915)
 {
-	char huge_opt[] = "huge=within_size"; /* r/w */
 	struct file_system_type *type;
+	struct fs_context *fc;
 	struct vfsmount *gemfs;
+	int ret;
 
 	/*
 	 * By creating our own shmemfs mountpoint, we can pass in
@@ -39,8 +46,16 @@ void i915_gemfs_init(struct drm_i915_private *i915)
 	if (!type)
 		goto err;
 
-	gemfs = vfs_kern_mount(type, SB_KERNMOUNT, type->name, huge_opt);
-	if (IS_ERR(gemfs))
+	fc = fs_context_for_mount(type, SB_KERNMOUNT);
+	if (IS_ERR(fc))
+		goto err;
+	ret = add_param(fc, "source", "tmpfs");
+	if (!ret)
+		ret = add_param(fc, "huge", "within_size");
+	if (!ret)
+		gemfs = fc_mount_longterm(fc);
+	put_fs_context(fc);
+	if (ret)
 		goto err;
 
 	i915->mm.gemfs = gemfs;
diff --git a/drivers/gpu/drm/v3d/v3d_gemfs.c b/drivers/gpu/drm/v3d/v3d_gemfs.c
index 4c5e18590a5c..8ec6ed82b3d9 100644
--- a/drivers/gpu/drm/v3d/v3d_gemfs.c
+++ b/drivers/gpu/drm/v3d/v3d_gemfs.c
@@ -3,14 +3,21 @@
 
 #include <linux/fs.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 
 #include "v3d_drv.h"
 
+static int add_param(struct fs_context *fc, const char *key, const char *val)
+{
+	return vfs_parse_fs_string(fc, key, val, strlen(val));
+}
+
 void v3d_gemfs_init(struct v3d_dev *v3d)
 {
-	char huge_opt[] = "huge=within_size";
 	struct file_system_type *type;
+	struct fs_context *fc;
 	struct vfsmount *gemfs;
+	int ret;
 
 	/*
 	 * By creating our own shmemfs mountpoint, we can pass in
@@ -28,8 +35,16 @@ void v3d_gemfs_init(struct v3d_dev *v3d)
 	if (!type)
 		goto err;
 
-	gemfs = vfs_kern_mount(type, SB_KERNMOUNT, type->name, huge_opt);
-	if (IS_ERR(gemfs))
+	fc = fs_context_for_mount(type, SB_KERNMOUNT);
+	if (IS_ERR(fc))
+		goto err;
+	ret = add_param(fc, "source", "tmpfs");
+	if (!ret)
+		ret = add_param(fc, "huge", "within_size");
+	if (!ret)
+		gemfs = fc_mount_longterm(fc);
+	put_fs_context(fc);
+	if (ret)
 		goto err;
 
 	v3d->gemfs = gemfs;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index e4de5425838d..4e0397775167 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1587,7 +1587,7 @@ static struct vfsmount *__init mount_one_hugetlbfs(struct hstate *h)
 	} else {
 		struct hugetlbfs_fs_context *ctx = fc->fs_private;
 		ctx->hstate = h;
-		mnt = fc_mount(fc);
+		mnt = fc_mount_longterm(fc);
 		put_fs_context(fc);
 	}
 	if (IS_ERR(mnt))
diff --git a/fs/namespace.c b/fs/namespace.c
index 6f7b2174f25b..07f636036b86 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1258,6 +1258,15 @@ struct vfsmount *fc_mount(struct fs_context *fc)
 }
 EXPORT_SYMBOL(fc_mount);
 
+struct vfsmount *fc_mount_longterm(struct fs_context *fc)
+{
+	struct vfsmount *mnt = fc_mount(fc);
+	if (!IS_ERR(mnt))
+		real_mount(mnt)->mnt_ns = MNT_NS_INTERNAL;
+	return mnt;
+}
+EXPORT_SYMBOL(fc_mount_longterm);
+
 struct vfsmount *vfs_kern_mount(struct file_system_type *type,
 				int flags, const char *name,
 				void *data)
diff --git a/include/linux/mount.h b/include/linux/mount.h
index dcc17ce8a959..9376d76dd61f 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -94,6 +94,7 @@ int mnt_get_write_access(struct vfsmount *mnt);
 void mnt_put_write_access(struct vfsmount *mnt);
 
 extern struct vfsmount *fc_mount(struct fs_context *fc);
+extern struct vfsmount *fc_mount_longterm(struct fs_context *fc);
 extern struct vfsmount *vfs_create_mount(struct fs_context *fc);
 extern struct vfsmount *vfs_kern_mount(struct file_system_type *type,
 				      int flags, const char *name,
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 35b4f8659904..daabf7f02b63 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -482,7 +482,7 @@ static struct vfsmount *mq_create_mount(struct ipc_namespace *ns)
 	put_user_ns(fc->user_ns);
 	fc->user_ns = get_user_ns(ctx->ipc_ns->user_ns);
 
-	mnt = fc_mount(fc);
+	mnt = fc_mount_longterm(fc);
 	put_fs_context(fc);
 	return mnt;
 }

