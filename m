Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7AC4B84C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 14:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbfFSMab (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 08:30:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51624 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731427AbfFSMaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so1588733wma.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NVPnLeIv971f025k0CXEVACXNX2ckV29nGAgqfri3so=;
        b=o9ryebJtyFJjq43yQIKfwAz9K5Kf7LEZOgnGoIQEI94chN7svmZ15ob2/D3EBJxwzr
         2rWBdIZxzmIBs7RIdyYOlW7j0P4hXj7yIpgS7rx+Xn9tUBGoH02ukF8zKVqTQn5rYOEy
         DN0yDqWQ0thqWDM7OWC5UFOW4QvHp76OXRbZIM8pwCo6V+bXXenKnStQ5tBqGFij9reZ
         b6A0Ub1N6uct2YEoU4O2OYiAm6z+zq0Tbxdh4X1ko+ivpzbdewQtE84xZmdKm29ONw+E
         QPP8ZdZHXz/7ko7HkHcwRkdpI9zj03bkzu+RCdjVmMuSa9OsCaNEc9Puq/4Sui0nrVN1
         4lmQ==
X-Gm-Message-State: APjAAAVukXzOYzAWHOrVUDSVrvdiPmyYiPsqSUoqUGeyCM2uztMYe/bq
        eKjwIMO0kHM3LqNY7hjl9Oc7TA==
X-Google-Smtp-Source: APXvYqzncdXtuPhfGwULjbWMrB268X3YQkOcb42lp3YuSywCSatwWWMFFsHdc7kraOvkXl4lQKZrMQ==
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr8465369wml.45.1560947427727;
        Wed, 19 Jun 2019 05:30:27 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:26 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] vfs: move vfs_parse_sb_flag() calls into filesystems
Date:   Wed, 19 Jun 2019 14:30:08 +0200
Message-Id: <20190619123019.30032-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move parsing "standard" options into filesystems' ->parse_param().  This
patch doesn't change behavior.

This is in preparation for allowing filesystems to reject options that they
don't support.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  6 +++++-
 fs/afs/super.c                         |  6 +++++-
 fs/fs_context.c                        | 12 +++++++-----
 fs/fuse/control.c                      |  1 +
 fs/hugetlbfs/inode.c                   |  6 +++++-
 fs/proc/root.c                         |  6 +++++-
 fs/sysfs/mount.c                       |  1 +
 include/linux/fs_context.h             |  1 +
 ipc/mqueue.c                           |  1 +
 kernel/cgroup/cgroup-v1.c              |  6 +++++-
 kernel/cgroup/cgroup.c                 |  6 +++++-
 kernel/cgroup/cpuset.c                 |  1 +
 12 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2131b8bbaad7..83d3c358f95e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2051,7 +2051,11 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
 	struct fs_parse_result result;
-	int opt;
+	int ret, opt;
+
+	ret = vfs_parse_sb_flag(fc, param);
+	if (ret != -ENOPARAM)
+		return ret;
 
 	opt = fs_parse(fc, &rdt_fs_parameters, param, &result);
 	if (opt < 0)
diff --git a/fs/afs/super.c b/fs/afs/super.c
index f18911e8d770..7f032d08781b 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -321,7 +321,11 @@ static int afs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct fs_parse_result result;
 	struct afs_fs_context *ctx = fc->fs_private;
-	int opt;
+	int ret, opt;
+
+	ret = vfs_parse_sb_flag(fc, param);
+	if (ret != -ENOPARAM)
+		return ret;
 
 	opt = fs_parse(fc, &afs_fs_parameters, param, &result);
 	if (opt < 0)
diff --git a/fs/fs_context.c b/fs/fs_context.c
index e56310fd8c75..a9f314390b99 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -81,7 +81,7 @@ static const char *const forbidden_sb_flag[] = {
 /*
  * Check for a common mount option that manipulates s_flags.
  */
-static int vfs_parse_sb_flag(struct fs_context *fc, struct fs_parameter *param)
+int vfs_parse_sb_flag(struct fs_context *fc, struct fs_parameter *param)
 {
 	const char *key = param->key;
 	unsigned int set, clear;
@@ -105,6 +105,7 @@ static int vfs_parse_sb_flag(struct fs_context *fc, struct fs_parameter *param)
 	fc->sb_flags_mask |= set | clear;
 	return 0;
 }
+EXPORT_SYMBOL(vfs_parse_sb_flag);
 
 /**
  * vfs_parse_fs_param - Add a single parameter to a superblock config
@@ -129,10 +130,6 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 	if (!param->key)
 		return invalf(fc, "Unnamed parameter\n");
 
-	ret = vfs_parse_sb_flag(fc, param);
-	if (ret != -ENOPARAM)
-		return ret;
-
 	ret = security_fs_context_parse_param(fc, param);
 	if (ret != -ENOPARAM)
 		/* Param belongs to the LSM or is disallowed by the LSM; so
@@ -561,6 +558,11 @@ static int legacy_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct legacy_fs_context *ctx = fc->fs_private;
 	unsigned int size = ctx->data_size;
 	size_t len = 0;
+	int ret;
+
+	ret = vfs_parse_sb_flag(fc, param);
+	if (ret != -ENOPARAM)
+		return ret;
 
 	if (strcmp(param->key, "source") == 0) {
 		if (param->type != fs_value_is_string)
diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 14ce1e47f980..c35013ed7f65 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -351,6 +351,7 @@ static int fuse_ctl_get_tree(struct fs_context *fc)
 
 static const struct fs_context_operations fuse_ctl_context_ops = {
 	.get_tree	= fuse_ctl_get_tree,
+	.parse_param	= vfs_parse_fs_param,
 };
 
 static int fuse_ctl_init_fs_context(struct fs_context *fc)
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 1dcc57189382..89125cc36d0e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1149,7 +1149,11 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
 	struct fs_parse_result result;
 	char *rest;
 	unsigned long ps;
-	int opt;
+	int ret, opt;
+
+	ret = vfs_parse_sb_flag(fc, param);
+	if (ret != -ENOPARAM)
+		return ret;
 
 	opt = fs_parse(fc, &hugetlb_fs_parameters, param, &result);
 	if (opt < 0)
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 8b145e7b9661..6ef1527ad975 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -56,7 +56,11 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct proc_fs_context *ctx = fc->fs_private;
 	struct fs_parse_result result;
-	int opt;
+	int ret, opt;
+
+	ret = vfs_parse_sb_flag(fc, param);
+	if (ret != -ENOPARAM)
+		return ret;
 
 	opt = fs_parse(fc, &proc_fs_parameters, param, &result);
 	if (opt < 0)
diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index 1b56686ab178..ba576a976e8c 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -49,6 +49,7 @@ static void sysfs_fs_context_free(struct fs_context *fc)
 
 static const struct fs_context_operations sysfs_fs_context_ops = {
 	.free		= sysfs_fs_context_free,
+	.parse_param	= vfs_parse_sb_flag,
 	.get_tree	= sysfs_get_tree,
 };
 
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index d476ff0c10df..39f4d8b0a390 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -127,6 +127,7 @@ extern struct fs_context *fs_context_for_submount(struct file_system_type *fs_ty
 						struct dentry *reference);
 
 extern struct fs_context *vfs_dup_fs_context(struct fs_context *fc);
+extern int vfs_parse_sb_flag(struct fs_context *fc, struct fs_parameter *param);
 extern int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param);
 extern int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 			       const char *value, size_t v_size);
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 216cad1ff0d0..557aa887996a 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1577,6 +1577,7 @@ static const struct super_operations mqueue_super_ops = {
 
 static const struct fs_context_operations mqueue_fs_context_ops = {
 	.free		= mqueue_fs_context_free,
+	.parse_param	= vfs_parse_sb_flag,
 	.get_tree	= mqueue_get_tree,
 };
 
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 88006be40ea3..f960e6149311 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -927,7 +927,11 @@ int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
 	struct cgroup_subsys *ss;
 	struct fs_parse_result result;
-	int opt, i;
+	int ret, opt, i;
+
+	ret = vfs_parse_sb_flag(fc, param);
+	if (ret != -ENOPARAM)
+		return ret;
 
 	opt = fs_parse(fc, &cgroup1_fs_parameters, param, &result);
 	if (opt == -ENOPARAM) {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index bf9dbffd46b1..93890285b510 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1834,7 +1834,11 @@ static int cgroup2_parse_param(struct fs_context *fc, struct fs_parameter *param
 {
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
 	struct fs_parse_result result;
-	int opt;
+	int ret, opt;
+
+	ret = vfs_parse_sb_flag(fc, param);
+	if (ret != -ENOPARAM)
+		return ret;
 
 	opt = fs_parse(fc, &cgroup2_fs_parameters, param, &result);
 	if (opt < 0)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 515525ff1cfd..025f6c6083a3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -394,6 +394,7 @@ static int cpuset_get_tree(struct fs_context *fc)
 }
 
 static const struct fs_context_operations cpuset_fs_context_ops = {
+	.parse_param	= vfs_parse_sb_flag,
 	.get_tree	= cpuset_get_tree,
 };
 
-- 
2.21.0

