Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F243360323F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 20:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJRSWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 14:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJRSWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:22:33 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979E18262F;
        Tue, 18 Oct 2022 11:22:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a13so21816222edj.0;
        Tue, 18 Oct 2022 11:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNJPAP+B+nZkQ0xLazBwFAmPNa/89U43FNa6fG8R6oo=;
        b=cB4Cqi5178EoSpHAXn2/jwjciYonrcV/ENsgaULX1vvs64Yzgi58SLA9wlvOSA1bz4
         dL8eoOGjiUeoG7fsIQaltSMPPncsSRsp+DqWkpOOqaqbz2uo18jV2tqwJOZmvN2mZLHV
         nrARunTn4LO+Om9KucVhPVMekZFSxLZUQZfPPnFJ5ByzIXHBkQa/CItQnY3A0DdggHsS
         BdWHq0naSu+LmmBBCKwY4EdBXayydlTnv4T29xNIm4GMmxlWzFVe6MzdYH0fKBs4cW46
         r9IOtgB173qEzDAkDr0Yt5Rq+j4n1tQGaXgP3EVZQOihKJzI8AbK19oVcaRqZgsF518e
         LNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNJPAP+B+nZkQ0xLazBwFAmPNa/89U43FNa6fG8R6oo=;
        b=lqRGyCKdEjYaHP/wEUc2moExIwkC2BZWTlsWB1/rNL1vOrUaRqyBrquFpVeNlIrW87
         GCfrpPxCoKPUH5iPF/u8tIyS88P2b7c5hR4Yp0EST7weMke9qMufiODJeHwD7dWP09m2
         Mx9PFYM4xvZXXgCrTwLuuD+9HWP6Z7D98z4cBbkkH7Kd1VI8omZetO5xMCKvMbka5Dup
         V3tPwRTiT1j8WFrMrDLjPz8P75qzZPaq2YvL3KuljCIIphssr0EaxZE7YUM+lPR9F3/x
         ui8RrlqOQo/fF6p/aUjFcEGKpqHmm8E+Zb4LBqR09NJ8ADL9IfeCRF+rlxYL30lufQud
         a1Ng==
X-Gm-Message-State: ACrzQf2XWbw/AcdwhZSj4Qs8x3PxcTLmg7DBJxGwormo/c3VniZlu8uD
        SAyfq6h8traPJU5cR5sTAanRlwmFAwU=
X-Google-Smtp-Source: AMsMyM6uairr6FwBJKqyUcP2JdQ4FNIId9VIcjSxdtdXcatIp72A5HwaEGPE0qIcxpy+KgtBkJRVOw==
X-Received: by 2002:a05:6402:42cf:b0:457:ae6f:e443 with SMTP id i15-20020a05640242cf00b00457ae6fe443mr3841568edc.299.1666117350194;
        Tue, 18 Oct 2022 11:22:30 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id i18-20020a0564020f1200b00458a03203b1sm9358395eda.31.2022.10.18.11.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:22:29 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        John Johansen <john.johansen@canonical.com>
Subject: [PATCH v10 01/11] security: Create file_truncate hook from path_truncate hook
Date:   Tue, 18 Oct 2022 20:22:06 +0200
Message-Id: <20221018182216.301684-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018182216.301684-1-gnoack3000@gmail.com>
References: <20221018182216.301684-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Like path_truncate, the file_truncate hook also restricts file
truncation, but is called in the cases where truncation is attempted
on an already-opened file.

This is required in a subsequent commit to handle ftruncate()
operations differently to truncate() operations.

Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: John Johansen <john.johansen@canonical.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 fs/namei.c                    |  2 +-
 fs/open.c                     |  2 +-
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/lsm_hooks.h     | 10 +++++++++-
 include/linux/security.h      |  6 ++++++
 security/apparmor/lsm.c       |  6 ++++++
 security/security.c           |  5 +++++
 security/tomoyo/tomoyo.c      | 13 +++++++++++++
 8 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 578c2110df02..85e9b9cc5c38 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3211,7 +3211,7 @@ static int handle_truncate(struct user_namespace *mnt_userns, struct file *filp)
 	if (error)
 		return error;
 
-	error = security_path_truncate(path);
+	error = security_file_truncate(filp);
 	if (!error) {
 		error = do_truncate(mnt_userns, path->dentry, 0,
 				    ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
diff --git a/fs/open.c b/fs/open.c
index a81319b6177f..c92f76ab341a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -188,7 +188,7 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 	if (IS_APPEND(file_inode(f.file)))
 		goto out_putf;
 	sb_start_write(inode->i_sb);
-	error = security_path_truncate(&f.file->f_path);
+	error = security_file_truncate(f.file);
 	if (!error)
 		error = do_truncate(file_mnt_user_ns(f.file), dentry, length,
 				    ATTR_MTIME | ATTR_CTIME, f.file);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ec119da1d89b..f67025823d92 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -177,6 +177,7 @@ LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
 	 struct fown_struct *fown, int sig)
 LSM_HOOK(int, 0, file_receive, struct file *file)
 LSM_HOOK(int, 0, file_open, struct file *file)
+LSM_HOOK(int, 0, file_truncate, struct file *file)
 LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
 	 unsigned long clone_flags)
 LSM_HOOK(void, LSM_RET_VOID, task_free, struct task_struct *task)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4ec80b96c22e..fad93a6d5293 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -409,7 +409,9 @@
  *	@attr is the iattr structure containing the new file attributes.
  *	Return 0 if permission is granted.
  * @path_truncate:
- *	Check permission before truncating a file.
+ *	Check permission before truncating the file indicated by path.
+ *	Note that truncation permissions may also be checked based on
+ *	already opened files, using the @file_truncate hook.
  *	@path contains the path structure for the file.
  *	Return 0 if permission is granted.
  * @inode_getattr:
@@ -598,6 +600,12 @@
  *	to receive an open file descriptor via socket IPC.
  *	@file contains the file structure being received.
  *	Return 0 if permission is granted.
+ * @file_truncate:
+ *	Check permission before truncating a file, i.e. using ftruncate.
+ *	Note that truncation permission may also be checked based on the path,
+ *	using the @path_truncate hook.
+ *	@file contains the file structure for the file.
+ *	Return 0 if permission is granted.
  * @file_open:
  *	Save open-time permission checking state for later use upon
  *	file_permission, and recheck access if anything has changed
diff --git a/include/linux/security.h b/include/linux/security.h
index ca1b7109c0db..1b5de26bdb12 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -396,6 +396,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
 				 struct fown_struct *fown, int sig);
 int security_file_receive(struct file *file);
 int security_file_open(struct file *file);
+int security_file_truncate(struct file *file);
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
 void security_task_free(struct task_struct *task);
 int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
@@ -1014,6 +1015,11 @@ static inline int security_file_open(struct file *file)
 	return 0;
 }
 
+static inline int security_file_truncate(struct file *file)
+{
+	return 0;
+}
+
 static inline int security_task_alloc(struct task_struct *task,
 				      unsigned long clone_flags)
 {
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index f56070270c69..be31549cfb40 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -329,6 +329,11 @@ static int apparmor_path_truncate(const struct path *path)
 	return common_perm_cond(OP_TRUNC, path, MAY_WRITE | AA_MAY_SETATTR);
 }
 
+static int apparmor_file_truncate(struct file *file)
+{
+	return apparmor_path_truncate(&file->f_path);
+}
+
 static int apparmor_path_symlink(const struct path *dir, struct dentry *dentry,
 				 const char *old_name)
 {
@@ -1232,6 +1237,7 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(mmap_file, apparmor_mmap_file),
 	LSM_HOOK_INIT(file_mprotect, apparmor_file_mprotect),
 	LSM_HOOK_INIT(file_lock, apparmor_file_lock),
+	LSM_HOOK_INIT(file_truncate, apparmor_file_truncate),
 
 	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
 	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
diff --git a/security/security.c b/security/security.c
index 79d82cb6e469..b55596958d0c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1652,6 +1652,11 @@ int security_file_open(struct file *file)
 	return fsnotify_perm(file, MAY_OPEN);
 }
 
+int security_file_truncate(struct file *file)
+{
+	return call_int_hook(file_truncate, 0, file);
+}
+
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
 	int rc = lsm_task_alloc(task);
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 71e82d855ebf..af04a7b7eb28 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -134,6 +134,18 @@ static int tomoyo_path_truncate(const struct path *path)
 	return tomoyo_path_perm(TOMOYO_TYPE_TRUNCATE, path, NULL);
 }
 
+/**
+ * tomoyo_file_truncate - Target for security_file_truncate().
+ *
+ * @file: Pointer to "struct file".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int tomoyo_file_truncate(struct file *file)
+{
+	return tomoyo_path_truncate(&file->f_path);
+}
+
 /**
  * tomoyo_path_unlink - Target for security_path_unlink().
  *
@@ -545,6 +557,7 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bprm_check_security, tomoyo_bprm_check_security),
 	LSM_HOOK_INIT(file_fcntl, tomoyo_file_fcntl),
 	LSM_HOOK_INIT(file_open, tomoyo_file_open),
+	LSM_HOOK_INIT(file_truncate, tomoyo_file_truncate),
 	LSM_HOOK_INIT(path_truncate, tomoyo_path_truncate),
 	LSM_HOOK_INIT(path_unlink, tomoyo_path_unlink),
 	LSM_HOOK_INIT(path_mkdir, tomoyo_path_mkdir),
-- 
2.38.0

