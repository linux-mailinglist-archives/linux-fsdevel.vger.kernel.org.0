Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4548D2EE7C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 22:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbhAGVov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 16:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbhAGVou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:44:50 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927C7C0612FD
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jan 2021 13:44:07 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 3so6753407wmg.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jan 2021 13:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ABbyrbeWgQQo1b2pUDkcD6wN158tfpfRCjginlZYZRE=;
        b=iiAAaHk3Wq971YULeeeLRDAKw+DjcXY0Eer57b9I6ZFZtV+bk5uFDXAyrJE9VJnV+y
         GrvqE7HYVslHERx6Cgb6+uJfIxHOBf5dEQx5O9ERKKh1V2+97amALIoAOSv7fnndzCcA
         xhECplo3ctmi8JhZHcvHdvm2Bkhd9NZkRcoiGqdlrcts9TlKdIgDeYdEcZZuUQA8nlCc
         HAwcEpuIQSnfthx/CNvbFIdFp6D0tTd6cYw2rofUi9M8IVepW/lcWZ9a6oy+jgFvMHkp
         9c1QtWR4rx7Dw6xlPnQIplFfqtxdfIRG6nJ4QGG0P9qYe+dRal5hmtRzJePXaSN7eJU7
         EI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ABbyrbeWgQQo1b2pUDkcD6wN158tfpfRCjginlZYZRE=;
        b=P4MomqfxbtHFmKew6R1Qs6dDjxgQ5itLJxX38vINnw2lI8lXYIZlscOHQvasHMfk4t
         9ivNaCZExUcztTQxV3XWIZTPTOXX7wVmjIl9zKfTm2mDlcmfPXEcAPoAgBVwb0VRW9K9
         5zPrgs8wUT72jybHqjlXC2RDstUhcO8OiOzV3MXw27Ad6LVreIGSYvO62b2LKWEBFnWt
         XgUojEowuHs34i4UvWIqSy1eD52Kn/XvqhZ4A16gAgHxvj57GcEi253JU9JMRcqtYcT/
         9SqLaPFqHlRB0vURgdeUL3i8D6mqa5mqY7kcDn8rJmUI9TyuG1IJHV4vdYJsikMDBZgm
         ojtg==
X-Gm-Message-State: AOAM531dCKWnfhr3jb7xP3fxeGEPE7F7hCt93ZfJDvusdn3NFAj5kHLR
        v7n2Yt8m0grWWJmlSUnm7UM=
X-Google-Smtp-Source: ABdhPJxBIQeY8LwDZDF8GQkR09wVYAGLRtgJv6iNypFzGnrk2TA1ckCU/wXgyQ2tgeleAVCxQDlH+A==
X-Received: by 2002:a1c:2394:: with SMTP id j142mr448769wmj.42.1610055846351;
        Thu, 07 Jan 2021 13:44:06 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id g1sm10084997wrq.30.2021.01.07.13.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:44:05 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 2/3] fs: collect per-mount io stats
Date:   Thu,  7 Jan 2021 23:44:00 +0200
Message-Id: <20210107214401.249416-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107214401.249416-1-amir73il@gmail.com>
References: <20210107214401.249416-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace task io account helpers with wrappers that may also collect
per-mount stats.

Currently, just for example, stats are collected for mounts of
filesystems with flag FS_USERNS_MOUNT.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

I used the arbirtaty flag FS_USERNS_MOUNT as an example for a way for
filesystem to opt-in to mount io stats, but it could be either an FS_
SB_ or MNT_ flag.  I do not anticipate shortage of opinions on this
matter.

As for performance, the io accounting hooks are the existing hooks for
task io accounting.  mount io stats add a dereference to mnt_pcp for
the filesystems that opt-in and one per-cpu var update.  The dereference
to mnt_sb->s_type->fs_flags is temporary as we will probably want to
use an MNT_ flag, whether kernel internal or user controlled.

Thanks,
Amir.

 fs/mount.h      | 21 ++++++++++++
 fs/read_write.c | 87 +++++++++++++++++++++++++++++++++++--------------
 2 files changed, 84 insertions(+), 24 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 2bf0df64ded5..81db83c36140 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -175,6 +175,27 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
 
 extern void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor);
 
+static inline bool mnt_has_stats(struct vfsmount *mnt)
+{
+#ifdef CONFIG_FS_MOUNT_STATS
+	/* Just for example. Should this be an FS_ SB_ or MNT_ flag? */
+	return (mnt->mnt_sb->s_type->fs_flags & FS_USERNS_MOUNT);
+#else
+	return false;
+#endif
+}
+
+static inline struct mount *file_mnt_has_stats(struct file *file)
+{
+#ifdef CONFIG_FS_MOUNT_STATS
+	struct vfsmount *mnt = file->f_path.mnt;
+
+	if (mnt_has_stats(mnt))
+		return real_mount(mnt);
+#endif
+	return NULL;
+}
+
 static inline void mnt_iostats_counter_inc(struct mount *mnt, int id)
 {
 #ifdef CONFIG_FS_MOUNT_STATS
diff --git a/fs/read_write.c b/fs/read_write.c
index 75f764b43418..7e3e1ebfefb4 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -21,6 +21,7 @@
 #include <linux/mount.h>
 #include <linux/fs.h>
 #include "internal.h"
+#include "mount.h"
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -34,6 +35,44 @@ const struct file_operations generic_ro_fops = {
 
 EXPORT_SYMBOL(generic_ro_fops);
 
+static void file_add_rchar(struct file *file, struct task_struct *tsk,
+			   ssize_t amt)
+{
+	struct mount *m = file_mnt_has_stats(file);
+
+	if (m)
+		mnt_iostats_counter_add(m, MNTIOS_CHARS_RD, amt);
+	add_rchar(tsk, amt);
+}
+
+static void file_add_wchar(struct file *file, struct task_struct *tsk,
+			   ssize_t amt)
+{
+	struct mount *m = file_mnt_has_stats(file);
+
+	if (m)
+		mnt_iostats_counter_add(m, MNTIOS_CHARS_WR, amt);
+	add_wchar(tsk, amt);
+}
+
+static void file_inc_syscr(struct file *file, struct task_struct *tsk)
+{
+	struct mount *m = file_mnt_has_stats(file);
+
+	if (m)
+		mnt_iostats_counter_inc(m, MNTIOS_SYSCALLS_RD);
+	inc_syscr(current);
+}
+
+static void file_inc_syscw(struct file *file, struct task_struct *tsk)
+{
+	struct mount *m = file_mnt_has_stats(file);
+
+	if (m)
+		mnt_iostats_counter_inc(m, MNTIOS_SYSCALLS_WR);
+	inc_syscw(current);
+}
+
 static inline bool unsigned_offsets(struct file *file)
 {
 	return file->f_mode & FMODE_UNSIGNED_OFFSET;
@@ -456,9 +495,9 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 		if (pos)
 			*pos = kiocb.ki_pos;
 		fsnotify_access(file);
-		add_rchar(current, ret);
+		file_add_rchar(file, current, ret);
 	}
-	inc_syscr(current);
+	file_inc_syscr(file, current);
 	return ret;
 }
 
@@ -498,9 +537,9 @@ ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
 		ret = -EINVAL;
 	if (ret > 0) {
 		fsnotify_access(file);
-		add_rchar(current, ret);
+		file_add_rchar(file, current, ret);
 	}
-	inc_syscr(current);
+	file_inc_syscr(file, current);
 	return ret;
 }
 
@@ -552,9 +591,9 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 		if (pos)
 			*pos = kiocb.ki_pos;
 		fsnotify_modify(file);
-		add_wchar(current, ret);
+		file_add_wchar(file, current, ret);
 	}
-	inc_syscw(current);
+	file_inc_syscw(file, current);
 	return ret;
 }
 /*
@@ -607,9 +646,9 @@ ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_
 		ret = -EINVAL;
 	if (ret > 0) {
 		fsnotify_modify(file);
-		add_wchar(current, ret);
+		file_add_wchar(file, current, ret);
 	}
-	inc_syscw(current);
+	file_inc_syscw(file, current);
 	file_end_write(file);
 	return ret;
 }
@@ -962,8 +1001,8 @@ static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
 	}
 
 	if (ret > 0)
-		add_rchar(current, ret);
-	inc_syscr(current);
+		file_add_rchar(f.file, current, ret);
+	file_inc_syscr(f.file, current);
 	return ret;
 }
 
@@ -986,8 +1025,8 @@ static ssize_t do_writev(unsigned long fd, const struct iovec __user *vec,
 	}
 
 	if (ret > 0)
-		add_wchar(current, ret);
-	inc_syscw(current);
+		file_add_wchar(f.file, current, ret);
+	file_inc_syscw(f.file, current);
 	return ret;
 }
 
@@ -1015,8 +1054,8 @@ static ssize_t do_preadv(unsigned long fd, const struct iovec __user *vec,
 	}
 
 	if (ret > 0)
-		add_rchar(current, ret);
-	inc_syscr(current);
+		file_add_rchar(f.file, current, ret);
+	file_inc_syscr(f.file, current);
 	return ret;
 }
 
@@ -1038,8 +1077,8 @@ static ssize_t do_pwritev(unsigned long fd, const struct iovec __user *vec,
 	}
 
 	if (ret > 0)
-		add_wchar(current, ret);
-	inc_syscw(current);
+		file_add_wchar(f.file, current, ret);
+	file_inc_syscw(f.file, current);
 	return ret;
 }
 
@@ -1258,8 +1297,8 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 	file_end_write(out.file);
 
 	if (retval > 0) {
-		add_rchar(current, retval);
-		add_wchar(current, retval);
+		file_add_rchar(in.file, current, retval);
+		file_add_wchar(out.file, current, retval);
 		fsnotify_access(in.file);
 		fsnotify_modify(out.file);
 		out.file->f_pos = out_pos;
@@ -1269,8 +1308,8 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 			in.file->f_pos = pos;
 	}
 
-	inc_syscr(current);
-	inc_syscw(current);
+	file_inc_syscr(in.file, current);
+	file_inc_syscw(out.file, current);
 	if (pos > max)
 		retval = -EOVERFLOW;
 
@@ -1519,13 +1558,13 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 done:
 	if (ret > 0) {
 		fsnotify_access(file_in);
-		add_rchar(current, ret);
+		file_add_rchar(file_in, current, ret);
 		fsnotify_modify(file_out);
-		add_wchar(current, ret);
+		file_add_wchar(file_out, current, ret);
 	}
 
-	inc_syscr(current);
-	inc_syscw(current);
+	file_inc_syscr(file_in, current);
+	file_inc_syscw(file_out, current);
 
 	file_end_write(file_out);
 
-- 
2.25.1

