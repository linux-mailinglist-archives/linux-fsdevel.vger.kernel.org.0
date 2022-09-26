Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335BD5EAAF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbiIZP0O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 11:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbiIZPYM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:24:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A421F33E03;
        Mon, 26 Sep 2022 07:09:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC40EB80AC8;
        Mon, 26 Sep 2022 14:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58F7C433D7;
        Mon, 26 Sep 2022 14:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664201388;
        bh=b18oPKBJ3iFitrZzcDI3d11KJokB4RPI5hri3MTK7K4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KApNOAvE9cOnQBtsza3kHjy85B0EOpyJFKLNKj/1yomP6QGAaVZHGnK14CyfvrVRo
         BxqNu6Cq9KJTAny4pqEPkLTDxr4xpOyclCDuJBBrDduuo4TIMjSK+VH1YGSOq6mE1C
         nhY8hZj+O5z9u8Nd2bdt3/vJV/wnFEipCwCV8f+8Rws4aCu0ZXQBF9zDQX6cXoRH3h
         gVkv2jqTA8eiYIWv68lNzXSb7ZiXwVJ1HSyNeRFUL61trLRzHCKU6PAjhPIxMw6Qg9
         ycYLG1tC2NBj0B6AUz45YVb2Mqmd1aN1rTRdmHTsVPSn9MLIgrpkPK6QOKLOA+FVTF
         ZuWErS6JqHBJg==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 26/30] ecryptfs: use stub posix acl handlers
Date:   Mon, 26 Sep 2022 16:08:23 +0200
Message-Id: <20220926140827.142806-27-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140827.142806-1-brauner@kernel.org>
References: <20220926140827.142806-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=827; i=brauner@kernel.org; h=from:subject; bh=b18oPKBJ3iFitrZzcDI3d11KJokB4RPI5hri3MTK7K4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQbbnL6Me8d14y2Fzc21caq2sbWzty6n7Xrn+b/B/Uzc/KO Tmx521HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR7gRGhuNKk2fOZcjaEbe7b1rb55 mNbJum3qg4uMhkQ25bxXfhs8UM/0s11G79OKTYkd5iVxfVk8d/JnBVqu2Tc7NnR63x0TpuwQ4A
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

Now that ecryptfs supports the get and set acl inode operations and the
vfs has been switched to the new posi api, ecryptfs can simply rely on
the stub posix acl handlers.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged

 fs/ecryptfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index c3d1ae688a19..bd6ae2582cd6 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1210,6 +1210,10 @@ static const struct xattr_handler ecryptfs_xattr_handler = {
 };
 
 const struct xattr_handler *ecryptfs_xattr_handlers[] = {
+#ifdef CONFIG_XFS_POSIX_ACL
+	&posix_acl_access_xattr_handler,
+	&posix_acl_default_xattr_handler,
+#endif
 	&ecryptfs_xattr_handler,
 	NULL
 };
-- 
2.34.1

