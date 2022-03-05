Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726384CE5C3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 17:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiCEQFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 11:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiCEQFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:05:45 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A744527FB;
        Sat,  5 Mar 2022 08:04:50 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j17so16975020wrc.0;
        Sat, 05 Mar 2022 08:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FcuiD2GTRh1jKD6riWIdoaj4V02D0ZKz+QuzZ5wgQGU=;
        b=Rwn3Eyg5/Som6eX6+n+/G/om90aW3CoxBdaqpO9BZ+Q40A3jl16O4IHN715Egvirqq
         36hXGa770Kvbp/b8595OlbkXGhnzaUPIzO0RIm34wMeD1CwiYLypomNuwyNfxPFgipcr
         O65KT/eBIkiMtOtksgbbu7DmiyVstakDBM0LgjTYO+NzY6+1VGlszI06Ubln6Hu4dxDv
         mkBR3oO3mKWipP7WflZbqkI6JdwKpGeBjYDCQwXZY9p5poY1HBJ0WmDTl9YafC9Icpu6
         D3TrTDy/I47RCxMphjkvhxdJV4oyerbfsbraHthmqMCjyItJY8m3S6Qxy2SkqPsIQtLz
         2siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FcuiD2GTRh1jKD6riWIdoaj4V02D0ZKz+QuzZ5wgQGU=;
        b=U9Uu5LxeoxpbPc9zib1Drvi8vtfNRiTnxHYu01AIx/ZEkP+exFLzblPFsWsSuRk7Gd
         J63GCrqu8dfNDLOzypCUOWkD8Mkmv2/2LoPb3QKpqKbjVG1vClyjX82GejfAGJZucUGV
         ZnbLoIxhM480G4apDayJfUSJoVuxGA/mv4u8ZIrXR3FisYaSKalvhr9Wzf2bhaA6w6Rj
         SJRQaB/ktV3kL/C/UG7ikpaYXozY9Ic2xPKUzTekCij3tLYrtfwWJWNl28/XIz00W/rZ
         yI2/l7aNFRRiH1XkDwiu3ATnjAnqozeV46UftUdeDp+O9NnJNLAnFPOXORq9gGZfjQOc
         b8hQ==
X-Gm-Message-State: AOAM533N4HoEfxApV1VyxJkO7xvliFZ2d28je1y4eua99YPvMGJI8uwf
        SaSWcXUgP26rk72SqFiLh4c=
X-Google-Smtp-Source: ABdhPJxbG0YgMfH7AalD4bl48AHqlO8NwmV7Eay438yKe6WJnJy9fnHAk78EibAzk/8aE+Hy/xAnnA==
X-Received: by 2002:a5d:6392:0:b0:1f0:651d:51ac with SMTP id p18-20020a5d6392000000b001f0651d51acmr2895301wru.253.1646496288526;
        Sat, 05 Mar 2022 08:04:48 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm1650717wri.85.2022.03.05.08.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:04:48 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 5/9] fs: collect per-sb io stats
Date:   Sat,  5 Mar 2022 18:04:20 +0200
Message-Id: <20220305160424.1040102-6-amir73il@gmail.com>
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

Replace task io account helpers with wrappers that may also collect
per-sb io stats for filesystems that have per-sb io stats enabled.

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

