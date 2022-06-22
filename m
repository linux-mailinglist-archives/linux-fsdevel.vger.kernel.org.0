Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13697556E10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 23:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbiFVV5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 17:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiFVV5m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 17:57:42 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38AD40A03;
        Wed, 22 Jun 2022 14:57:40 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MLPvdY013862;
        Wed, 22 Jun 2022 21:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6wrzb3Wml9nwKk3+3wz6vxVRKieUWEM5Z/GzPN94F2k=;
 b=RTJc5wTv/q92yOOjL7reTiu/Lsi77j8vpOtKtISz+9G+p06Z+C6RFjKuZ/1wpxMRBggN
 J6PKxbvbFe9tBYvnU+0ndyZCXEsYbxg48GYvT5Y4LuTXbpB4qLF07Sq1RqH7epfTEzuW
 LrdbYWzPgpDyswxBS6/W4YZBnLN1VVoLwB83CDNfLq7M1pBNRB1S0zQ+kD1umSHkPc5D
 bJCWNSG5UwIMRo5ejX8wW0Fo058UXsEXJVb10J4//ZIFbfIhbtOXeChtDIiXirfjxJ7J
 8e/AualR9P4Nrqx20JyQYmmAFsYR0TRLLRAFI0nkil3IYl3k97opJMqp776tUMy7/1Hd tw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gvb08gseh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 21:57:11 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25MLodXX028393;
        Wed, 22 Jun 2022 21:57:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3gv9r7030s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 21:57:08 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25MLv5g317695110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 21:57:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CD1CA404D;
        Wed, 22 Jun 2022 21:57:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 206ACA4040;
        Wed, 22 Jun 2022 21:57:02 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.125.38])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jun 2022 21:57:01 +0000 (GMT)
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
Subject: [RFC PATCH v2 1/3] powerpc/pseries: define driver for Platform KeyStore
Date:   Wed, 22 Jun 2022 17:56:46 -0400
Message-Id: <20220622215648.96723-2-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220622215648.96723-1-nayna@linux.ibm.com>
References: <20220622215648.96723-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EJ1qoo2YSAaDtyH9_JrEi_nHpCSmh-jX
X-Proofpoint-GUID: EJ1qoo2YSAaDtyH9_JrEi_nHpCSmh-jX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_08,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206220097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PowerVM provides an isolated Platform Keystore(PKS) storage allocation
for each LPAR with individually managed access controls to store
sensitive information securely. It provides a new set of hypervisor
calls for Linux kernel to access PKS storage.

Define PLPKS driver using H_CALL interface to access PKS storage.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h             |  12 +-
 arch/powerpc/include/asm/plpks.h              |  92 ++++
 arch/powerpc/platforms/pseries/Kconfig        |  10 +
 arch/powerpc/platforms/pseries/Makefile       |   2 +
 arch/powerpc/platforms/pseries/plpks/Makefile |   7 +
 arch/powerpc/platforms/pseries/plpks/plpks.c  | 517 ++++++++++++++++++
 6 files changed, 639 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/plpks.h
 create mode 100644 arch/powerpc/platforms/pseries/plpks/Makefile
 create mode 100644 arch/powerpc/platforms/pseries/plpks/plpks.c

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index d92a20a85395..1da429235632 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -97,6 +97,7 @@
 #define H_OP_MODE	-73
 #define H_COP_HW	-74
 #define H_STATE		-75
+#define H_IN_USE	-77
 #define H_UNSUPPORTED_FLAG_START	-256
 #define H_UNSUPPORTED_FLAG_END		-511
 #define H_MULTI_THREADS_ACTIVE	-9005
@@ -321,10 +322,19 @@
 #define H_SCM_UNBIND_ALL        0x3FC
 #define H_SCM_HEALTH            0x400
 #define H_SCM_PERFORMANCE_STATS 0x418
+#define H_PKS_GET_CONFIG	0x41C
+#define H_PKS_SET_PASSWORD	0x420
+#define H_PKS_GEN_PASSWORD	0x424
+#define H_PKS_WRITE_OBJECT	0x42C
+#define H_PKS_GEN_KEY		0x430
+#define H_PKS_READ_OBJECT	0x434
+#define H_PKS_REMOVE_OBJECT	0x438
+#define H_PKS_CONFIRM_OBJECT_FLUSHED	0x43C
 #define H_RPT_INVALIDATE	0x448
 #define H_SCM_FLUSH		0x44C
 #define H_GET_ENERGY_SCALE_INFO	0x450
-#define MAX_HCALL_OPCODE	H_GET_ENERGY_SCALE_INFO
+#define H_PKS_SIGNED_UPDATE	0x454
+#define MAX_HCALL_OPCODE	H_PKS_SIGNED_UPDATE
 
 /* Scope args for H_SCM_UNBIND_ALL */
 #define H_UNBIND_SCOPE_ALL (0x1)
diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
new file mode 100644
index 000000000000..c3b544bdbcb6
--- /dev/null
+++ b/arch/powerpc/include/asm/plpks.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ * Platform keystore for pseries LPAR(PLPKS).
+ */
+
+#ifndef _PSERIES_PLPKS_H
+#define _PSERIES_PLPKS_H
+
+
+#include <linux/types.h>
+#include <linux/list.h>
+
+
+#define OSSECBOOTAUDIT 0x40000000
+#define OSSECBOOTENFORCE 0x20000000
+#define WORLDREADABLE 0x08000000
+#define SIGNEDUPDATE 0x01000000
+
+struct plpks_var {
+	char *component;
+	u8 *name;
+	u16 namelen;
+	u32 policy;
+	u16 datalen;
+	u8 *data;
+};
+
+struct plpks_var_name {
+	u16 namelen;
+	u8  *name;
+};
+
+struct plpks_var_name_list {
+	u32 varcount;
+	struct plpks_var_name varlist[];
+};
+
+struct plpks_config {
+	u8 version;
+	u8 flags;
+	u32 rsvd0;
+	u16 maxpwsize;
+	u16 maxobjlabelsize;
+	u16 maxobjsize;
+	u32 totalsize;
+	u32 usedspace;
+	u32 supportedpolicies;
+	u64 rsvd1;
+} __packed;
+
+/**
+ * Successful return from this API  implies PKS is available.
+ * This is used to initialize kernel driver and user interfaces.
+ */
+extern struct plpks_config *plpks_get_config(void);
+
+/**
+ * Updates the authenticated variable. It expects NULL as the component.
+ */
+extern int plpks_signed_update_var(struct plpks_var var);
+
+/**
+ * Writes the specified var and its data to PKS.
+ * Any caller of PKS driver should present a valid component type for
+ * their variable.
+ */
+extern int plpks_write_var(struct plpks_var var);
+
+/**
+ * Removes the specified var and its data from PKS.
+ */
+extern int plpks_remove_var(char *component, struct plpks_var_name vname);
+
+/**
+ * Returns the data for the specified os variable.
+ */
+extern int plpks_read_os_var(struct plpks_var *var);
+
+/**
+ * Returns the data for the specified firmware variable.
+ */
+extern int plpks_read_fw_var(struct plpks_var *var);
+
+/**
+ * Returns the data for the specified bootloader variable.
+ */
+extern int plpks_read_bootloader_var(struct plpks_var *var);
+
+#endif
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index f7fd91d153a4..6c1ca487103f 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -142,6 +142,16 @@ config IBMEBUS
 	help
 	  Bus device driver for GX bus based adapters.
 
+config PSERIES_PLPKS
+	depends on PPC_PSERIES
+	tristate "Support for the Platform Key Storage"
+	help
+	  PowerVM provides an isolated Platform Keystore(PKS) storage
+	  allocation for each LPAR with individually managed access
+	  controls to store sensitive information securely. Select this
+	  config to enable operating system interface to hypervisor to
+	  access this space.
+
 config PAPR_SCM
 	depends on PPC_PSERIES && MEMORY_HOTPLUG && LIBNVDIMM
 	tristate "Support for the PAPR Storage Class Memory interface"
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 7aaff5323544..d6a9209e08c0 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -37,3 +37,5 @@ obj-$(CONFIG_ARCH_HAS_CC_PLATFORM)	+= cc_platform.o
 # nothing that operates in real mode is safe for KASAN
 KASAN_SANITIZE_ras.o := n
 KASAN_SANITIZE_kexec.o := n
+
+obj-$(CONFIG_PSERIES_PLPKS)      += plpks/
diff --git a/arch/powerpc/platforms/pseries/plpks/Makefile b/arch/powerpc/platforms/pseries/plpks/Makefile
new file mode 100644
index 000000000000..e651ace920db
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/plpks/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2022 IBM Corporation
+# Author: Nayna Jain <nayna@linux.ibm.com>
+#
+
+obj-$(CONFIG_PSERIES_PLPKS)  += plpks.o
diff --git a/arch/powerpc/platforms/pseries/plpks/plpks.c b/arch/powerpc/platforms/pseries/plpks/plpks.c
new file mode 100644
index 000000000000..1edb5905bbef
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/plpks/plpks.c
@@ -0,0 +1,517 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * POWER LPAR Platform KeyStore (PLPKS)
+ * Copyright (C) 2022 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ * Provides access to variables stored in Power LPAR Platform KeyStore(PLPKS).
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <asm/hvcall.h>
+#include <asm/plpks.h>
+#include <asm/unaligned.h>
+#include <asm/machdep.h>
+
+#define MODULE_VERS "1.0"
+#define MODULE_NAME "pseries-plpks"
+
+#define PKS_FW_OWNER   0x1
+#define PKS_BOOTLOADER_OWNER   0x2
+#define PKS_OS_OWNER   0x3
+
+#define PKS_VAR_LINUX	0x01
+#define PKS_VAR_COMMON	0x04
+
+#define MAX_LABEL_ATTR_SIZE 16
+#define MAX_NAME_SIZE 240
+#define MAX_DATA_SIZE 4000
+
+static bool configset;
+static struct plpks_config *config;
+static u8 *ospassword;
+static u16 ospasswordlength;
+
+struct plpks_auth {
+	u8 version;
+	u8 consumer;
+	__be64 rsvd0;
+	__be32 rsvd1;
+	__be16 passwordlength;
+	u8 password[];
+} __attribute__ ((packed, aligned(16)));
+
+struct label_attr {
+	u8 prefix[8];
+	u8 version;
+	u8 os;
+	u8 length;
+	u8 reserved[5];
+};
+
+struct label {
+	struct label_attr attr;
+	u8 name[MAX_NAME_SIZE];
+};
+
+static int pseries_status_to_err(int rc)
+{
+	int err;
+
+	switch (rc) {
+	case H_SUCCESS:
+		err = 0;
+		break;
+	case H_FUNCTION:
+		err = -ENXIO;
+		break;
+	case H_P2:
+	case H_P3:
+	case H_P4:
+	case H_P5:
+	case H_P6:
+		err = -EINVAL;
+		break;
+	case H_NOT_FOUND:
+		err = -ENOENT;
+		break;
+	case H_BUSY:
+		err = -EBUSY;
+		break;
+	case H_AUTHORITY:
+		err = -EPERM;
+		break;
+	case H_NO_MEM:
+		err = -ENOMEM;
+		break;
+	case H_RESOURCE:
+		err = -EEXIST;
+		break;
+	case H_TOO_BIG:
+		err = -EFBIG;
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+static int plpks_gen_password(void)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = {0};
+	u8 consumer = PKS_OS_OWNER;
+	int rc;
+
+	ospassword = kzalloc(config->maxpwsize, GFP_KERNEL);
+	if (!ospassword)
+		return -ENOMEM;
+
+	ospasswordlength = config->maxpwsize;
+	rc = plpar_hcall(H_PKS_GEN_PASSWORD,
+			retbuf,
+			consumer,
+			0,
+			virt_to_phys(ospassword),
+			config->maxpwsize);
+
+	return pseries_status_to_err(rc);
+}
+
+static int construct_auth(u8 consumer, struct plpks_auth **auth)
+{
+	pr_debug("max password size is %u\n", config->maxpwsize);
+
+	if (!auth || (consumer > 3))
+		return -EINVAL;
+
+	*auth = kmalloc(struct_size(*auth, password, config->maxpwsize),
+			GFP_KERNEL);
+	if (!*auth)
+		return -ENOMEM;
+
+	(*auth)->version = 1;
+	(*auth)->consumer = consumer;
+	(*auth)->rsvd0 = 0;
+	(*auth)->rsvd1 = 0;
+	if ((consumer == PKS_FW_OWNER) || (consumer == PKS_BOOTLOADER_OWNER)) {
+		pr_debug("consumer is bootloader or firmware\n");
+		(*auth)->passwordlength = 0;
+		return 0;
+	}
+
+	(*auth)->passwordlength = ospasswordlength;
+
+	memcpy((*auth)->password, ospassword, flex_array_size(*auth, password,
+					      (*auth)->passwordlength));
+	(*auth)->passwordlength = cpu_to_be16((*auth)->passwordlength);
+
+	return 0;
+}
+
+/**
+ * Label is combination of label attributes + name.
+ * Label attributes are used internally by kernel and not exposed to the user.
+ */
+static int construct_label(char *component, u8 *name, u16 namelen, u8 **label)
+{
+	int varlen;
+	int len = 0;
+	int llen = 0;
+	u8 anyos;
+	int i;
+	int rc = 0;
+	u8 labellength = MAX_LABEL_ATTR_SIZE;
+
+	if (!label)
+		return -EINVAL;
+
+	varlen = namelen + sizeof(struct label_attr);
+	*label = kzalloc(varlen, GFP_KERNEL);
+
+	if (!*label)
+		return -ENOMEM;
+
+	if (component) {
+		len = strlen(component);
+		memcpy(*label, component, len);
+	}
+	llen = len;
+
+	if (component)
+		len = 8 - strlen(component);
+	else
+		len = 8;
+
+	memset(*label + llen, 0, len);
+	llen = llen + len;
+
+	((*label)[llen]) = 0;
+	llen = llen + 1;
+
+	if (component)
+		if (memcmp(component, "sed-opal", 8) == 0)
+			anyos = PKS_VAR_COMMON;
+		else
+			anyos = PKS_VAR_LINUX;
+	else
+		anyos = PKS_VAR_LINUX;
+	memcpy(*label + llen, &anyos, 1);
+	llen = llen + 1;
+
+	memcpy(*label + llen, &labellength, 1);
+	llen = llen + 1;
+
+	memset(*label + llen, 0, 5);
+	llen = llen + 5;
+
+	memcpy(*label + llen, name, namelen);
+	llen = llen + namelen;
+
+	for (i = 0; i < llen; i++)
+		pr_debug("%c", (*label)[i]);
+
+	rc = llen;
+	return rc;
+}
+
+static int _plpks_get_config(void)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = {0};
+	int rc;
+	size_t size = sizeof(struct plpks_config);
+
+	config = kzalloc(size, GFP_KERNEL);
+	if (!config)
+		return -ENOMEM;
+
+	rc = plpar_hcall(H_PKS_GET_CONFIG,
+			retbuf,
+			virt_to_phys(config),
+			size);
+
+	if (rc != H_SUCCESS)
+		return pseries_status_to_err(rc);
+
+	config->rsvd0 = be32_to_cpu(config->rsvd0);
+	config->maxpwsize = be16_to_cpu(config->maxpwsize);
+	config->maxobjlabelsize = be16_to_cpu(config->maxobjlabelsize);
+	config->maxobjsize = be16_to_cpu(config->maxobjsize);
+	config->totalsize = be32_to_cpu(config->totalsize);
+	config->usedspace = be32_to_cpu(config->usedspace);
+	config->supportedpolicies = be32_to_cpu(config->supportedpolicies);
+	config->rsvd1 = be64_to_cpu(config->rsvd1);
+
+	configset = true;
+
+	return 0;
+}
+
+int plpks_signed_update_var(struct plpks_var var)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = {0};
+	int rc;
+	u8 *label;
+	u16 varlen;
+	u8 *data;
+	struct plpks_auth *auth;
+	u64 flags;
+	u64 continuetoken;
+
+	if (!var.data || (var.datalen <= 0)
+		  || (var.namelen > MAX_NAME_SIZE)
+		  || (var.datalen > MAX_DATA_SIZE))
+		return -EINVAL;
+
+	if (!(var.policy & SIGNEDUPDATE))
+		return -EINVAL;
+
+	rc = construct_auth(PKS_OS_OWNER, &auth);
+	if (rc)
+		return rc;
+
+	rc = construct_label(var.component, var.name, var.namelen, &label);
+	if (rc <= 0)
+		goto out;
+
+	varlen =  rc;
+	pr_debug("Name to be written is %s of label size %d\n", label, varlen);
+
+	memcpy(&flags, var.data, sizeof(u64));
+	data = kzalloc(var.datalen - sizeof(u64), GFP_KERNEL);
+	memcpy(data, var.data + sizeof(u64), var.datalen - sizeof(u64));
+
+	do {
+		rc = plpar_hcall(H_PKS_SIGNED_UPDATE,
+				retbuf,
+				virt_to_phys(auth),
+				virt_to_phys(label),
+				varlen,
+				var.policy,
+				flags,
+				virt_to_phys(data),
+				var.datalen);
+
+		continuetoken = retbuf[0];
+
+	} while (rc == H_BUSY);
+
+	rc = pseries_status_to_err(rc);
+
+	kfree(label);
+	kfree(data);
+
+out:
+	kfree(auth);
+
+	return rc;
+}
+EXPORT_SYMBOL(plpks_signed_update_var);
+
+int plpks_write_var(struct plpks_var var)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = {0};
+	int rc;
+	u8 *label;
+	u16 varlen;
+	u8 *data = var.data;
+	struct plpks_auth *auth;
+
+	if (!var.component || !data || (var.datalen <= 0)
+			   || (var.namelen > MAX_NAME_SIZE)
+			   || (var.datalen > MAX_DATA_SIZE))
+		return -EINVAL;
+
+	if (var.policy & SIGNEDUPDATE)
+		return -EINVAL;
+
+	rc = construct_auth(PKS_OS_OWNER, &auth);
+	if (rc)
+		return rc;
+
+	rc = construct_label(var.component, var.name, var.namelen, &label);
+	if (rc <= 0)
+		goto out;
+
+	varlen =  rc;
+	pr_debug("Name to be written is %s of label size %d\n", label, varlen);
+	rc = plpar_hcall(H_PKS_WRITE_OBJECT,
+			retbuf,
+			virt_to_phys(auth),
+			virt_to_phys(label),
+			varlen,
+			var.policy,
+			virt_to_phys(data),
+			var.datalen);
+
+	rc = pseries_status_to_err(rc);
+	kfree(label);
+
+out:
+	kfree(auth);
+
+	return rc;
+}
+EXPORT_SYMBOL(plpks_write_var);
+
+int plpks_remove_var(char *component, struct plpks_var_name vname)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = {0};
+	int rc;
+	u8 *label;
+	u16 varlen;
+	struct plpks_auth *auth;
+
+	if (!component || vname.namelen > MAX_NAME_SIZE)
+		return -EINVAL;
+
+	rc = construct_auth(PKS_OS_OWNER, &auth);
+	if (rc)
+		return rc;
+
+	rc = construct_label(component, vname.name, vname.namelen, &label);
+	if (rc <= 0)
+		goto out;
+
+	varlen = rc;
+	pr_debug("Name to be written is %s of label size %d\n", label, varlen);
+	rc = plpar_hcall(H_PKS_REMOVE_OBJECT,
+			retbuf,
+			virt_to_phys(auth),
+			virt_to_phys(label),
+			varlen);
+
+	rc = pseries_status_to_err(rc);
+	kfree(label);
+
+out:
+	kfree(auth);
+
+	return rc;
+}
+EXPORT_SYMBOL(plpks_remove_var);
+
+static int plpks_read_var(u8 consumer, struct plpks_var *var)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = {0};
+	int rc;
+	u16 outlen = config->maxobjsize;
+	u8 *label;
+	u8 *out;
+	u16 varlen;
+	struct plpks_auth *auth;
+
+	if (var->namelen > MAX_NAME_SIZE)
+		return -EINVAL;
+
+	rc = construct_auth(PKS_OS_OWNER, &auth);
+	if (rc)
+		return rc;
+
+	rc = construct_label(var->component, var->name, var->namelen, &label);
+	if (rc <= 0)
+		goto out;
+
+	varlen = rc;
+	pr_debug("Name to be written is %s of label size %d\n", label, varlen);
+	out = kzalloc(outlen, GFP_KERNEL);
+	if (!out)
+		goto out1;
+
+	rc = plpar_hcall(H_PKS_READ_OBJECT,
+			retbuf,
+			virt_to_phys(auth),
+			virt_to_phys(label),
+			varlen,
+			virt_to_phys(out),
+			outlen);
+
+	if (rc != H_SUCCESS) {
+		pr_err("Failed to read %d\n", rc);
+		rc = pseries_status_to_err(rc);
+		goto out2;
+	}
+
+	if ((var->datalen == 0) || (var->datalen > retbuf[0]))
+		var->datalen = retbuf[0];
+
+	var->data = kzalloc(var->datalen, GFP_KERNEL);
+	if (!var->data) {
+		rc = -ENOMEM;
+		goto out2;
+	}
+	var->policy = retbuf[1];
+
+	memcpy(var->data, out, var->datalen);
+
+out2:
+	kfree(out);
+
+out1:
+	kfree(label);
+
+out:
+	kfree(auth);
+
+	return rc;
+}
+
+int plpks_read_os_var(struct plpks_var *var)
+{
+	return plpks_read_var(PKS_OS_OWNER, var);
+}
+EXPORT_SYMBOL(plpks_read_os_var);
+
+int plpks_read_fw_var(struct plpks_var *var)
+{
+	return plpks_read_var(PKS_FW_OWNER, var);
+}
+EXPORT_SYMBOL(plpks_read_fw_var);
+
+int plpks_read_bootloader_var(struct plpks_var *var)
+{
+	return plpks_read_var(PKS_BOOTLOADER_OWNER, var);
+}
+EXPORT_SYMBOL(plpks_read_bootloader_var);
+
+struct plpks_config *plpks_get_config(void)
+{
+
+	if (!configset) {
+		if (_plpks_get_config())
+			return NULL;
+	}
+
+	return config;
+}
+EXPORT_SYMBOL(plpks_get_config);
+
+int __init pseries_plpks_init(void)
+{
+	int rc = 0;
+
+	rc = _plpks_get_config();
+
+	if (rc) {
+		pr_err("Error initializing plpks\n");
+		return rc;
+	}
+
+	rc = plpks_gen_password();
+	if (rc) {
+		if (rc == H_IN_USE) {
+			rc = 0;
+		} else {
+			pr_err("Failed setting password %d\n", rc);
+			rc = pseries_status_to_err(rc);
+			return rc;
+		}
+	}
+
+	return rc;
+}
+arch_initcall(pseries_plpks_init);
-- 
2.27.0

