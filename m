Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D214D4E07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 17:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbiCJQBG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 11:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbiCJQAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:00:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D26184631;
        Thu, 10 Mar 2022 07:59:51 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22AFFVmW008891;
        Thu, 10 Mar 2022 15:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VWawkc4J3H3kN15Gt+E1mREz+1IpGdx7oFmUL9ULj80=;
 b=ksvCxoRhv4vBWtFmeBhFKYs3ZUMxLzozp2rYw//epQNqLWjlEm42c/UkLJxWQMwIHNnD
 rbNYBn3fHk5ENY+B+12QjCPBVMRtHp6PtG9oc4NgYYcJYtV58mEFjOzWwYN7vjVFLYyP
 ZGTO51mRRwh5TjDkFwYBMQgIG5YTpByXKq9HCydEuLecRDHIpp0CM1N/EVRowBO9Y2Ok
 hGrwHEkqANm7gRPLtfHmllaSTz08+itqffdDGma7+V9dikmeaG4ufUnaqBFf8l6/mpC8
 IQPRyPfT6rSd60Saah3FEFJbaeAGlLadN64urdfoxts45tUKUrDfyqD1WRXabxNys4Ta Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqktj9171-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:44 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22AFFl8b009759;
        Thu, 10 Mar 2022 15:59:44 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqktj915t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:43 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22AFvLBJ022395;
        Thu, 10 Mar 2022 15:59:41 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3eky4j55mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22AFxdWU52953572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 15:59:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17A3852065;
        Thu, 10 Mar 2022 15:59:39 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9A5FA52050;
        Thu, 10 Mar 2022 15:59:38 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 07/10] ext4: Add transaction tid info in fc_track events
Date:   Thu, 10 Mar 2022 21:29:01 +0530
Message-Id: <b1718e50b90e9ce50e83d13902a57be66a25e471.1646922487.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1646922487.git.riteshh@linux.ibm.com>
References: <cover.1646922487.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qtWPgjI0SVS2qf3W-_CIMvwm6gRDXN8j
X-Proofpoint-ORIG-GUID: o6l5kQoGPzlWwGFdpeHiHB_MZ5kbVP1R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_06,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxlogscore=683 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds the transaction & inode tid info in trace events for
callers of ext4_fc_track_template(). This is helpful in debugging race
conditions where an inode could belong to two different transaction tids.
It also fixes the checkpatch warnings which says use tabs instead of
spaces.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/fast_commit.c       |  10 ++--
 include/trace/events/ext4.h | 113 ++++++++++++++++++++++--------------
 2 files changed, 73 insertions(+), 50 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index f4a56298fd88..849fd4dcb825 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -487,7 +487,7 @@ void __ext4_fc_track_unlink(handle_t *handle,
 
 	ret = ext4_fc_track_template(handle, inode, __track_dentry_update,
 					(void *)&args, 0);
-	trace_ext4_fc_track_unlink(inode, dentry, ret);
+	trace_ext4_fc_track_unlink(handle, inode, dentry, ret);
 }
 
 void ext4_fc_track_unlink(handle_t *handle, struct dentry *dentry)
@@ -516,7 +516,7 @@ void __ext4_fc_track_link(handle_t *handle,
 
 	ret = ext4_fc_track_template(handle, inode, __track_dentry_update,
 					(void *)&args, 0);
-	trace_ext4_fc_track_link(inode, dentry, ret);
+	trace_ext4_fc_track_link(handle, inode, dentry, ret);
 }
 
 void ext4_fc_track_link(handle_t *handle, struct dentry *dentry)
@@ -545,7 +545,7 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
 
 	ret = ext4_fc_track_template(handle, inode, __track_dentry_update,
 					(void *)&args, 0);
-	trace_ext4_fc_track_create(inode, dentry, ret);
+	trace_ext4_fc_track_create(handle, inode, dentry, ret);
 }
 
 void ext4_fc_track_create(handle_t *handle, struct dentry *dentry)
@@ -596,7 +596,7 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 		return;
 
 	ret = ext4_fc_track_template(handle, inode, __track_inode, NULL, 1);
-	trace_ext4_fc_track_inode(inode, ret);
+	trace_ext4_fc_track_inode(handle, inode, ret);
 }
 
 struct __track_range_args {
@@ -653,7 +653,7 @@ void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t star
 
 	ret = ext4_fc_track_template(handle, inode,  __track_range, &args, 1);
 
-	trace_ext4_fc_track_range(inode, start, end, ret);
+	trace_ext4_fc_track_range(handle, inode, start, end, ret);
 }
 
 static void ext4_fc_submit_bh(struct super_block *sb, bool is_tail)
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 46bc644ccd0d..cff9b67763c4 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2781,32 +2781,41 @@ TRACE_EVENT(ext4_fc_stats,
 
 DECLARE_EVENT_CLASS(ext4_fc_track_dentry,
 
-	TP_PROTO(struct inode *inode, struct dentry *dentry, int ret),
+	TP_PROTO(handle_t *handle, struct inode *inode,
+		 struct dentry *dentry, int ret),
 
-	TP_ARGS(inode, dentry, ret),
+	TP_ARGS(handle, inode, dentry, ret),
 
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
+		__field(tid_t, t_tid)
 		__field(ino_t, i_ino)
+		__field(tid_t, i_sync_tid)
 		__field(int, error)
 	),
 
 	TP_fast_assign(
+		struct ext4_inode_info *ei = EXT4_I(inode);
+
 		__entry->dev = inode->i_sb->s_dev;
+		__entry->t_tid = handle->h_transaction->t_tid;
 		__entry->i_ino = inode->i_ino;
+		__entry->i_sync_tid = ei->i_sync_tid;
 		__entry->error = ret;
 	),
 
-	TP_printk("dev %d,%d, ino %lu, error %d",
+	TP_printk("dev %d,%d, t_tid %u, ino %lu, i_sync_tid %u, error %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  __entry->i_ino, __entry->error
+		  __entry->t_tid, __entry->i_ino, __entry->i_sync_tid,
+		  __entry->error
 	)
 );
 
 #define DEFINE_EVENT_CLASS_DENTRY(__type)				\
 DEFINE_EVENT(ext4_fc_track_dentry, ext4_fc_track_##__type,		\
-	TP_PROTO(struct inode *inode, struct dentry *dentry, int ret),	\
-	TP_ARGS(inode, dentry, ret)					\
+	TP_PROTO(handle_t *handle, struct inode *inode,			\
+		 struct dentry *dentry, int ret),			\
+	TP_ARGS(handle, inode, dentry, ret)				\
 )
 
 DEFINE_EVENT_CLASS_DENTRY(create);
@@ -2814,52 +2823,66 @@ DEFINE_EVENT_CLASS_DENTRY(link);
 DEFINE_EVENT_CLASS_DENTRY(unlink);
 
 TRACE_EVENT(ext4_fc_track_inode,
-	    TP_PROTO(struct inode *inode, int ret),
+	TP_PROTO(handle_t *handle, struct inode *inode, int ret),
 
-	    TP_ARGS(inode, ret),
+	TP_ARGS(handle, inode, ret),
 
-	    TP_STRUCT__entry(
-		    __field(dev_t, dev)
-		    __field(int, ino)
-		    __field(int, error)
-		    ),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(tid_t, t_tid)
+		__field(ino_t, i_ino)
+		__field(tid_t, i_sync_tid)
+		__field(int, error)
+	),
 
-	    TP_fast_assign(
-		    __entry->dev = inode->i_sb->s_dev;
-		    __entry->ino = inode->i_ino;
-		    __entry->error = ret;
-		    ),
+	TP_fast_assign(
+		struct ext4_inode_info *ei = EXT4_I(inode);
 
-	    TP_printk("dev %d:%d, inode %d, error %d",
-		      MAJOR(__entry->dev), MINOR(__entry->dev),
-		      __entry->ino, __entry->error)
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->t_tid = handle->h_transaction->t_tid;
+		__entry->i_ino = inode->i_ino;
+		__entry->i_sync_tid = ei->i_sync_tid;
+		__entry->error = ret;
+	),
+
+	TP_printk("dev %d:%d, t_tid %u, inode %lu, i_sync_tid %u, error %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->t_tid, __entry->i_ino, __entry->i_sync_tid,
+		  __entry->error)
 	);
 
 TRACE_EVENT(ext4_fc_track_range,
-	    TP_PROTO(struct inode *inode, long start, long end, int ret),
-
-	    TP_ARGS(inode, start, end, ret),
-
-	    TP_STRUCT__entry(
-		    __field(dev_t, dev)
-		    __field(int, ino)
-		    __field(long, start)
-		    __field(long, end)
-		    __field(int, error)
-		    ),
-
-	    TP_fast_assign(
-		    __entry->dev = inode->i_sb->s_dev;
-		    __entry->ino = inode->i_ino;
-		    __entry->start = start;
-		    __entry->end = end;
-		    __entry->error = ret;
-		    ),
-
-	    TP_printk("dev %d:%d, inode %d, error %d, start %ld, end %ld",
-		      MAJOR(__entry->dev), MINOR(__entry->dev),
-		      __entry->ino, __entry->error, __entry->start,
-		      __entry->end)
+	TP_PROTO(handle_t *handle, struct inode *inode,
+		 long start, long end, int ret),
+
+	TP_ARGS(handle, inode, start, end, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(tid_t, t_tid)
+		__field(ino_t, i_ino)
+		__field(tid_t, i_sync_tid)
+		__field(long, start)
+		__field(long, end)
+		__field(int, error)
+	),
+
+	TP_fast_assign(
+		struct ext4_inode_info *ei = EXT4_I(inode);
+
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->t_tid = handle->h_transaction->t_tid;
+		__entry->i_ino = inode->i_ino;
+		__entry->i_sync_tid = ei->i_sync_tid;
+		__entry->start = start;
+		__entry->end = end;
+		__entry->error = ret;
+	),
+
+	TP_printk("dev %d:%d, t_tid %u, inode %lu, i_sync_tid %u, error %d, start %ld, end %ld",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->t_tid, __entry->i_ino, __entry->i_sync_tid,
+		  __entry->error, __entry->start, __entry->end)
 	);
 
 TRACE_EVENT(ext4_fc_cleanup,
-- 
2.31.1

