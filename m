Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF33F7BC62D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 10:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjJGIo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 04:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbjJGIop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:44:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3669C;
        Sat,  7 Oct 2023 01:44:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4066692ad35so26179825e9.1;
        Sat, 07 Oct 2023 01:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696668282; x=1697273082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmZS4tIDK1uSC4ejzxwsJgCokndmYIfM6rMk/k5lfY0=;
        b=T3OZsPzNHUC3+YG7ls+nJJKbNtfogfRCc+pmaZ/qI7l8CpiOGxREqRa56FAU/NTS7x
         htDSTmfoGwYd6KSjTFGWWfTRrrpqWH+sssT206iYOmdSLOWe1QysRsjE3SjQXJenLV+w
         6e49/VG+S7yPHdU87ddJAEyNjF2s//q9SiTbHaEr1ucodXMJJ/tkWl4Vpj0q/QMrGrdy
         tktGKWu9KJUaRCw8kFlPyhjE/byTrnkbfVgdBRabkPooBaL1/cTMAhnKDCWo5BH5DVTp
         q+EEZly6qJA45uUijDsIxq0wR5TnJwIWxBZP/QYPczMwO/zMk5Nu7v7qhtaiXUB966ix
         6mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696668282; x=1697273082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmZS4tIDK1uSC4ejzxwsJgCokndmYIfM6rMk/k5lfY0=;
        b=oM5CZ02ouQr4ivr26JrEzdNQgQPLBdS7b1cFzHGVDMngOu9g6yhmiwwiPllwq0DRFl
         WqcnL9z1BPLiIuGK3TeMq0MpjV7VvpfvgUY11CGZNSApNevghJsiTVzBLA0SUdaCQYhb
         IhhinQyvOxifyGsUgRbapghreG3pWye+rf+9r+F17NZ8Dpn7SwlQQhanpR02xV0H55fk
         hXzJ9wtdlAOu2JaPs/L5C3+33W8rM1cAVtiEuFNHyya0XdkvX4dfw8/sI/NBW+78e808
         p9hIAmU9iyKUqnTdypUCX4giszFzDfGYppPyYFA9iFM/wt1QyL85ZZPpYHOYRskodUV/
         y2NA==
X-Gm-Message-State: AOJu0YyvYdaJa57ckzLccFVUMniC883pIWT7/Hbo3KzZCPVkhGhAfP4D
        S+exfDva03KhHrsHl2en1B0=
X-Google-Smtp-Source: AGHT+IEq1wkZg+BW6VTKGCNzALIdtQTG0W3UxcAEsB20AtdnFiqUjAck93S565u/FqyoRjpIdorkfQ==
X-Received: by 2002:adf:e883:0:b0:317:7062:32d2 with SMTP id d3-20020adfe883000000b00317706232d2mr8318929wrm.54.1696668281495;
        Sat, 07 Oct 2023 01:44:41 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id a12-20020adff7cc000000b0031423a8f4f7sm3677850wrq.56.2023.10.07.01.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 01:44:41 -0700 (PDT)
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
Subject: [PATCH v2 2/3] fs: create helper file_user_path() for user displayed mapped file path
Date:   Sat,  7 Oct 2023 11:44:32 +0300
Message-Id: <20231007084433.1417887-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231007084433.1417887-1-amir73il@gmail.com>
References: <20231007084433.1417887-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 arch/arc/kernel/troubleshoot.c |  3 ++-
 fs/proc/base.c                 |  2 +-
 fs/proc/nommu.c                |  2 +-
 fs/proc/task_mmu.c             |  4 ++--
 fs/proc/task_nommu.c           |  2 +-
 include/linux/fs.h             | 14 ++++++++++++++
 kernel/trace/trace_output.c    |  2 +-
 7 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index d5b3ed2c58f5..097887e4a9b7 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -93,7 +93,8 @@ static void show_faulting_vma(unsigned long address)
 		char *nm = "?";
 
 		if (vma->vm_file) {
-			nm = file_path(vma->vm_file, buf, ARC_PATH_MAX-1);
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

