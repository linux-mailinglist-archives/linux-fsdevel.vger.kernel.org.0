Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784BF715FF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 14:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjE3MhW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 08:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjE3MhG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 08:37:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34990E5C;
        Tue, 30 May 2023 05:36:12 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UCOYFq003194;
        Tue, 30 May 2023 12:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=87g985SKq4ExfhGaneyPoQKUQgMSVXN8EEuL8wWxiWw=;
 b=eUvhoIpnmJWWHJsxSIZCWAcxSgVzrRTtNSSG9C3QdzSd+uEyrLgPF8cskByCfuY8BCj+
 ECW9NtNdvcXM3aXjLAaBz9YgCoiWeC8jHD4zb2LumeUxODLW1+hEV8+EEkQJYeZyuUmP
 3nOhRJjVIoWMeckfpCoBP690LefmpSYQRMclo5OuUcU5x9zwd98hzfAQuOVKfBTlb/Iq
 BNU1CQ4UhSibpvChu154CILHq23iPcFbEAnRI5X8WrCb39XbkGowa13ZwR2FRnJr0LKJ
 Wu6+xHXMPXy+f9lq7fmkiwV+9zjMY/OdQnMj1XurNhqUVGGeT/+KVV+KiGktvsvQeV0F Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwh46r8s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:11 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UCQUhR007964;
        Tue, 30 May 2023 12:34:11 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwh46r8qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:10 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U3UTTZ029244;
        Tue, 30 May 2023 12:34:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qu9g51fev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34UCY6ru10617502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 12:34:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E48632004E;
        Tue, 30 May 2023 12:34:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15A0A20040;
        Tue, 30 May 2023 12:34:03 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 12:34:02 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v2 05/12] ext4: Add per CR extent scanned counter
Date:   Tue, 30 May 2023 18:03:43 +0530
Message-Id: <55bb6d80f6e22ed2a5a830aa045572bdffc8b1b9.1685449706.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685449706.git.ojaswin@linux.ibm.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HIfNjzvJiLukgtPSwjtrJ-PyJ5vnYw5D
X-Proofpoint-GUID: fgQlRo-4cTBfXgHqpzBduX4L7bDJL1BV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_08,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index f9a4eaa10c6a..2df4189ef778 100644
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
index 97eaa22b907d..a3106607486f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2104,6 +2104,7 @@ static void ext4_mb_measure_extent(struct ext4_allocation_context *ac,
 	BUG_ON(ac->ac_status != AC_STATUS_CONTINUE);
 
 	ac->ac_found++;
+	ac->ac_cX_found[ac->ac_criteria]++;
 
 	/*
 	 * The special case - take what you catch first
@@ -2278,6 +2279,7 @@ void ext4_mb_simple_scan_group(struct ext4_allocation_context *ac,
 			break;
 		}
 		ac->ac_found++;
+		ac->ac_cX_found[ac->ac_criteria]++;
 
 		ac->ac_b_ex.fe_len = 1 << i;
 		ac->ac_b_ex.fe_start = k << i;
@@ -2393,6 +2395,7 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
 			max = mb_find_extent(e4b, i, stripe, &ex);
 			if (max >= stripe) {
 				ac->ac_found++;
+				ac->ac_cX_found[ac->ac_criteria]++;
 				ex.fe_logical = 0xDEADF00D; /* debug value */
 				ac->ac_b_ex = ex;
 				ext4_mb_use_best_found(ac, e4b);
@@ -2930,6 +2933,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR0]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR0]));
+	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR0]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[CR0]));
 	seq_printf(seq, "\t\tbad_suggestions: %u\n",
@@ -2939,6 +2943,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR1]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR1]));
+	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR1]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[CR1]));
 	seq_printf(seq, "\t\tbad_suggestions: %u\n",
@@ -2948,6 +2953,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR2]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR2]));
+	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR2]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[CR2]));
 
@@ -2955,6 +2961,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[CR3]));
 	seq_printf(seq, "\t\tgroups_considered: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_groups_considered[CR3]));
+	seq_printf(seq, "\t\textents_scanned: %u\n", atomic_read(&sbi->s_bal_cX_ex_scanned[CR3]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[CR3]));
 	seq_printf(seq, "\textents_scanned: %u\n", atomic_read(&sbi->s_bal_ex_scanned));
@@ -4403,7 +4410,12 @@ static void ext4_mb_collect_stats(struct ext4_allocation_context *ac)
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

