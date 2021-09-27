Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E247E419227
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 12:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhI0KXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 06:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233811AbhI0KXb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:23:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 106C960E73;
        Mon, 27 Sep 2021 10:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632738113;
        bh=zXIH+dCYrAWYUl8eZl54EKpoXDnxR7JoVrG+wQBxf4Y=;
        h=From:To:Cc:Subject:Date:From;
        b=fv/LAzsH8rIvVKT/pF208BdwrVp4DhlYa/RoJ4S3FOA7v+zzD8TdPuN01VkaMJC0m
         B1yqdiw9rD2ociBnfWysr+g7uLPpIRpQN7+ZpdGvosEE784XUnMSVpk3TF+crx8Gtb
         48D24OkNFxLEELFAHQ6YHl7wESqtZCCHziIeFufYq1qqRCVhq1Iga1CZ/ZI8vc0914
         +gznFifrOAuA7JJvFQdU3Y/OHF9Jdp/wJXmelXpd4cMOpokYRR33txUQnXQLSAlJ8p
         NmgdUmofRHyl2zttrT5tazXM8YsECO+/OntXlwWFleuiiyCQ6zcu7HxUTymkJe8sow
         LbSUVRl5iIkQA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] hfs/hfsplus: use WARN_ON for sanity check
Date:   Mon, 27 Sep 2021 12:21:27 +0200
Message-Id: <20210927102149.1809384-1-arnd@kernel.org>
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

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
Link: https://lore.kernel.org/all/20210322223249.2632268-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
HFS is orphaned, I hope that either Al or Andrew can pick this up.
---
 fs/hfs/inode.c     |  6 ++----
 fs/hfsplus/inode.c | 12 ++++--------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 4a95a92546a0..2a5143246282 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -462,8 +462,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 		goto out;
 
 	if (S_ISDIR(main_inode->i_mode)) {
-		if (fd.entrylength < sizeof(struct hfs_cat_dir))
-			/* panic? */;
+		WARN_ON(fd.entrylength < sizeof(struct hfs_cat_dir));
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset,
 			   sizeof(struct hfs_cat_dir));
 		if (rec.type != HFS_CDR_DIR ||
@@ -483,8 +482,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
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
index 6fef67c2a9f0..d08a8d1d40a4 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -509,8 +509,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 	if (type == HFSPLUS_FOLDER) {
 		struct hfsplus_cat_folder *folder = &entry.folder;
 
-		if (fd->entrylength < sizeof(struct hfsplus_cat_folder))
-			/* panic? */;
+		WARN_ON(fd->entrylength < sizeof(struct hfsplus_cat_folder));
 		hfs_bnode_read(fd->bnode, &entry, fd->entryoffset,
 					sizeof(struct hfsplus_cat_folder));
 		hfsplus_get_perms(inode, &folder->permissions, 1);
@@ -530,8 +529,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 	} else if (type == HFSPLUS_FILE) {
 		struct hfsplus_cat_file *file = &entry.file;
 
-		if (fd->entrylength < sizeof(struct hfsplus_cat_file))
-			/* panic? */;
+		WARN_ON(fd->entrylength < sizeof(struct hfsplus_cat_file));
 		hfs_bnode_read(fd->bnode, &entry, fd->entryoffset,
 					sizeof(struct hfsplus_cat_file));
 
@@ -588,8 +586,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	if (S_ISDIR(main_inode->i_mode)) {
 		struct hfsplus_cat_folder *folder = &entry.folder;
 
-		if (fd.entrylength < sizeof(struct hfsplus_cat_folder))
-			/* panic? */;
+		WARN_ON(fd.entrylength < sizeof(struct hfsplus_cat_folder));
 		hfs_bnode_read(fd.bnode, &entry, fd.entryoffset,
 					sizeof(struct hfsplus_cat_folder));
 		/* simple node checks? */
@@ -614,8 +611,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
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

