Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB47A5A3C53
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 08:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiH1Gqw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 02:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiH1Gqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 02:46:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECEB4B0D5;
        Sat, 27 Aug 2022 23:46:44 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27S4mJn6029619;
        Sun, 28 Aug 2022 06:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KwjyvFVc7hS69qCb0c8ZPxQE2xLYpbEanTTSH6+wgOE=;
 b=ppwnV9gxB8xXkqF5UgKsER8Qr06HyY+sZr1SFknm+Gc4Sa2qrk8cj+k2UoqX9J+i2U5+
 EseebaJie2e1o9BP9Qfz2YlO1AaKqnrtYxYaSvMjfv474m27rvIfnN9G6HY156Df1aCn
 Bg+kKFECdNIEzgEV03UbSnFY3+3iVSmqoiw/M7Y9QgfOrFdsjhK1xLZBooDuJeToRZre
 ievW6dIywqXE3SKsA1BA0BOPEYCVC5uzcbLfhHf6MdtkdpFJpc+E+RD+3Ba0KNErWqxU
 5g2oPOKt9wU9QV/lHlQcO1wRiG1SBHZflF4aYJV5KLhavoX9se/RCpDDtDiFzUTrxXq+ iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j81nkj36a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 06:46:41 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27S6kN0i023922;
        Sun, 28 Aug 2022 06:46:40 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j81nkj35k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 06:46:40 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27S6Zqhi018278;
        Sun, 28 Aug 2022 06:46:38 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3j7aw8rre5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 06:46:38 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27S6kZNo38470134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Aug 2022 06:46:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEE1652052;
        Sun, 28 Aug 2022 06:46:35 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.118.96])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id DA56F5204E;
        Sun, 28 Aug 2022 06:46:33 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 2/8] ext4: Refactor code related to freeing PAs
Date:   Sun, 28 Aug 2022 12:16:15 +0530
Message-Id: <7d710cff7f2bcfdadabfb02d7d405bcff08e5c3f.1661632343.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1661632343.git.ojaswin@linux.ibm.com>
References: <cover.1661632343.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p8poaoxfm2qSr_z0RbBShqboeMpZLei7
X-Proofpoint-GUID: ugEIYdNNKyJTEkA0-O5Grc4HlmVjQuX7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208280025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 17bf71a3b471..dc2c54464120 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4566,16 +4566,21 @@ static void ext4_mb_mark_pa_deleted(struct super_block *sb,
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
@@ -5102,14 +5107,20 @@ static int ext4_mb_pa_alloc(struct ext4_allocation_context *ac)
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
@@ -5654,13 +5665,13 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
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
@@ -5678,7 +5689,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 		 * If block allocation fails then the pa allocated above
 		 * needs to be freed here itself.
 		 */
-		ext4_mb_pa_free(ac);
+		ext4_mb_pa_put_free(ac);
 		*errp = -ENOSPC;
 	}
 
-- 
2.31.1

