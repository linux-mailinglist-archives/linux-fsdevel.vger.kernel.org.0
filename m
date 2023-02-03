Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BD168A426
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 22:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjBCVDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 16:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjBCVCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:02:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D345BAE868;
        Fri,  3 Feb 2023 13:01:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7DC3D5C344;
        Fri,  3 Feb 2023 21:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1675458065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NbJ8A7z8OuIv+MdnkMNKw5FRm+lvF7JY4gxwIronnVI=;
        b=ce4uKgVbpi/C7iswQ4w2hmqw5AERgDlwLmsxLhsNG9XzA2Cs+yMdYNxuqVqhhivMUaaThu
        DDBrpxmdV2q7iF3Cihhvy5UQbeV8+bGp8qa4ViP4rCK63x/XaexdByB/TcJ5v/LQj7IXNF
        M6BH3fFK8N+3zFpek9wOCWm/ZjWbEDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1675458065;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NbJ8A7z8OuIv+MdnkMNKw5FRm+lvF7JY4gxwIronnVI=;
        b=oYtHj8ESCbnCzDrWnQsC8plCxvJxONqie2yhTg2S14+cejnGgzdEt3pvquAToiYfDTyXcp
        5QkpH8uOuYWBt9AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C9371358A;
        Fri,  3 Feb 2023 21:01:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xUrWMRB23WP0JgAAMHmgww
        (envelope-from <krisman@suse.de>); Fri, 03 Feb 2023 21:01:04 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org,
        ebiggers@kernel.org, jack@suse.cz
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 4/7] libfs: Support revalidation of encrypted case-insensitive dentries
Date:   Fri,  3 Feb 2023 18:00:36 -0300
Message-Id: <20230203210039.16289-5-krisman@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230203210039.16289-1-krisman@suse.de>
References: <20230203210039.16289-1-krisman@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Preserve the existing behavior for encrypted directories, by rejecting
negative dentries of encrypted+casefolded directories.  This allows
generic_ci_d_revalidate to be used by filesystems with both features
enabled, as long as the directory is either casefolded or encrypted, but
not both at the same time.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/libfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index e3daca88d1d3..26a06fd5f5a1 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1478,6 +1478,9 @@ static inline int generic_ci_d_revalidate(struct dentry *dentry,
 		const struct inode *dir = READ_ONCE(parent->d_inode);
 
 		if (dir && needs_casefold(dir)) {
+			if (IS_ENCRYPTED(dir))
+				return 0;
+
 			if (!d_is_casefold_lookup(dentry))
 				return 0;
 
@@ -1487,7 +1490,8 @@ static inline int generic_ci_d_revalidate(struct dentry *dentry,
 				return 0;
 		}
 	}
-	return 1;
+
+	return fscrypt_d_revalidate(dentry, flags);
 }
 
 static const struct dentry_operations generic_ci_dentry_ops = {
@@ -1507,7 +1511,7 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
 static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
-	.d_revalidate = fscrypt_d_revalidate,
+	.d_revalidate_name = generic_ci_d_revalidate,
 };
 #endif
 
-- 
2.35.3

