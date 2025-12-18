Return-Path: <linux-fsdevel+bounces-71597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83137CCA0D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 03:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A21A3058E72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 02:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FE6277C9E;
	Thu, 18 Dec 2025 02:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PorQc+/o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874A3274B55;
	Thu, 18 Dec 2025 02:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766023470; cv=none; b=D6Hc2eMNj5siEjZf632rnCXegxfVgDBXveNR8mKWmR/2JR3OptHXY9uy5yb2Bwz52afF3FQUmgnuiW20Q1s9flkX/Atq0bW02r/G+gRjZpO4t/8Hnm8jkKFVWW0NRGfiJSFLbMyX2gh/mOW4LsPNtQXRon/fXfIuaj/VyYpIt1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766023470; c=relaxed/simple;
	bh=j1tpeiNdFz9hiQIp7oyYl8yQrEQ5vjXbVzGrCFB7PBk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+nWFr/m0lt1yXW8JAf04OTMScScxrW200BdEU8crq/e2DbTW8Ckm8Vpt505JhaBPsLtHx4t6iu7zKfwNxxxTX6ghsHv1dab5ntbeC77PDlgW/N7RA4iPidxNmEvJyEqpL2PRUNxFM7fWoAmjmWHfxpnJ/QopZyI0pIU9L3LH9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PorQc+/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC09C4CEF5;
	Thu, 18 Dec 2025 02:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766023470;
	bh=j1tpeiNdFz9hiQIp7oyYl8yQrEQ5vjXbVzGrCFB7PBk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PorQc+/oRs7uhNtRTh1cW21poWGbNmCphWZtFO50/ELLcBYEqRdgfGfhpf+Oazi4v
	 2FDqIZCTE85sKoeYIH6TzZOgme0Pndq6fpgSTnr0HoReF+thvuhhot/kpJJdC8Nyo7
	 gfGjNC7DGtlSF16nSEOT7GcB4/ph6GBMd0tjMRxvRnh1oOxnyNm/K73cjjCZd+PXUL
	 Dw0gx9tlVGwE0tSUh3vG9Oc8jrEQJ3SQ1p4WRwO48hK+oY2EbMQ0teQKCjObQMtUV1
	 iEyWkhA7gFfRKUk3lS/o9Vbuu8CH5nZbW9vRimKtbGCd/kXLwIGQ6opYfKY0QpPfQA
	 TpdZ+RU6625AA==
Date: Wed, 17 Dec 2025 18:04:29 -0800
Subject: [PATCH 1/4] fs: send uevents for filesystem mount events
From: "Darrick J. Wong" <djwong@kernel.org>
To: brauner@kernel.org, djwong@kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
 linux-fsdevel@vger.kernel.org
Message-ID: <176602332527.688213.9644123318095990966.stgit@frogsfrogsfrogs>
In-Reply-To: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
References: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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
 include/linux/fsevent.h |   33 ++++++++++++
 fs/Makefile             |    2 -
 fs/fsevent.c            |  128 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+), 1 deletion(-)
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
index f238cc5ea2e9d7..4a07ae61e65730 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -16,7 +16,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
 		fs_dirent.o fs_context.o fs_parser.o fsopen.o init.o \
 		kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o \
-		file_attr.o fserror.o
+		file_attr.o fserror.o fsevent.o
 
 obj-$(CONFIG_BUFFER_HEAD)	+= buffer.o mpage.o
 obj-$(CONFIG_PROC_FS)		+= proc_namespace.o
diff --git a/fs/fsevent.c b/fs/fsevent.c
new file mode 100644
index 00000000000000..a7eea8eac0578a
--- /dev/null
+++ b/fs/fsevent.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#include <linux/fs.h>
+#include <linux/kobject.h>
+#include <linux/fs_context.h>
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
+	(*envlen)++;
+	return ret;
+}
+
+#define ADVANCE_ENV(envp, buf, buflen, written) \
+	do { \
+		ssize_t __written = (written); \
+\
+		WARN_ON((buflen) < (__written) + 1); \
+		*(envp) = (buf); \
+		(envp)++; \
+		(buf) += (__written) + 1; \
+		(buflen) -= (__written) + 1; \
+	} while (0)
+
+static char **format_uevent_strings(struct super_block *sb, const char *source)
+{
+	unsigned int envlen = 0;
+	size_t buflen = fs_uevent_bufsize(sb, source, &envlen);
+	char *buf;
+	char **env, **envp;
+	ssize_t written;
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
+	envp = env;
+	written = snprintf(buf, buflen, "TYPE=filesystem");
+	if (written >= buflen)
+		goto bad;
+	ADVANCE_ENV(envp, buf, buflen, written);
+
+	written = snprintf(buf, buflen, "SID=%s", sb->s_id);
+	if (written >= buflen)
+		goto bad;
+	ADVANCE_ENV(envp, buf, buflen, written);
+
+	if (source) {
+		written = snprintf(buf, buflen, "SOURCE=%s", source);
+		if (written >= buflen)
+			goto bad;
+		ADVANCE_ENV(envp, buf, buflen, written);
+	}
+
+	if (sb->s_uuid_len == sizeof(sb->s_uuid)) {
+		written = snprintf(buf, buflen, "UUID=%pU", &sb->s_uuid);
+		if (written >= buflen)
+			goto bad;
+		ADVANCE_ENV(envp, buf, buflen, written);
+	}
+
+	return env;
+bad:
+	kfree(env);
+	kfree(buf);
+	return NULL;
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
+	char **env;
+
+	env = format_uevent_strings(sb, NULL);
+	if (env) {
+		kobject_uevent_env(kobject, kaction, env);
+		free_uevent_strings(env);
+	}
+}
+EXPORT_SYMBOL_GPL(fsevent_send);


