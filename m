Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB475E9A12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 09:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbiIZHG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 03:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiIZHG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:06:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEF2240B1;
        Mon, 26 Sep 2022 00:06:50 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28Q4ZO4x021578;
        Mon, 26 Sep 2022 07:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ffM+mRQ5OxJ4gjOuN8SlbuOlVJEumCavFUTpBKNJ95I=;
 b=nm++zQOCf2l2pHdNj0//GG+tG836Gwgnz1mf6WwEWcsvl+I8YP40jUbjSoGC/p37rmFl
 /hmPm2DQ2aF8dGW/bhL9VwLWEUxe1TEObW7bUSV9QtYr1NuGLKnQCDR234WmvmzjVYkF
 qOdf18uDx+60ZUMI0DrO92gugXDQbarhfZzbufWtbzm5xoaJ+tBuAGqDa5JZdIJ3zn0s
 KY6hYlPWQplYEKNlGV7mj9vpXKZx9jpQaR6Lmdb2EDPrywOYlQg7onCaobpZyR91IwRJ
 XKekXzuk+8Rski1y9Ds5IpzcDvDwyrs+LnXFA31EBFEM2jW8ZW7Cujnd+04Whj3CcRbK IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jtbtgvycv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 07:06:44 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28Q5ZxNd023580;
        Mon, 26 Sep 2022 07:06:44 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jtbtgvybx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 07:06:44 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28Q75GoY016800;
        Mon, 26 Sep 2022 07:06:41 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3jssh8sgqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 07:06:41 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28Q776I845416890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 07:07:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C5C011C04A;
        Mon, 26 Sep 2022 07:06:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 695E111C054;
        Mon, 26 Sep 2022 07:06:36 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.30.221])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Sep 2022 07:06:36 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC v2 2/8] ext4: Refactor code related to freeing PAs
Date:   Mon, 26 Sep 2022 12:34:53 +0530
Message-Id: <dd083c3e6db5c2938bcaecbd247bc9ecd6646d89.1664172580.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1664172580.git.ojaswin@linux.ibm.com>
References: <cover.1664172580.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: md4C-NwLNnhTlwl8kq_0l1W2OY0QCBxB
X-Proofpoint-ORIG-GUID: XZMD91FsheY5BEdGFVbT5qCn22Slth3-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209260043
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

