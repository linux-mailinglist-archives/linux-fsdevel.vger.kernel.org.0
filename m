Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200E74C936F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 19:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiCASnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 13:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbiCASnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:43:23 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C333C4C;
        Tue,  1 Mar 2022 10:42:40 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so1790444wmb.1;
        Tue, 01 Mar 2022 10:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gW0TtYSb+PHaz8KelaV23eMZzDm2Da2Jf842/OEtA9g=;
        b=dygrXPZTlKNM/lw3TV8UvA0wPnu2PMqRQHEExj25GEPMl7sqFvkeccQvcDPjW2yznJ
         PS+KL9G3fDxe9t1fk2wRwYNKAoSWEeNAsHhXxRgt6EZHZFBtbXE/JkZowmwKDUtOHjDr
         hwcJBWYm6S9naTTJZU8Z9NhghTr4skvIAZmtaZtMSLPwm3+S1pZXyksDeEEAs6R5vDjd
         /4QIH6GZocctQh3zTkMD3sHEqqCdr/+kYpSfabHnJ1gKvCqRKzH6sP3WzwwoOaFVwQcO
         X/aNZ+7OqHFvECxdDB5sl03APXn4gKXrFDytB5wonmprum5F98/wZJObxhqwi6XUMhPg
         hdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gW0TtYSb+PHaz8KelaV23eMZzDm2Da2Jf842/OEtA9g=;
        b=PvsP8lPibW5FSAhGTtqGSg9pRQGdCamJbrtGFFn0oUbNqBariIEqbGZy9LbWIzCYKk
         NIoFee2iEN+qodzF38SLQ0TRrtmTuxWd/UvzSNQX3OjEMF4uAXYxAS9pzrAcB1QgIDSR
         8xfD9UHtCiz8AD9HpcszwaBplf4hths07+/YoTOyqNEKS1aO660Lv0BXoKc0TUqa2K44
         ff3RKJbL0xwPPVnE+f094jPd54eYXByBVInSxz1homE5bNbzIjMT/U2YWQgKTv4tjA7d
         wl6z1ahLJYexDNfaoQHTbvcng5Pb09k6ST045eyKFR2CfWQClx3WyQCk5d82a5aKp7iC
         6s/Q==
X-Gm-Message-State: AOAM532MvI7TCRv1T2jluQEZwimyuKZX2dz+rkWRVSZv+jTv/rp5Rj9/
        s2GgwbnCieVlV7W0NvMtEt8=
X-Google-Smtp-Source: ABdhPJwsMVccL1RUs1zTxOwNYHxJcvEClzSQY2UjsMCh28ZAObi7BhM4PclFLLPNgaRRftQUG8Nhyw==
X-Received: by 2002:a05:600c:1c05:b0:382:255f:4b9c with SMTP id j5-20020a05600c1c0500b00382255f4b9cmr2528631wms.66.1646160159051;
        Tue, 01 Mar 2022 10:42:39 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d4dc1000000b001eeadc98c0csm14020381wru.101.2022.03.01.10.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:42:38 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/6] fs: add optional iostats counters to struct super_block
Date:   Tue,  1 Mar 2022 20:42:17 +0200
Message-Id: <20220301184221.371853-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301184221.371853-1-amir73il@gmail.com>
References: <20220301184221.371853-1-amir73il@gmail.com>
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

With CONFIG_FS_IOSTATS, filesystem can attach an array of counters to
struct super_block by calling sb_iostats_init().

These counters will be used to collect per-sb I/O statistics and display
them in /proc/<pid>/mountstats.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/Kconfig                 |   8 +++
 fs/super.c                 |   2 +
 include/linux/fs.h         |  10 ++-
 include/linux/fs_iostats.h | 127 +++++++++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+), 2 deletions(-)
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
index f1d4a193602d..c447cadb402b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -36,6 +36,7 @@
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
+#include <linux/fs_iostats.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
@@ -290,6 +291,7 @@ static void __put_super(struct super_block *s)
 		WARN_ON(s->s_dentry_lru.node);
 		WARN_ON(s->s_inode_lru.node);
 		WARN_ON(!list_empty(&s->s_mounts));
+		sb_iostats_destroy(s);
 		security_sb_free(s);
 		fscrypt_sb_free(s);
 		put_user_ns(s->s_user_ns);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2d892b201b0..a71c94cbb6c1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1454,6 +1454,8 @@ struct sb_writers {
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
 
+struct sb_iostats;
+
 struct super_block {
 	struct list_head	s_list;		/* Keep this first */
 	dev_t			s_dev;		/* search index; _not_ kdev_t */
@@ -1508,8 +1510,12 @@ struct super_block {
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
diff --git a/include/linux/fs_iostats.h b/include/linux/fs_iostats.h
new file mode 100644
index 000000000000..60d1efbea7d9
--- /dev/null
+++ b/include/linux/fs_iostats.h
@@ -0,0 +1,127 @@
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
+/* Initialize per-sb I/O stats */
+static inline int sb_iostats_init(struct super_block *sb)
+{
+	int err;
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
+static inline void sb_iostats_counter_inc(struct super_block *sb, int id)
+{
+	if (!sb->s_iostats)
+		return;
+
+	percpu_counter_inc(&sb->s_iostats->counter[id]);
+}
+
+static inline void sb_iostats_counter_add(struct super_block *sb, int id,
+					  s64 amt)
+{
+	if (!sb->s_iostats)
+		return;
+
+	percpu_counter_add(&sb->s_iostats->counter[id], amt);
+}
+
+static inline s64 sb_iostats_counter_read(struct super_block *sb, int id)
+{
+	if (!sb->s_iostats)
+		return 0;
+
+	return percpu_counter_read_positive(&sb->s_iostats->counter[id]);
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
+	return -EOPNOTSUPP;
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

