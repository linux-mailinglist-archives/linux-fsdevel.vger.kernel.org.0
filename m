Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29505206D50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 09:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389615AbgFXHJz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 03:09:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6313 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387849AbgFXHJz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:09:55 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0FC079EA5E84B35BDD1F;
        Wed, 24 Jun 2020 15:09:53 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Wed, 24 Jun 2020 15:09:49 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <sfrench@samba.org>, <jlayton@kernel.org>, <neilb@suse.de>,
        <neilb@suse.com>
CC:     <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] cifs: remove the retry in cifs_poxis_lock_set
Date:   Wed, 24 Jun 2020 15:10:53 +0800
Message-ID: <20200624071053.993784-1-yangerkun@huawei.com>
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
 fs/cifs/file.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 9b0f8f33f832..2c9c24b1805d 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1162,7 +1162,6 @@ cifs_posix_lock_set(struct file *file, struct file_lock *flock)
 	if ((flock->fl_flags & FL_POSIX) == 0)
 		return rc;
 
-try_again:
 	cifs_down_write(&cinode->lock_sem);
 	if (!cinode->can_cache_brlcks) {
 		up_write(&cinode->lock_sem);
@@ -1171,13 +1170,6 @@ cifs_posix_lock_set(struct file *file, struct file_lock *flock)
 
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
 
-- 
2.25.4

