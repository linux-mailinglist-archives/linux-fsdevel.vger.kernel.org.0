Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2BE339BC5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 05:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhCMEk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 23:40:59 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33566 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbhCMEkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:40:36 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKw2i-005Nze-U3; Sat, 13 Mar 2021 04:38:24 +0000
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
Subject: [PATCH v2 04/15] afs: Fix updating of i_mode due to 3rd party change
Date:   Sat, 13 Mar 2021 04:38:13 +0000
Message-Id: <20210313043824.1283821-4-viro@zeniv.linux.org.uk>
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

From: David Howells <dhowells@redhat.com>

Fix afs_apply_status() to mask off the irrelevant bits from status->mode
when OR'ing them into i_mode.  This can happen when a 3rd party chmod
occurs.

Also fix afs_inode_init_from_status() to mask off the mode bits when
initialising i_mode.

Fixes: 260a980317da ("[AFS]: Add "directory write" support.")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/afs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 1156b2df28d3..9f83e671c785 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -103,13 +103,13 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 
 	switch (status->type) {
 	case AFS_FTYPE_FILE:
-		inode->i_mode	= S_IFREG | status->mode;
+		inode->i_mode	= S_IFREG | (status->mode & S_IALLUGO);
 		inode->i_op	= &afs_file_inode_operations;
 		inode->i_fop	= &afs_file_operations;
 		inode->i_mapping->a_ops	= &afs_fs_aops;
 		break;
 	case AFS_FTYPE_DIR:
-		inode->i_mode	= S_IFDIR | status->mode;
+		inode->i_mode	= S_IFDIR |  (status->mode & S_IALLUGO);
 		inode->i_op	= &afs_dir_inode_operations;
 		inode->i_fop	= &afs_dir_file_operations;
 		inode->i_mapping->a_ops	= &afs_dir_aops;
@@ -199,7 +199,7 @@ static void afs_apply_status(struct afs_operation *op,
 	if (status->mode != vnode->status.mode) {
 		mode = inode->i_mode;
 		mode &= ~S_IALLUGO;
-		mode |= status->mode;
+		mode |= status->mode & S_IALLUGO;
 		WRITE_ONCE(inode->i_mode, mode);
 	}
 
-- 
2.11.0

