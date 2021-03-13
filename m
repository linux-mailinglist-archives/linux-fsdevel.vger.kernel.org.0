Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A907339BC8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 05:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhCMElB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 23:41:01 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33544 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbhCMEkf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:40:35 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKw2j-005O0F-NQ; Sat, 13 Mar 2021 04:38:25 +0000
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
Subject: [PATCH v2 13/15] openpromfs: don't do unlock_new_inode() until the new inode is set up
Date:   Sat, 13 Mar 2021 04:38:22 +0000
Message-Id: <20210313043824.1283821-13-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/openpromfs/inode.c | 67 +++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 40c8c2e32fa3..f825176ff4ed 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -236,27 +236,31 @@ static struct dentry *openpromfs_lookup(struct inode *dir, struct dentry *dentry
 	mutex_unlock(&op_mutex);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
-	ent_oi = OP_I(inode);
-	ent_oi->type = ent_type;
-	ent_oi->u = ent_data;
-
-	switch (ent_type) {
-	case op_inode_node:
-		inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;
-		inode->i_op = &openprom_inode_operations;
-		inode->i_fop = &openprom_operations;
-		set_nlink(inode, 2);
-		break;
-	case op_inode_prop:
-		if (of_node_name_eq(dp, "options") && (len == 17) &&
-		    !strncmp (name, "security-password", 17))
-			inode->i_mode = S_IFREG | S_IRUSR | S_IWUSR;
-		else
-			inode->i_mode = S_IFREG | S_IRUGO;
-		inode->i_fop = &openpromfs_prop_ops;
-		set_nlink(inode, 1);
-		inode->i_size = ent_oi->u.prop->length;
-		break;
+	if (inode->i_state & I_NEW) {
+		inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+		ent_oi = OP_I(inode);
+		ent_oi->type = ent_type;
+		ent_oi->u = ent_data;
+
+		switch (ent_type) {
+		case op_inode_node:
+			inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;
+			inode->i_op = &openprom_inode_operations;
+			inode->i_fop = &openprom_operations;
+			set_nlink(inode, 2);
+			break;
+		case op_inode_prop:
+			if (of_node_name_eq(dp, "options") && (len == 17) &&
+			    !strncmp (name, "security-password", 17))
+				inode->i_mode = S_IFREG | S_IRUSR | S_IWUSR;
+			else
+				inode->i_mode = S_IFREG | S_IRUGO;
+			inode->i_fop = &openpromfs_prop_ops;
+			set_nlink(inode, 1);
+			inode->i_size = ent_oi->u.prop->length;
+			break;
+		}
+		unlock_new_inode(inode);
 	}
 
 	return d_splice_alias(inode, dentry);
@@ -345,20 +349,9 @@ static void openprom_free_inode(struct inode *inode)
 
 static struct inode *openprom_iget(struct super_block *sb, ino_t ino)
 {
-	struct inode *inode;
-
-	inode = iget_locked(sb, ino);
+	struct inode *inode = iget_locked(sb, ino);
 	if (!inode)
-		return ERR_PTR(-ENOMEM);
-	if (inode->i_state & I_NEW) {
-		inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
-		if (inode->i_ino == OPENPROM_ROOT_INO) {
-			inode->i_op = &openprom_inode_operations;
-			inode->i_fop = &openprom_operations;
-			inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;
-		}
-		unlock_new_inode(inode);
-	}
+		inode = ERR_PTR(-ENOMEM);
 	return inode;
 }
 
@@ -394,9 +387,15 @@ static int openprom_fill_super(struct super_block *s, struct fs_context *fc)
 		goto out_no_root;
 	}
 
+	root_inode->i_mtime = root_inode->i_atime =
+		root_inode->i_ctime = current_time(root_inode);
+	root_inode->i_op = &openprom_inode_operations;
+	root_inode->i_fop = &openprom_operations;
+	root_inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;
 	oi = OP_I(root_inode);
 	oi->type = op_inode_node;
 	oi->u.node = of_find_node_by_path("/");
+	unlock_new_inode(root_inode);
 
 	s->s_root = d_make_root(root_inode);
 	if (!s->s_root)
-- 
2.11.0

