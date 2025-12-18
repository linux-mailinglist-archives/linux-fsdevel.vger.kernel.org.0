Return-Path: <linux-fsdevel+bounces-71695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 808CBCCDFCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 00:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF8FA30F9ED9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 23:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7E53128A5;
	Thu, 18 Dec 2025 23:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZq4DV0A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71022258C;
	Thu, 18 Dec 2025 23:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766100805; cv=none; b=AQ5aaKdL8GoQbXqDrp8841wqCK26PUW2GpjkNN/jyPjfVkfT3Bay/i4fncW1KlJvduB0ceW5ZDtir2uEKI2m5ajonEQM3v/+rqSbXt+hGbPcujkjLSJy/nEGrcwIl2KamF6xgMNJFQHXrDvJ+sjr5RfqJ8PVUvgV+WKvzBUmRFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766100805; c=relaxed/simple;
	bh=5umEWUA+r2q2TY1iFdMRoRA72BRfNLMnJM6doEla0LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf3jPjwibRsuTVA/5U5eDwwRCE9ErrrkjsiMrSGZADrybDBL485qn9C9/i/mDrgOt0M9CjyYiTnf+QXp90uyf+C0IKbSYJwKnDS5E4HDtdGInoAsK22nD/6SbBvQKmCFuC2Z/qOwHXHoWvOJYWC5RetI2dPbCLznpSlCA1B+7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZq4DV0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFCCC4CEFB;
	Thu, 18 Dec 2025 23:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766100805;
	bh=5umEWUA+r2q2TY1iFdMRoRA72BRfNLMnJM6doEla0LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZq4DV0AiBVUdsSFd0ZGovDetuKq4jQdXNWxNlV0ZKPI1cfEo08ijPhdGi1fuKUgf
	 yl9qHDu6WCA/9sFBNnnj2gfKN2MHtNyNjuc/YVN+ZcyKssRWll2F4zFieaOU6M3DbF
	 65BaoWLOvlr3k5dKezChacJ4OTtCw8X4z7kppQl+SH8GKfgzpBX8rtdmrwORppAM1i
	 6rJSECs8XZYhjsE3iAvcSrDTsBigRwcp/R2+Z7F7T+o11zoPZjlvj/zNMumdrfaU5a
	 j8+YdQqn1oEJ8HaMU4ubvq0AX4oHALS3AQ0hnyEAAwOX0Kq1y8kA0v+dmTQsV68iH4
	 U2V3jGueOf5kw==
Date: Thu, 18 Dec 2025 15:33:24 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: brauner@kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH V4.1 1/4] fs: send uevents for filesystem mount events
Message-ID: <20251218233324.GQ94594@frogsfrogsfrogs>
References: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
 <176602332527.688213.9644123318095990966.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176602332527.688213.9644123318095990966.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

Add the ability to send uevents whenever a filesystem mounts, unmounts,
or goes down.  This will enable XFS to start daemons whenever a
filesystem is first mounted.

Regrettably, we can't wire this directly into get_tree_bdev_flags or
generic_shutdown_super because not all filesystems set up a kobject
representation in sysfs, and the VFS has no idea if a filesystem
actually does that.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
v4.1: replace open-coded buffer formatting with seqbuf
---
 include/linux/fsevent.h |   33 ++++++++++++
 fs/Makefile             |    2 -
 fs/fsevent.c            |  126 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/fsevent.h
 create mode 100644 fs/fsevent.c

diff --git a/include/linux/fsevent.h b/include/linux/fsevent.h
new file mode 100644
index 00000000000000..548e35861e545f
--- /dev/null
+++ b/include/linux/fsevent.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef _LINUX_FSEVENT_H__
+#define _LINUX_FSEVENT_H__
+
+void fsevent_send_mount(struct super_block *sb, struct kobject *kobject,
+			struct fs_context *fc);
+
+void fsevent_send(struct super_block *sb, struct kobject *kobject,
+		  enum kobject_action kaction);
+
+static inline void fsevent_send_unmount(struct super_block *sb,
+					struct kobject *kobject)
+{
+	fsevent_send(sb, kobject, KOBJ_REMOVE);
+}
+
+static inline void fsevent_send_remount(struct super_block *sb,
+					struct kobject *kobject)
+{
+	fsevent_send(sb, kobject, KOBJ_CHANGE);
+}
+
+static inline void fsevent_send_shutdown(struct super_block *sb,
+					 struct kobject *kobject)
+{
+	fsevent_send(sb, kobject, KOBJ_OFFLINE);
+}
+
+#endif /* _LINUX_FSEVENT_H__ */
diff --git a/fs/Makefile b/fs/Makefile
index b4d182465405fe..266981bd25ab09 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -158,7 +158,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
 		fs_dirent.o fs_context.o fs_parser.o fsopen.o init.o \
 		kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o \
-		file_attr.o fserror.o
+		file_attr.o fserror.o fsevent.o
 
 obj-$(CONFIG_BUFFER_HEAD)	+= buffer.o mpage.o
 obj-$(CONFIG_PROC_FS)		+= proc_namespace.o
diff --git a/fs/fsevent.c b/fs/fsevent.c
new file mode 100644
index 00000000000000..d37f42f844e057
--- /dev/null
+++ b/fs/fsevent.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#include <linux/fs.h>
+#include <linux/kobject.h>
+#include <linux/fs_context.h>
+#include <linux/seq_buf.h>
+#include <linux/fsevent.h>
+
+static inline size_t fs_uevent_bufsize(const struct super_block *sb,
+				       const char *source,
+				       unsigned int *envlen)
+{
+	size_t ret = sizeof("TYPE=filesystem") +
+		     sizeof("SID=") + sizeof_field(struct super_block, s_id);
+	*envlen += 2;
+
+	if (source) {
+		ret += sizeof("SOURCE=") + strlen(source) + 1;
+		(*envlen)++;
+	}
+
+	if (sb->s_uuid_len == sizeof(sb->s_uuid)) {
+		ret += sizeof("UUID=") + UUID_STRING_LEN;
+		(*envlen)++;
+	}
+
+	/* null array element terminator */
+	ret++;
+	(*envlen)++;
+	return ret;
+}
+
+static char **format_uevent_strings(struct super_block *sb, const char *source)
+{
+	struct seq_buf sbuf;
+	unsigned int envlen = 0;
+	size_t buflen = fs_uevent_bufsize(sb, source, &envlen);
+	char *buf;
+	char **env, **envp;
+
+	buf = kzalloc(buflen, GFP_KERNEL);
+	if (!buf)
+		return NULL;
+	env = kcalloc(envlen, sizeof(char *), GFP_KERNEL);
+	if (!env) {
+		kfree(buf);
+		return NULL;
+	}
+
+	seq_buf_init(&sbuf, buf, buflen);
+	envp = env;
+
+	/*
+	 * Add a second null terminator on the end so the next printf can start
+	 * printing at the second null terminator.
+	 */
+	seq_buf_get_buf(&sbuf, envp++);
+	seq_buf_printf(&sbuf, "TYPE=filesystem");
+	seq_buf_putc(&sbuf, 0);
+
+	seq_buf_get_buf(&sbuf, envp++);
+	seq_buf_printf(&sbuf, "SID=%s", sb->s_id);
+	seq_buf_putc(&sbuf, 0);
+
+	if (source) {
+		seq_buf_get_buf(&sbuf, envp++);
+		seq_buf_printf(&sbuf, "SOURCE=%s", source);
+		seq_buf_putc(&sbuf, 0);
+	}
+
+	if (sb->s_uuid_len == sizeof(sb->s_uuid)) {
+		seq_buf_get_buf(&sbuf, envp++);
+		seq_buf_printf(&sbuf, "UUID=%pU", &sb->s_uuid);
+		seq_buf_putc(&sbuf, 0);
+	}
+
+	/* Add null terminator to strings array */
+	*envp = NULL;
+
+	if (seq_buf_has_overflowed(&sbuf)) {
+		WARN_ON(1);
+		kfree(env);
+		kfree(buf);
+		return NULL;
+	}
+
+	return env;
+}
+
+static inline void free_uevent_strings(char **env)
+{
+	kfree(env[0]);
+	kfree(env);
+}
+
+/*
+ * Send a uevent signalling that the mount succeeded so we can use udev rules
+ * to start background services.
+ */
+void fsevent_send_mount(struct super_block *sb, struct kobject *kobject,
+			struct fs_context *fc)
+{
+	char **env = format_uevent_strings(sb, fc->source);
+
+	if (env) {
+		kobject_uevent_env(kobject, KOBJ_ADD, env);
+		free_uevent_strings(env);
+	}
+}
+EXPORT_SYMBOL_GPL(fsevent_send_mount);
+
+/* Send a uevent signalling that something happened to a live mount. */
+void fsevent_send(struct super_block *sb, struct kobject *kobject,
+		  enum kobject_action kaction)
+{
+	char **env = format_uevent_strings(sb, NULL);
+
+	if (env) {
+		kobject_uevent_env(kobject, kaction, env);
+		free_uevent_strings(env);
+	}
+}
+EXPORT_SYMBOL_GPL(fsevent_send);

