Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46594C6AD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 12:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbiB1LkT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 06:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiB1LkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:40:09 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8DD710EC;
        Mon, 28 Feb 2022 03:39:30 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r10so14976589wrp.3;
        Mon, 28 Feb 2022 03:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8K1dPtjP6kt/9MicQEDSSkpjs+UJkjXgid/5yL0/qIs=;
        b=TasD+qz9xMoTcUs7jQ1O0lBlMOe2DV9YNo/ozcLO7O2IHeMWXxmd7piqIYdV8ubAED
         ebuasowgz+2TPe3TQ7c8AwBSynYTboBk38cu+EkRVI/h3DpFaMBER8X+VlI9MhYqaunV
         re72pKRgHu8/MngjkuktRS1MjlAup01DEYhDMLjmtA9Ezkdaxv3GBgNccY8JD2JI6xAU
         tNvq0uYTh6kvlnzvHiMcEYyUqyCkJCErHz3aeFKt8F1Wj1ik3rjfcph4crVGLS1iUXF6
         Gf9d/qtq3s9IxDw4uCXPCCwCbqMVbJGS3NA2WtZVco2ZREEFnK16aK3I0z9zjCmZZ+Da
         sRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8K1dPtjP6kt/9MicQEDSSkpjs+UJkjXgid/5yL0/qIs=;
        b=An+8ALoSDmPYsM2PDQHF5WmiYAwnlzazC4uAN+EdcagAcRj6Q0eF//t0JOBVXTpufZ
         iHcqQS9PVRS6Wmx+I0StXpNZoPubZc4uCfay3um1SOVCO/M44KlV70QF7y4RIvUoSisz
         LQM5jh6s9x0tiQaJxOmeQsczz8XCJaVT6HnGO7GxpPIdOyr3NZ8naICkKbGRnBvBkfMN
         X0LM8NQJ4DwfXFBfQOOIZcYsV/1wN+XNwnhI3ROIFZC0AKI2iuQQSUZ31SB48uJAu2HT
         WdGjAr8YM+WYAAsaJwY2USNWfy7nvUf9CR85RuDRsgnPWGH94xQEx8lj2rElfGld4sKg
         TKLA==
X-Gm-Message-State: AOAM533O1HHX13IkOPjloQ+A2LxYo141CTRmgNpF8pBWz1P5pGMwmS1t
        Xen8RUb6af3pSXgF2HpBdgefWYGgtSA=
X-Google-Smtp-Source: ABdhPJynxAe+Sike2N/G1k4+d1YltafzDWFYfwImEPBjh1oDW3XIMuMjkMJmnipFgZdIuj7oLHkRrg==
X-Received: by 2002:a5d:5307:0:b0:1ed:d1e0:391 with SMTP id e7-20020a5d5307000000b001edd1e00391mr14813683wrv.475.1646048369416;
        Mon, 28 Feb 2022 03:39:29 -0800 (PST)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id e22-20020adf9bd6000000b001eda1017861sm10584592wrc.64.2022.02.28.03.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 03:39:28 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-unionfs@vger.kernel.org,
        containers@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/6] fs: collect per-mount io stats
Date:   Mon, 28 Feb 2022 13:39:07 +0200
Message-Id: <20220228113910.1727819-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228113910.1727819-1-amir73il@gmail.com>
References: <20220228113910.1727819-1-amir73il@gmail.com>
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

Replace task io account helpers with wrappers that may also collect
per-mount stats.

Filesystems that want these per-mount io stats collected need to
opt-in with the FS_MOUNT_STATS flag.

We may consider opting-in per-mount using a mount option in the
future.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/mount.h         | 26 +++++++++++++++++
 fs/read_write.c    | 73 +++++++++++++++++++++++++++++++---------------
 include/linux/fs.h |  1 +
 3 files changed, 76 insertions(+), 24 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index b22169b4d24c..f98bf4cd5b1a 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -165,6 +165,16 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
 
 extern void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor);
 
+static inline bool mnt_has_stats(struct vfsmount *mnt)
+{
+#ifdef CONFIG_FS_MOUNT_STATS
+	/* Should this also be configurable per mount? */
+	return (mnt->mnt_sb->s_type->fs_flags & FS_MOUNT_STATS);
+#else
+	return false;
+#endif
+}
+
 static inline void mnt_iostats_counter_inc(struct mount *mnt, int id)
 {
 #ifdef CONFIG_FS_MOUNT_STATS
@@ -179,4 +189,20 @@ static inline void mnt_iostats_counter_add(struct mount *mnt, int id, s64 n)
 #endif
 }
 
+static inline void file_iostats_counter_inc(struct file *file, int id)
+{
+#ifdef CONFIG_FS_MOUNT_STATS
+	if (file && mnt_has_stats(file->f_path.mnt))
+		mnt_iostats_counter_inc(real_mount(file->f_path.mnt), id);
+#endif
+}
+
+static inline void file_iostats_counter_add(struct file *file, int id, s64 n)
+{
+#ifdef CONFIG_FS_MOUNT_STATS
+	if (file && mnt_has_stats(file->f_path.mnt))
+		mnt_iostats_counter_add(real_mount(file->f_path.mnt), id, n);
+#endif
+}
+
 extern s64 mnt_iostats_counter_read(struct mount *mnt, int id);
diff --git a/fs/read_write.c b/fs/read_write.c
index 0074afa7ecb3..386a907a19a8 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -21,6 +21,7 @@
 #include <linux/mount.h>
 #include <linux/fs.h>
 #include "internal.h"
+#include "mount.h"
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -34,6 +35,30 @@ const struct file_operations generic_ro_fops = {
 
 EXPORT_SYMBOL(generic_ro_fops);
 
+static void file_add_rchar(struct file *file, struct task_struct *tsk, ssize_t amt)
+{
+	file_iostats_counter_add(file, MNTIOS_CHARS_RD, amt);
+	add_rchar(tsk, amt);
+}
+
+static void file_add_wchar(struct file *file, struct task_struct *tsk, ssize_t amt)
+{
+	file_iostats_counter_add(file, MNTIOS_CHARS_WR, amt);
+	add_wchar(tsk, amt);
+}
+
+static void file_inc_syscr(struct file *file, struct task_struct *tsk)
+{
+	file_iostats_counter_inc(file, MNTIOS_SYSCALLS_RD);
+	inc_syscr(current);
+}
+
+static void file_inc_syscw(struct file *file, struct task_struct *tsk)
+{
+	file_iostats_counter_inc(file, MNTIOS_SYSCALLS_WR);
+	inc_syscw(current);
+}
+
 static inline bool unsigned_offsets(struct file *file)
 {
 	return file->f_mode & FMODE_UNSIGNED_OFFSET;
@@ -441,9 +466,9 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
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
 
@@ -483,9 +508,9 @@ ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
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
 
@@ -537,9 +562,9 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
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
@@ -592,9 +617,9 @@ ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_
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
@@ -947,8 +972,8 @@ static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
 	}
 
 	if (ret > 0)
-		add_rchar(current, ret);
-	inc_syscr(current);
+		file_add_rchar(f.file, current, ret);
+	file_inc_syscr(f.file, current);
 	return ret;
 }
 
@@ -971,8 +996,8 @@ static ssize_t do_writev(unsigned long fd, const struct iovec __user *vec,
 	}
 
 	if (ret > 0)
-		add_wchar(current, ret);
-	inc_syscw(current);
+		file_add_wchar(f.file, current, ret);
+	file_inc_syscw(f.file, current);
 	return ret;
 }
 
@@ -1000,8 +1025,8 @@ static ssize_t do_preadv(unsigned long fd, const struct iovec __user *vec,
 	}
 
 	if (ret > 0)
-		add_rchar(current, ret);
-	inc_syscr(current);
+		file_add_rchar(f.file, current, ret);
+	file_inc_syscr(f.file, current);
 	return ret;
 }
 
@@ -1023,8 +1048,8 @@ static ssize_t do_pwritev(unsigned long fd, const struct iovec __user *vec,
 	}
 
 	if (ret > 0)
-		add_wchar(current, ret);
-	inc_syscw(current);
+		file_add_wchar(f.file, current, ret);
+	file_inc_syscw(f.file, current);
 	return ret;
 }
 
@@ -1250,8 +1275,8 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 	}
 
 	if (retval > 0) {
-		add_rchar(current, retval);
-		add_wchar(current, retval);
+		file_add_rchar(in.file, current, retval);
+		file_add_wchar(out.file, current, retval);
 		fsnotify_access(in.file);
 		fsnotify_modify(out.file);
 		out.file->f_pos = out_pos;
@@ -1261,8 +1286,8 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 			in.file->f_pos = pos;
 	}
 
-	inc_syscr(current);
-	inc_syscw(current);
+	file_inc_syscr(in.file, current);
+	file_inc_syscw(out.file, current);
 	if (pos > max)
 		retval = -EOVERFLOW;
 
@@ -1511,13 +1536,13 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
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
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f220db331dba..60ee8d8ef020 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2434,6 +2434,7 @@ struct file_system_type {
 #define FS_USERNS_MOUNT		(1<<3)	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	(1<<4)	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP		(1<<5)	/* FS can handle vfs idmappings */
+#define FS_MOUNT_STATS		(1<<6)	/* FS has generic proc/pid/mountstats */
 #define FS_RENAME_DOES_D_MOVE	(1<<15)	/* FS will handle d_move() internally */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
-- 
2.25.1

