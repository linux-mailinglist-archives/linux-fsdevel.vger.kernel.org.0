Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C428669603
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbjAMLwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241123AbjAMLwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D6F111A
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:49:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63AE56155D
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26A1C433F2;
        Fri, 13 Jan 2023 11:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610583;
        bh=OazUfUQ09t8QUMq++vwE/tPHDEE4kc6T6cKee67MOnE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=f/U8miDqzryM68a7gLvOUa7Q2o0x+khyQWWkdt2jj+ReZiYEqB6qqbh9z15hGM68z
         Vac4zQ0qrBhP+cYnBGM1X8WJ+U/AIMRytHSuaoeKcePjd9kxxQfJtczU4Qpe4pS8bU
         eF1M34qeiIAoxvHuaXCUd00IKZ12XhRI70r6/o3MAAe3hCmU2Bu5t+CDEUuj7e8yIi
         pDzaMJF8Hn8IwE4aO0MPV3bCQDVsiYPY6nRl+HqAQ1WhbA4D18bMPDg1OeCRetTc7m
         bT4oKSOO+XeASRx/UgSnYmZoMlLLfC/k7Kj5HXZtVkLE1xwmZmVidLz7GojhJSOTbY
         qlu3ciV5xHSJQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:09 +0100
Subject: [PATCH 01/25] f2fs: project ids aren't idmapped
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-1-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=1031; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OazUfUQ09t8QUMq++vwE/tPHDEE4kc6T6cKee67MOnE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA2UXvrBespmtaczJn96HXmkdHGo6OegFO3Co4sv//wv
 que9qKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiln8YGV5s2LTBpvSF2mS96EmaFe
 /ahXfbTNyvu2/9t6xnmd2ztk5k+M2akBn3b3fmnl2flVl6dysnutwvT1oa6fK88mPV4eYffcwA
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

Project ids are only settable filesystem wide in the initial namespace.
They don't take the mount's idmapping into account.

Note, that after we converted everything over to struct mnt_idmap
mistakes such as the one here aren't possible anymore as struct
mnt_idmap cannot be passed to functions that operate on k{g,u}ids.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/f2fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 6032589099ce..30baa0e2a21c 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -246,7 +246,7 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
 		(F2FS_I(dir)->i_flags & F2FS_PROJINHERIT_FL))
 		F2FS_I(inode)->i_projid = F2FS_I(dir)->i_projid;
 	else
-		F2FS_I(inode)->i_projid = make_kprojid(mnt_userns,
+		F2FS_I(inode)->i_projid = make_kprojid(&init_user_ns,
 							F2FS_DEF_PROJID);
 
 	err = fscrypt_prepare_new_inode(dir, inode, &encrypt);

-- 
2.34.1

