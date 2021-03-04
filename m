Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A3132D1CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 12:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbhCDLaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 06:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240159AbhCDLaL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:30:11 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA60DC06175F;
        Thu,  4 Mar 2021 03:29:29 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a18so19030463wrc.13;
        Thu, 04 Mar 2021 03:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=40pLHnKRDrbU6TJaOaeEw7/+MusWDNP+s5ZgUOpvVwc=;
        b=h90NlX+Pe3747e66kieuyX970OdGIsBQuRimtM8RKUKK75QsfMyIHvBKy7kAQ/MNAJ
         eFxbVr+iRkHl1+pk38SsMgqHkin1PfxbmWfJmsMmFm4cTaWXM0CW4ZermE+H2IOrBcU0
         GX8RW9w4GPRDUCYQNZeEdOmGE3boDwl+dW5j2O5fqorU/n8h8qa3VGhehmJ8vKTAvOyd
         n+CkM+vABN6CXmb7EAbUjTJWcMZggxUvTvIXaa0IU1vnViIFMREo5SMyJPl+vtxlIuuh
         5JjZ1yrDYQNftXX8Ahd/5s4uFrw6hFuuUsSa10iv3EG3XA7EqX3jD3X5+jKseuMo+uB7
         QfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=40pLHnKRDrbU6TJaOaeEw7/+MusWDNP+s5ZgUOpvVwc=;
        b=T9dRBWzYCFejyRwp8B3hKEq5Be0HoNgHEOcp2p7ZljgOFrYTdiSrN/M394Sb2J47dt
         ++fEaQ4AvwYNLM4bfSc5UbdvyG7F2a9hcuNE8hqlZ1PeuwsxcQVVKTdbtemcHbqYaRNi
         BthIqeDx7aZytSLhKZQaf4Xio3GS7ezPJ2Wj7r+pPMtH+ElWfcfxCN4dTRebZnn2vswv
         CaDUgQWWYFee3Yf8shzSnIjD3Bj8SEdZbAmx8Jrmli3dhPDW5MQiZ23emPaD+TEuBR/f
         v/R4p14wOP5CO4iKwl3fkFD4/PF8p71DvQhY6jRUqahbRT7mrnzJyj4fi862Wk43AiWZ
         juRg==
X-Gm-Message-State: AOAM530Nha8kNRR/CaeKSTpf+GdBxYxT8biPAk9w8XwAT3sE+E4RT5dd
        AOQu00AMntBKbm9qICf1ap4=
X-Google-Smtp-Source: ABdhPJwmK0CaG3AXnme+wEmEKsvZe+0IlOtJYFeGEmtjC8eN1mOfa4Sw5NRUXIYV3x2XUtiWi1ZKrQ==
X-Received: by 2002:a5d:4e83:: with SMTP id e3mr3662717wru.82.1614857368389;
        Thu, 04 Mar 2021 03:29:28 -0800 (PST)
Received: from localhost.localdomain ([141.226.13.117])
        by smtp.gmail.com with ESMTPSA id 3sm25196554wry.72.2021.03.04.03.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 03:29:27 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 2/2] fanotify: support limited functionality for unprivileged users
Date:   Thu,  4 Mar 2021 13:29:21 +0200
Message-Id: <20210304112921.3996419-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304112921.3996419-1-amir73il@gmail.com>
References: <20210304112921.3996419-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add limited support for unprivileged fanotify groups.
An unprivileged users is not allowed to get an open file descriptor in
the event nor the process pid of another process.  An unprivileged user
cannot request permission events, cannot set mount/filesystem marks and
cannot request unlimited queue/marks.

This enables the limited functionality similar to inotify when watching a
set of files and directories for OPEN/ACCESS/MODIFY/CLOSE events, without
requiring SYS_CAP_ADMIN privileges.

The FAN_REPORT_DFID_NAME init flag, provide a method for an unprivileged
listener watching a set of directories (with FAN_EVENT_ON_CHILD) to monitor
all changes inside those directories.

This typically requires that the listener keeps a map of watched directory
fid to dirfd (O_PATH), where fid is obtained with name_to_handle_at()
before starting to watch for changes.

When getting an event, the reported fid of the parent should be resolved
to dirfd and fstatsat(2) with dirfd and name should be used to query the
state of the filesystem entry.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 29 ++++++++++++++++++++++++--
 fs/notify/fdinfo.c                 |  3 ++-
 include/linux/fanotify.h           | 33 +++++++++++++++++++++++++-----
 3 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index e81848e09646..65142b1fa823 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -419,6 +419,14 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	metadata.reserved = 0;
 	metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
 	metadata.pid = pid_vnr(event->pid);
+	/*
+	 * For an unprivileged listener, event->pid can be used to identify the
+	 * events generated by the listener process itself, without disclosing
+	 * the pids of other processes.
+	 */
+	if (!capable(CAP_SYS_ADMIN) &&
+	    task_tgid(current) != event->pid)
+		metadata.pid = 0;
 
 	if (path && path->mnt && path->dentry) {
 		fd = create_fd(group, path, &f);
@@ -1036,8 +1044,16 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
+	if (!capable(CAP_SYS_ADMIN)) {
+		/*
+		 * An unprivileged user can setup an fanotify group with
+		 * limited functionality - an unprivileged group is limited to
+		 * notification events with file handles and it cannot use
+		 * unlimited queue/marks.
+		 */
+		if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) || !fid_mode)
+			return -EPERM;
+	}
 
 #ifdef CONFIG_AUDITSYSCALL
 	if (flags & ~(FANOTIFY_INIT_FLAGS | FAN_ENABLE_AUDIT))
@@ -1288,6 +1304,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 	group = f.file->private_data;
 
+	/*
+	 * An unprivileged user is not allowed to watch a mount point nor
+	 * a filesystem.
+	 */
+	ret = -EPERM;
+	if (!capable(CAP_SYS_ADMIN) &&
+	    mark_type != FAN_MARK_INODE)
+		goto fput_and_out;
+
 	/*
 	 * group->priority == FS_PRIO_0 == FAN_CLASS_NOTIF.  These are not
 	 * allowed to set permissions events.
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index f0d6b54be412..a712b2aaa9ac 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -144,7 +144,8 @@ void fanotify_show_fdinfo(struct seq_file *m, struct file *f)
 	struct fsnotify_group *group = f->private_data;
 
 	seq_printf(m, "fanotify flags:%x event-flags:%x\n",
-		   group->fanotify_data.flags, group->fanotify_data.f_flags);
+		   group->fanotify_data.flags,
+		   group->fanotify_data.f_flags);
 
 	show_fdinfo(m, f, fanotify_fdinfo);
 }
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 031a97d8369a..bad41bcb25df 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -18,15 +18,38 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
  * these constant, the programs may break if re-compiled with new uapi headers
  * and then run on an old kernel.
  */
-#define FANOTIFY_CLASS_BITS	(FAN_CLASS_NOTIF | FAN_CLASS_CONTENT | \
+
+/* Group classes where permission events are allowed */
+#define FANOTIFY_PERM_CLASSES	(FAN_CLASS_CONTENT | \
 				 FAN_CLASS_PRE_CONTENT)
 
+#define FANOTIFY_CLASS_BITS	(FAN_CLASS_NOTIF | FANOTIFY_PERM_CLASSES)
+
 #define FANOTIFY_FID_BITS	(FAN_REPORT_FID | FAN_REPORT_DFID_NAME)
 
-#define FANOTIFY_INIT_FLAGS	(FANOTIFY_CLASS_BITS | FANOTIFY_FID_BITS | \
-				 FAN_REPORT_TID | \
-				 FAN_CLOEXEC | FAN_NONBLOCK | \
-				 FAN_UNLIMITED_QUEUE | FAN_UNLIMITED_MARKS)
+/*
+ * fanotify_init() flags that require CAP_SYS_ADMIN.
+ * We do not allow unprivileged groups to request permission events.
+ * We do not allow unprivileged groups to get other process pid in events.
+ * We do not allow unprivileged groups to use unlimited resources.
+ */
+#define FANOTIFY_ADMIN_INIT_FLAGS	(FANOTIFY_PERM_CLASSES | \
+					 FAN_REPORT_TID | \
+					 FAN_UNLIMITED_QUEUE | \
+					 FAN_UNLIMITED_MARKS)
+
+/*
+ * fanotify_init() flags that are allowed for user without CAP_SYS_ADMIN.
+ * FAN_CLASS_NOTIF is the only class we allow for unprivileged group.
+ * We do not allow unprivileged groups to get file descriptors in events,
+ * so one of the flags for reporting file handles is required.
+ */
+#define FANOTIFY_USER_INIT_FLAGS	(FAN_CLASS_NOTIF | \
+					 FANOTIFY_FID_BITS | \
+					 FAN_CLOEXEC | FAN_NONBLOCK)
+
+#define FANOTIFY_INIT_FLAGS	(FANOTIFY_ADMIN_INIT_FLAGS | \
+				 FANOTIFY_USER_INIT_FLAGS)
 
 #define FANOTIFY_MARK_TYPE_BITS	(FAN_MARK_INODE | FAN_MARK_MOUNT | \
 				 FAN_MARK_FILESYSTEM)
-- 
2.30.0

