Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3884339BC7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 05:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhCMElB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 23:41:01 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33552 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhCMEkf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:40:35 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKw2j-005O0J-Q5; Sat, 13 Mar 2021 04:38:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Richard Weinberger <richard@nod.at>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 14/15] 9p: missing chunk of "fs/9p: Don't update file type when updating file attributes"
Date:   Sat, 13 Mar 2021 04:38:23 +0000
Message-Id: <20210313043824.1283821-14-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210313043824.1283821-1-viro@zeniv.linux.org.uk>
References: <YExBLBEbJRXDV19F@zeniv-ca.linux.org.uk>
 <20210313043824.1283821-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In commit 45089142b149 Aneesh had missed one (admittedly, very unlikely
to hit) case in v9fs_stat2inode_dotl().  However, the same considerations
apply there as well - we have no business whatsoever to change ->i_rdev
or the file type.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/9p/vfs_inode_dotl.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index df0b87b05c42..e1c0240b51c0 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -663,14 +663,10 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
 		if (stat->st_result_mask & P9_STATS_NLINK)
 			set_nlink(inode, stat->st_nlink);
 		if (stat->st_result_mask & P9_STATS_MODE) {
-			inode->i_mode = stat->st_mode;
-			if ((S_ISBLK(inode->i_mode)) ||
-						(S_ISCHR(inode->i_mode)))
-				init_special_inode(inode, inode->i_mode,
-								inode->i_rdev);
+			mode = stat->st_mode & S_IALLUGO;
+			mode |= inode->i_mode & ~S_IALLUGO;
+			inode->i_mode = mode;
 		}
-		if (stat->st_result_mask & P9_STATS_RDEV)
-			inode->i_rdev = new_decode_dev(stat->st_rdev);
 		if (!(flags & V9FS_STAT2INODE_KEEP_ISIZE) &&
 		    stat->st_result_mask & P9_STATS_SIZE)
 			v9fs_i_size_write(inode, stat->st_size);
-- 
2.11.0

