Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812A1242EFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 21:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgHLTPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 15:15:36 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49308 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgHLTPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:15:35 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id 99B6220B490D;
        Wed, 12 Aug 2020 12:15:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 99B6220B490D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597259734;
        bh=h0J5zXRS82FdnJWHfZ2GyfbHIqLimH6f5CETRRANugM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IPTNf+AAB/gHjcp2nEVZ6YE01NMHqQtqWFgNJwZIqNz/7TOAX7osA0GmBz4Nc6Xn0
         yxQyzxWltKqjadSD71S8O00cedJjVAV0Z3qBhmEb2s49vO2o77OQi4n80GwzjRV19C
         L6WkY/oxHDSpefMCYmHlDx66SVcqQtePhVxmuT78=
From:   Daniel Burgener <dburgener@linux.microsoft.com>
To:     selinux@vger.kernel.org
Cc:     stephen.smalley.work@gmail.com, omosnace@redhat.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2 2/4] selinux: Refactor selinuxfs directory populating functions
Date:   Wed, 12 Aug 2020 15:15:23 -0400
Message-Id: <20200812191525.1120850-3-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200812191525.1120850-1-dburgener@linux.microsoft.com>
References: <20200812191525.1120850-1-dburgener@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make sel_make_bools and sel_make_classes take the specific elements of
selinux_fs_info that they need rather than the entire struct.

This will allow a future patch to pass temporary elements that are not in
the selinux_fs_info struct to these functions so that the original elements
can be preserved until we are ready to perform the switch over.

Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
---
 security/selinux/selinuxfs.c | 45 ++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index fc914facb48f..9657c3acfc8f 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -346,10 +346,12 @@ static const struct file_operations sel_policyvers_ops = {
 };
 
 /* declaration for sel_write_load */
-static int sel_make_bools(struct selinux_fs_info *fsi,
-			struct selinux_policy *newpolicy);
-static int sel_make_classes(struct selinux_fs_info *fsi,
-			struct selinux_policy *newpolicy);
+static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_dir,
+			  unsigned int *bool_num, char ***bool_pending_names,
+			  unsigned int **bool_pending_values);
+static int sel_make_classes(struct selinux_policy *newpolicy,
+			    struct dentry *class_dir,
+			    unsigned long *last_class_ino);
 
 /* declaration for sel_make_class_dirs */
 static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
@@ -541,13 +543,15 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 
 	sel_remove_old_policy_nodes(fsi);
 
-	ret = sel_make_bools(fsi, newpolicy);
+	ret = sel_make_bools(newpolicy, fsi->bool_dir, &fsi->bool_num,
+			     &fsi->bool_pending_names, &fsi->bool_pending_values);
 	if (ret) {
 		pr_err("SELinux: failed to load policy booleans\n");
 		return ret;
 	}
 
-	ret = sel_make_classes(fsi, newpolicy);
+	ret = sel_make_classes(newpolicy, fsi->class_dir,
+			       &fsi->last_class_ino);
 	if (ret) {
 		pr_err("SELinux: failed to load policy classes\n");
 		return ret;
@@ -1361,13 +1365,13 @@ static void sel_remove_entries(struct dentry *de)
 
 #define BOOL_DIR_NAME "booleans"
 
-static int sel_make_bools(struct selinux_fs_info *fsi,
-			struct selinux_policy *newpolicy)
+static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_dir,
+			  unsigned int *bool_num, char ***bool_pending_names,
+			  unsigned int **bool_pending_values)
 {
 	int ret;
 	ssize_t len;
 	struct dentry *dentry = NULL;
-	struct dentry *dir = fsi->bool_dir;
 	struct inode *inode = NULL;
 	struct inode_security_struct *isec;
 	char **names = NULL, *page;
@@ -1386,12 +1390,12 @@ static int sel_make_bools(struct selinux_fs_info *fsi,
 
 	for (i = 0; i < num; i++) {
 		ret = -ENOMEM;
-		dentry = d_alloc_name(dir, names[i]);
+		dentry = d_alloc_name(bool_dir, names[i]);
 		if (!dentry)
 			goto out;
 
 		ret = -ENOMEM;
-		inode = sel_make_inode(dir->d_sb, S_IFREG | S_IRUGO | S_IWUSR);
+		inode = sel_make_inode(bool_dir->d_sb, S_IFREG | S_IRUGO | S_IWUSR);
 		if (!inode) {
 			dput(dentry);
 			goto out;
@@ -1420,9 +1424,9 @@ static int sel_make_bools(struct selinux_fs_info *fsi,
 		inode->i_ino = i|SEL_BOOL_INO_OFFSET;
 		d_add(dentry, inode);
 	}
-	fsi->bool_num = num;
-	fsi->bool_pending_names = names;
-	fsi->bool_pending_values = values;
+	*bool_num = num;
+	*bool_pending_names = names;
+	*bool_pending_values = values;
 
 	free_page((unsigned long)page);
 	return 0;
@@ -1435,7 +1439,7 @@ static int sel_make_bools(struct selinux_fs_info *fsi,
 		kfree(names);
 	}
 	kfree(values);
-	sel_remove_entries(dir);
+	sel_remove_entries(bool_dir);
 
 	return ret;
 }
@@ -1882,8 +1886,9 @@ static int sel_make_class_dir_entries(struct selinux_policy *newpolicy,
 	return rc;
 }
 
-static int sel_make_classes(struct selinux_fs_info *fsi,
-			struct selinux_policy *newpolicy)
+static int sel_make_classes(struct selinux_policy *newpolicy,
+			    struct dentry *class_dir,
+			    unsigned long *last_class_ino)
 {
 
 	int rc, nclasses, i;
@@ -1894,13 +1899,13 @@ static int sel_make_classes(struct selinux_fs_info *fsi,
 		return rc;
 
 	/* +2 since classes are 1-indexed */
-	fsi->last_class_ino = sel_class_to_ino(nclasses + 2);
+	*last_class_ino = sel_class_to_ino(nclasses + 2);
 
 	for (i = 0; i < nclasses; i++) {
 		struct dentry *class_name_dir;
 
-		class_name_dir = sel_make_dir(fsi->class_dir, classes[i],
-					      &fsi->last_class_ino);
+		class_name_dir = sel_make_dir(class_dir, classes[i],
+					      last_class_ino);
 		if (IS_ERR(class_name_dir)) {
 			rc = PTR_ERR(class_name_dir);
 			goto out;
-- 
2.25.4

