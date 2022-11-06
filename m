Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2A461E63B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Nov 2022 22:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKFVIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Nov 2022 16:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiKFVIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:08:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28335E94;
        Sun,  6 Nov 2022 13:08:44 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A6IUAFO011922;
        Sun, 6 Nov 2022 21:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Dqgb6V30u6xH6F66DO7gRqyHAW/t9HZRw8bgLYM5ckw=;
 b=kbNAHBCErfLINFOuOiMPnoow6F32B88f+tjTazQiuPItwxFaLqOFg4jGjJBGnleBifxS
 fGxv0C7G85ivViME9xVq+b0qRDoa4RMlSaTj71Gug7Z0ct/3GK3AxX57IzWt6CiDEl20
 HmXcAkK8oqYvdfcNf7NaoqokjRghSo1ts3ITGhUfKnSGcIpjy/hu4vzlTW70gLjTlnzl
 Gp0unEnMzEQ7XXVSTfK35kuWILVLLwtzGXCppQsYYx3+NGxfW22T5CakTN4t+nGP0nf1
 mPcPyV25jyZLY8iiuJJMh7ssdwpOf0oL9vLjfuoZ59RdGJjvtivgkzsKMWGUMbv04O/P oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp1tecujy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Nov 2022 21:08:17 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A6KtCZS004297;
        Sun, 6 Nov 2022 21:08:17 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp1tecuje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Nov 2022 21:08:16 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A6L5621016614;
        Sun, 6 Nov 2022 21:08:14 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3kngpgh73j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Nov 2022 21:08:14 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A6L8BB837683662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Nov 2022 21:08:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1824A11C050;
        Sun,  6 Nov 2022 21:08:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FDAB11C04C;
        Sun,  6 Nov 2022 21:08:07 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.78.124])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Nov 2022 21:08:07 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, Dov Murik <dovmurik@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Russell Currey <ruscur@russell.cc>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH 2/4] fs: define a firmware security filesystem named fwsecurityfs
Date:   Sun,  6 Nov 2022 16:07:42 -0500
Message-Id: <20221106210744.603240-3-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221106210744.603240-1-nayna@linux.ibm.com>
References: <20221106210744.603240-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K3_cqkK3xbQIHy73A5pjMwCCpwqxa3JZ
X-Proofpoint-ORIG-GUID: k5ARmYELm2Mnq7-NXOeNpwZ_BKzPCB6-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-06_14,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211060188
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

securityfs is meant for Linux security subsystems to expose policies/logs
or any other information. However, there are various firmware security
features which expose their variables for user management via the kernel.
There is currently no single place to expose these variables. Different
platforms use sysfs/platform specific filesystem(efivarfs)/securityfs
interface as they find it appropriate. Thus, there is a gap in kernel
interfaces to expose variables for security features.

Define a firmware security filesystem (fwsecurityfs) to be used by
security features enabled by the firmware. These variables are platform
specific. This filesystem provides platforms a way to implement their
 own underlying semantics by defining own inode and file operations.

Similar to securityfs, the firmware security filesystem is recommended
to be exposed on a well known mount point /sys/firmware/security.
Platforms can define their own directory or file structure under this path.

Example:

# mount -t fwsecurityfs fwsecurityfs /sys/firmware/security

# cd /sys/firmware/security/

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 fs/Kconfig                   |   1 +
 fs/Makefile                  |   1 +
 fs/fwsecurityfs/Kconfig      |  14 ++
 fs/fwsecurityfs/Makefile     |  10 ++
 fs/fwsecurityfs/super.c      | 263 +++++++++++++++++++++++++++++++++++
 include/linux/fwsecurityfs.h |  29 ++++
 include/uapi/linux/magic.h   |   1 +
 7 files changed, 319 insertions(+)
 create mode 100644 fs/fwsecurityfs/Kconfig
 create mode 100644 fs/fwsecurityfs/Makefile
 create mode 100644 fs/fwsecurityfs/super.c
 create mode 100644 include/linux/fwsecurityfs.h

diff --git a/fs/Kconfig b/fs/Kconfig
index 2685a4d0d353..2a24f1c779dd 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -275,6 +275,7 @@ config ARCH_HAS_GIGANTIC_PAGE
 
 source "fs/configfs/Kconfig"
 source "fs/efivarfs/Kconfig"
+source "fs/fwsecurityfs/Kconfig"
 
 endmenu
 
diff --git a/fs/Makefile b/fs/Makefile
index 4dea17840761..b945019a9bbe 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -134,6 +134,7 @@ obj-$(CONFIG_F2FS_FS)		+= f2fs/
 obj-$(CONFIG_CEPH_FS)		+= ceph/
 obj-$(CONFIG_PSTORE)		+= pstore/
 obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
+obj-$(CONFIG_FWSECURITYFS)		+= fwsecurityfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
diff --git a/fs/fwsecurityfs/Kconfig b/fs/fwsecurityfs/Kconfig
new file mode 100644
index 000000000000..1dc2ee831eda
--- /dev/null
+++ b/fs/fwsecurityfs/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2022 IBM Corporation
+# Author: Nayna Jain <nayna@linux.ibm.com>
+#
+
+config FWSECURITYFS
+	bool "Enable the fwsecurityfs filesystem"
+	help
+	  This will build fwsecurityfs filesystem which should be mounted
+	  on /sys/firmware/security. This filesystem can be used by
+	  platform to expose firmware-managed variables.
+
+	  If you are unsure how to answer this question, answer N.
diff --git a/fs/fwsecurityfs/Makefile b/fs/fwsecurityfs/Makefile
new file mode 100644
index 000000000000..5c7b76228ebb
--- /dev/null
+++ b/fs/fwsecurityfs/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2022 IBM Corporation
+# Author: Nayna Jain <nayna@linux.ibm.com>
+#
+# Makefile for the firmware security filesystem
+
+obj-$(CONFIG_FWSECURITYFS)		+= fwsecurityfs.o
+
+fwsecurityfs-objs			:= super.o
diff --git a/fs/fwsecurityfs/super.c b/fs/fwsecurityfs/super.c
new file mode 100644
index 000000000000..99ca4da4ab63
--- /dev/null
+++ b/fs/fwsecurityfs/super.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ */
+
+#include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/pagemap.h>
+#include <linux/init.h>
+#include <linux/namei.h>
+#include <linux/magic.h>
+#include <linux/fwsecurityfs.h>
+
+static struct super_block *fwsecsb;
+static struct vfsmount *mount;
+static int mount_count;
+static bool fwsecurityfs_initialized;
+
+static void fwsecurityfs_free_inode(struct inode *inode)
+{
+	free_inode_nonrcu(inode);
+}
+
+static const struct super_operations fwsecurityfs_super_operations = {
+	.statfs = simple_statfs,
+	.free_inode = fwsecurityfs_free_inode,
+};
+
+static int fwsecurityfs_fill_super(struct super_block *sb,
+				   struct fs_context *fc)
+{
+	static const struct tree_descr files[] = {{""}};
+	int rc;
+
+	rc = simple_fill_super(sb, FWSECURITYFS_MAGIC, files);
+	if (rc)
+		return rc;
+
+	sb->s_op = &fwsecurityfs_super_operations;
+
+	fwsecsb = sb;
+
+	rc = arch_fwsecurityfs_init();
+
+	if (!rc)
+		fwsecurityfs_initialized = true;
+
+	return rc;
+}
+
+static int fwsecurityfs_get_tree(struct fs_context *fc)
+{
+	return get_tree_single(fc, fwsecurityfs_fill_super);
+}
+
+static const struct fs_context_operations fwsecurityfs_context_ops = {
+	.get_tree	= fwsecurityfs_get_tree,
+};
+
+static int fwsecurityfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &fwsecurityfs_context_ops;
+
+	return 0;
+}
+
+static void fwsecurityfs_kill_sb(struct super_block *sb)
+{
+	kill_litter_super(sb);
+
+	fwsecurityfs_initialized = false;
+}
+
+static struct file_system_type fs_type = {
+	.owner =	THIS_MODULE,
+	.name =		"fwsecurityfs",
+	.init_fs_context = fwsecurityfs_init_fs_context,
+	.kill_sb =	fwsecurityfs_kill_sb,
+};
+
+static struct dentry *fwsecurityfs_create_dentry(const char *name, umode_t mode,
+						 u16 filesize,
+						 struct dentry *parent,
+						 struct dentry *dentry, void *data,
+						 const struct file_operations *fops,
+						 const struct inode_operations *iops)
+{
+	struct inode *inode;
+	int rc;
+	struct inode *dir;
+	struct dentry *ldentry = dentry;
+
+	/* Calling simple_pin_fs() while initial mount in progress results in recursive
+	 * call to mount.
+	 */
+	if (fwsecurityfs_initialized) {
+		rc = simple_pin_fs(&fs_type, &mount, &mount_count);
+		if (rc)
+			return ERR_PTR(rc);
+	}
+
+	dir = d_inode(parent);
+
+	/* For userspace created files, lock is already taken. */
+	if (!dentry)
+		inode_lock(dir);
+
+	if (!dentry) {
+		ldentry = lookup_one_len(name, parent, strlen(name));
+		if (IS_ERR(ldentry))
+			goto out;
+
+		if (d_really_is_positive(ldentry)) {
+			rc = -EEXIST;
+			goto out1;
+		}
+	}
+
+	inode = new_inode(dir->i_sb);
+	if (!inode) {
+		rc = -ENOMEM;
+		goto out1;
+	}
+
+	inode->i_ino = get_next_ino();
+	inode->i_mode = mode;
+	inode->i_atime = current_time(inode);
+	inode->i_mtime = current_time(inode);
+	inode->i_ctime = current_time(inode);
+	inode->i_private = data;
+
+	if (S_ISDIR(mode)) {
+		inode->i_op = iops ? iops : &simple_dir_inode_operations;
+		inode->i_fop = &simple_dir_operations;
+		inc_nlink(inode);
+		inc_nlink(dir);
+	} else {
+		inode->i_fop = fops ? fops : &simple_dir_operations;
+	}
+
+	if (S_ISREG(mode)) {
+		inode_lock(inode);
+		i_size_write(inode, filesize);
+		inode_unlock(inode);
+	}
+	d_instantiate(ldentry, inode);
+
+	/* dget() here is required for userspace created files. */
+	if (dentry)
+		dget(ldentry);
+
+	if (!dentry)
+		inode_unlock(dir);
+
+	return ldentry;
+
+out1:
+	ldentry = ERR_PTR(rc);
+
+out:
+	if (fwsecurityfs_initialized)
+		simple_release_fs(&mount, &mount_count);
+
+	if (!dentry)
+		inode_unlock(dir);
+
+	return ldentry;
+}
+
+struct dentry *fwsecurityfs_create_file(const char *name, umode_t mode,
+					u16 filesize, struct dentry *parent,
+					struct dentry *dentry, void *data,
+					const struct file_operations *fops)
+{
+	if (!parent)
+		return ERR_PTR(-EINVAL);
+
+	return fwsecurityfs_create_dentry(name, mode, filesize, parent,
+					  dentry, data, fops, NULL);
+}
+EXPORT_SYMBOL_GPL(fwsecurityfs_create_file);
+
+struct dentry *fwsecurityfs_create_dir(const char *name, umode_t mode,
+				       struct dentry *parent,
+				       const struct inode_operations *iops)
+{
+	if (!parent) {
+		if (!fwsecsb)
+			return ERR_PTR(-EIO);
+		parent = fwsecsb->s_root;
+	}
+
+	return fwsecurityfs_create_dentry(name, mode, 0, parent, NULL, NULL,
+					  NULL, iops);
+}
+EXPORT_SYMBOL_GPL(fwsecurityfs_create_dir);
+
+static int fwsecurityfs_remove_dentry(struct dentry *dentry)
+{
+	struct inode *dir;
+
+	if (!dentry || IS_ERR(dentry))
+		return -EINVAL;
+
+	dir = d_inode(dentry->d_parent);
+	inode_lock(dir);
+	if (simple_positive(dentry)) {
+		dget(dentry);
+		if (d_is_dir(dentry))
+			simple_rmdir(dir, dentry);
+		else
+			simple_unlink(dir, dentry);
+		d_delete(dentry);
+		dput(dentry);
+	}
+	inode_unlock(dir);
+
+	/* Once fwsecurityfs_initialized is set to true, calling this for
+	 * removing files created during initial mount might result in
+	 * imbalance of simple_pin_fs() and simple_release_fs() calls.
+	 */
+	if (fwsecurityfs_initialized)
+		simple_release_fs(&mount, &mount_count);
+
+	return 0;
+}
+
+int fwsecurityfs_remove_dir(struct dentry *dentry)
+{
+	if (!d_is_dir(dentry))
+		return -EPERM;
+
+	return fwsecurityfs_remove_dentry(dentry);
+}
+EXPORT_SYMBOL_GPL(fwsecurityfs_remove_dir);
+
+int fwsecurityfs_remove_file(struct dentry *dentry)
+{
+	return fwsecurityfs_remove_dentry(dentry);
+};
+EXPORT_SYMBOL_GPL(fwsecurityfs_remove_file);
+
+static int __init fwsecurityfs_init(void)
+{
+	int rc;
+
+	rc = sysfs_create_mount_point(firmware_kobj, "security");
+	if (rc)
+		return rc;
+
+	rc = register_filesystem(&fs_type);
+	if (rc) {
+		sysfs_remove_mount_point(firmware_kobj, "security");
+		return rc;
+	}
+
+	return 0;
+}
+core_initcall(fwsecurityfs_init);
+MODULE_DESCRIPTION("Firmware Security Filesystem");
+MODULE_AUTHOR("Nayna Jain");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/fwsecurityfs.h b/include/linux/fwsecurityfs.h
new file mode 100644
index 000000000000..ed8f328f3133
--- /dev/null
+++ b/include/linux/fwsecurityfs.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ */
+
+#ifndef _FWSECURITYFS_H_
+#define _FWSECURITYFS_H_
+
+#include <linux/ctype.h>
+#include <linux/fs.h>
+
+struct dentry *fwsecurityfs_create_file(const char *name, umode_t mode,
+					u16 filesize, struct dentry *parent,
+					struct dentry *dentry, void *data,
+					const struct file_operations *fops);
+
+int fwsecurityfs_remove_file(struct dentry *dentry);
+struct dentry *fwsecurityfs_create_dir(const char *name, umode_t mode,
+				       struct dentry *parent,
+				       const struct inode_operations *iops);
+int fwsecurityfs_remove_dir(struct dentry *dentry);
+
+static int arch_fwsecurityfs_init(void)
+{
+	return 0;
+}
+
+#endif /* _FWSECURITYFS_H_ */
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 6325d1d0e90f..553a5fdfabce 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -53,6 +53,7 @@
 #define QNX4_SUPER_MAGIC	0x002f		/* qnx4 fs detection */
 #define QNX6_SUPER_MAGIC	0x68191122	/* qnx6 fs detection */
 #define AFS_FS_MAGIC		0x6B414653
+#define FWSECURITYFS_MAGIC         0x5345434e      /* "SECM" */
 
 
 #define REISERFS_SUPER_MAGIC	0x52654973	/* used by gcc */
-- 
2.31.1

