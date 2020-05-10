Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67761CC742
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 08:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgEJGZw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 02:25:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18174 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbgEJGZv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 02:25:51 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A62Asv074332;
        Sun, 10 May 2020 02:25:46 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30xa4gab9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 02:25:46 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A6K14D027746;
        Sun, 10 May 2020 06:25:44 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 30wm55j0tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 06:25:44 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A6OVbO62587280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 06:24:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0C874204D;
        Sun, 10 May 2020 06:25:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C6BD4203F;
        Sun, 10 May 2020 06:25:40 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 06:25:40 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 12/16] ext4: Improve ext_debug() msg in case of block allocation failure
Date:   Sun, 10 May 2020 11:54:52 +0530
Message-Id: <1610ec2aa932396be00f9d552fe29da473ead176.1589086800.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086800.git.riteshh@linux.ibm.com>
References: <cover.1589086800.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_01:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 suspectscore=1 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005100050
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ext4_map_blocks() has ext_debug msg early at the start of function.
We also get ext_debug msg if we could allocate a block from
ext4_ext_map_blocks(). But there is no ext_debug() msg in case of
block allocation failure. So add one along with error code.

Also add more info in ext_debug() msg like how many blocks were allocated
v/s how many were requested in ext4_ext_map_blocks().

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/extents.c | 4 ++--
 fs/ext4/inode.c   | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f2b577b315a0..461600c07316 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4218,10 +4218,10 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	newblock = ext4_mb_new_blocks(handle, &ar, &err);
 	if (!newblock)
 		goto out2;
-	ext_debug("allocate new block: goal %llu, found %llu/%u\n",
-		  ar.goal, newblock, allocated);
 	allocated_clusters = ar.len;
 	ar.len = EXT4_C2B(sbi, ar.len) - offset;
+	ext_debug("allocate new block: goal %llu, found %llu/%u, requested %u\n",
+		  ar.goal, newblock, ar.len, allocated);
 	if (ar.len > allocated)
 		ar.len = allocated;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e294abeb7f03..5f120af22d48 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -726,6 +726,10 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 				return ret;
 		}
 	}
+
+	if (retval < 0)
+		ext_debug("failed for inode %lu with err %d\n",
+			  inode->i_ino, retval);
 	return retval;
 }
 
-- 
2.21.0

