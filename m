Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F0D3BA737
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jul 2021 06:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhGCEhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jul 2021 00:37:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61716 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbhGCEhD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jul 2021 00:37:03 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1634VJlA003589;
        Sat, 3 Jul 2021 04:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ku2u1sh21qAreNKCI4Mk/+99AZ1MCciUFgGvlXoI7xA=;
 b=dHuM6bE8gQdtPnmgroYWXGWuvMRzmnXbFD0KWF235pKuRFhKwJGL73bguFgbNPxQtTXJ
 +7j3qLevA312Un5Kcbd4VEtGyzZ8jHwrVH12Fb68707Z4O78099XHBc1/Xd8H5B8fT9I
 DsDY9IDqnYLzE6I6Xv3vxuzDPmMoF7ER716vsxRR4qaNz9UajDkLYFp2Hf0zrc4VBc8o
 JPzfTyXiMINcyPegggtupwsfcb9XNWQGvdPR9Kqktb62xKDSTsjDEnuDjiRmC/iirBLG
 kNm+E45ZI/rtqyuUaEN4ucpS1OLZiTu05IaISvcSbKgHIMpSBqVslT/WS9EtCoF6Voft bA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jeacg2qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jul 2021 04:34:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1634UFVA150250;
        Sat, 3 Jul 2021 04:34:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 39jf7k3v0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jul 2021 04:34:28 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1634YQ5j156774;
        Sat, 3 Jul 2021 04:34:27 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3020.oracle.com with ESMTP id 39jf7k3uyg-2;
        Sat, 03 Jul 2021 04:34:27 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 1/2] fs/lock: add new callback, lm_expire_lock, to lock_manager_operations.
Date:   Sat,  3 Jul 2021 00:34:19 -0400
Message-Id: <20210703043420.84549-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20210703043420.84549-1-dai.ngo@oracle.com>
References: <20210703043420.84549-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oPzuy_z4E-qloS1qJk76nAG2Fs5QMO0Z
X-Proofpoint-ORIG-GUID: oPzuy_z4E-qloS1qJk76nAG2Fs5QMO0Z
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

Lock manager, such as NFSv4 courteous server, can use this callback to
resolve conflict by destroying lock owner, or the NFSv4 courtesy client
(client that has expired but allowed to maintains its states) that owns
the lock.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/locks.c         | 10 ++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 74b2a1dfe8d8..d712fe2ee530 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1140,6 +1140,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	int error;
 	bool added = false;
 	LIST_HEAD(dispose);
+	bool ret;
 
 	ctx = locks_get_lock_context(inode, request->fl_type);
 	if (!ctx)
@@ -1166,9 +1167,18 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
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
index c3c88fdb9b2a..ee7407f64e27 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1025,6 +1025,7 @@ struct lock_manager_operations {
 	int (*lm_change)(struct file_lock *, int, struct list_head *);
 	void (*lm_setup)(struct file_lock *, void **);
 	bool (*lm_breaker_owns_lease)(struct file_lock *);
+	bool (*lm_expire_lock)(struct file_lock *fl, bool testonly);
 };
 
 struct lock_manager {
-- 
2.9.5

