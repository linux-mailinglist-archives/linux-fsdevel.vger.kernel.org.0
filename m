Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107196B226A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 12:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCILPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 06:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjCILOd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:14:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEA3F249F;
        Thu,  9 Mar 2023 03:09:52 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3297eXL3024061;
        Thu, 9 Mar 2023 11:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=AVwrVBC1YwXBtnFMwHYdJTjiEZ0n8RKNs2clD1tsk+o=;
 b=hJ2FhyCe5DXrPvwddAl8lklGBSjBnAjNvXgloTpXMEaImw/tTUhSRMr5RQ/W2jxoC30o
 b581DQxrQQAska5XlZn5Eb1mY48FFqN+Ua/mRObMKXsAoUsHx3HnbKbN7jYlw2nLwKRo
 fXX9dqiKz4YuGWQ56uTtQ9qKrND9sL2YZtFKGt7aOBeUhznA47t9FyQkcFyM5rvLeuRi
 uSUJSw2WsLhb04UFSuBiYzoGJEe0Vy0+WPcnGnalNam3gI2Lq7Z5aKSq/hu3yw6eeUQw
 2ynfY/AyQsaX4+Fa67iPvl20g8z2QYT5sdzkd239KZb+xA7QNHV1f/9YEdcsMXDBypl2 jA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p418y2fj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 11:09:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 329AckMf020762;
        Thu, 9 Mar 2023 11:09:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fu9b77c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 11:09:44 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 329B70tM021817;
        Thu, 9 Mar 2023 11:09:43 GMT
Received: from localhost.localdomain (dhcp-10-191-129-247.vpn.oracle.com [10.191.129.247])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p6fu9b73f-3;
        Thu, 09 Mar 2023 11:09:43 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        joe.jin@oracle.com
Subject: [PATCH v2 2/3] kernfs: Use a per-fs rwsem to protect per-fs list of kernfs_super_info.
Date:   Thu,  9 Mar 2023 22:09:31 +1100
Message-Id: <20230309110932.2889010-3-imran.f.khan@oracle.com>
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
X-Proofpoint-GUID: ZS6LNlr80EJgBb5lZJSH0USiaGC6dNHy
X-Proofpoint-ORIG-GUID: ZS6LNlr80EJgBb5lZJSH0USiaGC6dNHy
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
 fs/kernfs/file.c            | 4 ++--
 fs/kernfs/kernfs-internal.h | 1 +
 fs/kernfs/mount.c           | 8 ++++----
 4 files changed, 8 insertions(+), 6 deletions(-)

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
index e4a50e4ff0d23..40c4661f15b7c 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -922,8 +922,8 @@ static void kernfs_notify_workfn(struct work_struct *work)
 
 	root = kernfs_root(kn);
 	/* kick fsnotify */
-	down_write(&root->kernfs_rwsem);
 
+	down_read(&root->kernfs_supers_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
 		struct inode *p_inode = NULL;
@@ -960,7 +960,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		iput(inode);
 	}
 
-	up_write(&root->kernfs_rwsem);
+	up_read(&root->kernfs_supers_rwsem);
 	kernfs_put(kn);
 	goto repeat;
 }
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

