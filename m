Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB32339BC0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 05:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhCMEk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 23:40:59 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33590 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbhCMEkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:40:36 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKw2j-005O07-I9; Sat, 13 Mar 2021 04:38:25 +0000
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
Subject: [PATCH v2 11/15] cifs: have cifs_fattr_to_inode() refuse to change type on live inode
Date:   Sat, 13 Mar 2021 04:38:20 +0000
Message-Id: <20210313043824.1283821-11-viro@zeniv.linux.org.uk>
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

... instead of trying to do that in the callers (and missing some,
at that)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/cifs/cifsproto.h |  2 +-
 fs/cifs/file.c      |  2 +-
 fs/cifs/inode.c     | 42 +++++++++++++++---------------------------
 fs/cifs/readdir.c   |  4 +---
 4 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 75ce6f742b8d..2a72dc24b00a 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -194,7 +194,7 @@ extern void cifs_unix_basic_to_fattr(struct cifs_fattr *fattr,
 				     struct cifs_sb_info *cifs_sb);
 extern void cifs_dir_info_to_fattr(struct cifs_fattr *, FILE_DIRECTORY_INFO *,
 					struct cifs_sb_info *);
-extern void cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr);
+extern int cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr);
 extern struct inode *cifs_iget(struct super_block *sb,
 			       struct cifs_fattr *fattr);
 
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 26de4329d161..78266f0e0595 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -165,7 +165,7 @@ int cifs_posix_open(char *full_path, struct inode **pinode,
 			goto posix_open_ret;
 		}
 	} else {
-		cifs_fattr_to_inode(*pinode, &fattr);
+		rc = cifs_fattr_to_inode(*pinode, &fattr);
 	}
 
 posix_open_ret:
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 80c487fcf10e..51cb1ca829ec 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -157,12 +157,18 @@ cifs_nlink_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 }
 
 /* populate an inode with info from a cifs_fattr struct */
-void
+int
 cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 {
 	struct cifsInodeInfo *cifs_i = CIFS_I(inode);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 
+	if (!(inode->i_state & I_NEW) &&
+	    unlikely(inode_wrong_type(inode, fattr->cf_mode))) {
+		CIFS_I(inode)->time = 0; /* force reval */
+		return -ESTALE;
+	}
+
 	cifs_revalidate_cache(inode, fattr);
 
 	spin_lock(&inode->i_lock);
@@ -219,6 +225,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 		inode->i_flags |= S_AUTOMOUNT;
 	if (inode->i_state & I_NEW)
 		cifs_set_ops(inode);
+	return 0;
 }
 
 void
@@ -363,7 +370,7 @@ cifs_get_file_info_unix(struct file *filp)
 		rc = 0;
 	}
 
-	cifs_fattr_to_inode(inode, &fattr);
+	rc = cifs_fattr_to_inode(inode, &fattr);
 	free_xid(xid);
 	return rc;
 }
@@ -426,13 +433,7 @@ int cifs_get_inode_info_unix(struct inode **pinode,
 		}
 
 		/* if filetype is different, return error */
-		if (unlikely(inode_wrong_type(*pinode, fattr.cf_mode))) {
-			CIFS_I(*pinode)->time = 0; /* force reval */
-			rc = -ESTALE;
-			goto cgiiu_exit;
-		}
-
-		cifs_fattr_to_inode(*pinode, &fattr);
+		rc = cifs_fattr_to_inode(*pinode, &fattr);
 	}
 
 cgiiu_exit:
@@ -782,7 +783,8 @@ cifs_get_file_info(struct file *filp)
 	 */
 	fattr.cf_uniqueid = CIFS_I(inode)->uniqueid;
 	fattr.cf_flags |= CIFS_FATTR_NEED_REVAL;
-	cifs_fattr_to_inode(inode, &fattr);
+	/* if filetype is different, return error */
+	rc = cifs_fattr_to_inode(inode, &fattr);
 cgfi_exit:
 	free_xid(xid);
 	return rc;
@@ -1099,16 +1101,8 @@ cifs_get_inode_info(struct inode **inode,
 			rc = -ESTALE;
 			goto out;
 		}
-
 		/* if filetype is different, return error */
-		if (unlikely(((*inode)->i_mode & S_IFMT) !=
-		    (fattr.cf_mode & S_IFMT))) {
-			CIFS_I(*inode)->time = 0; /* force reval */
-			rc = -ESTALE;
-			goto out;
-		}
-
-		cifs_fattr_to_inode(*inode, &fattr);
+		rc = cifs_fattr_to_inode(*inode, &fattr);
 	}
 out:
 	cifs_buf_release(smb1_backup_rsp_buf);
@@ -1214,14 +1208,7 @@ smb311_posix_get_inode_info(struct inode **inode,
 		}
 
 		/* if filetype is different, return error */
-		if (unlikely(((*inode)->i_mode & S_IFMT) !=
-		    (fattr.cf_mode & S_IFMT))) {
-			CIFS_I(*inode)->time = 0; /* force reval */
-			rc = -ESTALE;
-			goto out;
-		}
-
-		cifs_fattr_to_inode(*inode, &fattr);
+		rc = cifs_fattr_to_inode(*inode, &fattr);
 	}
 out:
 	cifs_put_tlink(tlink);
@@ -1316,6 +1303,7 @@ cifs_iget(struct super_block *sb, struct cifs_fattr *fattr)
 			}
 		}
 
+		/* can't fail - see cifs_find_inode() */
 		cifs_fattr_to_inode(inode, fattr);
 		if (sb->s_flags & SB_NOATIME)
 			inode->i_flags |= S_NOATIME | S_NOCMTIME;
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 80bf4c6f4c7b..e563c0fb47cb 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -119,9 +119,7 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 			/* update inode in place
 			 * if both i_ino and i_mode didn't change */
 			if (CIFS_I(inode)->uniqueid == fattr->cf_uniqueid &&
-			    (inode->i_mode & S_IFMT) ==
-			    (fattr->cf_mode & S_IFMT)) {
-				cifs_fattr_to_inode(inode, fattr);
+			    cifs_fattr_to_inode(inode, fattr) == 0) {
 				dput(dentry);
 				return;
 			}
-- 
2.11.0

