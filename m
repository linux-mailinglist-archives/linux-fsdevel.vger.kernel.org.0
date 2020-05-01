Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D089E1C0E16
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 08:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgEAGag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 02:30:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728126AbgEAGaf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 02:30:35 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04161S8x074452;
        Fri, 1 May 2020 02:30:29 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r81ggyyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 02:30:29 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0416AqrZ009348;
        Fri, 1 May 2020 06:30:28 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 30mcu746rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 06:30:27 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0416UPN258458220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 06:30:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BF86A405B;
        Fri,  1 May 2020 06:30:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EA44A405C;
        Fri,  1 May 2020 06:30:23 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.81.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 06:30:23 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 08/20] ext4: mballoc: Simplify error handling in ext4_init_mballoc()
Date:   Fri,  1 May 2020 11:59:50 +0530
Message-Id: <09d1cd052ddb2ac8ea8df5235938d2610b3b8bfe.1588313626.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588313626.git.riteshh@linux.ibm.com>
References: <cover.1588313626.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_01:2020-04-30,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0 priorityscore=1501
 suspectscore=3 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=964 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010040
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
index 2999b41bb5f8..10f295c61ccb 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2942,23 +2942,26 @@ int __init ext4_init_mballoc(void)
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

