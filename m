Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC2E6BBFDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 23:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjCOWfm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 18:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjCOWff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:35:35 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A4E1A64C;
        Wed, 15 Mar 2023 15:35:32 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so3773797pjt.5;
        Wed, 15 Mar 2023 15:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678919732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0koife/nlE14fvbjfnK84DaRRasyA0xRR/jJ0/e5jM=;
        b=yS98LTZCIJvFjR9AASnXaH684TaFHs+ujYhE5YFAD4cT1iMWUWzQwCfl+W1vXHib6Z
         /AcO6bE2jrh3G4KUuA3QvHyPP09K1LsZnuPQa33y3Z2c9tfQtOZdJfEsU/Q37wh/7UBD
         UUXtysVqxshIWYg2dK5x0A7vS4eLCtUfWpSi4kz4C+ILHI9Sq8n+ah8tBy9Mp/hkrG8+
         dS+F2kHvV+4S8CPT5xLJghUq8wclRdNgoUZhATL4qOv0m9tsy/+nzgNM1EGPje+B1Suz
         OM2zIK5odvugwPwwE79mtO6Wno9Op7LUWUt55Xl9fK+QWMO6oLwCClf7E+1o8srAuEuD
         P+Lw==
X-Gm-Message-State: AO0yUKX5Y7B2eRf6HIDvFo33UJE5yOZgky0FiwGP6Abvj64Rmn3IkvJ+
        6XzMG7BATxa9zDNqjAK6cMw=
X-Google-Smtp-Source: AK7set9B/YQ/PBUMKpKxkVmqwVhindrUUADKuCvN2ZSaf4Gk2VJfd0h2KRJbbtSA5xWJBRYx7xnqkQ==
X-Received: by 2002:a05:6a20:3d15:b0:d6:4003:e386 with SMTP id y21-20020a056a203d1500b000d64003e386mr1832718pzi.48.1678919732304;
        Wed, 15 Mar 2023 15:35:32 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id c12-20020aa781cc000000b005dc70330d9bsm4034369pfn.26.2023.03.15.15.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 15:35:32 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
        brauner@kernel.org, Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v8 2/3] fs: introduce lock_rename_child() helper
Date:   Thu, 16 Mar 2023 07:34:34 +0900
Message-Id: <20230315223435.5139-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315223435.5139-1-linkinjeon@kernel.org>
References: <20230315223435.5139-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Pass the dentry of a source file and the dentry of a destination directory
to lock parent inodes for rename. As soon as this function returns,
->d_parent of the source file dentry is stable and inodes are properly
locked for calling vfs-rename. This helper is needed for ksmbd server.
rename request of SMB protocol has to rename an opened file, no matter
which directory it's in.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/namei.c            | 68 ++++++++++++++++++++++++++++++++++++-------
 include/linux/namei.h |  1 +
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 5855dc6edbd5..984d4f7b47dc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2980,20 +2980,10 @@ static inline int may_create(struct mnt_idmap *idmap,
 	return inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
 }
 
-/*
- * p1 and p2 should be directories on the same fs.
- */
-struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
+static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
 {
 	struct dentry *p;
 
-	if (p1 == p2) {
-		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
-		return NULL;
-	}
-
-	mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
-
 	p = d_ancestor(p2, p1);
 	if (p) {
 		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
@@ -3012,8 +3002,64 @@ struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
 	return NULL;
 }
+
+/*
+ * p1 and p2 should be directories on the same fs.
+ */
+struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
+{
+	if (p1 == p2) {
+		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
+		return NULL;
+	}
+
+	mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
+	return lock_two_directories(p1, p2);
+}
 EXPORT_SYMBOL(lock_rename);
 
+/*
+ * c1 and p2 should be on the same fs.
+ */
+struct dentry *lock_rename_child(struct dentry *c1, struct dentry *p2)
+{
+	if (READ_ONCE(c1->d_parent) == p2) {
+		/*
+		 * hopefully won't need to touch ->s_vfs_rename_mutex at all.
+		 */
+		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
+		/*
+		 * now that p2 is locked, nobody can move in or out of it,
+		 * so the test below is safe.
+		 */
+		if (likely(c1->d_parent == p2))
+			return NULL;
+
+		/*
+		 * c1 got moved out of p2 while we'd been taking locks;
+		 * unlock and fall back to slow case.
+		 */
+		inode_unlock(p2->d_inode);
+	}
+
+	mutex_lock(&c1->d_sb->s_vfs_rename_mutex);
+	/*
+	 * nobody can move out of any directories on this fs.
+	 */
+	if (likely(c1->d_parent != p2))
+		return lock_two_directories(c1->d_parent, p2);
+
+	/*
+	 * c1 got moved into p2 while we were taking locks;
+	 * we need p2 locked and ->s_vfs_rename_mutex unlocked,
+	 * for consistency with lock_rename().
+	 */
+	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
+	mutex_unlock(&c1->d_sb->s_vfs_rename_mutex);
+	return NULL;
+}
+EXPORT_SYMBOL(lock_rename_child);
+
 void unlock_rename(struct dentry *p1, struct dentry *p2)
 {
 	inode_unlock(p1->d_inode);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index c2747cfe97ac..4c070fb29a91 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -83,6 +83,7 @@ extern int follow_down(struct path *);
 extern int follow_up(struct path *);
 
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
+extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
 
 extern int __must_check nd_jump_link(const struct path *path);
-- 
2.25.1

