Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF8B77D99E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 07:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbjHPFIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 01:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241816AbjHPFIY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 01:08:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E665123;
        Tue, 15 Aug 2023 22:08:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01A001FD69;
        Wed, 16 Aug 2023 05:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692162502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fAKJMliuplYWQDoWYsulN2iGzcJARjx0CuuXblbXYuU=;
        b=PC1i8Yq9/pXBFy33eGdFQnp0RR1fe0b4yV5u4AJIBUCTXIKWFc4V4xndaSo4eA7w81ojHe
        lrhz3VIfySAORxWwRMsdFnM18OsTIVMiNN7RC+HNCI3OXLWa/uNaeambLeMB+08iz0F24g
        3G5pDtuwzT4jdYEmSAOMM28WzJ9RFXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692162502;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fAKJMliuplYWQDoWYsulN2iGzcJARjx0CuuXblbXYuU=;
        b=zZIuF8NUL4aI5eai5vVdfOKHZAjXYanheIqAkAN4i2hQbFD4ERfdQ6wEUtz0hyif9dVCwG
        ofFewuC7mEIxiXDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFAA0133F2;
        Wed, 16 Aug 2023 05:08:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iu43KMVZ3GQRTwAAMHmgww
        (envelope-from <krisman@suse.de>); Wed, 16 Aug 2023 05:08:21 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        ebiggers@kernel.org, jaegeuk@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v6 9/9] f2fs: Enable negative dentries on case-insensitive lookup
Date:   Wed, 16 Aug 2023 01:08:03 -0400
Message-ID: <20230816050803.15660-10-krisman@suse.de>
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

Instead of invalidating negative dentries during case-insensitive
lookups, mark them as such and let them be added to the dcache.
d_ci_revalidate is able to properly filter them out if necessary based
on the dentry casefold flag.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v5:
  - Use IS_CASEFOLDED directly (eric)
Changes since v4:
  - Use helper to decide if should set dentry flag.

Changes since v2:
  - Move dentry flag set closer to fscrypt code (Eric)
---
 fs/f2fs/namei.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index bee0568888da..bf026ea2f220 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -533,6 +533,10 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 
 	err = f2fs_prepare_lookup(dir, dentry, &fname);
 	generic_set_encrypted_ci_d_ops(dentry);
+
+	if (IS_CASEFOLDED(dir))
+		d_set_casefolded_name(dentry);
+
 	if (err == -ENOENT)
 		goto out_splice;
 	if (err)
@@ -578,17 +582,6 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out_iput;
 	}
 out_splice:
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (!inode && IS_CASEFOLDED(dir)) {
-		/* Eventually we want to call d_add_ci(dentry, NULL)
-		 * for negative dentries in the encoding case as
-		 * well.  For now, prevent the negative dentry
-		 * from being cached.
-		 */
-		trace_f2fs_lookup_end(dir, dentry, ino, err);
-		return NULL;
-	}
-#endif
 	new = d_splice_alias(inode, dentry);
 	trace_f2fs_lookup_end(dir, !IS_ERR_OR_NULL(new) ? new : dentry,
 				ino, IS_ERR(new) ? PTR_ERR(new) : err);
@@ -641,16 +634,6 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	f2fs_delete_entry(de, page, dir, inode);
 	f2fs_unlock_op(sbi);
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	/* VFS negative dentries are incompatible with Encoding and
-	 * Case-insensitiveness. Eventually we'll want avoid
-	 * invalidating the dentries here, alongside with returning the
-	 * negative dentries at f2fs_lookup(), when it is better
-	 * supported by the VFS for the CI case.
-	 */
-	if (IS_CASEFOLDED(dir))
-		d_invalidate(dentry);
-#endif
 	if (IS_DIRSYNC(dir))
 		f2fs_sync_fs(sbi->sb, 1);
 fail:
-- 
2.41.0

