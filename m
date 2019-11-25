Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295E41090C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 16:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfKYPMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 10:12:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbfKYPMb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:12:31 -0500
Received: from hubcapsc.localdomain (adsl-074-187-100-144.sip.mia.bellsouth.net [74.187.100.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7811B20740;
        Mon, 25 Nov 2019 15:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574694750;
        bh=dK/5+v9DW/csw7it9hEQJvhNqq/h2Yo7jkCBisKEIE8=;
        h=From:To:Cc:Subject:Date:From;
        b=YnFp4d7TRO4mJIqRfHYGt5+t3E+BgmEnu6HFfOekUZg/rnoqy1VcE1iDvlK1qyUUZ
         Qv+/Dh+GhssUYzJjhhcAJuwUA5y3YFywSrbhbSlo5MlXOxQw1i/J+dMbDQi6WyfPs7
         7EZvkV94oiknPrEjUtF3XyYFJYLQnQh75gsU4fzg=
From:   hubcap@kernel.org
To:     torvalds@linux-foundation.org
Cc:     Mike Marshall <hubcap@omnibond.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH V2] orangefs: posix open permission checking
Date:   Mon, 25 Nov 2019 10:12:14 -0500
Message-Id: <20191125151214.6514-1-hubcap@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Marshall <hubcap@omnibond.com>


Here's another approach that might not be as broken...

Orangefs has no open. Orangefs does permission
checking each time a file is accessed. The Posix
model is for permission checks to be done at open.

This patch brings orangefs-through-the-kernel closer
to Posix by marking inodes "opened" when they pass
through file_operations->open and using a UID whose
capabilities include PINT_CAP_WRITE and PINT_CAP_READ
for IO associated with open files.

I have another proof-of-concept version of this patch which sends a
message to the userspace server to add PINT_CAP_WRITE and PINT_CAP_READ
to whatever arbitrary UID is doing IO, in case using the
root UID for the entire IO is not conservative enough... this
version also requires a patch to the userspace part of Orangefs.

  "root has every possible capability - PINT_get_capabilities"

Signed-off-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/file.c            | 4 ++++
 fs/orangefs/inode.c           | 1 +
 fs/orangefs/orangefs-kernel.h | 1 +
 3 files changed, 6 insertions(+)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index a5612abc0936..a6de17889682 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -90,6 +90,8 @@ ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,
 		new_op->upcall.uid = from_kuid(&init_user_ns, wr->uid);
 		new_op->upcall.gid = from_kgid(&init_user_ns, wr->gid);
 	}
+	if (new_op->upcall.uid && (ORANGEFS_I(inode)->opened))
+		new_op->upcall.uid = 0;
 
 	gossip_debug(GOSSIP_FILE_DEBUG,
 		     "%s(%pU): offset: %llu total_size: %zd\n",
@@ -495,6 +497,7 @@ static int orangefs_file_release(struct inode *inode, struct file *file)
 		     "orangefs_file_release: called on %pD\n",
 		     file);
 
+	ORANGEFS_I(inode)->opened = 0;
 	/*
 	 * remove all associated inode pages from the page cache and
 	 * readahead cache (if any); this forces an expensive refresh of
@@ -618,6 +621,7 @@ static int orangefs_lock(struct file *filp, int cmd, struct file_lock *fl)
 static int orangefs_file_open(struct inode * inode, struct file *file)
 {
 	file->private_data = NULL;
+	ORANGEFS_I(inode)->opened = 1;
 	return generic_file_open(inode, file);
 }
 
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index efb12197da18..dc6ced95e888 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -1060,6 +1060,7 @@ static int orangefs_set_inode(struct inode *inode, void *data)
 	hash_init(ORANGEFS_I(inode)->xattr_cache);
 	ORANGEFS_I(inode)->mapping_time = jiffies - 1;
 	ORANGEFS_I(inode)->bitlock = 0;
+	ORANGEFS_I(inode)->opened = 0;
 	return 0;
 }
 
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 34a6c99fa29b..0ce4a6af716d 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -198,6 +198,7 @@ struct orangefs_inode_s {
 	kuid_t attr_uid;
 	kgid_t attr_gid;
 	unsigned long bitlock;
+	int opened;
 
 	DECLARE_HASHTABLE(xattr_cache, 4);
 };
-- 
2.20.1

