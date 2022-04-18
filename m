Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08EA504DF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 10:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiDRIig (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 04:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiDRIif (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:38:35 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D601903C;
        Mon, 18 Apr 2022 01:35:56 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23I6mDgm005538;
        Mon, 18 Apr 2022 08:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=lZyXQJUt4CpWUIk9cUTgllpiE9+zbRc1xss0Qv8j8bU=;
 b=YfCTFGWYqg1CUJ7or2S4z4B7Jvx+l7qYciZNJcgD08g/D6+Nau94XJ62R0mhhRxFj/xK
 bEUcHcuCw8ObgkZKgoTMizEm5gJKA1FPE1RHG14KnAM35oNu+h/YPdllOjZn/neqlzhQ
 Q4OhAuEB7uA2EA29VQXSpvBd63hkTLnGfHnAbmOKEcUcMyF8rSiadDEJkPaG7ZwpF8dg
 sam4EqTDe781eTUPjDCDW3CXtFLMUgrkUXOBWcngoo1qI6JvqkAiztHEWuR+knm6k3NE
 Jgk+9NTSo9U+h9htcGQaGkdrNsSK0JxoRVeYbZnEpwSfDG+4DKHtDFigldD8MeZXc6Q9 fQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7re7j66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 08:35:54 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23I8TitQ013823;
        Mon, 18 Apr 2022 08:35:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3ffne8syfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 08:35:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23I8Zo0C34865604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Apr 2022 08:35:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 481235205F;
        Mon, 18 Apr 2022 08:35:50 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.96.67])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 641B252054;
        Mon, 18 Apr 2022 08:35:48 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Fix journal_ioprio mount option handling
Date:   Mon, 18 Apr 2022 14:05:45 +0530
Message-Id: <20220418083545.45778-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rLvH2COIKIlxQHYtJ2OII1y8njttQDg8
X-Proofpoint-ORIG-GUID: rLvH2COIKIlxQHYtJ2OII1y8njttQDg8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-18_02,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204180051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In __ext4_super() we always overwrote the user specified journal_ioprio
value with a default value, expecting  parse_apply_sb_mount_options() to
later correctly set ctx->journal_ioprio to the user specified value.
However, if parse_apply_sb_mount_options() returned early because of
empty sbi->es_s->s_mount_opts, the correct journal_ioprio value was
never set.

This patch fixes __ext4_super() to only use the default value if the
user has not specified any value for journal_ioprio.

Similarly, the remount behavior was to either use journal_ioprio
value specified during initial mount, or use the default value
irrespective of the journal_ioprio value specified during remount.
This patch modifies this to first check if a new value for ioprio
has been passed during remount and apply it. Incase, no new value is
passed, use the value specified during initial mount.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/super.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5a9ffbf7f4f..bfd767c51203 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4427,7 +4427,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	int silent = fc->sb_flags & SB_SILENT;
 
 	/* Set defaults for the variables that will be set during parsing */
-	ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
+	if (!(ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO))
+		ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
 
 	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
 	sbi->s_sectors_written_start =
@@ -6289,7 +6290,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	char *to_free[EXT4_MAXQUOTAS];
 #endif
 
-	ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
 
 	/* Store the original options */
 	old_sb_flags = sb->s_flags;
@@ -6315,9 +6315,14 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 		} else
 			old_opts.s_qf_names[i] = NULL;
 #endif
-	if (sbi->s_journal && sbi->s_journal->j_task->io_context)
-		ctx->journal_ioprio =
-			sbi->s_journal->j_task->io_context->ioprio;
+	if (!(ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO)) {
+		if (sbi->s_journal && sbi->s_journal->j_task->io_context)
+			ctx->journal_ioprio =
+				sbi->s_journal->j_task->io_context->ioprio;
+		else
+			ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
+
+	}
 
 	ext4_apply_options(fc, sb);
 
-- 
2.27.0

