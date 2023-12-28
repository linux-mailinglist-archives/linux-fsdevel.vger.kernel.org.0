Return-Path: <linux-fsdevel+bounces-6992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC2581F6B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 11:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690EF285621
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 10:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAA46AAD;
	Thu, 28 Dec 2023 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EapI1PpO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB963D1;
	Thu, 28 Dec 2023 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BS9OU96018640;
	Thu, 28 Dec 2023 10:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=cWe/25it10EMHhkWu1PLMQPFydg3tc9FhUjbVhZUt7E=;
 b=EapI1PpOnuAhqZbC4v5TbwTeUkiuSQE8TQSQC0MUzUIjiN3JaRUabyammQFFiyf6KJbX
 owg4+bs+QB1ZTM+ydrSq/54jDfzC7gKNcOk9+Br9eSe0CiwfLn2NrqwIEq0XWz67an6Y
 Z5ly3zosB30YK9L/S7KtKYuClhkLzlyzmQtdseKNWIZsztvdAK7es1tAIK27xs8up8IK
 6OSa4xYiOmD3pZi+vg8iTzIzSDlMCPzNpVdhNJ8QFBZRbJx7aXmlrQego2IVjutAuht/
 7yvUP70QcJrgh/+SWs7r6f9OqXP/UMwOozF5pKWks8gJObvhpM1JW9qyad/PVMDgRdU6 Hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5pfce3ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 10:06:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BS91V7R028761;
	Thu, 28 Dec 2023 10:06:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v5p0d4afn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 10:06:31 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BSA6VwO035795;
	Thu, 28 Dec 2023 10:06:31 GMT
Received: from localhost.localdomain (dhcp-10-175-56-248.vpn.oracle.com [10.175.56.248])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v5p0d4aaq-1;
	Thu, 28 Dec 2023 10:06:30 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH -next] fs: fix __sb_write_started() kerneldoc formatting
Date: Thu, 28 Dec 2023 11:06:08 +0100
Message-Id: <20231228100608.3123987-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-28_02,2023-12-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312280080
X-Proofpoint-GUID: fpLWot9syO7IQo91pEzJGc8cMzWivCia
X-Proofpoint-ORIG-GUID: fpLWot9syO7IQo91pEzJGc8cMzWivCia

When running 'make htmldocs', I see the following warning:

  Documentation/filesystems/api-summary:14: ./include/linux/fs.h:1659: WARNING: Definition list ends without a blank line; unexpected unindent.

The official guidance [1] seems to be to use lists, which will prevent
both the "unexpected unindent" warning as well as ensure that each line
is formatted on a separate line in the HTML output instead of being
all considered a single paragraph.

[1]: https://docs.kernel.org/doc-guide/kernel-doc.html#return-values

Fixes: 8802e580ee64 ("fs: create __sb_write_started() helper")
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
Applies to git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.rw

 include/linux/fs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index db5d07e6e02e..473063f385e5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1650,9 +1650,9 @@ static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
  * @sb: the super we write to
  * @level: the freeze level
  *
- * > 0 sb freeze level is held
- *   0 sb freeze level is not held
- * < 0 !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN
+ * * > 0 - sb freeze level is held
+ * *   0 - sb freeze level is not held
+ * * < 0 - !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN
  */
 static inline int __sb_write_started(const struct super_block *sb, int level)
 {
-- 
2.34.1


