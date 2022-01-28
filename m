Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E623A4A0100
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 20:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344273AbiA1TkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 14:40:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30290 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344147AbiA1TkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:40:00 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SIi0ff032646;
        Fri, 28 Jan 2022 19:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=2sS1wkdpPi8hqyth/o0IYJ7+3AIJhshz50LoLfajj5M=;
 b=EcRnbqB0So7dMfC8fE5yzsqTqbgfV14XOUKWedcrRx23ADBKjAABdXE5vtpbMwuuhFby
 rvn5TBOJt6g3CXTXJwrHr2Qkm7ADhTlegAWYQi5F6YbKBMjJVfwhjkKc+B2hBF8K912e
 jyMzUfNcIwXkrbUAljWyN1LxS1VVuuVToK8IDZyrL25LFWkI9/+RSWI39TR/zg35ThFr
 Xm0ue/JeWHAZnKPHKKdjrEzAqJ8wD+aNUOxaARLyp09837q3VRiA3EsXs7gnMf36klGU
 QN0ZKQ+xqa5qtodzzRgWax0mX4HE5BMvovXEl4SMzNJIRkj1mDucjfGsKgGqWtVjw45n oQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duwrxmaqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 19:39:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SJR9jO192126;
        Fri, 28 Jan 2022 19:39:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3dr726eqwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 19:39:55 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20SJdsjM038315;
        Fri, 28 Jan 2022 19:39:55 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by userp3030.oracle.com with ESMTP id 3dr726eqv5-2;
        Fri, 28 Jan 2022 19:39:55 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 1/3] fs/lock: add new callback, lm_expire_lock, to lock_manager_operations
Date:   Fri, 28 Jan 2022 11:39:31 -0800
Message-Id: <1643398773-29149-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1643398773-29149-1-git-send-email-dai.ngo@oracle.com>
References: <1643398773-29149-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: 018YHAd9NSw6lKZAvwOhgyeXmG5ENiHG
X-Proofpoint-ORIG-GUID: 018YHAd9NSw6lKZAvwOhgyeXmG5ENiHG
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add new callback, lm_expire_lock, to lock_manager_operations to allow
the lock manager to take appropriate action to resolve the lock conflict
if possible. The callback takes 1 argument, the file_lock of the blocker
and returns true if the conflict was resolved else returns false. Note
that the lock manager has to be able to resolve the conflict while
the spinlock flc_lock is held.

Lock manager, such as NFSv4 courteous server, uses this callback to
resolve conflict by destroying lock owner, or the NFSv4 courtesy client
(client that has expired but allowed to maintains its states) that owns
the lock.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 Documentation/filesystems/locking.rst |  2 ++
 fs/locks.c                            | 14 ++++++++++----
 include/linux/fs.h                    |  1 +
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index d36fe79167b3..57ce0fbc8ab1 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -439,6 +439,7 @@ prototypes::
 	void (*lm_break)(struct file_lock *); /* break_lease callback */
 	int (*lm_change)(struct file_lock **, int);
 	bool (*lm_breaker_owns_lease)(struct file_lock *);
+	bool (*lm_lock_conflict)(struct file_lock *);
 
 locking rules:
 
@@ -450,6 +451,7 @@ lm_grant:		no		no			no
 lm_break:		yes		no			no
 lm_change		yes		no			no
 lm_breaker_owns_lease:	no		no			no
+lm_lock_conflict:       no		no			no
 ======================	=============	=================	=========
 
 buffer_head
diff --git a/fs/locks.c b/fs/locks.c
index 0fca9d680978..052b42cc7f25 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -853,10 +853,13 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 
 	spin_lock(&ctx->flc_lock);
 	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
-		if (posix_locks_conflict(fl, cfl)) {
-			locks_copy_conflock(fl, cfl);
-			goto out;
-		}
+		if (!posix_locks_conflict(fl, cfl))
+			continue;
+		if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_conflict &&
+			!cfl->fl_lmops->lm_lock_conflict(cfl))
+			continue;
+		locks_copy_conflock(fl, cfl);
+		goto out;
 	}
 	fl->fl_type = F_UNLCK;
 out:
@@ -1059,6 +1062,9 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
 			if (!posix_locks_conflict(request, fl))
 				continue;
+			if (fl->fl_lmops && fl->fl_lmops->lm_lock_conflict &&
+				!fl->fl_lmops->lm_lock_conflict(fl))
+				continue;
 			if (conflock)
 				locks_copy_conflock(conflock, fl);
 			error = -EAGAIN;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbf812ce89a8..21cb7afe2d63 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1068,6 +1068,7 @@ struct lock_manager_operations {
 	int (*lm_change)(struct file_lock *, int, struct list_head *);
 	void (*lm_setup)(struct file_lock *, void **);
 	bool (*lm_breaker_owns_lease)(struct file_lock *);
+	bool (*lm_lock_conflict)(struct file_lock *cfl);
 };
 
 struct lock_manager {
-- 
2.9.5

