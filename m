Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A822242F01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 21:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgHLTPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 15:15:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49332 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgHLTPg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:15:36 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3242020B4913;
        Wed, 12 Aug 2020 12:15:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3242020B4913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597259735;
        bh=Tenvf2ZFeve+L6GrtHxaPF1KS+dvmSgforU0bSg6Yik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDI5GfNoehUYwtHxuHbI88RgD9f5EAMnNqT5JfFkzYkVmVF5qiTdfTYjsszAQSu12
         rfd/gvzAVn9DEVZvVxX8EPClcKeFznO5qHbIOwgdpU3ZtDjlkzWh1xFNddABKGHIE6
         KLLVBtFR1Afegiow+H3kVMHV8vnykwiPt5tmwQM8=
From:   Daniel Burgener <dburgener@linux.microsoft.com>
To:     selinux@vger.kernel.org
Cc:     stephen.smalley.work@gmail.com, omosnace@redhat.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2 4/4] selinux: Create new booleans and class dirs out of tree
Date:   Wed, 12 Aug 2020 15:15:25 -0400
Message-Id: <20200812191525.1120850-5-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200812191525.1120850-1-dburgener@linux.microsoft.com>
References: <20200812191525.1120850-1-dburgener@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to avoid concurrency issues around selinuxfs resource availability
during policy load, we first create new directories out of tree for
reloaded resources, then swap them in, and finally delete the old versions.

This fix focuses on concurrency in each of the three subtrees swapped, and
not concurrency across the three trees.  This means that it is still possible
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
 security/selinux/selinuxfs.c | 145 +++++++++++++++++++++++++++++------
 1 file changed, 120 insertions(+), 25 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index f09afdb90ddd..d3a19170210a 100644
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
@@ -518,50 +523,108 @@ static const struct file_operations sel_policy_ops = {
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
-	/* policycap_dir cleanup */
-	sel_remove_entries(fsi->policycap_dir);
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
+	struct dentry *tmp_parent, *tmp_bool_dir, *tmp_class_dir, *tmp_policycap_dir, *old_dentry;
+	unsigned int tmp_bool_num, old_bool_num;
+	char **tmp_bool_names, **old_bool_names;
+	unsigned int *tmp_bool_values, *old_bool_values;
+
+	tmp_parent = sel_make_disconnected_dir(fsi->sb, &fsi->last_ino);
+	if (IS_ERR(tmp_parent))
+		return PTR_ERR(tmp_parent);
 
-	sel_remove_old_policy_nodes(fsi);
+	tmp_bool_dir = sel_make_dir(tmp_parent, BOOL_DIR_NAME, &fsi->last_ino);
+	if (IS_ERR(tmp_bool_dir)) {
+		ret = PTR_ERR(tmp_bool_dir);
+		goto out;
+	}
+
+	tmp_class_dir = sel_make_dir(tmp_parent, CLASS_DIR_NAME, &fsi->last_ino);
+	if (IS_ERR(tmp_class_dir)) {
+		ret = PTR_ERR(tmp_class_dir);
+		goto out;
+	}
+
+	tmp_policycap_dir = sel_make_dir(tmp_parent, POLICYCAP_DIR_NAME, &fsi->last_ino);
+	if (IS_ERR(tmp_policycap_dir)) {
+		ret = PTR_ERR(tmp_policycap_dir);
+		goto out;
+	}
 
-	ret = sel_make_bools(newpolicy, fsi->bool_dir, &fsi->bool_num,
-			     &fsi->bool_pending_names, &fsi->bool_pending_values);
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
+	// booleans
+	old_dentry = fsi->bool_dir;
+	lock_rename(tmp_bool_dir, old_dentry);
+	ret = vfs_rename(tmp_parent->d_inode, tmp_bool_dir, fsi->sb->s_root->d_inode,
+			 fsi->bool_dir, NULL, RENAME_EXCHANGE);
+	if (ret) {
+		pr_err("Failed to update boolean directory\n");
+		unlock_rename(tmp_bool_dir, old_dentry);
+		goto out;
+	}
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
+	// classes
+	old_dentry = fsi->class_dir;
+	lock_rename(tmp_class_dir, old_dentry);
+	ret = vfs_rename(tmp_parent->d_inode, tmp_class_dir, fsi->sb->s_root->d_inode,
+			 fsi->class_dir, NULL, RENAME_EXCHANGE);
+	if (ret) {
+		pr_err("Failed to update class directory\n");
+		unlock_rename(tmp_class_dir, old_dentry);
+		goto out;
+	}
+	fsi->class_dir = tmp_class_dir;
+	unlock_rename(tmp_class_dir, old_dentry);
+
+out:
+	// Since the other temporary dirs are children of tmp_parent
+	// this will handle all the cleanup in the case of a failure before
+	// the swapover
+	sel_remove_entries(tmp_parent);
+	dput(tmp_parent); // d_genocide() only handles the children
+
+	return ret;
 }
 
 static ssize_t sel_write_load(struct file *file, const char __user *buf,
@@ -1984,6 +2047,38 @@ static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
 	return dentry;
 }
 
+// vfs_rename() requires a rename operation to be defined.
+int sel_rename(struct inode *old_dir, struct dentry *old_dentry,
+		  struct inode *new_dir, struct dentry *new_dentry,
+		  unsigned int flags)
+{
+	if (!(flags & RENAME_EXCHANGE))
+		return -EINVAL;
+
+	return 0;
+}
+
+const struct inode_operations sel_dir_inode_operations = {
+	.lookup		= simple_lookup,
+	.rename		= sel_rename,
+};
+
+static struct dentry *sel_make_disconnected_dir(struct super_block *sb,
+						unsigned long *ino)
+{
+	struct inode *inode = sel_make_inode(sb, S_IFDIR | S_IRUGO | S_IXUGO);
+
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	inode->i_op = &sel_dir_inode_operations;
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

