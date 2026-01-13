Return-Path: <linux-fsdevel+bounces-73338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 692D6D160C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 354E63048C66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 00:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F219527F18B;
	Tue, 13 Jan 2026 00:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEAqWscR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D532367B8;
	Tue, 13 Jan 2026 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264286; cv=none; b=ZUK03bzjkXH6OafFNce6Kt3J95Zf+yzWecBwSvPOjHj1FfqQI4NuNVDNHKuaQ8aRHU5o5FvwuAM5S42kET/HC2q6CUoOHUJxpUWuflHmT9BnpfkxaO5B4HNHFrNJ/kGTEXyvqcvFlDcDqiRe/X3BIYo+IQtyEVMSIRmWPri/NYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264286; c=relaxed/simple;
	bh=NsPm8rAKGcZQgZOVJ6nIPVneie3IexBMdRBs3GBvgRI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKoXpcXU8Puerx9MRY3w0XheiuPvtNdQ8FBsjKo8epi0onN+iIg3OgU7BLyMDk9JsPWfqR8e6S61VHqDMu6ReHuSeipPCwuNf2a9H9IyuQ7KnSsfGaR8RXJJPRIE02I6SXdASR01WYk5EobYuCZ61yR3F/mEeBFnNI/CduOz8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEAqWscR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FDFC116D0;
	Tue, 13 Jan 2026 00:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768264285;
	bh=NsPm8rAKGcZQgZOVJ6nIPVneie3IexBMdRBs3GBvgRI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KEAqWscReMdd/3YdwQt8MiWBrca2sUOYKXC0FsEPa/3eB/r8uFwFbi1uUsjdyILEW
	 ZGhbtb8dG1KgGgtMH4ebXJZ+X1O2U/U8nhiS15pbjmFFod3EkA5sdCPpEZhzOiNXbE
	 FRTNVDsn9ZYZVFyxjaH93sOV/AFCCasr/iIuqzqJFkkD8DqT8wjmweBjwItY/8rxrJ
	 xUekmc1y0kOx3Yfg6xEnRuILlP9udixTCySfZLheBHUzAifchgJC8Xb73/K+Cdb1ml
	 y0XubeliYrXZWN3Os8h6ZMb3tyY0LiSI8lccBRFJl03pCHnVA6avtl9DQWzjEZaH8a
	 mQz9Nj0QTbAvQ==
Date: Mon, 12 Jan 2026 16:31:25 -0800
Subject: [PATCH 2/6] fs: report filesystem and file I/O errors to fsnotify
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, brauner@kernel.org
Cc: hch@lst.de, jack@suse.cz, linux-xfs@vger.kernel.org, jack@suse.cz,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 gabriel@krisman.be, hch@lst.de, amir73il@gmail.com
Message-ID: <176826402610.3490369.4378391061533403171.stgit@frogsfrogsfrogs>
In-Reply-To: <176826402528.3490369.2415315475116356277.stgit@frogsfrogsfrogs>
References: <176826402528.3490369.2415315475116356277.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create some wrapper code around struct super_block so that filesystems
have a standard way to queue filesystem metadata and file I/O error
reports to have them sent to fsnotify.

If a filesystem wants to provide an error number, it must supply only
negative error numbers.  These are stored internally as negative
numbers, but they are converted to positive error numbers before being
passed to fanotify, per the fanotify(7) manpage.  Implementations of
super_operations::report_error are passed the raw internal event data.

Note that we have to play some shenanigans with mempools and queue_work
so that the error handling doesn't happen outside of process context,
and the event handler functions (both ->report_error and fsnotify) can
handle file I/O error messages without having to worry about whatever
locks might be held.  This asynchronicity requires that unmount wait for
pending events to clear.

Add a new callback to the superblock operations structure so that
filesystem drivers can themselves respond to file I/O errors if they so
desire.  This will be used for an upcoming self-healing patchset for
XFS.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 include/linux/fs/super_types.h |    7 +
 include/linux/fserror.h        |   75 +++++++++++++++
 fs/Makefile                    |    2 
 fs/fserror.c                   |  194 ++++++++++++++++++++++++++++++++++++++++
 fs/super.c                     |    3 +
 5 files changed, 280 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/fserror.h
 create mode 100644 fs/fserror.c


diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index 6bd3009e09b3b8..97a8552d8f2bc9 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -35,6 +35,7 @@ struct user_namespace;
 struct workqueue_struct;
 struct writeback_control;
 struct xattr_handler;
+struct fserror_event;
 
 extern struct super_block *blockdev_superblock;
 
@@ -124,6 +125,9 @@ struct super_operations {
 	 */
 	int (*remove_bdev)(struct super_block *sb, struct block_device *bdev);
 	void (*shutdown)(struct super_block *sb);
+
+	/* Report a filesystem error */
+	void (*report_error)(const struct fserror_event *event);
 };
 
 struct super_block {
@@ -268,6 +272,9 @@ struct super_block {
 	spinlock_t				s_inode_wblist_lock;
 	struct list_head			s_inodes_wb;	/* writeback inodes */
 	long					s_min_writeback_pages;
+
+	/* number of fserrors that are being sent to fsnotify/filesystems */
+	refcount_t				s_pending_errors;
 } __randomize_layout;
 
 /*
diff --git a/include/linux/fserror.h b/include/linux/fserror.h
new file mode 100644
index 00000000000000..5e1ad78c346e27
--- /dev/null
+++ b/include/linux/fserror.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef _LINUX_FSERROR_H__
+#define _LINUX_FSERROR_H__
+
+void fserror_mount(struct super_block *sb);
+void fserror_unmount(struct super_block *sb);
+
+enum fserror_type {
+	/* pagecache I/O failed */
+	FSERR_BUFFERED_READ,
+	FSERR_BUFFERED_WRITE,
+
+	/* direct I/O failed */
+	FSERR_DIRECTIO_READ,
+	FSERR_DIRECTIO_WRITE,
+
+	/* out of band media error reported */
+	FSERR_DATA_LOST,
+
+	/* filesystem metadata */
+	FSERR_METADATA,
+};
+
+struct fserror_event {
+	struct work_struct work;
+	struct super_block *sb;
+	struct inode *inode;
+	loff_t pos;
+	u64 len;
+	enum fserror_type type;
+
+	/* negative error number */
+	int error;
+};
+
+void fserror_report(struct super_block *sb, struct inode *inode,
+		    enum fserror_type type, loff_t pos, u64 len, int error,
+		    gfp_t gfp);
+
+static inline void fserror_report_io(struct inode *inode,
+				     enum fserror_type type, loff_t pos,
+				     u64 len, int error, gfp_t gfp)
+{
+	fserror_report(inode->i_sb, inode, type, pos, len, error, gfp);
+}
+
+static inline void fserror_report_data_lost(struct inode *inode, loff_t pos,
+					    u64 len, gfp_t gfp)
+{
+	fserror_report(inode->i_sb, inode, FSERR_DATA_LOST, pos, len, -EIO,
+		       gfp);
+}
+
+static inline void fserror_report_file_metadata(struct inode *inode, int error,
+						gfp_t gfp)
+{
+	fserror_report(inode->i_sb, inode, FSERR_METADATA, 0, 0, error, gfp);
+}
+
+static inline void fserror_report_metadata(struct super_block *sb, int error,
+					   gfp_t gfp)
+{
+	fserror_report(sb, NULL, FSERR_METADATA, 0, 0, error, gfp);
+}
+
+static inline void fserror_report_shutdown(struct super_block *sb, gfp_t gfp)
+{
+	fserror_report(sb, NULL, FSERR_METADATA, 0, 0, -ESHUTDOWN, gfp);
+}
+
+#endif /* _LINUX_FSERROR_H__ */
diff --git a/fs/Makefile b/fs/Makefile
index a04274a3c85420..f238cc5ea2e9d7 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -16,7 +16,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
 		fs_dirent.o fs_context.o fs_parser.o fsopen.o init.o \
 		kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o \
-		file_attr.o
+		file_attr.o fserror.o
 
 obj-$(CONFIG_BUFFER_HEAD)	+= buffer.o mpage.o
 obj-$(CONFIG_PROC_FS)		+= proc_namespace.o
diff --git a/fs/fserror.c b/fs/fserror.c
new file mode 100644
index 00000000000000..06ca86adab9b76
--- /dev/null
+++ b/fs/fserror.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#include <linux/fs.h>
+#include <linux/fsnotify.h>
+#include <linux/mempool.h>
+#include <linux/fserror.h>
+
+#define FSERROR_DEFAULT_EVENT_POOL_SIZE		(32)
+
+static struct mempool fserror_events_pool;
+
+void fserror_mount(struct super_block *sb)
+{
+	/*
+	 * The pending error counter is biased by 1 so that we don't wake_var
+	 * until we're actually trying to unmount.
+	 */
+	refcount_set(&sb->s_pending_errors, 1);
+}
+
+void fserror_unmount(struct super_block *sb)
+{
+	/*
+	 * If we don't drop the pending error count to zero, then wait for it
+	 * to drop below 1, which means that the pending errors cleared and
+	 * hopefully we didn't saturate with 1 billion+ concurrent events.
+	 */
+	if (!refcount_dec_and_test(&sb->s_pending_errors))
+		wait_var_event(&sb->s_pending_errors,
+			       refcount_read(&sb->s_pending_errors) < 1);
+}
+
+static inline void fserror_pending_dec(struct super_block *sb)
+{
+	if (refcount_dec_and_test(&sb->s_pending_errors))
+		wake_up_var(&sb->s_pending_errors);
+}
+
+static inline void fserror_free_event(struct fserror_event *event)
+{
+	fserror_pending_dec(event->sb);
+	mempool_free(event, &fserror_events_pool);
+}
+
+static void fserror_worker(struct work_struct *work)
+{
+	struct fserror_event *event =
+			container_of(work, struct fserror_event, work);
+	struct super_block *sb = event->sb;
+
+	if (sb->s_flags & SB_ACTIVE) {
+		struct fs_error_report report = {
+			/* send positive error number to userspace */
+			.error = -event->error,
+			.inode = event->inode,
+			.sb = event->sb,
+		};
+
+		if (sb->s_op->report_error)
+			sb->s_op->report_error(event);
+
+		fsnotify(FS_ERROR, &report, FSNOTIFY_EVENT_ERROR, NULL, NULL,
+			 NULL, 0);
+	}
+
+	iput(event->inode);
+	fserror_free_event(event);
+}
+
+static inline struct fserror_event *fserror_alloc_event(struct super_block *sb,
+							gfp_t gfp_flags)
+{
+	struct fserror_event *event = NULL;
+
+	/*
+	 * If pending_errors already reached zero or is no longer active,
+	 * the superblock is being deactivated so there's no point in
+	 * continuing.
+	 *
+	 * The order of the check of s_pending_errors and SB_ACTIVE are
+	 * mandated by order of accesses in generic_shutdown_super and
+	 * fserror_unmount.  Barriers are implicitly provided by the refcount
+	 * manipulations in this function and fserror_unmount.
+	 */
+	if (!refcount_inc_not_zero(&sb->s_pending_errors))
+		return NULL;
+	if (!(sb->s_flags & SB_ACTIVE))
+		goto out_pending;
+
+	event = mempool_alloc(&fserror_events_pool, gfp_flags);
+	if (!event)
+		goto out_pending;
+
+	/* mempool_alloc doesn't support GFP_ZERO */
+	memset(event, 0, sizeof(*event));
+	event->sb = sb;
+	INIT_WORK(&event->work, fserror_worker);
+
+	return event;
+
+out_pending:
+	fserror_pending_dec(sb);
+	return NULL;
+}
+
+/**
+ * fserror_report - report a filesystem error of some kind
+ *
+ * @sb:		superblock of the filesystem
+ * @inode:	inode within that filesystem, if applicable
+ * @type:	type of error encountered
+ * @pos:	start of inode range affected, if applicable
+ * @len:	length of inode range affected, if applicable
+ * @error:	error number encountered, must be negative
+ * @gfp:	memory allocation flags for conveying the event to a worker,
+ *		since this function can be called from atomic contexts
+ *
+ * Report details of a filesystem error to the super_operations::report_error
+ * callback if present; and to fsnotify for distribution to userspace.  @sb,
+ * @gfp, @type, and @error must all be specified.  For file I/O errors, the
+ * @inode, @pos, and @len fields must also be specified.  For file metadata
+ * errors, @inode must be specified.  If @inode is not NULL, then @inode->i_sb
+ * must point to @sb.
+ *
+ * Reporting work is deferred to a workqueue to ensure that ->report_error is
+ * called from process context without any locks held.  An active reference to
+ * the inode is maintained until event handling is complete, and unmount will
+ * wait for queued events to drain.
+ */
+void fserror_report(struct super_block *sb, struct inode *inode,
+		    enum fserror_type type, loff_t pos, u64 len, int error,
+		    gfp_t gfp)
+{
+	struct fserror_event *event;
+
+	/* sb and inode must be from the same filesystem */
+	WARN_ON_ONCE(inode && inode->i_sb != sb);
+
+	/* error number must be negative */
+	WARN_ON_ONCE(error >= 0);
+
+	event = fserror_alloc_event(sb, gfp);
+	if (!event)
+		goto lost;
+
+	event->type = type;
+	event->pos = pos;
+	event->len = len;
+	event->error = error;
+
+	/*
+	 * Can't iput from non-sleeping context, so grabbing another reference
+	 * to the inode must be the last thing before submitting the event.
+	 */
+	if (inode) {
+		event->inode = igrab(inode);
+		if (!event->inode)
+			goto lost_event;
+	}
+
+	/*
+	 * Use schedule_work here even if we're already in process context so
+	 * that fsnotify and super_operations::report_error implementations are
+	 * guaranteed to run in process context without any locks held.  Since
+	 * errors are supposed to be rare, the overhead shouldn't kill us any
+	 * more than the failing device will.
+	 */
+	schedule_work(&event->work);
+	return;
+
+lost_event:
+	fserror_free_event(event);
+lost:
+	if (inode)
+		pr_err_ratelimited(
+ "%s: lost file I/O error report for ino %lu type %u pos 0x%llx len 0x%llx error %d",
+		       sb->s_id, inode->i_ino, type, pos, len, error);
+	else
+		pr_err_ratelimited(
+ "%s: lost filesystem error report for type %u error %d",
+		       sb->s_id, type, error);
+}
+EXPORT_SYMBOL_GPL(fserror_report);
+
+static int __init fserror_init(void)
+{
+	return mempool_init_kmalloc_pool(&fserror_events_pool,
+					 FSERROR_DEFAULT_EVENT_POOL_SIZE,
+					 sizeof(struct fserror_event));
+}
+fs_initcall(fserror_init);
diff --git a/fs/super.c b/fs/super.c
index 3d85265d14001d..b13c1fd6a6f422 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -36,6 +36,7 @@
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
+#include <linux/fserror.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
@@ -363,6 +364,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	spin_lock_init(&s->s_inode_list_lock);
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
+	fserror_mount(s);
 
 	s->s_count = 1;
 	atomic_set(&s->s_active, 1);
@@ -622,6 +624,7 @@ void generic_shutdown_super(struct super_block *sb)
 		sync_filesystem(sb);
 		sb->s_flags &= ~SB_ACTIVE;
 
+		fserror_unmount(sb);
 		cgroup_writeback_umount(sb);
 
 		/* Evict all inodes with zero refcount. */


