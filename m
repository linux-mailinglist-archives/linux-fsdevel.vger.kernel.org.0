Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E8D211CA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 09:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgGBHYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 03:24:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6798 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727938AbgGBHYo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:24:44 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CA90E34D9277EB53D136;
        Thu,  2 Jul 2020 15:24:39 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 15:24:34 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <sfrench@samba.org>, <jlayton@kernel.org>, <neilb@suse.de>
CC:     <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2] cifs: remove the retry in cifs_poxis_lock_set
Date:   Thu, 2 Jul 2020 15:25:26 +0800
Message-ID: <20200702072526.1442138-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The caller of cifs_posix_lock_set will do retry(like
fcntl_setlk64->do_lock_file_wait) if we will wait for any file_lock.
So the retry in cifs_poxis_lock_set seems duplicated, remove it to
make a cleanup.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/cifs/file.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

v1->v2:
check FILE_LOCK_DEFERRED in cifs_setlk

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 9b0f8f33f832..be46fab4c96d 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1149,20 +1149,20 @@ cifs_posix_lock_test(struct file *file, struct file_lock *flock)
 
 /*
  * Set the byte-range lock (posix style). Returns:
- * 1) 0, if we set the lock and don't need to request to the server;
- * 2) 1, if we need to request to the server;
- * 3) <0, if the error occurs while setting the lock.
+ * 1) <0, if the error occurs while setting the lock;
+ * 2) 0, if we set the lock and don't need to request to the server;
+ * 3) FILE_LOCK_DEFERRED, if we will wait for some other file_lock;
+ * 4) FILE_LOCK_DEFERRED + 1, if we need to request to the server.
  */
 static int
 cifs_posix_lock_set(struct file *file, struct file_lock *flock)
 {
 	struct cifsInodeInfo *cinode = CIFS_I(file_inode(file));
-	int rc = 1;
+	int rc = FILE_LOCK_DEFERRED + 1;
 
 	if ((flock->fl_flags & FL_POSIX) == 0)
 		return rc;
 
-try_again:
 	cifs_down_write(&cinode->lock_sem);
 	if (!cinode->can_cache_brlcks) {
 		up_write(&cinode->lock_sem);
@@ -1171,13 +1171,6 @@ cifs_posix_lock_set(struct file *file, struct file_lock *flock)
 
 	rc = posix_lock_file(file, flock, NULL);
 	up_write(&cinode->lock_sem);
-	if (rc == FILE_LOCK_DEFERRED) {
-		rc = wait_event_interruptible(flock->fl_wait,
-					list_empty(&flock->fl_blocked_member));
-		if (!rc)
-			goto try_again;
-		locks_delete_block(flock);
-	}
 	return rc;
 }
 
@@ -1652,7 +1645,7 @@ cifs_setlk(struct file *file, struct file_lock *flock, __u32 type,
 		int posix_lock_type;
 
 		rc = cifs_posix_lock_set(file, flock);
-		if (!rc || rc < 0)
+		if (rc <= FILE_LOCK_DEFERRED)
 			return rc;
 
 		if (type & server->vals->shared_lock_type)
-- 
2.25.4

