Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988AB67B148
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 12:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbjAYLaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 06:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbjAYL3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:29:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E851E9EF8
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 03:29:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83EA2614C7
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 11:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE3DC4339C;
        Wed, 25 Jan 2023 11:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674646192;
        bh=2hyKsONoFMtmM8iTjuJTXUT79jOLhlYjsFLY9rKXI9A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=OCwnQtKZDEALzjBEjed/2kj+0N7kbW8pwocjz2w7xgcD4RY5kpsW0qhlvOpdVPDmh
         /2tIYf9WL62TAFbAGpR57+RrOisd4EKSKQbsWxCVme8nCgZdR+utW1YvBUOWRJoH30
         Vf8707ZgptcICq/48xa748h3hbRftBSIqZyd9kaR1OJFA9OANCSZJiTH5+d0Sgp3fK
         936qx9gA2ZhBaXk3aJZRW4PGAnP4s7eQUsaQUORyDSeJRWxJvjcL3S7QEfTlYtxBp6
         pcxQnp5zSk5ApP3i90BDtdpyrr1nKvSo57g7XRVBTYXAMALHuGswLynNHq8L1SiN6h
         F++aD95XzKsuQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 25 Jan 2023 12:28:57 +0100
Subject: [PATCH 12/12] acl: remove posix acl handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v1-12-6cf155b492b6@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2hyKsONoFMtmM8iTjuJTXUT79jOLhlYjsFLY9rKXI9A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRfFJq0R+Fh3QbvuwqFvKb7L/HKLFbtv85vkyG6q8nbKGrR
 ur9iHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPRzmf4K8XOUTnPit2nQpSltOKYXN
 1clWIhU/PwNdmSPLInKg7MYPjDM9lhNnPEx70upTnLY9esvJ3OrnpQ+pGV1gaWhYrxhfaMAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that everything in the VFS and all filesystems just rely on the
dedicated inode methods to interact with posix acls we can remove the
dummy generic posix acl xattr handlers. This way no filesystem an be
falsely under the impression that they are needed to implement posix acl
support.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/posix_acl.c                  | 20 --------------------
 include/linux/posix_acl_xattr.h |  3 ---
 2 files changed, 23 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index d7bc81fc0840..8028b6ee38a0 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -958,26 +958,6 @@ set_posix_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 }
 EXPORT_SYMBOL(set_posix_acl);
 
-static bool
-posix_acl_xattr_list(struct dentry *dentry)
-{
-	return IS_POSIXACL(d_backing_inode(dentry));
-}
-
-const struct xattr_handler posix_acl_access_xattr_handler = {
-	.name = XATTR_NAME_POSIX_ACL_ACCESS,
-	.flags = ACL_TYPE_ACCESS,
-	.list = posix_acl_xattr_list,
-};
-EXPORT_SYMBOL_GPL(posix_acl_access_xattr_handler);
-
-const struct xattr_handler posix_acl_default_xattr_handler = {
-	.name = XATTR_NAME_POSIX_ACL_DEFAULT,
-	.flags = ACL_TYPE_DEFAULT,
-	.list = posix_acl_xattr_list,
-};
-EXPORT_SYMBOL_GPL(posix_acl_default_xattr_handler);
-
 int simple_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		   struct posix_acl *acl, int type)
 {
diff --git a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
index 905d532ccd6e..bb657f3336e8 100644
--- a/include/linux/posix_acl_xattr.h
+++ b/include/linux/posix_acl_xattr.h
@@ -73,7 +73,4 @@ static inline bool posix_acl_dentry_list(struct dentry *dentry)
 	return IS_POSIXACL(d_backing_inode(dentry));
 }
 
-extern const struct xattr_handler posix_acl_access_xattr_handler;
-extern const struct xattr_handler posix_acl_default_xattr_handler;
-
 #endif	/* _POSIX_ACL_XATTR_H */

-- 
2.34.1

