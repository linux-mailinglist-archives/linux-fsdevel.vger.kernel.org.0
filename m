Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FE624A757
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 21:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgHST7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 15:59:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39376 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgHST7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:59:47 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id CAB9320B4916;
        Wed, 19 Aug 2020 12:59:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CAB9320B4916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597867185;
        bh=bhtC4hraLLqdJvCVeKNMgBWQSmvZ3EnyjyD8Sd7gMjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TbWtaEzYorqxgwuhmVpLEXLn7V50+EzIhzGJz/wEd7QdkdBph/ObElNUilw/1mffB
         yewaPjjpDwfro3D/fWcw2xyEONww47UaqwAKhPaLqQbjFGRZTbSu8oXCuImQoSyzdv
         HUMytyIG0EPjmKmLPjJAayKfjJ2uSk56kPQG00jc=
From:   Daniel Burgener <dburgener@linux.microsoft.com>
To:     selinux@vger.kernel.org
Cc:     stephen.smalley.work@gmail.com, omosnace@redhat.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH v3 4/4] selinux: Create new booleans and class dirs out of tree
Date:   Wed, 19 Aug 2020 15:59:35 -0400
Message-Id: <20200819195935.1720168-5-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200819195935.1720168-1-dburgener@linux.microsoft.com>
References: <20200819195935.1720168-1-dburgener@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to avoid concurrency issues around selinuxfs resource availability
during policy load, we first create new directories out of tree for
reloaded resources, then swap them in, and finally delete the old versions.

This fix focuses on concurrency in each of the two subtrees swapped, and
not concurrency between the trees.  This means that it is still possible
that subsequent reads to eg the booleans directory and the class directory
during a policy load could see the old state for one and the new for the other.
The problem of ensuring that policy loads are fully atomic from the perspective
of userspace is larger than what is dealt with here.  This commit focuses on
ensuring that the directories contents always match either the new or the old
policy state from the perspective of userspace.

In the previous implementation, on policy load /sys/fs/selinux is updated
by deleting the previous contents of
/sys/fs/selinux/{class,booleans} and then recreating them.  This means
that there is a period of time when the contents of these directories do not
exist which can cause race conditions as userspace relies on them for
information about the policy.  In addition, it means that error recovery in
the event of failure is challenging.

In order to demonstrate the race condition that this series fixes, you
can use the following commands:

while true; do cat /sys/fs/selinux/class/service/perms/status
>/dev/null; done &
while true; do load_policy; done;

In the existing code, this will display errors fairly often as the class
lookup fails.  (In normal operation from systemd, this would result in a
permission check which would be allowed or denied based on policy settings
around unknown object classes.) After applying this patch series you
should expect to no longer see such error messages.

Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
---
 security/selinux/selinuxfs.c | 113 ++++++++++++++++++++++++++++-------
 1 file changed, 90 insertions(+), 23 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 2a0e8b5f19d5..d1872adf0c47 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -20,6 +20,7 @@
 #include <linux/fs_context.h>
 #include <linux/mount.h>
 #include <linux/mutex.h>
+#include <linux/namei.h>
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/security.h>
@@ -361,7 +362,11 @@ static int sel_make_classes(struct selinux_policy *newpolicy,
 static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
 			unsigned long *ino);
 
-/* declaration for sel_remove_old_policy_nodes */
+/* declaration for sel_make_policy_nodes */
+static struct dentry *sel_make_disconnected_dir(struct super_block *sb,
+						unsigned long *ino);
+
+/* declaration for sel_make_policy_nodes */
 static void sel_remove_entries(struct dentry *de);
 
 static ssize_t sel_read_mls(struct file *filp, char __user *buf,
@@ -518,48 +523,94 @@ static const struct file_operations sel_policy_ops = {
 	.llseek		= generic_file_llseek,
 };
 
-static void sel_remove_old_policy_nodes(struct selinux_fs_info *fsi)
+static void sel_remove_old_bool_data(unsigned int bool_num, char **bool_names,
+				unsigned int *bool_values)
 {
 	u32 i;
 
 	/* bool_dir cleanup */
-	for (i = 0; i < fsi->bool_num; i++)
-		kfree(fsi->bool_pending_names[i]);
-	kfree(fsi->bool_pending_names);
-	kfree(fsi->bool_pending_values);
-	fsi->bool_num = 0;
-	fsi->bool_pending_names = NULL;
-	fsi->bool_pending_values = NULL;
-
-	sel_remove_entries(fsi->bool_dir);
-
-	/* class_dir cleanup */
-	sel_remove_entries(fsi->class_dir);
-
+	for (i = 0; i < bool_num; i++)
+		kfree(bool_names[i]);
+	kfree(bool_names);
+	kfree(bool_values);
 }
 
 static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 				struct selinux_policy *newpolicy)
 {
-	int ret;
+	int ret = 0;
+	struct dentry *tmp_parent, *tmp_bool_dir, *tmp_class_dir, *old_dentry;
+	unsigned int tmp_bool_num, old_bool_num;
+	char **tmp_bool_names, **old_bool_names;
+	unsigned int *tmp_bool_values, *old_bool_values;
+	unsigned long tmp_ino = fsi->last_ino; /* Don't increment last_ino in this function */
 
-	sel_remove_old_policy_nodes(fsi);
+	tmp_parent = sel_make_disconnected_dir(fsi->sb, &tmp_ino);
+	if (IS_ERR(tmp_parent))
+		return PTR_ERR(tmp_parent);
 
-	ret = sel_make_bools(newpolicy, fsi->bool_dir, &fsi->bool_num,
-			     &fsi->bool_pending_names, &fsi->bool_pending_values);
+	tmp_ino = fsi->bool_dir->d_inode->i_ino - 1; /* sel_make_dir will increment and set */
+	tmp_bool_dir = sel_make_dir(tmp_parent, BOOL_DIR_NAME, &tmp_ino);
+	if (IS_ERR(tmp_bool_dir)) {
+		ret = PTR_ERR(tmp_bool_dir);
+		goto out;
+	}
+
+	tmp_ino = fsi->class_dir->d_inode->i_ino - 1; /* sel_make_dir will increment and set */
+	tmp_class_dir = sel_make_dir(tmp_parent, CLASS_DIR_NAME, &tmp_ino);
+	if (IS_ERR(tmp_class_dir)) {
+		ret = PTR_ERR(tmp_class_dir);
+		goto out;
+	}
+
+	ret = sel_make_bools(newpolicy, tmp_bool_dir, &tmp_bool_num,
+			     &tmp_bool_names, &tmp_bool_values);
 	if (ret) {
 		pr_err("SELinux: failed to load policy booleans\n");
-		return ret;
+		goto out;
 	}
 
-	ret = sel_make_classes(newpolicy, fsi->class_dir,
+	ret = sel_make_classes(newpolicy, tmp_class_dir,
 			       &fsi->last_class_ino);
 	if (ret) {
 		pr_err("SELinux: failed to load policy classes\n");
-		return ret;
+		goto out;
 	}
 
-	return 0;
+	/* booleans */
+	old_dentry = fsi->bool_dir;
+	lock_rename(tmp_bool_dir, old_dentry);
+	d_exchange(tmp_bool_dir, fsi->bool_dir);
+
+	old_bool_num = fsi->bool_num;
+	old_bool_names = fsi->bool_pending_names;
+	old_bool_values = fsi->bool_pending_values;
+
+	fsi->bool_num = tmp_bool_num;
+	fsi->bool_pending_names = tmp_bool_names;
+	fsi->bool_pending_values = tmp_bool_values;
+
+	sel_remove_old_bool_data(old_bool_num, old_bool_names, old_bool_values);
+
+	fsi->bool_dir = tmp_bool_dir;
+	unlock_rename(tmp_bool_dir, old_dentry);
+
+	/* classes */
+	old_dentry = fsi->class_dir;
+	lock_rename(tmp_class_dir, old_dentry);
+	d_exchange(tmp_class_dir, fsi->class_dir);
+	fsi->class_dir = tmp_class_dir;
+	unlock_rename(tmp_class_dir, old_dentry);
+
+out:
+	/* Since the other temporary dirs are children of tmp_parent
+	 * this will handle all the cleanup in the case of a failure before
+	 * the swapover
+	 */
+	sel_remove_entries(tmp_parent);
+	dput(tmp_parent); /* d_genocide() only handles the children */
+
+	return ret;
 }
 
 static ssize_t sel_write_load(struct file *file, const char __user *buf,
@@ -1982,6 +2033,22 @@ static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
 	return dentry;
 }
 
+static struct dentry *sel_make_disconnected_dir(struct super_block *sb,
+						unsigned long *ino)
+{
+	struct inode *inode = sel_make_inode(sb, S_IFDIR | S_IRUGO | S_IXUGO);
+
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	inode->i_ino = ++(*ino);
+	/* directory inodes start off with i_nlink == 2 (for "." entry) */
+	inc_nlink(inode);
+	return d_obtain_alias(inode);
+}
+
 #define NULL_FILE_NAME "null"
 
 static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
-- 
2.25.4

