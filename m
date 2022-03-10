Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1FB4D4DFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 17:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbiCJQAy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 11:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239574AbiCJQAo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:00:44 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B39A15A224;
        Thu, 10 Mar 2022 07:59:43 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22AFGo8H026314;
        Thu, 10 Mar 2022 15:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DFOgjjRVfh9RqkGCCnhMtsstlvujXFyUiF2Loke7u60=;
 b=IgkDEMdVbbUI3m0BuVsG4bO+ED0XKCT+BDQHMSdNiEqqD+iDXO0IY19tafQWY9TPm0xA
 ywGoF0PUCEbt6VQfP8JtdCe+pKmGUDLj0JgxLiy5dk97SCtvCANJkaTtYZVsCF0V/BHJ
 BprKWX0c27Y2nGGxlCVJsxGTyutJ6MPozA4dPwJzqP3C7ZIc+hcyRH2V5qiWRvC2+pk1
 6ZZIYS/1KpzowfouL/qRQ5F7VZhOOJIXMHcyT6m9hoteOwsvWLeE904iC7DIp3wiqEgt
 c7cidoAWV72JUD4E+2HPBhxr0ewSe5+XWUKbllWNt4eLscdtaaPfMXmUnh5T81IEnSl4 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eqg9dpt1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:39 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22AEheg2023010;
        Thu, 10 Mar 2022 15:59:38 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eqg9dpt0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:38 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22AFwBBv025113;
        Thu, 10 Mar 2022 15:59:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3eqk8604b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:36 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22AFxY3t54788454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 15:59:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E92FAA4040;
        Thu, 10 Mar 2022 15:59:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75AE1A404D;
        Thu, 10 Mar 2022 15:59:33 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Mar 2022 15:59:33 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 04/10] ext4: Do not call FC trace event in ext4_fc_commit() if FS does not support FC
Date:   Thu, 10 Mar 2022 21:28:58 +0530
Message-Id: <a5c6dd06583fdcce170a96d41cd48c1e61f1a6ce.1646922487.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1646922487.git.riteshh@linux.ibm.com>
References: <cover.1646922487.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q7uoYzninur_x3GJlK51Qe3TEp9bZhmZ
X-Proofpoint-ORIG-GUID: -5gjqCkPZDKZSKwDkDrgVKD0_ryJ8VpU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_06,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=860
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

This just puts trace_ext4_fc_commit_start(sb) & ktime_get()
for measuring FC commit time, after the check of whether sb
supports JOURNAL_FAST_COMMIT or not.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fast_commit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 5ac594e03402..55d33f296cae 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1165,13 +1165,13 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	int status = EXT4_FC_STATUS_OK, fc_bufs_before = 0;
 	ktime_t start_time, commit_time;
 
+	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
+		return jbd2_complete_transaction(journal, commit_tid);
+
 	trace_ext4_fc_commit_start(sb);
 
 	start_time = ktime_get();
 
-	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
-		return jbd2_complete_transaction(journal, commit_tid);
-
 restart_fc:
 	ret = jbd2_fc_begin_commit(journal, commit_tid);
 	if (ret == -EALREADY) {
-- 
2.31.1

