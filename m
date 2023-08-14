Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9145677BFD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 20:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjHNS3u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 14:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjHNS3j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:29:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E62DE7E;
        Mon, 14 Aug 2023 11:29:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6720657DB;
        Mon, 14 Aug 2023 18:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2DCC433C8;
        Mon, 14 Aug 2023 18:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692037777;
        bh=ZmG/XvBXL8nYb0AYKa5yxa3KEb90q7gpbLYhFxe+7hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPu3Z7xOTiw1V2P9IGJ3Zq6It/yKQDOl4S8w4vkx/8uUbODyhlazNrBFDQfieMUVR
         6lGqwV/MTV1XwfMAF/HwwqTf7NRlJsfT2gKH+EO7UgwjeTe06UCnFwv9NJCnH8/sPx
         RaLyBmG+bXYvYG26NH9t31zsEISCLes66ViCdisW7axIPpYcUE0FnhTr4vFIPEP36k
         rTa8YfV8vYcsC+tr9E++6x84YjtCGpiYdK+Tq0iSfxgADjUIoxpamwtwvDi8nkud4s
         KX3gTW43S0vV9fDGLakOvExRU/BUGTaWLGjZELMqh0Q780fCr7dkN4A36rOQ3hrpPH
         3FHTRoSqZkmDQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH 3/3] libfs: remove redundant checks of s_encoding
Date:   Mon, 14 Aug 2023 11:29:03 -0700
Message-ID: <20230814182903.37267-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814182903.37267-1-ebiggers@kernel.org>
References: <20230814182903.37267-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that neither ext4 nor f2fs allows inodes with the casefold flag to
be instantiated when unsupported, it's unnecessary to repeatedly check
for support later on during random filesystem operations.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/libfs.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 5b851315eeed..5197ea8c66d3 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1381,16 +1381,6 @@ bool is_empty_dir_inode(struct inode *inode)
 }
 
 #if IS_ENABLED(CONFIG_UNICODE)
-/*
- * Determine if the name of a dentry should be casefolded.
- *
- * Return: if names will need casefolding
- */
-static bool needs_casefold(const struct inode *dir)
-{
-	return IS_CASEFOLDED(dir) && dir->i_sb->s_encoding;
-}
-
 /**
  * generic_ci_d_compare - generic d_compare implementation for casefolding filesystems
  * @dentry:	dentry whose name we are checking against
@@ -1411,7 +1401,7 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 	char strbuf[DNAME_INLINE_LEN];
 	int ret;
 
-	if (!dir || !needs_casefold(dir))
+	if (!dir || !IS_CASEFOLDED(dir))
 		goto fallback;
 	/*
 	 * If the dentry name is stored in-line, then it may be concurrently
@@ -1453,7 +1443,7 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	const struct unicode_map *um = sb->s_encoding;
 	int ret = 0;
 
-	if (!dir || !needs_casefold(dir))
+	if (!dir || !IS_CASEFOLDED(dir))
 		return 0;
 
 	ret = utf8_casefold_hash(um, dentry, str);
-- 
2.41.0

