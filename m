Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5925D4D6CDB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 06:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiCLFll (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 00:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiCLFld (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 00:41:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A92B25B151;
        Fri, 11 Mar 2022 21:40:26 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22C4Uxe2004509;
        Sat, 12 Mar 2022 05:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2KCsS3W1WVdY76zNFIcqLqLY2zcDuWWLvPjfeVG2mYM=;
 b=Mb+9gsrjRYzMn4isHsg0BMZpNKw58Cj8PtaGtubVgOyae1wVw9JuuYMLCHbmGjQE1ovH
 VuYLS3uoKqCLMqC2vLe8bc49AYA5L8YMREFUbfe3Ra1EbOt6fUueAegYupYfh/a/lEIP
 T4crHd1ien8XodYOndPzPFFYIQ2Y/Sda6YEyZHNekwCqvGuEMIkVuMB3t6h7AeSc+0PD
 n4wMMa2pKpq6+zSTUCCuPGtDCFBR8U8choIpr1qPy7U4fNZDJvD+k+DQmPxSLCxltTTr
 /W0B0jQgyqchOiDxMkR9vL4RbmK/SOY0oRAktyyKb6Yglh9HrsxDm+FYYx6Pu0fpHMB/ +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3erka5sjy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:22 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22C5SlVm008192;
        Sat, 12 Mar 2022 05:40:21 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3erka5sjxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:21 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22C5U4au009209;
        Sat, 12 Mar 2022 05:40:19 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3erk58r78k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22C5eH9N55050632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 05:40:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3D5CA405B;
        Sat, 12 Mar 2022 05:40:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75940A4054;
        Sat, 12 Mar 2022 05:40:16 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 12 Mar 2022 05:40:16 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 06/10] ext4: Add new trace event in ext4_fc_cleanup
Date:   Sat, 12 Mar 2022 11:09:51 +0530
Message-Id: <794cdb1d5d3622f3f80d30c222ff6652ea68c375.1647057583.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1647057583.git.riteshh@linux.ibm.com>
References: <cover.1647057583.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g1gxnmYgOq8uij5Dy4OQ4TMykCjIX2Jb
X-Proofpoint-GUID: 4N0Sigm0ZqA3K4nmPGISv4FyFmI-kjU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-12_02,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=683
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
index 3d48fcb62987..20654aaf9495 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2863,6 +2863,32 @@ TRACE_EVENT(ext4_fc_track_range,
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

