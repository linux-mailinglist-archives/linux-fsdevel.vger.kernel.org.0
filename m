Return-Path: <linux-fsdevel+bounces-52450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E1AAE347C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7268A18907C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0BA1E6DC5;
	Mon, 23 Jun 2025 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Phbh/o5j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB051C862B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654474; cv=none; b=IfM/FfSWa6sjd/lmW2eAKsHSFAI+1igpxUNtwSIoWns6tpIaL1ny+vNrpF3bkqjvBp3TlgWT4QgtfPNZtuaPh6Z24MLicx8ReeXFfo/afVtOFzwitjgCz8sq51ZMMkdtRDtmI4gyUocO+d2gZNgsO/75HeT9MQXfaErt474oohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654474; c=relaxed/simple;
	bh=t7JVjmb9LmQOwLDtlnDkbqg5iib70qiFr0D9Spff8Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOdN4OaWSqv5blgJYnNl83ZzYWvYxh0//ia8yzNEWducBwGMREcPCRtanWd3/IpUIuBwyZJKoSa3isY6ChEtgNzim9BYfZh3IuL7EptYwfmCLfENulwHqAmbXeq8stgK0FjBcqlFzsXJeBoeGuI4ZFAuxxrzLpqeY9V4BFRW4nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Phbh/o5j; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=z2jK/UXAmdS58gPfCGiZyvtDyClDzyKnPsGqwQboCk8=; b=Phbh/o5jOWyx0723sDmznR+tvv
	YzPyXJRC5qyr0iPwP5g41FYuLDydwrUk5g7xtzMuTYLwN/4OhoUyQugR2KNyqC9MoqolWE1taSdB3
	hcx128Dg4xgH7wq+55rEfTkdMhVBQ6CZwr+qKjKKYgNOCrJqa8bCRDGjRpiMrJCI8mReS8M6HIDEG
	dev6eddryo1T2K09wO0ZsfIGkGCIHSrfu3o8E+yCsPQbG0I5CQwXRT5E5/TbA+/Uoyr01ybs/nK4L
	maPof5hcD+2VcaMEXCddwhimY9suWnUXyep79DPFoa+fXbE3MAGAYFYcqv8e+KbRztSKOUAGjmdgm
	KdEdqTNg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCQ-00000005Kr2-2IWm;
	Mon, 23 Jun 2025 04:54:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 17/35] sanitize handling of long-term internal mounts
Date: Mon, 23 Jun 2025 05:54:10 +0100
Message-ID: <20250623045428.1271612-17-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/gpu/drm/i915/gem/i915_gemfs.c | 21 ++++++++++++++++++---
 drivers/gpu/drm/v3d/v3d_gemfs.c       | 21 ++++++++++++++++++---
 fs/hugetlbfs/inode.c                  |  2 +-
 fs/namespace.c                        |  9 +++++++++
 include/linux/mount.h                 |  1 +
 ipc/mqueue.c                          |  2 +-
 6 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
index 65d84a93c525..a09e2eb47175 100644
--- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
+++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
@@ -5,16 +5,23 @@
 
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
@@ -38,8 +45,16 @@ void i915_gemfs_init(struct drm_i915_private *i915)
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
index a7bf07d88da4..96bc3b804974 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1260,6 +1260,15 @@ struct vfsmount *fc_mount(struct fs_context *fc)
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
index 1a508beba446..c145820fcbbf 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -98,6 +98,7 @@ int mnt_get_write_access(struct vfsmount *mnt);
 void mnt_put_write_access(struct vfsmount *mnt);
 
 extern struct vfsmount *fc_mount(struct fs_context *fc);
+extern struct vfsmount *fc_mount_longterm(struct fs_context *fc);
 extern struct vfsmount *vfs_create_mount(struct fs_context *fc);
 extern struct vfsmount *vfs_kern_mount(struct file_system_type *type,
 				      int flags, const char *name,
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 82ed2d3c9846..de7432efbf4a 100644
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
-- 
2.39.5


