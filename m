Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C964D6CEA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 06:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiCLFmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 00:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiCLFmB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 00:42:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBFC2634CF;
        Fri, 11 Mar 2022 21:40:40 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22C4V03b015317;
        Sat, 12 Mar 2022 05:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vM9XEBwKtRYyBewaKrwr6E68qDySLSzvHD0+KoHlCwA=;
 b=ADhSagWGvYHv5v2wk8d1Rf7Ttv8A1qRgynVJ4KY5JRNFegYLK4XX1uZONdSYZprVXBC3
 6G92QJg+oR/QxlgkiBDENYo5oUKYhiB3hsX00p0zpP68A3wxdveCQ5VHMVhsp92sI6/B
 acZS4P2M2C8BdTKkPopRgm788sty7JfFHUyFJt2NRIClmZ3flWz1uT/Vo4X517eoI4I0
 4o93v4bt3PzjopwzxUv4gyyGsUI97KSdtMqyCW/bCi4dL+nC0RgYedGMczKUFROBL+tn
 0Dq1UHqlh7ULmaHTzXytsXumI5sMG30YJGYB7xrnxEdkLddpXSUI8sH2KzqtCbXxV8yu zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3erjas2h6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:15 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22C5a3i0005802;
        Sat, 12 Mar 2022 05:40:14 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3erjas2h64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:14 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22C5U6V4018338;
        Sat, 12 Mar 2022 05:40:12 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3erk58g65m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:12 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22C5SqHx28311892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 05:28:52 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE58BAE04D;
        Sat, 12 Mar 2022 05:40:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C541AE059;
        Sat, 12 Mar 2022 05:40:09 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 12 Mar 2022 05:40:09 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>, stable@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCHv3 02/10] ext4: Fix ext4_fc_stats trace point
Date:   Sat, 12 Mar 2022 11:09:47 +0530
Message-Id: <b4b9691414c35c62e570b723e661c80674169f9a.1647057583.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1647057583.git.riteshh@linux.ibm.com>
References: <cover.1647057583.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Jv41_Q0x54_Fp6wtHM3hb_Ecjt8nV1qX
X-Proofpoint-GUID: 93W825egS0ao6TGPLCt33rW48NRr2kuP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-12_02,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 mlxlogscore=927 clxscore=1015 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

ftrace's __print_symbolic() requires that any enum values used in the
symbol to string translation table be wrapped in a TRACE_DEFINE_ENUM
so that the enum value can be decoded from the ftrace ring buffer by
user space tooling.

This patch also fixes few other problems found in this trace point.
e.g. dereferencing structures in TP_printk which should not be done
at any cost.

Also to avoid checkpatch warnings, this patch removes those
whitespaces/tab stops issues.

Cc: stable@kernel.org
Fixes: commit aa75f4d3daae ("ext4: main fast-commit commit path")
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 include/trace/events/ext4.h | 78 +++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 29 deletions(-)

diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 19e957b7f941..1a0b7030f72a 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -95,6 +95,17 @@ TRACE_DEFINE_ENUM(ES_REFERENCED_B);
 	{ FALLOC_FL_COLLAPSE_RANGE,	"COLLAPSE_RANGE"},	\
 	{ FALLOC_FL_ZERO_RANGE,		"ZERO_RANGE"})
 
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_XATTR);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_CROSS_RENAME);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_NOMEM);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_SWAP_BOOT);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_RESIZE);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_RENAME_DIR);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_FALLOC_RANGE);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_INODE_JOURNAL_DATA);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);
+
 #define show_fc_reason(reason)						\
 	__print_symbolic(reason,					\
 		{ EXT4_FC_REASON_XATTR,		"XATTR"},		\
@@ -2723,41 +2734,50 @@ TRACE_EVENT(ext4_fc_commit_stop,
 
 #define FC_REASON_NAME_STAT(reason)					\
 	show_fc_reason(reason),						\
-	__entry->sbi->s_fc_stats.fc_ineligible_reason_count[reason]
+	__entry->fc_ineligible_rc[reason]
 
 TRACE_EVENT(ext4_fc_stats,
-	    TP_PROTO(struct super_block *sb),
-
-	    TP_ARGS(sb),
+	TP_PROTO(struct super_block *sb),
 
-	    TP_STRUCT__entry(
-		    __field(dev_t, dev)
-		    __field(struct ext4_sb_info *, sbi)
-		    __field(int, count)
-		    ),
+	TP_ARGS(sb),
 
-	    TP_fast_assign(
-		    __entry->dev = sb->s_dev;
-		    __entry->sbi = EXT4_SB(sb);
-		    ),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__array(unsigned int, fc_ineligible_rc, EXT4_FC_REASON_MAX)
+		__field(unsigned long, fc_commits)
+		__field(unsigned long, fc_ineligible_commits)
+		__field(unsigned long, fc_numblks)
+	),
 
-	    TP_printk("dev %d:%d fc ineligible reasons:\n"
-		      "%s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d; "
-		      "num_commits:%ld, ineligible: %ld, numblks: %ld",
-		      MAJOR(__entry->dev), MINOR(__entry->dev),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_CROSS_RENAME),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_NOMEM),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_SWAP_BOOT),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
-		      __entry->sbi->s_fc_stats.fc_num_commits,
-		      __entry->sbi->s_fc_stats.fc_ineligible_commits,
-		      __entry->sbi->s_fc_stats.fc_numblks)
+	TP_fast_assign(
+		int i;
 
+		__entry->dev = sb->s_dev;
+		for (i = 0; i < EXT4_FC_REASON_MAX; i++) {
+			__entry->fc_ineligible_rc[i] =
+				EXT4_SB(sb)->s_fc_stats.fc_ineligible_reason_count[i];
+		}
+		__entry->fc_commits = EXT4_SB(sb)->s_fc_stats.fc_num_commits;
+		__entry->fc_ineligible_commits =
+			EXT4_SB(sb)->s_fc_stats.fc_ineligible_commits;
+		__entry->fc_numblks = EXT4_SB(sb)->s_fc_stats.fc_numblks;
+	),
+
+	TP_printk("dev %d,%d fc ineligible reasons:\n"
+		  "%s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u "
+		  "num_commits:%lu, ineligible: %lu, numblks: %lu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_CROSS_RENAME),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_NOMEM),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_SWAP_BOOT),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
+		  __entry->fc_commits, __entry->fc_ineligible_commits,
+		  __entry->fc_numblks)
 );
 
 #define DEFINE_TRACE_DENTRY_EVENT(__type)				\
-- 
2.31.1

