Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716AA5166BE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 May 2022 19:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353551AbiEARl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 May 2022 13:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353457AbiEARlv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 May 2022 13:41:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B689BDB6;
        Sun,  1 May 2022 10:38:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2418N8ep032436;
        Sun, 1 May 2022 17:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=mKSDOa4qRzjE/NpQsELIZA2a0Z8+WDa1MO8RxPDFNxg=;
 b=w1gbt52OwNMv/hlk+YXoJYXcfhfep/y9vMeViBC2fZn4uTKGZWBOr4oYeYXpdbeVSKse
 Di2nsT9HTA3Is21TfIjlAMES+BFEC0cz0rON6p3dmosMLzzDdP7KAYYOUrjq73NaIPAx
 Vpgx5Fr8nQVZw9e8jlGJFDf78mOB6nuDCPY90OiIvAGNLJTZTAlr3AsbpkqFbsocMAol
 9620/3Juas1BZZoqMzrur+k4jeOxAHb1WY+FlcAibHulV1rLTCCjuuzqYiTfgDCzwNbA
 2VQCymbg+PwGBFk4R9LESwJhrqprTEbifK+hI5N7R79wk/hCQewem/gzwHse4aWhTvsx oQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0aht9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 May 2022 17:38:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 241HZDwr033356;
        Sun, 1 May 2022 17:38:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a37w6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 May 2022 17:38:22 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 241HauVj034841;
        Sun, 1 May 2022 17:38:22 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a37w5x-6;
        Sun, 01 May 2022 17:38:22 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v24 5/7] fs/lock: add 2 callbacks to lock_manager_operations to resolve conflict
Date:   Sun,  1 May 2022 10:38:14 -0700
Message-Id: <1651426696-15509-6-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1651426696-15509-1-git-send-email-dai.ngo@oracle.com>
References: <1651426696-15509-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: VA4Ga4N708Q_vhDjWd26Jx9SCIQaHcjG
X-Proofpoint-ORIG-GUID: VA4Ga4N708Q_vhDjWd26Jx9SCIQaHcjG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add 2 new callbacks, lm_lock_expirable and lm_expire_lock, to
lock_manager_operations to allow the lock manager to take appropriate
action to resolve the lock conflict if possible.

A new field, lm_mod_owner, is also added to lock_manager_operations.
The lm_mod_owner is used by the fs/lock code to make sure the lock
manager module such as nfsd, is not freed while lock conflict is being
resolved.

lm_lock_expirable checks and returns true to indicate that the lock
conflict can be resolved else return false. This callback must be
called with the flc_lock held so it can not block.

lm_expire_lock is called to resolve the lock conflict if the returned
value from lm_lock_expirable is true. This callback is called without
the flc_lock held since it's allowed to block. Upon returning from
this callback, the lock conflict should be resolved and the caller is
expected to restart the conflict check from the beginnning of the list.

Lock manager, such as NFSv4 courteous server, uses this callback to
resolve conflict by destroying lock owner, or the NFSv4 courtesy client
(client that has expired but allowed to maintains its states) that owns
the lock.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 Documentation/filesystems/locking.rst |  4 ++++
 fs/locks.c                            | 45 ++++++++++++++++++++++++++++++++---
 include/linux/fs.h                    |  3 +++
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index c26d854275a0..0997a258361a 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -428,6 +428,8 @@ prototypes::
 	void (*lm_break)(struct file_lock *); /* break_lease callback */
 	int (*lm_change)(struct file_lock **, int);
 	bool (*lm_breaker_owns_lease)(struct file_lock *);
+        bool (*lm_lock_expirable)(struct file_lock *);
+        void (*lm_expire_lock)(void);
 
 locking rules:
 
@@ -439,6 +441,8 @@ lm_grant:		no		no			no
 lm_break:		yes		no			no
 lm_change		yes		no			no
 lm_breaker_owns_lease:	yes     	no			no
+lm_lock_expirable	yes		no			no
+lm_expire_lock		no		no			yes
 ======================	=============	=================	=========
 
 buffer_head
diff --git a/fs/locks.c b/fs/locks.c
index c369841ef7d1..17917da06463 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -902,6 +902,9 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 	struct file_lock *cfl;
 	struct file_lock_context *ctx;
 	struct inode *inode = locks_inode(filp);
+	void *owner;
+	bool ret;
+	void (*func)(void);
 
 	ctx = smp_load_acquire(&inode->i_flctx);
 	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
@@ -909,12 +912,28 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 		return;
 	}
 
+retry:
 	spin_lock(&ctx->flc_lock);
 	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
-		if (posix_locks_conflict(fl, cfl)) {
-			locks_copy_conflock(fl, cfl);
-			goto out;
+		if (!posix_locks_conflict(fl, cfl))
+			continue;
+		if (cfl->fl_lmops && cfl->fl_lmops->lm_mod_owner &&
+				cfl->fl_lmops->lm_lock_expirable &&
+				cfl->fl_lmops->lm_expire_lock) {
+			ret = (*cfl->fl_lmops->lm_lock_expirable)(cfl);
+			if (!ret)
+				goto conflict;
+			owner = cfl->fl_lmops->lm_mod_owner;
+			func = cfl->fl_lmops->lm_expire_lock;
+			__module_get(owner);
+			spin_unlock(&ctx->flc_lock);
+			(*func)();
+			module_put(owner);
+			goto retry;
 		}
+conflict:
+		locks_copy_conflock(fl, cfl);
+		goto out;
 	}
 	fl->fl_type = F_UNLCK;
 out:
@@ -1088,6 +1107,9 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	int error;
 	bool added = false;
 	LIST_HEAD(dispose);
+	void *owner;
+	bool ret;
+	void (*func)(void);
 
 	ctx = locks_get_lock_context(inode, request->fl_type);
 	if (!ctx)
@@ -1106,6 +1128,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		new_fl2 = locks_alloc_lock();
 	}
 
+retry:
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
 	/*
@@ -1117,6 +1140,22 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
 			if (!posix_locks_conflict(request, fl))
 				continue;
+			if (fl->fl_lmops && fl->fl_lmops->lm_mod_owner &&
+					fl->fl_lmops->lm_lock_expirable &&
+					fl->fl_lmops->lm_expire_lock) {
+				ret = (*fl->fl_lmops->lm_lock_expirable)(fl);
+				if (!ret)
+					goto conflict;
+				owner = fl->fl_lmops->lm_mod_owner;
+				func = fl->fl_lmops->lm_expire_lock;
+				__module_get(owner);
+				spin_unlock(&ctx->flc_lock);
+				percpu_up_read(&file_rwsem);
+				(*func)();
+				module_put(owner);
+				goto retry;
+			}
+conflict:
 			if (conflock)
 				locks_copy_conflock(conflock, fl);
 			error = -EAGAIN;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b8ed7f974fb4..aa6c1bbdb8c4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1029,6 +1029,7 @@ struct file_lock_operations {
 };
 
 struct lock_manager_operations {
+	void *lm_mod_owner;
 	fl_owner_t (*lm_get_owner)(fl_owner_t);
 	void (*lm_put_owner)(fl_owner_t);
 	void (*lm_notify)(struct file_lock *);	/* unblock callback */
@@ -1037,6 +1038,8 @@ struct lock_manager_operations {
 	int (*lm_change)(struct file_lock *, int, struct list_head *);
 	void (*lm_setup)(struct file_lock *, void **);
 	bool (*lm_breaker_owns_lease)(struct file_lock *);
+	bool (*lm_lock_expirable)(struct file_lock *cfl);
+	void (*lm_expire_lock)(void);
 };
 
 struct lock_manager {
-- 
2.9.5

