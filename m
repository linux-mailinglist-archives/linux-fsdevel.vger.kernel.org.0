Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA5E779C13
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 02:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbjHLAm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 20:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbjHLAmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:42:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F3D3582;
        Fri, 11 Aug 2023 17:42:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A7AE91F38A;
        Sat, 12 Aug 2023 00:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691800927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sTxhaqF5sRXfD/Sz/tp3d/xhC2rVXOn+t3d6w8E4rAo=;
        b=X8tB+eKLTTO897QOvQSA84RZHzPqH9/rqG0UZPdDtiaDP7unm/zP2xCocNDYKUbwpbfsTe
        Cp5Kzt3MQnBuvdPcAgwy8jaRWuaBG/EXL9V4LJbLhUJit6Ojr4p2qnJAGzSFRBMkpK1SIG
        mAq5HMRJiKBD4Vwo4DgbJ8+5ww6m08I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691800927;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sTxhaqF5sRXfD/Sz/tp3d/xhC2rVXOn+t3d6w8E4rAo=;
        b=WgVIEOryp4HKOjylausdq6/ZDFC+LngfMkSsLq62KITN3Vx3He6okdRjHVstf/tRXvDrZy
        ZzklrOajizMRl0Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7232013592;
        Sat, 12 Aug 2023 00:42:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6vxRFl/V1mQsEAAAMHmgww
        (envelope-from <krisman@suse.de>); Sat, 12 Aug 2023 00:42:07 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        ebiggers@kernel.org, jaegeuk@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v5 08/10] libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
Date:   Fri, 11 Aug 2023 20:41:44 -0400
Message-ID: <20230812004146.30980-9-krisman@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230812004146.30980-1-krisman@suse.de>
References: <20230812004146.30980-1-krisman@suse.de>
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
index efb245118d10..6b15a4f0312f 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1516,7 +1516,7 @@ static int generic_ci_d_revalidate(struct dentry *dentry,
 	return fscrypt_d_revalidate(dentry, name, flags);
 }
 
-static const struct dentry_operations generic_ci_dentry_ops = {
+static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
 	.d_revalidate = generic_ci_d_revalidate,
@@ -1529,26 +1529,19 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
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
@@ -1557,34 +1550,22 @@ static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
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

