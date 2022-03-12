Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6F94D6CE1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 06:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiCLFmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 00:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiCLFlq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 00:41:46 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC6D25E5F4;
        Fri, 11 Mar 2022 21:40:31 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22C4VFok015193;
        Sat, 12 Mar 2022 05:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=72IILQkSKCsj4Fb1noVQP7GFJo+j/6G6KhZ2BtCmmBQ=;
 b=WzEuTJT0aiVL6HlXeqyJW6wWJ0faPcIw01vNxBju85y0WToUObFhh8T4pBPS3mgAZryx
 v04d6uBIvz2W2+Wss+a1amTfTXSvOl5laLzYf+FpfIFoVAqzVrXL0dn78Xs7ItwrFbk+
 g402k8PAhfoKYaqjGK8TqtvVBLg2U8Maxo2VASbPC0G/uSggAEXgFZq7JmdtGfeJZlbK
 38+03auCLUUeREjLuBEhV4Hub0iGS2hKE9sDMnKxeEtvPrydHyltEKpiCB6XJPPj9oyr
 Ru7mNTJvKKhJoJTt7XEK6cflYWH+X/PvQAuyBcFvUywgQUQPhbbV3AYda+T4wcqzgGUb /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ergx8bhgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:26 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22C5eQSq027296;
        Sat, 12 Mar 2022 05:40:26 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ergx8bhgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:26 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22C5U7Ei009552;
        Sat, 12 Mar 2022 05:40:24 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3erk58r78u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:24 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22C5eMd852167054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 05:40:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01003A4051;
        Sat, 12 Mar 2022 05:40:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86F7CA4040;
        Sat, 12 Mar 2022 05:40:21 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 12 Mar 2022 05:40:21 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 09/10] ext4: Add commit tid info in ext4_fc_commit_start/stop trace events
Date:   Sat, 12 Mar 2022 11:09:54 +0530
Message-Id: <ebcd6b9ab5b718db30f90854497886801ce38c63.1647057583.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1647057583.git.riteshh@linux.ibm.com>
References: <cover.1647057583.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7ckqcYKFHQWuNxhgPK4k2xRJGWmd_FuK
X-Proofpoint-GUID: XgoKM3erHW0NsbWNKJgTUplUvvGAD2jV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-12_02,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 mlxlogscore=938 priorityscore=1501 clxscore=1015 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203120032
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
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c       |  4 ++--
 include/trace/events/ext4.h | 21 +++++++++++++--------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 88ed99e670c5..3d72565ec6e8 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1187,7 +1187,7 @@ static void ext4_fc_update_stats(struct super_block *sb, int status,
 	} else {
 		stats->fc_skipped_commits++;
 	}
-	trace_ext4_fc_commit_stop(sb, nblks, status);
+	trace_ext4_fc_commit_stop(sb, nblks, status, commit_tid);
 }
 
 /*
@@ -1208,7 +1208,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
 		return jbd2_complete_transaction(journal, commit_tid);
 
-	trace_ext4_fc_commit_start(sb);
+	trace_ext4_fc_commit_start(sb, commit_tid);
 
 	start_time = ktime_get();
 
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 6bd90df07b5c..aad97376e032 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2686,26 +2686,29 @@ TRACE_EVENT(ext4_fc_replay,
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
@@ -2714,6 +2717,7 @@ TRACE_EVENT(ext4_fc_commit_stop,
 		__field(int, num_fc)
 		__field(int, num_fc_ineligible)
 		__field(int, nblks_agg)
+		__field(tid_t, tid)
 	),
 
 	TP_fast_assign(
@@ -2724,12 +2728,13 @@ TRACE_EVENT(ext4_fc_commit_stop,
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

