Return-Path: <linux-fsdevel+bounces-4633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE3B801688
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC554281C1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7839C3F8C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="iRWsKR0B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3431110D
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:13 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-dae0ab8ac3eso1002987276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468732; x=1702073532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVbb9Vde1QaPim8O9By/4uOtcs6MazfrO+ctrzAYQaM=;
        b=iRWsKR0BRtLF42T/03oB3nUmUJewNrHTm2Fo08LZe+QdfNLdHwp7/BlhZcgKloEnU8
         yPxn0fVkm3zMnuTe4b9CRQNImGXRE1FuoCHZY3c6ci107MCB6ImkLhki1OnDfcyHxFqY
         gb9LvWijXSMaLqKkbt3moSJjZ7gRKTb1HUk1W6BK/AwkJBSZvWUFuvzpvD4px8DdAUFm
         d3pI6eP7hSlE6Cdfrvrwz46X2iKo0+2zg8OhiFtwwEl3E2vF5xUAQdJglx5P3+LwNCNU
         ooFaLMY0hgF1HTOdwM+EitSP3pgHQ/Ai19fBREbxivsJ/Srviwx6ZgoMjIWT/PQZLYtX
         uVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468732; x=1702073532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVbb9Vde1QaPim8O9By/4uOtcs6MazfrO+ctrzAYQaM=;
        b=mGGLvpuFC5zlYkG4NXl+ASYMAk3kyR5yljBj168Lt2VO5+BUOnBUZ/uKmW+8zdzvBp
         dtzo9EfSO1/6xDUXjglsjNn8EYmTBB2QBUG4eUvcwmXg7NMMrUFNqB9jSqf9FCi6Ju6S
         BfLB5QvdQsS66TZ5wnSZjOek4reSHBCTk7mAwAS9K4GHB/YIhj59DlbrpabA5bKkUmRv
         HXAv4W62prTB2HCQBfHMTaezH6tIflNdS4mlasYe8oXA0EEPTi/Xky6KBrdGqMFS0kcB
         vwntKjFkwBlqYVIRH399hD5qLGGSuAGXFTqIaPN4QQaGJJ8UfdVDtRO3Z3bVedkp7tps
         drXQ==
X-Gm-Message-State: AOJu0YwazCrMxKt5nvNCD6vWuRhuFG2jYRPlQYTu/9tUZFpbYgPVaSOy
	YWx2rYcIRNtREQhv6WGwfNM6cA==
X-Google-Smtp-Source: AGHT+IEUXLDvWblHxjdvikmsg5VbVCLTqQIJ7qFAdJhdH3YM5s8f+qZUOtghC28xBsykapqU1GZHGA==
X-Received: by 2002:a81:ac42:0:b0:5d7:1940:f3dd with SMTP id z2-20020a81ac42000000b005d71940f3ddmr152061ywj.69.1701468732326;
        Fri, 01 Dec 2023 14:12:12 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u204-20020a8160d5000000b005d29344e625sm1384159ywb.114.2023.12.01.14.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:11 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Cc: Omar Sandoval <osandov@osandov.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v4 13/46] btrfs: add new FEATURE_INCOMPAT_ENCRYPT flag
Date: Fri,  1 Dec 2023 17:11:10 -0500
Message-ID: <7e42047ce1c87e4181a65347362c7860d5fd05ed.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@osandov.com>

As encrypted files will be incompatible with older filesystem versions,
new filesystems should be created with an incompat flag for fscrypt,
which will gate access to the encryption ioctls.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/fs.h              | 3 ++-
 fs/btrfs/super.c           | 5 +++++
 fs/btrfs/sysfs.c           | 6 ++++++
 include/uapi/linux/btrfs.h | 1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index f8bb73d6ab68..1340e71d026c 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -232,7 +232,8 @@ enum {
 #define BTRFS_FEATURE_INCOMPAT_SUPP		\
 	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE |	\
 	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE | \
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 | \
+	 BTRFS_FEATURE_INCOMPAT_ENCRYPT)
 
 #else
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4b92d6ffde5e..39a338e92115 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2445,6 +2445,11 @@ static int __init btrfs_print_mod_info(void)
 			", fsverity=yes"
 #else
 			", fsverity=no"
+#endif
+#ifdef CONFIG_FS_ENCRYPTION
+			", fscrypt=yes"
+#else
+			", fscrypt=no"
 #endif
 			;
 	pr_info("Btrfs loaded%s\n", options);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e6b51fb3ddc1..4ece703d9d5f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -304,6 +304,9 @@ BTRFS_FEAT_ATTR_INCOMPAT(raid_stripe_tree, RAID_STRIPE_TREE);
 #ifdef CONFIG_FS_VERITY
 BTRFS_FEAT_ATTR_COMPAT_RO(verity, VERITY);
 #endif
+#ifdef CONFIG_FS_ENCRYPTION
+BTRFS_FEAT_ATTR_INCOMPAT(encryption, ENCRYPT);
+#endif /* CONFIG_FS_ENCRYPTION */
 
 /*
  * Features which depend on feature bits and may differ between each fs.
@@ -336,6 +339,9 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 #ifdef CONFIG_FS_VERITY
 	BTRFS_FEAT_ATTR_PTR(verity),
 #endif
+#ifdef CONFIG_FS_ENCRYPTION
+	BTRFS_FEAT_ATTR_PTR(encryption),
+#endif /* CONFIG_FS_ENCRYPTION */
 	NULL
 };
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 7c29d82db9ee..6a0f4c0e4096 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -334,6 +334,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
 #define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE	(1ULL << 14)
+#define BTRFS_FEATURE_INCOMPAT_ENCRYPT		(1ULL << 15)
 #define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 16)
 
 struct btrfs_ioctl_feature_flags {
-- 
2.41.0


