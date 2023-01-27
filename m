Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E97F67E57F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 13:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbjA0Miy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 07:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjA0Mia (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:38:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E88223859;
        Fri, 27 Jan 2023 04:38:06 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RBET1Y014380;
        Fri, 27 Jan 2023 12:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=M1tb4cjH4bgJJnWusS9MEZJss0JDmzKW4zB+owgJxGA=;
 b=btuC1X9nWwAj2GbGt8lRrwSlWKQNLH51G9HP4KFSIU9q8LugLCs2NK0TEyZDFfkEpMN9
 8s14ML+FKTCqRlTwsLxB9LNdTDFV6jC0FcGgMpzWGKz/4pCSmiqiwjjRU5r9vDY8VoUI
 kfEQP+PnUlGy6VbZ9F/avhyEWSllK3Tzw6Khtz056MFnfA4wTKchEqOsjnG+BMb00Vcd
 yL0uUayJgrGxUm4QAJhn/Dfhf3vE8tJ/11vlmQgGjwr8aae+ipbQBdXEVcmXmg62al3/
 LzNoKcMb393Db1Kbxz6yKwXP7lhBwIXZfULnIJhiOQdmFIheTHiWDYHBNXCBqkb6SVjq 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncdj7hwyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:02 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RBr2Zi010709;
        Fri, 27 Jan 2023 12:38:02 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncdj7hwy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:02 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QKVxYn027489;
        Fri, 27 Jan 2023 12:38:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6fhs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RCbw1J24314518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 12:37:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FD8D2004B;
        Fri, 27 Jan 2023 12:37:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5714220040;
        Fri, 27 Jan 2023 12:37:56 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.40.88])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 12:37:56 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 06/11] ext4: Add counter to track successful allocation of goal length
Date:   Fri, 27 Jan 2023 18:07:33 +0530
Message-Id: <e6a33294b00b5e02eb0b621e8192a641d34eea1f.1674822311.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1674822311.git.ojaswin@linux.ibm.com>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k-7xJYDov3F73zXb2tDJk4djzdO9ZhOs
X-Proofpoint-ORIG-GUID: S46KAwtfGnQooOLJOPtt0wa_y-m6rU0s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Track number of allocations where the length of blocks allocated is equal to the
length of goal blocks (post normalization). This metric could be useful if
making changes to the allocator logic in the future as it could give us
visibility into how often do we trim our requests.

PS: ac_b_ex.fe_len might get modified due to preallocation efforts and
hence we use ac_f_ex.fe_len instead since we want to compare how much the
allocator was able to actually find.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h    | 1 +
 fs/ext4/mballoc.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 4ba2c95915eb..d8fa01e54e81 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1636,6 +1636,7 @@ struct ext4_sb_info {
 	atomic_t s_bal_cX_ex_scanned[EXT4_MB_NUM_CRS];	/* total extents scanned */
 	atomic_t s_bal_groups_scanned;	/* number of groups scanned */
 	atomic_t s_bal_goals;	/* goal hits */
+	atomic_t s_bal_len_goals;	/* len goal hits */
 	atomic_t s_bal_breaks;	/* too long searches */
 	atomic_t s_bal_2orders;	/* 2^order hits */
 	atomic_t s_bal_cr0_bad_suggestions;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 07a50a13751c..c4ab8f412d32 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2930,6 +2930,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 		   atomic64_read(&sbi->s_bal_cX_failed[CR3]));
 	seq_printf(seq, "\textents_scanned: %u\n", atomic_read(&sbi->s_bal_ex_scanned));
 	seq_printf(seq, "\t\tgoal_hits: %u\n", atomic_read(&sbi->s_bal_goals));
+	seq_printf(seq, "\t\tlen_goal_hits: %u\n", atomic_read(&sbi->s_bal_len_goals));
 	seq_printf(seq, "\t\t2^n_hits: %u\n", atomic_read(&sbi->s_bal_2orders));
 	seq_printf(seq, "\t\tbreaks: %u\n", atomic_read(&sbi->s_bal_breaks));
 	seq_printf(seq, "\t\tlost: %u\n", atomic_read(&sbi->s_mb_lost_chunks));
@@ -4233,6 +4234,8 @@ static void ext4_mb_collect_stats(struct ext4_allocation_context *ac)
 		if (ac->ac_g_ex.fe_start == ac->ac_b_ex.fe_start &&
 				ac->ac_g_ex.fe_group == ac->ac_b_ex.fe_group)
 			atomic_inc(&sbi->s_bal_goals);
+		if (ac->ac_f_ex.fe_len == ac->ac_g_ex.fe_len)
+			atomic_inc(&sbi->s_bal_len_goals);
 		if (ac->ac_found > sbi->s_mb_max_to_scan)
 			atomic_inc(&sbi->s_bal_breaks);
 	}
-- 
2.31.1

