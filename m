Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E011D41C307
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 12:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245597AbhI2K4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 06:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245590AbhI2K4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 06:56:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C196FC06161C;
        Wed, 29 Sep 2021 03:54:30 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2401:4900:1c20:3124:6d32:b2f4:daed:4666])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DD8A41F43F97;
        Wed, 29 Sep 2021 11:54:24 +0100 (BST)
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     tytso@mit.edu, viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        krisman@collabora.com
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH 1/2] fs: dcache: Handle case-exact lookup in d_alloc_parallel
Date:   Wed, 29 Sep 2021 16:23:38 +0530
Message-Id: <0b8fd2677b797663bfcb97f6aa108193fedf9767.1632909358.git.shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1632909358.git.shreeya.patel@collabora.com>
References: <cover.1632909358.git.shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a soft hang caused by a deadlock in d_alloc_parallel which
waits up on lookups to finish for the dentries in the parent directory's
hash_table.
In case when d_add_ci is called from the fs layer's lookup functions,
the dentry being looked up is already in the hash table (created before
the fs lookup function gets called). We should not be processing the
same dentry that is being looked up, hence, in case of case-insensitive
filesystems we are making it a case-exact match to prevent this from
happening.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 fs/dcache.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index cf871a81f4fd..2a28ab64a165 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2565,6 +2565,15 @@ static void d_wait_lookup(struct dentry *dentry)
 	}
 }
 
+static inline bool d_same_exact_name(const struct dentry *dentry,
+				     const struct dentry *parent,
+				     const struct qstr *name)
+{
+	if (dentry->d_name.len != name->len)
+		return false;
+	return dentry_cmp(dentry, name->name, name->len) == 0;
+}
+
 struct dentry *d_alloc_parallel(struct dentry *parent,
 				const struct qstr *name,
 				wait_queue_head_t *wq)
@@ -2575,6 +2584,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	struct dentry *new = d_alloc(parent, name);
 	struct dentry *dentry;
 	unsigned seq, r_seq, d_seq;
+	int ci_dir = IS_CASEFOLDED(parent->d_inode);
 
 	if (unlikely(!new))
 		return ERR_PTR(-ENOMEM);
@@ -2626,8 +2636,14 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 			continue;
 		if (dentry->d_parent != parent)
 			continue;
-		if (!d_same_name(dentry, parent, name))
-			continue;
+		if (ci_dir) {
+			if (!d_same_exact_name(dentry, parent, name))
+				continue;
+		} else {
+			if (!d_same_name(dentry, parent, name))
+				continue;
+		}
+
 		hlist_bl_unlock(b);
 		/* now we can try to grab a reference */
 		if (!lockref_get_not_dead(&dentry->d_lockref)) {
-- 
2.30.2

