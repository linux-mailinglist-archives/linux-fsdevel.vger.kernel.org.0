Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E734D4DEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 17:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbiCJQAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 11:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbiCJQAm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:00:42 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AEB340F2;
        Thu, 10 Mar 2022 07:59:41 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22AFMJTQ021597;
        Thu, 10 Mar 2022 15:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=Ism+czsQCbxi32DkeYnFtpYuyRJudmqJlgwaD3Wz6a8=;
 b=ME5RJAkjJ6AUn9FzFmoPgOsj3qXNsPZI85HnxfNb/g5M0B8OZvymVFT70MXfZgH3GZHu
 vbnhGz1zWiYYQFJQExO6o9FEoFAQ/cFaiN+VRZ5cgGXHuesaIciNFm3Td+VjLzVKffR/
 OMvSGyidhPiXlB2iJiIdyZKJ6jvvjI7syzUA2J4dHQ2Q2qC4dytmYba9PfTJqmcsmUaq
 mLSptVgsnDpRvQANagPwTUQnLfNk+6IPjQjohcOdaMiLWnRPAZdTU4FrROZZdUQGI39q
 s5Qmcu2MNq5M1+33gEzVawQkiAuBvVE4FJd3WrQcG/LNxP1eBPYW+7JP5KmFU3GU3SD/ uA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqg9rxp6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:36 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22ADJkDN012437;
        Thu, 10 Mar 2022 15:59:36 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqg9rxp69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:36 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22AFvThx022431;
        Thu, 10 Mar 2022 15:59:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3eky4j55m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22AFxWa536045292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 15:59:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3180452054;
        Thu, 10 Mar 2022 15:59:32 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B9CA652052;
        Thu, 10 Mar 2022 15:59:31 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 03/10] ext4: Convert ext4_fc_track_dentry type events to use event class
Date:   Thu, 10 Mar 2022 21:28:57 +0530
Message-Id: <05af3ccc77e411dcb494dbe413be33baa87a3c53.1646922487.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1646922487.git.riteshh@linux.ibm.com>
References: <cover.1646922487.git.riteshh@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: paF6x0XYOR0Vy1c4PqYNG8kT4k_yMKA3
X-Proofpoint-ORIG-GUID: eBkoI87tnSDjqkRIv9p0T9TKUUn_xLW1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_06,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=883 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
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
index db404eb9b666..c3d16dd829aa 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2779,33 +2779,39 @@ TRACE_EVENT(ext4_fc_stats,
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

