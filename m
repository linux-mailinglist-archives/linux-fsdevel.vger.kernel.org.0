Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BA25EBE5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 11:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiI0JUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 05:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiI0JUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:20:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA928C474;
        Tue, 27 Sep 2022 02:18:56 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R8TIrC008212;
        Tue, 27 Sep 2022 09:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ffM+mRQ5OxJ4gjOuN8SlbuOlVJEumCavFUTpBKNJ95I=;
 b=iM+QiBYUKS8TWYYF4f4WIKT6J3C+3/Q4kzqEuWi+p8NcRMQyVqMhmvUflseh7szCUIP/
 YvvNMm1F9eip6YWoKi52K6fWcqLi911VWzDNqzvS0hbkVZdU+FE5XHcajDwjuXVStoFO
 H4V3u0PpeQNOIUR4nlF0Xb2s8BbcD7BIzCq72wxMH6Q61WerEAzXy8cSoGcYcApVJY/5
 LH9Dq0XHa7gOcTZcIsc83ZsL489utyoj2Sge4dSGMZTv7WaPKPVsa+hPjgDzP9XfhxRQ
 +S6naRt4hnQjvrTwuPXG8f3KtdvPQNpnDQZh1jSZUDQoICzD5u88HNHp6qGktupnd7W5 fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3juwq69n4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 09:18:29 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28R92IgK024709;
        Tue, 27 Sep 2022 09:18:28 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3juwq69n3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 09:18:28 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28R95ohC018801;
        Tue, 27 Sep 2022 09:18:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3jssh9bm45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 09:18:26 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28R9IOU7983730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 09:18:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 512C642041;
        Tue, 27 Sep 2022 09:18:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13EF04203F;
        Tue, 27 Sep 2022 09:18:22 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.61.44])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Sep 2022 09:18:21 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC v3 2/8] ext4: Refactor code related to freeing PAs
Date:   Tue, 27 Sep 2022 14:46:42 +0530
Message-Id: <dd083c3e6db5c2938bcaecbd247bc9ecd6646d89.1664269665.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1664269665.git.ojaswin@linux.ibm.com>
References: <cover.1664269665.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Hgxl8ZBjM1KovJNRk8QgobbXgkbVfs7z
X-Proofpoint-ORIG-GUID: Fab5BmFw85xqhJdEd1NwWtqrZKF1uCd-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999 adultscore=0
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

This patch makes the following changes:

*  Rename ext4_mb_pa_free to ext4_mb_pa_put_free
   to better reflect its purpose

*  Add new ext4_mb_pa_free() which only handles freeing

*  Refactor ext4_mb_pa_callback() to use ext4_mb_pa_free()

There are no functional changes in this patch

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/mballoc.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 2e3eb632a216..8be6f8765a6f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4531,16 +4531,21 @@ static void ext4_mb_mark_pa_deleted(struct super_block *sb,
 	}
 }
 
-static void ext4_mb_pa_callback(struct rcu_head *head)
+static void inline ext4_mb_pa_free(struct ext4_prealloc_space *pa)
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
+	pa = container_of(head, struct ext4_prealloc_space, u.pa_rcu);
+	ext4_mb_pa_free(pa);
+}
+
 /*
  * drops a reference to preallocated space descriptor
  * if this was the last reference and the space is consumed
@@ -5067,14 +5072,20 @@ static int ext4_mb_pa_alloc(struct ext4_allocation_context *ac)
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
@@ -5623,13 +5634,13 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
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
@@ -5648,7 +5659,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 		 * If block allocation fails then the pa allocated above
 		 * needs to be freed here itself.
 		 */
-		ext4_mb_pa_free(ac);
+		ext4_mb_pa_put_free(ac);
 		*errp = -ENOSPC;
 	}
 
-- 
2.31.1

