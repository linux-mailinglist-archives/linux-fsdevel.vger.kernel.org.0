Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE375BC5C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 11:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiISJtg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 05:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiISJtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:49:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8215BD5
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 02:49:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3785EB818A2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 09:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A649EC433C1;
        Mon, 19 Sep 2022 09:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663580965;
        bh=jqOw/lhGPxoVYYIIrji6Poc8TGW9Aq5/f8L0fS1L9xI=;
        h=From:To:Cc:Subject:Date:From;
        b=T8eCNdeEzrvaYOE6+0M+Cjb7wrZtejvZLrE3T4umwjvmsSPnVJC1VzuLw6P9imFEV
         Yrq7S4HgUzxn0gWgCUdSjNOIRnNP20NQoymJirTpe9doxqbbeAdqmgkZX9j4kdFLIt
         ArRIKybhdZMlQYcUnrCgqqSjA0udGVN/+ZlrtA4UvIDyKHhsbD7RYclUcz7pkyQfMu
         gRoqM2PnpPeUkwVwuzvNeXBIhBvY5cgLUMMLRkdn6/yEgjh7BqwWLruRyb59qTnfOF
         ZJLNOipqwnG1qtYz3KFX2cjV8+FBxs1Mz1Ap2eaHoAcSlqpAue1bnG1uvSJjMMhFoy
         XB5Px4Mgx/rqw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] xattr: always us is_posix_acl_xattr() helper
Date:   Mon, 19 Sep 2022 11:49:14 +0200
Message-Id: <20220919094914.1174728-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The is_posix_acl_xattr() helper was added in 0c5fd887d2bb ("acl: move
idmapped mount fixup into vfs_{g,s}etxattr()") to remove the open-coded
checks for POSIX ACLs. We missed to update two locations. Switch them to
use the helper.

Cc: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/xattr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index a1f4998bc6be..01aa45cea83c 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -587,9 +587,7 @@ int setxattr_copy(const char __user *name, struct xattr_ctx *ctx)
 static void setxattr_convert(struct user_namespace *mnt_userns,
 			     struct dentry *d, struct xattr_ctx *ctx)
 {
-	if (ctx->size &&
-		((strcmp(ctx->kname->name, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
-		(strcmp(ctx->kname->name, XATTR_NAME_POSIX_ACL_DEFAULT) == 0)))
+	if (ctx->size && is_posix_acl_xattr(ctx->kname->name))
 		posix_acl_fix_xattr_from_user(ctx->kvalue, ctx->size);
 }
 
@@ -705,8 +703,7 @@ do_getxattr(struct user_namespace *mnt_userns, struct dentry *d,
 
 	error = vfs_getxattr(mnt_userns, d, kname, ctx->kvalue, ctx->size);
 	if (error > 0) {
-		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
-		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
+		if (is_posix_acl_xattr(kname))
 			posix_acl_fix_xattr_to_user(ctx->kvalue, error);
 		if (ctx->size && copy_to_user(ctx->value, ctx->kvalue, error))
 			error = -EFAULT;

base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.34.1

