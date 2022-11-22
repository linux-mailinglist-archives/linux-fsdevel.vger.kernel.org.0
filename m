Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7CE6332E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 03:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiKVCQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 21:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiKVCQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:16:02 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7400E0DC0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:01 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-368994f4bc0so128910987b3.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=76QMXC6mJ9CAtH5i+yrdnZDHqT+yu4res8J20D/aqg0=;
        b=l2D1VL2CNvcisUBCfC7TgWMOqx1HOlygw+itHxo7cwEflDooq8QM69jmRhG7gICfG1
         hTRGKLnw8K5QuEa9EZLI8ENeRVJuE5SOMmwyPEJjhVZy0H050FJFI8bz4Vc6mrIwQZiN
         IHCMrogofo5yeziIRnPzb2b9NCBrL1dKOr1Rsx6IvGn9BCrV+CvaI40xmoq/Pkys4N5M
         T3A4myoeL008QjavUGxH+DQmWe0rU2ZlIK4qlzvsHCPG7wJ1NfooXYDhkk2wqyNTgLh6
         h4HPd9c+S/3Z1zd8RBtIkE3BvCURRYwFwWk/vQDvb+L1wb6OV2nLlCOUJuixxEhWkpxi
         G6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76QMXC6mJ9CAtH5i+yrdnZDHqT+yu4res8J20D/aqg0=;
        b=U+p7+W0jPl/DsZhutoNNFmpM5jztn2UJ90bk4UIRm5r9dwduQRER7/8eruKf13w0Ez
         zt99QP04M6BCojq050C9ousVVmsWMkRw1BlxlOUfZSCeDsrxq5N2clJJHdEqXgnqb/MO
         e3jLlHnePhj79w+qkvlphkHU9LD1JhwZTDk65PfnEyz9vAnhyn+18Bkc5gqiN4QuVKYo
         G0qepODA9vgVjTdEoqzVEls/audOm3MSussKSyck4aemo1h8g1JzcJRBrwT4aPvgkZHU
         cE+Sll3NAkzC2jXVlGzuooquGZgYtg6KZDkLcodflkUo2rvSuZ/HEQ3yR8afLMCtYnuh
         wwjQ==
X-Gm-Message-State: ANoB5plSbPk0v/pp3MEhRkpmfltFkISyirbUhQoyPf08tlnRepKnkCQP
        62MmwEC65Kp5dO76ZOXMRajk0hTfrXY=
X-Google-Smtp-Source: AA0mqf55G/Y8Pk5Zs24pQf5k4rb24e2BBoc8iasqg8lF/QrPjpTa9SNSGo6ZuBmA0Asti95EjcZJANNWXhQ=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:8539:aadd:13be:6e82])
 (user=drosen job=sendgmr) by 2002:a25:1c07:0:b0:6dd:fed7:8128 with SMTP id
 c7-20020a251c07000000b006ddfed78128mr1729703ybc.131.1669083360508; Mon, 21
 Nov 2022 18:16:00 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:15:18 -0800
In-Reply-To: <20221122021536.1629178-1-drosen@google.com>
Mime-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122021536.1629178-4-drosen@google.com>
Subject: [RFC PATCH v2 03/21] fuse-bpf: Prepare for fuse-bpf patch
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This moves some functions and structs around to make the following patch
easier to read.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/dir.c    | 30 ------------------------------
 fs/fuse/fuse_i.h | 35 +++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c  | 44 ++++++++++++++++++++++----------------------
 3 files changed, 57 insertions(+), 52 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index bb97a384dc5d..168903cadb54 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -46,10 +46,6 @@ static inline u64 fuse_dentry_time(const struct dentry *entry)
 }
 
 #else
-union fuse_dentry {
-	u64 time;
-	struct rcu_head rcu;
-};
 
 static inline void __fuse_dentry_settime(struct dentry *dentry, u64 time)
 {
@@ -83,27 +79,6 @@ static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 	__fuse_dentry_settime(dentry, time);
 }
 
-/*
- * FUSE caches dentries and attributes with separate timeout.  The
- * time in jiffies until the dentry/attributes are valid is stored in
- * dentry->d_fsdata and fuse_inode->i_time respectively.
- */
-
-/*
- * Calculate the time in jiffies until a dentry/attributes are valid
- */
-static u64 time_to_jiffies(u64 sec, u32 nsec)
-{
-	if (sec || nsec) {
-		struct timespec64 ts = {
-			sec,
-			min_t(u32, nsec, NSEC_PER_SEC - 1)
-		};
-
-		return get_jiffies_64() + timespec64_to_jiffies(&ts);
-	} else
-		return 0;
-}
 
 /*
  * Set dentry and possibly attribute timeouts from the lookup/mk*
@@ -115,11 +90,6 @@ void fuse_change_entry_timeout(struct dentry *entry, struct fuse_entry_out *o)
 		time_to_jiffies(o->entry_valid, o->entry_valid_nsec));
 }
 
-static u64 attr_timeout(struct fuse_attr_out *o)
-{
-	return time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
-}
-
 u64 entry_attr_timeout(struct fuse_entry_out *o)
 {
 	return time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 98a9cf531873..57453296e662 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -63,6 +63,14 @@ struct fuse_forget_link {
 	struct fuse_forget_link *next;
 };
 
+/** FUSE specific dentry data */
+#if BITS_PER_LONG < 64
+union fuse_dentry {
+	u64 time;
+	struct rcu_head rcu;
+};
+#endif
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -1319,4 +1327,31 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
+/*
+ * FUSE caches dentries and attributes with separate timeout.  The
+ * time in jiffies until the dentry/attributes are valid is stored in
+ * dentry->d_fsdata and fuse_inode->i_time respectively.
+ */
+
+/*
+ * Calculate the time in jiffies until a dentry/attributes are valid
+ */
+static inline u64 time_to_jiffies(u64 sec, u32 nsec)
+{
+	if (sec || nsec) {
+		struct timespec64 ts = {
+			sec,
+			min_t(u32, nsec, NSEC_PER_SEC - 1)
+		};
+
+		return get_jiffies_64() + timespec64_to_jiffies(&ts);
+	} else
+		return 0;
+}
+
+static inline u64 attr_timeout(struct fuse_attr_out *o)
+{
+	return time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
+}
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6b3beda16c1b..504336d56a7f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -162,6 +162,28 @@ static ino_t fuse_squash_ino(u64 ino64)
 	return ino;
 }
 
+static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
+				      const struct fuse_inode *fi)
+{
+	*attr = (struct fuse_attr){
+		.ino		= fi->inode.i_ino,
+		.size		= fi->inode.i_size,
+		.blocks		= fi->inode.i_blocks,
+		.atime		= fi->inode.i_atime.tv_sec,
+		.mtime		= fi->inode.i_mtime.tv_sec,
+		.ctime		= fi->inode.i_ctime.tv_sec,
+		.atimensec	= fi->inode.i_atime.tv_nsec,
+		.mtimensec	= fi->inode.i_mtime.tv_nsec,
+		.ctimensec	= fi->inode.i_ctime.tv_nsec,
+		.mode		= fi->inode.i_mode,
+		.nlink		= fi->inode.i_nlink,
+		.uid		= fi->inode.i_uid.val,
+		.gid		= fi->inode.i_gid.val,
+		.rdev		= fi->inode.i_rdev,
+		.blksize	= 1u << fi->inode.i_blkbits,
+	};
+}
+
 void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 				   u64 attr_valid, u32 cache_mask)
 {
@@ -1386,28 +1408,6 @@ void fuse_dev_free(struct fuse_dev *fud)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_free);
 
-static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
-				      const struct fuse_inode *fi)
-{
-	*attr = (struct fuse_attr){
-		.ino		= fi->inode.i_ino,
-		.size		= fi->inode.i_size,
-		.blocks		= fi->inode.i_blocks,
-		.atime		= fi->inode.i_atime.tv_sec,
-		.mtime		= fi->inode.i_mtime.tv_sec,
-		.ctime		= fi->inode.i_ctime.tv_sec,
-		.atimensec	= fi->inode.i_atime.tv_nsec,
-		.mtimensec	= fi->inode.i_mtime.tv_nsec,
-		.ctimensec	= fi->inode.i_ctime.tv_nsec,
-		.mode		= fi->inode.i_mode,
-		.nlink		= fi->inode.i_nlink,
-		.uid		= fi->inode.i_uid.val,
-		.gid		= fi->inode.i_gid.val,
-		.rdev		= fi->inode.i_rdev,
-		.blksize	= 1u << fi->inode.i_blkbits,
-	};
-}
-
 static void fuse_sb_defaults(struct super_block *sb)
 {
 	sb->s_magic = FUSE_SUPER_MAGIC;
-- 
2.38.1.584.g0f3c55d4c2-goog

