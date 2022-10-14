Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3165FF4A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 22:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiJNUh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 16:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiJNUhW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:37:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F52E4C3B;
        Fri, 14 Oct 2022 13:36:59 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EKHic9000567;
        Fri, 14 Oct 2022 20:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=B4vZrK6YJlL8pOsOJIfCd1dExjqio4WqMVFEwMmL+Y4=;
 b=Hocz8ZIv1oDo4vmPRDG0WVKiH4B+rgDOQBHPOYl3oWkZEhVBC1U3oFMSlYZ37CDg5eP+
 7z7Gcnt7Sauugb0FS88MGTT36rnFjRyD9ma/jeeJQkQiFbFomZOdEkBj+p5rPsicq93D
 6ZVing5+SW99B1YnSoLWn/8DPObBIAluPRKvR7IzioNZXy+mFgaR7bau0UEryVSYy1jM
 pTrFj/XeZy2WMUj7T+CSHCnIj4tmM+Py2QecXfqRkn7JNC/E+nx/+y6GrP49lfKFsoij
 yHqVp/TI2icL68f3R93KpagRFAjp4FiL1r4J1zpIR9863mzXdeDpL/QXuODAQN6vu8fR /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k7d3ak9rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 20:36:53 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29EKSKqD018384;
        Fri, 14 Oct 2022 20:36:53 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k7d3ak9qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 20:36:53 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29EKZMk1008037;
        Fri, 14 Oct 2022 20:36:51 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3k30fj7hc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 20:36:51 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29EKanMY55837180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 20:36:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45B3542041;
        Fri, 14 Oct 2022 20:36:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1D1A4203F;
        Fri, 14 Oct 2022 20:36:46 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.122.214])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Oct 2022 20:36:46 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v2 5/8] ext4: Abstract out overlap fix/check logic in ext4_mb_normalize_request()
Date:   Sat, 15 Oct 2022 02:06:27 +0530
Message-Id: <cf4a2196db634fcefe24d29f572c14b8cacd1ba1.1665776268.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1665776268.git.ojaswin@linux.ibm.com>
References: <cover.1665776268.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Qo9K6rNMRQF8SMcsdJP6doRiWZDtWxnO
X-Proofpoint-GUID: FTq9arRGgpkiXbUcdEEa2cifsFOGOaT4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_11,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Abstract out the logic of fixing PA overlaps in ext4_mb_normalize_request to
improve readability of code. This also makes it easier to make changes
to the overlap logic in future.

There are no functional changes in this patch

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 110 +++++++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 41 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 210f90a6229a..a76fc19ed8d5 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4007,6 +4007,74 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
 	rcu_read_unlock();
 }
 
+/*
+ * Given an allocation context "ac" and a range "start", "end", check
+ * and adjust boundaries if the range overlaps with any of the existing
+ * preallocatoins stored in the corresponding inode of the allocation context.
+ *
+ *Parameters:
+ *	ac			allocation context
+ *	start			start of the new range
+ *	end			end of the new range
+ */
+static inline void
+ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
+			 ext4_lblk_t *start, ext4_lblk_t *end)
+{
+	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	struct ext4_prealloc_space *tmp_pa;
+	ext4_lblk_t new_start, new_end;
+	ext4_lblk_t tmp_pa_start, tmp_pa_end;
+
+	new_start = *start;
+	new_end = *end;
+
+	/* check we don't cross already preallocated blocks */
+	rcu_read_lock();
+	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
+		if (tmp_pa->pa_deleted)
+			continue;
+		spin_lock(&tmp_pa->pa_lock);
+		if (tmp_pa->pa_deleted) {
+			spin_unlock(&tmp_pa->pa_lock);
+			continue;
+		}
+
+		tmp_pa_start = tmp_pa->pa_lstart;
+		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
+
+		/* PA must not overlap original request */
+		BUG_ON(!(ac->ac_o_ex.fe_logical >= tmp_pa_end ||
+			ac->ac_o_ex.fe_logical < tmp_pa_start));
+
+		/* skip PAs this normalized request doesn't overlap with */
+		if (tmp_pa_start >= new_end || tmp_pa_end <= new_start) {
+			spin_unlock(&tmp_pa->pa_lock);
+			continue;
+		}
+		BUG_ON(tmp_pa_start <= new_start && tmp_pa_end >= new_end);
+
+		/* adjust start or end to be adjacent to this pa */
+		if (tmp_pa_end <= ac->ac_o_ex.fe_logical) {
+			BUG_ON(tmp_pa_end < new_start);
+			new_start = tmp_pa_end;
+		} else if (tmp_pa_start > ac->ac_o_ex.fe_logical) {
+			BUG_ON(tmp_pa_start > new_end);
+			new_end = tmp_pa_start;
+		}
+		spin_unlock(&tmp_pa->pa_lock);
+	}
+	rcu_read_unlock();
+
+	/* XXX: extra loop to check we really don't overlap preallocations */
+	ext4_mb_pa_assert_overlap(ac, new_start, new_end);
+
+	*start = new_start;
+	*end = new_end;
+	return;
+}
+
 /*
  * Normalization means making request better in terms of
  * size and alignment
@@ -4021,9 +4089,6 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	loff_t size, start_off;
 	loff_t orig_size __maybe_unused;
 	ext4_lblk_t start;
-	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
-	struct ext4_prealloc_space *tmp_pa;
-	ext4_lblk_t tmp_pa_start, tmp_pa_end;
 
 	/* do normalize only data requests, metadata requests
 	   do not need preallocation */
@@ -4124,47 +4189,10 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 
 	end = start + size;
 
-	/* check we don't cross already preallocated blocks */
-	rcu_read_lock();
-	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
-		if (tmp_pa->pa_deleted)
-			continue;
-		spin_lock(&tmp_pa->pa_lock);
-		if (tmp_pa->pa_deleted) {
-			spin_unlock(&tmp_pa->pa_lock);
-			continue;
-		}
-
-		tmp_pa_start = tmp_pa->pa_lstart;
-		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
-
-		/* PA must not overlap original request */
-		BUG_ON(!(ac->ac_o_ex.fe_logical >= tmp_pa_end ||
-			ac->ac_o_ex.fe_logical < tmp_pa_start));
-
-		/* skip PAs this normalized request doesn't overlap with */
-		if (tmp_pa_start >= end || tmp_pa_end <= start) {
-			spin_unlock(&tmp_pa->pa_lock);
-			continue;
-		}
-		BUG_ON(tmp_pa_start <= start && tmp_pa_end >= end);
+	ext4_mb_pa_adjust_overlap(ac, &start, &end);
 
-		/* adjust start or end to be adjacent to this pa */
-		if (tmp_pa_end <= ac->ac_o_ex.fe_logical) {
-			BUG_ON(tmp_pa_end < start);
-			start = tmp_pa_end;
-		} else if (tmp_pa_start > ac->ac_o_ex.fe_logical) {
-			BUG_ON(tmp_pa_start > end);
-			end = tmp_pa_start;
-		}
-		spin_unlock(&tmp_pa->pa_lock);
-	}
-	rcu_read_unlock();
 	size = end - start;
 
-	/* XXX: extra loop to check we really don't overlap preallocations */
-	ext4_mb_pa_assert_overlap(ac, start, end);
-
 	/*
 	 * In this function "start" and "size" are normalized for better
 	 * alignment and length such that we could preallocate more blocks.
-- 
2.31.1

