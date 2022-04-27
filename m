Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E299E5113E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 10:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbiD0I4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 04:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiD0I4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:56:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207791AFF6C;
        Wed, 27 Apr 2022 01:53:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R8j2tx015530;
        Wed, 27 Apr 2022 08:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=Ng5lP8dLKMbMbAC0I5xdRomFXGbCQ8hsKYIRVJCyaew=;
 b=MdvSCSoQxl6o6F/l9X++7eFe3r/vlKnujbiYvROgp+sjywYnKJAzxRcUcgAqGWth5wHT
 c0fWB9Kb5aPbK2Ksoj3KdYUrhbX2VkQ/vvubb8K77h0rgedZjRO8PP0BKDs3c3+qVRVd
 uAf2oZX/kC+FXCRHVyb4LDsAXpZOUw2LU8cT/uix7ZGXgAQNi+LuwoaFJCRHi2/tddhL
 Lc5VguaYAyueWWVcg0L09kSCPjR/7td/IWGa0Y/0Oba1rz+XGfl5NKlbSrvfV07czfLK
 pw5UXWuGuhdUiTCesY/mgW6GpObvPJMJD2I+rJn3noIPBR52XnYGjz5Yy07UjF+twdtU KQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9arcjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 08:53:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23R8kYZZ001371;
        Wed, 27 Apr 2022 08:53:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ykfxqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 08:53:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 23R8lih2005778;
        Wed, 27 Apr 2022 08:53:03 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ykfxme-6;
        Wed, 27 Apr 2022 08:53:03 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v22 5/7] fs/lock: add 2 callbacks to lock_manager_operations to resolve conflict
Date:   Wed, 27 Apr 2022 01:52:51 -0700
Message-Id: <1651049573-29552-6-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1651049573-29552-1-git-send-email-dai.ngo@oracle.com>
References: <1651049573-29552-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: UR59RzxAhVwdLKBsCRqWnqaeso5Z2Kz6
X-Proofpoint-GUID: UR59RzxAhVwdLKBsCRqWnqaeso5Z2Kz6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

lm_lock_expirable checks and returns a pointer to an opaque data if
the lock conflict can be resolved otherwise returns NULL. This callback
must be called with the flc_lock held so it can not block.

lm_expire_lock is called with the returned value from lm_lock_expirable
to resolve the conflict. This callback is called without the flc_lock
held since it's allowed to block. Upon returning from this callback, the
lock conflict should be resolved and the caller is expected to restart
the conflict check from the beginnning of the list.

Lock manager, such as NFSv4 courteous server, uses this callback to
resolve conflict by destroying lock owner, or the NFSv4 courtesy client
(client that has expired but allowed to maintains its states) that owns
the lock.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 Documentation/filesystems/locking.rst |  2 ++
 fs/locks.c                            | 44 +++++++++++++++++++++++++++++++----
 include/linux/fs.h                    |  3 +++
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index c26d854275a0..fdf3cd82b611 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -439,6 +439,8 @@ lm_grant:		no		no			no
 lm_break:		yes		no			no
 lm_change		yes		no			no
 lm_breaker_owns_lease:	yes     	no			no
+lm_lock_expirable	yes		no			no
+lm_expire_lock		no		no			yes
 ======================	=============	=================	=========
 
 buffer_head
diff --git a/fs/locks.c b/fs/locks.c
index c369841ef7d1..283645f52c2e 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -896,6 +896,36 @@ static bool flock_locks_conflict(struct file_lock *caller_fl,
 	return locks_conflict(caller_fl, sys_fl);
 }
 
+static bool
+resolve_lock_conflict_locked(struct file_lock_context *ctx,
+			struct file_lock *cfl, bool rwsem)
+{
+	void *ret, *owner;
+	void (*func)(void *priv);
+
+	if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_expirable &&
+				cfl->fl_lmops->lm_expire_lock) {
+		ret = (*cfl->fl_lmops->lm_lock_expirable)(cfl);
+		if (!ret)
+			return false;
+		owner = cfl->fl_lmops->lm_mod_owner;
+		if (!owner)
+			return false;
+		func = cfl->fl_lmops->lm_expire_lock;
+		__module_get(owner);
+		if (rwsem)
+			percpu_up_read(&file_rwsem);
+		spin_unlock(&ctx->flc_lock);
+		(*func)(ret);
+		module_put(owner);
+		if (rwsem)
+			percpu_down_read(&file_rwsem);
+		spin_lock(&ctx->flc_lock);
+		return true;
+	}
+	return false;
+}
+
 void
 posix_test_lock(struct file *filp, struct file_lock *fl)
 {
@@ -910,11 +940,14 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 	}
 
 	spin_lock(&ctx->flc_lock);
+retry:
 	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
-		if (posix_locks_conflict(fl, cfl)) {
-			locks_copy_conflock(fl, cfl);
-			goto out;
-		}
+		if (!posix_locks_conflict(fl, cfl))
+			continue;
+		if (resolve_lock_conflict_locked(ctx, cfl, false))
+			goto retry;
+		locks_copy_conflock(fl, cfl);
+		goto out;
 	}
 	fl->fl_type = F_UNLCK;
 out:
@@ -1108,6 +1141,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
+retry:
 	/*
 	 * New lock request. Walk all POSIX locks and look for conflicts. If
 	 * there are any, either return error or put the request on the
@@ -1117,6 +1151,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
 			if (!posix_locks_conflict(request, fl))
 				continue;
+			if (resolve_lock_conflict_locked(ctx, fl, true))
+				goto retry;
 			if (conflock)
 				locks_copy_conflock(conflock, fl);
 			error = -EAGAIN;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b8ed7f974fb4..0830176a1aa8 100644
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
+	void *(*lm_lock_expirable)(struct file_lock *cfl);
+	void (*lm_expire_lock)(void *data);
 };
 
 struct lock_manager {
-- 
2.9.5

