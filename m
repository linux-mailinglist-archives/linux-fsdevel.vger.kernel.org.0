Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF53D4C9371
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 19:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbiCASn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 13:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbiCASnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:43:24 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34235F9F;
        Tue,  1 Mar 2022 10:42:41 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u1so21918417wrg.11;
        Tue, 01 Mar 2022 10:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xzuvULgXIUX/WiyolQQEQyHGFyJpowTtJUHjSYjdBuM=;
        b=eqNJUVfZ+IINido+jqvZ7OrioxEfn447b0g67gVVH/qjsXX6Eolo63N4RTgk1rG5d6
         ToAvEE3eIar9AK1Aoy8sxQHYjiW/HnDCFdfLGcbiw7QfxhACaLKbLUoIjtcmnvrZI59b
         H5p+ztfcdgaVWGz7f+Iv/1LzMxf/81avht0QWDtq17nNhtc7aFQFCeE/Vc9zBu4O3Q4u
         2I5CgOoRK5pYQisg4aBr983H0EAgvOylX2lUI8jOhpKEFeh6vtKhYJPJOZ6uciiqZKsV
         tDowkPQnBbrzmVokZBhK0SAIDFSSZp6ZDZydTEcpWMx+1Sj0tExTCOTB+dVyWalQJjoQ
         35Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xzuvULgXIUX/WiyolQQEQyHGFyJpowTtJUHjSYjdBuM=;
        b=kCZ9YNc3SwAm8cwvOlmQytDNHmIVdzOQs4SJUSjQElBM8TZNF+wyMU0fZsRa41QaEY
         CF2nHpoXHh/aBU0VJHiJLD1Ngl1iNB/HcoJ5MYm357L++QoInvp4jxaK0M5+D0cO8Pxf
         V8yuRrtr8hsS2ItBvouK5gilk0DGSrEIu7OVxiHw5l1ymB9/U7DpY5A1OGwqqfrEhV/I
         SKVp7XyNvYRDVK1D3mryq2kW/F8SrBTbtIeTp6OqtrZrX8bFgwt74BV37WTCPrU/z22s
         W79Cc5ij/ZcAlfP0k7j+AHUktznxPo2KZSspy9pD0BZr98r5h92+Y9B/YZTkX9UAc4Ka
         csXw==
X-Gm-Message-State: AOAM533t62aVvutSUNDo/gyOTfjpRSWWw3gBUL9T+xPpr+K1qW8bN0Mb
        IgFa4RKZByqrgtwTW9pI73k=
X-Google-Smtp-Source: ABdhPJwXsG2Vj5ZgFFqDK7P+AYOaMsTefX0KdS8oKpmCpErm+7NZARmNNtwTmTdv8OK6NZpQqaM23w==
X-Received: by 2002:adf:e343:0:b0:1f0:7a2:99f2 with SMTP id n3-20020adfe343000000b001f007a299f2mr3845166wrj.96.1646160160404;
        Tue, 01 Mar 2022 10:42:40 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d4dc1000000b001eeadc98c0csm14020381wru.101.2022.03.01.10.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:42:40 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 3/6] fs: collect per-sb io stats
Date:   Tue,  1 Mar 2022 20:42:18 +0200
Message-Id: <20220301184221.371853-4-amir73il@gmail.com>
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

Replace task io account helpers with wrappers that may also collect
per-sb io stats.

Filesystems that want these per-sb io stats collected need to opt-in
with sb_iostats_init().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/read_write.c | 88 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 24 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 0074afa7ecb3..8c599bf2dd78 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -20,6 +20,7 @@
 #include <linux/compat.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
+#include <linux/fs_iostats.h>
 #include "internal.h"
 
 #include <linux/uaccess.h>
@@ -34,6 +35,45 @@ const struct file_operations generic_ro_fops = {
 
 EXPORT_SYMBOL(generic_ro_fops);
 
+static inline void file_iostats_counter_inc(struct file *file, int id)
+{
+	if (file)
+		sb_iostats_counter_inc(file->f_path.mnt->mnt_sb, id);
+}
+
+static inline void file_iostats_counter_add(struct file *file, int id,
+					    ssize_t amt)
+{
+	if (file)
+		sb_iostats_counter_add(file->f_path.mnt->mnt_sb, id, amt);
+}
+
+static void file_add_rchar(struct file *file, struct task_struct *tsk,
+			   ssize_t amt)
+{
+	file_iostats_counter_add(file, SB_IOSTATS_CHARS_RD, amt);
+	add_rchar(tsk, amt);
+}
+
+static void file_add_wchar(struct file *file, struct task_struct *tsk,
+			   ssize_t amt)
+{
+	file_iostats_counter_add(file, SB_IOSTATS_CHARS_WR, amt);
+	add_wchar(tsk, amt);
+}
+
+static void file_inc_syscr(struct file *file, struct task_struct *tsk)
+{
+	file_iostats_counter_inc(file, SB_IOSTATS_SYSCALLS_RD);
+	inc_syscr(current);
+}
+
+static void file_inc_syscw(struct file *file, struct task_struct *tsk)
+{
+	file_iostats_counter_inc(file, SB_IOSTATS_SYSCALLS_WR);
+	inc_syscw(current);
+}
+
 static inline bool unsigned_offsets(struct file *file)
 {
 	return file->f_mode & FMODE_UNSIGNED_OFFSET;
@@ -441,9 +481,9 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
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
 
@@ -483,9 +523,9 @@ ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
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
 
@@ -537,9 +577,9 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
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
@@ -592,9 +632,9 @@ ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_
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
@@ -947,8 +987,8 @@ static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
 	}
 
 	if (ret > 0)
-		add_rchar(current, ret);
-	inc_syscr(current);
+		file_add_rchar(f.file, current, ret);
+	file_inc_syscr(f.file, current);
 	return ret;
 }
 
@@ -971,8 +1011,8 @@ static ssize_t do_writev(unsigned long fd, const struct iovec __user *vec,
 	}
 
 	if (ret > 0)
-		add_wchar(current, ret);
-	inc_syscw(current);
+		file_add_wchar(f.file, current, ret);
+	file_inc_syscw(f.file, current);
 	return ret;
 }
 
@@ -1000,8 +1040,8 @@ static ssize_t do_preadv(unsigned long fd, const struct iovec __user *vec,
 	}
 
 	if (ret > 0)
-		add_rchar(current, ret);
-	inc_syscr(current);
+		file_add_rchar(f.file, current, ret);
+	file_inc_syscr(f.file, current);
 	return ret;
 }
 
@@ -1023,8 +1063,8 @@ static ssize_t do_pwritev(unsigned long fd, const struct iovec __user *vec,
 	}
 
 	if (ret > 0)
-		add_wchar(current, ret);
-	inc_syscw(current);
+		file_add_wchar(f.file, current, ret);
+	file_inc_syscw(f.file, current);
 	return ret;
 }
 
@@ -1250,8 +1290,8 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 	}
 
 	if (retval > 0) {
-		add_rchar(current, retval);
-		add_wchar(current, retval);
+		file_add_rchar(in.file, current, retval);
+		file_add_wchar(out.file, current, retval);
 		fsnotify_access(in.file);
 		fsnotify_modify(out.file);
 		out.file->f_pos = out_pos;
@@ -1261,8 +1301,8 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 			in.file->f_pos = pos;
 	}
 
-	inc_syscr(current);
-	inc_syscw(current);
+	file_inc_syscr(in.file, current);
+	file_inc_syscw(out.file, current);
 	if (pos > max)
 		retval = -EOVERFLOW;
 
@@ -1511,13 +1551,13 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
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

