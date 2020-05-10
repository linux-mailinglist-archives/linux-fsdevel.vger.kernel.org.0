Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CB51CC73E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 08:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgEJGZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 02:25:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727122AbgEJGZs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 02:25:48 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A639Ux043295;
        Sun, 10 May 2020 02:25:42 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ws59bx06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 02:25:42 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A6K7ef020359;
        Sun, 10 May 2020 06:25:40 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 30wm558t4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 06:25:40 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A6Pc1d65798284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 06:25:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0427242042;
        Sun, 10 May 2020 06:25:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 738AF42041;
        Sun, 10 May 2020 06:25:36 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 06:25:36 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 10/16] ext4: balloc: Use task_pid_nr() helper
Date:   Sun, 10 May 2020 11:54:50 +0530
Message-Id: <4b58403e15e9c8deb34a1b93deb3fc9cd153ab84.1589086800.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086800.git.riteshh@linux.ibm.com>
References: <cover.1589086800.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_01:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=1 adultscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=795
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005100055
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use task_pid_nr() function instead of current->pid.
There should be no functionality change in this patch.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/balloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index a32e5f7b5385..1ba46d87cdf1 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -903,10 +903,11 @@ ext4_fsblk_t ext4_inode_to_goal_block(struct inode *inode)
 		return bg_start;
 
 	if (bg_start + EXT4_BLOCKS_PER_GROUP(inode->i_sb) <= last_block)
-		colour = (current->pid % 16) *
+		colour = (task_pid_nr(current) % 16) *
 			(EXT4_BLOCKS_PER_GROUP(inode->i_sb) / 16);
 	else
-		colour = (current->pid % 16) * ((last_block - bg_start) / 16);
+		colour = (task_pid_nr(current) % 16) *
+			((last_block - bg_start) / 16);
 	return bg_start + colour;
 }
 
-- 
2.21.0

