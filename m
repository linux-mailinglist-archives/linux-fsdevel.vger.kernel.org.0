Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AEE5BF072
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 00:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiITWoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 18:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiITWnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:43:55 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E956CF4E;
        Tue, 20 Sep 2022 15:43:55 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id q9so4131075pgq.8;
        Tue, 20 Sep 2022 15:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5K/RIYItWzBwJjJUuRJANuwpWyKGk0xDPz8dpbGp/5Q=;
        b=M2Cm8ttunzNdi4LfFHR3eMFw5NVLP0htZLeQV/+x2JQx8gncjZ6BBbpYpTEaKImbDm
         AECYIeYMBIfXzZ3o9KxaTEGmbxkokKT3e6TdZlcrO0QDazmZE6kh1yJP7YFFj6rx1aIC
         cH3g3eIqmBBrLFdsZp1L/klX45Vb0VROLgR3RV0CPPnRDg9YYRJLajyPO28ZRCL+Rnhu
         WGegEbTl/tOlR6xod0S9Za9le/bQAePpv+5V01FKzuuu2mNzlGHpq+st5MtKmZu4WcVc
         3bfLxmxEJcpF/MJiwh3V7ZFi07z5qwAtI53AZEjspSB2kcsXiT4gmZbDjiV7bTtaoV/l
         Ek1g==
X-Gm-Message-State: ACrzQf3ypsunHZpBBzsfIyqrUaW4FMxw3NRa4aSciHJIk1eLmsJYrPpV
        zN+MLiTYJxkMFc/3yOQy6xQ=
X-Google-Smtp-Source: AMsMyM4s2NkTqs95w5UpRHvzngsMunBpMamjPGnmNoMdEifSb4FpCGIfGhVkMwdsd1JhQGDAE5HqGQ==
X-Received: by 2002:a63:ff55:0:b0:438:fa5d:af36 with SMTP id s21-20020a63ff55000000b00438fa5daf36mr22100920pgk.533.1663713834592;
        Tue, 20 Sep 2022 15:43:54 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id 13-20020a62140d000000b0053e93aa8fb9sm451352pfu.71.2022.09.20.15.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 15:43:54 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
        atteh.mailbox@gmail.com, Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v7 2/3] fs: introduce lock_rename_child() helper
Date:   Wed, 21 Sep 2022 07:43:37 +0900
Message-Id: <20220920224338.22217-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920224338.22217-1-linkinjeon@kernel.org>
References: <20220920224338.22217-1-linkinjeon@kernel.org>
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
 fs/namei.c            | 46 ++++++++++++++++++++++++++++++++-----------
 include/linux/namei.h |  1 +
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 53b4bc094db2..5ff7f2a9e54e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2979,20 +2979,10 @@ static inline int may_create(struct user_namespace *mnt_userns,
 	return inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
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
@@ -3011,8 +3001,42 @@ struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
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
 
+struct dentry *lock_rename_child(struct dentry *c1, struct dentry *p2)
+{
+	if (READ_ONCE(c1->d_parent) == p2) {
+		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
+		if (likely(c1->d_parent == p2))
+			return NULL;
+
+		inode_unlock(p2->d_inode);
+	}
+
+	mutex_lock(&c1->d_sb->s_vfs_rename_mutex);
+	if (likely(c1->d_parent != p2))
+		return lock_two_directories(c1->d_parent, p2);
+
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
index 40c693525f79..7868732cce24 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -83,6 +83,7 @@ extern int follow_down(struct path *);
 extern int follow_up(struct path *);
 
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
+extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
 
 extern int __must_check nd_jump_link(struct path *path);
-- 
2.25.1

