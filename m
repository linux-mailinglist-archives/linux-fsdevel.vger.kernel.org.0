Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF540E9C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 20:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbhIPSY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 14:24:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55934 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349529AbhIPSXr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:23:47 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GIDHwN026756;
        Thu, 16 Sep 2021 18:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=gUUL68PzT1tsHqbh2Eu96RtT1DlD2y4rsvPdvYDuQH0=;
 b=1FOEvpU1TFkPYNy+Mau8Z/a12f+P4pVi+GJ0qebkTCNZ8NeskOTWVMwLWUzr4CGgGAZI
 tCeEpAY6IE0Br/bzSH2T1q5qURd2RWcXV2EcP7pTOOVTyFENOcjfH3SAl6bf52vaKlPe
 5RkAP1MC0q4j7mLB0Vh2+Z/D1/RGkWAi0t26mjN4qrWVfH900Wl+YQuPlGAlaH46GtU4
 eBIRxoh3lOb4ts1SuEv9H2hqvphRr11IKUz5DNoXmcxGOfa0PRTON7x2yX1xixYdRbF+
 G63dNgGo7gleRwyM/ZbJYNyulOKWvztVbCsuYHib3SKlaG5+wdTifG2FV6v7jCC8+gWl NQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=gUUL68PzT1tsHqbh2Eu96RtT1DlD2y4rsvPdvYDuQH0=;
 b=XVHeflLqxovsS4YdnOA5MTR+zFZnPi3/4TrPXFlsQaKQ3LW4FrZr8JDLGDs79qnFqmlK
 INCQpsx6UVUmWDlitVcfu65WSzlVlVtGnLyaMY6s0eHEM3NpO/4H/SOjCJ0nwyHbwmwA
 78bEONJ1J7b9xGu5QSd3Z4u6daKxuUi9DdnUx0+MEgD7mmgxrVo9ejGn2n3d7d/n2vHt
 TlP9UsFJXr63SbeuDn+n/ZZZkARTdXrwZeJlN4TIvXKQTVEruWCWOTXT/+hEvl87eV9y
 6c6l/M5WKEYZWRmWstfzZi/2XvHNPmLzxJ4qJ5ZYh37IsxZBLd+YLeVA/LGapro+apwa Gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3jy7mqpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 18:22:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GIAWhk149842;
        Thu, 16 Sep 2021 18:22:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3b0m99rpf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 18:22:19 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 18GIK46c182960;
        Thu, 16 Sep 2021 18:22:19 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 3b0m99rpeg-2;
        Thu, 16 Sep 2021 18:22:19 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/3] fs/lock: add new callback, lm_expire_lock, to lock_manager_operations
Date:   Thu, 16 Sep 2021 14:22:10 -0400
Message-Id: <20210916182212.81608-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20210916182212.81608-1-dai.ngo@oracle.com>
References: <20210916182212.81608-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: plUQJPPn6Ln-iKjlWym-ja-LavCl6uLP
X-Proofpoint-ORIG-GUID: plUQJPPn6Ln-iKjlWym-ja-LavCl6uLP
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
 fs/locks.c         | 26 +++++++++++++++++++++++---
 include/linux/fs.h |  1 +
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 3d6fb4ae847b..893b348a2d57 100644
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
@@ -1166,9 +1177,18 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
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
+				ret = fl->fl_lmops->lm_expire_lock(fl, 0);
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

