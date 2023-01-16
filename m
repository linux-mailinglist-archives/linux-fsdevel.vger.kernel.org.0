Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B704E66B8AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 09:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjAPIDr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 03:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjAPIDD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:03:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8263113FF;
        Mon, 16 Jan 2023 00:02:33 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30G5pgPb005210;
        Mon, 16 Jan 2023 08:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ok7YbW6YpMCYxhzqrtvlXy1RVNtgESxGdAZll8GvBIM=;
 b=DA7I6/QkF1w2HKoB+pXz1mcuVuKkB+31OBuTFD7Svxn8Yh5o2Xv7GI8lRZjwvpQ5zjFu
 8nahTmZnPbHZozmtd0h9bQXdgW3fY/qOxlR6hjMFKLdKGePBt2n4oApz+YOq0YWpPg5+
 E41DUUMx3phTx49c1G17Y3Tb1vbO1hP2qrr5BdMeZmmUYG4uKo1UYElveYyWkZfhQaMA
 zvn/Lx/45Eajodg2FcwpGtyPMC7y6ttNmVT0ujjjdmuJB2J9WlXmB3jkshpmCMNawvUk
 kPXOeJQt/4d7OlO7MMIVJ+vZF0p5ONMUIuCFEcbQSGpW/HzoYHRxlEDlG7L2stN/oEYY aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n4gdc92ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 08:02:29 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30G7gXPA026233;
        Mon, 16 Jan 2023 08:02:29 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n4gdc92d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 08:02:29 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30FKoJcI027702;
        Mon, 16 Jan 2023 08:02:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3n3m16hgv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 08:02:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30G82OCO50200878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 08:02:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EF9F20043;
        Mon, 16 Jan 2023 08:02:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22D0B20040;
        Mon, 16 Jan 2023 08:02:22 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jan 2023 08:02:21 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v3 2/8] ext4: Refactor code related to freeing PAs
Date:   Mon, 16 Jan 2023 13:32:10 +0530
Message-Id: <20230116080216.249195-3-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230116080216.249195-1-ojaswin@linux.ibm.com>
References: <20230116080216.249195-1-ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v6wjoGbAaIAxct7YuJE8XG8ReqaYsmg9
X-Proofpoint-ORIG-GUID: tFlrJXrpiFRE3RLbaLDm-drT_YUgKu0h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_06,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301160058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch makes the following changes:

*  Rename ext4_mb_pa_free to ext4_mb_pa_put_free
   to better reflect its purpose

*  Add new ext4_mb_pa_free() which only handles freeing

*  Refactor ext4_mb_pa_callback() to use ext4_mb_pa_free()

There are no functional changes in this patch

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e0bbca523b4b..a5f2803aff93 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4530,16 +4530,22 @@ static void ext4_mb_mark_pa_deleted(struct super_block *sb,
 	}
 }
 
-static void ext4_mb_pa_callback(struct rcu_head *head)
+static inline void ext4_mb_pa_free(struct ext4_prealloc_space *pa)
 {
-	struct ext4_prealloc_space *pa;
-	pa = container_of(head, struct ext4_prealloc_space, u.pa_rcu);
-
+	BUG_ON(!pa);
 	BUG_ON(atomic_read(&pa->pa_count));
 	BUG_ON(pa->pa_deleted == 0);
 	kmem_cache_free(ext4_pspace_cachep, pa);
 }
 
+static void ext4_mb_pa_callback(struct rcu_head *head)
+{
+	struct ext4_prealloc_space *pa;
+
+	pa = container_of(head, struct ext4_prealloc_space, u.pa_rcu);
+	ext4_mb_pa_free(pa);
+}
+
 /*
  * drops a reference to preallocated space descriptor
  * if this was the last reference and the space is consumed
@@ -5066,14 +5072,20 @@ static int ext4_mb_pa_alloc(struct ext4_allocation_context *ac)
 	return 0;
 }
 
-static void ext4_mb_pa_free(struct ext4_allocation_context *ac)
+static void ext4_mb_pa_put_free(struct ext4_allocation_context *ac)
 {
 	struct ext4_prealloc_space *pa = ac->ac_pa;
 
 	BUG_ON(!pa);
 	ac->ac_pa = NULL;
 	WARN_ON(!atomic_dec_and_test(&pa->pa_count));
-	kmem_cache_free(ext4_pspace_cachep, pa);
+	/*
+	 * current function is only called due to an error or due to
+	 * len of found blocks < len of requested blocks hence the PA has not
+	 * been added to grp->bb_prealloc_list. So we don't need to lock it
+	 */
+	pa->pa_deleted = 1;
+	ext4_mb_pa_free(pa);
 }
 
 #ifdef CONFIG_EXT4_DEBUG
@@ -5616,13 +5628,13 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 		 * So we have to free this pa here itself.
 		 */
 		if (*errp) {
-			ext4_mb_pa_free(ac);
+			ext4_mb_pa_put_free(ac);
 			ext4_discard_allocated_blocks(ac);
 			goto errout;
 		}
 		if (ac->ac_status == AC_STATUS_FOUND &&
 			ac->ac_o_ex.fe_len >= ac->ac_f_ex.fe_len)
-			ext4_mb_pa_free(ac);
+			ext4_mb_pa_put_free(ac);
 	}
 	if (likely(ac->ac_status == AC_STATUS_FOUND)) {
 		*errp = ext4_mb_mark_diskspace_used(ac, handle, reserv_clstrs);
@@ -5641,7 +5653,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 		 * If block allocation fails then the pa allocated above
 		 * needs to be freed here itself.
 		 */
-		ext4_mb_pa_free(ac);
+		ext4_mb_pa_put_free(ac);
 		*errp = -ENOSPC;
 	}
 
-- 
2.31.1

