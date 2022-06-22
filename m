Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DA65554EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 21:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354197AbiFVTq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 15:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352333AbiFVTqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:46:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5A522B0B;
        Wed, 22 Jun 2022 12:46:20 -0700 (PDT)
Received: from localhost (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: krisman)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4DE9C66016F7;
        Wed, 22 Jun 2022 20:46:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655927179;
        bh=HAicmnDTWWajqPFt32opP8XSXWOdsqjYOr5lPMSjCC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bjq2bJZFyDgthN8mhd3Gfuxf+h9t36pUy7vflqdPWhhUWe19PkfnPzQooeqVa8Y6D
         vQF2dEmDaCoxSB8EhamHfXjlp2zb6wyiOVr2XEwACiKI2TFLIzglSxhlgwrDmDeu8v
         FwlCzV4v44eC/7r5ZM0oBd0H4lSY38azEDOgv4RV7TCEUWn3dvKPXXV3ld+05qeuXz
         7eIC+yc69Unwxo+oBg0tnkEXiM5JHTI3E8GEdbHX/gh9uGTMgqTzuOQP9/KrqaskOr
         kAyeiuN5uAvq2PmCXw0lXcMGdCXoXfBlcGQO6qlG+ty+7bnCuC2rr/RwS2klIAc2oW
         w7L/3SSFPQ1dw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org
Cc:     ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 2/7] fs: Add DCACHE_CASEFOLD_LOOKUP flag
Date:   Wed, 22 Jun 2022 15:45:58 -0400
Message-Id: <20220622194603.102655-3-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622194603.102655-1-krisman@collabora.com>
References: <20220622194603.102655-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This flag marks a negative or positive dentry as being created after a
case-insensitive lookup operation.  It is useful to differentiate
dentries this way to detect whether the negative dentry can be trusted
during a case-insensitive lookup.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/dcache.c            | 7 +++++++
 include/linux/dcache.h | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index a0fe9e3676fb..518ddb7fbe0c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1958,6 +1958,13 @@ void d_set_fallthru(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_set_fallthru);
 
+void d_set_casefold_lookup(struct dentry *dentry)
+{
+	spin_lock(&dentry->d_lock);
+	dentry->d_flags |= DCACHE_CASEFOLD_LOOKUP;
+	spin_unlock(&dentry->d_lock);
+}
+
 static unsigned d_flags_for_inode(struct inode *inode)
 {
 	unsigned add_flags = DCACHE_REGULAR_TYPE;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 871f65c8ef7f..8b71c5e418c2 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -208,6 +208,7 @@ struct dentry_operations {
 #define DCACHE_FALLTHRU			0x01000000 /* Fall through to lower layer */
 #define DCACHE_NOKEY_NAME		0x02000000 /* Encrypted name encoded without key */
 #define DCACHE_OP_REAL			0x04000000
+#define DCACHE_CASEFOLD_LOOKUP		0x08000000 /* Dentry comes from a casefold directory */
 
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		0x20000000
@@ -497,6 +498,13 @@ static inline bool d_is_fallthru(const struct dentry *dentry)
 	return dentry->d_flags & DCACHE_FALLTHRU;
 }
 
+extern void d_set_casefold_lookup(struct dentry *dentry);
+
+static inline bool d_is_casefold_lookup(const struct dentry *dentry)
+{
+	return dentry->d_flags & DCACHE_CASEFOLD_LOOKUP;
+}
+
 
 extern int sysctl_vfs_cache_pressure;
 
-- 
2.36.1

