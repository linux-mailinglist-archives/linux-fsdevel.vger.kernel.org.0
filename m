Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE445EF8E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbiI2PdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbiI2PcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:32:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256B5128A20;
        Thu, 29 Sep 2022 08:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD202B824FA;
        Thu, 29 Sep 2022 15:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C7EC43470;
        Thu, 29 Sep 2022 15:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465490;
        bh=MoGYshfN2ilMbkOYzge1aGNpDz34pK604EVyBwEjG4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wxdys+QiFx+i4K21O9tHLaPzYM+3P6MPmga/Yz6N9I8PGag+OuQRoUKJrUX3nWecV
         zg34xYJSg2e7kzeTkyzyTvxNIcTfOXeYvVJ6ucD4BBvg1tTJ5MnsXhCoFhP9ijXiL6
         RYR5JJVtZedBto5vVisfTDtGQhrzwoUat/rHOkCojZVDz3Lg6aJjgK837W4LWnhigS
         L9LV6MjZ5TlNo7ISTcGU6I+LaisWRAjYfUeR63rn3NqINBuR8vfbST5vSBMLx72M9X
         DS3o8umt21wMh+MT5DgfxnVCyRTOuL/fwIM42Wg4BnZbCjDhN/Tq80H0PX+nL98Kdd
         tfOmUi1ItjIow==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 14/30] internal: add may_write_xattr()
Date:   Thu, 29 Sep 2022 17:30:24 +0200
Message-Id: <20220929153041.500115-15-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153041.500115-1-brauner@kernel.org>
References: <20220929153041.500115-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3094; i=brauner@kernel.org; h=from:subject; bh=MoGYshfN2ilMbkOYzge1aGNpDz34pK604EVyBwEjG4g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSb7hKZeZ5/3p6te/omh0mvWquZJL1EW2HGM56wVN7YxEvn 8lqzOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyj4vhf+y72Gc65SxazyL+8d06WP js6NGvoStUHpU+28f567lm3FqGf6r/mw0WHFs+YUXezy82KyTvGzMt3T11zeS/IoFP1SoNlbgB
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

 fs/internal.h |  1 +
 fs/xattr.c    | 40 +++++++++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 87e96b9024ce..a95b1500ed65 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -221,3 +221,4 @@ ssize_t do_getxattr(struct user_namespace *mnt_userns,
 int setxattr_copy(const char __user *name, struct xattr_ctx *ctx);
 int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		struct xattr_ctx *ctx);
+int may_write_xattr(struct user_namespace *mnt_userns, struct inode *inode);
diff --git a/fs/xattr.c b/fs/xattr.c
index 61107b6bbed2..57148c207545 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -80,6 +80,28 @@ xattr_resolve_name(struct inode *inode, const char **name)
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
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode) ||
+	    HAS_UNMAPPED_ID(mnt_userns, inode))
+		return -EPERM;
+	return 0;
+}
+
 /*
  * Check permissions for extended attribute access.  This is a bit complicated
  * because different namespaces have very different rules.
@@ -88,20 +110,12 @@ static int
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

