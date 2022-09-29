Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8174F5EF8C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbiI2PbD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbiI2Pa6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:30:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0FF24958;
        Thu, 29 Sep 2022 08:30:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E13661227;
        Thu, 29 Sep 2022 15:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFB9C43470;
        Thu, 29 Sep 2022 15:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465454;
        bh=gVAjdgVsHmw66X+ETBmgGkG29RZLkvbmpAiiXi5aTL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjsuHb1YDBv9JMwrZqslDfolOaBy3u8ieUYg46zsuel81WlPHpv230nPI3cD4o8wQ
         aQuv1SyJYfjvJ7eDGuZNm4bts/zgLTRNaWdjvxyPeQMRkEqwV2dKKQ+BrZPECSADsi
         433g1ndtaG+81CSJKy6S96utm46NF4/vEZ97elSo+2obcS4mh6Dm+tUP4Y7E8UIJfS
         tRaegNz7T/FnRsNNBM9SBB1Y0Rc3VKsGnr+IXTAeqdjrZCkPIu7EEhlJL3nc1CO5rq
         gPbo2DEU0IeAhCPQmGAAAsWOtfnCaZ2Kjrzqr9g+63/hAWkWtha8lA/idMyvlsw9Fk
         ZxQNgjmHpoXjA==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 01/30] orangefs: rework posix acl handling when creating new filesystem objects
Date:   Thu, 29 Sep 2022 17:30:11 +0200
Message-Id: <20220929153041.500115-2-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153041.500115-1-brauner@kernel.org>
References: <20220929153041.500115-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9359; i=brauner@kernel.org; h=from:subject; bh=gVAjdgVsHmw66X+ETBmgGkG29RZLkvbmpAiiXi5aTL0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSb7hJMcfMUFksN2mThLTVlcdhmfY3rOf8jRZcvNW9m8/qt f8u9o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKZsQx/hUOsltqVzutI3rbg6+LdrP 9szu/k7f5ox/b1C9/5lh8szxl+MT1juBxze9WMjORXDzqkKsL5A65t81Xx2nUjLIR1jns9AwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When creating new filesytem objects orangefs used to create posix acls
after it had created and inserted a new inode. This made it necessary to
all posix_acl_chmod() on the newly created inode in case the mode of the
inode would be changed by the posix acls.

Instead of doing it this way calculate the correct mode directly before
actually creating the inode. So we first create posix acls, then pass
the mode that posix acls mandate into the orangefs getattr helper and
calculate the correct mode. This is needed so we can simply change
posix_acl_chmod() to take a dentry instead of an inode argument in the
next patch.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    Christoph Hellwig <hch@lst.de>:
    - Add separate patch for orangefs rework.
    
    /* v3 */
    unchanged
    
    /* v4 */
    Christoph Hellwig <hch@lst.de>:
    - drop extern from function declaration

 fs/orangefs/acl.c             | 44 ++---------------------------------
 fs/orangefs/inode.c           | 44 ++++++++++++++++++++++++++++-------
 fs/orangefs/orangefs-kernel.h |  6 +++--
 fs/orangefs/orangefs-utils.c  | 12 +++++++---
 4 files changed, 51 insertions(+), 55 deletions(-)

diff --git a/fs/orangefs/acl.c b/fs/orangefs/acl.c
index 605e5a3506ec..0e2db840c217 100644
--- a/fs/orangefs/acl.c
+++ b/fs/orangefs/acl.c
@@ -64,8 +64,7 @@ struct posix_acl *orangefs_get_acl(struct inode *inode, int type, bool rcu)
 	return acl;
 }
 
-static int __orangefs_set_acl(struct inode *inode, struct posix_acl *acl,
-			      int type)
+int __orangefs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 {
 	int error = 0;
 	void *value = NULL;
@@ -153,46 +152,7 @@ int orangefs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	rc = __orangefs_set_acl(inode, acl, type);
 
 	if (!rc && (iattr.ia_valid == ATTR_MODE))
-		rc = __orangefs_setattr(inode, &iattr);
+		rc = __orangefs_setattr_mode(inode, &iattr);
 
 	return rc;
 }
-
-int orangefs_init_acl(struct inode *inode, struct inode *dir)
-{
-	struct posix_acl *default_acl, *acl;
-	umode_t mode = inode->i_mode;
-	struct iattr iattr;
-	int error = 0;
-
-	error = posix_acl_create(dir, &mode, &default_acl, &acl);
-	if (error)
-		return error;
-
-	if (default_acl) {
-		error = __orangefs_set_acl(inode, default_acl,
-					   ACL_TYPE_DEFAULT);
-		posix_acl_release(default_acl);
-	} else {
-		inode->i_default_acl = NULL;
-	}
-
-	if (acl) {
-		if (!error)
-			error = __orangefs_set_acl(inode, acl, ACL_TYPE_ACCESS);
-		posix_acl_release(acl);
-	} else {
-		inode->i_acl = NULL;
-	}
-
-	/* If mode of the inode was changed, then do a forcible ->setattr */
-	if (mode != inode->i_mode) {
-		memset(&iattr, 0, sizeof iattr);
-		inode->i_mode = mode;
-		iattr.ia_mode = mode;
-		iattr.ia_valid |= ATTR_MODE;
-		__orangefs_setattr(inode, &iattr);
-	}
-
-	return error;
-}
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 7a8c0c6e698d..35788cde6d24 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -828,15 +828,22 @@ int __orangefs_setattr(struct inode *inode, struct iattr *iattr)
 	spin_unlock(&inode->i_lock);
 	mark_inode_dirty(inode);
 
-	if (iattr->ia_valid & ATTR_MODE)
-		/* change mod on a file that has ACLs */
-		ret = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
-
 	ret = 0;
 out:
 	return ret;
 }
 
+int __orangefs_setattr_mode(struct inode *inode, struct iattr *iattr)
+{
+	int ret;
+
+	ret = __orangefs_setattr(inode, iattr);
+	/* change mode on a file that has ACLs */
+	if (!ret && (iattr->ia_valid & ATTR_MODE))
+		ret = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
+	return ret;
+}
+
 /*
  * Change attributes of an object referenced by dentry.
  */
@@ -849,7 +856,7 @@ int orangefs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	ret = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (ret)
 	        goto out;
-	ret = __orangefs_setattr(d_inode(dentry), iattr);
+	ret = __orangefs_setattr_mode(d_inode(dentry), iattr);
 	sync_inode_metadata(d_inode(dentry), 1);
 out:
 	gossip_debug(GOSSIP_INODE_DEBUG, "orangefs_setattr: returning %d\n",
@@ -1097,8 +1104,9 @@ struct inode *orangefs_iget(struct super_block *sb,
  * Allocate an inode for a newly created file and insert it into the inode hash.
  */
 struct inode *orangefs_new_inode(struct super_block *sb, struct inode *dir,
-		int mode, dev_t dev, struct orangefs_object_kref *ref)
+		umode_t mode, dev_t dev, struct orangefs_object_kref *ref)
 {
+	struct posix_acl *acl = NULL, *default_acl = NULL;
 	unsigned long hash = orangefs_handle_hash(ref);
 	struct inode *inode;
 	int error;
@@ -1115,16 +1123,33 @@ struct inode *orangefs_new_inode(struct super_block *sb, struct inode *dir,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
+	error = posix_acl_create(dir, &mode, &default_acl, &acl);
+	if (error)
+		goto out_iput;
+
 	orangefs_set_inode(inode, ref);
 	inode->i_ino = hash;	/* needed for stat etc */
 
-	error = orangefs_inode_getattr(inode, ORANGEFS_GETATTR_NEW);
+	error = __orangefs_inode_getattr(inode, mode, ORANGEFS_GETATTR_NEW);
 	if (error)
 		goto out_iput;
 
 	orangefs_init_iops(inode);
 	inode->i_rdev = dev;
 
+	if (default_acl) {
+		error = __orangefs_set_acl(inode, default_acl,
+					   ACL_TYPE_DEFAULT);
+		if (error)
+			goto out_iput;
+	}
+
+	if (acl) {
+		error = __orangefs_set_acl(inode, acl, ACL_TYPE_ACCESS);
+		if (error)
+			goto out_iput;
+	}
+
 	error = insert_inode_locked4(inode, hash, orangefs_test_inode, ref);
 	if (error < 0)
 		goto out_iput;
@@ -1132,10 +1157,13 @@ struct inode *orangefs_new_inode(struct super_block *sb, struct inode *dir,
 	gossip_debug(GOSSIP_INODE_DEBUG,
 		     "Initializing ACL's for inode %pU\n",
 		     get_khandle_from_ino(inode));
-	orangefs_init_acl(inode, dir);
+	posix_acl_release(acl);
+	posix_acl_release(default_acl);
 	return inode;
 
 out_iput:
 	iput(inode);
+	posix_acl_release(acl);
+	posix_acl_release(default_acl);
 	return ERR_PTR(error);
 }
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index b5940ec1836a..3298b15684b7 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -103,13 +103,13 @@ enum orangefs_vfs_op_states {
 #define ORANGEFS_CACHE_CREATE_FLAGS 0
 #endif
 
-extern int orangefs_init_acl(struct inode *inode, struct inode *dir);
 extern const struct xattr_handler *orangefs_xattr_handlers[];
 
 extern struct posix_acl *orangefs_get_acl(struct inode *inode, int type, bool rcu);
 extern int orangefs_set_acl(struct user_namespace *mnt_userns,
 			    struct inode *inode, struct posix_acl *acl,
 			    int type);
+int __orangefs_set_acl(struct inode *inode, struct posix_acl *acl, int type);
 
 /*
  * orangefs data structures
@@ -356,11 +356,12 @@ void fsid_key_table_finalize(void);
 vm_fault_t orangefs_page_mkwrite(struct vm_fault *);
 struct inode *orangefs_new_inode(struct super_block *sb,
 			      struct inode *dir,
-			      int mode,
+			      umode_t mode,
 			      dev_t dev,
 			      struct orangefs_object_kref *ref);
 
 int __orangefs_setattr(struct inode *, struct iattr *);
+int __orangefs_setattr_mode(struct inode *inode, struct iattr *iattr);
 int orangefs_setattr(struct user_namespace *, struct dentry *, struct iattr *);
 
 int orangefs_getattr(struct user_namespace *mnt_userns, const struct path *path,
@@ -422,6 +423,7 @@ int orangefs_inode_setxattr(struct inode *inode,
 #define ORANGEFS_GETATTR_SIZE 2
 
 int orangefs_inode_getattr(struct inode *, int);
+int __orangefs_inode_getattr(struct inode *inode, umode_t mode, int flags);
 
 int orangefs_inode_check_changed(struct inode *inode);
 
diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index 46b7dcff18ac..2351a62a7b37 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -233,7 +233,7 @@ static int orangefs_inode_is_stale(struct inode *inode,
 	return 0;
 }
 
-int orangefs_inode_getattr(struct inode *inode, int flags)
+int __orangefs_inode_getattr(struct inode *inode, umode_t mode, int flags)
 {
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
 	struct orangefs_kernel_op_s *new_op;
@@ -368,8 +368,9 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	inode->i_ctime.tv_nsec = 0;
 
 	/* special case: mark the root inode as sticky */
-	inode->i_mode = type | (is_root_handle(inode) ? S_ISVTX : 0) |
-	    orangefs_inode_perms(&new_op->downcall.resp.getattr.attributes);
+	inode->i_mode = type | (is_root_handle(inode) ? S_ISVTX : 0) | mode |
+	    orangefs_inode_perms(&new_op->downcall.resp.getattr.attributes) |
+	    mode;
 
 	orangefs_inode->getattr_time = jiffies +
 	    orangefs_getattr_timeout_msecs*HZ/1000;
@@ -381,6 +382,11 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	return ret;
 }
 
+int orangefs_inode_getattr(struct inode *inode, int flags)
+{
+	return __orangefs_inode_getattr(inode, 0, flags);
+}
+
 int orangefs_inode_check_changed(struct inode *inode)
 {
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
-- 
2.34.1

