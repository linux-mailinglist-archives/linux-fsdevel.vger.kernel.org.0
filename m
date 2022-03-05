Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867094CE5C0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 17:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiCEQFq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 11:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiCEQFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:05:45 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762D540E7B;
        Sat,  5 Mar 2022 08:04:48 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so6768445wmp.5;
        Sat, 05 Mar 2022 08:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5CHc8CKH7uLvD0MRz+pjrVdTqF9gV7wQBEMlUwFM4GM=;
        b=AfcdU295DfZ60SJB0qJHp4pnm4CD3ZkDzQslxY5H+dleyUYaRN2HZCbTb/Qhcvh5NK
         f4jwKi2FzyeRi9y2tRBAHTYvYKW0h/X71tYXLOhSdKbK0+Bv51OBASDbjoYdbtY2OQec
         PCro6sNe4zXZA0uAGB+hYWW8XQVbc7GKLAOutxSBPbSxqCYoB0v7baLzaIBnCXMga4+C
         2isvRbf4GeRnsrMr9m5wUi7G/2+kcmhSuPsBxwmog/Vi3jRLoYS/6QMxs2T+r+82Lowx
         7MA8SMJv5CFYrR8qIj+r3hjX94xk3GzwHkhQiiCZH5lZ+rrdvdW5ZqkYCM4b0jefU00I
         T/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5CHc8CKH7uLvD0MRz+pjrVdTqF9gV7wQBEMlUwFM4GM=;
        b=1rmldlaqkfI1YIp5wbUj3CCzP9ttwOCRnIdmBbIZZmvzqaQUtUHA4vmrTMScZBjSFC
         gFhNdwZF9EaFqfi/GcoPTY4iBRNgsvjBYzbzzTsWSsRFWSQz3f0EGMFHI4/Rm7FeMVqM
         2qkdE5j1yt+a8ds6A8hUm7zeeQeaoKAT4Ou00ai6CPCGXkwEG5+EtJMh5WxwqUAiNDnI
         BczdAq6BHps0oVHXv04dyokVJdYzNli/8Mah26W7NfcdQ8CjGD5dFarUoM4tFoiT4bkD
         51+ERSV1z7lFgobMK4gbZmB2ZhB9Xly3xfQjtQSbQSrg3zVViEEBMvsl3UbyEim/TwtO
         ewyQ==
X-Gm-Message-State: AOAM5339n87YWG80hbJCEyARMALEK9oGN0PJFT91D8UJP5Owp+jQOMcM
        EPYmNpnw6Q74zyNQf7llfzg=
X-Google-Smtp-Source: ABdhPJxdFMnzPUU+1O1iGiA2wtKyD2rs0ohY81KGPvW9SwV+nn7+joGlqJEUJLeHLuFo02Hac3howQ==
X-Received: by 2002:a05:600c:205a:b0:380:d03d:9cd5 with SMTP id p26-20020a05600c205a00b00380d03d9cd5mr12069992wmg.89.1646496287010;
        Sat, 05 Mar 2022 08:04:47 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm1650717wri.85.2022.03.05.08.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:04:46 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 4/9] fs: add optional iostats counters to struct super_block
Date:   Sat,  5 Mar 2022 18:04:19 +0200
Message-Id: <20220305160424.1040102-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305160424.1040102-1-amir73il@gmail.com>
References: <20220305160424.1040102-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With CONFIG_FS_IOSTATS, filesystems can opt-in to generic per-sb I/O
statistics by setting the FS_SB_IOSTATS fstype flag.

These counters will be used to collect per-sb I/O statistics and display
them in /proc/<pid>/mountstats.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/Kconfig                 |   8 +++
 fs/super.c                 |   6 ++
 include/linux/fs.h         |  11 +++-
 include/linux/fs_iostats.h | 130 +++++++++++++++++++++++++++++++++++++
 4 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/fs_iostats.h

diff --git a/fs/Kconfig b/fs/Kconfig
index 6c7dc1387beb..394d9da6bda9 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -15,6 +15,14 @@ config VALIDATE_FS_PARSER
 	  Enable this to perform validation of the parameter description for a
 	  filesystem when it is registered.
 
+config FS_IOSTATS
+	bool "Enable generic filesystem I/O statistics"
+	help
+	  Enable this to allow collecting filesystem I/O statistics and display
+	  them in /proc/<pid>/mountstats.
+
+	  Say N if unsure.
+
 config FS_IOMAP
 	bool
 
diff --git a/fs/super.c b/fs/super.c
index f1d4a193602d..a18930693e54 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -36,6 +36,7 @@
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
+#include <linux/fs_iostats.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
@@ -179,6 +180,7 @@ static void destroy_unused_super(struct super_block *s)
 	up_write(&s->s_umount);
 	list_lru_destroy(&s->s_dentry_lru);
 	list_lru_destroy(&s->s_inode_lru);
+	sb_iostats_destroy(s);
 	security_sb_free(s);
 	put_user_ns(s->s_user_ns);
 	kfree(s->s_subtype);
@@ -230,6 +232,9 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	if (security_sb_alloc(s))
 		goto fail;
 
+	if (type->fs_flags & FS_SB_IOSTATS && sb_iostats_init(s))
+		goto fail;
+
 	for (i = 0; i < SB_FREEZE_LEVELS; i++) {
 		if (__percpu_init_rwsem(&s->s_writers.rw_sem[i],
 					sb_writers_name[i],
@@ -290,6 +295,7 @@ static void __put_super(struct super_block *s)
 		WARN_ON(s->s_dentry_lru.node);
 		WARN_ON(s->s_inode_lru.node);
 		WARN_ON(!list_empty(&s->s_mounts));
+		sb_iostats_destroy(s);
 		security_sb_free(s);
 		fscrypt_sb_free(s);
 		put_user_ns(s->s_user_ns);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ecb64997c390..f8e7ec81ae0b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1455,6 +1455,8 @@ struct sb_writers {
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
 
+struct sb_iostats;
+
 struct super_block {
 	struct list_head	s_list;		/* Keep this first */
 	dev_t			s_dev;		/* search index; _not_ kdev_t */
@@ -1509,8 +1511,12 @@ struct super_block {
 	/* Granularity of c/m/atime in ns (cannot be worse than a second) */
 	u32			s_time_gran;
 	/* Time limits for c/m/atime in seconds */
-	time64_t		   s_time_min;
-	time64_t		   s_time_max;
+	time64_t		s_time_min;
+	time64_t		s_time_max;
+#ifdef CONFIG_FS_IOSTATS
+	/* Optional per-sb I/O stats */
+	struct sb_iostats	*s_iostats;
+#endif
 #ifdef CONFIG_FSNOTIFY
 	__u32			s_fsnotify_mask;
 	struct fsnotify_mark_connector __rcu	*s_fsnotify_marks;
@@ -2435,6 +2441,7 @@ struct file_system_type {
 #define FS_USERNS_MOUNT		(1<<3)	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	(1<<4)	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP		(1<<5)	/* FS can handle vfs idmappings */
+#define FS_SB_IOSTATS		(1<<6)	/* FS has generic per-sb I/O stats */
 #define FS_RENAME_DOES_D_MOVE	(1<<15)	/* FS will handle d_move() internally */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
diff --git a/include/linux/fs_iostats.h b/include/linux/fs_iostats.h
new file mode 100644
index 000000000000..2db13e9e17fc
--- /dev/null
+++ b/include/linux/fs_iostats.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_FS_IOSTATS_H
+#define _LINUX_FS_IOSTATS_H
+
+#include <linux/fs.h>
+#include <linux/percpu_counter.h>
+#include <linux/slab.h>
+
+/* Similar to task_io_accounting members */
+enum {
+	SB_IOSTATS_CHARS_RD,	/* bytes read via syscalls */
+	SB_IOSTATS_CHARS_WR,	/* bytes written via syscalls */
+	SB_IOSTATS_SYSCALLS_RD,	/* # of read syscalls */
+	SB_IOSTATS_SYSCALLS_WR,	/* # of write syscalls */
+	SB_IOSTATS_COUNTERS_NUM
+};
+
+struct sb_iostats {
+	time64_t		start_time;
+	struct percpu_counter	counter[SB_IOSTATS_COUNTERS_NUM];
+};
+
+#ifdef CONFIG_FS_IOSTATS
+static inline struct sb_iostats *sb_iostats(struct super_block *sb)
+{
+	return sb->s_iostats;
+}
+
+static inline bool sb_has_iostats(struct super_block *sb)
+{
+	return !!sb->s_iostats;
+}
+
+/* Initialize per-sb I/O stats */
+static inline int sb_iostats_init(struct super_block *sb)
+{
+	int err;
+
+	if (sb->s_iostats)
+		return 0;
+
+	sb->s_iostats = kmalloc(sizeof(struct sb_iostats), GFP_KERNEL);
+	if (!sb->s_iostats)
+		return -ENOMEM;
+
+	err = percpu_counters_init(sb->s_iostats->counter,
+				   SB_IOSTATS_COUNTERS_NUM, 0, GFP_KERNEL);
+	if (err) {
+		kfree(sb->s_iostats);
+		sb->s_iostats = NULL;
+		return err;
+	}
+
+	sb->s_iostats->start_time = ktime_get_seconds();
+	return 0;
+}
+
+static inline void sb_iostats_destroy(struct super_block *sb)
+{
+	if (!sb->s_iostats)
+		return;
+
+	percpu_counters_destroy(sb->s_iostats->counter,
+				SB_IOSTATS_COUNTERS_NUM);
+	kfree(sb->s_iostats);
+	sb->s_iostats = NULL;
+}
+
+static inline void sb_iostats_counter_inc(struct super_block *sb, int id)
+{
+	if (!sb->s_iostats)
+		return;
+
+	percpu_counter_inc_relaxed(&sb->s_iostats->counter[id]);
+}
+
+static inline void sb_iostats_counter_add(struct super_block *sb, int id,
+					  s64 amt)
+{
+	if (!sb->s_iostats)
+		return;
+
+	percpu_counter_add_relaxed(&sb->s_iostats->counter[id], amt);
+}
+
+static inline s64 sb_iostats_counter_read(struct super_block *sb, int id)
+{
+	if (!sb->s_iostats)
+		return 0;
+
+	return percpu_counter_sum_positive(&sb->s_iostats->counter[id]);
+}
+
+#else /* !CONFIG_FS_IOSTATS */
+
+static inline struct sb_iostats *sb_iostats(struct super_block *sb)
+{
+	return NULL;
+}
+
+static inline bool sb_has_iostats(struct super_block *sb)
+{
+	return false;
+}
+
+static inline int sb_iostats_init(struct super_block *sb)
+{
+	return 0;
+}
+
+static inline void sb_iostats_destroy(struct super_block *sb)
+{
+}
+
+static inline void sb_iostats_counter_inc(struct super_block *sb, int id)
+{
+}
+
+static inline void sb_iostats_counter_add(struct super_block *sb, int id,
+					  s64 amt)
+{
+}
+
+static inline s64 sb_iostats_counter_read(struct super_block *sb, int id)
+{
+	return 0;
+}
+#endif
+
+#endif /* _LINUX_FS_IOSTATS_H */
-- 
2.25.1

