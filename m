Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701F54C031F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 21:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiBVUfj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 15:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbiBVUf3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:35:29 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3BF13D90B;
        Tue, 22 Feb 2022 12:35:00 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MHfdgA001571;
        Tue, 22 Feb 2022 20:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6NP+SqwknYxeB+r5zaqqZN0Yt1ExjQsEZddzFENEXd8=;
 b=EAJL3ZYi48GoV82fHKXMiDXmg72yIcvlLvRVV9fQhNZsF4P9/qDJJZ0PHdzB9CBfkHdp
 IYJjOjg9KG/ItgqIbzm3gnO/+FS8E5XR0Ophtnw7qsXFcxuXOUCdEcRxp8mEDacsgcw1
 Z5RDoKykofbxyjL/Jko8gBcBEeioLkVGoM4ZdUMjY9zelKQTIqhwDmOg4lf1WuMnmY6+
 m3a/K8WxFqQ7a1LM3W8dDfSpIUhroHsBEcvYSWg6Y50kb4IJ49oKBMzQPFrlyY+RR/wS
 AOFZE8jpSKl/yI1VTHqu5XS2IwNwi9NH0AtPDvqTv241F66bzaxdK5KTd9GRDQ4XFbS6 Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed4exv11k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:34:57 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21MKLMw7030938;
        Tue, 22 Feb 2022 20:34:56 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed4exv114-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:34:56 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MKJbmQ027516;
        Tue, 22 Feb 2022 20:34:54 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3ear695q0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:34:54 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MKOE2Q48955890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 20:24:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A9D3AE056;
        Tue, 22 Feb 2022 20:34:52 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87C2EAE051;
        Tue, 22 Feb 2022 20:34:49 +0000 (GMT)
Received: from localhost (unknown [9.43.75.136])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Feb 2022 20:34:48 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 5/9] ext4: Add commit_tid info in jbd debug log
Date:   Wed, 23 Feb 2022 02:04:13 +0530
Message-Id: <60daf324eec64f2be0b9ce0e240294d36411037c.1645558375.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1645558375.git.riteshh@linux.ibm.com>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tOKLBdk7diP1LGUC4Pv9mwynpvVUHuiv
X-Proofpoint-GUID: W2K3CMZeSe6fpoIufOc1WwqVDGNXOkQE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_07,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=881 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds commit_tid argument in ext4_fc_update_stats()
so that we can add this information too in jbd_debug logs.
This is also required in a later patch to pass the commit_tid info in
ext4_fc_commit_start/stop() trace events.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/fast_commit.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 7fb1eceef30c..ee32aac0cbbf 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1127,11 +1127,12 @@ static int ext4_fc_perform_commit(journal_t *journal)
 }
 
 static void ext4_fc_update_stats(struct super_block *sb, int status,
-				 u64 commit_time, int nblks)
+				 u64 commit_time, int nblks, tid_t commit_tid)
 {
 	struct ext4_fc_stats *stats = &EXT4_SB(sb)->s_fc_stats;
 
-	jbd_debug(1, "Fast commit ended with status = %d", status);
+	jbd_debug(1, "Fast commit ended with status = %d for tid %u",
+			status, commit_tid);
 	if (status == EXT4_FC_STATUS_OK) {
 		stats->fc_num_commits++;
 		stats->fc_numblks += nblks;
@@ -1181,14 +1182,16 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 		if (atomic_read(&sbi->s_fc_subtid) <= subtid &&
 			commit_tid > journal->j_commit_sequence)
 			goto restart_fc;
-		ext4_fc_update_stats(sb, EXT4_FC_STATUS_SKIPPED, 0, 0);
+		ext4_fc_update_stats(sb, EXT4_FC_STATUS_SKIPPED, 0, 0,
+				commit_tid);
 		return 0;
 	} else if (ret) {
 		/*
 		 * Commit couldn't start. Just update stats and perform a
 		 * full commit.
 		 */
-		ext4_fc_update_stats(sb, EXT4_FC_STATUS_FAILED, 0, 0);
+		ext4_fc_update_stats(sb, EXT4_FC_STATUS_FAILED, 0, 0,
+				commit_tid);
 		return jbd2_complete_transaction(journal, commit_tid);
 	}
 
@@ -1220,12 +1223,12 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	 * don't react too strongly to vast changes in the commit time
 	 */
 	commit_time = ktime_to_ns(ktime_sub(ktime_get(), start_time));
-	ext4_fc_update_stats(sb, status, commit_time, nblks);
+	ext4_fc_update_stats(sb, status, commit_time, nblks, commit_tid);
 	return ret;
 
 fallback:
 	ret = jbd2_fc_end_commit_fallback(journal);
-	ext4_fc_update_stats(sb, status, 0, 0);
+	ext4_fc_update_stats(sb, status, 0, 0, commit_tid);
 	return ret;
 }
 
-- 
2.31.1

