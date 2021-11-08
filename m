Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5946D449A5D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 18:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbhKHRD7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 12:03:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48768 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235453AbhKHRD6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:03:58 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8GWLA7017554;
        Mon, 8 Nov 2021 17:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=qTgha4aiz9iITjfGZMEm4VpbubZUM3+NuX3efHPL2o0=;
 b=JVxVWMrWNK7+wSWWcn15sfRlQk07rHCf1mB/5bantLMY/0hpLjetJOc7wVQNyUDuh6xM
 KqAeZDznH/mesdAyokZ5KmFUCvluY/xU80+v6r7vXSLFCPO2nekWZJ4PLfRiYoUeRe58
 4BCRLXQvNOwrXSm9n7wMuMTItQ3oMxxKhpHDiKsRUNhj88th9Bjc7lj8Xi4HjxxnE5bj
 QZlUwBoeqxiGG1yw05Wy2KqPEbajhy7y/piv+MIsK0bi/zkwW6gz9O7Ns7cOd/wW0VvU
 2gcGtiTMW/AXg52cBUBJohD2aOEdQg7Dm+sz3Ms7kkOZqD1RGV8ToojCxN8K02sW1SIr Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c69dn3cue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 17:01:10 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A8GXpG8025230;
        Mon, 8 Nov 2021 17:01:10 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c69dn3cth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 17:01:10 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A8Gm9t6016447;
        Mon, 8 Nov 2021 17:01:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3c5hb9q2bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 17:01:08 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A8H159423265568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Nov 2021 17:01:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D97674C040;
        Mon,  8 Nov 2021 17:01:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AA464C050;
        Mon,  8 Nov 2021 17:01:04 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.5.243])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Nov 2021 17:01:04 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [RFC PATCH] ima: differentiate overlay, pivot_root, and other pathnames
Date:   Mon,  8 Nov 2021 12:01:00 -0500
Message-Id: <20211108170100.148066-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ezzw92u2Y38_C0kO_2kbEnL3pYcIFrfD
X-Proofpoint-ORIG-GUID: RptRndZ79OCqbGHtOyVZS2wU9ky8XPLf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_05,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080103
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Relative file pathnames are included in the IMA measurement list making
it difficult to differentiate files.  Permit replacing the relative
pathname with the (raw) full pathname in the measurement list.

Define a new module param named "ima.rawpath".

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
comment: this change does not address the simple "unshare -m" case
without pivot_root.

 .../admin-guide/kernel-parameters.txt          |  7 +++++++
 security/integrity/ima/ima_api.c               | 18 +++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91ba391f9b32..d49a5edcd3c3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1890,6 +1890,13 @@
 			different crypto accelerators. This option can be used
 			to achieve best performance for particular HW.
 
+	ima.rawpath=	[IMA]
+			Format: <bool>
+			Default: 0
+			This parameter controls whether the IMA measurement
+			list contains the relative or raw full file pathnames
+			in the IMA measurement list.
+
 	init=		[KNL]
 			Format: <full_path>
 			Run specified binary instead of /sbin/init as init
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index a64fb0130b01..42c6ff7056e6 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -9,14 +9,19 @@
  *	appraise_measurement, store_measurement and store_template.
  */
 #include <linux/slab.h>
+#include <linux/moduleparam.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <linux/xattr.h>
 #include <linux/evm.h>
 #include <linux/iversion.h>
 
 #include "ima.h"
 
+static bool rawpath_enabled;
+module_param_named(rawpath, rawpath_enabled, bool, 0);
+
 /*
  * ima_free_template_entry - free an existing template entry
  */
@@ -390,11 +395,22 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
  */
 const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
 {
+	struct dentry *dentry = NULL;
 	char *pathname = NULL;
 
 	*pathbuf = __getname();
 	if (*pathbuf) {
-		pathname = d_absolute_path(path, *pathbuf, PATH_MAX);
+		if (!rawpath_enabled) {
+			pathname = d_absolute_path(path, *pathbuf, PATH_MAX);
+		} else {
+			/* Use union/overlay full pathname */
+			if (unlikely(path->dentry->d_flags & DCACHE_OP_REAL))
+				dentry = d_real(path->dentry, NULL);
+			else
+				dentry = path->dentry;
+			pathname = dentry_path_raw(dentry, *pathbuf, PATH_MAX);
+		}
+
 		if (IS_ERR(pathname)) {
 			__putname(*pathbuf);
 			*pathbuf = NULL;
-- 
2.27.0

