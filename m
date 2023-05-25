Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC103710B0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 13:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbjEYLeO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 07:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240957AbjEYLdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 07:33:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42EFE7;
        Thu, 25 May 2023 04:33:36 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PAlLcK016047;
        Thu, 25 May 2023 11:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ABwR8cxxhdtxFZyh3vWPH5jroCx0zVHitmhQOhPm+sE=;
 b=pCSEDS4A0wZuvbR6GLg3NI+zShyqNKF1wN3rFy7bjyuUvSvLjJv1WK3MWZM44mIZfN8U
 IhSaQ2htBRDf2/+x0NlwJ7kcD/KdLd+yId7RngIYKU7jSDESrD/posj+z+M9c1ZKFO2G
 inIj40bVBGSRrMB9PYjT+I7wSd76DJ76leHQdkiUkZ3irLk2l4jRMihicBs1Sf+61woH
 6fj/RtseOp5vJXlgVBi6pS4jwcK6jN3VC3zZHyHd/nkpP/LhdqyzJ+fIY1JxL5X+lFco
 YhrKFDPVxkKfuRGdT37y+CGGq4Jl4nmHjqX3ap9T8VZRbeZH6j0Yc+6KvEr8Jw0cMHbQ 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt67w14f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:29 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34PBRbVt005418;
        Thu, 25 May 2023 11:33:28 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt67w14ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:28 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34P81dV4009515;
        Thu, 25 May 2023 11:33:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3qppc1209y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34PBXOYW37486850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 11:33:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 947A12004B;
        Thu, 25 May 2023 11:33:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA91220040;
        Thu, 25 May 2023 11:33:22 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 25 May 2023 11:33:22 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH 06/13] ext4: Add per CR extent scanned counter
Date:   Thu, 25 May 2023 17:03:00 +0530
Message-Id: <271fd97bd7e4521b7be86ff4db33fb0b8a495af1.1685009579.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685009579.git.ojaswin@linux.ibm.com>
References: <cover.1685009579.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: INbfQYUPOoZsaXmh7K6RSDUxS5gVP_Pn
X-Proofpoint-GUID: YBWaslFQNtIquZdZVyPXVfxfmQKkddZ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305250092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This gives better visibility into the number of extents scanned in each
particular CR. For example, this information can be used to see how out
block group scanning logic is performing when the BG is fragmented.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h    |  1 +
 fs/ext4/mballoc.c | 12 ++++++++++++
 fs/ext4/mballoc.h |  1 +
 3 files changed, 14 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2fa4e77eb3a1..7b460a31ac82 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1553,6 +1553,7 @@ struct ext4_sb_info {
 	atomic_t s_bal_success;	/* we found long enough chunks */
 	atomic_t s_bal_allocated;	/* in blocks */
 	atomic_t s_bal_ex_scanned;	/* total extents scanned */
+	atomic_t s_bal_cX_ex_scanned[EXT4_MB_NUM_CRS];	/* total extents scanned */
 	atomic_t s_bal_groups_scanned;	/* number of groups scanned */
 	atomic_t s_bal_goals;	/* goal hits */
 	atomic_t s_bal_breaks;	/* too long searches */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 10dd86a02997..98d93d2c5401 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2103,6 +2103,7 @@ static void ext4_mb_measure_extent(struct ext4_allocation_context *ac,
 	BUG_ON(ac->ac_status != AC_STATUS_CONTINUE);
 
 	ac->ac_found++;
+	ac->ac_cX_found[ac->ac_criteria]++;
 
 	/*
 	 * The special case - take what you catch first
@@ -2277,6 +2278,7 @@ void ext4_mb_simple_scan_group(struct ext4_allocation_context *ac,
 			break;
 		}
 		ac->ac_found++;
+		ac->ac_cX_found[ac->ac_criteria]++;
 
 		ac->ac_b_ex.fe_len = 1 << i;
 		ac->ac_b_ex.fe_start = k << i;
@@ -2390,6 +2392,7 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
 			max = mb_find_extent(e4b, i, sbi->s_stripe, &ex);
 			if (max >= sbi->s_stripe) {
 				ac->ac_found++;
+				ac->ac_cX_found[ac->ac_criteria]++;
 				ex.fe_logical = 0xDEADF00D; /* debug value */
 				ac->ac_b_ex = ex;
 				ext4_mb_use_best_found(ac, e4b);
@@ -2926,6 +2929,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR0]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR0]));
+	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR0]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[CR0]));
 	seq_printf(seq, "\t\tbad_suggestions: %u\n",
@@ -2935,6 +2939,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR1]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR1]));
+	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR1]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[CR1]));
 	seq_printf(seq, "\t\tbad_suggestions: %u\n",
@@ -2944,6 +2949,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR2]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR2]));
+	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR2]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[CR2]));
 
@@ -2951,6 +2957,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR3]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR3]));
+	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR3]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[CR3]));
 	seq_printf(seq, "\textents_scanned: %u\n", atomic_read(&sbi->s_bal_ex_scanned));
@@ -4390,7 +4397,12 @@ static void ext4_mb_collect_stats(struct ext4_allocation_context *ac)
 		atomic_add(ac->ac_b_ex.fe_len, &sbi->s_bal_allocated);
 		if (ac->ac_b_ex.fe_len >= ac->ac_o_ex.fe_len)
 			atomic_inc(&sbi->s_bal_success);
+
 		atomic_add(ac->ac_found, &sbi->s_bal_ex_scanned);
+		for (int i=0; i<EXT4_MB_NUM_CRS; i++) {
+			atomic_add(ac->ac_cX_found[i], &sbi->s_bal_cX_ex_scanned[i]);
+		}
+
 		atomic_add(ac->ac_groups_scanned, &sbi->s_bal_groups_scanned);
 		if (ac->ac_g_ex.fe_start == ac->ac_b_ex.fe_start &&
 				ac->ac_g_ex.fe_group == ac->ac_b_ex.fe_group)
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 24b666e558f1..acfdc204e15d 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -184,6 +184,7 @@ struct ext4_allocation_context {
 	__u16 ac_groups_scanned;
 	__u16 ac_groups_linear_remaining;
 	__u16 ac_found;
+	__u16 ac_cX_found[EXT4_MB_NUM_CRS];
 	__u16 ac_tail;
 	__u16 ac_buddy;
 	__u8 ac_status;
-- 
2.31.1

