Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850181733EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 10:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgB1J1T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 04:27:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726810AbgB1J1T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:27:19 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01S9Ku1H104231
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2020 04:27:18 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yepwhymtm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2020 04:27:18 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 28 Feb 2020 09:27:16 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Feb 2020 09:27:14 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01S9RDfG37486778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 09:27:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CE5342041;
        Fri, 28 Feb 2020 09:27:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDF0342047;
        Fri, 28 Feb 2020 09:27:10 +0000 (GMT)
Received: from dhcp-9-199-158-200.in.ibm.com (unknown [9.199.158.200])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Feb 2020 09:27:10 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        hch@infradead.org, cmaiolino@redhat.com, david@fromorbit.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv5 2/6] ext4: Optimize ext4_ext_precache for 0 depth
Date:   Fri, 28 Feb 2020 14:56:55 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1582880246.git.riteshh@linux.ibm.com>
References: <cover.1582880246.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022809-4275-0000-0000-000003A64905
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022809-4276-0000-0000-000038BACC1C
Message-Id: <93da0d0f073c73358e85bb9849d8a5378d1da539.1582880246.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-28_02:2020-02-26,2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=18 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=284
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002280078
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch avoids the memory alloc & free path when depth is 0,
since anyway there is no extra caching done in that case.
So on checking depth 0, simply return early.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
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

