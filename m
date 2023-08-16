Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A5E77D9AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 07:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241843AbjHPFIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 01:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241814AbjHPFIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 01:08:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F68123;
        Tue, 15 Aug 2023 22:08:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD4492197E;
        Wed, 16 Aug 2023 05:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692162498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+WpWeF/beREB2Fn9GeBuU/+YeiAk2ooPdVMPezCQUNU=;
        b=lm26MfDUBiHQuyHb46zaQ0o6C2cOU0FMGKuUoH5PiNp/835savhoWnQU4yN/xwQp+sgURX
        HJwxuqQSkWegX9sgFI3dP7n6NulUFc/z/stg/WjNWzB40wUHvT8QnccJh7eqR7AgwBubKc
        05pmpGknUCyYROU9sNy4reGD1/4T/9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692162498;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+WpWeF/beREB2Fn9GeBuU/+YeiAk2ooPdVMPezCQUNU=;
        b=hmNCRvvC0SKQcXmET/OnFbvqes+JG+oLvQXYa/0idPerhVvI3iw5xCvUj+5nqfEpBf2ScO
        p+rJlV8dLA6NbRBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A804E133F2;
        Wed, 16 Aug 2023 05:08:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6J9KI8JZ3GQFTwAAMHmgww
        (envelope-from <krisman@suse.de>); Wed, 16 Aug 2023 05:08:18 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        ebiggers@kernel.org, jaegeuk@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v6 7/9] libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
Date:   Wed, 16 Aug 2023 01:08:01 -0400
Message-ID: <20230816050803.15660-8-krisman@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816050803.15660-1-krisman@suse.de>
References: <20230816050803.15660-1-krisman@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Now that casefold needs d_revalidate and calls fscrypt_d_revalidate
itself, generic_encrypt_ci_dentry_ops and generic_ci_dentry_ops are now
equivalent.  Merge them together and simplify the setup code.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
changes since v2:
  - reword comment for clarity (Eric)
---
 fs/libfs.c | 45 +++++++++++++--------------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 994e4c98ec07..e7a44a2be0ee 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1523,7 +1523,7 @@ static int generic_ci_d_revalidate(struct dentry *dentry,
 	return fscrypt_d_revalidate(dentry, name, flags);
 }
 
-static const struct dentry_operations generic_ci_dentry_ops = {
+static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
 	.d_revalidate = generic_ci_d_revalidate,
@@ -1536,26 +1536,19 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
 };
 #endif
 
-#if defined(CONFIG_FS_ENCRYPTION) && IS_ENABLED(CONFIG_UNICODE)
-static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
-	.d_hash = generic_ci_d_hash,
-	.d_compare = generic_ci_d_compare,
-	.d_revalidate = generic_ci_d_revalidate,
-};
-#endif
-
 /**
  * generic_set_encrypted_ci_d_ops - helper for setting d_ops for given dentry
  * @dentry:	dentry to set ops on
  *
- * Casefolded directories need d_hash and d_compare set, so that the dentries
- * contained in them are handled case-insensitively.  Note that these operations
- * are needed on the parent directory rather than on the dentries in it, and
- * while the casefolding flag can be toggled on and off on an empty directory,
- * dentry_operations can't be changed later.  As a result, if the filesystem has
- * casefolding support enabled at all, we have to give all dentries the
- * casefolding operations even if their inode doesn't have the casefolding flag
- * currently (and thus the casefolding ops would be no-ops for now).
+ * Casefolded directories need some dentry_operations set, so that the dentries
+ * contained in them are handled case-insensitively.  Note that d_hash and
+ * d_compare are needed on the parent directory rather than on the dentries in
+ * it, and while the casefolding flag can be toggled on and off on an empty
+ * directory, dentry_operations can't be changed later.  As a result, if the
+ * filesystem has casefolding support enabled at all, we have to give all
+ * dentries the casefolding operations even if their inode doesn't have the
+ * casefolding flag currently (and thus the casefolding ops would be no-ops for
+ * now).
  *
  * Encryption works differently in that the only dentry operation it needs is
  * d_revalidate, which it only needs on dentries that have the no-key name flag.
@@ -1564,34 +1557,22 @@ static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
  * Finally, to maximize compatibility with overlayfs (which isn't compatible
  * with certain dentry operations) and to avoid taking an unnecessary
  * performance hit, we use custom dentry_operations for each possible
- * combination rather than always installing all operations.
+ * combination of operations rather than always installing them.
  */
 void generic_set_encrypted_ci_d_ops(struct dentry *dentry)
 {
-#ifdef CONFIG_FS_ENCRYPTION
-	bool needs_encrypt_ops = dentry->d_flags & DCACHE_NOKEY_NAME;
-#endif
 #if IS_ENABLED(CONFIG_UNICODE)
-	bool needs_ci_ops = dentry->d_sb->s_encoding;
-#endif
-#if defined(CONFIG_FS_ENCRYPTION) && IS_ENABLED(CONFIG_UNICODE)
-	if (needs_encrypt_ops && needs_ci_ops) {
+	if (dentry->d_sb->s_encoding) {
 		d_set_d_op(dentry, &generic_encrypted_ci_dentry_ops);
 		return;
 	}
 #endif
 #ifdef CONFIG_FS_ENCRYPTION
-	if (needs_encrypt_ops) {
+	if (dentry->d_flags & DCACHE_NOKEY_NAME) {
 		d_set_d_op(dentry, &generic_encrypted_dentry_ops);
 		return;
 	}
 #endif
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (needs_ci_ops) {
-		d_set_d_op(dentry, &generic_ci_dentry_ops);
-		return;
-	}
-#endif
 }
 EXPORT_SYMBOL(generic_set_encrypted_ci_d_ops);
 
-- 
2.41.0

