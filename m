Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B57A4B819D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 08:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiBPHdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 02:33:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiBPHdH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:33:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1B11704EA;
        Tue, 15 Feb 2022 23:32:52 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21G6dRax023616;
        Wed, 16 Feb 2022 07:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QO8IJ24lVGpbewZLMEJyHb1C3k5Nw+2DtNPDwd9jQkA=;
 b=IiKGLNlXNZdA8zfzV+Zi6xZ8VIdwT4XnLzPBZdg3524uAtObEO4EouQP9rq+rTqAB8X5
 T7L+xuw2QIbpVTQgPCxEdszwwhT48Mj/gnI1K27OPp8UFeM8/mts080TOo0ap5SFa1NI
 GAUGo9xGRn1u6vq6Od/tyM9hGq7GvLGyyloLRuxoZZRZd0QVHh6shzvLFCFy2jp540eI
 kWm1vOJfRn7elcE4UZEHFmh1zI+VmwdS/sVTQ/HtqrrDH0WpyEr1zd2/ZyF9N/6g5S3P
 Ta7PbfmlYS+1M+0yONH4d+lcTf4/3FekJmnvEJ4EmdKQ0mUpQWs0zO/+i8v4OKshQnaX Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e8tyuhw1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:03:03 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21G6tYcu010793;
        Wed, 16 Feb 2022 07:03:02 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e8tyuhw14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:03:02 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21G728pP027159;
        Wed, 16 Feb 2022 07:03:00 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3e64h9v15y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:03:00 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21G72wCQ39911790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 07:02:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C88252059;
        Wed, 16 Feb 2022 07:02:58 +0000 (GMT)
Received: from localhost (unknown [9.43.85.173])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E386852054;
        Wed, 16 Feb 2022 07:02:57 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 1/9] ext4: Correct cluster len and clusters changed accounting in ext4_mb_mark_bb
Date:   Wed, 16 Feb 2022 12:32:43 +0530
Message-Id: <a0b035d536bafa88110b74456853774b64c8ac40.1644992609.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644992609.git.riteshh@linux.ibm.com>
References: <cover.1644992609.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wJSx8lmTvqn0MGag2_466iJdBocpuDQ_
X-Proofpoint-ORIG-GUID: QNMUdHaVxDxMftvZ124n-UtMuGM5l-5r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_02,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 mlxlogscore=552 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ext4_mb_mark_bb() currently wrongly calculates cluster len (clen) and
flex_group->free_clusters. This patch fixes that.

Identified based on code review of ext4_mb_mark_bb() function.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 67ac95c4cd9b..b8ffbc0ebe14 100644
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

