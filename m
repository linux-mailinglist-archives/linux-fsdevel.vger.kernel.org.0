Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A1F4C0333
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 21:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiBVUgg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 15:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiBVUgM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:36:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969CF13EF83;
        Tue, 22 Feb 2022 12:35:27 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MIsEEF009864;
        Tue, 22 Feb 2022 20:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=6S2/ICHcurzNb4XpSPpzhB4nMsXUVhuEApaMsiklLwg=;
 b=Ba5AfzMrENTKH199pimQpUbEQ+odhmx5ClZnxZ0Aw/k2BKUDFPH0Z5aSZFUOBboNPyn9
 L0G7h3amtDnwOgJgbLph+fokt+5xiIv41YJ2lDRHJlFEcWpbA4eSiyLL9UljG8rY/kVs
 C+dtgASwt/iQ8WFwlqweK3qoleB+0SB9zV2xIQCsXyH94xebXwzTX87LX6jxIIOoeLxn
 tLHHFcQrX3O/WOBwU7j/QVHf/7SPuqdazaw1pgDnjrlcqzyqeZGk/sYsTZPJPH/qKLSc
 JFr4h09gVhrcKeirASTqm6rK04WxUKCPAiVarzkVmSr9bCnFgdTbVhckUWaFfXcivGbh yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed34ueff0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:35:20 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21MKD8AP000954;
        Tue, 22 Feb 2022 20:35:19 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed34uefe1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:35:19 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MKJS0S020862;
        Tue, 22 Feb 2022 20:35:17 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3eaqtj5r7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:35:17 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MKZF3l18022732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 20:35:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19E8042049;
        Tue, 22 Feb 2022 20:35:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A67E42041;
        Tue, 22 Feb 2022 20:35:13 +0000 (GMT)
Received: from localhost (unknown [9.43.75.136])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Feb 2022 20:35:12 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 8/9] ext4: Convert ext4_fc_track_dentry type events to use event class
Date:   Wed, 23 Feb 2022 02:04:16 +0530
Message-Id: <bf55f9a22a67f8619ffe5f1af47bebb43f5ed372.1645558375.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1645558375.git.riteshh@linux.ibm.com>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 11eIfY_tWYhlaICOqrbcQzL4RDqSmwSI
X-Proofpoint-ORIG-GUID: POeS3dzRkHhuddIRZuHklOHLnjt_Wr_-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_07,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=954 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202220126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One should use DECLARE_EVENT_CLASS for similar event types instead of
defining TRACE_EVENT for each event type. This is helpful in reducing
the text section footprint for e.g. [1]

[1]: https://lwn.net/Articles/381064/

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 include/trace/events/ext4.h | 57 +++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 233dbffa5ceb..33a059d845d6 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2783,33 +2783,40 @@ TRACE_EVENT(ext4_fc_stats,
 		  __entry->fc_numblks)
 );
 
-#define DEFINE_TRACE_DENTRY_EVENT(__type)				\
-	TRACE_EVENT(ext4_fc_track_##__type,				\
-	    TP_PROTO(struct inode *inode, struct dentry *dentry, int ret), \
-									\
-	    TP_ARGS(inode, dentry, ret),				\
-									\
-	    TP_STRUCT__entry(						\
-		    __field(dev_t, dev)					\
-		    __field(int, ino)					\
-		    __field(int, error)					\
-		    ),							\
-									\
-	    TP_fast_assign(						\
-		    __entry->dev = inode->i_sb->s_dev;			\
-		    __entry->ino = inode->i_ino;			\
-		    __entry->error = ret;				\
-		    ),							\
-									\
-	    TP_printk("dev %d:%d, inode %d, error %d, fc_%s",		\
-		      MAJOR(__entry->dev), MINOR(__entry->dev),		\
-		      __entry->ino, __entry->error,			\
-		      #__type)						\
+DECLARE_EVENT_CLASS(ext4_fc_track_dentry,
+
+	TP_PROTO(struct inode *inode, struct dentry *dentry, int ret),
+
+	TP_ARGS(inode, dentry, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(int, ino)
+		__field(int, error)
+	),
+
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->error = ret;
+	),
+
+	TP_printk("dev %d,%d, inode %d, error %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino, __entry->error
 	)
+);
+
+#define DEFINE_EVENT_CLASS_TYPE(__type)					\
+DEFINE_EVENT(ext4_fc_track_dentry, ext4_fc_track_##__type,		\
+	TP_PROTO(struct inode *inode, struct dentry *dentry, int ret),	\
+	TP_ARGS(inode, dentry, ret)					\
+)
+
 
-DEFINE_TRACE_DENTRY_EVENT(create);
-DEFINE_TRACE_DENTRY_EVENT(link);
-DEFINE_TRACE_DENTRY_EVENT(unlink);
+DEFINE_EVENT_CLASS_TYPE(create);
+DEFINE_EVENT_CLASS_TYPE(link);
+DEFINE_EVENT_CLASS_TYPE(unlink);
 
 TRACE_EVENT(ext4_fc_track_inode,
 	    TP_PROTO(struct inode *inode, int ret),
-- 
2.31.1

