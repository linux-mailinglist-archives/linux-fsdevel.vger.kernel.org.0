Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE7961E642
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Nov 2022 22:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiKFVI4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Nov 2022 16:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKFVIt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:08:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DDA12B;
        Sun,  6 Nov 2022 13:08:48 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A6HV7x8007449;
        Sun, 6 Nov 2022 21:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5MhZFFjlk0VZoRGHVW0Rss+S9jLEMjHRQ1D6yVxO9a4=;
 b=AF8xOBGbAaL0VYOH536tpKhB8Ye1r9impz11ZryPUcjIOLpxCjz1Wd7MzeHXTqAiZZ3A
 SLTFir2b9vIh8RUHOTtwBLPHAURItRkpw6vNRvAH5K0AH0bBfJB/rSowmzAdd48QpBMp
 09G0BjlIydTJcHYKKydVw21Ikj50n1lo1nFsphOCdKL/5dbSpYEhGjl0wmjaSv3bAgk6
 E+OVEfVxGN4VjUIWH0dO9bcEa2Uutn72cXX3uwzskIybIxKXDsCR6X5yEKtAkiVcZgOL
 cAX1ekKoagbOW/T/PCP4Ve/DyWNWCc1bVJxZeVj5r5769hZpILLmudZv46vZvNFL5QqJ +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp1mrvxu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Nov 2022 21:08:26 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A6L0X41003881;
        Sun, 6 Nov 2022 21:08:25 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp1mrvxtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Nov 2022 21:08:25 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A6L5fOT031604;
        Sun, 6 Nov 2022 21:08:23 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3kngs4h753-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Nov 2022 21:08:23 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A6L8vvh52953468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Nov 2022 21:08:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A076B11C050;
        Sun,  6 Nov 2022 21:08:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A050B11C04A;
        Sun,  6 Nov 2022 21:08:15 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.78.124])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Nov 2022 21:08:15 +0000 (GMT)
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
Subject: [PATCH 4/4] powerpc/pseries: expose authenticated variables stored in LPAR PKS
Date:   Sun,  6 Nov 2022 16:07:44 -0500
Message-Id: <20221106210744.603240-5-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221106210744.603240-1-nayna@linux.ibm.com>
References: <20221106210744.603240-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fHT35PKex5OwM3ebL0FRXNCV6qcoAKaV
X-Proofpoint-ORIG-GUID: 3PodlQ9DGmkF2yW6-5SiV_Sx-vcyEglU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-06_14,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211060188
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

$ pwd
/sys/firmware/security/plpks/secvars

$ ls -ltrh
total 0
-rw-r--r-- 1 root root 831 Sep 12 18:34 PK
-rw-r--r-- 1 root root 831 Sep 12 18:34 KEK
-rw-r--r-- 1 root root 831 Sep 12 18:34 db

$ hexdump -C db
00000000  00 00 00 08 a1 59 c0 a5  e4 94 a7 4a 87 b5 ab 15  |.....Y.....J....|
00000010  5c 2b f0 72 3f 03 00 00  00 00 00 00 23 03 00 00  |\+.r?.......#...|
00000020  ca 18 1d 1c 01 7d eb 11  9a 71 08 94 ef 31 fb e4  |.....}...q...1..|
00000030  30 82 03 0f 30 82 01 f7  a0 03 02 01 02 02 14 22  |0...0.........."|
00000040  ab 18 2f d5 aa dd c5 ba  98 27 60 26 f1 63 89 54  |../......'`&.c.T|
00000050  4c 52 d9 30 0d 06 09 2a  86 48 86 f7 0d 01 01 0b  |LR.0...*.H......|
00000060  05 00 30 17 31 15 30 13  06 03 55 04 03 0c 0c 72  |..0.1.0...U....r|
...

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/Kconfig        |  10 +
 arch/powerpc/platforms/pseries/Makefile       |   1 +
 .../platforms/pseries/fwsecurityfs_arch.c     |   8 +
 arch/powerpc/platforms/pseries/plpks.h        |   3 +
 arch/powerpc/platforms/pseries/secvars.c      | 365 ++++++++++++++++++
 5 files changed, 387 insertions(+)
 create mode 100644 arch/powerpc/platforms/pseries/secvars.c

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 5fb45e601982..41c17f60dfe9 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -172,6 +172,16 @@ config PSERIES_FWSECURITYFS_ARCH
 
 	  If you are unsure how to use it, say N.
 
+config PSERIES_PLPKS_SECVARS
+       depends on PSERIES_PLPKS
+       select PSERIES_FWSECURITYFS_ARCH
+       tristate "Support for secvars"
+       help
+         This interface exposes authenticated variables stored in the LPAR
+         Platform KeyStore using fwsecurityfs interface.
+
+         If you are unsure how to use it, say N.
+
 config PAPR_SCM
 	depends on PPC_PSERIES && MEMORY_HOTPLUG && LIBNVDIMM
 	tristate "Support for the PAPR Storage Class Memory interface"
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 2903cff26258..6833f6b02798 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_PPC_SVM)		+= svm.o
 obj-$(CONFIG_FA_DUMP)		+= rtas-fadump.o
 obj-$(CONFIG_PSERIES_PLPKS) += plpks.o
 obj-$(CONFIG_PSERIES_FWSECURITYFS_ARCH) += fwsecurityfs_arch.o
+obj-$(CONFIG_PSERIES_PLPKS_SECVARS) += secvars.o
 
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PPC_VAS)		+= vas.o vas-sysfs.o
diff --git a/arch/powerpc/platforms/pseries/fwsecurityfs_arch.c b/arch/powerpc/platforms/pseries/fwsecurityfs_arch.c
index b43bd3cf7889..1cc651ad6434 100644
--- a/arch/powerpc/platforms/pseries/fwsecurityfs_arch.c
+++ b/arch/powerpc/platforms/pseries/fwsecurityfs_arch.c
@@ -58,6 +58,7 @@ static int create_plpks_dir(void)
 {
 	struct dentry *config_dir;
 	struct dentry *fdentry;
+	int rc;
 
 	if (!IS_ENABLED(CONFIG_PSERIES_PLPKS) || !plpks_is_available()) {
 		pr_warn("Platform KeyStore is not available on this LPAR\n");
@@ -107,6 +108,13 @@ static int create_plpks_dir(void)
 	if (IS_ERR(fdentry))
 		pr_err("Could not create version %ld\n", PTR_ERR(fdentry));
 
+	if (IS_ENABLED(CONFIG_PSERIES_PLPKS_SECVARS)) {
+		rc = plpks_secvars_init(plpks_dir);
+		if (rc)
+			pr_err("Secure Variables initialization failed with error %d\n", rc);
+		return rc;
+	}
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/pseries/plpks.h b/arch/powerpc/platforms/pseries/plpks.h
index fb483658549f..2d572fe4b522 100644
--- a/arch/powerpc/platforms/pseries/plpks.h
+++ b/arch/powerpc/platforms/pseries/plpks.h
@@ -11,6 +11,7 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/dcache.h>
 
 #define OSSECBOOTAUDIT 0x40000000
 #define OSSECBOOTENFORCE 0x20000000
@@ -103,4 +104,6 @@ u32 plpks_get_totalsize(void);
  */
 u32 plpks_get_usedspace(void);
 
+int plpks_secvars_init(struct dentry *parent);
+
 #endif
diff --git a/arch/powerpc/platforms/pseries/secvars.c b/arch/powerpc/platforms/pseries/secvars.c
new file mode 100644
index 000000000000..3d5a251d0571
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/secvars.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Expose secure(authenticated) variables for user key management.
+ * Copyright (C) 2022 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ */
+
+#include <linux/fwsecurityfs.h>
+#include "plpks.h"
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
+static u16 get_ucs2name(const char *name, uint8_t **ucs2_name)
+{
+	int i = 0;
+	int j = 0;
+	int namelen = 0;
+
+	namelen = strlen(name) * 2;
+
+	*ucs2_name = kzalloc(namelen, GFP_KERNEL);
+	if (!*ucs2_name)
+		return 0;
+
+	while (name[i]) {
+		(*ucs2_name)[j++] = name[i];
+		(*ucs2_name)[j++] = '\0';
+		pr_debug("ucs2name is %c\n", (*ucs2_name)[j - 2]);
+		i++;
+	}
+
+	return namelen;
+}
+
+static int validate_name(const char *name)
+{
+	int i = 0;
+
+	while (names[i]) {
+		if ((strcmp(name, names[i]) == 0))
+			return 0;
+		i++;
+	}
+	pr_err("Invalid name, allowed ones are (PK,KEK,db,dbx,grubdb,sbat,moduledb,trustedcadb)\n");
+
+	return -EINVAL;
+}
+
+static u32 get_policy(const char *name)
+{
+	if ((strcmp(name, "db") == 0) ||
+	    (strcmp(name, "dbx") == 0) ||
+	    (strcmp(name, "grubdb") == 0) ||
+	    (strcmp(name, "sbat") == 0))
+		return (WORLDREADABLE | SIGNEDUPDATE);
+	else
+		return SIGNEDUPDATE;
+}
+
+static ssize_t plpks_secvar_file_write(struct file *file,
+				       const char __user *userbuf,
+				       size_t count, loff_t *ppos)
+{
+	struct plpks_var var;
+	void *data;
+	u16 ucs2_namelen;
+	u8 *ucs2_name = NULL;
+	u64 flags;
+	ssize_t rc;
+	bool exist = true;
+	u16 datasize = count;
+	struct inode *inode = file->f_mapping->host;
+
+	if (count <= sizeof(flags))
+		return -EINVAL;
+
+	ucs2_namelen = get_ucs2name(file_dentry(file)->d_iname, &ucs2_name);
+	if (ucs2_namelen == 0)
+		return -ENOMEM;
+
+	rc = copy_from_user(&flags, userbuf, sizeof(flags));
+	if (rc)
+		return -EFAULT;
+
+	datasize = count - sizeof(flags);
+
+	data = memdup_user(userbuf + sizeof(flags), datasize);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	var.component = NULL;
+	var.name = ucs2_name;
+	var.namelen = ucs2_namelen;
+	var.os = PLPKS_VAR_LINUX;
+	var.datalen = 0;
+	var.data = NULL;
+
+	/* If PKS variable doesn't exist, it implies first time creation */
+	rc = plpks_read_os_var(&var);
+	if (rc) {
+		if (rc == -ENOENT) {
+			exist = false;
+		} else {
+			pr_err("Reading variable %s failed with error %ld\n",
+			       file_dentry(file)->d_iname, rc);
+			goto out;
+		}
+	}
+
+	var.datalen = datasize;
+	var.data = data;
+	var.policy = get_policy(file_dentry(file)->d_iname);
+	rc = plpks_signed_update_var(var, flags);
+	if (rc) {
+		pr_err("Update of the variable %s failed with error %ld\n",
+		       file_dentry(file)->d_iname, rc);
+		if (!exist)
+			fwsecurityfs_remove_file(file_dentry(file));
+		goto out;
+	}
+
+	/* Read variable again to get updated size of the object */
+	var.datalen = 0;
+	var.data = NULL;
+	rc = plpks_read_os_var(&var);
+	if (rc)
+		pr_err("Error updating file size\n");
+
+	inode_lock(inode);
+	i_size_write(inode, var.datalen);
+	inode->i_mtime = current_time(inode);
+	inode_unlock(inode);
+
+	rc = count;
+out:
+	kfree(data);
+	kfree(ucs2_name);
+
+	return rc;
+}
+
+static ssize_t __secvar_os_file_read(char *name, char **out, u32 *outlen)
+{
+	struct plpks_var var;
+	int rc;
+	u8 *ucs2_name = NULL;
+	u16 ucs2_namelen;
+
+	ucs2_namelen = get_ucs2name(name, &ucs2_name);
+	if (ucs2_namelen == 0)
+		return -ENOMEM;
+
+	var.component = NULL;
+	var.name = ucs2_name;
+	var.namelen = ucs2_namelen;
+	var.os = PLPKS_VAR_LINUX;
+	var.datalen = 0;
+	var.data = NULL;
+	rc = plpks_read_os_var(&var);
+	if (rc) {
+		pr_err("Error %d reading object %s from firmware\n", rc, name);
+		kfree(ucs2_name);
+		return rc;
+	}
+
+	*outlen = sizeof(var.policy) + var.datalen;
+	*out = kzalloc(*outlen, GFP_KERNEL);
+	if (!*out) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	memcpy(*out, &var.policy, sizeof(var.policy));
+
+	memcpy(*out + sizeof(var.policy), var.data, var.datalen);
+
+err:
+	kfree(ucs2_name);
+	kfree(var.data);
+	return rc;
+}
+
+static ssize_t __secvar_fw_file_read(char *name, char **out, u32 *outlen)
+{
+	struct plpks_var var;
+	int rc;
+
+	var.component = NULL;
+	var.name = name;
+	var.namelen = strlen(name);
+	var.datalen = 0;
+	var.data = NULL;
+	rc = plpks_read_fw_var(&var);
+	if (rc) {
+		if (rc == -ENOENT) {
+			var.datalen = 1;
+			var.data = kzalloc(var.datalen, GFP_KERNEL);
+			rc = 0;
+		} else {
+			pr_err("Error %d reading object %s from firmware\n",
+			       rc, name);
+			return rc;
+		}
+	}
+
+	*outlen = var.datalen;
+	*out = kzalloc(*outlen, GFP_KERNEL);
+	if (!*out) {
+		kfree(var.data);
+		return -ENOMEM;
+	}
+
+	memcpy(*out, var.data, var.datalen);
+
+	kfree(var.data);
+	return 0;
+}
+
+static ssize_t plpks_secvar_file_read(struct file *file, char __user *userbuf,
+				      size_t count, loff_t *ppos)
+{
+	int rc;
+	char *out = NULL;
+	u32 outlen;
+	char *fname = file_dentry(file)->d_iname;
+
+	if (strcmp(fname, "SB_VERSION") == 0)
+		rc = __secvar_fw_file_read(fname, &out, &outlen);
+	else
+		rc = __secvar_os_file_read(fname, &out, &outlen);
+	if (!rc)
+		rc = simple_read_from_buffer(userbuf, count, ppos,
+					     out, outlen);
+
+	kfree(out);
+
+	return rc;
+}
+
+static const struct file_operations plpks_secvar_file_operations = {
+	.open   = simple_open,
+	.read   = plpks_secvar_file_read,
+	.write  = plpks_secvar_file_write,
+	.llseek = no_llseek,
+};
+
+static int plpks_secvar_create(struct user_namespace *mnt_userns,
+			       struct inode *dir, struct dentry *dentry,
+			       umode_t mode, bool excl)
+{
+	const char *varname;
+	struct dentry *ldentry;
+	int rc;
+
+	varname = dentry->d_name.name;
+
+	rc = validate_name(varname);
+	if (rc)
+		goto out;
+
+	ldentry = fwsecurityfs_create_file(varname, S_IFREG | 0644, 0,
+					   secvar_dir, dentry, NULL,
+					   &plpks_secvar_file_operations);
+	if (IS_ERR(ldentry)) {
+		rc = PTR_ERR(ldentry);
+		pr_err("Creation of variable %s failed with error %d\n",
+		       varname, rc);
+	}
+
+out:
+	return rc;
+}
+
+static const struct inode_operations plpks_secvar_dir_inode_operations = {
+	.lookup = simple_lookup,
+	.create = plpks_secvar_create,
+};
+
+static int plpks_fill_secvars(void)
+{
+	struct plpks_var var;
+	int rc = 0;
+	int i = 0;
+	u8 *ucs2_name = NULL;
+	u16 ucs2_namelen;
+	struct dentry *dentry;
+
+	dentry = fwsecurityfs_create_file("SB_VERSION", S_IFREG | 0444, 1,
+					  secvar_dir, NULL, NULL,
+					  &plpks_secvar_file_operations);
+	if (IS_ERR(dentry)) {
+		rc = PTR_ERR(dentry);
+		pr_err("Creation of variable SB_VERSION failed with error %d\n", rc);
+		return rc;
+	}
+
+	while (names[i]) {
+		ucs2_namelen = get_ucs2name(names[i], &ucs2_name);
+		if (ucs2_namelen == 0) {
+			i++;
+			continue;
+		}
+
+		i++;
+		var.component = NULL;
+		var.name = ucs2_name;
+		var.namelen = ucs2_namelen;
+		var.os = PLPKS_VAR_LINUX;
+		var.datalen = 0;
+		var.data = NULL;
+		rc = plpks_read_os_var(&var);
+		kfree(ucs2_name);
+		if (rc) {
+			rc = 0;
+			continue;
+		}
+
+		dentry = fwsecurityfs_create_file(names[i - 1], S_IFREG | 0644,
+						  var.datalen, secvar_dir,
+						  NULL, NULL,
+						  &plpks_secvar_file_operations);
+
+		kfree(var.data);
+		if (IS_ERR(dentry)) {
+			rc = PTR_ERR(dentry);
+			pr_err("Creation of variable %s failed with error %d\n",
+			       names[i - 1], rc);
+			break;
+		}
+	}
+
+	return rc;
+};
+
+int plpks_secvars_init(struct dentry *parent)
+{
+	int rc;
+
+	secvar_dir = fwsecurityfs_create_dir("secvars", S_IFDIR | 0755, parent,
+					     &plpks_secvar_dir_inode_operations);
+	if (IS_ERR(secvar_dir)) {
+		rc = PTR_ERR(secvar_dir);
+		pr_err("Unable to create secvars dir: %d\n", rc);
+		return rc;
+	}
+
+	rc = plpks_fill_secvars();
+	if (rc)
+		pr_err("Filling secvars failed %d\n", rc);
+
+	return rc;
+};
-- 
2.31.1

