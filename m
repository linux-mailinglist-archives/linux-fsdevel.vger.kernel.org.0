Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CA446A38B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 18:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345430AbhLFSDY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 13:03:24 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21510 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344292AbhLFSDY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:03:24 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Gna7f019187;
        Mon, 6 Dec 2021 17:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=1J/hPwL1BMfdPatV95xoYfaLtBXXyjmC3fdunj0fm8E=;
 b=LliR90sqBm/lofpUAKF+4Dr6za6wX8znQ7HyGnRQAu8eULX1wMWD2hQzfSGg0IeNmpO1
 vLV6CRu7xnKsAUt9I3xjIb/H6wiu5DA4ta2/3hW3jSddKQpa2edhGkOzj+36odM2T4Ig
 yfZS2YNPOFZuuwO80uR0IpNU7nms14ioi1RQISo7VwB2EgUaMgvI9wZPZPiuzEipSFHj
 p6PAirlPAA1uSCD5r6PiAcTLDW5Ho5MXB1NqmmZPKzbOEt/yzRlj4zBdG/JegYfISOSt
 0FlGqiMAokVDAvce3+9irbKgWUZS45FSuTuc4hjJewwfpJ7A30//VXXFMoYs84H1Oqan mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csd2yasmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 17:59:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6HudpZ072356;
        Mon, 6 Dec 2021 17:59:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3cr1smf1sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 17:59:51 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1B6HxnaZ081234;
        Mon, 6 Dec 2021 17:59:50 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3020.oracle.com with ESMTP id 3cr1smf1rt-2;
        Mon, 06 Dec 2021 17:59:50 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v6 1/2] fs/lock: add new callback, lm_expire_lock, to lock_manager_operations
Date:   Mon,  6 Dec 2021 12:59:41 -0500
Message-Id: <20211206175942.47326-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20211206175942.47326-1-dai.ngo@oracle.com>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -EwzLk3vG1Gkr9k7cgB1M_9VYuWUxITq
X-Proofpoint-ORIG-GUID: -EwzLk3vG1Gkr9k7cgB1M_9VYuWUxITq
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add new callback, lm_expire_lock, to lock_manager_operations to allow
the lock manager to take appropriate action to resolve the lock conflict
if possible. The callback takes 2 arguments, file_lock of the blocker
and a testonly flag:

testonly = 1  check and return true if lock conflict can be resolved
              else return false.
testonly = 0  resolve the conflict if possible, return true if conflict
              was resolved esle return false.

Lock manager, such as NFSv4 courteous server, uses this callback to
resolve conflict by destroying lock owner, or the NFSv4 courtesy client
(client that has expired but allowed to maintains its states) that owns
the lock.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/locks.c         | 28 +++++++++++++++++++++++++---
 include/linux/fs.h |  1 +
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 3d6fb4ae847b..0fef0a6322c7 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -954,6 +954,7 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 	struct file_lock *cfl;
 	struct file_lock_context *ctx;
 	struct inode *inode = locks_inode(filp);
+	bool ret;
 
 	ctx = smp_load_acquire(&inode->i_flctx);
 	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
@@ -962,11 +963,20 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 	}
 
 	spin_lock(&ctx->flc_lock);
+retry:
 	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
-		if (posix_locks_conflict(fl, cfl)) {
-			locks_copy_conflock(fl, cfl);
-			goto out;
+		if (!posix_locks_conflict(fl, cfl))
+			continue;
+		if (cfl->fl_lmops && cfl->fl_lmops->lm_expire_lock &&
+				cfl->fl_lmops->lm_expire_lock(cfl, 1)) {
+			spin_unlock(&ctx->flc_lock);
+			ret = cfl->fl_lmops->lm_expire_lock(cfl, 0);
+			spin_lock(&ctx->flc_lock);
+			if (ret)
+				goto retry;
 		}
+		locks_copy_conflock(fl, cfl);
+		goto out;
 	}
 	fl->fl_type = F_UNLCK;
 out:
@@ -1140,6 +1150,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	int error;
 	bool added = false;
 	LIST_HEAD(dispose);
+	bool ret;
 
 	ctx = locks_get_lock_context(inode, request->fl_type);
 	if (!ctx)
@@ -1166,9 +1177,20 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	 * blocker's list of waiters and the global blocked_hash.
 	 */
 	if (request->fl_type != F_UNLCK) {
+retry:
 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
 			if (!posix_locks_conflict(request, fl))
 				continue;
+			if (fl->fl_lmops && fl->fl_lmops->lm_expire_lock &&
+					fl->fl_lmops->lm_expire_lock(fl, 1)) {
+				spin_unlock(&ctx->flc_lock);
+				percpu_up_read(&file_rwsem);
+				ret = fl->fl_lmops->lm_expire_lock(fl, 0);
+				percpu_down_read(&file_rwsem);
+				spin_lock(&ctx->flc_lock);
+				if (ret)
+					goto retry;
+			}
 			if (conflock)
 				locks_copy_conflock(conflock, fl);
 			error = -EAGAIN;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e7a633353fd2..1a76b6451398 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1071,6 +1071,7 @@ struct lock_manager_operations {
 	int (*lm_change)(struct file_lock *, int, struct list_head *);
 	void (*lm_setup)(struct file_lock *, void **);
 	bool (*lm_breaker_owns_lease)(struct file_lock *);
+	bool (*lm_expire_lock)(struct file_lock *fl, bool testonly);
 };
 
 struct lock_manager {
-- 
2.9.5

