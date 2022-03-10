Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039814D4E04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 17:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbiCJQA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 11:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiCJQAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:00:47 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4918340F2;
        Thu, 10 Mar 2022 07:59:46 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22AFMJTV021597;
        Thu, 10 Mar 2022 15:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=i4e3/XamIreajFTFBX4CHVIaXfqWy6x2jBzyd/C0EkM=;
 b=gVR5dYu4m7nSRNzgI8pxytO7juILDJT5f3+L6N9KJPrI5C5RI9vH4rb57GtCn1sPsHOO
 sHWAXDkiL5X+8GqP8gMDkGUC/j7VrQRmgNylPtFaqyAxGbzzIJkBlSPfgkqbsDcIJqAd
 Q/i0Om8iLXNnvh1O//JSVBmc8R2KGBxJUNsawDLV6RLwZTTiHTdXhgnvrkeRmYIpaRSt
 DsLvmQL8Q+5xDp2yQ1FFu7d6Qvi7rSUxyOwDlsVWkq90UcvpTXNutMUtdRlwRm0klqEr
 gdXy11z0lHRbhYFijRmJ/l8xxY7Fo4lloVwaaQegd/2m8eCIuF4T25n5aWvbhmUiFhml YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqg9rxp9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:42 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22AFgvNs007868;
        Thu, 10 Mar 2022 15:59:42 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqg9rxp8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:41 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22AFv6EG028968;
        Thu, 10 Mar 2022 15:59:39 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3ekyg951d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:39 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22AFmNs734013632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 15:48:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56BB852059;
        Thu, 10 Mar 2022 15:59:37 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D97505205A;
        Thu, 10 Mar 2022 15:59:36 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 06/10] ext4: Add new trace event in ext4_fc_cleanup
Date:   Thu, 10 Mar 2022 21:29:00 +0530
Message-Id: <1a5c357e16a21bc8270419ed1678eaab4d232b8d.1646922487.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1646922487.git.riteshh@linux.ibm.com>
References: <cover.1646922487.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bt8qr6_gg2bSAjMzyeGjPjzfhFcSIgNs
X-Proofpoint-ORIG-GUID: n8Py04Ejp7UbVIl6DbmSv871ZKXEXwQ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_06,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=683 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
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

This adds a new trace event in ext4_fc_cleanup() which is helpful in debugging
some fast_commit issues.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/fast_commit.c       |  1 +
 include/trace/events/ext4.h | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 6990429daa0e..f4a56298fd88 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1280,6 +1280,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	if (full && sbi->s_fc_bh)
 		sbi->s_fc_bh = NULL;
 
+	trace_ext4_fc_cleanup(journal, full, tid);
 	jbd2_fc_release_bufs(journal);
 
 	spin_lock(&sbi->s_fc_lock);
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index c3d16dd829aa..46bc644ccd0d 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2862,6 +2862,32 @@ TRACE_EVENT(ext4_fc_track_range,
 		      __entry->end)
 	);
 
+TRACE_EVENT(ext4_fc_cleanup,
+	TP_PROTO(journal_t *journal, int full, tid_t tid),
+
+	TP_ARGS(journal, full, tid),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(int, j_fc_off)
+		__field(int, full)
+		__field(tid_t, tid)
+	),
+
+	TP_fast_assign(
+		struct super_block *sb = journal->j_private;
+
+		__entry->dev = sb->s_dev;
+		__entry->j_fc_off = journal->j_fc_off;
+		__entry->full = full;
+		__entry->tid = tid;
+	),
+
+	TP_printk("dev %d,%d, j_fc_off %d, full %d, tid %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->j_fc_off, __entry->full, __entry->tid)
+	);
+
 TRACE_EVENT(ext4_update_sb,
 	TP_PROTO(struct super_block *sb, ext4_fsblk_t fsblk,
 		 unsigned int flags),
-- 
2.31.1

