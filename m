Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A929339BCB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 05:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhCMElB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 23:41:01 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33554 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhCMEkf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:40:35 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKw2i-005NzW-Og; Sat, 13 Mar 2021 04:38:24 +0000
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
Subject: [PATCH v2 02/15] ceph: fix up error handling with snapdirs
Date:   Sat, 13 Mar 2021 04:38:11 +0000
Message-Id: <20210313043824.1283821-2-viro@zeniv.linux.org.uk>
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

From: Jeff Layton <jlayton@kernel.org>

There are several warts in the snapdir error handling. The -EOPNOTSUPP
return in __snapfh_to_dentry is currently lost, and the call to
ceph_handle_snapdir is not currently checked at all.

Fix all of this up and eliminate a BUG_ON in ceph_get_snapdir. We can
handle that case with a warning and return an error.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ceph/dir.c    |  2 ++
 fs/ceph/export.c |  9 +++++----
 fs/ceph/inode.c  | 14 +++++++++++++-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 83d9358854fb..f7a790ed62c4 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -677,6 +677,8 @@ int ceph_handle_snapdir(struct ceph_mds_request *req,
 	    strcmp(dentry->d_name.name,
 		   fsc->mount_options->snapdir_name) == 0) {
 		struct inode *inode = ceph_get_snapdir(parent);
+		if (IS_ERR(inode))
+			return PTR_ERR(inode);
 		dout("ENOENT on snapdir %p '%pd', linking to snapdir %p\n",
 		     dentry, dentry, inode);
 		BUG_ON(!d_unhashed(dentry));
diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index e088843a7734..f22156ee7306 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -248,9 +248,10 @@ static struct dentry *__snapfh_to_dentry(struct super_block *sb,
 			ihold(inode);
 		} else {
 			/* mds does not support lookup snapped inode */
-			err = -EOPNOTSUPP;
-			inode = NULL;
+			inode = ERR_PTR(-EOPNOTSUPP);
 		}
+	} else {
+		inode = ERR_PTR(-ESTALE);
 	}
 	ceph_mdsc_put_request(req);
 
@@ -261,8 +262,8 @@ static struct dentry *__snapfh_to_dentry(struct super_block *sb,
 		dout("snapfh_to_dentry %llx.%llx parent %llx hash %x err=%d",
 		      vino.ino, vino.snap, sfh->parent_ino, sfh->hash, err);
 	}
-	if (!inode)
-		return ERR_PTR(-ESTALE);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
 	/* see comments in ceph_get_parent() */
 	return unlinked ? d_obtain_root(inode) : d_obtain_alias(inode);
 }
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 156f849f5385..5db7bf4c6a26 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -78,9 +78,21 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 	struct inode *inode = ceph_get_inode(parent->i_sb, vino);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
-	BUG_ON(!S_ISDIR(parent->i_mode));
 	if (IS_ERR(inode))
 		return inode;
+
+	if (!S_ISDIR(parent->i_mode)) {
+		pr_warn_once("bad snapdir parent type (mode=0%o)\n",
+			     parent->i_mode);
+		return ERR_PTR(-ENOTDIR);
+	}
+
+	if (!(inode->i_state & I_NEW) && !S_ISDIR(inode->i_mode)) {
+		pr_warn_once("bad snapdir inode type (mode=0%o)\n",
+			     inode->i_mode);
+		return ERR_PTR(-ENOTDIR);
+	}
+
 	inode->i_mode = parent->i_mode;
 	inode->i_uid = parent->i_uid;
 	inode->i_gid = parent->i_gid;
-- 
2.11.0

