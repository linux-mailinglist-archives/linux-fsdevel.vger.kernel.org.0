Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A486B2264
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 12:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCILPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 06:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjCILOf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:14:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6364AF24A1;
        Thu,  9 Mar 2023 03:09:52 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3297ehhf018305;
        Thu, 9 Mar 2023 11:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=sM2f8KUGw2ieEok7xffWn1NRPRHy+6lIt8O7z1nqwUA=;
 b=TSnSEGn5fb0r5OLvOmUoycnnvxGcMtkvj/9K5fXfjPDk9H8e+BsRTw2uEkMU64l1vELt
 aKRdI2H/G4dZsIpo3IJXtA0+sTk8iJzlIig9WYSj42yiRC20iPnTLAfw7xbxFk4NGbsv
 fAUU1a0c9ZPPgIOYiCw0zCAnLYMpgsH90fLJ4ilnFoqXLDpeP+0PxTuAJ8Ka31WQUpKD
 BSQ1H4dQ7EgM8MFHSHQNhxHF2vEp/QZLOagIHzUsYu/NtfarilnJfAQ1za8URmfhtyeU
 aWG/rkqYpVFuOzgPtj5XzP90WmFP17XqbXdCEgdU+QlDiVNQamF5pJCX1cuYikzzwo4B ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p5nn96r6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 11:09:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3299XM3J020822;
        Thu, 9 Mar 2023 11:09:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fu9b78j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 11:09:47 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 329B70tO021817;
        Thu, 9 Mar 2023 11:09:46 GMT
Received: from localhost.localdomain (dhcp-10-191-129-247.vpn.oracle.com [10.191.129.247])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p6fu9b73f-4;
        Thu, 09 Mar 2023 11:09:46 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        joe.jin@oracle.com
Subject: [PATCH v2 3/3] kernfs: change kernfs_rename_lock into a read-write lock.
Date:   Thu,  9 Mar 2023 22:09:32 +1100
Message-Id: <20230309110932.2889010-4-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309110932.2889010-1-imran.f.khan@oracle.com>
References: <20230309110932.2889010-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_06,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090088
X-Proofpoint-GUID: ZO8p4MktoRctYaJuWOGPKLN1rJZ9us9T
X-Proofpoint-ORIG-GUID: ZO8p4MktoRctYaJuWOGPKLN1rJZ9us9T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernfs_rename_lock protects a node's ->parent and thus kernfs topology.
Thus it can be used in cases that rely on a stable kernfs topology.
Change it to a read-write lock for better scalability.

Suggested by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 2cdb8516e5287..06e27b36216fe 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -17,7 +17,7 @@
 
 #include "kernfs-internal.h"
 
-static DEFINE_SPINLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
+static DEFINE_RWLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
 /*
  * Don't use rename_lock to piggy back on pr_cont_buf. We don't want to
  * call pr_cont() while holding rename_lock. Because sometimes pr_cont()
@@ -196,9 +196,9 @@ int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&kernfs_rename_lock, flags);
+	read_lock_irqsave(&kernfs_rename_lock, flags);
 	ret = kernfs_name_locked(kn, buf, buflen);
-	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
+	read_unlock_irqrestore(&kernfs_rename_lock, flags);
 	return ret;
 }
 
@@ -224,9 +224,9 @@ int kernfs_path_from_node(struct kernfs_node *to, struct kernfs_node *from,
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&kernfs_rename_lock, flags);
+	read_lock_irqsave(&kernfs_rename_lock, flags);
 	ret = kernfs_path_from_node_locked(to, from, buf, buflen);
-	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
+	read_unlock_irqrestore(&kernfs_rename_lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernfs_path_from_node);
@@ -294,10 +294,10 @@ struct kernfs_node *kernfs_get_parent(struct kernfs_node *kn)
 	struct kernfs_node *parent;
 	unsigned long flags;
 
-	spin_lock_irqsave(&kernfs_rename_lock, flags);
+	read_lock_irqsave(&kernfs_rename_lock, flags);
 	parent = kn->parent;
 	kernfs_get(parent);
-	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
+	read_unlock_irqrestore(&kernfs_rename_lock, flags);
 
 	return parent;
 }
@@ -1731,7 +1731,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	kernfs_get(new_parent);
 
 	/* rename_lock protects ->parent and ->name accessors */
-	spin_lock_irq(&kernfs_rename_lock);
+	write_lock_irq(&kernfs_rename_lock);
 
 	old_parent = kn->parent;
 	kn->parent = new_parent;
@@ -1742,7 +1742,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		kn->name = new_name;
 	}
 
-	spin_unlock_irq(&kernfs_rename_lock);
+	write_unlock_irq(&kernfs_rename_lock);
 
 	kn->hash = kernfs_name_hash(kn->name, kn->ns);
 	kernfs_link_sibling(kn);
-- 
2.34.1

