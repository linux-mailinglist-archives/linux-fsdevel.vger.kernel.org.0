Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490984C0328
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 21:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiBVUgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 15:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbiBVUfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:35:37 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D35313F8AE;
        Tue, 22 Feb 2022 12:35:10 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MJclVH012213;
        Tue, 22 Feb 2022 20:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+J/Rf8cDqkjirscioJz526wLvNASZ132sgewxIzS3Wk=;
 b=VpOLtxEfKvTd/exalt6tllFsdRn61x17TXELsAtj2cOk2rhJ6IKYv6F4+u4qjYG2Zdgw
 bX0YOPL50dgU6H0CPtLELw1MXauHvHOroPjGcUeHuUOJJa+HvfMqdh/04CMh3rkOs3GK
 cpMqXitTpKXSGct9yDrGtf7WF+u7We0Jcbfe1qeBtpvkhFYDmpWfVUojCF0jRhJ3oq50
 tJufG/R7z6Yxgqj5m48MtKkn8r5ClyNZ7bv6RKrK4GhD4BI82lFLMxFZkWnyLmAd0KHE
 nYBZ7Glyfc5ApIFsUslXa9hgliSO7VwCb+KuR4xSO2KFU51s+7uyaWlJr6KvSClEjaOK Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed3jv5nww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:35:05 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21MKDCih027297;
        Tue, 22 Feb 2022 20:35:04 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed3jv5nwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:35:04 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MKIxe2014858;
        Tue, 22 Feb 2022 20:35:02 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3ear694ckr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:35:02 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MKYx3e50397486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 20:34:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B343C11C052;
        Tue, 22 Feb 2022 20:34:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6FDB11C04A;
        Tue, 22 Feb 2022 20:34:57 +0000 (GMT)
Received: from localhost (unknown [9.43.75.136])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Feb 2022 20:34:57 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 6/9] ext4: Add commit tid info in ext4_fc_commit_start/stop trace events
Date:   Wed, 23 Feb 2022 02:04:14 +0530
Message-Id: <dbc43257b4039b4bdba5613cd31fe65528721f3a.1645558375.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1645558375.git.riteshh@linux.ibm.com>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C6avY7l5Tak_pCVRP-BvFknAfRv1tDJj
X-Proofpoint-ORIG-GUID: dsjIyIau2k4vyj-XXw8vbyCM5Sn4jfnX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_07,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds commit_tid info in ext4_fc_commit_start/stop which is helpful
in debugging fast_commit issues.

For e.g. issues where due to jbd2 journal full commit, FC miss to commit
updates to a file.

Also improves TP_prink format string i.e. all ext4 and jbd2 trace events
starts with "dev MAjOR,MINOR". Let's follow the same convention while we
are still at it.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/fast_commit.c       |  4 ++--
 include/trace/events/ext4.h | 21 +++++++++++++--------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index ee32aac0cbbf..8803ba087b07 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1150,7 +1150,7 @@ static void ext4_fc_update_stats(struct super_block *sb, int status,
 	} else {
 		stats->fc_skipped_commits++;
 	}
-	trace_ext4_fc_commit_stop(sb, nblks, status);
+	trace_ext4_fc_commit_stop(sb, nblks, status, commit_tid);
 }
 
 /*
@@ -1171,7 +1171,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
 		return jbd2_complete_transaction(journal, commit_tid);
 
-	trace_ext4_fc_commit_start(sb);
+	trace_ext4_fc_commit_start(sb, commit_tid);
 
 	start_time = ktime_get();
 
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index cd09dccea502..6e66cb7ce624 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2685,26 +2685,29 @@ TRACE_EVENT(ext4_fc_replay,
 );
 
 TRACE_EVENT(ext4_fc_commit_start,
-	TP_PROTO(struct super_block *sb),
+	TP_PROTO(struct super_block *sb, tid_t commit_tid),
 
-	TP_ARGS(sb),
+	TP_ARGS(sb, commit_tid),
 
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
+		__field(tid_t, tid)
 	),
 
 	TP_fast_assign(
 		__entry->dev = sb->s_dev;
+		__entry->tid = commit_tid;
 	),
 
-	TP_printk("fast_commit started on dev %d,%d",
-		  MAJOR(__entry->dev), MINOR(__entry->dev))
+	TP_printk("dev %d,%d tid %u", MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->tid)
 );
 
 TRACE_EVENT(ext4_fc_commit_stop,
-	    TP_PROTO(struct super_block *sb, int nblks, int reason),
+	    TP_PROTO(struct super_block *sb, int nblks, int reason,
+		     tid_t commit_tid),
 
-	TP_ARGS(sb, nblks, reason),
+	TP_ARGS(sb, nblks, reason, commit_tid),
 
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
@@ -2713,6 +2716,7 @@ TRACE_EVENT(ext4_fc_commit_stop,
 		__field(int, num_fc)
 		__field(int, num_fc_ineligible)
 		__field(int, nblks_agg)
+		__field(tid_t, tid)
 	),
 
 	TP_fast_assign(
@@ -2723,12 +2727,13 @@ TRACE_EVENT(ext4_fc_commit_stop,
 		__entry->num_fc_ineligible =
 			EXT4_SB(sb)->s_fc_stats.fc_ineligible_commits;
 		__entry->nblks_agg = EXT4_SB(sb)->s_fc_stats.fc_numblks;
+		__entry->tid = commit_tid;
 	),
 
-	TP_printk("fc on [%d,%d] nblks %d, reason %d, fc = %d, ineligible = %d, agg_nblks %d",
+	TP_printk("dev %d,%d nblks %d, reason %d, fc = %d, ineligible = %d, agg_nblks %d, tid %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->nblks, __entry->reason, __entry->num_fc,
-		  __entry->num_fc_ineligible, __entry->nblks_agg)
+		  __entry->num_fc_ineligible, __entry->nblks_agg, __entry->tid)
 );
 
 #define FC_REASON_NAME_STAT(reason)					\
-- 
2.31.1

