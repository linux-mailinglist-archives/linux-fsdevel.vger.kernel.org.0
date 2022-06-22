Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9325E556E49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 00:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359586AbiFVV7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 17:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbiFVV5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 17:57:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8EA40A02;
        Wed, 22 Jun 2022 14:57:45 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MLqjO4025445;
        Wed, 22 Jun 2022 21:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=h+uTqCXrf4FFxJFWfTluGUJzYCQR4/0b1sDhf+WiCxQ=;
 b=aAUAt1nPl3LvTj8FwbT3OsqPzQdf7Fv3O4WIZZkUNj4/Y7qZzpAFIU4kBHkKBO5Qrwik
 KSzS+0X9mT0/zHr40ts31zekuoGlmAh1GXxRxrjWvf+TFVM75pc5/uZAICdhvdVyKhcL
 RjI6z6LZoVsbLgTqvgP4DHzoG7AjQNjdIQMHl8a29C8p4G48bdHknQ+LUpeeC5/OTm0k
 mwnZgpVYEhVQf8/tg+0noVDXNaWCN7l5VpprqaOxc1OHtkxcOeU8KGRGFDjefMaVGNxP
 HhNqjQWkpeUhm2Px2CChtSavLu205zwy06F8Rx+GQOkdWjDE3mqmIFsa4mrarabs3ORy 5A== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gvbcs842e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 21:57:19 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25MLqKwn002781;
        Wed, 22 Jun 2022 21:57:16 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3gs6b8x8h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 21:57:16 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25MLvD2i19595730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 21:57:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CA3FA4051;
        Wed, 22 Jun 2022 21:57:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B35F5A4040;
        Wed, 22 Jun 2022 21:57:09 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.125.38])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jun 2022 21:57:09 +0000 (GMT)
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
Subject: [RFC PATCH v2 3/3] powerpc/pseries: expose authenticated variables stored in LPAR PKS
Date:   Wed, 22 Jun 2022 17:56:48 -0400
Message-Id: <20220622215648.96723-4-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220622215648.96723-1-nayna@linux.ibm.com>
References: <20220622215648.96723-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uPe6-Ern24Q0dEX6STb0zo-EtHatNIBI
X-Proofpoint-ORIG-GUID: uPe6-Ern24Q0dEX6STb0zo-EtHatNIBI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_08,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PowerVM Guest Secure boot feature need to expose firmware managed
secure variables for user management. These variables store keys for
grub/kernel verification and also corresponding denied list.

Expose these variables to the userpace via fwsecurityfs.

Example:

Example:

# cd /sys/firmware/security/secvars

# pwd
/sys/firmware/security/secvars

# cat /tmp/PK.bin > PK

# ls -l
total 0
-rw-r--r-- 1 root root 2497 Jun 22 08:34 PK

# hexdump -C PK
00000000  00 00 00 00 00 08 00 00  a1 59 c0 a5 e4 94 a7 4a  |.........Y.....J|
00000010  87 b5 ab 15 5c 2b f0 72  3f 03 00 00 00 00 00 00  |....\+.r?.......|
00000020  23 03 00 00 ca 18 1d 1c  01 7d eb 11 9a 71 08 94  |#........}...q..|
00000030  ef 31 fb e4 30 82 03 0f  30 82 01 f7 a0 03 02 01  |.1..0...0.......|
00000040  02 02 14 22 ab 18 2f d5  aa dd c5 ba 98 27 60 26  |..."../......'`&|
00000050  f1 63 89 54 4c 52 d9 30  0d 06 09 2a 86 48 86 f7  |.c.TLR.0...*.H..|
...

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/Kconfig        |  17 ++
 arch/powerpc/platforms/pseries/plpks/Makefile |   2 +
 .../pseries/plpks/fwsecurityfs_arch.c         |  16 ++
 .../platforms/pseries/plpks/internal.h        |  18 ++
 .../powerpc/platforms/pseries/plpks/secvars.c | 239 ++++++++++++++++++
 include/linux/fwsecurityfs.h                  |   4 +
 6 files changed, 296 insertions(+)
 create mode 100644 arch/powerpc/platforms/pseries/plpks/fwsecurityfs_arch.c
 create mode 100644 arch/powerpc/platforms/pseries/plpks/internal.h
 create mode 100644 arch/powerpc/platforms/pseries/plpks/secvars.c

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 6c1ca487103f..9c52095e20c4 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -152,6 +152,23 @@ config PSERIES_PLPKS
 	  config to enable operating system interface to hypervisor to
 	  access this space.
 
+config PSERIES_FWSECURITYFS_ARCH
+	depends on FWSECURITYFS
+	bool "Support fwsecurityfs for pseries"
+	help
+	  Enable fwsecuirtyfs arch specific code. This would initialize
+	  the firmware security filesystem with initial platform specific
+	  structure.
+
+config PSERIES_PLPKS_SECVARS
+	depends on PSERIES_PLPKS
+	select PSERIES_FWSECURITYFS_ARCH
+	tristate "Support for secvars"
+	help
+	  This interface exposes authenticated variables stored in the LPAR
+	  Platform KeyStore using fwsecurityfs interface.
+	  If you are unsure how to use it, say N.
+
 config PAPR_SCM
 	depends on PPC_PSERIES && MEMORY_HOTPLUG && LIBNVDIMM
 	tristate "Support for the PAPR Storage Class Memory interface"
diff --git a/arch/powerpc/platforms/pseries/plpks/Makefile b/arch/powerpc/platforms/pseries/plpks/Makefile
index e651ace920db..ff3d4b4cd3d7 100644
--- a/arch/powerpc/platforms/pseries/plpks/Makefile
+++ b/arch/powerpc/platforms/pseries/plpks/Makefile
@@ -5,3 +5,5 @@
 #
 
 obj-$(CONFIG_PSERIES_PLPKS)  += plpks.o
+obj-$(CONFIG_PSERIES_FWSECURITYFS_ARCH) += fwsecurityfs_arch.o
+obj-$(CONFIG_PSERIES_PLPKS_SECVARS) += secvars.o
diff --git a/arch/powerpc/platforms/pseries/plpks/fwsecurityfs_arch.c b/arch/powerpc/platforms/pseries/plpks/fwsecurityfs_arch.c
new file mode 100644
index 000000000000..6ccdfe4000a6
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/plpks/fwsecurityfs_arch.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * POWER LPAR Platform KeyStore (PLPKS)
+ * Copyright (C) 2022 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ */
+
+#include <linux/fwsecurityfs.h>
+
+#include "internal.h"
+
+int arch_fwsecurity_init(void)
+{
+	return plpks_secvars_init();
+}
diff --git a/arch/powerpc/platforms/pseries/plpks/internal.h b/arch/powerpc/platforms/pseries/plpks/internal.h
new file mode 100644
index 000000000000..6061ffd37677
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/plpks/internal.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ */
+#ifndef PKS_FWSEC_INTERNAL
+#define PKS_FWSEC_INTERNAL
+
+#ifdef CONFIG_PSERIES_PLPKS_SECVARS
+int plpks_secvars_init(void);
+#else
+int plpks_secvars_init(void)
+{
+	return 0;
+}
+#endif
+#endif
diff --git a/arch/powerpc/platforms/pseries/plpks/secvars.c b/arch/powerpc/platforms/pseries/plpks/secvars.c
new file mode 100644
index 000000000000..8852cb8f2f3c
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/plpks/secvars.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * POWER LPAR Platform KeyStore (PLPKS)
+ * Copyright (C) 2022 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ */
+
+#include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/mount.h>
+#include <linux/pagemap.h>
+#include <linux/init.h>
+#include <linux/namei.h>
+#include <linux/ctype.h>
+#include <linux/fwsecurityfs.h>
+#include <asm/plpks.h>
+
+#include "internal.h"
+
+static struct dentry *secvar_dir;
+
+static const char * const names[] = {
+	"PK",
+	"KEK",
+	"db",
+	"dbx",
+	"grubdb",
+	"sbat",
+	"moduledb",
+	"trustedcadb",
+	NULL
+};
+
+static int validate_name(char *name)
+{
+	int i = 0;
+
+	while (names[i] != NULL) {
+		if ((strlen(names[i]) == strlen(name))
+		&& (strncmp(name, names[i], strlen(names[i])) == 0))
+			return 0;
+		i++;
+	}
+	pr_err("Invalid name, allowed ones are (dbx,grubdb,sbat,moduledb,trustedcadb)\n");
+
+	return -EINVAL;
+}
+
+static u32 get_policy(char *name)
+{
+	if ((strncmp(name, "PK", 2) == 0)
+	|| (strncmp(name, "KEK", 3) == 0)
+	|| (strncmp(name, "db", 2) == 0)
+	|| (strncmp(name, "dbx", 3) == 0)
+	|| (strncmp(name, "grubdb", 6) == 0)
+	|| (strncmp(name, "sbat", 4) == 0))
+		return (WORLDREADABLE & SIGNEDUPDATE);
+	else
+		return SIGNEDUPDATE;
+}
+
+static ssize_t plpks_secvar_file_write(struct file *file,
+				     const char __user *userbuf,
+				     size_t count, loff_t *ppos)
+{
+	struct plpks_var var;
+	void *data;
+	struct inode *inode = file->f_mapping->host;
+	u16 datasize = count;
+	ssize_t bytes;
+
+	data = memdup_user(userbuf, datasize);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	var.component = NULL;
+	var.name = file->f_path.dentry->d_iname;
+	var.namelen = strlen(var.name);
+	var.policy = get_policy(var.name);
+	var.datalen = datasize;
+	var.data = data;
+	bytes = plpks_signed_update_var(var);
+
+	if (bytes) {
+		pr_err("Update of the variable failed with error %ld\n", bytes);
+		goto out;
+	}
+
+	inode_lock(inode);
+	i_size_write(inode, datasize);
+	inode->i_mtime = current_time(inode);
+	inode_unlock(inode);
+
+	bytes = count;
+out:
+	kfree(data);
+
+	return bytes;
+
+}
+
+static ssize_t plpks_secvar_file_read(struct file *file, char __user *userbuf,
+				    size_t count, loff_t *ppos)
+{
+	struct plpks_var var;
+	char *out;
+	u32 outlen;
+	int rc;
+	size_t size;
+
+	var.name = file->f_path.dentry->d_iname;
+	var.namelen = strlen(var.name);
+	var.component = NULL;
+	rc = plpks_read_os_var(&var);
+	if (rc) {
+		pr_err("Error reading object %d\n", rc);
+		return rc;
+	}
+
+	outlen = sizeof(var.policy) + var.datalen;
+	out = kzalloc(outlen, GFP_KERNEL);
+	memcpy(out, &var.policy, sizeof(var.policy));
+
+	memcpy(out + sizeof(var.policy), var.data, var.datalen);
+
+	size = simple_read_from_buffer(userbuf, count, ppos,
+				       out, outlen);
+	kfree(out);
+	return size;
+}
+
+
+static const struct file_operations plpks_secvar_file_operations = {
+	.open   = simple_open,
+	.read   = plpks_secvar_file_read,
+	.write  = plpks_secvar_file_write,
+	.llseek = no_llseek,
+};
+
+static int plpks_secvar_create(struct user_namespace *mnt_userns, struct inode *dir,
+			     struct dentry *dentry, umode_t mode, bool excl)
+{
+	int namelen, i = 0;
+	char *varname;
+	int rc = 0;
+
+	namelen = dentry->d_name.len;
+
+	varname = kzalloc(namelen + 1, GFP_KERNEL);
+	if (!varname)
+		return -ENOMEM;
+
+	for (i = 0; i < namelen; i++)
+		varname[i] = dentry->d_name.name[i];
+	varname[i] = '\0';
+
+	rc = validate_name(varname);
+	if (rc)
+		goto out;
+
+	rc = validate_name(varname);
+	if (rc)
+		goto out;
+
+	rc = fwsecurityfs_create_file(varname, S_IFREG|0644, 0, secvar_dir,
+				      dentry, &plpks_secvar_file_operations);
+	if (rc)
+		pr_err("Error creating file\n");
+
+out:
+	kfree(varname);
+
+	return rc;
+}
+
+static const struct inode_operations plpks_secvar_dir_inode_operations = {
+	.lookup = simple_lookup,
+	.create = plpks_secvar_create,
+};
+
+static int plpks_fill_secvars(struct super_block *sb)
+{
+	struct plpks_var *var = NULL;
+	int err;
+	int i = 0;
+
+	while (names[i] != NULL) {
+		var = kzalloc(sizeof(struct plpks_var), GFP_KERNEL);
+		var->name = (char *)names[i];
+		var->namelen = strlen(names[i]);
+		pr_debug("name is %s\n", var->name);
+		var->component = NULL;
+		i++;
+		err = plpks_read_os_var(var);
+		if (err) {
+			kfree(var);
+			continue;
+		}
+
+		err = fwsecurityfs_create_file(var->name, S_IFREG|0644,
+					       var->datalen, secvar_dir,
+					       NULL,
+					       &plpks_secvar_file_operations);
+
+		kfree(var);
+		if (err) {
+			pr_err("Error creating file\n");
+			break;
+		}
+	}
+	return  err;
+};
+
+int plpks_secvars_init(void)
+{
+	int error;
+
+	struct super_block *sb;
+
+	secvar_dir = fwsecurityfs_create_dir("secvars", S_IFDIR | 0755, NULL,
+					     &plpks_secvar_dir_inode_operations);
+	if (IS_ERR(secvar_dir)) {
+		int ret = PTR_ERR(secvar_dir);
+
+		if (ret != -ENODEV)
+			pr_err("Unable to create integrity sysfs dir: %d\n",
+					ret);
+		secvar_dir = NULL;
+		return ret;
+	}
+
+	sb = fwsecurityfs_get_superblock();
+	error = plpks_fill_secvars(sb);
+	if (error)
+		pr_err("Filling secvars failed\n");
+
+	return 0;
+};
diff --git a/include/linux/fwsecurityfs.h b/include/linux/fwsecurityfs.h
index c079ce939f42..d5fd51aa6322 100644
--- a/include/linux/fwsecurityfs.h
+++ b/include/linux/fwsecurityfs.h
@@ -21,9 +21,13 @@ struct dentry *fwsecurityfs_create_dir(const char *name, umode_t mode,
 				       const struct inode_operations *iops);
 int fwsecurityfs_remove_dir(struct dentry *dentry);
 
+#ifdef CONFIG_PSERIES_FWSECURITYFS_ARCH
+int arch_fwsecurity_init(void);
+#else
 static int arch_fwsecurity_init(void)
 {
 	return 0;
 }
+#endif
 
 #endif /* _FWSECURITYFS_H_ */
-- 
2.27.0

