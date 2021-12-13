Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8914732DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 18:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241288AbhLMRYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 12:24:36 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1532 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236018AbhLMRYd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:24:33 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDG0dhP018126;
        Mon, 13 Dec 2021 17:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=8bKxMld2fSR7u8bDJG93oyV8/YH0MRQpMeV1wCMI6FI=;
 b=uvWFNm5icJVrDibS3ktKJ99c98JOpwKLcN3I7Bn5FcxORUTpvdX4CHWt056A66AcNVlN
 yWc+pATbt187AVVyME61hAcDEOL/Ce32F3nLrjAVYLW2sYl4BlrCtIFCXC9q3UzjxF2v
 WpSWddLHbs1KGaRFhoL1Vb+XMeDxqioeiyUJkhwyP9yJ5eiLW3rkScCHoYdFKkPKk4Cz
 Nw2BFQi9zmr1aBD/4IMtq4Y1SFxRrDAyJIfs5/8ArJxIjnSd0XRyWQNpvGMrEZ3mnCd4
 G6CnQDAqZ10+vlwslB8CmmHsY2nUaDbR1qZwjSLfmjbefkXGceWoR+GZDfPeiYAt/out iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3mrs8tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 17:24:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDHF2ed130602;
        Mon, 13 Dec 2021 17:24:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3cvnendvu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 17:24:28 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1BDHOQ0P168505;
        Mon, 13 Dec 2021 17:24:27 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3020.oracle.com with ESMTP id 3cvnendvt7-2;
        Mon, 13 Dec 2021 17:24:27 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v8 1/2] fs/lock: add new callback, lm_expire_lock, to lock_manager_operations
Date:   Mon, 13 Dec 2021 12:24:22 -0500
Message-Id: <20211213172423.49021-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20211213172423.49021-1-dai.ngo@oracle.com>
References: <20211213172423.49021-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cW3sJbN8xsRDDaYIBI2bgaxTGz3MwDwg
X-Proofpoint-GUID: cW3sJbN8xsRDDaYIBI2bgaxTGz3MwDwg
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add new callback, lm_expire_lock, to lock_manager_operations to allow
the lock manager to take appropriate action to resolve the lock conflict
if possible. The callback takes 2 arguments, file_lock of the blocker
and a testonly flag:

testonly = 1  check and return lock manager's private data if lock conflict
              can be resolved else return NULL.
testonly = 0  resolve the conflict if possible, return true if conflict
              was resolved esle return false.

Lock manager, such as NFSv4 courteous server, uses this callback to
resolve conflict by destroying lock owner, or the NFSv4 courtesy client
(client that has expired but allowed to maintains its states) that owns
the lock.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/locks.c         | 40 +++++++++++++++++++++++++++++++++++++---
 include/linux/fs.h |  1 +
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 3d6fb4ae847b..5f3ea40ce2aa 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -952,8 +952,11 @@ void
 posix_test_lock(struct file *filp, struct file_lock *fl)
 {
 	struct file_lock *cfl;
+	struct file_lock *checked_cfl = NULL;
 	struct file_lock_context *ctx;
 	struct inode *inode = locks_inode(filp);
+	void *res_data;
+	void *(*func)(void *priv, bool testonly);
 
 	ctx = smp_load_acquire(&inode->i_flctx);
 	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
@@ -962,11 +965,24 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 	}
 
 	spin_lock(&ctx->flc_lock);
+retry:
 	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
-		if (posix_locks_conflict(fl, cfl)) {
-			locks_copy_conflock(fl, cfl);
-			goto out;
+		if (!posix_locks_conflict(fl, cfl))
+			continue;
+		if (checked_cfl != cfl && cfl->fl_lmops &&
+				cfl->fl_lmops->lm_expire_lock) {
+			res_data = cfl->fl_lmops->lm_expire_lock(cfl, true);
+			if (res_data) {
+				func = cfl->fl_lmops->lm_expire_lock;
+				spin_unlock(&ctx->flc_lock);
+				func(res_data, false);
+				spin_lock(&ctx->flc_lock);
+				checked_cfl = cfl;
+				goto retry;
+			}
 		}
+		locks_copy_conflock(fl, cfl);
+		goto out;
 	}
 	fl->fl_type = F_UNLCK;
 out:
@@ -1136,10 +1152,13 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	struct file_lock *new_fl2 = NULL;
 	struct file_lock *left = NULL;
 	struct file_lock *right = NULL;
+	struct file_lock *checked_fl = NULL;
 	struct file_lock_context *ctx;
 	int error;
 	bool added = false;
 	LIST_HEAD(dispose);
+	void *res_data;
+	void *(*func)(void *priv, bool testonly);
 
 	ctx = locks_get_lock_context(inode, request->fl_type);
 	if (!ctx)
@@ -1166,9 +1185,24 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	 * blocker's list of waiters and the global blocked_hash.
 	 */
 	if (request->fl_type != F_UNLCK) {
+retry:
 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
 			if (!posix_locks_conflict(request, fl))
 				continue;
+			if (checked_fl != fl && fl->fl_lmops &&
+					fl->fl_lmops->lm_expire_lock) {
+				res_data = fl->fl_lmops->lm_expire_lock(fl, true);
+				if (res_data) {
+					func = fl->fl_lmops->lm_expire_lock;
+					spin_unlock(&ctx->flc_lock);
+					percpu_up_read(&file_rwsem);
+					func(res_data, false);
+					percpu_down_read(&file_rwsem);
+					spin_lock(&ctx->flc_lock);
+					checked_fl = fl;
+					goto retry;
+				}
+			}
 			if (conflock)
 				locks_copy_conflock(conflock, fl);
 			error = -EAGAIN;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e7a633353fd2..8cb910c3a394 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1071,6 +1071,7 @@ struct lock_manager_operations {
 	int (*lm_change)(struct file_lock *, int, struct list_head *);
 	void (*lm_setup)(struct file_lock *, void **);
 	bool (*lm_breaker_owns_lease)(struct file_lock *);
+	void *(*lm_expire_lock)(void *priv, bool testonly);
 };
 
 struct lock_manager {
-- 
2.9.5

