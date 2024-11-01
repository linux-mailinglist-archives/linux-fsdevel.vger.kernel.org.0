Return-Path: <linux-fsdevel+bounces-33489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9868A9B95BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 17:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EFA61F21BDD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 16:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04AC1B4F2D;
	Fri,  1 Nov 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pn87DnAX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817341CC177;
	Fri,  1 Nov 2024 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479421; cv=none; b=VrN3oxRo0o1M6UGjkM0ZpNkzuCaKEFxiMnxs/NU+IaJFBtO7PjhmsN5iDBQSX0XHICDxLEHIKNqXFk4EHA1IxC4woOxpQjf3xY33GXHt3m1kSTskOp/0RWGu/CCyjdLVGN1+N05jx4omutgX6Et0r8NgouXRBtXZFh1wb2QkrU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479421; c=relaxed/simple;
	bh=lb9RjaO/cLTpIA5ytTYGjlJe27AiShJpYxvElcVEufQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZRfmEhIEinO8KuG/taDa7IDAmUCguqUE//gh4l/uH1OeICCWhaSZmZg8nMz0KMK01ty904aDmfH5H7Z2C2hZZBjHFTc2iNE2FqZg3ByxV/wZV9t05j/Y5XU9yQ4G2r04RXcjGn2VsnfMGAEG5Hxubk8GDz0FXGGTIuPbeuVB5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pn87DnAX; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1Ftxs1X2bzMP8j6QK8gh+paXxKWIM0HgFnEN8ePS9Tc=; b=pn87DnAXiqTKqX3MhKegErUZj5
	8fCM7W1FYVlDWFulKMj228VX/ZFBQhPW4JdWHiNJiwft3+OKS2uzZ38b0zQkfN7UDdR63V5WJmxNJ
	0cosR6SaUcOAmBfdPq5JkJzMoDj8rmyXRxm5n8gdLhSHxkpUdnkxrjNy6F6WQp+T9Hq942V7HLV3C
	riIgfxGS/lJw0g3kwhnuyvJbZ219OKN0jbsI4l8TPLXRXOdfFlve7BfHTYfALrHsT8CTepBHlg3m+
	+N3x4S5N5bDYQV3qfkogt58NtqJQWVUwatzywOpDBtCpGXtluXxG07xA2u0cIp2s8qwApichjWNIj
	cvwLKPEQ==;
Received: from [189.78.222.89] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t6ukB-000V2F-9N; Fri, 01 Nov 2024 17:43:27 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Nathan Chancellor <nathan@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 3/3] tmpfs: Initialize sysfs during tmpfs init
Date: Fri,  1 Nov 2024 13:42:51 -0300
Message-ID: <20241101164251.327884-4-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241101164251.327884-1-andrealmeid@igalia.com>
References: <20241101164251.327884-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of using fs_initcall(), initialize sysfs with the rest of the
filesystem. This is the right way to do it because otherwise any error
during tmpfs_sysfs_init() would get silently ignored. It's also useful
if tmpfs' sysfs ever need to display runtime information.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v1:
- Fixed ifdef guard for tmpfs_sysfs_init()
---
 mm/shmem.c | 130 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 68 insertions(+), 62 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 6038e1d11987..a5355cf9443c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5126,6 +5126,66 @@ static struct file_system_type shmem_fs_type = {
 	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 
+#if defined(CONFIG_SYSFS) && defined(CONFIG_TMPFS)
+
+#define __INIT_KOBJ_ATTR(_name, _mode, _show, _store)			\
+{									\
+	.attr	= { .name = __stringify(_name), .mode = _mode },	\
+	.show	= _show,						\
+	.store	= _store,						\
+}
+
+#define TMPFS_ATTR_W(_name, _store)				\
+	static struct kobj_attribute tmpfs_attr_##_name =	\
+			__INIT_KOBJ_ATTR(_name, 0200, NULL, _store)
+
+#define TMPFS_ATTR_RW(_name, _show, _store)			\
+	static struct kobj_attribute tmpfs_attr_##_name =	\
+			__INIT_KOBJ_ATTR(_name, 0644, _show, _store)
+
+#define TMPFS_ATTR_RO(_name, _show)				\
+	static struct kobj_attribute tmpfs_attr_##_name =	\
+			__INIT_KOBJ_ATTR(_name, 0444, _show, NULL)
+
+#if IS_ENABLED(CONFIG_UNICODE)
+static ssize_t casefold_show(struct kobject *kobj, struct kobj_attribute *a,
+			char *buf)
+{
+		return sysfs_emit(buf, "supported\n");
+}
+TMPFS_ATTR_RO(casefold, casefold_show);
+#endif
+
+static struct attribute *tmpfs_attributes[] = {
+#if IS_ENABLED(CONFIG_UNICODE)
+	&tmpfs_attr_casefold.attr,
+#endif
+	NULL
+};
+
+static const struct attribute_group tmpfs_attribute_group = {
+	.attrs = tmpfs_attributes,
+	.name = "features"
+};
+
+static struct kobject *tmpfs_kobj;
+
+static int __init tmpfs_sysfs_init(void)
+{
+	int ret;
+
+	tmpfs_kobj = kobject_create_and_add("tmpfs", fs_kobj);
+	if (!tmpfs_kobj)
+		return -ENOMEM;
+
+	ret = sysfs_create_group(tmpfs_kobj, &tmpfs_attribute_group);
+	if (ret)
+		kobject_put(tmpfs_kobj);
+
+	return ret;
+}
+#endif /* CONFIG_SYSFS && CONFIG_TMPFS */
+
 void __init shmem_init(void)
 {
 	int error;
@@ -5149,6 +5209,14 @@ void __init shmem_init(void)
 		goto out1;
 	}
 
+#if defined(CONFIG_SYSFS) && defined(CONFIG_TMPFS)
+	error = tmpfs_sysfs_init();
+	if (error) {
+		pr_err("Could not init tmpfs sysfs\n");
+		goto out1;
+	}
+#endif
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (has_transparent_hugepage() && shmem_huge > SHMEM_HUGE_DENY)
 		SHMEM_SB(shm_mnt->mnt_sb)->huge = shmem_huge;
@@ -5546,65 +5614,3 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 	return page;
 }
 EXPORT_SYMBOL_GPL(shmem_read_mapping_page_gfp);
-
-#if defined(CONFIG_SYSFS) && defined(CONFIG_TMPFS)
-
-#define __INIT_KOBJ_ATTR(_name, _mode, _show, _store)			\
-{									\
-	.attr	= { .name = __stringify(_name), .mode = _mode },	\
-	.show	= _show,						\
-	.store	= _store,						\
-}
-
-#define TMPFS_ATTR_W(_name, _store)				\
-	static struct kobj_attribute tmpfs_attr_##_name =	\
-			__INIT_KOBJ_ATTR(_name, 0200, NULL, _store)
-
-#define TMPFS_ATTR_RW(_name, _show, _store)			\
-	static struct kobj_attribute tmpfs_attr_##_name =	\
-			__INIT_KOBJ_ATTR(_name, 0644, _show, _store)
-
-#define TMPFS_ATTR_RO(_name, _show)				\
-	static struct kobj_attribute tmpfs_attr_##_name =	\
-			__INIT_KOBJ_ATTR(_name, 0444, _show, NULL)
-
-#if IS_ENABLED(CONFIG_UNICODE)
-static ssize_t casefold_show(struct kobject *kobj, struct kobj_attribute *a,
-			char *buf)
-{
-		return sysfs_emit(buf, "supported\n");
-}
-TMPFS_ATTR_RO(casefold, casefold_show);
-#endif
-
-static struct attribute *tmpfs_attributes[] = {
-#if IS_ENABLED(CONFIG_UNICODE)
-	&tmpfs_attr_casefold.attr,
-#endif
-	NULL
-};
-
-static const struct attribute_group tmpfs_attribute_group = {
-	.attrs = tmpfs_attributes,
-	.name = "features"
-};
-
-static struct kobject *tmpfs_kobj;
-
-static int __init tmpfs_sysfs_init(void)
-{
-	int ret;
-
-	tmpfs_kobj = kobject_create_and_add("tmpfs", fs_kobj);
-	if (!tmpfs_kobj)
-		return -ENOMEM;
-
-	ret = sysfs_create_group(tmpfs_kobj, &tmpfs_attribute_group);
-	if (ret)
-		kobject_put(tmpfs_kobj);
-
-	return ret;
-}
-
-fs_initcall(tmpfs_sysfs_init);
-#endif /* CONFIG_SYSFS && CONFIG_TMPFS */
-- 
2.47.0


