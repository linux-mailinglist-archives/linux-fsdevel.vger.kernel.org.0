Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1F74D6CD2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 06:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiCLFlg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 00:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiCLFlZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 00:41:25 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E35D52E6D;
        Fri, 11 Mar 2022 21:40:21 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22C4Ur1p011170;
        Sat, 12 Mar 2022 05:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=GOmkNyrNSRiiOCRdhOgsgTnvVQo+HP41BRnOmijuI/o=;
 b=A3IpLaqIAGLsdIMDLtm93K66Xzrxer9ae1jlkK9061CBhvTrGY7CudCEsaHjsIXAecui
 llOUWAbXld100UPXi3pOOn3ZzqXah8A+RlLBc90z0MfOlVsr+8gjiX4uoY+xPDbhYb6m
 Wb0YvzvfveYj1vU3I5qg3HB1v+1VAXlySG4lOp5O/7xYbL9LO9fW0muHRpPbEHD9ti9r
 jNCNn/uhq+VEwxcoeqXpL7EHqFCxWsM5fgZ55fkWRpQHPYqCfoJ6vaBHdmw6EWPvq2QR
 +DBZxJ8ED09a5Akmj9FE1DrDXLdAJoqcFqizgRey+ovTz/jWDuDiWuITedQaha/tpKOp Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3erm5bs010-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:17 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22C5dTSu012709;
        Sat, 12 Mar 2022 05:40:16 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3erm5bs00f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:16 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22C5TuGe013535;
        Sat, 12 Mar 2022 05:40:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3erk58g5vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22C5eB8L19399140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 05:40:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB795AE04D;
        Sat, 12 Mar 2022 05:40:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39F7CAE055;
        Sat, 12 Mar 2022 05:40:11 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 12 Mar 2022 05:40:10 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 03/10] ext4: Convert ext4_fc_track_dentry type events to use event class
Date:   Sat, 12 Mar 2022 11:09:48 +0530
Message-Id: <a019cb46219ef4b30e4d98d7ced7d8819a2fc61d.1647057583.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1647057583.git.riteshh@linux.ibm.com>
References: <cover.1647057583.git.riteshh@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lEd-Nf5HIQaAR0OohBjfiV2GkJYVkc-S
X-Proofpoint-ORIG-GUID: y0HlHYpwX6rWGYnVdjYWEFyoikAHuYvL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-12_02,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=882 classifier=spam adjust=0 reason=mlx scancount=1
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

One should use DECLARE_EVENT_CLASS for similar event types instead of
defining TRACE_EVENT for each event type. This is helpful in reducing
the text section footprint for e.g. [1]

[1]: https://lwn.net/Articles/381064/

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 include/trace/events/ext4.h | 56 ++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 1a0b7030f72a..3d48fcb62987 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2780,33 +2780,39 @@ TRACE_EVENT(ext4_fc_stats,
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
+		__field(ino_t, i_ino)
+		__field(int, error)
+	),
+
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->i_ino = inode->i_ino;
+		__entry->error = ret;
+	),
+
+	TP_printk("dev %d,%d, ino %lu, error %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->i_ino, __entry->error
 	)
+);
+
+#define DEFINE_EVENT_CLASS_DENTRY(__type)				\
+DEFINE_EVENT(ext4_fc_track_dentry, ext4_fc_track_##__type,		\
+	TP_PROTO(struct inode *inode, struct dentry *dentry, int ret),	\
+	TP_ARGS(inode, dentry, ret)					\
+)
 
-DEFINE_TRACE_DENTRY_EVENT(create);
-DEFINE_TRACE_DENTRY_EVENT(link);
-DEFINE_TRACE_DENTRY_EVENT(unlink);
+DEFINE_EVENT_CLASS_DENTRY(create);
+DEFINE_EVENT_CLASS_DENTRY(link);
+DEFINE_EVENT_CLASS_DENTRY(unlink);
 
 TRACE_EVENT(ext4_fc_track_inode,
 	    TP_PROTO(struct inode *inode, int ret),
-- 
2.31.1

