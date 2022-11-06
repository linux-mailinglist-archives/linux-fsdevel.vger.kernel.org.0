Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C2F61E643
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Nov 2022 22:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiKFVI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Nov 2022 16:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiKFVIq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:08:46 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AC1114B;
        Sun,  6 Nov 2022 13:08:44 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A6GpqkP007325;
        Sun, 6 Nov 2022 21:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IQsnQ0ZKluqSboJqzc22REjjigAMqIndSiKKso4ysoA=;
 b=tetFKxEj5HqociJEbpCgIGtEMd+Z+TTf2XQECVsX3ccbYmJsDGfb64DF2TJIPab159OD
 vJlbOIHWf4CmnF9gimbBR5hWYOPya0dofLeKygrOBOOBIx/ZeLZvlDTPhlVnqlsY1i3R
 vgXk57SvFRnlf6gGJlprrN1Ykc61GzXc9dcw+ZeG5Q1YJtRHVdkZvqkuMXjhNp/eTdYK
 e41Gc0rYHSCm1uXkOl6DiwYLMtPrhQ+jmdTty3YbL9F3FQviCjNXl8OaK2vy3oobIuM+
 Gjd6sGJhJ0JStYyStkT0lGCPD7t6JFmSNQjzKiXh2O7WEgVSeE4dCb7Y6PLqL8t56jM5 sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp1mrvxt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Nov 2022 21:08:22 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A6L8Lx4025479;
        Sun, 6 Nov 2022 21:08:21 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp1mrvxsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Nov 2022 21:08:21 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A6L5oEW017575;
        Sun, 6 Nov 2022 21:08:19 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3kngnc9q4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Nov 2022 21:08:18 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A6L8FkS3342990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Nov 2022 21:08:15 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4212111C04A;
        Sun,  6 Nov 2022 21:08:15 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6217511C04C;
        Sun,  6 Nov 2022 21:08:11 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.78.124])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Nov 2022 21:08:11 +0000 (GMT)
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
Subject: [PATCH 3/4] powerpc/pseries: initialize fwsecurityfs with plpks arch-specific structure
Date:   Sun,  6 Nov 2022 16:07:43 -0500
Message-Id: <20221106210744.603240-4-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221106210744.603240-1-nayna@linux.ibm.com>
References: <20221106210744.603240-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gnoaMLvNd0-ijIFGJkLq3FgJgaDSk6qV
X-Proofpoint-ORIG-GUID: rdvdkE7aGcukAqtXArd8UuCui4ydUdbV
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

PowerVM PLPKS variables are exposed via fwsecurityfs.

Initialize fwsecurityfs arch-specific structure with plpks configuration.

Eg:

[root@ltcfleet35-lp1 config]# pwd
/sys/firmware/security/plpks/config
[root@ltcfleet35-lp1 config]# ls -ltrh
total 0
-r--r--r-- 1 root root 1 Sep 28 15:01 version
-r--r--r-- 1 root root 4 Sep 28 15:01 used_space
-r--r--r-- 1 root root 4 Sep 28 15:01 total_size
-r--r--r-- 1 root root 2 Sep 28 15:01 max_object_size
-r--r--r-- 1 root root 2 Sep 28 15:01 max_object_label_size

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/Kconfig        |  10 ++
 arch/powerpc/platforms/pseries/Makefile       |   1 +
 .../platforms/pseries/fwsecurityfs_arch.c     | 116 ++++++++++++++++++
 include/linux/fwsecurityfs.h                  |   4 +
 4 files changed, 131 insertions(+)
 create mode 100644 arch/powerpc/platforms/pseries/fwsecurityfs_arch.c

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index a3b4d99567cb..5fb45e601982 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -162,6 +162,16 @@ config PSERIES_PLPKS
 
 	  If unsure, select N.
 
+config PSERIES_FWSECURITYFS_ARCH
+	select FWSECURITYFS
+	bool "Support fwsecurityfs for pseries"
+	help
+	  Enable fwsecurityfs arch specific code. This would initialize
+	  the firmware security filesystem with initial platform specific
+	  structure.
+
+	  If you are unsure how to use it, say N.
+
 config PAPR_SCM
 	depends on PPC_PSERIES && MEMORY_HOTPLUG && LIBNVDIMM
 	tristate "Support for the PAPR Storage Class Memory interface"
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 92310202bdd7..2903cff26258 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_PPC_SPLPAR)	+= vphn.o
 obj-$(CONFIG_PPC_SVM)		+= svm.o
 obj-$(CONFIG_FA_DUMP)		+= rtas-fadump.o
 obj-$(CONFIG_PSERIES_PLPKS) += plpks.o
+obj-$(CONFIG_PSERIES_FWSECURITYFS_ARCH) += fwsecurityfs_arch.o
 
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PPC_VAS)		+= vas.o vas-sysfs.o
diff --git a/arch/powerpc/platforms/pseries/fwsecurityfs_arch.c b/arch/powerpc/platforms/pseries/fwsecurityfs_arch.c
new file mode 100644
index 000000000000..b43bd3cf7889
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/fwsecurityfs_arch.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Initialize fwsecurityfs with POWER LPAR Platform KeyStore (PLPKS)
+ * Copyright (C) 2022 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ */
+
+#include <linux/fwsecurityfs.h>
+#include "plpks.h"
+
+static struct dentry *plpks_dir;
+
+static ssize_t plpks_config_file_read(struct file *file, char __user *userbuf,
+				      size_t count, loff_t *ppos)
+{
+	u8 out[4];
+	u32 outlen;
+	size_t size;
+	char *name;
+	u32 data;
+
+	name = file_dentry(file)->d_iname;
+
+	if (strcmp(name, "max_object_size") == 0) {
+		outlen = sizeof(u16);
+		data = plpks_get_maxobjectsize();
+	} else if (strcmp(name, "max_object_label_size") == 0) {
+		outlen = sizeof(u16);
+		data = plpks_get_maxobjectlabelsize();
+	} else if (strcmp(name, "total_size") == 0) {
+		outlen = sizeof(u32);
+		data = plpks_get_totalsize();
+	} else if (strcmp(name, "used_space") == 0) {
+		outlen = sizeof(u32);
+		data = plpks_get_usedspace();
+	} else if (strcmp(name, "version") == 0) {
+		outlen = sizeof(u8);
+		data = plpks_get_version();
+	} else {
+		return -EINVAL;
+	}
+
+	memcpy(out, &data, outlen);
+
+	size = simple_read_from_buffer(userbuf, count, ppos, out, outlen);
+
+	return size;
+}
+
+static const struct file_operations plpks_config_file_operations = {
+	.open   = simple_open,
+	.read   = plpks_config_file_read,
+	.llseek = no_llseek,
+};
+
+static int create_plpks_dir(void)
+{
+	struct dentry *config_dir;
+	struct dentry *fdentry;
+
+	if (!IS_ENABLED(CONFIG_PSERIES_PLPKS) || !plpks_is_available()) {
+		pr_warn("Platform KeyStore is not available on this LPAR\n");
+		return 0;
+	}
+
+	plpks_dir = fwsecurityfs_create_dir("plpks", S_IFDIR | 0755, NULL,
+					    NULL);
+	if (IS_ERR(plpks_dir)) {
+		pr_err("Unable to create PLPKS dir: %ld\n", PTR_ERR(plpks_dir));
+		return PTR_ERR(plpks_dir);
+	}
+
+	config_dir = fwsecurityfs_create_dir("config", S_IFDIR | 0755, plpks_dir, NULL);
+	if (IS_ERR(config_dir)) {
+		pr_err("Unable to create config dir: %ld\n", PTR_ERR(config_dir));
+		return PTR_ERR(config_dir);
+	}
+
+	fdentry = fwsecurityfs_create_file("max_object_size", S_IFREG | 0444,
+					   sizeof(u16), config_dir, NULL, NULL,
+					   &plpks_config_file_operations);
+	if (IS_ERR(fdentry))
+		pr_err("Could not create max object size %ld\n", PTR_ERR(fdentry));
+
+	fdentry = fwsecurityfs_create_file("max_object_label_size", S_IFREG | 0444,
+					   sizeof(u16), config_dir, NULL, NULL,
+					   &plpks_config_file_operations);
+	if (IS_ERR(fdentry))
+		pr_err("Could not create max object label size %ld\n", PTR_ERR(fdentry));
+
+	fdentry = fwsecurityfs_create_file("total_size", S_IFREG | 0444,
+					   sizeof(u32), config_dir, NULL, NULL,
+					   &plpks_config_file_operations);
+	if (IS_ERR(fdentry))
+		pr_err("Could not create total size %ld\n", PTR_ERR(fdentry));
+
+	fdentry = fwsecurityfs_create_file("used_space", S_IFREG | 0444,
+					   sizeof(u32), config_dir, NULL, NULL,
+					   &plpks_config_file_operations);
+	if (IS_ERR(fdentry))
+		pr_err("Could not create used space %ld\n", PTR_ERR(fdentry));
+
+	fdentry = fwsecurityfs_create_file("version", S_IFREG | 0444,
+					   sizeof(u8), config_dir, NULL, NULL,
+					   &plpks_config_file_operations);
+	if (IS_ERR(fdentry))
+		pr_err("Could not create version %ld\n", PTR_ERR(fdentry));
+
+	return 0;
+}
+
+int arch_fwsecurityfs_init(void)
+{
+	return create_plpks_dir();
+}
diff --git a/include/linux/fwsecurityfs.h b/include/linux/fwsecurityfs.h
index ed8f328f3133..38fcb3cb374e 100644
--- a/include/linux/fwsecurityfs.h
+++ b/include/linux/fwsecurityfs.h
@@ -21,9 +21,13 @@ struct dentry *fwsecurityfs_create_dir(const char *name, umode_t mode,
 				       const struct inode_operations *iops);
 int fwsecurityfs_remove_dir(struct dentry *dentry);
 
+#ifdef CONFIG_PSERIES_FWSECURITYFS_ARCH
+int arch_fwsecurityfs_init(void);
+#else
 static int arch_fwsecurityfs_init(void)
 {
 	return 0;
 }
+#endif
 
 #endif /* _FWSECURITYFS_H_ */
-- 
2.31.1

