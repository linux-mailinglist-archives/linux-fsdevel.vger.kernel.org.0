Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D921CC735
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 08:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgEJGZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 02:25:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbgEJGZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 02:25:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A63bsW124590;
        Sun, 10 May 2020 02:25:35 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30wrvxc59d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 02:25:35 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A6KkFl004901;
        Sun, 10 May 2020 06:25:33 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 30wm568t82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 06:25:33 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A6PUmE48496790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 06:25:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A4AB42045;
        Sun, 10 May 2020 06:25:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6F014203F;
        Sun, 10 May 2020 06:25:28 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 06:25:28 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 06/16] ext4: mballoc: Simplify error handling in ext4_init_mballoc()
Date:   Sun, 10 May 2020 11:54:46 +0530
Message-Id: <8621a7bc68f7107a9ac4292afeb784515333bd25.1589086800.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086800.git.riteshh@linux.ibm.com>
References: <cover.1589086800.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_01:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=952 clxscore=1015 mlxscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=3
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005100055
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch simplifies error handling logic in ext4_init_mballoc(),
by adding all the cleanups at one place at the end of that function.

There should be no functionality change in this patch.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 4ada63cf425f..aaf43c6c08e1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2913,23 +2913,26 @@ int __init ext4_init_mballoc(void)
 	ext4_pspace_cachep = KMEM_CACHE(ext4_prealloc_space,
 					SLAB_RECLAIM_ACCOUNT);
 	if (ext4_pspace_cachep == NULL)
-		return -ENOMEM;
+		goto out;
 
 	ext4_ac_cachep = KMEM_CACHE(ext4_allocation_context,
 				    SLAB_RECLAIM_ACCOUNT);
-	if (ext4_ac_cachep == NULL) {
-		kmem_cache_destroy(ext4_pspace_cachep);
-		return -ENOMEM;
-	}
+	if (ext4_ac_cachep == NULL)
+		goto out_pa_free;
 
 	ext4_free_data_cachep = KMEM_CACHE(ext4_free_data,
 					   SLAB_RECLAIM_ACCOUNT);
-	if (ext4_free_data_cachep == NULL) {
-		kmem_cache_destroy(ext4_pspace_cachep);
-		kmem_cache_destroy(ext4_ac_cachep);
-		return -ENOMEM;
-	}
+	if (ext4_free_data_cachep == NULL)
+		goto out_ac_free;
+
 	return 0;
+
+out_ac_free:
+	kmem_cache_destroy(ext4_ac_cachep);
+out_pa_free:
+	kmem_cache_destroy(ext4_pspace_cachep);
+out:
+	return -ENOMEM;
 }
 
 void ext4_exit_mballoc(void)
-- 
2.21.0

