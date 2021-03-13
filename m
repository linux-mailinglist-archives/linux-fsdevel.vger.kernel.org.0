Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E614B339BC4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 05:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhCMElA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 23:41:00 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33538 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhCMEkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:40:36 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKw2j-005Nzz-CM; Sat, 13 Mar 2021 04:38:25 +0000
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
Subject: [PATCH v2 09/15] do_cifs_create(): don't set ->i_mode of something we had not created
Date:   Sat, 13 Mar 2021 04:38:18 +0000
Message-Id: <20210313043824.1283821-9-viro@zeniv.linux.org.uk>
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

If the file had existed before we'd called ->atomic_open() (without
O_EXCL, that is), we have no more business setting ->i_mode than
we would setting ->i_uid or ->i_gid.  We also have no business
doing either if another client has managed to get unlink+mkdir
between ->open() and cifs_inode_get_info().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/cifs/dir.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index a3fb81e0ba17..9d7ae93c8af7 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -418,15 +418,16 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 		if (newinode) {
 			if (server->ops->set_lease_key)
 				server->ops->set_lease_key(newinode, fid);
-			if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DYNPERM)
-				newinode->i_mode = mode;
-			if ((*oplock & CIFS_CREATE_ACTION) &&
-			    (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SET_UID)) {
-				newinode->i_uid = current_fsuid();
-				if (inode->i_mode & S_ISGID)
-					newinode->i_gid = inode->i_gid;
-				else
-					newinode->i_gid = current_fsgid();
+			if ((*oplock & CIFS_CREATE_ACTION) && S_ISREG(newinode->i_mode)) {
+				if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DYNPERM)
+					newinode->i_mode = mode;
+				if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SET_UID) {
+					newinode->i_uid = current_fsuid();
+					if (inode->i_mode & S_ISGID)
+						newinode->i_gid = inode->i_gid;
+					else
+						newinode->i_gid = current_fsgid();
+				}
 			}
 		}
 	}
-- 
2.11.0

