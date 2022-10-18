Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2C4602AC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 13:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiJRL7O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 07:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiJRL6b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B250BD066;
        Tue, 18 Oct 2022 04:57:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43EBC6153D;
        Tue, 18 Oct 2022 11:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1132EC433B5;
        Tue, 18 Oct 2022 11:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094275;
        bh=sDCoYooQ4sD0AFfta13qFLuUwaIu1lEyBmzZmR0H7D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XvcK/KuFSP4wAtRSlUJ+CbuI5H+cxAg7n6eU2SEOFM+D6Yf++VXozoVkCO5Z4ITg1
         gDKU6Jx/XGCVScFWfmmCiHusbArwh6iqnzOuOXrb37ju/pAAWoalEKX6qci3QeIPMU
         a40CH1Q8x81wXjhDpe+hF2lFq00fdphtP1vh//Vb4qUgj7vk9wHrCBMRqOtV6RxTfL
         ItZbkMviaoz15w5vEw547sX3trJScyIHhp2n41yyLdf2hvAO3YaVDgSlkNEWgjMaTZ
         BRQMMQoACZkSYHmqzoYzDkdU/34kPwkqF8EXQrl1bhvxSP91wJMMyre2NVMzySJTDU
         KK9HhAIPQZZJw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 14/30] internal: add may_write_xattr()
Date:   Tue, 18 Oct 2022 13:56:44 +0200
Message-Id: <20221018115700.166010-15-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3136; i=brauner@kernel.org; h=from:subject; bh=sDCoYooQ4sD0AFfta13qFLuUwaIu1lEyBmzZmR0H7D4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TVFfl128Q5PdTKVWTkz/wslek5dLvRa63Xq7P7V/G7u9 vEVGRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ0pjD8M/zKEPGi7/i8W2X7lu26uI e1R2jzRa3C2SmHVhumT8t4b8LIsMx2wQL5D86lFtnP1d0aJl44HVxkeegng7spk46/TaUkDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split out the generic checks whether an inode allows writing xattrs. Since
security.* and system.* xattrs don't have any restrictions and we're going
to split out posix acls into a dedicated api we will use this helper to
check whether we can write posix acls.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    patch not present
    
    /* v3 */
    patch not present
    
    /* v4 */
    Christoph Hellwig <hch@lst.de>:
    - Split out checks whether an inode can have xattrs written to into a helper.
    
    /* v5 */
    unchanged

 fs/internal.h |  1 +
 fs/xattr.c    | 43 ++++++++++++++++++++++++++++++-------------
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 6f0386b34fae..de43795ab7cd 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -234,3 +234,4 @@ int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		struct xattr_ctx *ctx);
 
 ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *pos);
+int may_write_xattr(struct user_namespace *mnt_userns, struct inode *inode);
diff --git a/fs/xattr.c b/fs/xattr.c
index 61107b6bbed2..31b5ac65ca34 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -80,6 +80,31 @@ xattr_resolve_name(struct inode *inode, const char **name)
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+/**
+ * may_write_xattr - check whether inode allows writing xattr
+ * @mnt_userns:	User namespace of the mount the inode was found from
+ * @inode: the inode on which to set an xattr
+ *
+ * Check whether the inode allows writing xattrs. Specifically, we can never
+ * set or remove an extended attribute on a read-only filesystem  or on an
+ * immutable / append-only inode.
+ *
+ * We also need to ensure that the inode has a mapping in the mount to
+ * not risk writing back invalid i_{g,u}id values.
+ *
+ * Return: On success zero is returned. On error a negative errno is returned.
+ */
+int may_write_xattr(struct user_namespace *mnt_userns, struct inode *inode)
+{
+	if (IS_IMMUTABLE(inode))
+		return -EPERM;
+	if (IS_APPEND(inode))
+		return -EPERM;
+	if (HAS_UNMAPPED_ID(mnt_userns, inode))
+		return -EPERM;
+	return 0;
+}
+
 /*
  * Check permissions for extended attribute access.  This is a bit complicated
  * because different namespaces have very different rules.
@@ -88,20 +113,12 @@ static int
 xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
 		 const char *name, int mask)
 {
-	/*
-	 * We can never set or remove an extended attribute on a read-only
-	 * filesystem  or on an immutable / append-only inode.
-	 */
 	if (mask & MAY_WRITE) {
-		if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
-			return -EPERM;
-		/*
-		 * Updating an xattr will likely cause i_uid and i_gid
-		 * to be writen back improperly if their true value is
-		 * unknown to the vfs.
-		 */
-		if (HAS_UNMAPPED_ID(mnt_userns, inode))
-			return -EPERM;
+		int ret;
+
+		ret = may_write_xattr(mnt_userns, inode);
+		if (ret)
+			return ret;
 	}
 
 	/*
-- 
2.34.1

