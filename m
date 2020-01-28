Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF9414B271
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 11:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgA1KSu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 05:18:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725965AbgA1KSu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:18:50 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SAARcO067328
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 05:18:48 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xrg637fxr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 05:18:48 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 28 Jan 2020 10:18:46 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Jan 2020 10:18:42 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00SAHolI31326596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 10:17:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 626EDAE059;
        Tue, 28 Jan 2020 10:18:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A23CAE057;
        Tue, 28 Jan 2020 10:18:39 +0000 (GMT)
Received: from dhcp-9-199-158-40.in.ibm.com (unknown [9.199.158.40])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jan 2020 10:18:38 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        hch@infradead.org, cmaiolino@redhat.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFCv2 2/4] ext4: Optimize ext4_ext_precache for 0 depth
Date:   Tue, 28 Jan 2020 15:48:26 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1580121790.git.riteshh@linux.ibm.com>
References: <cover.1580121790.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012810-0012-0000-0000-000003816244
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012810-0013-0000-0000-000021BDB511
Message-Id: <597d295e3f667478de3e085800f7cdad75722823.1580121790.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_02:2020-01-24,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=307
 malwarescore=0 suspectscore=11 phishscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280083
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

