Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E114D6CD6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 06:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiCLFlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 00:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiCLFld (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 00:41:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064BD25D224;
        Fri, 11 Mar 2022 21:40:29 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22C4UqZt016127;
        Sat, 12 Mar 2022 05:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+1eh5cJUcucfhcJxDJpi2q49l/euNQ3nDrSALIB4zHM=;
 b=hgl+F+fnAy2RvBqXXaJXl1ixAuwRlPnRbFfqhGKolXbfCvfrZMJWK5UR4Q8ocNaXqrbI
 Bc41eAp43usUpI4vuAXn9au0RPYiZIu0J1msBRyODf9vIjOh6P7GzAveQ7/KmJY/Har0
 j5BoQhS+TFl/sZ187/gNyqhzDqDBJwcxdPbT+uO6SwJX/1hZjEpyxNZESHA/9ihh82oH
 NaD9hxAGReDn72jQMevoJ4Ng6SXBfWspwQfg2FHRLztqwZHAXofwYIF0jaaEFcD2wS/5
 PwF6jqEugdbQnVYucsGjuU1QCipynh4S633svjyVYMJVAFDX92XFL7iMfkeI5cn2WFgX HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ermgn0s8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:25 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22C5bTMK020359;
        Sat, 12 Mar 2022 05:40:25 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ermgn0s8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:24 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22C5U4Cw002665;
        Sat, 12 Mar 2022 05:40:22 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3erjshg8br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:40:22 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22C5eKaZ58851738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 05:40:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45AB6AE045;
        Sat, 12 Mar 2022 05:40:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C80C5AE04D;
        Sat, 12 Mar 2022 05:40:19 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 12 Mar 2022 05:40:19 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 08/10] ext4: Add commit_tid info in jbd debug log
Date:   Sat, 12 Mar 2022 11:09:53 +0530
Message-Id: <dabda3f2919a60e01887e798bf5915216b451733.1647057583.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1647057583.git.riteshh@linux.ibm.com>
References: <cover.1647057583.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wnRYNV4dhsbaVlly9dlepGC3eU-Uk21u
X-Proofpoint-ORIG-GUID: vJa0KmUVdMGqgpna_7-btkWu18qftL5N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-12_02,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=808 bulkscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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

This adds commit_tid argument in ext4_fc_update_stats()
so that we can add this information too in jbd_debug logs.
This is also required in a later patch to pass the commit_tid info in
ext4_fc_commit_start/stop() trace events.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 849fd4dcb825..88ed99e670c5 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1164,11 +1164,12 @@ static int ext4_fc_perform_commit(journal_t *journal)
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
@@ -1218,14 +1219,16 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
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
 
@@ -1257,12 +1260,12 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
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

