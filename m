Return-Path: <linux-fsdevel+bounces-35614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 896019D662B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 00:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4195B23DD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 23:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB231CFEB5;
	Fri, 22 Nov 2024 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zch9RVE2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580FA189BB1;
	Fri, 22 Nov 2024 23:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732316423; cv=none; b=oTcIVNdUypzUdEvJW7OQjyrxPOoJA/mW3Gykt7cxIVVcVK2w25wqN1+MiDFVEwiiQmI/XPv1JQuDRnNcy6S6JuDwD6M02HL+4AZ2PeX/YURJvuqXX0DGIR6BUYptefuIrg3f07myiiki/Rx2vS8JD45849CSvoeaLFA+fsNu5Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732316423; c=relaxed/simple;
	bh=xVMvNTreNsiSf+Oi2YWprRrxP/bmGcPLFx+HgKedbeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeUyhYbZq+SC1LEwir9A6WBb3/MFsh1GOpQjgG+acsrNGWVsq3XT1OVuqKgQZTSUby/1jWTcGbXPjmyu+BTm0drV9g1bbtqIVeW9+Q0QLBoKATj7//4K22OauL/Ofuoojg3iQkZGuN1523QLIq4/X1zfZGKNuUd4sNBPfet0HS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zch9RVE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60C9C4CECE;
	Fri, 22 Nov 2024 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732316422;
	bh=xVMvNTreNsiSf+Oi2YWprRrxP/bmGcPLFx+HgKedbeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zch9RVE2KKddFuu/5uZMwb2QORRzfEro6aSr1lCgM+0Mch4T6zeYZ6C99OJ/Av7cD
	 5+fK8NugnTlWrl8pX04WdL2AP2xBe4bqsuX8jF4gu7SK73MjWUpipRMeqefkSxmAia
	 RAe+PFrijVPg4fskc7v9OG3RJPnnFgpFeEb2Tfoac9D1z/2iEBF79qgYdTtwL0ScNc
	 iWGrz5DcrAdBM8/9A11RgwUrKW4l1eqpiCzLCeEBUTpk4/JCEiAkUfGxfv1nQbfds7
	 dhzGvkGdruLfoPayjNp8GypWc7OgFwncLsrXlblOAl+QofHy5X28Sn+VVj5loRIy+U
	 +sHotx7Z6h5Nw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
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
	mic@digikod.net,
	gnoack@google.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 fanotify 1/2] fanotify: Introduce fanotify filter
Date: Fri, 22 Nov 2024 14:59:57 -0800
Message-ID: <20241122225958.1775625-2-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241122225958.1775625-1-song@kernel.org>
References: <20241122225958.1775625-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fanotify filter enables handling fanotify events within the kernel, and
thus saves a trip to the user space. fanotify filter can be useful in
many use cases. For example, if a user is only interested in events for
some files in side a directory, a filter can be used to filter out
irrelevant events.

fanotify filter is attached to fsnotify_group. At most one filter can
be attached to a fsnotify_group. The attach/detach of filter are
controlled by two new ioctls on the fanotify fds: FAN_IOC_ADD_FILTER
and FAN_IOC_DEL_FILTER.

fanotify filter is packaged in a kernel module. In the future, it is
also possible to package fanotify filter in a BPF program. Since loading
modules requires CAP_SYS_ADMIN, _loading_ fanotify filter in kernel
modules is limited to CAP_SYS_ADMIN. However, non-SYS_CAP_ADMIN users
can _attach_ filter loaded by sys admin to their fanotify fds. The owner
of the fanotify fitler can use flag FAN_FILTER_F_SYS_ADMIN_ONLY to
make a filter available only to users with CAP_SYS_ADMIN.

To make fanotify filters more flexible, a filter can take arguments at
attach time.

sysfs entry /sys/kernel/fanotify_filter is added to help users know
which fanotify filters are available. At the moment, these files are
added for each filter: flags, desc, and init_args.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/notify/fanotify/Kconfig           |  13 ++
 fs/notify/fanotify/Makefile          |   1 +
 fs/notify/fanotify/fanotify.c        |  44 +++-
 fs/notify/fanotify/fanotify_filter.c | 289 +++++++++++++++++++++++++++
 fs/notify/fanotify/fanotify_user.c   |   7 +
 include/linux/fanotify.h             | 128 ++++++++++++
 include/linux/fsnotify_backend.h     |   6 +-
 include/uapi/linux/fanotify.h        |  36 ++++
 8 files changed, 520 insertions(+), 4 deletions(-)
 create mode 100644 fs/notify/fanotify/fanotify_filter.c

diff --git a/fs/notify/fanotify/Kconfig b/fs/notify/fanotify/Kconfig
index 0e36aaf379b7..abfd59d95f49 100644
--- a/fs/notify/fanotify/Kconfig
+++ b/fs/notify/fanotify/Kconfig
@@ -24,3 +24,16 @@ config FANOTIFY_ACCESS_PERMISSIONS
 	   hierarchical storage management systems.
 
 	   If unsure, say N.
+
+config FANOTIFY_FILTER
+	bool "fanotify in kernel filter"
+	depends on FANOTIFY
+	default y
+	help
+	   Say Y here if you want to use fanotify in kernel filter.
+	   The filter can be implemented in a kernel module or a
+	   BPF program. The filter can speed up fanotify in many
+	   use cases. For example, when the listener is only interested in
+	   a subset of events.
+
+	   If unsure, say Y.
\ No newline at end of file
diff --git a/fs/notify/fanotify/Makefile b/fs/notify/fanotify/Makefile
index 25ef222915e5..d95ec0aeffb5 100644
--- a/fs/notify/fanotify/Makefile
+++ b/fs/notify/fanotify/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_FANOTIFY)		+= fanotify.o fanotify_user.o
+obj-$(CONFIG_FANOTIFY_FILTER)	+= fanotify_filter.o
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 224bccaab4cc..c70184cd2d45 100644
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
+	struct fanotify_filter_hook *filter_hook __maybe_unused;
 
 	BUILD_BUG_ON(FAN_ACCESS != FS_ACCESS);
 	BUILD_BUG_ON(FAN_MODIFY != FS_MODIFY);
@@ -921,6 +924,39 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	pr_debug("%s: group=%p mask=%x report_mask=%x\n", __func__,
 		 group, mask, match_mask);
 
+	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS))
+		fsid = fanotify_get_fsid(iter_info);
+
+#ifdef CONFIG_FANOTIFY_FILTER
+	filter_hook = srcu_dereference(group->fanotify_data.filter_hook, &fsnotify_mark_srcu);
+	if (filter_hook) {
+		struct fanotify_filter_event filter_event = {
+			.mask = mask,
+			.data = data,
+			.data_type = data_type,
+			.dir = dir,
+			.file_name = file_name,
+			.fsid = &fsid,
+			.match_mask = match_mask,
+		};
+
+		ret = filter_hook->ops->filter(group, filter_hook, &filter_event);
+
+		/*
+		 * The filter may return
+		 * - FAN_FILTER_RET_SEND_TO_USERSPACE => continue the rest;
+		 * - FAN_FILTER_RET_SKIP_EVENT => return 0 now;
+		 * - < 0 error => return error now.
+		 *
+		 * For the latter two cases, we can just return ret.
+		 */
+		BUILD_BUG_ON(FAN_FILTER_RET_SKIP_EVENT != 0);
+
+		if (ret != FAN_FILTER_RET_SEND_TO_USERSPACE)
+			return ret;
+	}
+#endif
+
 	if (fanotify_is_perm_event(mask)) {
 		/*
 		 * fsnotify_prepare_user_wait() fails if we race with mark
@@ -930,9 +966,6 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 			return 0;
 	}
 
-	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS))
-		fsid = fanotify_get_fsid(iter_info);
-
 	event = fanotify_alloc_event(group, mask, data, data_type, dir,
 				     file_name, &fsid, match_mask);
 	ret = -ENOMEM;
@@ -976,6 +1009,11 @@ static void fanotify_free_group_priv(struct fsnotify_group *group)
 
 	if (mempool_initialized(&group->fanotify_data.error_events_pool))
 		mempool_exit(&group->fanotify_data.error_events_pool);
+
+#ifdef CONFIG_FANOTIFY_FILTER
+	if (group->fanotify_data.filter_hook)
+		fanotify_filter_hook_free(group->fanotify_data.filter_hook);
+#endif
 }
 
 static void fanotify_free_path_event(struct fanotify_event *event)
diff --git a/fs/notify/fanotify/fanotify_filter.c b/fs/notify/fanotify/fanotify_filter.c
new file mode 100644
index 000000000000..9215612e2fcb
--- /dev/null
+++ b/fs/notify/fanotify/fanotify_filter.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/fanotify.h>
+#include <linux/kobject.h>
+#include <linux/module.h>
+
+#include "fanotify.h"
+
+extern struct srcu_struct fsnotify_mark_srcu;
+
+static DEFINE_SPINLOCK(filter_list_lock);
+static LIST_HEAD(filter_list);
+
+static struct kobject *fan_filter_root_kobj;
+
+static struct {
+	enum fanotify_filter_flags flag;
+	const char *name;
+} fanotify_filter_flags_names[] = {
+	{
+		.flag = FAN_FILTER_F_SYS_ADMIN_ONLY,
+		.name = "SYS_ADMIN_ONLY",
+	}
+};
+
+static ssize_t flags_show(struct kobject *kobj,
+			  struct kobj_attribute *attr, char *buf)
+{
+	struct fanotify_filter_ops *ops;
+	ssize_t len = 0;
+	int i;
+
+	ops = container_of(kobj, struct fanotify_filter_ops, kobj);
+	for (i = 0; i < ARRAY_SIZE(fanotify_filter_flags_names); i++) {
+		if (ops->flags & fanotify_filter_flags_names[i].flag) {
+			len += sysfs_emit_at(buf, len, "%s%s", len ? " " : "",
+					     fanotify_filter_flags_names[i].name);
+		}
+	}
+	len += sysfs_emit_at(buf, len, "\n");
+	return len;
+}
+
+static ssize_t desc_show(struct kobject *kobj,
+			 struct kobj_attribute *attr, char *buf)
+{
+	struct fanotify_filter_ops *ops;
+
+	ops = container_of(kobj, struct fanotify_filter_ops, kobj);
+
+	return sysfs_emit(buf, "%s\n", ops->desc ?: "N/A");
+}
+
+static ssize_t init_args_show(struct kobject *kobj,
+			      struct kobj_attribute *attr, char *buf)
+{
+	struct fanotify_filter_ops *ops;
+
+	ops = container_of(kobj, struct fanotify_filter_ops, kobj);
+
+	return sysfs_emit(buf, "%s\n", ops->init_args ?: "N/A");
+}
+
+static struct kobj_attribute flags_kobj_attr = __ATTR_RO(flags);
+static struct kobj_attribute desc_kobj_attr = __ATTR_RO(desc);
+static struct kobj_attribute init_args_kobj_attr = __ATTR_RO(init_args);
+
+static struct attribute *fan_filter_attrs[] = {
+	&flags_kobj_attr.attr,
+	&desc_kobj_attr.attr,
+	&init_args_kobj_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(fan_filter);
+
+static void fan_filter_kobj_release(struct kobject *kobj)
+{
+}
+
+static const struct kobj_type fan_filter_ktype = {
+	.release = fan_filter_kobj_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = fan_filter_groups,
+};
+
+static struct fanotify_filter_ops *fanotify_filter_find(const char *name)
+{
+	struct fanotify_filter_ops *ops;
+
+	list_for_each_entry(ops, &filter_list, list) {
+		if (!strcmp(ops->name, name))
+			return ops;
+	}
+	return NULL;
+}
+
+static void __fanotify_filter_unregister(struct fanotify_filter_ops *ops)
+{
+	spin_lock(&filter_list_lock);
+	list_del_init(&ops->list);
+	spin_unlock(&filter_list_lock);
+}
+
+/*
+ * fanotify_filter_register - Register a new filter.
+ *
+ * Add a filter to the filter_list. These filter are
+ * available for all users in the system.
+ *
+ * @ops:	pointer to fanotify_filter_ops to add.
+ *
+ * Returns:
+ *	0	- on success;
+ *	-EEXIST	- filter of the same name already exists.
+ *	-ENODEV	- fanotify filter was not properly initialized.
+ */
+int fanotify_filter_register(struct fanotify_filter_ops *ops)
+{
+	int ret;
+
+	if (!fan_filter_root_kobj)
+		return -ENODEV;
+
+	spin_lock(&filter_list_lock);
+	if (fanotify_filter_find(ops->name)) {
+		/* cannot register two filters with the same name */
+		spin_unlock(&filter_list_lock);
+		return -EEXIST;
+	}
+	list_add_tail(&ops->list, &filter_list);
+	spin_unlock(&filter_list_lock);
+
+
+	kobject_init(&ops->kobj, &fan_filter_ktype);
+	ret = kobject_add(&ops->kobj, fan_filter_root_kobj, "%s", ops->name);
+	if (ret) {
+		__fanotify_filter_unregister(ops);
+		return ret;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fanotify_filter_register);
+
+/*
+ * fanotify_filter_unregister - Unregister a new filter.
+ *
+ * Remove a filter from filter_list.
+ *
+ * @ops:	pointer to fanotify_filter_ops to remove.
+ */
+void fanotify_filter_unregister(struct fanotify_filter_ops *ops)
+{
+	kobject_put(&ops->kobj);
+	__fanotify_filter_unregister(ops);
+}
+EXPORT_SYMBOL_GPL(fanotify_filter_unregister);
+
+/*
+ * fanotify_filter_add - Add a filter to fsnotify_group.
+ *
+ * Add a filter from filter_list to a fsnotify_group.
+ *
+ * @group:	fsnotify_group that will have add
+ * @argp:	fanotify_filter_args that specifies the filter
+ *		and the init arguments of the filter.
+ *
+ * Returns:
+ *	0	- on success;
+ *	-EEXIST	- filter of the same name already exists.
+ */
+int fanotify_filter_add(struct fsnotify_group *group,
+			struct fanotify_filter_args __user *argp)
+{
+	struct fanotify_filter_hook *filter_hook;
+	struct fanotify_filter_ops *filter_ops;
+	struct fanotify_filter_args args;
+	void *init_args = NULL;
+	int ret = 0;
+
+	ret = copy_from_user(&args, argp, sizeof(args));
+	if (ret)
+		return -EFAULT;
+
+	if (args.init_args_size > FAN_FILTER_ARGS_MAX)
+		return -EINVAL;
+
+	args.name[FAN_FILTER_NAME_MAX - 1] = '\0';
+
+	fsnotify_group_lock(group);
+
+	if (rcu_access_pointer(group->fanotify_data.filter_hook)) {
+		fsnotify_group_unlock(group);
+		return -EBUSY;
+	}
+
+	filter_hook = kzalloc(sizeof(*filter_hook), GFP_KERNEL);
+	if (!filter_hook) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	spin_lock(&filter_list_lock);
+	filter_ops = fanotify_filter_find(args.name);
+	if (!filter_ops || !try_module_get(filter_ops->owner)) {
+		spin_unlock(&filter_list_lock);
+		ret = -ENOENT;
+		goto err_free_hook;
+	}
+	spin_unlock(&filter_list_lock);
+
+	if (!capable(CAP_SYS_ADMIN) && (filter_ops->flags & FAN_FILTER_F_SYS_ADMIN_ONLY)) {
+		ret = -EPERM;
+		goto err_module_put;
+	}
+
+	if (filter_ops->filter_init) {
+		if (args.init_args_size != filter_ops->init_args_size) {
+			ret = -EINVAL;
+			goto err_module_put;
+		}
+		if (args.init_args_size) {
+			init_args = kzalloc(args.init_args_size, GFP_KERNEL);
+			if (!init_args) {
+				ret = -ENOMEM;
+				goto err_module_put;
+			}
+			if (copy_from_user(init_args, (void __user *)args.init_args,
+					   args.init_args_size)) {
+				ret = -EFAULT;
+				goto err_free_args;
+			}
+
+		}
+		ret = filter_ops->filter_init(group, filter_hook, init_args);
+		if (ret)
+			goto err_free_args;
+		kfree(init_args);
+	}
+	filter_hook->ops = filter_ops;
+	rcu_assign_pointer(group->fanotify_data.filter_hook, filter_hook);
+
+out:
+	fsnotify_group_unlock(group);
+	return ret;
+
+err_free_args:
+	kfree(init_args);
+err_module_put:
+	module_put(filter_ops->owner);
+err_free_hook:
+	kfree(filter_hook);
+	goto out;
+}
+
+void fanotify_filter_hook_free(struct fanotify_filter_hook *filter_hook)
+{
+	if (filter_hook->ops->filter_free)
+		filter_hook->ops->filter_free(filter_hook);
+
+	module_put(filter_hook->ops->owner);
+	kfree(filter_hook);
+}
+
+/*
+ * fanotify_filter_del - Delete a filter from fsnotify_group.
+ */
+void fanotify_filter_del(struct fsnotify_group *group)
+{
+	struct fanotify_filter_hook *filter_hook;
+
+	fsnotify_group_lock(group);
+	filter_hook = group->fanotify_data.filter_hook;
+	if (!filter_hook)
+		goto out;
+
+	rcu_assign_pointer(group->fanotify_data.filter_hook, NULL);
+	fanotify_filter_hook_free(filter_hook);
+
+out:
+	fsnotify_group_unlock(group);
+}
+
+static int __init fanotify_filter_init(void)
+{
+	fan_filter_root_kobj = kobject_create_and_add("fanotify_filter", kernel_kobj);
+	if (!fan_filter_root_kobj)
+		return -ENOMEM;
+	return 0;
+}
+device_initcall(fanotify_filter_init);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 8e2d43fc6f7c..6445256541d2 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -987,6 +987,13 @@ static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 		spin_unlock(&group->notification_lock);
 		ret = put_user(send_len, (int __user *) p);
 		break;
+	case FAN_IOC_ADD_FILTER:
+		ret = fanotify_filter_add(group, p);
+		break;
+	case FAN_IOC_DEL_FILTER:
+		fanotify_filter_del(group);
+		ret = 0;
+		break;
 	}
 
 	return ret;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 89ff45bd6f01..d3d9af81d2c5 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_FANOTIFY_H
 #define _LINUX_FANOTIFY_H
 
+#include <linux/kobject.h>
 #include <linux/sysctl.h>
 #include <uapi/linux/fanotify.h>
 
@@ -136,4 +137,131 @@
 #undef FAN_ALL_PERM_EVENTS
 #undef FAN_ALL_OUTGOING_EVENTS
 
+struct fsnotify_group;
+struct qstr;
+struct inode;
+struct fanotify_filter_hook;
+
+/*
+ * Event passed to fanotify filter
+ *
+ * @mask:	event type and flags
+ * @data:	object that event happened on
+ * @data_type:	type of object for fanotify_data_XXX() accessors
+ * @dir:	optional directory associated with event -
+ *		if @file_name is not NULL, this is the directory that
+ *		@file_name is relative to
+ * @file_name:	optional file name associated with event
+ * @match_mask:	mark types of this group that matched the event
+ */
+struct fanotify_filter_event {
+	u32 mask;
+	const void *data;
+	int data_type;
+	struct inode *dir;
+	const struct qstr *file_name;
+	__kernel_fsid_t *fsid;
+	u32 match_mask;
+};
+
+/*
+ * fanotify filter should implement these ops.
+ *
+ * filter - Main call for the filter.
+ * @group:	The group being notified
+ * @filter_hook:	fanotify_filter_hook for the attach on @group.
+ * Returns: enum fanotify_filter_return.
+ *
+ * filter_init - Initialize the fanotify_filter_hook.
+ * @group:	The group that getting the filter
+ * @hook:	fanotify_filter_hook to be initialized
+ * @args:	Arguments used to initialize @hook
+ *
+ * filter_free - Free the fanotify_filter_hook.
+ * @hook:	fanotify_filter_hook to be freed.
+ *
+ * @name:	Name of the fanotify_filter_ops. This need to be unique
+ *		in the system
+ * @owner:	Owner module of this fanotify_filter_ops
+ * @list:	Attach to global list of fanotify_filter_ops
+ * @flags:	Flags for the fanotify_filter_ops
+ * @init_args_size: expected size of @args of filter_init()
+ * @desc:	Description of what this filter do (optional)
+ * @init_args:	Description of the init_args in a string (optional)
+ */
+struct fanotify_filter_ops {
+	int (*filter)(struct fsnotify_group *group,
+		      struct fanotify_filter_hook *filter_hook,
+		      struct fanotify_filter_event *filter_event);
+	int (*filter_init)(struct fsnotify_group *group,
+			   struct fanotify_filter_hook *hook,
+			   void *args);
+	void (*filter_free)(struct fanotify_filter_hook *hook);
+
+	char name[FAN_FILTER_NAME_MAX];
+	struct module *owner;
+	struct list_head list;
+	u32 flags;
+	u32 init_args_size;
+	const char *desc;
+	const char *init_args;
+
+	/* internal */
+	struct kobject kobj;
+};
+
+/* Flags for fanotify_filter_ops->flags */
+enum fanotify_filter_flags {
+	/* CAP_SYS_ADMIN is required to use this filter */
+	FAN_FILTER_F_SYS_ADMIN_ONLY = BIT(0),
+
+	FAN_FILTER_F_ALL = FAN_FILTER_F_SYS_ADMIN_ONLY,
+};
+
+/*
+ * Hook that attaches fanotify_filter_ops to a group.
+ * @ops:	the ops
+ * @data:	per group data used by the ops
+ */
+struct fanotify_filter_hook {
+	struct fanotify_filter_ops *ops;
+	void *data;
+};
+
+#ifdef CONFIG_FANOTIFY_FILTER
+
+int fanotify_filter_register(struct fanotify_filter_ops *ops);
+void fanotify_filter_unregister(struct fanotify_filter_ops *ops);
+int fanotify_filter_add(struct fsnotify_group *group,
+			struct fanotify_filter_args __user *args);
+void fanotify_filter_del(struct fsnotify_group *group);
+void fanotify_filter_hook_free(struct fanotify_filter_hook *filter_hook);
+
+#else /* CONFIG_FANOTIFY_FILTER */
+
+static inline int fanotify_filter_register(struct fanotify_filter_ops *ops)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void fanotify_filter_unregister(struct fanotify_filter_ops *ops)
+{
+}
+
+static inline int fanotify_filter_add(struct fsnotify_group *group,
+				      struct fanotify_filter_args __user *args)
+{
+	return -ENOENT;
+}
+
+static inline void fanotify_filter_del(struct fsnotify_group *group)
+{
+}
+
+static inline void fanotify_filter_hook_free(struct fanotify_filter_hook *filter_hook)
+{
+}
+
+#endif /* CONFIG_FANOTIFY_FILTER */
+
 #endif /* _LINUX_FANOTIFY_H */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 3ecf7768e577..8cc2d6f737a6 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -117,6 +117,7 @@ struct fsnotify_fname;
 struct fsnotify_iter_info;
 
 struct mem_cgroup;
+struct fanotify_filter_hook;
 
 /*
  * Each group much define these ops.  The fsnotify infrastructure will call
@@ -255,8 +256,11 @@ struct fsnotify_group {
 			int f_flags; /* event_f_flags from fanotify_init() */
 			struct ucounts *ucounts;
 			mempool_t error_events_pool;
+#ifdef CONFIG_FANOTIFY_FILTER
+			struct fanotify_filter_hook __rcu *filter_hook;
+#endif /* CONFIG_FANOTIFY_FILTER */
 		} fanotify_data;
-#endif /* CONFIG_FANOTIFY */
+#endif
 	};
 };
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 34f221d3a1b9..33fd493558c3 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -3,6 +3,7 @@
 #define _UAPI_LINUX_FANOTIFY_H
 
 #include <linux/types.h>
+#include <linux/ioctl.h>
 
 /* the following events that user-space can register for */
 #define FAN_ACCESS		0x00000001	/* File was accessed */
@@ -243,4 +244,39 @@ struct fanotify_response_info_audit_rule {
 				(long)(meta)->event_len >= (long)FAN_EVENT_METADATA_LEN && \
 				(long)(meta)->event_len <= (long)(len))
 
+/*
+ * fanotify filter.
+ * Please check out include/linux/fanotify.h for more information about
+ * the kernel module API.
+ */
+
+/* Return value of filter */
+enum fanotify_filter_return {
+	/* The event should NOT be sent to user space */
+	FAN_FILTER_RET_SKIP_EVENT = 0,
+	/* The event should be sent to user space */
+	FAN_FILTER_RET_SEND_TO_USERSPACE = 1,
+};
+
+#define FAN_FILTER_NAME_MAX 64
+#define FAN_FILTER_ARGS_MAX 64
+
+/* This is the arguments used to add filter to a group. */
+struct fanotify_filter_args {
+	char name[FAN_FILTER_NAME_MAX];
+
+	/*
+	 * user space pointer to the init args of filter,
+	 * up to init_args_len (<= FAN_FILTER_ARGS_MAX).
+	 */
+	__u64 init_args;
+	/* size of init_args */
+	__u32 init_args_size;
+} __attribute__((__packed__));
+
+#define FAN_IOC_MAGIC 'F'
+
+#define FAN_IOC_ADD_FILTER _IOW(FAN_IOC_MAGIC, 0, struct fanotify_filter_args)
+#define FAN_IOC_DEL_FILTER _IOW(FAN_IOC_MAGIC, 1, char[FAN_FILTER_NAME_MAX])
+
 #endif /* _UAPI_LINUX_FANOTIFY_H */
-- 
2.43.5


