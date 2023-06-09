Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD49729139
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 09:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbjFIHeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 03:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbjFIHeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:34:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005CC3A82;
        Fri,  9 Jun 2023 00:33:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f642a24568so1763835e87.2;
        Fri, 09 Jun 2023 00:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686295968; x=1688887968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQajwurBrexF3RgH/dCXscnFIs5TmYO49NFvfACESZg=;
        b=a0VZw62YcJ6uuuQAcNULYTBQhJ8ERceFYiIAf9S88dfyEg3hKK4WgQudKxj0ADt5Ua
         SYVWRyOl4uklX8HSydK5U2ycrh9uW/q0tFWzTC12KvAeaZ8vKevxXWNxZy1ly+aftu8D
         kW+0rlz1FCqlJ2rFeEs3GXytvRc5TL68p3EglgWXqxNKGPfQujvsWRwnVt+XUUmsETZD
         4nGOcbtoXy3BZXLxSsgCUQiWB2XpuwPs+SNYVqDldJGCN2TMa1+y2tQJoto+FszVe9Ge
         bcNrXXiPrrK7ZcU7QITxtNxW/fAszbMdfV3es6bL4B2nvPn5M/mVLCmuQfbEcqlwnnJh
         mwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686295968; x=1688887968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQajwurBrexF3RgH/dCXscnFIs5TmYO49NFvfACESZg=;
        b=aTWN50aCfClmJckBI5cIjhFlNYbmbjPjwKYD1nSGWEudHap2iE51aTuu1/Dt2cEQOy
         zU6M1wJbchDxLJZmJjpoxm1ghOfAy0RK+wuaTGpWzUdWHce7qtaQ8eq9bhxM4ZLCKszT
         yyGc0SLCfGpPHyXN54bNzh/Cc+4dO8fdjG8ojWhNgSPGF0rKqWlqK5nKOdvq3ZuwRS09
         /bk699tlmLr5iqTs1KTJkUwkLY/wNlqMsVN41H9aE6TRthUCKEEmSUl5pBYuEbdafa41
         uPJJk1Ol8t/Rcksym+qs2tMFZLR2osYHkuxSaF3hKT1bKWRYLkfEuNJkkpGSkfXHCZRC
         65dQ==
X-Gm-Message-State: AC+VfDwlLPd3fdGS80how3Mkrie8ZkifsTPrX8i3BVQ1kM22Un/P6txe
        ly+hIFbh+x4LH52T2LNmMSe/ZdXuavY=
X-Google-Smtp-Source: ACHHUZ75H1nyUAVTty2YGczZIMyK+HR+48Qu7b7K4xKOqMgJEtdp+25RefPS0WPQT0gUINrPjzBGbQ==
X-Received: by 2002:a19:5f12:0:b0:4f6:1433:fca0 with SMTP id t18-20020a195f12000000b004f61433fca0mr272216lfb.0.1686295967835;
        Fri, 09 Jun 2023 00:32:47 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000050300b003068f5cca8csm3624528wrf.94.2023.06.09.00.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 00:32:47 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 2/3] fs: use file_fake_path() to get path of mapped files for display
Date:   Fri,  9 Jun 2023 10:32:38 +0300
Message-Id: <20230609073239.957184-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609073239.957184-1-amir73il@gmail.com>
References: <20230609073239.957184-1-amir73il@gmail.com>
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

/proc/$pid/maps and /proc/$pid/exe contain display paths of mapped file.
audot and tomoyo also log the display path of the mapped exec file.

When the mapped file comes from overlayfs, we need to use the macro
file_fake_path() to make sure that we get the fake overlayfs path and
not the real internal path.

At the time of this commit, file_fake_path() always returns f_path,
where overlayfs has stored the fake overlayfs path, but soon we are
going to change the location that the fake path is stored.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/proc/base.c         | 8 +++++---
 fs/seq_file.c          | 2 +-
 kernel/audit.c         | 3 ++-
 kernel/fork.c          | 5 +++--
 security/tomoyo/util.c | 3 ++-
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 05452c3b9872..d6f8c77a3e38 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1730,8 +1730,9 @@ static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
 	exe_file = get_task_exe_file(task);
 	put_task_struct(task);
 	if (exe_file) {
-		*exe_path = exe_file->f_path;
-		path_get(&exe_file->f_path);
+		/* Overlayfs mapped files have fake path */
+		*exe_path = *file_fake_path(exe_file);
+		path_get(exe_path);
 		fput(exe_file);
 		return 0;
 	} else
@@ -2218,7 +2219,8 @@ static int map_files_get_link(struct dentry *dentry, struct path *path)
 	rc = -ENOENT;
 	vma = find_exact_vma(mm, vm_start, vm_end);
 	if (vma && vma->vm_file) {
-		*path = vma->vm_file->f_path;
+		/* Overlayfs mapped files have fake path */
+		*path = *file_fake_path(vma->vm_file);
 		path_get(path);
 		rc = 0;
 	}
diff --git a/fs/seq_file.c b/fs/seq_file.c
index f5fdaf3b1572..7e65fde4336a 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -497,7 +497,7 @@ EXPORT_SYMBOL(seq_path);
  */
 int seq_file_path(struct seq_file *m, struct file *file, const char *esc)
 {
-	return seq_path(m, &file->f_path, esc);
+	return seq_path(m, file_fake_path(file), esc);
 }
 EXPORT_SYMBOL(seq_file_path);
 
diff --git a/kernel/audit.c b/kernel/audit.c
index 9bc0b0301198..91975f139a03 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2202,7 +2202,8 @@ void audit_log_d_path_exe(struct audit_buffer *ab,
 	if (!exe_file)
 		goto out_null;
 
-	audit_log_d_path(ab, " exe=", &exe_file->f_path);
+	/* Overlayfs mapped files have fake path */
+	audit_log_d_path(ab, " exe=", file_fake_path(exe_file));
 	fput(exe_file);
 	return;
 out_null:
diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..9a3c138a677e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1455,8 +1455,9 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 		for_each_vma(vmi, vma) {
 			if (!vma->vm_file)
 				continue;
-			if (path_equal(&vma->vm_file->f_path,
-				       &old_exe_file->f_path)) {
+			/* Overlayfs mapped files have fake path */
+			if (path_equal(file_fake_path(vma->vm_file),
+				       file_fake_path(old_exe_file))) {
 				ret = -EBUSY;
 				break;
 			}
diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
index 6799b1122c9d..ff0d94fb431c 100644
--- a/security/tomoyo/util.c
+++ b/security/tomoyo/util.c
@@ -975,7 +975,8 @@ const char *tomoyo_get_exe(void)
 	if (!exe_file)
 		return NULL;
 
-	cp = tomoyo_realpath_from_path(&exe_file->f_path);
+	/* Overlayfs mapped files have fake path */
+	cp = tomoyo_realpath_from_path(file_fake_path(exe_file));
 	fput(exe_file);
 	return cp;
 }
-- 
2.34.1

