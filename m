Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC315A3C58
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 08:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiH1Gq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 02:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbiH1Gqw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 02:46:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9DF4B0C2;
        Sat, 27 Aug 2022 23:46:51 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27S594fa000407;
        Sun, 28 Aug 2022 06:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gCCmfy8qvG0d0V1/cAfNdfT3acbWpIQUagPipop3hBo=;
 b=h3/VTj9RNU0GpVV4/E7GsHWiDe1zeVfDYQ7ssgI3z+pZefNAXHhwL1PkaZ+bQl84ImkS
 nhN0xeI0iTcu8bTFMaV5B2IoZoCkThHWGzHY18S+859GWLXqkfCfO4UDfU9Gl7W7tFQ0
 u4VZGpcBlv1ykskim/k6H9jB3gVShulGxquoZ1th0+xtICPK/CrSa6WLQ7N8jEd/JvSk
 Xg+TvuU8uDw/t6C7Ze4Wg8pRGJXsq1ZPzMOVbbubG2xhhFfesbUKxM9DhXHVyBDJtE1N
 KuOpz0gaOjGmyW67y6ha9hDkvsUJcLtu1vjPSrXZSoQQP+ZOrRUMxkuMKyIC57Zd2XIH oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j7w6gg2cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 06:46:48 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27S6kmJn030354;
        Sun, 28 Aug 2022 06:46:48 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j7w6gg2c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 06:46:48 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27S6Zuld012785;
        Sun, 28 Aug 2022 06:46:45 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3j7ahhrrdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 06:46:45 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27S6l4vH44630502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Aug 2022 06:47:04 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C3AC5204F;
        Sun, 28 Aug 2022 06:46:43 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.118.96])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3C6E05204E;
        Sun, 28 Aug 2022 06:46:41 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 5/8] ext4: Abstract out overlap fix/check logic in ext4_mb_normalize_request()
Date:   Sun, 28 Aug 2022 12:16:18 +0530
Message-Id: <234312071f65ed3a66e9f3472082a745f575e50e.1661632343.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1661632343.git.ojaswin@linux.ibm.com>
References: <cover.1661632343.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w_HlLSzDn5xFpW2c58xSqyVV2pcWOGJL
X-Proofpoint-GUID: w9W8W0KuijcbBLGgAKEiztP19cd1vwMZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 clxscore=1015 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208280025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 8f5aaff892d4..49bc4b8fd849 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4043,6 +4043,74 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
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
@@ -4057,9 +4125,6 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	loff_t size, start_off;
 	loff_t orig_size __maybe_unused;
 	ext4_lblk_t start;
-	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
-	struct ext4_prealloc_space *tmp_pa;
-	ext4_lblk_t tmp_pa_start, tmp_pa_end;
 
 	/* do normalize only data requests, metadata requests
 	   do not need preallocation */
@@ -4160,47 +4225,10 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 
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

