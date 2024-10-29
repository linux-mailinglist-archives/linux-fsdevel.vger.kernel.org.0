Return-Path: <linux-fsdevel+bounces-33171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1289B568C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 00:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD4D2852DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 23:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1096320B1FB;
	Tue, 29 Oct 2024 23:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSKInQXB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A8B207A12;
	Tue, 29 Oct 2024 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243583; cv=none; b=ut3duUt6ZdJ81RfVu6II8oHbfiw1dJWAZ7lLhMf6TX92F2MWOp+uH9zSnxe9vh/WPARHzGt/5UC+I4IY3gnKfjeUJ+mE1GqFv1TUndWx9kiy8c5mQBAVbtqx3gcKwjIiodDmKxfzvtKgNWoGepOSZuFgVv5ffo91fsNlZVSk6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243583; c=relaxed/simple;
	bh=fFT1L9du/H1IVWZ0eDVHcXdOUhHiStUdXZ7+xMjkVO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmAGU1IfmrDH7OcFwujrLRoCPZxcwXXYHDJTL+qumEnRm9/RGr1p6e4OftHbJ189GevOglroKVvIXgzcn7UQZeBUVuMGhrCE1erWbhLIPjhGAqJyzr51A341nZ/XZVaihU2ys8Ch9877JGzET9teAQs02H/2efevltC1jH/GIjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSKInQXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0D4C4CEE3;
	Tue, 29 Oct 2024 23:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730243583;
	bh=fFT1L9du/H1IVWZ0eDVHcXdOUhHiStUdXZ7+xMjkVO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LSKInQXB7YJpOLtG1Sv30vmLc+NtVYkw8tEGdybzSf12xtX/ex5GI1tDuez+Kxxlm
	 3VUYh6R8bd7zR7smF77QzF4WMEYw4o45R7zORDAasjD20ZpI/0yPgtYRv2jGTIGiJD
	 62BoPiWkl4reYngRYcqsrTj7xodQSA2VIfXwjn225BuxipFFu4ZZW8GEOUUnzc3cqj
	 cKpK7rMi6VpKib8E+eHsOz8pdOH5oOJguz90e8i8eEJuvGUKVTu/deKpXhQNCcQoeU
	 oTDtfsJETJNPSIH2UjGNBhpSxITUMO8qz3wiYZMLvBYd/s64jhP6FD2p08t3WgqwSe
	 uPFbfWhEbrhcg==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	amir73il@gmail.com,
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	Song Liu <song@kernel.org>
Subject: [RFC bpf-next fanotify 1/5] fanotify: Introduce fanotify fastpath handler
Date: Tue, 29 Oct 2024 16:12:40 -0700
Message-ID: <20241029231244.2834368-2-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029231244.2834368-1-song@kernel.org>
References: <20241029231244.2834368-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fanotify fastpath handler enables handling fanotify events within the
kernel, and thus saves a trip to the user space. fanotify fastpath handler
can be useful in many use cases. For example, if a user is only interested
in events for some files in side a directory, a fastpath handler can be
used to filter out irrelevant events.

fanotify fastpath handler is attached to fsnotify_group. At most one
fastpath handler can be attached to a fsnotify_group. The attach/detach
of fastpath handlers are controlled by two new ioctls on the fanotify fds:
FAN_IOC_ADD_FP and FAN_IOC_DEL_FP.

fanotify fastpath handler is packaged in a kernel module. In the future,
it is also possible to package fastpath handler in a BPF program. Since
loading modules requires CAP_SYS_ADMIN, _loading_ fanotify fastpath
handler in kernel modules is limited to CAP_SYS_ADMIN. However,
non-SYS_CAP_ADMIN users can _attach_ fastpath handler loaded by sys admin
to their fanotify fds. To make fanotify fastpath handler more useful
for non-CAP_SYS_ADMIN users, a fastpath handler can take arguments at
attach time.

TODO: Add some mechanism to help users discover available fastpath
handlers. For example, we can add a sysctl which is similar to
net.ipv4.tcp_available_congestion_control, or we can add some sysfs
entries.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/notify/fanotify/Makefile            |   2 +-
 fs/notify/fanotify/fanotify.c          |  25 ++++
 fs/notify/fanotify/fanotify_fastpath.c | 171 +++++++++++++++++++++++++
 fs/notify/fanotify/fanotify_user.c     |   7 +
 include/linux/fanotify.h               |  45 +++++++
 include/linux/fsnotify_backend.h       |   3 +
 include/uapi/linux/fanotify.h          |  26 ++++
 7 files changed, 278 insertions(+), 1 deletion(-)
 create mode 100644 fs/notify/fanotify/fanotify_fastpath.c

diff --git a/fs/notify/fanotify/Makefile b/fs/notify/fanotify/Makefile
index 25ef222915e5..fddab88dde37 100644
--- a/fs/notify/fanotify/Makefile
+++ b/fs/notify/fanotify/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_FANOTIFY)		+= fanotify.o fanotify_user.o
+obj-$(CONFIG_FANOTIFY)		+= fanotify.o fanotify_user.o fanotify_fastpath.o
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 224bccaab4cc..a40ec06d0218 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -18,6 +18,8 @@
 
 #include "fanotify.h"
 
+extern struct srcu_struct fsnotify_mark_srcu;
+
 static bool fanotify_path_equal(const struct path *p1, const struct path *p2)
 {
 	return p1->mnt == p2->mnt && p1->dentry == p2->dentry;
@@ -888,6 +890,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	struct fsnotify_event *fsn_event;
 	__kernel_fsid_t fsid = {};
 	u32 match_mask = 0;
+	struct fanotify_fastpath_hook *fp_hook;
 
 	BUILD_BUG_ON(FAN_ACCESS != FS_ACCESS);
 	BUILD_BUG_ON(FAN_MODIFY != FS_MODIFY);
@@ -933,6 +936,25 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS))
 		fsid = fanotify_get_fsid(iter_info);
 
+	fp_hook = srcu_dereference(group->fanotify_data.fp_hook, &fsnotify_mark_srcu);
+	if (fp_hook) {
+		struct fanotify_fastpath_event fp_event = {
+			.mask = mask,
+			.data = data,
+			.data_type = data_type,
+			.dir = dir,
+			.file_name = file_name,
+			.fsid = &fsid,
+			.match_mask = match_mask,
+		};
+
+		ret = fp_hook->ops->fp_handler(group, fp_hook, &fp_event);
+		if (ret == FAN_FP_RET_SKIP_EVENT) {
+			ret = 0;
+			goto finish;
+		}
+	}
+
 	event = fanotify_alloc_event(group, mask, data, data_type, dir,
 				     file_name, &fsid, match_mask);
 	ret = -ENOMEM;
@@ -976,6 +998,9 @@ static void fanotify_free_group_priv(struct fsnotify_group *group)
 
 	if (mempool_initialized(&group->fanotify_data.error_events_pool))
 		mempool_exit(&group->fanotify_data.error_events_pool);
+
+	if (group->fanotify_data.fp_hook)
+		fanotify_fastpath_hook_free(group->fanotify_data.fp_hook);
 }
 
 static void fanotify_free_path_event(struct fanotify_event *event)
diff --git a/fs/notify/fanotify/fanotify_fastpath.c b/fs/notify/fanotify/fanotify_fastpath.c
new file mode 100644
index 000000000000..0453a1ac25b1
--- /dev/null
+++ b/fs/notify/fanotify/fanotify_fastpath.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/fanotify.h>
+#include <linux/module.h>
+
+#include "fanotify.h"
+
+extern struct srcu_struct fsnotify_mark_srcu;
+
+static DEFINE_SPINLOCK(fp_list_lock);
+static LIST_HEAD(fp_list);
+
+static struct fanotify_fastpath_ops *fanotify_fastpath_find(const char *name)
+{
+	struct fanotify_fastpath_ops *ops;
+
+	list_for_each_entry(ops, &fp_list, list) {
+		if (!strcmp(ops->name, name))
+			return ops;
+	}
+	return NULL;
+}
+
+
+/*
+ * fanotify_fastpath_register - Register a new fastpath handler.
+ *
+ * Add a fastpath handler to the fp_list. These fastpath handlers are
+ * available for all users in the system.
+ *
+ * @ops:	pointer to fanotify_fastpath_ops to add.
+ *
+ * Returns:
+ *	0	- on success;
+ *	-EEXIST	- fastpath handler of the same name already exists.
+ */
+int fanotify_fastpath_register(struct fanotify_fastpath_ops *ops)
+{
+	spin_lock(&fp_list_lock);
+	if (fanotify_fastpath_find(ops->name)) {
+		/* cannot register two handlers with the same name */
+		spin_unlock(&fp_list_lock);
+		return -EEXIST;
+	}
+	list_add_tail(&ops->list, &fp_list);
+	spin_unlock(&fp_list_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fanotify_fastpath_register);
+
+/*
+ * fanotify_fastpath_unregister - Unregister a new fastpath handler.
+ *
+ * Remove a fastpath handler from fp_list.
+ *
+ * @ops:	pointer to fanotify_fastpath_ops to remove.
+ */
+void fanotify_fastpath_unregister(struct fanotify_fastpath_ops *ops)
+{
+	spin_lock(&fp_list_lock);
+	list_del_init(&ops->list);
+	spin_unlock(&fp_list_lock);
+}
+EXPORT_SYMBOL_GPL(fanotify_fastpath_unregister);
+
+/*
+ * fanotify_fastpath_add - Add a fastpath handler to fsnotify_group.
+ *
+ * Add a fastpath handler from fp_list to a fsnotify_group.
+ *
+ * @group:	fsnotify_group that will have add
+ * @argp:	fanotify_fastpath_args that specifies the fastpath handler
+ *		and the init arguments of the fastpath handler.
+ *
+ * Returns:
+ *	0	- on success;
+ *	-EEXIST	- fastpath handler of the same name already exists.
+ */
+int fanotify_fastpath_add(struct fsnotify_group *group,
+			  struct fanotify_fastpath_args __user *argp)
+{
+	struct fanotify_fastpath_hook *fp_hook;
+	struct fanotify_fastpath_ops *fp_ops;
+	struct fanotify_fastpath_args args;
+	int ret = 0;
+
+	ret = copy_from_user(&args, argp, sizeof(args));
+	if (ret)
+		return -EFAULT;
+
+	if (args.version != 1 || args.flags || args.init_args_len > FAN_FP_ARGS_MAX)
+		return -EINVAL;
+
+	args.name[FAN_FP_NAME_MAX - 1] = '\0';
+
+	fsnotify_group_lock(group);
+
+	if (rcu_access_pointer(group->fanotify_data.fp_hook)) {
+		fsnotify_group_unlock(group);
+		return -EBUSY;
+	}
+
+	fp_hook = kzalloc(sizeof(*fp_hook), GFP_KERNEL);
+	if (!fp_hook) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	spin_lock(&fp_list_lock);
+	fp_ops = fanotify_fastpath_find(args.name);
+	if (!fp_ops || !try_module_get(fp_ops->owner)) {
+		spin_unlock(&fp_list_lock);
+		ret = -ENOENT;
+		goto err_free_hook;
+	}
+	spin_unlock(&fp_list_lock);
+
+	if (fp_ops->fp_init) {
+		char *init_args = NULL;
+
+		if (args.init_args_len) {
+			init_args = strndup_user(u64_to_user_ptr(args.init_args),
+						 args.init_args_len);
+			if (IS_ERR(init_args)) {
+				ret = PTR_ERR(init_args);
+				if (ret == -EINVAL)
+					ret = -E2BIG;
+				goto err_module_put;
+			}
+		}
+		ret = fp_ops->fp_init(fp_hook, init_args);
+		kfree(init_args);
+		if (ret)
+			goto err_module_put;
+	}
+	fp_hook->ops = fp_ops;
+	rcu_assign_pointer(group->fanotify_data.fp_hook, fp_hook);
+
+out:
+	fsnotify_group_unlock(group);
+	return ret;
+
+err_module_put:
+	module_put(fp_ops->owner);
+err_free_hook:
+	kfree(fp_hook);
+	goto out;
+}
+
+void fanotify_fastpath_hook_free(struct fanotify_fastpath_hook *fp_hook)
+{
+	if (fp_hook->ops->fp_free)
+		fp_hook->ops->fp_free(fp_hook);
+
+	module_put(fp_hook->ops->owner);
+}
+
+void fanotify_fastpath_del(struct fsnotify_group *group)
+{
+	struct fanotify_fastpath_hook *fp_hook;
+
+	fsnotify_group_lock(group);
+	fp_hook = group->fanotify_data.fp_hook;
+	if (!fp_hook)
+		goto out;
+
+	rcu_assign_pointer(group->fanotify_data.fp_hook, NULL);
+	fanotify_fastpath_hook_free(fp_hook);
+
+out:
+	fsnotify_group_unlock(group);
+}
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 8e2d43fc6f7c..e96cb83f8409 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -987,6 +987,13 @@ static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 		spin_unlock(&group->notification_lock);
 		ret = put_user(send_len, (int __user *) p);
 		break;
+	case FAN_IOC_ADD_FP:
+		ret = fanotify_fastpath_add(group, p);
+		break;
+	case FAN_IOC_DEL_FP:
+		fanotify_fastpath_del(group);
+		ret = 0;
+		break;
 	}
 
 	return ret;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 89ff45bd6f01..cea95307a580 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -136,4 +136,49 @@
 #undef FAN_ALL_PERM_EVENTS
 #undef FAN_ALL_OUTGOING_EVENTS
 
+struct fsnotify_group;
+struct qstr;
+struct inode;
+struct fanotify_fastpath_hook;
+
+struct fanotify_fastpath_event {
+	u32 mask;
+	const void *data;
+	int data_type;
+	struct inode *dir;
+	const struct qstr *file_name;
+	__kernel_fsid_t *fsid;
+	u32 match_mask;
+};
+
+struct fanotify_fastpath_ops {
+	int (*fp_handler)(struct fsnotify_group *group,
+			  struct fanotify_fastpath_hook *fp_hook,
+			  struct fanotify_fastpath_event *fp_event);
+	int (*fp_init)(struct fanotify_fastpath_hook *hook, const char *args);
+	void (*fp_free)(struct fanotify_fastpath_hook *hook);
+
+	char name[FAN_FP_NAME_MAX];
+	struct module *owner;
+	struct list_head list;
+	int flags;
+};
+
+enum fanotify_fastpath_return {
+	FAN_FP_RET_SEND_TO_USERSPACE = 0,
+	FAN_FP_RET_SKIP_EVENT = 1,
+};
+
+struct fanotify_fastpath_hook {
+	struct fanotify_fastpath_ops *ops;
+	void *data;
+};
+
+int fanotify_fastpath_register(struct fanotify_fastpath_ops *ops);
+void fanotify_fastpath_unregister(struct fanotify_fastpath_ops *ops);
+int fanotify_fastpath_add(struct fsnotify_group *group,
+			  struct fanotify_fastpath_args __user *args);
+void fanotify_fastpath_del(struct fsnotify_group *group);
+void fanotify_fastpath_hook_free(struct fanotify_fastpath_hook *fp_hook);
+
 #endif /* _LINUX_FANOTIFY_H */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 3ecf7768e577..ef251b4e4e6f 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -117,6 +117,7 @@ struct fsnotify_fname;
 struct fsnotify_iter_info;
 
 struct mem_cgroup;
+struct fanotify_fastpath_hook;
 
 /*
  * Each group much define these ops.  The fsnotify infrastructure will call
@@ -255,6 +256,8 @@ struct fsnotify_group {
 			int f_flags; /* event_f_flags from fanotify_init() */
 			struct ucounts *ucounts;
 			mempool_t error_events_pool;
+
+			struct fanotify_fastpath_hook __rcu *fp_hook;
 		} fanotify_data;
 #endif /* CONFIG_FANOTIFY */
 	};
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 34f221d3a1b9..9c30baeebae0 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -3,6 +3,7 @@
 #define _UAPI_LINUX_FANOTIFY_H
 
 #include <linux/types.h>
+#include <linux/ioctl.h>
 
 /* the following events that user-space can register for */
 #define FAN_ACCESS		0x00000001	/* File was accessed */
@@ -243,4 +244,29 @@ struct fanotify_response_info_audit_rule {
 				(long)(meta)->event_len >= (long)FAN_EVENT_METADATA_LEN && \
 				(long)(meta)->event_len <= (long)(len))
 
+#define FAN_FP_NAME_MAX 64
+#define FAN_FP_ARGS_MAX 1024
+
+/* This is the arguments used to add fastpath handler to a group. */
+struct fanotify_fastpath_args {
+	/* user space pointer to the name of fastpath handler */
+	char name[FAN_FP_NAME_MAX];
+
+	__u32 version;
+	__u32 flags;
+
+	/*
+	 * user space pointer to the init args of fastpath handler,
+	 * up to init_args_len (<= FAN_FP_ARGS_MAX).
+	 */
+	__u64 init_args;
+	/* length of init_args */
+	__u32 init_args_len;
+} __attribute__((__packed__));
+
+#define FAN_IOC_MAGIC 'F'
+
+#define FAN_IOC_ADD_FP _IOW(FAN_IOC_MAGIC, 0, struct fanotify_fastpath_args)
+#define FAN_IOC_DEL_FP _IOW(FAN_IOC_MAGIC, 1, char[FAN_FP_NAME_MAX])
+
 #endif /* _UAPI_LINUX_FANOTIFY_H */
-- 
2.43.5


