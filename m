Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D88F5E9A1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 09:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbiIZHHj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 03:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbiIZHG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:06:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80D924962;
        Mon, 26 Sep 2022 00:06:58 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28Q4eGcn024910;
        Mon, 26 Sep 2022 07:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0q0BYZuRJwbMKv3NZXlCr8nj4/9ERnVAsBGtncQ7xqE=;
 b=bYhqjGvwmq8+q0LzvPPL4Tx1RLBhk9ztvbQrcNfVaISlnbop9r0ou1xj7H+t0HBeosPt
 UQdVz8klSiTIh9oMnWG5sQgwXsAsH7acxnh/9m+DhBFwoBPdgZo6/cITD1gdTu2w1xjo
 d7Bpds1PlcHH+uIPhFZ83ys0vZMbAkQ2w1dKAat7FGFHXZEXTFj3Tgjf+P2TWDGBAKP9
 OZcYw0B4NzS6OkdRJlrfZg+pKwudrOt/Q5m0GAl7krTMkOGby8ILUwICGVOKhS5ytiTp
 N/2KFk/553MW4qvH5KsrJz1knncAP2kq0rKO4QkLBewXn1iJUhdYRpsCc00RqnwCKK8o BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jtbxr4n3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 07:06:54 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28Q6xetw013542;
        Mon, 26 Sep 2022 07:06:54 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jtbxr4n2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 07:06:54 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28Q75frv014755;
        Mon, 26 Sep 2022 07:06:52 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3jss5j21r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 07:06:51 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28Q76nfY38994416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 07:06:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 990BD11C04A;
        Mon, 26 Sep 2022 07:06:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95A7811C050;
        Mon, 26 Sep 2022 07:06:46 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.30.221])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Sep 2022 07:06:46 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC v2 5/8] ext4: Abstract out overlap fix/check logic in ext4_mb_normalize_request()
Date:   Mon, 26 Sep 2022 12:34:56 +0530
Message-Id: <f6787e57f6deb1bff2a1d1c070dfe20d281ed5d1.1664172580.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1664172580.git.ojaswin@linux.ibm.com>
References: <cover.1664172580.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WQgwoI0wHryuJtuLEzfsnp37WvK2Mhss
X-Proofpoint-GUID: eixyOSNGUA9dq3wMfHaMlbaL9UOjmQ_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260043
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
---
 fs/ext4/mballoc.c | 110 +++++++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 41 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d1ce34888dcc..dda9a72c81d9 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4008,6 +4008,74 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
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
@@ -4022,9 +4090,6 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	loff_t size, start_off;
 	loff_t orig_size __maybe_unused;
 	ext4_lblk_t start;
-	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
-	struct ext4_prealloc_space *tmp_pa;
-	ext4_lblk_t tmp_pa_start, tmp_pa_end;
 
 	/* do normalize only data requests, metadata requests
 	   do not need preallocation */
@@ -4125,47 +4190,10 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 
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

