Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA29A2EE7C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 22:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbhAGVou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 16:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbhAGVou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:44:50 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CC9C0612FC
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jan 2021 13:44:06 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 3so6753324wmg.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jan 2021 13:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdQIRAgFej0dYyKrcRHotRaZjuyoBcHpXJCOhJYtpyI=;
        b=FRJgxBoi7X6HsEpFnZSRvocp/evARXJMQ8tdL83pS/6mSNuu8rK1zI+bMUZJpRte67
         4Z6LX4/nIs+fHThfSMw+7wPlUlxJjMHqj2y69Not5HE6sWEWqPe8i0jwswDFSL48S3ed
         PSJ5qslNXufnOdXmuuP2CdvvrflRdru7Cp+HO+qPzq7Q2gLY9cpXGvzE+Z5i7Kxu+9uG
         5QeuNWuqTjJ3o19eVBQj2/fOl0eoueUB0MOHVXb9QrpE7WIs8UFu/hf2P2TV98cHv/5L
         LgVjtIaECsviv4BNj4je7rDzy2Yr04MmTWNbQp/b9GGLH9T0Oy0wbe2ifQIn1MKODagv
         vM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdQIRAgFej0dYyKrcRHotRaZjuyoBcHpXJCOhJYtpyI=;
        b=Ltbr++vXtfGwc7NvAPOzWIbFn9az1tVfGPLJOEy8NSW6WS3wp7sPqzRrrW4wY6OAn4
         BQO4EJ9bRyeFX0Z//aWUNWu7y2WadBwkX/kw6H769IEWZIECCWj3qxqbyP2kWo68R6OA
         x4BsXTBiih7ZOMVxSgAlVQJEFD7930IHBo1+0vCCy/Tyyuc5+NiXlifMR1yAHX6TmZMW
         vLhXTclQno/wBY67Iw4NskrjBLmaQ7k6og88snh34kUufl9Tov5CVJ9dm+4CrpJmtVwx
         wzMMslTf6Ns/jaH5q9fYnWsgvkSM2HVWIGfSobkIxldkyLjna5L9KkI/49AZGRVmjfFY
         KcKA==
X-Gm-Message-State: AOAM532Gi/PiePVrPL60RsjDnTNaD1O2uaR9aoODhEhpvz1cLQ7zdfbX
        7LJSGfFlcPqfwPAeX4/Ce3I=
X-Google-Smtp-Source: ABdhPJwqmvbDxVz2oYapetRL3T7WDcmTDfBZE+Mxm7TzAVaozG+WIvQ/ZuQ/JK2CQpVQBtHGUiCmWw==
X-Received: by 2002:a05:600c:208:: with SMTP id 8mr438256wmi.146.1610055845059;
        Thu, 07 Jan 2021 13:44:05 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id g1sm10084997wrq.30.2021.01.07.13.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:44:04 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 1/3] fs: add iostats counters to struct mount
Date:   Thu,  7 Jan 2021 23:43:59 +0200
Message-Id: <20210107214401.249416-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107214401.249416-1-amir73il@gmail.com>
References: <20210107214401.249416-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With config MOUNT_IO_STATS, add an array of counters to struct mnt_pcp
that will be used to collect I/O statistics.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Please note that the dependency on SMP is just for the RFC.

Thanks,
Amir.

 fs/Kconfig     |  9 +++++++++
 fs/mount.h     | 32 ++++++++++++++++++++++++++++++++
 fs/namespace.c | 17 +++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index aa4c12282301..7473bdf4bbfb 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -15,6 +15,15 @@ config VALIDATE_FS_PARSER
 	  Enable this to perform validation of the parameter description for a
 	  filesystem when it is registered.
 
+config FS_MOUNT_STATS
+	bool "Enable per-mount I/O statistics"
+	depends on SMP
+	help
+	  Enable this to allow collecting per-mount I/O statistics and display
+	  them in /proc/<pid>/mountstats.
+
+	  Say N if unsure.
+
 if BLOCK
 
 config FS_IOMAP
diff --git a/fs/mount.h b/fs/mount.h
index ce6c376e0bc2..2bf0df64ded5 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -24,9 +24,25 @@ struct mnt_namespace {
 	unsigned int		pending_mounts;
 } __randomize_layout;
 
+/* Similar to task_io_accounting members */
+enum {
+	MNTIOS_CHARS_RD,	/* bytes read via syscalls */
+	MNTIOS_CHARS_WR,	/* bytes written via syscalls */
+	MNTIOS_SYSCALLS_RD,	/* # of read syscalls */
+	MNTIOS_SYSCALLS_WR,	/* # of write syscalls */
+	_MNTIOS_COUNTERS_NUM
+};
+
+struct mnt_iostats {
+	s64 counter[_MNTIOS_COUNTERS_NUM];
+};
+
 struct mnt_pcp {
 	int mnt_count;
 	int mnt_writers;
+#ifdef CONFIG_FS_MOUNT_STATS
+	struct mnt_iostats iostats;
+#endif
 };
 
 struct mountpoint {
@@ -158,3 +174,19 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
 }
 
 extern void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor);
+
+static inline void mnt_iostats_counter_inc(struct mount *mnt, int id)
+{
+#ifdef CONFIG_FS_MOUNT_STATS
+	this_cpu_inc(mnt->mnt_pcp->iostats.counter[id]);
+#endif
+}
+
+static inline void mnt_iostats_counter_add(struct mount *mnt, int id, s64 n)
+{
+#ifdef CONFIG_FS_MOUNT_STATS
+	this_cpu_add(mnt->mnt_pcp->iostats.counter[id], n);
+#endif
+}
+
+extern s64 mnt_iostats_counter_read(struct mount *mnt, int id);
diff --git a/fs/namespace.c b/fs/namespace.c
index d2db7dfe232b..04b35dfcc71f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -283,6 +283,23 @@ static unsigned int mnt_get_writers(struct mount *mnt)
 #endif
 }
 
+s64 mnt_iostats_counter_read(struct mount *mnt, int id)
+{
+	s64 count = 0;
+#ifdef CONFIG_FS_MOUNT_STATS
+	/*
+	 * MOUNT_STATS depends on SMP.
+	 * Should be trivial to implement for !SMP if anyone cares...
+	 */
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		count += per_cpu_ptr(mnt->mnt_pcp, cpu)->iostats.counter[id];
+	}
+#endif
+	return count;
+}
+
 static int mnt_is_readonly(struct vfsmount *mnt)
 {
 	if (mnt->mnt_sb->s_readonly_remount)
-- 
2.25.1

