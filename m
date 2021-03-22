Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A70345272
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 23:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhCVWdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 18:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhCVWdj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:33:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B26A36188B;
        Mon, 22 Mar 2021 22:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616452419;
        bh=ji0LbAc4MdpqSmJYhxILX8fn2PGdJNP4JfQoqh5DMp0=;
        h=From:To:Cc:Subject:Date:From;
        b=TafXG5IGjmKLeZRt+XeqCcYVC2GFK3UyQ7uzZ3iEvmzlhcDbwPDy9IEHsJA83s55Q
         6VQao1j7lrnyx8mNY78rV/cfq4RlVYOzfgbBftZCoR2p+99rG6CZWWMXOv32wyEcYc
         7nSte+XyTxeUcxZYvZjteWxJTlgAcOLNkRTBaBgkukLiKpQ2OadpV9g8Zst/9P2dmP
         hZessJmKNZPwkZBo+Ars87Brf6ysK5c2oRyMcmnNZi1H918u+k+nti7aKXb1EYIiDx
         7jRKuhtQ/nqQsICGse+0EbUMrAY1m635cRA32pbOcVVfjl5EBCqDi0BMummNVyDGkA
         cvtPUj3rUgSKA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        James Morris <jamorris@linux.microsoft.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hfs/hfsplus: use WARN_ON for sanity check
Date:   Mon, 22 Mar 2021 23:32:40 +0100
Message-Id: <20210322223249.2632268-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc warns about a couple of instances in which a sanity check
exists but the author wasn't sure how to react to it failing,
which makes it look like a possible bug:

fs/hfsplus/inode.c: In function 'hfsplus_cat_read_inode':
fs/hfsplus/inode.c:503:37: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  503 |                         /* panic? */;
      |                                     ^
fs/hfsplus/inode.c:524:37: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  524 |                         /* panic? */;
      |                                     ^
fs/hfsplus/inode.c: In function 'hfsplus_cat_write_inode':
fs/hfsplus/inode.c:582:37: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  582 |                         /* panic? */;
      |                                     ^
fs/hfsplus/inode.c:608:37: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  608 |                         /* panic? */;
      |                                     ^
fs/hfs/inode.c: In function 'hfs_write_inode':
fs/hfs/inode.c:464:37: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  464 |                         /* panic? */;
      |                                     ^
fs/hfs/inode.c:485:37: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  485 |                         /* panic? */;
      |                                     ^

panic() is probably not the correct choice here, but a WARN_ON
seems appropriate and avoids the compile-time warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/hfs/inode.c     |  6 ++----
 fs/hfsplus/inode.c | 12 ++++--------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 3fc5cb346586..4c5610b5356f 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -460,8 +460,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 		goto out;
 
 	if (S_ISDIR(main_inode->i_mode)) {
-		if (fd.entrylength < sizeof(struct hfs_cat_dir))
-			/* panic? */;
+		WARN_ON(fd.entrylength < sizeof(struct hfs_cat_dir));
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset,
 			   sizeof(struct hfs_cat_dir));
 		if (rec.type != HFS_CDR_DIR ||
@@ -481,8 +480,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 		hfs_bnode_write(fd.bnode, &rec, fd.entryoffset,
 				sizeof(struct hfs_cat_file));
 	} else {
-		if (fd.entrylength < sizeof(struct hfs_cat_file))
-			/* panic? */;
+		WARN_ON(fd.entrylength < sizeof(struct hfs_cat_file));
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset,
 			   sizeof(struct hfs_cat_file));
 		if (rec.type != HFS_CDR_FIL ||
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 078c5c8a5156..6bcb0d935472 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -499,8 +499,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 	if (type == HFSPLUS_FOLDER) {
 		struct hfsplus_cat_folder *folder = &entry.folder;
 
-		if (fd->entrylength < sizeof(struct hfsplus_cat_folder))
-			/* panic? */;
+		WARN_ON(fd->entrylength < sizeof(struct hfsplus_cat_folder));
 		hfs_bnode_read(fd->bnode, &entry, fd->entryoffset,
 					sizeof(struct hfsplus_cat_folder));
 		hfsplus_get_perms(inode, &folder->permissions, 1);
@@ -520,8 +519,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 	} else if (type == HFSPLUS_FILE) {
 		struct hfsplus_cat_file *file = &entry.file;
 
-		if (fd->entrylength < sizeof(struct hfsplus_cat_file))
-			/* panic? */;
+		WARN_ON(fd->entrylength < sizeof(struct hfsplus_cat_file));
 		hfs_bnode_read(fd->bnode, &entry, fd->entryoffset,
 					sizeof(struct hfsplus_cat_file));
 
@@ -578,8 +576,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	if (S_ISDIR(main_inode->i_mode)) {
 		struct hfsplus_cat_folder *folder = &entry.folder;
 
-		if (fd.entrylength < sizeof(struct hfsplus_cat_folder))
-			/* panic? */;
+		WARN_ON(fd.entrylength < sizeof(struct hfsplus_cat_folder));
 		hfs_bnode_read(fd.bnode, &entry, fd.entryoffset,
 					sizeof(struct hfsplus_cat_folder));
 		/* simple node checks? */
@@ -604,8 +601,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	} else {
 		struct hfsplus_cat_file *file = &entry.file;
 
-		if (fd.entrylength < sizeof(struct hfsplus_cat_file))
-			/* panic? */;
+		WARN_ON(fd.entrylength < sizeof(struct hfsplus_cat_file));
 		hfs_bnode_read(fd.bnode, &entry, fd.entryoffset,
 					sizeof(struct hfsplus_cat_file));
 		hfsplus_inode_write_fork(inode, &file->data_fork);
-- 
2.29.2

