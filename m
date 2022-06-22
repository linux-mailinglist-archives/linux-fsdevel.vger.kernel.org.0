Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518735554ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 21:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376548AbiFVTqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 15:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376409AbiFVTqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:46:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A5B3FBF2;
        Wed, 22 Jun 2022 12:46:23 -0700 (PDT)
Received: from localhost (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: krisman)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C8F86601736;
        Wed, 22 Jun 2022 20:46:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655927182;
        bh=+ZKL9HDtB8ixIilBthrStw+0LDABivssdB66ZuLZCzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AN1ENUwjaQJvAZzW1SqVGKdeH/sKuItFwqcGMsN7l5ezgbxtmKVx/8OURKrRHwExX
         Qs1OrFnS+GwhkKKbIPaDUBSviY3cZo3v7CTJA6Ayq+L/0qWkxw2DQM+OIfQ1hY6ULz
         KbsMB/SZsXuLP0CkF/CQV0H7+4Rih1MnTE0f56AVlEPUyLkZhoYMXo4iefGinkZEY8
         ufkXGyWzrbxwuPp2OgtvxfaoLVNNqkpOjaMR5GvDjWcZ6cyqW1gNYOKB/B1/Xciih8
         gtpg32k0//8NOXAz+LZUXlXnRgGj9W5EJ6f23wBAQd8fD31ZZc7t7SxnICv5hUbNAG
         09n2s1rgCeJfg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org
Cc:     ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 3/7] libfs: Validate negative dentries in case-insensitive directories
Date:   Wed, 22 Jun 2022 15:45:59 -0400
Message-Id: <20220622194603.102655-4-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622194603.102655-1-krisman@collabora.com>
References: <20220622194603.102655-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 31b0ddf01c31..de43f3f585f1 100644
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

