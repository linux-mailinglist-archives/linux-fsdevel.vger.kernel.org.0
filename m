Return-Path: <linux-fsdevel+bounces-17071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D99E8A72E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 20:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB511C21920
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE95134CE8;
	Tue, 16 Apr 2024 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+oxJ45r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0209A84A32
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291299; cv=none; b=POf/+BA7MyRcaJMFQNzPBRy3F6iKCMYDAqMa6SPXBY2MpSJb81CDd9Wa/WoIIn3QbISxNkzQRZ9mbGwDcl70l/iMcnwFYpB7p1V0aT9pmBgFXJwnMAghMBWzkRanLrr+aYOE7ck6b7wRByY2tr7WIGOOa44Hx0ps5Ux3qYUQw5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291299; c=relaxed/simple;
	bh=AVYrPoNvk4js8zd8p+EK0y4viuIINfCvEKHXV3XG3iA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PpPDw33FDoXv/LEAamcXE439+2Np//oBO68qs7HKY9hgg1rEDSoprhTPKagciLnmiqqNEE7T3v0Rh04uVLhp6DO3wS9Y8bB5/i6MewiI+kN17cH/aIv9bxTZzlTMr4GHVfmpyoSxQZxFFbuFCw/ulwHPTxOpwxTBY/iMRB9ap64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+oxJ45r; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41884f8f35bso10193905e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 11:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713291296; x=1713896096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GpVsDlwp9tGKX1bl16eoCf4bz5m9UbDIO1/efocPpaM=;
        b=m+oxJ45rkvFrzTEaQBl/HgAeNJ7neYtB2taHT/qizjdYiUM9O8FvlcKIKcU8PL1aOf
         3hm+NACB7rX1afcbeXyWTx539emvX2auHxQKSm+b0dvTrm5qMnG2g1YshVPtL2p/Ct90
         2ehI9ri1L2B/YtqULVWLfWH1DtbQtNyoiEO3RgLjPbdpoSNt66ltGgkPOgnwN/YoVhU2
         LWS62DbTX7Y99tO+9bB8Au+MFba16bikiTaMD+UPnyUoY6pZm35+TMPhBUfU8zbeJ7rF
         jy7X04ymnqNJZ70vbtdazYBgc3lmMCc2/d7UrjiPOmeHhKSvtTg3fRv/8cd0vWtbaGj7
         s/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713291296; x=1713896096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GpVsDlwp9tGKX1bl16eoCf4bz5m9UbDIO1/efocPpaM=;
        b=Rdp9wzFySOYEUKZOztwMLUfJxTlb33s9GzKPigaTXa/By+wAHbUN1nBPEZOp5MjUjD
         6uyw3G3COLrSb7QHeTpp3iJ3ZkfdOuaOuIoch4qqytIIOEG7YPHxa36Eh5uiu7fNeStN
         wCMpTeoE2gDgZXCORqmlkSOwEN+jDouvWV838Yg3y5yGv1TT0GlZU6jlLXKntH9v2TH/
         P31mDAakTPuq6VEJ5ByscXrYe+yYO6P6A5ExBIvy8xiGA2FnrVDfIjxebGeQhEuUorP6
         f/apd71iuxU3u9HgpBbJQRHOOfk213Ygvks9T4+mm9bTreUu3SXCr0Baia7gXwkhM6wC
         Tz3w==
X-Forwarded-Encrypted: i=1; AJvYcCVEuTVP4xBpYDb7qBXQwWOadb7pU7LjqJsGpIKu1XUVVTfSF6gIKHVO5lhuJj0ZtjS8Af6uQwBvpqi1CYqntmsS+wbLcPsIqRw5qdyNlw==
X-Gm-Message-State: AOJu0YynVGQUbWvL4TH5Oy3+wqZ9VzC9Nx6nYahIcacDzsLbEBGSYDKH
	Qmw8p3ze8s8OEFIWRBoM3BjfxkNiBgk63BfD6AWZlz1l6o4DZdaV
X-Google-Smtp-Source: AGHT+IElfGmSRjM14+eiR7Cs2PHDbYNcON+X7sYCQ4YmVf1aXdJoxf8Y8+3DCj3sja3C60MNPhS1eQ==
X-Received: by 2002:a05:600c:19c9:b0:418:9941:c977 with SMTP id u9-20020a05600c19c900b004189941c977mr1895464wmq.3.1713291296275;
        Tue, 16 Apr 2024 11:14:56 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id bi27-20020a05600c3d9b00b004187c57e161sm5778209wmb.0.2024.04.16.11.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:14:55 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Hillf Danton <hdanton@sina.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fsnotify: fix UAF from FS_ERROR event on a shutting down filesystem
Date: Tue, 16 Apr 2024 21:14:52 +0300
Message-Id: <20240416181452.567070-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protect against use after free when filesystem calls fsnotify_sb_error()
during fs shutdown.

Move freeing of sb->s_fsnotify_info to destroy_super_work(), because it
may be accessed from fs shutdown context.

Reported-by: syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com
Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/linux-fsdevel/20240416173211.4lnmgctyo4jn5fha@quack3/
Fixes: 07a3b8d0bf72 ("fsnotify: lazy attach fsnotify_sb_info state to sb")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c             | 6 +++++-
 fs/super.c                       | 1 +
 include/linux/fsnotify_backend.h | 4 ++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 2ae965ef37e8..ff69ae24c4e8 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -103,7 +103,11 @@ void fsnotify_sb_delete(struct super_block *sb)
 	WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_CONTENT));
 	WARN_ON(fsnotify_sb_has_priority_watchers(sb,
 						  FSNOTIFY_PRIO_PRE_CONTENT));
-	kfree(sbinfo);
+}
+
+void fsnotify_sb_free(struct super_block *sb)
+{
+	kfree(sb->s_fsnotify_info);
 }
 
 /*
diff --git a/fs/super.c b/fs/super.c
index 69ce6c600968..b72f1d288e95 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -274,6 +274,7 @@ static void destroy_super_work(struct work_struct *work)
 {
 	struct super_block *s = container_of(work, struct super_block,
 							destroy_work);
+	fsnotify_sb_free(s);
 	security_sb_free(s);
 	put_user_ns(s->s_user_ns);
 	kfree(s->s_subtype);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 7f1ab8264e41..4dd6143db271 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -576,6 +576,7 @@ extern int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data
 extern void __fsnotify_inode_delete(struct inode *inode);
 extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
 extern void fsnotify_sb_delete(struct super_block *sb);
+extern void fsnotify_sb_free(struct super_block *sb);
 extern u32 fsnotify_get_cookie(void);
 
 static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
@@ -880,6 +881,9 @@ static inline void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
 static inline void fsnotify_sb_delete(struct super_block *sb)
 {}
 
+static inline void fsnotify_sb_free(struct super_block *sb)
+{}
+
 static inline void fsnotify_update_flags(struct dentry *dentry)
 {}
 
-- 
2.34.1


