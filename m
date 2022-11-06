Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19A261E63E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Nov 2022 22:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiKFVIy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Nov 2022 16:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiKFVIq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:08:46 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FBD10BA;
        Sun,  6 Nov 2022 13:08:44 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A6Go9d7010545;
        Sun, 6 Nov 2022 21:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vyKXMiJNltHgwUz76VjitY5UHxk/04FjszPG4Qsf8gI=;
 b=lv2qo9eFFhk3xL/pW2aYjcbbT8EFSsOxP14ahAlv1Z4A8sP4x7/RXnRooOO9rpVNHPOJ
 YTpE/yzRtn4s1z6Qea0CgOKqPLfGHZAkDOA0A1EATpg/Osgwag7hhO+/lIQUckfyZJuj
 B+FpAgtAlaEqVZ//uSIMFjDBoptAdOdumQxtO5OB71Tf46WzjJlGDcw7BZGK9aVl7Ded
 29RkUewpHihuOmYHGU3qvX+FYhwkNNeykKFkt4rIn6IiGK4YPxpwKYihe9vc93IdDMH5
 HxEgvS/HbzZl/Q2jFWgNrX4hLbRgHqgvHVx5bWrEXnvmyKFUzmMdUruSah9RHgIpLgo3 Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp1utvtfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Nov 2022 21:08:13 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A6L3BZp025014;
        Sun, 6 Nov 2022 21:08:12 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp1utvtf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Nov 2022 21:08:12 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A6L6Bfn012616;
        Sun, 6 Nov 2022 21:08:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3kngmqh79p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Nov 2022 21:08:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A6L86Uq60883340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Nov 2022 21:08:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBCCB11C04C;
        Sun,  6 Nov 2022 21:08:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACC1511C04A;
        Sun,  6 Nov 2022 21:08:02 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.78.124])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Nov 2022 21:08:02 +0000 (GMT)
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
Subject: [PATCH 1/4] powerpc/pseries: Add new functions to PLPKS driver
Date:   Sun,  6 Nov 2022 16:07:41 -0500
Message-Id: <20221106210744.603240-2-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221106210744.603240-1-nayna@linux.ibm.com>
References: <20221106210744.603240-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7YCJKVa3OSt0_THGSkn_BGba6mQ2w3mA
X-Proofpoint-ORIG-GUID: HjjwrpVYZbrllcQTouJXDFGYBBKTAB2M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-06_14,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211060188
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PowerVM stores authenticated variables in the PowerVM LPAR Platform
KeyStore(PLPKS).

Add signed update H_CALL to PLPKS driver to support authenticated
variables. Additionally, expose config values outside the PLPKS
driver.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h      |   3 +-
 arch/powerpc/platforms/pseries/plpks.c | 112 +++++++++++++++++++++++--
 arch/powerpc/platforms/pseries/plpks.h |  35 ++++++++
 3 files changed, 144 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 95fd7f9485d5..33b26c0cb69b 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -336,7 +336,8 @@
 #define H_SCM_FLUSH		0x44C
 #define H_GET_ENERGY_SCALE_INFO	0x450
 #define H_WATCHDOG		0x45C
-#define MAX_HCALL_OPCODE	H_WATCHDOG
+#define H_PKS_SIGNED_UPDATE	0x454
+#define MAX_HCALL_OPCODE	H_PKS_SIGNED_UPDATE
 
 /* Scope args for H_SCM_UNBIND_ALL */
 #define H_UNBIND_SCOPE_ALL (0x1)
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 4edd1585e245..d0fa7b55a900 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -40,6 +40,10 @@ static u16 ospasswordlength;
 // Retrieved with H_PKS_GET_CONFIG
 static u16 maxpwsize;
 static u16 maxobjsize;
+static s16 maxobjlabelsize;
+static u32 totalsize;
+static u32 usedspace;
+static u8 version;
 
 struct plpks_auth {
 	u8 version;
@@ -87,6 +91,12 @@ static int pseries_status_to_err(int rc)
 		err = -ENOENT;
 		break;
 	case H_BUSY:
+	case H_LONG_BUSY_ORDER_1_MSEC:
+	case H_LONG_BUSY_ORDER_10_MSEC:
+	case H_LONG_BUSY_ORDER_100_MSEC:
+	case H_LONG_BUSY_ORDER_1_SEC:
+	case H_LONG_BUSY_ORDER_10_SEC:
+	case H_LONG_BUSY_ORDER_100_SEC:
 		err = -EBUSY;
 		break;
 	case H_AUTHORITY:
@@ -187,14 +197,17 @@ static struct label *construct_label(char *component, u8 varos, u8 *name,
 				     u16 namelen)
 {
 	struct label *label;
-	size_t slen;
+	size_t slen = 0;
 
 	if (!name || namelen > MAX_NAME_SIZE)
 		return ERR_PTR(-EINVAL);
 
-	slen = strlen(component);
-	if (component && slen > sizeof(label->attr.prefix))
-		return ERR_PTR(-EINVAL);
+	/* Support NULL component for signed updates */
+	if (component) {
+		slen = strlen(component);
+		if (slen > sizeof(label->attr.prefix))
+			return ERR_PTR(-EINVAL);
+	}
 
 	label = kzalloc(sizeof(*label), GFP_KERNEL);
 	if (!label)
@@ -240,10 +253,51 @@ static int _plpks_get_config(void)
 
 	maxpwsize = be16_to_cpu(config.maxpwsize);
 	maxobjsize = be16_to_cpu(config.maxobjsize);
+	maxobjlabelsize = be16_to_cpu(config.maxobjlabelsize) -
+			  MAX_LABEL_ATTR_SIZE;
+	maxobjlabelsize = maxobjlabelsize < 0 ? 0 : maxobjlabelsize;
+	totalsize = be32_to_cpu(config.totalsize);
+	usedspace = be32_to_cpu(config.usedspace);
 
 	return 0;
 }
 
+u8 plpks_get_version(void)
+{
+	return version;
+}
+
+u16 plpks_get_maxobjectsize(void)
+{
+	return maxobjsize;
+}
+
+u16 plpks_get_maxobjectlabelsize(void)
+{
+	return maxobjlabelsize;
+}
+
+u32 plpks_get_totalsize(void)
+{
+	return totalsize;
+}
+
+u32 plpks_get_usedspace(void)
+{
+	return usedspace;
+}
+
+bool plpks_is_available(void)
+{
+	int rc;
+
+	rc = _plpks_get_config();
+	if (rc)
+		return false;
+
+	return true;
+}
+
 static int plpks_confirm_object_flushed(struct label *label,
 					struct plpks_auth *auth)
 {
@@ -277,6 +331,54 @@ static int plpks_confirm_object_flushed(struct label *label,
 	return rc;
 }
 
+int plpks_signed_update_var(struct plpks_var var, u64 flags)
+{
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
+	int rc;
+	struct label *label;
+	struct plpks_auth *auth;
+	u64 continuetoken = 0;
+
+	if (!var.data || var.datalen <= 0 || var.namelen > MAX_NAME_SIZE)
+		return -EINVAL;
+
+	if (!(var.policy & SIGNEDUPDATE))
+		return -EINVAL;
+
+	auth = construct_auth(PKS_OS_OWNER);
+	if (IS_ERR(auth))
+		return PTR_ERR(auth);
+
+	label = construct_label(var.component, var.os, var.name, var.namelen);
+	if (IS_ERR(label)) {
+		rc = PTR_ERR(label);
+		goto out;
+	}
+
+	do {
+		rc = plpar_hcall9(H_PKS_SIGNED_UPDATE, retbuf,
+				  virt_to_phys(auth), virt_to_phys(label),
+				  label->size, var.policy, flags,
+				  virt_to_phys(var.data), var.datalen,
+				  continuetoken);
+
+		continuetoken = retbuf[0];
+		rc = pseries_status_to_err(rc);
+	} while (rc == -EBUSY);
+
+	if (!rc) {
+		rc = plpks_confirm_object_flushed(label, auth);
+		rc = pseries_status_to_err(rc);
+	}
+
+	kfree(label);
+out:
+	kfree(auth);
+
+	return rc;
+}
+EXPORT_SYMBOL(plpks_signed_update_var);
+
 int plpks_write_var(struct plpks_var var)
 {
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
@@ -323,7 +425,7 @@ int plpks_remove_var(char *component, u8 varos, struct plpks_var_name vname)
 	struct label *label;
 	int rc;
 
-	if (!component || vname.namelen > MAX_NAME_SIZE)
+	if (vname.namelen > MAX_NAME_SIZE)
 		return -EINVAL;
 
 	auth = construct_auth(PKS_OS_OWNER);
diff --git a/arch/powerpc/platforms/pseries/plpks.h b/arch/powerpc/platforms/pseries/plpks.h
index 275ccd86bfb5..fb483658549f 100644
--- a/arch/powerpc/platforms/pseries/plpks.h
+++ b/arch/powerpc/platforms/pseries/plpks.h
@@ -40,6 +40,11 @@ struct plpks_var_name_list {
 	struct plpks_var_name varlist[];
 };
 
+/**
+ * Updates the authenticated variable. It expects NULL as the component.
+ */
+int plpks_signed_update_var(struct plpks_var var, u64 flags);
+
 /**
  * Writes the specified var and its data to PKS.
  * Any caller of PKS driver should present a valid component type for
@@ -68,4 +73,34 @@ int plpks_read_fw_var(struct plpks_var *var);
  */
 int plpks_read_bootloader_var(struct plpks_var *var);
 
+/**
+ * Returns if PKS is available on this LPAR.
+ */
+bool plpks_is_available(void);
+
+/**
+ * Returns version of the Platform KeyStore.
+ */
+u8 plpks_get_version(void);
+
+/**
+ * Returns maximum object size supported by Platform KeyStore.
+ */
+u16 plpks_get_maxobjectsize(void);
+
+/**
+ * Returns maximum object label size supported by Platform KeyStore.
+ */
+u16 plpks_get_maxobjectlabelsize(void);
+
+/**
+ * Returns total size of the configured Platform KeyStore.
+ */
+u32 plpks_get_totalsize(void);
+
+/**
+ * Returns used space from the total size of the Platform KeyStore.
+ */
+u32 plpks_get_usedspace(void);
+
 #endif
-- 
2.31.1

