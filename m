Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05656EB617
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Apr 2023 02:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjDVADq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 20:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjDVADd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 20:03:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9632728;
        Fri, 21 Apr 2023 17:03:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6A3491F74A;
        Sat, 22 Apr 2023 00:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682121799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQ2hnOdmsNbOalgg2OMbyQl6sErzhoHUuwjQS8j97Nk=;
        b=BFFUkMJ1mM7zUwoO7pQsExf12xi88DS2xXyZNV7FNQe2tPCYu5DFviHR63leB2aNdNLxTv
        Cy+5M6J0UJGnYrDc9NFhlqmjaQlLZ5v5tD3Q3BDyEBz1R18O1Vdy64FLdBclnhPVCH6QX8
        BVJ/thhQSe5logCbkyLyr5pL7bTju40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682121799;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQ2hnOdmsNbOalgg2OMbyQl6sErzhoHUuwjQS8j97Nk=;
        b=gtw9hA5UoDxnDy6dq4kGmTD0HMrJQA5PKwzHB1peiO1mQBQ+DaGe43T9pDTCPEU7J/+h66
        +ZReDzfsoTb/nqAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 328041358E;
        Sat, 22 Apr 2023 00:03:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qoS1BkckQ2TpdwAAMHmgww
        (envelope-from <krisman@suse.de>); Sat, 22 Apr 2023 00:03:19 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     tytso@mit.edu, jaegeuk@kernel.org, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, krisman@suse.de
Subject: [PATCH v2 5/7] libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
Date:   Fri, 21 Apr 2023 20:03:08 -0400
Message-Id: <20230422000310.1802-6-krisman@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230422000310.1802-1-krisman@suse.de>
References: <20230422000310.1802-1-krisman@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 fs/libfs.c | 44 +++++++++++++-------------------------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 0886044db593..348ec6130198 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1504,7 +1504,7 @@ static inline int generic_ci_d_revalidate(struct dentry *dentry,
 	return fscrypt_d_revalidate(dentry, flags);
 }
 
-static const struct dentry_operations generic_ci_dentry_ops = {
+static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
 	.d_revalidate_name = generic_ci_d_revalidate,
@@ -1517,26 +1517,20 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
 };
 #endif
 
-#if defined(CONFIG_FS_ENCRYPTION) && IS_ENABLED(CONFIG_UNICODE)
-static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
-	.d_hash = generic_ci_d_hash,
-	.d_compare = generic_ci_d_compare,
-	.d_revalidate_name = generic_ci_d_revalidate,
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
+ * Casefolded directories need d_hash, d_compare and d_revalidate set, so
+ * that the dentries contained in them are handled case-insensitively,
+ * but implement support for fs_encryption.  Note that these operations
+ * are needed on the parent directory rather than on the dentries in it,
+ * and while the casefolding flag can be toggled on and off on an empty
+ * directory, dentry_operations can't be changed later.  As a result, if
+ * the filesystem has casefolding support enabled at all, we have to
+ * give all dentries the casefolding operations even if their inode
+ * doesn't have the casefolding flag currently (and thus the casefolding
+ * ops would be no-ops for now).
  *
  * Encryption works differently in that the only dentry operation it needs is
  * d_revalidate, which it only needs on dentries that have the no-key name flag.
@@ -1549,30 +1543,18 @@ static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
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
2.40.0

