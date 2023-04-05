Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCE96D84AF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 19:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjDERPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 13:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDERPG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:15:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08DA1BEF;
        Wed,  5 Apr 2023 10:15:05 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335GG6GM013112;
        Wed, 5 Apr 2023 17:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=xdPANpjtlbwea8smzHbacqN4g1Ruy2zYgHhQtcKL4jA=;
 b=JviavfdghGpxFybYoZ5PlrAS6QH2tK6y0r0h+eXId+HQSVyuZwFsAE51ZdMf1ff8IoSY
 P++/zzbiTHnTDBH9nzhlqIg3PrXzCqG3Ag4Ui7vYjJ+SYDACo3jAydx7qX4BAmris178
 pSHQRQqmageLgFAvtA+6VddGcD5/HFH4snG+444FBWx9UBBRgbMxO4wf0+V11IoVldbJ
 fUBcS1Y+CJcWyp+IS+74gxvt0hoNYLjeLOYYde0GmAJIDbwNDfVjwLU3s2pSjWN+I7DV
 8BrNIpuZsqc1J5HzEP9DCeb9eWi6kAyGm4xsmky9G580xQpWuJGp80zwxn/Zy53Yj8r8 GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps8w7yu2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 17:15:04 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 335Gk6am002751;
        Wed, 5 Apr 2023 17:15:03 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps8w7yu29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 17:15:03 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 335H1GMO031516;
        Wed, 5 Apr 2023 17:15:03 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3ppc88d3y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 17:15:02 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335HF1hV36307508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 17:15:01 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17F085805C;
        Wed,  5 Apr 2023 17:15:01 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D01B58059;
        Wed,  5 Apr 2023 17:15:00 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Apr 2023 17:15:00 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        miklos@szeredi.hu
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after writes
Date:   Wed,  5 Apr 2023 13:14:49 -0400
Message-Id: <20230405171449.4064321-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I-u9B3_Iu8NUUSka9TVqB0TEA3acKn1L
X-Proofpoint-ORIG-GUID: usiMNPTQycmGVGH7XZb5S6smuMFo-bqs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_11,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050154
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overlayfs fails to notify IMA / EVM about file content modifications
and therefore IMA-appraised files may execute even though their file
signature does not validate against the changed hash of the file
anymore. To resolve this issue, add a call to integrity_notify_change()
to the ovl_release() function to notify the integrity subsystem about
file changes. The set flag triggers the re-evaluation of the file by
IMA / EVM once the file is accessed again.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 fs/overlayfs/file.c       |  4 ++++
 include/linux/integrity.h |  6 ++++++
 security/integrity/iint.c | 13 +++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 6011f955436b..19b8f4bcc18c 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/integrity.h>
 #include "overlayfs.h"
 
 struct ovl_aio_req {
@@ -169,6 +170,9 @@ static int ovl_open(struct inode *inode, struct file *file)
 
 static int ovl_release(struct inode *inode, struct file *file)
 {
+	if (file->f_flags & O_ACCMODE)
+		integrity_notify_change(inode);
+
 	fput(file->private_data);
 
 	return 0;
diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index 2ea0f2f65ab6..cefdeccc1619 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -23,6 +23,7 @@ enum integrity_status {
 #ifdef CONFIG_INTEGRITY
 extern struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
 extern void integrity_inode_free(struct inode *inode);
+extern void integrity_notify_change(struct inode *inode);
 extern void __init integrity_load_keys(void);
 
 #else
@@ -37,6 +38,11 @@ static inline void integrity_inode_free(struct inode *inode)
 	return;
 }
 
+static inline void integrity_notify_change(struct inode *inode)
+{
+	return;
+}
+
 static inline void integrity_load_keys(void)
 {
 }
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8638976f7990..70d2d716f3ae 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -85,6 +85,19 @@ static void iint_free(struct integrity_iint_cache *iint)
 	kmem_cache_free(iint_cache, iint);
 }
 
+void integrity_notify_change(struct inode *inode)
+{
+	struct integrity_iint_cache *iint;
+
+	if (!IS_IMA(inode))
+		return;
+
+	iint = integrity_iint_find(inode);
+	if (iint)
+		set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
+}
+EXPORT_SYMBOL_GPL(integrity_notify_change);
+
 /**
  * integrity_inode_get - find or allocate an iint associated with an inode
  * @inode: pointer to the inode
-- 
2.34.1

