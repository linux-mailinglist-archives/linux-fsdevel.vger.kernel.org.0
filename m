Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4416A7A83
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 05:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCBEdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 23:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjCBEc0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 23:32:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC484989B;
        Wed,  1 Mar 2023 20:32:22 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321MuxpQ010778;
        Thu, 2 Mar 2023 04:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=TnmHeNRcAoyXl5CEEGM2b0RdtGuW/vrovhZ7nMWGPa0=;
 b=2gOGmw3Wh0CLC7D2pE1j5DHV7xeIlF0qqJR/e8+rBMWqHBO4lL2cFG9eriTgocpPDkaO
 rDHEzJCB5blI11WLf/+3E4diSRpDf8DsnRMttn47zhqEnW+7fb4ASMjcvwd8LjO2e+Tl
 snt5n1xfm4/ZyWmiDR8J26VURmdYlmG9iLGWOf8XT/OsjaEq5ffNVmmz1SY3tT1nxdAq
 As80PfpE7lj0amVB3E/0r4sk+Kr5Iaesd+EaR56HCy8LbTvj9RDA/LPfGYnkWf+nz4bR
 ePgjIixaF/LS7R/CPkjEJIoecQabd6pOiZ/fvT0m9bjH4BAQp2XHlI4NLxbHT+ORZLPO 5A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybb2jnht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 04:32:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3223Grw5031559;
        Thu, 2 Mar 2023 04:32:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sga7g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 04:32:15 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3224W8eW012677;
        Thu, 2 Mar 2023 04:32:15 GMT
Received: from localhost.localdomain (dhcp-10-191-129-161.vpn.oracle.com [10.191.129.161])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ny8sga7bn-3;
        Thu, 02 Mar 2023 04:32:14 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        joe.jin@oracle.com
Subject: [PATCH 2/3] kernfs: Use a per-fs rwsem to protect per-fs list of kernfs_super_info.
Date:   Thu,  2 Mar 2023 15:32:02 +1100
Message-Id: <20230302043203.1695051-3-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302043203.1695051-1-imran.f.khan@oracle.com>
References: <20230302043203.1695051-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_01,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020035
X-Proofpoint-GUID: dxhkk4ncYBTkcogIzjvu99Hbi9OzkoaW
X-Proofpoint-ORIG-GUID: dxhkk4ncYBTkcogIzjvu99Hbi9OzkoaW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Right now per-fs kernfs_rwsem protects list of kernfs_super_info instances
for a kernfs_root. Since kernfs_rwsem is used to synchronize several other
operations across kernfs and since most of these operations don't impact
kernfs_super_info, we can use a separate per-fs rwsem to synchronize access
to list of kernfs_super_info.
This helps in reducing contention around kernfs_rwsem and also allows
operations that change/access list of kernfs_super_info to proceed without
contending for kernfs_rwsem.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c             | 1 +
 fs/kernfs/file.c            | 2 ++
 fs/kernfs/kernfs-internal.h | 1 +
 fs/kernfs/mount.c           | 8 ++++----
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 953b2717c60e6..2cdb8516e5287 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -944,6 +944,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 	idr_init(&root->ino_idr);
 	init_rwsem(&root->kernfs_rwsem);
 	init_rwsem(&root->kernfs_iattr_rwsem);
+	init_rwsem(&root->kernfs_supers_rwsem);
 	INIT_LIST_HEAD(&root->supers);
 
 	/*
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e4a50e4ff0d23..b84cf0cd4bd44 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -924,6 +924,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	/* kick fsnotify */
 	down_write(&root->kernfs_rwsem);
 
+	down_write(&root->kernfs_supers_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
 		struct inode *p_inode = NULL;
@@ -960,6 +961,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		iput(inode);
 	}
 
+	up_write(&root->kernfs_supers_rwsem);
 	up_write(&root->kernfs_rwsem);
 	kernfs_put(kn);
 	goto repeat;
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 3297093c920de..a9b854cdfdb5f 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -48,6 +48,7 @@ struct kernfs_root {
 	wait_queue_head_t	deactivate_waitq;
 	struct rw_semaphore	kernfs_rwsem;
 	struct rw_semaphore	kernfs_iattr_rwsem;
+	struct rw_semaphore	kernfs_supers_rwsem;
 };
 
 /* +1 to avoid triggering overflow warning when negating it */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index e08e8d9998070..d49606accb07b 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -351,9 +351,9 @@ int kernfs_get_tree(struct fs_context *fc)
 		}
 		sb->s_flags |= SB_ACTIVE;
 
-		down_write(&root->kernfs_rwsem);
+		down_write(&root->kernfs_supers_rwsem);
 		list_add(&info->node, &info->root->supers);
-		up_write(&root->kernfs_rwsem);
+		up_write(&root->kernfs_supers_rwsem);
 	}
 
 	fc->root = dget(sb->s_root);
@@ -380,9 +380,9 @@ void kernfs_kill_sb(struct super_block *sb)
 	struct kernfs_super_info *info = kernfs_info(sb);
 	struct kernfs_root *root = info->root;
 
-	down_write(&root->kernfs_rwsem);
+	down_write(&root->kernfs_supers_rwsem);
 	list_del(&info->node);
-	up_write(&root->kernfs_rwsem);
+	up_write(&root->kernfs_supers_rwsem);
 
 	/*
 	 * Remove the superblock from fs_supers/s_instances
-- 
2.34.1

