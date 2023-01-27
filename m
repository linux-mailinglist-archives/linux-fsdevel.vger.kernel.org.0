Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02D567E57C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 13:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjA0Mif (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 07:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbjA0MiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:38:10 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6103424CBA;
        Fri, 27 Jan 2023 04:38:04 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RCRt8A027734;
        Fri, 27 Jan 2023 12:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ddsu/0jyS7fDDzRbZJAZ4q3biNn4PL2l/bOCSoC16xU=;
 b=rBYj8jxaewqEWEUOTLro71wE5EGObhAiyDkvdnSxQHNvHc8aU84fEYN6nK8VeOsN4DEw
 x16B7lvDQTqBPUlVHb91kxk4EMv2cUfTxttodgVygeDaIWVLdU6XZ+gIkdM228jQe7Kt
 6TXUABj5ToYWHdz06q4qsKe1sjxac2Sf7rt8PwaqMmQL3B3wd5dWfd23H9kgVTNsXGqb
 VuamSiTzgKnl31bnehZnOX552GddlfkI06PU7u3cbRbrUHHLnVAMvr/yBMJriUpiBllq
 jFebhrz1Omnix7bmH3j+SlMBepFnmNfII+JWQ6wHeyIfjKztRrb+Lyk4INhzQDR34PaM OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nce8m8vex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:00 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RCKOWl001554;
        Fri, 27 Jan 2023 12:38:00 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nce8m8vec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:00 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30R3aZGL028677;
        Fri, 27 Jan 2023 12:37:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87affhcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:37:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RCbuME15401514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 12:37:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF8FF20049;
        Fri, 27 Jan 2023 12:37:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25BFD20040;
        Fri, 27 Jan 2023 12:37:54 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.40.88])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 12:37:53 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 05/11] ext4: Add per CR extent scanned counter
Date:   Fri, 27 Jan 2023 18:07:32 +0530
Message-Id: <e320e13e0f966b8878f923b3a700568064dbe634.1674822311.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1674822311.git.ojaswin@linux.ibm.com>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5LjGqIYMMtTPIwktfANJT_7iolLfImSU
X-Proofpoint-GUID: 1L0AmnUo-F8HudI_5BbIMdlmzY97eyBG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_07,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
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
---
 fs/ext4/ext4.h    |  1 +
 fs/ext4/mballoc.c | 12 ++++++++++++
 fs/ext4/mballoc.h |  1 +
 3 files changed, 14 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6037b8e0af86..4ba2c95915eb 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1633,6 +1633,7 @@ struct ext4_sb_info {
 	atomic_t s_bal_success;	/* we found long enough chunks */
 	atomic_t s_bal_allocated;	/* in blocks */
 	atomic_t s_bal_ex_scanned;	/* total extents scanned */
+	atomic_t s_bal_cX_ex_scanned[EXT4_MB_NUM_CRS];	/* total extents scanned */
 	atomic_t s_bal_groups_scanned;	/* number of groups scanned */
 	atomic_t s_bal_goals;	/* goal hits */
 	atomic_t s_bal_breaks;	/* too long searches */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 323604a2ff45..07a50a13751c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2077,6 +2077,7 @@ static void ext4_mb_measure_extent(struct ext4_allocation_context *ac,
 	BUG_ON(ac->ac_status != AC_STATUS_CONTINUE);
 
 	ac->ac_found++;
+	ac->ac_cX_found[ac->ac_criteria]++;
 
 	/*
 	 * The special case - take what you catch first
@@ -2249,6 +2250,7 @@ void ext4_mb_simple_scan_group(struct ext4_allocation_context *ac,
 			break;
 		}
 		ac->ac_found++;
+		ac->ac_cX_found[ac->ac_criteria]++;
 
 		ac->ac_b_ex.fe_len = 1 << i;
 		ac->ac_b_ex.fe_start = k << i;
@@ -2362,6 +2364,7 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
 			max = mb_find_extent(e4b, i, sbi->s_stripe, &ex);
 			if (max >= sbi->s_stripe) {
 				ac->ac_found++;
+				ac->ac_cX_found[ac->ac_criteria]++;
 				ex.fe_logical = 0xDEADF00D; /* debug value */
 				ac->ac_b_ex = ex;
 				ext4_mb_use_best_found(ac, e4b);
@@ -2894,6 +2897,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR0]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR0]));
+	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR0]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[CR0]));
 	seq_printf(seq, "\t\tbad_suggestions: %u\n",
@@ -2903,6 +2907,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR1]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR1]));
+	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR1]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[CR1]));
 	seq_printf(seq, "\t\tbad_suggestions: %u\n",
@@ -2912,6 +2917,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR2]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR2]));
+	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR2]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[CR2]));
 
@@ -2919,6 +2925,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR3]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR3]));
+	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR3]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[CR3]));
 	seq_printf(seq, "\textents_scanned: %u\n", atomic_read(&sbi->s_bal_ex_scanned));
@@ -4216,7 +4223,12 @@ static void ext4_mb_collect_stats(struct ext4_allocation_context *ac)
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
index f0087a85e366..004b8d163cc9 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -193,6 +193,7 @@ struct ext4_allocation_context {
 	__u16 ac_groups_scanned;
 	__u16 ac_groups_linear_remaining;
 	__u16 ac_found;
+	__u16 ac_cX_found[EXT4_MB_NUM_CRS];
 	__u16 ac_tail;
 	__u16 ac_buddy;
 	__u8 ac_status;
-- 
2.31.1

