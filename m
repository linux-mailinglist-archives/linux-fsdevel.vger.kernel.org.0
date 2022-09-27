Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE19A5EBE64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 11:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiI0JVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 05:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiI0JUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:20:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD51DD12D1;
        Tue, 27 Sep 2022 02:19:05 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R9EeAP008590;
        Tue, 27 Sep 2022 09:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0q0BYZuRJwbMKv3NZXlCr8nj4/9ERnVAsBGtncQ7xqE=;
 b=HyIUdL9DUa6YX2apZgJmrmM01ZOdvLzZ69oX0ZaKuST9lleJORaQGfxwOa4gbJWe01vg
 ZOvquxe54HUBEorldwt9EQdrtWunt5LhXWojwYdhjQ7HTwBKj6Lu1tnmSMnpiOjdLZzX
 XFJ67Pfkq91rZGUi66f1KAiEnNRJtEWy44euGn+madjmubB9r56i9jR/ty+1FzJwE8fw
 +E5rl5IsixsdR22ny5yTm4gdOcHmKlgVPtdVU5ZMppGLZwC8JatydeRGx/F1WumxLmGu
 ghyr0ohFBbqtM/MYvYnZRGWPcnnLZY7sZc3a94G/Z9JUVSL3QegWimxodjN0f1BVrHET uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3juv5nmfcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 09:18:38 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28R95mIF001331;
        Tue, 27 Sep 2022 09:18:37 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3juv5nmfbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 09:18:37 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28R95bSL026871;
        Tue, 27 Sep 2022 09:18:35 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3jssh8tpj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 09:18:35 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28R9IWel2228898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 09:18:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 858CD42041;
        Tue, 27 Sep 2022 09:18:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 421344203F;
        Tue, 27 Sep 2022 09:18:30 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.61.44])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Sep 2022 09:18:30 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC v3 5/8] ext4: Abstract out overlap fix/check logic in ext4_mb_normalize_request()
Date:   Tue, 27 Sep 2022 14:46:45 +0530
Message-Id: <f6787e57f6deb1bff2a1d1c070dfe20d281ed5d1.1664269665.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1664269665.git.ojaswin@linux.ibm.com>
References: <cover.1664269665.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OUop73_yJ7w3I8r0fGrg8TLPzrWTlOc3
X-Proofpoint-GUID: 08ZUdi6ya0fwuNtZFgUtIxGTIOE0kqUQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270053
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

