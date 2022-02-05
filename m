Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156D74AA94A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 15:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380083AbiBEOKT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 09:10:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239567AbiBEOKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:10:18 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 215DQrh2017152;
        Sat, 5 Feb 2022 14:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XZs0vgGx68Nu9xcAhPeplWHMIkaM0SZOLdc6eNGFIDo=;
 b=h+m/Il+LG7g6yNcfPmGkh1AxXJ7N8HrWuGH56Ca6oycqCmDWJsVneoUzsVZCbor4Grsz
 ecTFpAlHKqEU399Vj8n0Cg76oU54WE/4LaQhdXadBEbHhBhsQCyzqxohZhRS8mX6dXCl
 bz4sk1B0NmB37oTCrf6iv80Z06pFk4iE8NwKJ6F4fAl1K+VPy2LYFbAs/2fYbjHuKHR9
 S7PCYDb6jeMR32fxYAoirdJrG9wlt/2wBpVj0/OXf41i5xFU1KZQ2Rfe6FOzqbLYu/uS
 MRN9gmtI2vabxc7o0USpjgapXm0PNMs7KJKMmtHBIvuSqOdqxrrCY2w2Gl5mjb/g00se gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1h16qp8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:14 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 215DtuLA012304;
        Sat, 5 Feb 2022 14:10:14 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1h16qp8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:14 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 215E3Prl015021;
        Sat, 5 Feb 2022 14:10:11 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3e1gv8t0qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:11 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 215EA9aK44892664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 14:10:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A838A4055;
        Sat,  5 Feb 2022 14:10:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEAD9A4040;
        Sat,  5 Feb 2022 14:10:07 +0000 (GMT)
Received: from localhost (unknown [9.43.12.205])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  5 Feb 2022 14:10:07 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv1 1/9] ext4: Correct cluster len and clusters changed accounting in ext4_mb_mark_bb
Date:   Sat,  5 Feb 2022 19:39:50 +0530
Message-Id: <f2ab83d92010375afead88a8e41d7a0e1df94a10.1644062450.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644062450.git.riteshh@linux.ibm.com>
References: <cover.1644062450.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -qWqSAsbhaAY2152ZglRrMNYPHcxd72e
X-Proofpoint-ORIG-GUID: M4eByTj0Z44v-dHB1V8JlwWxKEQsJLiI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_10,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 mlxlogscore=627
 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202050095
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ext4_mb_mark_bb() currently wrongly calculates cluster len (clen) and
flex_group->free_clusters. This patch fixes that.

Identified based on code review of ext4_mb_mark_bb() function.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c781974df9d0..2f117ce3bb73 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3899,10 +3899,11 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_group_t group;
 	ext4_grpblk_t blkoff;
-	int i, clen, err;
+	int i, err;
 	int already;
+	unsigned int clen, clen_changed;
 
-	clen = EXT4_B2C(sbi, len);
+	clen = EXT4_NUM_B2C(sbi, len);
 
 	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
 	bitmap_bh = ext4_read_block_bitmap(sb, group);
@@ -3923,6 +3924,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 		if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) == !state)
 			already++;
 
+	clen_changed = clen - already;
 	if (state)
 		ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
 	else
@@ -3935,9 +3937,9 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 						group, gdp));
 	}
 	if (state)
-		clen = ext4_free_group_clusters(sb, gdp) - clen + already;
+		clen = ext4_free_group_clusters(sb, gdp) - clen_changed;
 	else
-		clen = ext4_free_group_clusters(sb, gdp) + clen - already;
+		clen = ext4_free_group_clusters(sb, gdp) + clen_changed;
 
 	ext4_free_group_clusters_set(sb, gdp, clen);
 	ext4_block_bitmap_csum_set(sb, group, gdp, bitmap_bh);
@@ -3947,10 +3949,13 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 
 	if (sbi->s_log_groups_per_flex) {
 		ext4_group_t flex_group = ext4_flex_group(sbi, group);
+		struct flex_groups *fg = sbi_array_rcu_deref(sbi,
+					   s_flex_groups, flex_group);
 
-		atomic64_sub(len,
-			     &sbi_array_rcu_deref(sbi, s_flex_groups,
-						  flex_group)->free_clusters);
+		if (state)
+			atomic64_sub(clen_changed, &fg->free_clusters);
+		else
+			atomic64_add(clen_changed, &fg->free_clusters);
 	}
 
 	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
-- 
2.31.1

