Return-Path: <linux-fsdevel+bounces-34741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C0B9C8500
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 09:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42BFB1F215A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 08:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD48D1F76DF;
	Thu, 14 Nov 2024 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPKuOCU1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11354E573;
	Thu, 14 Nov 2024 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731573850; cv=none; b=WVynjhWhbO4QNtBiUQxJONDklv2rhp+dntYpqlj3AHE/lb13fSRd4kiDs6x1LdD5zjXSNmC897ap441Lvergfik1f7XYtHY3KGYfWtMvei3eZuHFcVudR76MtsCK8F4361+TwwENn47dUqMO3ziYIFoi0J6RZkL/uhVZlBHrX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731573850; c=relaxed/simple;
	bh=Xiiv/B9YnbIscwfZvAT3Alc/LK36lg2qnRQFOpJ0xZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2DWtY4e6Qes/81UpdTCFAGiwlwuTbgSkTBKlFIW6Im6u9XG0sYd7AiWfvXnpWlvRzYR18EI4/LRkcWt1IhMyhKRMqeMd+kFdXSt2Z0k3olMT+i5glQXvl7UvEbfCIp9T1M6kAuMiyOvGZklNT+vRhBV+gDlJTS8J6uckGFMQko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPKuOCU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A5DC4CECD;
	Thu, 14 Nov 2024 08:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731573849;
	bh=Xiiv/B9YnbIscwfZvAT3Alc/LK36lg2qnRQFOpJ0xZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kPKuOCU1mZAVyaK7a/67/nYrtHrWuJniOj1/4YlkZfISInFB+AmYC2QitB5LqzpXj
	 VBU3u3W87kRH/zKwS1k6L4QuzCyhVSQsrT9Hcg8NpdzeuRVwU2xPLwcOdC3q0Bz97l
	 q4P6vFuOAOwTmbrCb3DcTiSE5XXuBWD2kQLUYtjqBmMLNvUiF71Wxz01hAIclsFvv3
	 P7S9QOWIFgTKcdQxlsxaLhjd45HBSS5C9+Ptnn1bECFA8VUyTcLaDfn+uUSL9A2lVl
	 y+Iitlid34HQazJAmlOV930GHZHYMbS9T/2upEIkXxvJl+6mYFiJdFwMVXMMbDoYQs
	 P7ItEiSQQcgVw==
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
Subject: [RFC/PATCH v2 bpf-next fanotify 1/7] fanotify: Introduce fanotify fastpath handler
Date: Thu, 14 Nov 2024 00:43:39 -0800
Message-ID: <20241114084345.1564165-2-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241114084345.1564165-1-song@kernel.org>
References: <20241114084345.1564165-1-song@kernel.org>
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

sysfs entry /sys/kernel/fanotify_fastpath is added to help users know
which fastpath handlers are available. At the moment, files are added for
each fastpath handler: flags, desc, and init_args.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/notify/fanotify/Kconfig             |  13 ++
 fs/notify/fanotify/Makefile            |   1 +
 fs/notify/fanotify/fanotify.c          |  29 +++
 fs/notify/fanotify/fanotify_fastpath.c | 282 +++++++++++++++++++++++++
 fs/notify/fanotify/fanotify_user.c     |   7 +
 include/linux/fanotify.h               | 131 ++++++++++++
 include/linux/fsnotify_backend.h       |   4 +
 include/uapi/linux/fanotify.h          |  25 +++
 8 files changed, 492 insertions(+)
 create mode 100644 fs/notify/fanotify/fanotify_fastpath.c

diff --git a/fs/notify/fanotify/Kconfig b/fs/notify/fanotify/Kconfig
index 0e36aaf379b7..74677d3699a3 100644
--- a/fs/notify/fanotify/Kconfig
+++ b/fs/notify/fanotify/Kconfig
@@ -24,3 +24,16 @@ config FANOTIFY_ACCESS_PERMISSIONS
 	   hierarchical storage management systems.
 
 	   If unsure, say N.
+
+config FANOTIFY_FASTPATH
+	bool "fanotify fastpath handler"
+	depends on FANOTIFY
+	default y
+	help
+	   Say Y here if you want to use fanotify in kernel fastpath handler.
+	   The fastpath handler can be implemented in a kernel module or a
+	   BPF program. The fastpath handler can speed up fanotify in many
+	   use cases. For example, when the listener is only interested in
+	   a subset of events.
+
+	   If unsure, say Y.
\ No newline at end of file
diff --git a/fs/notify/fanotify/Makefile b/fs/notify/fanotify/Makefile
index 25ef222915e5..543cb7aa08fc 100644
--- a/fs/notify/fanotify/Makefile
+++ b/fs/notify/fanotify/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_FANOTIFY)		+= fanotify.o fanotify_user.o
+obj-$(CONFIG_FANOTIFY_FASTPATH)	+= fanotify_fastpath.o
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 224bccaab4cc..b395b628a58b 100644
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
+	struct fanotify_fastpath_hook *fp_hook __maybe_unused;
 
 	BUILD_BUG_ON(FAN_ACCESS != FS_ACCESS);
 	BUILD_BUG_ON(FAN_MODIFY != FS_MODIFY);
@@ -933,6 +936,27 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS))
 		fsid = fanotify_get_fsid(iter_info);
 
+#ifdef CONFIG_FANOTIFY_FASTPATH
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
+#endif
+
 	event = fanotify_alloc_event(group, mask, data, data_type, dir,
 				     file_name, &fsid, match_mask);
 	ret = -ENOMEM;
@@ -976,6 +1000,11 @@ static void fanotify_free_group_priv(struct fsnotify_group *group)
 
 	if (mempool_initialized(&group->fanotify_data.error_events_pool))
 		mempool_exit(&group->fanotify_data.error_events_pool);
+
+#ifdef CONFIG_FANOTIFY_FASTPATH
+	if (group->fanotify_data.fp_hook)
+		fanotify_fastpath_hook_free(group->fanotify_data.fp_hook);
+#endif
 }
 
 static void fanotify_free_path_event(struct fanotify_event *event)
diff --git a/fs/notify/fanotify/fanotify_fastpath.c b/fs/notify/fanotify/fanotify_fastpath.c
new file mode 100644
index 000000000000..f2aefcf0ca6a
--- /dev/null
+++ b/fs/notify/fanotify/fanotify_fastpath.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/fanotify.h>
+#include <linux/kobject.h>
+#include <linux/module.h>
+
+#include "fanotify.h"
+
+extern struct srcu_struct fsnotify_mark_srcu;
+
+static DEFINE_SPINLOCK(fp_list_lock);
+static LIST_HEAD(fp_list);
+
+static struct kobject *fan_fp_root_kobj;
+
+static struct {
+	enum fanotify_fastpath_flags flag;
+	const char *name;
+} fanotify_fastpath_flags_names[] = {
+	{
+		.flag = FAN_FP_F_SYS_ADMIN_ONLY,
+		.name = "SYS_ADMIN_ONLY",
+	}
+};
+
+static ssize_t flags_show(struct kobject *kobj,
+			  struct kobj_attribute *attr, char *buf)
+{
+	struct fanotify_fastpath_ops *ops;
+	ssize_t len = 0;
+	int i;
+
+	ops = container_of(kobj, struct fanotify_fastpath_ops, kobj);
+	for (i = 0; i < ARRAY_SIZE(fanotify_fastpath_flags_names); i++) {
+		if (ops->flags & fanotify_fastpath_flags_names[i].flag) {
+			len += sysfs_emit_at(buf, len, "%s%s", len ? " " : "",
+					     fanotify_fastpath_flags_names[i].name);
+		}
+	}
+	len += sysfs_emit_at(buf, len, "\n");
+	return len;
+}
+
+static ssize_t desc_show(struct kobject *kobj,
+			 struct kobj_attribute *attr, char *buf)
+{
+	struct fanotify_fastpath_ops *ops;
+
+	ops = container_of(kobj, struct fanotify_fastpath_ops, kobj);
+
+	return sysfs_emit(buf, "%s\n", ops->desc ?: "N/A");
+}
+
+static ssize_t init_args_show(struct kobject *kobj,
+			      struct kobj_attribute *attr, char *buf)
+{
+	struct fanotify_fastpath_ops *ops;
+
+	ops = container_of(kobj, struct fanotify_fastpath_ops, kobj);
+
+	return sysfs_emit(buf, "%s\n", ops->init_args ?: "N/A");
+}
+
+static struct kobj_attribute flags_kobj_attr = __ATTR_RO(flags);
+static struct kobj_attribute desc_kobj_attr = __ATTR_RO(desc);
+static struct kobj_attribute init_args_kobj_attr = __ATTR_RO(init_args);
+
+static struct attribute *fan_fp_attrs[] = {
+	&flags_kobj_attr.attr,
+	&desc_kobj_attr.attr,
+	&init_args_kobj_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(fan_fp);
+
+static void fan_fp_kobj_release(struct kobject *kobj)
+{
+
+}
+
+static const struct kobj_type fan_fp_ktype = {
+	.release = fan_fp_kobj_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = fan_fp_groups,
+};
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
+static void __fanotify_fastpath_unregister(struct fanotify_fastpath_ops *ops)
+{
+	spin_lock(&fp_list_lock);
+	list_del_init(&ops->list);
+	spin_unlock(&fp_list_lock);
+}
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
+	int ret;
+
+	spin_lock(&fp_list_lock);
+	if (fanotify_fastpath_find(ops->name)) {
+		/* cannot register two handlers with the same name */
+		spin_unlock(&fp_list_lock);
+		return -EEXIST;
+	}
+	list_add_tail(&ops->list, &fp_list);
+	spin_unlock(&fp_list_lock);
+
+
+	kobject_init(&ops->kobj, &fan_fp_ktype);
+	ret = kobject_add(&ops->kobj, fan_fp_root_kobj, "%s", ops->name);
+	if (ret) {
+		__fanotify_fastpath_unregister(ops);
+		return ret;
+	}
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
+	kobject_put(&ops->kobj);
+	__fanotify_fastpath_unregister(ops);
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
+	void *init_args = NULL;
+	int ret = 0;
+
+	ret = copy_from_user(&args, argp, sizeof(args));
+	if (ret)
+		return -EFAULT;
+
+	if (args.version != 1 || args.flags || args.init_args_size > FAN_FP_ARGS_MAX)
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
+	if (!capable(CAP_SYS_ADMIN) && (fp_ops->flags & FAN_FP_F_SYS_ADMIN_ONLY)) {
+		ret = -EPERM;
+		goto err_module_put;
+	}
+
+	if (fp_ops->fp_init) {
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
+		ret = fp_ops->fp_init(fp_hook, init_args);
+		if (ret)
+			goto err_free_args;
+		kfree(init_args);
+	}
+	fp_hook->ops = fp_ops;
+	rcu_assign_pointer(group->fanotify_data.fp_hook, fp_hook);
+
+out:
+	fsnotify_group_unlock(group);
+	return ret;
+
+err_free_args:
+	kfree(init_args);
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
+	kfree(fp_hook);
+}
+
+/*
+ * fanotify_fastpath_add - Delete a fastpath handler from fsnotify_group.
+ */
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
+
+static int __init fanotify_fastpath_init(void)
+{
+	fan_fp_root_kobj = kobject_create_and_add("fanotify_fastpath", kernel_kobj);
+	if (!fan_fp_root_kobj)
+		return -ENOMEM;
+	return 0;
+}
+device_initcall(fanotify_fastpath_init);
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
index 89ff45bd6f01..8645d0b29e9d 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_FANOTIFY_H
 #define _LINUX_FANOTIFY_H
 
+#include <linux/kobject.h>
 #include <linux/sysctl.h>
 #include <uapi/linux/fanotify.h>
 
@@ -136,4 +137,134 @@
 #undef FAN_ALL_PERM_EVENTS
 #undef FAN_ALL_OUTGOING_EVENTS
 
+struct fsnotify_group;
+struct qstr;
+struct inode;
+struct fanotify_fastpath_hook;
+
+/*
+ * Event passed to fanotify fastpath handler
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
+/*
+ * fanotify fastpath handler should implement these ops.
+ *
+ * fp_handler - Main call for the fastpath handler.
+ * @group:	The group being notified
+ * @fp_hook:	fanotify_fastpath_hook for the attach on @group.
+ * Returns: enum fanotify_fastpath_return.
+ *
+ * fp_init - Initialize the fanotify_fastpath_hook.
+ * @hook:	fanotify_fastpath_hook to be initialized
+ * @args:	Arguments used to initialize @hook
+ *
+ * fp_free - Free the fanotify_fastpath_hook.
+ * @hook:	fanotify_fastpath_hook to be freed.
+ *
+ * @name:	Name of the fanotify_fastpath_ops. This need to be unique
+ *		in the system
+ * @owner:	Owner module of this fanotify_fastpath_ops
+ * @list:	Attach to global list of fanotify_fastpath_ops
+ * @flags:	Flags for the fanotify_fastpath_ops
+ * @desc:	Description of what this fastpath handler do (optional)
+ * @init_args:	Description of the init_args in a string (optional)
+ */
+struct fanotify_fastpath_ops {
+	int (*fp_handler)(struct fsnotify_group *group,
+			  struct fanotify_fastpath_hook *fp_hook,
+			  struct fanotify_fastpath_event *fp_event);
+	int (*fp_init)(struct fanotify_fastpath_hook *hook, void *args);
+	void (*fp_free)(struct fanotify_fastpath_hook *hook);
+
+	char name[FAN_FP_NAME_MAX];
+	struct module *owner;
+	struct list_head list;
+	u32 flags;
+	const char *desc;
+	const char *init_args;
+
+	/* internal */
+	struct kobject kobj;
+};
+
+/* Flags for fanotify_fastpath_ops->flags */
+enum fanotify_fastpath_flags {
+	/* CAP_SYS_ADMIN is required to use this fastpath handler */
+	FAN_FP_F_SYS_ADMIN_ONLY = BIT(0),
+
+	FAN_FP_F_ALL = FAN_FP_F_SYS_ADMIN_ONLY,
+};
+
+/* Return value of fp_handler */
+enum fanotify_fastpath_return {
+	/* The event should be sent to user space */
+	FAN_FP_RET_SEND_TO_USERSPACE = 0,
+	/* The event should NOT be sent to user space */
+	FAN_FP_RET_SKIP_EVENT = 1,
+};
+
+/*
+ * Hook that attaches fanotify_fastpath_ops to a group.
+ * @ops:	the ops
+ * @data:	per group data used by the ops
+ */
+struct fanotify_fastpath_hook {
+	struct fanotify_fastpath_ops *ops;
+	void *data;
+};
+
+#ifdef CONFIG_FANOTIFY_FASTPATH
+
+int fanotify_fastpath_register(struct fanotify_fastpath_ops *ops);
+void fanotify_fastpath_unregister(struct fanotify_fastpath_ops *ops);
+int fanotify_fastpath_add(struct fsnotify_group *group,
+			  struct fanotify_fastpath_args __user *args);
+void fanotify_fastpath_del(struct fsnotify_group *group);
+void fanotify_fastpath_hook_free(struct fanotify_fastpath_hook *fp_hook);
+
+#else /* CONFIG_FANOTIFY_FASTPATH */
+
+static inline int fanotify_fastpath_register(struct fanotify_fastpath_ops *ops)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void fanotify_fastpath_unregister(struct fanotify_fastpath_ops *ops)
+{
+}
+
+static inline int fanotify_fastpath_add(struct fsnotify_group *group,
+					struct fanotify_fastpath_args __user *args)
+{
+	return -ENOENT;
+}
+
+static inline void fanotify_fastpath_del(struct fsnotify_group *group)
+{
+}
+
+static inline void fanotify_fastpath_hook_free(struct fanotify_fastpath_hook *fp_hook)
+{
+}
+
+#endif /* CONFIG_FANOTIFY_FASTPATH */
+
 #endif /* _LINUX_FANOTIFY_H */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 3ecf7768e577..9b22d9b9d0bb 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -117,6 +117,7 @@ struct fsnotify_fname;
 struct fsnotify_iter_info;
 
 struct mem_cgroup;
+struct fanotify_fastpath_hook;
 
 /*
  * Each group much define these ops.  The fsnotify infrastructure will call
@@ -255,6 +256,9 @@ struct fsnotify_group {
 			int f_flags; /* event_f_flags from fanotify_init() */
 			struct ucounts *ucounts;
 			mempool_t error_events_pool;
+#ifdef CONFIG_FANOTIFY_FASTPATH
+			struct fanotify_fastpath_hook __rcu *fp_hook;
+#endif /* CONFIG_FANOTIFY_FASTPATH */
 		} fanotify_data;
 #endif /* CONFIG_FANOTIFY */
 	};
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 34f221d3a1b9..654d5ab44143 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -3,6 +3,7 @@
 #define _UAPI_LINUX_FANOTIFY_H
 
 #include <linux/types.h>
+#include <linux/ioctl.h>
 
 /* the following events that user-space can register for */
 #define FAN_ACCESS		0x00000001	/* File was accessed */
@@ -243,4 +244,28 @@ struct fanotify_response_info_audit_rule {
 				(long)(meta)->event_len >= (long)FAN_EVENT_METADATA_LEN && \
 				(long)(meta)->event_len <= (long)(len))
 
+#define FAN_FP_NAME_MAX 64
+#define FAN_FP_ARGS_MAX 64
+
+/* This is the arguments used to add fastpath handler to a group. */
+struct fanotify_fastpath_args {
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
+	/* size of init_args */
+	__u32 init_args_size;
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


