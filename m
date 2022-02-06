Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64BF4AB1E0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Feb 2022 21:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242621AbiBFUCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 15:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiBFUCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 15:02:16 -0500
X-Greylist: delayed 3450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 12:02:15 PST
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E17C06173B;
        Sun,  6 Feb 2022 12:02:15 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 216GWa3E026188;
        Sun, 6 Feb 2022 19:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=4tWJY0xnAJLFgMaVTnRJZ0+CnzE3fCsuRD4Dcje3u1M=;
 b=C71XcyOPptutJXLxA/mViZOuewbxZescZsclb7TwOIvhE3ujT9o9x9v/ubUOigYiPw4k
 9DUFaoyD5BJI26ygxA6577IlsruMBFTqAXeMSCoP0DNd2NeoANYtWZokqoHeZVkpKbr3
 94i5h31Dn1I1JZCcZGDztAPtufHcbSkkxa+xWAlvSbNm8lSvGatB4XYfhxpQrL2Zh1EB
 Ed5fPFVk27ETg2dgoZZz4tBg263WZu7IVE+JNN6P5FxOOLJAciYeHdrXzc16DWjz1z0L
 EX0T0Ngm5151MQKWS0Z93gO7KaNjBl57Ce6SfrGqj5t9lSr8Sl41EOB33Ta1+9XBjbYG bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1h4b3nqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 19:04:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 216J1vk3035726;
        Sun, 6 Feb 2022 19:04:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3e1f9ceduq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 19:04:40 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 216J4dFT044049;
        Sun, 6 Feb 2022 19:04:40 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3e1f9cedtx-2;
        Sun, 06 Feb 2022 19:04:40 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 1/3] fs/lock: add new callback, lm_lock_conflict, to lock_manager_operations
Date:   Sun,  6 Feb 2022 11:04:28 -0800
Message-Id: <1644174270-20681-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1644174270-20681-1-git-send-email-dai.ngo@oracle.com>
References: <1644174270-20681-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: 1kj4dpKw1suPRVgRctJFllDtamoJnsat
X-Proofpoint-ORIG-GUID: 1kj4dpKw1suPRVgRctJFllDtamoJnsat
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add new callback, lm_lock_conflict, to lock_manager_operations to allow
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
 include/linux/fs.h                    |  8 ++++++++
 3 files changed, 20 insertions(+), 4 deletions(-)

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
index bbf812ce89a8..726d0005e32f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1068,6 +1068,14 @@ struct lock_manager_operations {
 	int (*lm_change)(struct file_lock *, int, struct list_head *);
 	void (*lm_setup)(struct file_lock *, void **);
 	bool (*lm_breaker_owns_lease)(struct file_lock *);
+	/*
+	 * This callback function is called after a lock conflict is
+	 * detected. This allows the lock manager of the lock that
+	 * causes the conflict to see if the conflict can be resolved
+	 * somehow. If it can then this callback returns false; the
+	 * conflict was resolved, else returns true.
+	 */
+	bool (*lm_lock_conflict)(struct file_lock *cfl);
 };
 
 struct lock_manager {
-- 
2.9.5

