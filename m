Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD9A5A4C7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 14:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiH2MxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 08:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiH2Mwj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:52:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92930273E
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 05:42:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC5CEB80EB8
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 12:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFA8C433C1;
        Mon, 29 Aug 2022 12:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661776917;
        bh=RzYzKcN+rGy7aRRp7/Svsei9IVFqNDNJmKgRrwtnph8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvFtTkRbW8XtJEahnCBVDOiSu9K3Slydf8IDYuAo25WcNX5DoHZ83l1eBx3R0WeF8
         aOscTk4Zzn9UJA7e1cSbBrmDZdlx5wvTHbnE9VjxxLXHidc7rTs1DZPreaIpbh/KSG
         X1qsSPtggycHvwMc2yY2vsvra3E7IfvHKiP2MMpEPr1T46GUjtjepx/xKqnH1jsN2Z
         FN0OMfSxWewZaQqNlF0jX7sy1ZKz+WDMcdNLjEnWwrg+giTTAxVqnqgK3QjouBXXqk
         fcY89kP+3iDpd5J9pKGYcveBkjPUDaHpDK0shwoYAcXf10Cl7MFae7HUU2IvnmnqTT
         1TQ9xAHcIDlxA==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>
Subject: [PATCH 6/6] xattr: constify value argument in vfs_setxattr()
Date:   Mon, 29 Aug 2022 14:38:45 +0200
Message-Id: <20220829123843.1146874-7-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829123843.1146874-1-brauner@kernel.org>
References: <20220829123843.1146874-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2552; i=brauner@kernel.org; h=from:subject; bh=RzYzKcN+rGy7aRRp7/Svsei9IVFqNDNJmKgRrwtnph8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTzbPrTXyq0OSjrZ7lA2sEJ/mK/pOYE/2fI2F+f3SrJcOvx HZVTHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5943hv8+Li3Yvv0w1bWSZq3w5Na T3yapHj9u4T3+5+WCi5zXd2hqG/1Eq/t4Tr1ROqfx44u+JhzsKJycEsaxa5ZXisUTzm9Tu32wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we don't perform translations directly in vfs_setxattr()
anymore we can constify the @value argument in vfs_setxattr(). This also
allows us to remove the hack to cast from a const in ovl_do_setxattr().

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/overlayfs/overlayfs.h | 2 +-
 fs/xattr.c               | 5 ++---
 include/linux/xattr.h    | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 87759165d32b..ee93c825b06b 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -250,7 +250,7 @@ static inline int ovl_do_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
 				  size_t size, int flags)
 {
 	int err = vfs_setxattr(ovl_upper_mnt_userns(ofs), dentry, name,
-			       (void *)value, size, flags);
+			       value, size, flags);
 
 	pr_debug("setxattr(%pd2, \"%s\", \"%*pE\", %zu, %d) = %i\n",
 		 dentry, name, min((int)size, 48), value, size, flags, err);
diff --git a/fs/xattr.c b/fs/xattr.c
index 3ac68ec0c023..74fc8e021ebc 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -290,7 +290,7 @@ static inline bool is_posix_acl_xattr(const char *name)
 
 int
 vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
-	     const char *name, void *value, size_t size, int flags)
+	     const char *name, const void *value, size_t size, int flags)
 {
 	struct inode *inode = dentry->d_inode;
 	struct inode *delegated_inode = NULL;
@@ -298,8 +298,7 @@ vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	int error;
 
 	if (size && strcmp(name, XATTR_NAME_CAPS) == 0) {
-		error = cap_convert_nscap(mnt_userns, dentry,
-					  (const void **)&value, size);
+		error = cap_convert_nscap(mnt_userns, dentry, &value, size);
 		if (error < 0)
 			return error;
 		size = error;
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 979a9d3e5bfb..4c379d23ec6e 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -61,7 +61,7 @@ int __vfs_setxattr_locked(struct user_namespace *, struct dentry *,
 			  const char *, const void *, size_t, int,
 			  struct inode **);
 int vfs_setxattr(struct user_namespace *, struct dentry *, const char *,
-		 void *, size_t, int);
+		 const void *, size_t, int);
 int __vfs_removexattr(struct user_namespace *, struct dentry *, const char *);
 int __vfs_removexattr_locked(struct user_namespace *, struct dentry *,
 			     const char *, struct inode **);
-- 
2.34.1

