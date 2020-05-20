Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E9E1DAAC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 08:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgETGlM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 02:41:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726596AbgETGlK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 02:41:10 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04K6VNgX039696;
        Wed, 20 May 2020 02:41:04 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312c659w81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 02:41:04 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04K6eOsE007591;
        Wed, 20 May 2020 06:41:02 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 313xas32ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 06:41:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04K6f0vn56819850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 06:41:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECDCCA4060;
        Wed, 20 May 2020 06:40:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D59CA4066;
        Wed, 20 May 2020 06:40:58 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.188.115])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 May 2020 06:40:58 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv5 2/5] ext4: mballoc: Refactor ext4_mb_discard_preallocations()
Date:   Wed, 20 May 2020 12:10:33 +0530
Message-Id: <1cfae0098d2aa9afbeb59331401258182868c8f2.1589955723.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589955723.git.riteshh@linux.ibm.com>
References: <cover.1589955723.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_02:2020-05-19,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=1 mlxlogscore=999 cotscore=-2147483648
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200051
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement ext4_mb_discard_preallocations_should_retry()
which we will need in later patches to add more logic
like check for sequence number match to see if we should
retry for block allocation or not.

There should be no functionality change in this patch.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index decc5168d126..b75408d72773 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4543,6 +4543,17 @@ static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
 	return freed;
 }
 
+static bool ext4_mb_discard_preallocations_should_retry(struct super_block *sb,
+			struct ext4_allocation_context *ac)
+{
+	int freed;
+
+	freed = ext4_mb_discard_preallocations(sb, ac->ac_o_ex.fe_len);
+	if (freed)
+		return true;
+	return false;
+}
+
 /*
  * Main entry point into mballoc to allocate blocks
  * it tries to use preallocation first, then falls back
@@ -4551,7 +4562,6 @@ static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
 ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 				struct ext4_allocation_request *ar, int *errp)
 {
-	int freed;
 	struct ext4_allocation_context *ac = NULL;
 	struct ext4_sb_info *sbi;
 	struct super_block *sb;
@@ -4656,8 +4666,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 			ar->len = ac->ac_b_ex.fe_len;
 		}
 	} else {
-		freed  = ext4_mb_discard_preallocations(sb, ac->ac_o_ex.fe_len);
-		if (freed)
+		if (ext4_mb_discard_preallocations_should_retry(sb, ac))
 			goto repeat;
 		/*
 		 * If block allocation fails then the pa allocated above
-- 
2.21.0

