Return-Path: <linux-fsdevel+bounces-66005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0D5C179D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4E024F1211
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105022D320E;
	Wed, 29 Oct 2025 00:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PupCBTlX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC7141C62;
	Wed, 29 Oct 2025 00:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698745; cv=none; b=opUjOuQyif2oV6RmxnMBeMV8rLf1qqdFayZVnQjjry/RpKVLwewFFS9kI0ID3LVmKktmNcq94xVbNWP8mFagI/vb9K5F70s9aFqGndwS0UZbqJaRHSOrZncOSzjRAImwqYiB2TRImbcnqgAuPIeZhcS5vUGfd14gSvswe1yvxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698745; c=relaxed/simple;
	bh=OzhbD/y7Y1eJzApzclRvGAwOG/qBVmd8tVWeHnDaHPE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrM/3QmtZmFL/Bk3KaNInvxxKW5lOs8NcvSigcaBx/2GscYj/PYwtJVvTkpzo/wEnJDdVTnO6NGiZvAqULVgOi/BF2Yo5tGqcEjT8Hy5XTjxvxc2of/DbMyP1hQornvnXZOMSUA9ziRd2+6pBQad+mMVfvNPH6EB9n4hAlw2Csw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PupCBTlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4312C4CEE7;
	Wed, 29 Oct 2025 00:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698744;
	bh=OzhbD/y7Y1eJzApzclRvGAwOG/qBVmd8tVWeHnDaHPE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PupCBTlXBP2IIKt2ZDP7+qd0KTT33cZlBVZwz8N/ItkBKcnS1L3Fu6dslxy3wRuaQ
	 wDdDjatauuTxTV6fLjvgOo7sbg7y3AJYxrTceALYQ4bvruu0o519tZV3XKb+q+qxIK
	 7ivwmSC65A/LDv+h9u8QkfeNldy/VzKeHb8ZPMQLTdkZM5+lJOcm94MzW9KmUu/D9F
	 UsUI2JarrOlbiKn877P2LA5vqIDplBMX6c0tXNgPKOlj77o/t74sJzL9Jx7PiOHV4Z
	 i69bSq26qEq61l1VTFWHpqjn/a7OP/hmZkNwW5OahTK9ZWgGj9Ffc2TKx5Dmkv62sO
	 jSNsX/sWLKZBA==
Date: Tue, 28 Oct 2025 17:45:44 -0700
Subject: [PATCH 03/31] fuse: make debugging configurable at runtime
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810415.1424854.10373764649459618752.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Use static keys so that we can configure debugging assertions and dmesg
warnings at runtime.  By default this is turned off so the cost is
merely scanning a nop sled.  However, fuse server developers can turn
it on for their debugging systems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h     |    8 +++++
 fs/fuse/iomap_i.h    |   16 ++++++++--
 fs/fuse/Kconfig      |   15 +++++++++
 fs/fuse/file_iomap.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c      |    7 ++++
 5 files changed, 124 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 45be59df7ae592..61fb65f3604d61 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1691,6 +1691,14 @@ extern void fuse_sysctl_unregister(void);
 #define fuse_sysctl_unregister()	do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
+int fuse_iomap_sysfs_init(struct kobject *kobj);
+void fuse_iomap_sysfs_cleanup(struct kobject *kobj);
+#else
+# define fuse_iomap_sysfs_init(...)		(0)
+# define fuse_iomap_sysfs_cleanup(...)		((void)0)
+#endif
+
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
 bool fuse_iomap_enabled(void);
 
diff --git a/fs/fuse/iomap_i.h b/fs/fuse/iomap_i.h
index 6d9ce9c0f40a04..3615ec76c0dec0 100644
--- a/fs/fuse/iomap_i.h
+++ b/fs/fuse/iomap_i.h
@@ -6,19 +6,29 @@
 #ifndef _FS_FUSE_IOMAP_I_H
 #define _FS_FUSE_IOMAP_I_H
 
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_DEFAULT)
+DECLARE_STATIC_KEY_TRUE(fuse_iomap_debug);
+#else
+DECLARE_STATIC_KEY_FALSE(fuse_iomap_debug);
+#endif
+
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
 #if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
-# define ASSERT(condition) do {						\
+# define ASSERT(condition) \
+while (static_branch_unlikely(&fuse_iomap_debug)) {			\
 	int __cond = !!(condition);					\
 	if (unlikely(!__cond))						\
 		trace_fuse_iomap_assert(__func__, __LINE__, #condition); \
 	WARN(!__cond, "Assertion failed: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
-} while (0)
+	break;								\
+}
 # define BAD_DATA(condition) ({						\
 	int __cond = !!(condition);					\
 	if (unlikely(__cond))						\
 		trace_fuse_iomap_bad_data(__func__, __LINE__, #condition); \
-	WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
+	if (static_branch_unlikely(&fuse_iomap_debug))			\
+		WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
+	unlikely(__cond);								\
 })
 #else
 # define ASSERT(condition)
diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 934d48076a010c..bb867afe6e867c 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -101,6 +101,21 @@ config FUSE_IOMAP_DEBUG
 	  Enable debugging assertions for the fuse iomap code paths and logging
 	  of bad iomap file mapping data being sent to the kernel.
 
+	  Say N here if you don't want any debugging code code compiled in at
+	  all.
+
+config FUSE_IOMAP_DEBUG_BY_DEFAULT
+	bool "Debug FUSE file IO over iomap at boot time"
+	default n
+	depends on FUSE_IOMAP_DEBUG
+	help
+	  At boot time, enable debugging assertions for the fuse iomap code
+	  paths and warnings about bad iomap file mapping data.  This enables
+	  fuse server authors to control debugging at runtime even on a
+	  distribution kernel while avoiding most of the overhead on production
+	  systems.  The setting can be changed at runtime via
+	  /sys/fs/fuse/iomap/debug.
+
 config FUSE_IO_URING
 	bool "FUSE communication over io-uring"
 	default y
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index a88f5d8d2bce15..b6fc70068c5542 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -8,6 +8,12 @@
 #include "fuse_trace.h"
 #include "iomap_i.h"
 
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_DEFAULT)
+DEFINE_STATIC_KEY_TRUE(fuse_iomap_debug);
+#else
+DEFINE_STATIC_KEY_FALSE(fuse_iomap_debug);
+#endif
+
 static bool __read_mostly enable_iomap =
 #if IS_ENABLED(CONFIG_FUSE_IOMAP_BY_DEFAULT)
 	true;
@@ -17,6 +23,81 @@ static bool __read_mostly enable_iomap =
 module_param(enable_iomap, bool, 0644);
 MODULE_PARM_DESC(enable_iomap, "Enable file I/O through iomap");
 
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
+static struct kobject *iomap_kobj;
+
+static ssize_t fuse_iomap_debug_show(struct kobject *kobject,
+				     struct kobj_attribute *a, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", !!static_key_enabled(&fuse_iomap_debug));
+}
+
+static ssize_t fuse_iomap_debug_store(struct kobject *kobject,
+				      struct kobj_attribute *a,
+				      const char *buf, size_t count)
+{
+	int ret;
+	int val;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val < 0 || val > 1)
+		return -EINVAL;
+
+	if (val)
+		static_branch_enable(&fuse_iomap_debug);
+	else
+		static_branch_disable(&fuse_iomap_debug);
+
+	return count;
+}
+
+#define __INIT_KOBJ_ATTR(_name, _mode, _show, _store)			\
+{									\
+	.attr	= { .name = __stringify(_name), .mode = _mode },	\
+	.show	= _show,						\
+	.store	= _store,						\
+}
+
+#define FUSE_ATTR_RW(_name, _show, _store)			\
+	static struct kobj_attribute fuse_attr_##_name =	\
+			__INIT_KOBJ_ATTR(_name, 0644, _show, _store)
+
+#define FUSE_ATTR_PTR(_name)					\
+	(&fuse_attr_##_name.attr)
+
+FUSE_ATTR_RW(debug, fuse_iomap_debug_show, fuse_iomap_debug_store);
+
+static const struct attribute *fuse_iomap_attrs[] = {
+	FUSE_ATTR_PTR(debug),
+	NULL,
+};
+
+int fuse_iomap_sysfs_init(struct kobject *fuse_kobj)
+{
+	int error;
+
+	iomap_kobj = kobject_create_and_add("iomap", fuse_kobj);
+	if (!iomap_kobj)
+		return -ENOMEM;
+
+	error = sysfs_create_files(iomap_kobj, fuse_iomap_attrs);
+	if (error) {
+		kobject_put(iomap_kobj);
+		return error;
+	}
+
+	return 0;
+}
+
+void fuse_iomap_sysfs_cleanup(struct kobject *fuse_kobj)
+{
+	kobject_put(iomap_kobj);
+}
+#endif /* IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG) */
+
 bool fuse_iomap_enabled(void)
 {
 	/* Don't let anyone touch iomap until the end of the patchset. */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 1eea8dc6e723c6..eec711302a4a13 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -2277,8 +2277,14 @@ static int fuse_sysfs_init(void)
 	if (err)
 		goto out_fuse_unregister;
 
+	err = fuse_iomap_sysfs_init(fuse_kobj);
+	if (err)
+		goto out_fuse_connections;
+
 	return 0;
 
+ out_fuse_connections:
+	sysfs_remove_mount_point(fuse_kobj, "connections");
  out_fuse_unregister:
 	kobject_put(fuse_kobj);
  out_err:
@@ -2287,6 +2293,7 @@ static int fuse_sysfs_init(void)
 
 static void fuse_sysfs_cleanup(void)
 {
+	fuse_iomap_sysfs_cleanup(fuse_kobj);
 	sysfs_remove_mount_point(fuse_kobj, "connections");
 	kobject_put(fuse_kobj);
 }


