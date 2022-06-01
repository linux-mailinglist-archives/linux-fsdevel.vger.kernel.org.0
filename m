Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF6D53AE4E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 22:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiFAUsi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 16:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiFAUrp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:47:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECB91E1777;
        Wed,  1 Jun 2022 13:45:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 36E601F438C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654116292;
        bh=MlhhI4KNumY+gCoHEanKUqEAs+Rh5WqCT1slFMX1xD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atMZNmTS2/Z3FB/qUsDTkwAy3b75U/OSvu1g9Nm5kWX+CCnCF0mvO8wFqTYFJQJU9
         dPSbFJGLpoqw8BN0NCpKT5TOYiUC1Wr/p7csdxOB1r/JZ+ttjb+QjtZ1Mw+XJDyQ4J
         FT0Z73eO8iLzs57BPjCOvg5WgRrXk/5QqZtVhhxmMfL8E6AlW68vo/UK7m7KsXTgdi
         +LbFAncbQHP565b1R7phYlcfr5yfpmlOqgL7lTMIYelxBcdRleePeylucRG+Rt8tOi
         Y11IQzPWUjVVzbZ8QKUD/gOP5F+8D3K9brmubrbRGUWcnqURoQ7xXfO+3+YIX70AmL
         6c9oMKvyEUQ4Q==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org
Cc:     ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 3/7] libfs: Validate negative dentries in case-insensitive directories
Date:   Wed,  1 Jun 2022 16:44:33 -0400
Message-Id: <20220601204437.676872-4-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601204437.676872-1-krisman@collabora.com>
References: <20220601204437.676872-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a dentry revalidation helper to be used by case-insensitive
filesystems to check if it is safe to reuse a negative dentry.

A negative dentry is safe to be reused on a case-insensitive lookup if
it was created during a case-insensitive lookup and this is not a lookup
that will instantiate a dentry. If this is a creation lookup, we also
need to make sure the name matches sensitively the name under lookup in
order to assure the name preserving semantics.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/libfs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index e64bdedef168..618a85c08aa7 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1450,9 +1450,33 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	return 0;
 }
 
+static inline int generic_ci_d_revalidate(struct dentry *dentry,
+					  const struct qstr *name,
+					  unsigned int flags)
+{
+	int is_creation = flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET);
+
+	if (d_is_negative(dentry)) {
+		const struct dentry *parent = READ_ONCE(dentry->d_parent);
+		const struct inode *dir = READ_ONCE(parent->d_inode);
+
+		if (dir && needs_casefold(dir)) {
+			if (!d_is_casefold_lookup(dentry))
+				return 0;
+
+			if (is_creation &&
+			    (dentry->d_name.len != name->len ||
+			     memcmp(dentry->d_name.name, name->name, name->len)))
+				return 0;
+		}
+	}
+	return 1;
+}
+
 static const struct dentry_operations generic_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
+	.d_revalidate_name = generic_ci_d_revalidate,
 };
 #endif
 
-- 
2.36.1

