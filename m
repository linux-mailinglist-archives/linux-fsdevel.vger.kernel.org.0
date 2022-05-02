Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BE95178FF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 23:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387620AbiEBVXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 17:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387612AbiEBVXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 17:23:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C338DFDA;
        Mon,  2 May 2022 14:19:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242IEC5a029440;
        Mon, 2 May 2022 21:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=LWrAqEtRPv3KYEJl/ulpcEC5A07BZMW3JL5hZIMzwEQ=;
 b=kKQcj3q7qeiOu65TIEH0xEp5sXvs1a8ZDRWsJcRN6X7teSwuQ/X4xNXPMJEshZcSoVzI
 ZZ8RrhmQS/WT4hXuHdcOCAYOCBQpVeGDU7TCif/BifpkpkrgedYatq0Rh2v2Q+peGGK4
 TtN/Sd1ry3LwVTD8z8ErD7TAAMykb1NsXZE4N2eIMdvO9/nna3EZ8C8T/wymrLdzWxjM
 cHXwpFjzWUbIRnrYyrH7ixWo9RMhIhWcPEtNgSFRZii56MCwQBd4xwD6UqXWsfm8Db4w
 eBcEJoLBm/rA/JPjqfYHkxxXVilvQ3EeihaIHOq97P1ABdfmyKdIqFSS3nDxYENM6W6l eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0cdv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 21:19:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 242LAj68029038;
        Mon, 2 May 2022 21:19:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj1v8qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 21:19:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 242LJXSQ003941;
        Mon, 2 May 2022 21:19:35 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj1v8ph-6;
        Mon, 02 May 2022 21:19:35 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v25 5/7] fs/lock: add 2 callbacks to lock_manager_operations to resolve conflict
Date:   Mon,  2 May 2022 14:19:25 -0700
Message-Id: <1651526367-1522-6-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1651526367-1522-1-git-send-email-dai.ngo@oracle.com>
References: <1651526367-1522-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: 8nk-xK-WaitFzhVQPJDOChGELvwlWWL-
X-Proofpoint-GUID: 8nk-xK-WaitFzhVQPJDOChGELvwlWWL-
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

Reviewed-by: J. Bruce Fields <bfields@fieldses.org>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 Documentation/filesystems/locking.rst |  4 ++++
 fs/locks.c                            | 33 ++++++++++++++++++++++++++++++---
 include/linux/fs.h                    |  3 +++
 3 files changed, 37 insertions(+), 3 deletions(-)

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
index c369841ef7d1..ca28e0e50e56 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -902,6 +902,8 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 	struct file_lock *cfl;
 	struct file_lock_context *ctx;
 	struct inode *inode = locks_inode(filp);
+	void *owner;
+	void (*func)(void);
 
 	ctx = smp_load_acquire(&inode->i_flctx);
 	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
@@ -909,12 +911,23 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
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
+		if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_expirable
+			&& (*cfl->fl_lmops->lm_lock_expirable)(cfl)) {
+			owner = cfl->fl_lmops->lm_mod_owner;
+			func = cfl->fl_lmops->lm_expire_lock;
+			__module_get(owner);
+			spin_unlock(&ctx->flc_lock);
+			(*func)();
+			module_put(owner);
+			goto retry;
 		}
+		locks_copy_conflock(fl, cfl);
+		goto out;
 	}
 	fl->fl_type = F_UNLCK;
 out:
@@ -1088,6 +1101,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	int error;
 	bool added = false;
 	LIST_HEAD(dispose);
+	void *owner;
+	void (*func)(void);
 
 	ctx = locks_get_lock_context(inode, request->fl_type);
 	if (!ctx)
@@ -1106,6 +1121,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		new_fl2 = locks_alloc_lock();
 	}
 
+retry:
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
 	/*
@@ -1117,6 +1133,17 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
 			if (!posix_locks_conflict(request, fl))
 				continue;
+			if (fl->fl_lmops && fl->fl_lmops->lm_lock_expirable
+				&& (*fl->fl_lmops->lm_lock_expirable)(fl)) {
+				owner = fl->fl_lmops->lm_mod_owner;
+				func = fl->fl_lmops->lm_expire_lock;
+				__module_get(owner);
+				spin_unlock(&ctx->flc_lock);
+				percpu_up_read(&file_rwsem);
+				(*func)();
+				module_put(owner);
+				goto retry;
+			}
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

