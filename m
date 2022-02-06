Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3254AB25C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Feb 2022 22:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242096AbiBFVb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 16:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241155AbiBFVbZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:31:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D78C061353;
        Sun,  6 Feb 2022 13:31:24 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 216JgNb5011738;
        Sun, 6 Feb 2022 21:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=4tWJY0xnAJLFgMaVTnRJZ0+CnzE3fCsuRD4Dcje3u1M=;
 b=BAVmHoCFrTw/BS3xW5hCOZCzZUc8J2Slg4vIg9I5NJzUqmpJ/Y9/BoZOY289pmHnnWd1
 bzIjeVhATKaWhokEqTkRbKtadEUw1bUARgSetuxKOvQ8IWy/lZGDj1VCAzxTbKanizql
 E1orn7V3ZDW6JGWWYxDNV+xQZw1/IOUsYKAM3A2WO1dtAnNDLDeoMeu2zZ2UThtWAQiV
 vNQp6DLqWLi9ckVSt/Bcfu7rv74d5/mE7cq6k9kW98gcZrTfVyuYnXR2W3JYG3IpkDdG
 ezPhW4VWi5/yLBM5O83dDQ2mqB8gqxYUZ+1mdkJN2YPdGzrXBJ0e/iXK0jj8i/uxGR6J mA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1hsu41dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 21:31:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 216LGHpX077107;
        Sun, 6 Feb 2022 21:31:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3e1f9ch3yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 21:31:21 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 216LVJOk103536;
        Sun, 6 Feb 2022 21:31:20 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3e1f9ch3xt-2;
        Sun, 06 Feb 2022 21:31:20 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v11 1/3] fs/lock: add new callback, lm_lock_conflict, to lock_manager_operations
Date:   Sun,  6 Feb 2022 13:31:15 -0800
Message-Id: <1644183077-2663-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1644183077-2663-1-git-send-email-dai.ngo@oracle.com>
References: <1644183077-2663-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: PkCPbH4MoyoHU32oaDg3c3ikm_RDbk-h
X-Proofpoint-GUID: PkCPbH4MoyoHU32oaDg3c3ikm_RDbk-h
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

