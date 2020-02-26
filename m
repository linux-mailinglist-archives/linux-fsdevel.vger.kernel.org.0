Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 907DB16FB67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 10:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBZJ5e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 04:57:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727359AbgBZJ5d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:57:33 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01Q9oUss012974
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 04:57:32 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydcnc8bt0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 04:57:32 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 26 Feb 2020 09:57:29 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Feb 2020 09:57:25 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01Q9vP4o58917114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 09:57:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB6C14204B;
        Wed, 26 Feb 2020 09:57:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D39624205F;
        Wed, 26 Feb 2020 09:57:22 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.47.18])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Feb 2020 09:57:22 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 2/6] ext4: Optimize ext4_ext_precache for 0 depth
Date:   Wed, 26 Feb 2020 15:27:04 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1582702693.git.riteshh@linux.ibm.com>
References: <cover.1582702693.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022609-0028-0000-0000-000003DE196C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022609-0029-0000-0000-000024A334BB
Message-Id: <30a143eafd931603d54bef8026411d89c71ffdda.1582702694.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_02:2020-02-25,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=619
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260074
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch avoids the memory alloc & free path when depth is 0, 
since anyway there is no extra caching done in that case.
So on checking depth 0, simply return early.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/extents.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ee83fe7c98aa..0de548bb3c90 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -594,6 +594,12 @@ int ext4_ext_precache(struct inode *inode)
 	down_read(&ei->i_data_sem);
 	depth = ext_depth(inode);
 
+	/* Don't cache anything if there are no external extent blocks */
+	if (!depth) {
+		up_read(&ei->i_data_sem);
+		return ret;
+	}
+
 	path = kcalloc(depth + 1, sizeof(struct ext4_ext_path),
 		       GFP_NOFS);
 	if (path == NULL) {
@@ -601,9 +607,6 @@ int ext4_ext_precache(struct inode *inode)
 		return -ENOMEM;
 	}
 
-	/* Don't cache anything if there are no external extent blocks */
-	if (depth == 0)
-		goto out;
 	path[0].p_hdr = ext_inode_hdr(inode);
 	ret = ext4_ext_check(inode, path[0].p_hdr, depth, 0);
 	if (ret)
-- 
2.21.0

