Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AD76C8C6D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Mar 2023 09:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjCYIOf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Mar 2023 04:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjCYIOQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:14:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D761110279;
        Sat, 25 Mar 2023 01:14:09 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32P7K9Dx009393;
        Sat, 25 Mar 2023 08:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=44j/rkb/mzYeeWQowCkMiryXGzb4i5J79ee0BAZdui0=;
 b=RgXb7d/QWlpDITdDcKbZogVqmLr3dcXrOz9KdjHx1DfteqHA83HPgXroP9UG0ENYkO8K
 wFzab/Y01d7qiODyQYE1OEljtx11HSue6CO4Y0Zw63B3hSljTv1C8b7zwYT8/thYhM3G
 HBcW/wdP4EF+R4OUrsyFKvoP9BAmYPXumyiPzgxzb0Pql8b+JL7lnQypAFwlsimtxv2y
 J08r/9W5aMdzAwa01ObHFvCJihifFSJBF3JO8p2zINSZF/OQkd5jiY4c+141VKs30aK/
 5HlnqaQedSNBoWzeZuUMXgJTbJFxNN0y76xqYIOMLuRTcnwGd1qhfiWF5wgMvy0iCIE4 MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3phvfgrmgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 08:14:04 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32P8E4ND026937;
        Sat, 25 Mar 2023 08:14:04 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3phvfgrmg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 08:14:04 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32P2tKaM015705;
        Sat, 25 Mar 2023 08:14:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3phrk6g78t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 08:14:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32P8Dx3N24969942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Mar 2023 08:13:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4852420043;
        Sat, 25 Mar 2023 08:13:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E46FE20040;
        Sat, 25 Mar 2023 08:13:56 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.63.61])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 25 Mar 2023 08:13:56 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v6 5/9] ext4: Abstract out overlap fix/check logic in ext4_mb_normalize_request()
Date:   Sat, 25 Mar 2023 13:43:38 +0530
Message-Id: <9b35f3955a1d7b66bbd713eca1e63026e01f78c1.1679731817.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1679731817.git.ojaswin@linux.ibm.com>
References: <cover.1679731817.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lqLTtDCawen_Gq4oVU-MxiiQHsmBU1BV
X-Proofpoint-GUID: x5lls1CNS3_INZAUqGu9XMEEq0p0s_Ri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303250065
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Abstract out the logic of fixing PA overlaps in ext4_mb_normalize_request
to improve readability of code. This also makes it easier to make changes
to the overlap logic in future.

There are no functional changes in this patch

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 109 +++++++++++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 41 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index daa8411d6b61..37bf6507cbfd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4001,6 +4001,73 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
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
+}
+
 /*
  * Normalization means making request better in terms of
  * size and alignment
@@ -4016,9 +4083,6 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	loff_t size, start_off;
 	loff_t orig_size __maybe_unused;
 	ext4_lblk_t start;
-	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
-	struct ext4_prealloc_space *tmp_pa;
-	ext4_lblk_t tmp_pa_start, tmp_pa_end;
 
 	/* do normalize only data requests, metadata requests
 	   do not need preallocation */
@@ -4119,47 +4183,10 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 
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

