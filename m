Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE477BE511
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 17:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377745AbjJIPh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 11:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377762AbjJIPht (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:37:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3974127;
        Mon,  9 Oct 2023 08:37:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3296b87aa13so2822996f8f.3;
        Mon, 09 Oct 2023 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696865843; x=1697470643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wmy0daGALQ1py5IbjkFGv3XbOVsnYmBR2h2654w7l88=;
        b=J2QIG6VLwdE0eespBrzmL+vciAO356222tPl2UlxUgRvzrGusMqWrmzkVFlSXv2h2t
         5+PhGl6FDqZLSz/RpgtfN/uIJF5kj5pKw9Rb5omfnOsK3PqHD8HcJNjcnl7Ojf8v4os3
         L3nw1koRKyI0Pw6ET7TWYMW1IFl9eMKMxXBj9LjarvmyO4xuh6iTz5TCR/xvPsAR6r77
         fhHAcwQbKIisfYNy2fSK+HwPkaPvbB7T5tS6NobMv+9Hp38oGYGAZu80ugxfTNpJsxb+
         aLZJp/oJpViWOVoT6N0e9SdUBQXxxn861VAsHdlwxCr9aIhGA3udcRpQxZmk9f5a+T7u
         Sgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865843; x=1697470643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wmy0daGALQ1py5IbjkFGv3XbOVsnYmBR2h2654w7l88=;
        b=cQorfbXS8ev2Ypz9XxT8ppErKdAeBpHOGbhFLs5hJTsvVKEuccizqKjYdm80BFOQpv
         cTNS52NenGH6dR5CQ7HDaTy21iqIqayOe7vD8xdH+ow7V4CVRe9GqvSgy26urbD0DiI3
         lk29Qc7j+JGhKxCWuPyw1IGAmYoe8aAJmscUh1XdxvfPgtCYTeJbtGqEwu8C0ewcXG+p
         hOGjZJBBvQczBYH7tIHqb9A6hHJUg9OhXihf7fLCyhtUfR50/PRrOtlFXeWyO6SvcHGu
         oQZL72piHknPZhJHsFPkIKgUTnINkH4lvpe5ac+Bdqj4WDh6LR2txwNfAXRozX3zWH3Y
         3YfA==
X-Gm-Message-State: AOJu0YxwpqnFXKt1va0QmcFBFlQR/cj828rsOsyyop9EuQEn11HyGWfO
        6GC7eaL27dGr2x+Tati7q1Y=
X-Google-Smtp-Source: AGHT+IEkgTUmTfWy3RPhueraFJ/Pb9buE12pC3YvZg1L7Auowskq7n3WIOQKtLtyVnCEzublhLPVMw==
X-Received: by 2002:adf:e3ca:0:b0:317:6a07:83a7 with SMTP id k10-20020adfe3ca000000b003176a0783a7mr13822243wrm.38.1696865842859;
        Mon, 09 Oct 2023 08:37:22 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id g7-20020a056000118700b003143c9beeaesm9939924wrx.44.2023.10.09.08.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:37:22 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/3] fs: create helper file_user_path() for user displayed mapped file path
Date:   Mon,  9 Oct 2023 18:37:11 +0300
Message-Id: <20231009153712.1566422-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009153712.1566422-1-amir73il@gmail.com>
References: <20231009153712.1566422-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overlayfs uses backing files with "fake" overlayfs f_path and "real"
underlying f_inode, in order to use underlying inode aops for mapped
files and to display the overlayfs path in /proc/<pid>/maps.

In preparation for storing the overlayfs "fake" path instead of the
underlying "real" path in struct backing_file, define a noop helper
file_user_path() that returns f_path for now.

Use the new helper in procfs and kernel logs whenever a path of a
mapped file is displayed to users.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 arch/arc/kernel/troubleshoot.c |  6 ++++--
 fs/proc/base.c                 |  2 +-
 fs/proc/nommu.c                |  2 +-
 fs/proc/task_mmu.c             |  4 ++--
 fs/proc/task_nommu.c           |  2 +-
 include/linux/fs.h             | 14 ++++++++++++++
 kernel/trace/trace_output.c    |  2 +-
 7 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index d5b3ed2c58f5..c380d8c30704 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -90,10 +90,12 @@ static void show_faulting_vma(unsigned long address)
 	 */
 	if (vma) {
 		char buf[ARC_PATH_MAX];
-		char *nm = "?";
+		char *nm = "anon";
 
 		if (vma->vm_file) {
-			nm = file_path(vma->vm_file, buf, ARC_PATH_MAX-1);
+			/* XXX: can we use %pD below and get rid of buf? */
+			nm = d_path(file_user_path(vma->vm_file), buf,
+				    ARC_PATH_MAX-1);
 			if (IS_ERR(nm))
 				nm = "?";
 		}
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ffd54617c354..20695c928ee6 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2218,7 +2218,7 @@ static int map_files_get_link(struct dentry *dentry, struct path *path)
 	rc = -ENOENT;
 	vma = find_exact_vma(mm, vm_start, vm_end);
 	if (vma && vma->vm_file) {
-		*path = vma->vm_file->f_path;
+		*path = *file_user_path(vma->vm_file);
 		path_get(path);
 		rc = 0;
 	}
diff --git a/fs/proc/nommu.c b/fs/proc/nommu.c
index 4d3493579458..c6e7ebc63756 100644
--- a/fs/proc/nommu.c
+++ b/fs/proc/nommu.c
@@ -58,7 +58,7 @@ static int nommu_region_show(struct seq_file *m, struct vm_region *region)
 
 	if (file) {
 		seq_pad(m, ' ');
-		seq_file_path(m, file, "");
+		seq_path(m, file_user_path(file), "");
 	}
 
 	seq_putc(m, '\n');
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3dd5be96691b..1593940ca01e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -296,7 +296,7 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 		if (anon_name)
 			seq_printf(m, "[anon_shmem:%s]", anon_name->name);
 		else
-			seq_file_path(m, file, "\n");
+			seq_path(m, file_user_path(file), "\n");
 		goto done;
 	}
 
@@ -1967,7 +1967,7 @@ static int show_numa_map(struct seq_file *m, void *v)
 
 	if (file) {
 		seq_puts(m, " file=");
-		seq_file_path(m, file, "\n\t= ");
+		seq_path(m, file_user_path(file), "\n\t= ");
 	} else if (vma_is_initial_heap(vma)) {
 		seq_puts(m, " heap");
 	} else if (vma_is_initial_stack(vma)) {
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index 7cebd397cc26..bce674533000 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -157,7 +157,7 @@ static int nommu_vma_show(struct seq_file *m, struct vm_area_struct *vma)
 
 	if (file) {
 		seq_pad(m, ' ');
-		seq_file_path(m, file, "");
+		seq_path(m, file_user_path(file), "");
 	} else if (mm && vma_is_initial_stack(vma)) {
 		seq_pad(m, ' ');
 		seq_puts(m, "[stack]");
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7f7e7d2efbeb..a8e4e1cac48e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2472,6 +2472,20 @@ static inline const struct path *file_real_path(struct file *f)
 	return &f->f_path;
 }
 
+/*
+ * file_user_path - get the path to display for memory mapped file
+ *
+ * When mmapping a file on a stackable filesystem (e.g., overlayfs), the file
+ * stored in ->vm_file is a backing file whose f_inode is on the underlying
+ * filesystem.  When the mapped file path is displayed to user (e.g. via
+ * /proc/<pid>/maps), this helper should be used to get the path to display
+ * to the user, which is the path of the fd that user has requested to map.
+ */
+static inline const struct path *file_user_path(struct file *f)
+{
+	return &f->f_path;
+}
+
 static inline struct file *file_clone_open(struct file *file)
 {
 	return dentry_open(&file->f_path, file->f_flags, file->f_cred);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index db575094c498..d8b302d01083 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -404,7 +404,7 @@ static int seq_print_user_ip(struct trace_seq *s, struct mm_struct *mm,
 			vmstart = vma->vm_start;
 		}
 		if (file) {
-			ret = trace_seq_path(s, &file->f_path);
+			ret = trace_seq_path(s, file_user_path(file));
 			if (ret)
 				trace_seq_printf(s, "[+0x%lx]",
 						 ip - vmstart);
-- 
2.34.1

