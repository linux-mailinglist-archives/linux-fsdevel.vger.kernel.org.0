Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF14626F59
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Nov 2022 12:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiKMLuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Nov 2022 06:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiKMLuP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Nov 2022 06:50:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C33C76B
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Nov 2022 03:50:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAB5060B7B
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Nov 2022 11:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE35C433D7;
        Sun, 13 Nov 2022 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668340213;
        bh=6m4dXZHDAdYqiZM8fRXHGTAok6QV5PM/StMbeMuAAsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=si4676o7eTFNaZjEM1or3E7i1G/ip61XqC3mqETAjyqytxcDLKpzzI0/U8rQpULiw
         3xdqllA2uFspCLoag4jq/XpOeFYBK2diwRRtA+vgnMU4wJECCGWOlv2sr048ZH4lHq
         e+n/0Y6fMYn4ickHzl70nWr2RdlaO+CBeEEk0Vw3gqKUCePpzxho10gxTIKkyW1hlQ
         Lqtlal/DrlUqvDyN3Or/hfjnlA2xlrRSMC7zLS/ywRYCpAOoD6Pqaho10KYhMw7SHt
         d1wUCt+e6ivWOm5UO89YPx8NjI1set3aS2ztzc2AQjTvSG7032v11WCTAXRzmZeaiM
         uu4zeE+vikZ2Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] orangefs: fix mode handling
Date:   Sun, 13 Nov 2022 12:50:02 +0100
Message-Id: <20221113115002.2006026-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221112100945.uig2jef74oxbg6gd@wittgenstein>
References: <20221112100945.uig2jef74oxbg6gd@wittgenstein>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4397; i=brauner@kernel.org; h=from:subject; bh=6m4dXZHDAdYqiZM8fRXHGTAok6QV5PM/StMbeMuAAsA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQX3Hwgvdm14eh9/rOeM1X0Zv/e27LGS53NhvNI5+wEb6mb bNvndJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk7R/D/0z+6prHd//oLdcUK9Xr3s w05fi9je05sf+fTb4+5dH7Z9+BKvoe+/2pYVUwms1uteg8c6ysqq6zefrtdWf8OCZcj1jEDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In 4053d2500beb ("orangefs: rework posix acl handling when creating new
filesystem objects") we tried to precalculate the correct mode when
creating a new inode. However, this leads to regressions when creating new
filesystem objects.

Even if we precalculate the mode we still need to call __orangefs_setattr()
to perform additional checks and we also need to update the mode of
ACL_TYPE_ACCESS acls set on the inode. The patch referenced above regressed
that. Restore that part of the old behavior and remove the mode
precalculation as it doesn't get us anything anymore.

Fixes: 4053d2500beb ("orangefs: rework posix acl handling when creating new filesystem objects")
Reported-by: Mike Marshall <hubcap@omnibond.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    Link: https://lore.kernel.org/linux-fsdevel/CAOg9mSSq_yV=q5J6sEh8qHWwLe_wYwwsb1rTEh11k52D2nm11g@mail.gmail.com
    
    Hey Mike,
    
    The fix is pretty straightforward. I forgot to update the mode through
    __orangefs_setattr() and in the ACL_TYPE_ACCESS acl. This patch restores
    this and fixes the reported xfstest failure. I've pushed this out now.
    
    Thanks!
    Christian

 fs/orangefs/inode.c           | 11 ++++++++++-
 fs/orangefs/orangefs-kernel.h |  1 -
 fs/orangefs/orangefs-utils.c  | 10 ++--------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 8974b0fbf00d..3d65accfae17 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -1131,7 +1131,7 @@ struct inode *orangefs_new_inode(struct super_block *sb, struct inode *dir,
 	orangefs_set_inode(inode, ref);
 	inode->i_ino = hash;	/* needed for stat etc */
 
-	error = __orangefs_inode_getattr(inode, mode, ORANGEFS_GETATTR_NEW);
+	error = orangefs_inode_getattr(inode, ORANGEFS_GETATTR_NEW);
 	if (error)
 		goto out_iput;
 
@@ -1158,6 +1158,15 @@ struct inode *orangefs_new_inode(struct super_block *sb, struct inode *dir,
 	gossip_debug(GOSSIP_INODE_DEBUG,
 		     "Initializing ACL's for inode %pU\n",
 		     get_khandle_from_ino(inode));
+	if (mode != inode->i_mode) {
+		struct iattr iattr = {
+			.ia_mode = mode,
+			.ia_valid = ATTR_MODE,
+		};
+		inode->i_mode = mode;
+		__orangefs_setattr(inode, &iattr);
+		__posix_acl_chmod(&acl, GFP_KERNEL, inode->i_mode);
+	}
 	posix_acl_release(acl);
 	posix_acl_release(default_acl);
 	return inode;
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 55cd6d50eea1..6e0cc01b3a14 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -423,7 +423,6 @@ int orangefs_inode_setxattr(struct inode *inode,
 #define ORANGEFS_GETATTR_SIZE 2
 
 int orangefs_inode_getattr(struct inode *, int);
-int __orangefs_inode_getattr(struct inode *inode, umode_t mode, int flags);
 
 int orangefs_inode_check_changed(struct inode *inode);
 
diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index 334a2fd98c37..46b7dcff18ac 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -233,7 +233,7 @@ static int orangefs_inode_is_stale(struct inode *inode,
 	return 0;
 }
 
-int __orangefs_inode_getattr(struct inode *inode, umode_t mode, int flags)
+int orangefs_inode_getattr(struct inode *inode, int flags)
 {
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
 	struct orangefs_kernel_op_s *new_op;
@@ -369,8 +369,7 @@ int __orangefs_inode_getattr(struct inode *inode, umode_t mode, int flags)
 
 	/* special case: mark the root inode as sticky */
 	inode->i_mode = type | (is_root_handle(inode) ? S_ISVTX : 0) |
-	    orangefs_inode_perms(&new_op->downcall.resp.getattr.attributes) |
-	    mode;
+	    orangefs_inode_perms(&new_op->downcall.resp.getattr.attributes);
 
 	orangefs_inode->getattr_time = jiffies +
 	    orangefs_getattr_timeout_msecs*HZ/1000;
@@ -382,11 +381,6 @@ int __orangefs_inode_getattr(struct inode *inode, umode_t mode, int flags)
 	return ret;
 }
 
-int orangefs_inode_getattr(struct inode *inode, int flags)
-{
-	return __orangefs_inode_getattr(inode, 0, flags);
-}
-
 int orangefs_inode_check_changed(struct inode *inode)
 {
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);

base-commit: 5b52aebef8954cadff29918bb61d7fdc7be07837
-- 
2.34.1

