Return-Path: <linux-fsdevel+bounces-58444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B16DB2E9C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87483A2651F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F351E32D3;
	Thu, 21 Aug 2025 00:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4ZpZ2Yl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2232FC2FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737598; cv=none; b=rA9sRb6DqICsWwV9uSWde1f23KA2qb2f2cHhD+5Y7RjyRKqdup/zaqzBoBEClZFY9Pa9+MXg6VaxTTNdClLo6+7yAikNUXeDNKNAuxkfaRwfV24pBsz9qJ01hs6NEcKRntlcGyF9zLlWGKc90TxBxsYsRgk4wjyoqs5yi/h2b3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737598; c=relaxed/simple;
	bh=jmdY5Tj8DED+mHy08HyLUy0ICEfs/IP9ErQDrqBxUeg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hbsn6yevTFPWAoPiGGReOTfNy/BAxyDoCDb2Tn8TQx1g1X3PzxOJjjJSCtpti8xFn2reodf6G0+demfHSnxfXU6pMVtO3vtHCy8QH6+0o+mzr2chG25Bq7U8c0zcRicvGCzkCvy6eQVz7lRtZhrG0V3oi7TZmCgeLZsIW5tevfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4ZpZ2Yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88ACDC4CEE7;
	Thu, 21 Aug 2025 00:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737597;
	bh=jmdY5Tj8DED+mHy08HyLUy0ICEfs/IP9ErQDrqBxUeg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=u4ZpZ2Yln3EIY8rIB1Y0XOocLsFVP9sCwG5tEjwUt5jZMBhZf/LWj4OiF455chl+u
	 daNxeOrhi9RwKywtk9ZDbLOAn+08hFskPGdBZoDOZl/3XycK2QnngDqk+0EZLHrcob
	 bDEfxiXVz3f7HGmOhjyMYFPhDn3TP4mMt17Y72LCZALnhNul8ROG+TkxsJeSVIxv3p
	 Cys+xB9kYv2UPWHSunBmqY/FcHOUVxdNVfLDNJpHGG9hL34VsCar7f7fCqB7vtqB4a
	 ZQhnh1SMQiOZcg/bMKijP/1R97A9NnFJtNa+NZuOpKL7Nu2gBX9kVyE970h4BPdcBl
	 WfyTlGWr0N/FQ==
Date: Wed, 20 Aug 2025 17:53:17 -0700
Subject: [PATCH 03/23] fuse: make debugging configurable at runtime
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709179.17510.17629388878814132103.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
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
 fs/fuse/iomap_priv.h |   16 ++++++++--
 fs/fuse/Kconfig      |   15 +++++++++
 fs/fuse/file_iomap.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c      |    7 ++++
 5 files changed, 124 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b28054c254f866..2cd9f4cdc6a7ef 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1607,6 +1607,14 @@ extern void fuse_sysctl_unregister(void);
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
 
diff --git a/fs/fuse/iomap_priv.h b/fs/fuse/iomap_priv.h
index ca8544a95a4267..7002eb38f87fe1 100644
--- a/fs/fuse/iomap_priv.h
+++ b/fs/fuse/iomap_priv.h
@@ -6,19 +6,29 @@
 #ifndef _FS_FUSE_IOMAP_PRIV_H
 #define _FS_FUSE_IOMAP_PRIV_H
 
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
index e0bcbd42431344..6be74396ef5198 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -90,6 +90,21 @@ config FUSE_IOMAP_DEBUG
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
index d11b1f810523fc..fad5457d669baf 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -8,6 +8,12 @@
 #include "fuse_trace.h"
 #include "iomap_priv.h"
 
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
index 82e074642e8e9b..9448a11c828fef 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -2217,8 +2217,14 @@ static int fuse_sysfs_init(void)
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
@@ -2227,6 +2233,7 @@ static int fuse_sysfs_init(void)
 
 static void fuse_sysfs_cleanup(void)
 {
+	fuse_iomap_sysfs_cleanup(fuse_kobj);
 	sysfs_remove_mount_point(fuse_kobj, "connections");
 	kobject_put(fuse_kobj);
 }


