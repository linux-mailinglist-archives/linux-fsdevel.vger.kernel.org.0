Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44410556E13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 23:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiFVV5q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 17:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiFVV5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 17:57:43 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3D44091F;
        Wed, 22 Jun 2022 14:57:42 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MKPnKh000352;
        Wed, 22 Jun 2022 21:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yO69ITjOfpZ5Nfv0+ek3fE3ZRMt15oT6xMQwVNQEC6A=;
 b=tiK+9gTtrLH4YNGlXPAythyCJZ2kpjw1NkIx1Q4TFdgF2J59hjgneM0TBr0X/Yt0q27b
 rXJpRRtLGcc3dPvLZCLYr3BzusHLTNwexW+Vm16M8z15sJechKQUeVQ1CBqESIBXR9xQ
 TegGprBBs7Sp1YeNhSZmXv+XUMMt2UWcZ5OnMSZbFQr8p74/omcLBL9x93KzeOQSxE4g
 +xNn2zEaEeOs2FN9Nd+c50t3UeS/Ihz7cpYEfhAnpFcqG8cpfdE66jHsZenJZd2XOM5w
 5a5bFPuZlOVSYtgd1N58OHodKmLPQ7neVOUXwpTAtzPOIeSxR6sMlksbbL8rloPPT1Lh Yg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gva3y2mx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 21:57:14 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25MLqDDf007944;
        Wed, 22 Jun 2022 21:57:12 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3gs6b9682k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 21:57:12 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25MLv9aK21102944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 21:57:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4769CA4051;
        Wed, 22 Jun 2022 21:57:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BA2DA4040;
        Wed, 22 Jun 2022 21:57:06 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.125.38])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jun 2022 21:57:05 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dov Murik <dovmurik@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>, gjoyce@ibm.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [RFC PATCH v2 2/3] fs: define a firmware security filesystem named fwsecurityfs
Date:   Wed, 22 Jun 2022 17:56:47 -0400
Message-Id: <20220622215648.96723-3-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220622215648.96723-1-nayna@linux.ibm.com>
References: <20220622215648.96723-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YA5a0H2NLYPnmgTKDUfzyKHq307nadwo
X-Proofpoint-GUID: YA5a0H2NLYPnmgTKDUfzyKHq307nadwo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_08,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

securityfs is meant for linux security subsystems to expose policies/logs
or any other information. However, there are various firmware security
features which expose their variables for user management via kernel.
There is currently no single place to expose these variables. Different
platforms use sysfs/platform specific filesystem(efivarfs)/securityfs
interface as find appropriate. Thus, there is a gap in kernel interfaces
to expose variables for security features.

Define a firmware security filesystem (fwsecurityfs) to be used for
exposing variables managed by firmware and to be used by firmware
enabled security features. These variables are platform specific.
Filesystem provides platforms to implement their own underlying
semantics by defining own inode and file operations.

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
 fs/fwsecurityfs/Kconfig      |  14 +++
 fs/fwsecurityfs/Makefile     |  10 +++
 fs/fwsecurityfs/inode.c      | 159 +++++++++++++++++++++++++++++++++++
 fs/fwsecurityfs/internal.h   |  13 +++
 fs/fwsecurityfs/super.c      | 154 +++++++++++++++++++++++++++++++++
 include/linux/fwsecurityfs.h |  29 +++++++
 include/uapi/linux/magic.h   |   1 +
 9 files changed, 382 insertions(+)
 create mode 100644 fs/fwsecurityfs/Kconfig
 create mode 100644 fs/fwsecurityfs/Makefile
 create mode 100644 fs/fwsecurityfs/inode.c
 create mode 100644 fs/fwsecurityfs/internal.h
 create mode 100644 fs/fwsecurityfs/super.c
 create mode 100644 include/linux/fwsecurityfs.h

diff --git a/fs/Kconfig b/fs/Kconfig
index 5976eb33535f..19ea28143428 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -276,6 +276,7 @@ config ARCH_HAS_GIGANTIC_PAGE
 
 source "fs/configfs/Kconfig"
 source "fs/efivarfs/Kconfig"
+source "fs/fwsecurityfs/Kconfig"
 
 endmenu
 
diff --git a/fs/Makefile b/fs/Makefile
index 208a74e0b00e..5792cd0443cb 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -137,6 +137,7 @@ obj-$(CONFIG_F2FS_FS)		+= f2fs/
 obj-$(CONFIG_CEPH_FS)		+= ceph/
 obj-$(CONFIG_PSTORE)		+= pstore/
 obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
+obj-$(CONFIG_FWSECURITYFS)		+= fwsecurityfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
diff --git a/fs/fwsecurityfs/Kconfig b/fs/fwsecurityfs/Kconfig
new file mode 100644
index 000000000000..f1665511eeb9
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
+	  This will build the fwsecurityfs file system which is recommended
+	  to be mounted on /sys/firmware/security. This can be used by
+	  platforms to expose their variables which are managed by firmware.
+
+	  If you are unsure how to answer this question, answer N.
diff --git a/fs/fwsecurityfs/Makefile b/fs/fwsecurityfs/Makefile
new file mode 100644
index 000000000000..b9931d180178
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
+fwsecurityfs-objs			:= inode.o super.o
diff --git a/fs/fwsecurityfs/inode.c b/fs/fwsecurityfs/inode.c
new file mode 100644
index 000000000000..5d06dc0de059
--- /dev/null
+++ b/fs/fwsecurityfs/inode.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ */
+
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+#include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/mount.h>
+#include <linux/pagemap.h>
+#include <linux/init.h>
+#include <linux/namei.h>
+#include <linux/security.h>
+#include <linux/lsm_hooks.h>
+#include <linux/magic.h>
+#include <linux/ctype.h>
+#include <linux/fwsecurityfs.h>
+
+#include "internal.h"
+
+int fwsecurityfs_remove_file(struct dentry *dentry)
+{
+	drop_nlink(d_inode(dentry));
+	dput(dentry);
+	return 0;
+};
+EXPORT_SYMBOL_GPL(fwsecurityfs_remove_file);
+
+int fwsecurityfs_create_file(const char *name, umode_t mode,
+					u16 filesize, struct dentry *parent,
+					struct dentry *dentry,
+					const struct file_operations *fops)
+{
+	struct inode *inode;
+	int error;
+	struct inode *dir;
+
+	if (!parent)
+		return -EINVAL;
+
+	dir = d_inode(parent);
+	pr_debug("securityfs: creating file '%s'\n", name);
+
+	inode = new_inode(dir->i_sb);
+	if (!inode) {
+		error = -ENOMEM;
+		goto out1;
+	}
+
+	inode->i_ino = get_next_ino();
+	inode->i_mode = mode;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+
+	if (fops)
+		inode->i_fop = fops;
+	else
+		inode->i_fop = &simple_dir_operations;
+
+	if (!dentry) {
+		dentry = fwsecurityfs_alloc_dentry(parent, name);
+		if (IS_ERR(dentry)) {
+			error = PTR_ERR(dentry);
+			goto out;
+		}
+	}
+
+	inode_lock(inode);
+	i_size_write(inode, filesize);
+	d_instantiate(dentry, inode);
+	dget(dentry);
+	d_add(dentry, inode);
+	inode_unlock(inode);
+	return 0;
+
+out1:
+	if (dentry)
+		dput(dentry);
+out:
+	return error;
+}
+EXPORT_SYMBOL_GPL(fwsecurityfs_create_file);
+
+struct dentry *fwsecurityfs_create_dir(const char *name, umode_t mode,
+				       struct dentry *parent,
+				       const struct inode_operations *iops)
+{
+	struct dentry *dentry;
+	struct inode *inode;
+	int error;
+	struct inode *dir;
+	struct super_block *fwsecsb;
+
+	if (!parent) {
+		fwsecsb = fwsecurityfs_get_superblock();
+		if (!fwsecsb)
+			return ERR_PTR(-EIO);
+		parent = fwsecsb->s_root;
+	}
+
+	dir = d_inode(parent);
+
+	inode_lock(dir);
+	dentry = lookup_one_len(name, parent, strlen(name));
+	if (IS_ERR(dentry))
+		goto out;
+
+	inode = new_inode(dir->i_sb);
+	if (!inode) {
+		error = -ENOMEM;
+		goto out1;
+	}
+
+	inode->i_ino = get_next_ino();
+	inode->i_mode = mode;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	if (iops)
+		inode->i_op = iops;
+	else
+		inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	inc_nlink(inode);
+	inc_nlink(dir);
+	d_instantiate(dentry, inode);
+	dget(dentry);
+	inode_unlock(dir);
+	return dentry;
+
+out1:
+	dput(dentry);
+	dentry = ERR_PTR(error);
+out:
+	inode_unlock(dir);
+	return dentry;
+}
+EXPORT_SYMBOL_GPL(fwsecurityfs_create_dir);
+
+int fwsecurityfs_remove_dir(struct dentry *dentry)
+{
+	struct inode *dir;
+
+	if (!dentry || IS_ERR(dentry))
+		return -EINVAL;
+
+	if (!d_is_dir(dentry))
+		return -EPERM;
+
+	dir = d_inode(dentry->d_parent);
+	inode_lock(dir);
+	if (simple_positive(dentry)) {
+		simple_rmdir(dir, dentry);
+		dput(dentry);
+	}
+	inode_unlock(dir);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fwsecurityfs_remove_dir);
diff --git a/fs/fwsecurityfs/internal.h b/fs/fwsecurityfs/internal.h
new file mode 100644
index 000000000000..b73f6d4b9504
--- /dev/null
+++ b/fs/fwsecurityfs/internal.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ */
+
+#ifndef __FWSECURITYFS_INTERNAL_H
+#define __FWSECURITYFS_INTERNAL_H
+
+struct dentry *fwsecurityfs_alloc_dentry(struct dentry *parent,
+					 const char *name);
+
+#endif
diff --git a/fs/fwsecurityfs/super.c b/fs/fwsecurityfs/super.c
new file mode 100644
index 000000000000..9930889c22a5
--- /dev/null
+++ b/fs/fwsecurityfs/super.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ */
+
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+#include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/mount.h>
+#include <linux/pagemap.h>
+#include <linux/init.h>
+#include <linux/namei.h>
+#include <linux/security.h>
+#include <linux/lsm_hooks.h>
+#include <linux/magic.h>
+#include <linux/ctype.h>
+#include <linux/fwsecurityfs.h>
+
+#include "internal.h"
+
+static struct super_block *fwsecsb;
+
+struct super_block *fwsecurityfs_get_superblock(void)
+{
+	return fwsecsb;
+}
+
+static int fwsecurityfs_d_hash(const struct dentry *dir, struct qstr *this)
+{
+	unsigned long hash;
+	int i;
+
+	hash = init_name_hash(dir);
+	for (i = 0; i < this->len; i++)
+		hash = partial_name_hash(tolower(this->name[i]), hash);
+	this->hash = end_name_hash(hash);
+
+	return 0;
+}
+
+static int fwsecurityfs_d_compare(const struct dentry *dentry,
+				  unsigned int len, const char *str,
+				  const struct qstr *name)
+{
+	int i;
+	int result = 1;
+
+	if (len != name->len)
+		goto out;
+	for (i = 0; i < len; i++) {
+		if (tolower(str[i]) != tolower(name->name[i]))
+			goto out;
+	}
+	result = 0;
+out:
+	return result;
+}
+
+struct dentry *fwsecurityfs_alloc_dentry(struct dentry *parent, const char *name)
+{
+	struct dentry *d;
+	struct qstr q;
+	int err;
+
+	q.name = name;
+	q.len = strlen(name);
+
+	err = fwsecurityfs_d_hash(parent, &q);
+	if (err)
+		return ERR_PTR(err);
+
+	d = d_alloc(parent, &q);
+	if (d)
+		return d;
+
+	return ERR_PTR(-ENOMEM);
+}
+
+static const struct dentry_operations fwsecurityfs_d_ops = {
+	.d_compare = fwsecurityfs_d_compare,
+	.d_hash = fwsecurityfs_d_hash,
+	.d_delete = always_delete_dentry,
+};
+
+static const struct super_operations securityfs_super_operations = {
+	.statfs = simple_statfs,
+	.drop_inode = generic_delete_inode,
+};
+
+static int fwsecurityfs_fill_super(struct super_block *sb,
+				   struct fs_context *fc)
+{
+	static const struct tree_descr files[] = {{""}};
+	int error;
+
+	error = simple_fill_super(sb, FWSECURITYFS_MAGIC, files);
+	if (error)
+		return error;
+
+	sb->s_d_op = &fwsecurityfs_d_ops;
+
+	fwsecsb = sb;
+
+	error = arch_fwsecurity_init();
+	if (error)
+		pr_err("arch specific firmware initialization failed\n");
+
+	return 0;
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
+	return 0;
+}
+
+static struct file_system_type fs_type = {
+	.owner =	THIS_MODULE,
+	.name =		"fwsecurityfs",
+	.init_fs_context = fwsecurityfs_init_fs_context,
+	.kill_sb =	kill_litter_super,
+};
+
+static int __init fwsecurityfs_init(void)
+{
+	int retval;
+
+	retval = sysfs_create_mount_point(firmware_kobj, "security");
+	if (retval)
+		return retval;
+
+	retval = register_filesystem(&fs_type);
+	if (retval) {
+		sysfs_remove_mount_point(firmware_kobj, "security");
+		return retval;
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
index 000000000000..c079ce939f42
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
+struct super_block *fwsecurityfs_get_superblock(void);
+int fwsecurityfs_create_file(const char *name, umode_t mode,
+					u16 filesize, struct dentry *parent,
+					struct dentry *dentry,
+					const struct file_operations *fops);
+int fwsecurityfs_remove_file(struct dentry *dentry);
+struct dentry *fwsecurityfs_create_dir(const char *name, umode_t mode,
+				       struct dentry *parent,
+				       const struct inode_operations *iops);
+int fwsecurityfs_remove_dir(struct dentry *dentry);
+
+static int arch_fwsecurity_init(void)
+{
+	return 0;
+}
+
+#endif /* _FWSECURITYFS_H_ */
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index f724129c0425..3c6754937e15 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -53,6 +53,7 @@
 #define QNX4_SUPER_MAGIC	0x002f		/* qnx4 fs detection */
 #define QNX6_SUPER_MAGIC	0x68191122	/* qnx6 fs detection */
 #define AFS_FS_MAGIC		0x6B414653
+#define FWSECURITYFS_MAGIC         0x5345434e      /* "SECM" */
 
 
 #define REISERFS_SUPER_MAGIC	0x52654973	/* used by gcc */
-- 
2.27.0

