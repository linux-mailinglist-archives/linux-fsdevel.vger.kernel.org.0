Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDD977D99F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 07:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241842AbjHPFIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 01:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241813AbjHPFIT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 01:08:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BFE19A7;
        Tue, 15 Aug 2023 22:08:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 60BB01FD68;
        Wed, 16 Aug 2023 05:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692162497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jfWn+nVnv3+8SQpKCe+L3XufWL8bAoo1SnGSq8hl/Lo=;
        b=uHk9/NDXy54Ps3hgFUM7ZmkOyUwDGzc2LYEjh1QTroGoBAOPsmDp/tn6Dqvps2Ro00Upls
        eWarw5OENO9wdPnP96JNE/BmvT0YSbezK9yPuwRpaVU+WGSjkf1x+rNiRSySipYz+x4g4A
        IW51xHtfDGXwDT6E2kjtTQ4HHvOSc2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692162497;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jfWn+nVnv3+8SQpKCe+L3XufWL8bAoo1SnGSq8hl/Lo=;
        b=6+OtEpZaQ8VZp1D1MHeDTr/KKhSlreUog2bxmATSI1pXWcgAtXZ/V98PeaadOzgBEJ7J2a
        W81afJNVNFNu86Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29969133F2;
        Wed, 16 Aug 2023 05:08:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id shOlBMFZ3GQBTwAAMHmgww
        (envelope-from <krisman@suse.de>); Wed, 16 Aug 2023 05:08:17 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        ebiggers@kernel.org, jaegeuk@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v6 6/9] libfs: Chain encryption checks after case-insensitive revalidation
Date:   Wed, 16 Aug 2023 01:08:00 -0400
Message-ID: <20230816050803.15660-7-krisman@suse.de>
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

Support encrypted dentries in generic_ci_d_revalidate by chaining
fscrypt_d_revalidate at the tail of the d_revalidate.  This allows
filesystem to just call generic_ci_d_revalidate and let it handle any
case-insensitive dentry (encrypted or not).

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Enable negative dentries of encrypted filesystems (Eric)
---
 fs/libfs.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 26bf1b832b0a..994e4c98ec07 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1462,9 +1462,8 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	return 0;
 }
 
-static int generic_ci_d_revalidate(struct dentry *dentry,
-				   const struct qstr *name,
-				   unsigned int flags)
+static int ci_d_revalidate(struct dentry *dentry, const struct qstr *name,
+			   unsigned int flags)
 {
 	const struct dentry *parent;
 	const struct inode *dir;
@@ -1515,6 +1514,15 @@ static int generic_ci_d_revalidate(struct dentry *dentry,
 	return 1;
 }
 
+static int generic_ci_d_revalidate(struct dentry *dentry,
+				   const struct qstr *name,
+				   unsigned int flags)
+{
+	if (!ci_d_revalidate(dentry, name, flags))
+		return 0;
+	return fscrypt_d_revalidate(dentry, name, flags);
+}
+
 static const struct dentry_operations generic_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
@@ -1532,7 +1540,7 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
 static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
-	.d_revalidate = fscrypt_d_revalidate,
+	.d_revalidate = generic_ci_d_revalidate,
 };
 #endif
 
-- 
2.41.0

