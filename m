Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0F6489F99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 19:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242458AbiAJSvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 13:51:23 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46964 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242474AbiAJSvS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:51:18 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AIlSlP001336;
        Mon, 10 Jan 2022 18:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=DweiOUgl/hkOGesDpgQ+/pDf8TBMxj3hc8JKRsSd/zQ=;
 b=PYz25vHQtr1wUhW3jZFPbEylPBjvYB4SXCZwL9XOQyq8oB5brTo+6J4sVpw+VlbpD4Xu
 WkPaW5ecTpkNAcsRoKi90r6FIQDKIOvPs4A3xsCUfGLQW+PuA/cdQLGo50+QRCVIaJla
 dnCp/x/Pqd2V5QeDuWqcnvSvn1LSycdfFTH4nXBa3WMU0uZHGaw3qevzGmKSExuINJot
 HvhKIvgyA4vkKA7e+amc2nORozfTLs4rpRt1KNrDyzpYioeT7Q2YZxhBSSdUvh0O9/bC
 iOFKBXp6rC6n7GEACy22kNk2a3dYfxcEHlOwky7YHfWBcj1Xi7UMPg24WwBBXPyPZAhk nA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn748y9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 18:51:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AIk7Br115835;
        Mon, 10 Jan 2022 18:51:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3deyqvubdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 18:51:12 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20AIpBum140178;
        Mon, 10 Jan 2022 18:51:11 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by userp3030.oracle.com with ESMTP id 3deyqvubcm-2;
        Mon, 10 Jan 2022 18:51:11 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v9 1/2] fs/lock: add new callback, lm_expire_lock, to lock_manager_operations
Date:   Mon, 10 Jan 2022 10:50:52 -0800
Message-Id: <1641840653-23059-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641840653-23059-1-git-send-email-dai.ngo@oracle.com>
References: <1641840653-23059-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: sD_JpfSElReBvfXbf17yIVY4irReKXMW
X-Proofpoint-GUID: sD_JpfSElReBvfXbf17yIVY4irReKXMW
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
 fs/locks.c         | 14 ++++++++++----
 include/linux/fs.h |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 3d6fb4ae847b..5844fd29560d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -963,10 +963,13 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 
 	spin_lock(&ctx->flc_lock);
 	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
-		if (posix_locks_conflict(fl, cfl)) {
-			locks_copy_conflock(fl, cfl);
-			goto out;
-		}
+		if (!posix_locks_conflict(fl, cfl))
+			continue;
+		if (cfl->fl_lmops && cfl->fl_lmops->lm_expire_lock &&
+			cfl->fl_lmops->lm_expire_lock(cfl))
+			continue;
+		locks_copy_conflock(fl, cfl);
+		goto out;
 	}
 	fl->fl_type = F_UNLCK;
 out:
@@ -1169,6 +1172,9 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
 			if (!posix_locks_conflict(request, fl))
 				continue;
+			if (fl->fl_lmops && fl->fl_lmops->lm_expire_lock &&
+				fl->fl_lmops->lm_expire_lock(fl))
+				continue;
 			if (conflock)
 				locks_copy_conflock(conflock, fl);
 			error = -EAGAIN;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e7a633353fd2..0f70e0b39834 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1071,6 +1071,7 @@ struct lock_manager_operations {
 	int (*lm_change)(struct file_lock *, int, struct list_head *);
 	void (*lm_setup)(struct file_lock *, void **);
 	bool (*lm_breaker_owns_lease)(struct file_lock *);
+	bool (*lm_expire_lock)(struct file_lock *cfl);
 };
 
 struct lock_manager {
-- 
2.9.5

