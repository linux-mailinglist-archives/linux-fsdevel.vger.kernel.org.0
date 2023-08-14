Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603B877BFDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 20:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjHNS3u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 14:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjHNS3i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:29:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FB7E73;
        Mon, 14 Aug 2023 11:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 856176577C;
        Mon, 14 Aug 2023 18:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E8DC433CA;
        Mon, 14 Aug 2023 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692037777;
        bh=TwLV5UwTulr/DDiB634rcf+NgwfPvOt5lHyqVyHUL/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJAA8GczDBa0f8X2Pqv9nyTEui8jCtPFWj0e9Ple1qHue9uONq19sLDMI17uyO07+
         TXHjb90lEzczne07U5ml1GpJRfcN/NuF7kygZgI32FsFkZ8zp5e3ZwJQvQhK5MSNcQ
         unbS7+Bi6Tj97vMm1gviMijGdn+cPMkmWj/9NQYo49PWLgirKuescuU2PvlkOsfA95
         8sx/kgDgan/zz7juyAhnjjtmupZMR78e9AkCFXkX1pKuvAQEAltroGj5p6Hpl+D2C6
         sDjjeIkULyfYncQaAIuwiMj3+xZ42lbv6kgsQzbOTfkwCNAFE+/ePXqWWxh7H39Tq5
         q8HEhvLosPZWA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH 2/3] ext4: remove redundant checks of s_encoding
Date:   Mon, 14 Aug 2023 11:29:02 -0700
Message-ID: <20230814182903.37267-3-ebiggers@kernel.org>
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

Now that ext4 does not allow inodes with the casefold flag to be
instantiated when unsupported, it's unnecessary to repeatedly check for
support later on during random filesystem operations.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/hash.c  | 2 +-
 fs/ext4/namei.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index 46c3423ddfa1..deabe29da7fb 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -300,7 +300,7 @@ int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 	unsigned char *buff;
 	struct qstr qstr = {.name = name, .len = len };
 
-	if (len && IS_CASEFOLDED(dir) && um &&
+	if (len && IS_CASEFOLDED(dir) &&
 	   (!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir))) {
 		buff = kzalloc(sizeof(char) * PATH_MAX, GFP_KERNEL);
 		if (!buff)
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 0caf6c730ce3..f9a5663b9d23 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1445,7 +1445,7 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 	struct dx_hash_info *hinfo = &name->hinfo;
 	int len;
 
-	if (!IS_CASEFOLDED(dir) || !dir->i_sb->s_encoding ||
+	if (!IS_CASEFOLDED(dir) ||
 	    (IS_ENCRYPTED(dir) && !fscrypt_has_encryption_key(dir))) {
 		cf_name->name = NULL;
 		return 0;
@@ -1496,7 +1496,7 @@ static bool ext4_match(struct inode *parent,
 #endif
 
 #if IS_ENABLED(CONFIG_UNICODE)
-	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent) &&
+	if (IS_CASEFOLDED(parent) &&
 	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
 		if (fname->cf_name.name) {
 			struct qstr cf = {.name = fname->cf_name.name,
@@ -2393,7 +2393,7 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 
 #if IS_ENABLED(CONFIG_UNICODE)
 	if (sb_has_strict_encoding(sb) && IS_CASEFOLDED(dir) &&
-	    sb->s_encoding && utf8_validate(sb->s_encoding, &dentry->d_name))
+	    utf8_validate(sb->s_encoding, &dentry->d_name))
 		return -EINVAL;
 #endif
 
-- 
2.41.0

