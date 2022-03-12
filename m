Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBC04D6CDA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 06:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiCLFlm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 00:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiCLFld (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 00:41:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D55025C114;
        Fri, 11 Mar 2022 21:40:27 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22C4Uq0E016440;
        Sat, 12 Mar 2022 05:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GPZPBYjhL1Z8HPS0jiuxhPJZErA/c6ZsWuVGP3Cq6eg=;
 b=rBK08zGyrcj5s1jxn9T56vwWSj94/Pnnqy8P0RyefAyFYveko7c+I1ZwExBnjENZ3Ucl
 rbyT17+jsXhxW3MizZ+Csq7xZdOvM95X5tYJNRmq7ZMzb49lkoGuGs5j3HISXl+VJQPr
 WtoaA/liQ5pw35/coNbagmFzBSBSRTBSo+prBtVss1pRd2pZNKkbmDTy6lJYR2RGH8CZ
 OpcuM71KaXV5mC0vLUvkoeYtAoLvNWeNlGEU64dcrsA/wlSopyfOewwQBayRD34boj6X
 nNi5y5JA64oprzifYTI9tYGo0hjg8WQbbwZUiFwV7BrPDxkxVvv4V5NEKoK2nRQ/o3Of 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ergvtkj6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:23 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22C5eNgE018981;
        Sat, 12 Mar 2022 05:40:23 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ergvtkj67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:23 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22C5TxKM026839;
        Sat, 12 Mar 2022 05:40:20 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3erk58g62r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:20 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22C5eINL49873368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 05:40:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F2A44C04A;
        Sat, 12 Mar 2022 05:40:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21A444C046;
        Sat, 12 Mar 2022 05:40:18 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 12 Mar 2022 05:40:17 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 07/10] ext4: Add transaction tid info in fc_track events
Date:   Sat, 12 Mar 2022 11:09:52 +0530
Message-Id: <c203c09dc11bb372803c430f621f25a4b8c2c8b4.1647057583.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1647057583.git.riteshh@linux.ibm.com>
References: <cover.1647057583.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bMoWz23G6Pw_RXWsY-aFWVz4ibLCoEWZ
X-Proofpoint-GUID: JhbHXHUlVccT2gSN77b_FzI3pWnZYnUz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-12_02,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=678 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203120030
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
index 20654aaf9495..6bd90df07b5c 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2782,32 +2782,41 @@ TRACE_EVENT(ext4_fc_stats,
 
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
@@ -2815,52 +2824,66 @@ DEFINE_EVENT_CLASS_DENTRY(link);
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

