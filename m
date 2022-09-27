Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28905EBE5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 11:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiI0JUi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 05:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiI0JUE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:20:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9C6D33C5;
        Tue, 27 Sep 2022 02:19:03 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R8JYTt010781;
        Tue, 27 Sep 2022 09:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IetkwfUweD3Gi0+PhqVbWTS8N537yLyHgepl+ZxlTvE=;
 b=OAAC5PZCGIjK4k6AKL1jeGg6y2iWn4Ud805B6FOko2E1Hzd+BBJJjvMjE++AWGmyMS3R
 is/t2GQ327JmK9MnvMSKu74/sY9Ctc4TpA2xVy2RwTYUo1bduq92WhH/t/KXL2yOmrE9
 kiXfbpHATJ5/McPDscG2emyNtirNKhAuSGRh95Xr5+R2yXWieomEUoGEzV818kmIlrLQ
 CmChi+Hua2j8VCy5ABj4ChEedMXED3MXzv5OVlAMUrajz7CtEnT5OjbbEQoOXQFP37IP
 ougAvRsVxgYI+RZz+4Qff73qv9NGKPbqBFMEGNZ9vmLSxZvyBuOrVKkAkLnckGtI7S5e qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3juwjk9st4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 09:18:34 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28R8K132011539;
        Tue, 27 Sep 2022 09:18:34 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3juwjk9ssc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 09:18:34 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28R967DO005217;
        Tue, 27 Sep 2022 09:18:32 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3jssh8tph2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 09:18:32 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28R9EGAW44761448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 09:14:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D86AE42047;
        Tue, 27 Sep 2022 09:18:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80C164203F;
        Tue, 27 Sep 2022 09:18:27 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.61.44])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Sep 2022 09:18:27 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC v3 4/8] ext4: Move overlap assert logic into a separate function
Date:   Tue, 27 Sep 2022 14:46:44 +0530
Message-Id: <a762293342ceadc5c49870db0394a15ca53eebaa.1664269665.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1664269665.git.ojaswin@linux.ibm.com>
References: <cover.1664269665.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2f2mWJOCr5b35zEv4fD9TS7ETF3bCi5a
X-Proofpoint-ORIG-GUID: ogVtXn7HejRZa-D4tapr_F4j-MaGsBQb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Abstract out the logic to double check for overlaps in normalize_pa to
a separate function. Since there has been no reports in past where we
have seen any overlaps which hits this bug_on(), in future we can
consider calling this function under "#ifdef AGGRESSIVE_CHECK" only.

There are no functional changes in this patch

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/mballoc.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 84950df709bb..d1ce34888dcc 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3985,6 +3985,29 @@ static void ext4_mb_normalize_group_request(struct ext4_allocation_context *ac)
 	mb_debug(sb, "goal %u blocks for locality group\n", ac->ac_g_ex.fe_len);
 }
 
+static inline void
+ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
+			  ext4_lblk_t start, ext4_lblk_t end)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
+	struct ext4_prealloc_space *tmp_pa;
+	ext4_lblk_t tmp_pa_start, tmp_pa_end;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
+		spin_lock(&tmp_pa->pa_lock);
+		if (tmp_pa->pa_deleted == 0) {
+			tmp_pa_start = tmp_pa->pa_lstart;
+			tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
+
+			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
+		}
+		spin_unlock(&tmp_pa->pa_lock);
+	}
+	rcu_read_unlock();
+}
+
 /*
  * Normalization means making request better in terms of
  * size and alignment
@@ -4141,18 +4164,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	size = end - start;
 
 	/* XXX: extra loop to check we really don't overlap preallocations */
-	rcu_read_lock();
-	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
-		spin_lock(&tmp_pa->pa_lock);
-		if (tmp_pa->pa_deleted == 0) {
-			tmp_pa_start = tmp_pa->pa_lstart;
-			tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
-
-			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
-		}
-		spin_unlock(&tmp_pa->pa_lock);
-	}
-	rcu_read_unlock();
+	ext4_mb_pa_assert_overlap(ac, start, end);
 
 	/*
 	 * In this function "start" and "size" are normalized for better
-- 
2.31.1

