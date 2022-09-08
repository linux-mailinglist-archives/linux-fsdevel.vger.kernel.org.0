Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537315B2749
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 21:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIHT7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 15:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiIHT6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:58:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97206112129;
        Thu,  8 Sep 2022 12:58:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t7so22977210wrm.10;
        Thu, 08 Sep 2022 12:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=X5JtbaRKpQNt66W3vP0r+JXCBaH0/CYt+RJ9N8favnA=;
        b=XqGD5FARU1AX3e65qWyzZ0kAAbGFkJkv/CKaCEs9R5PSmyrgp/DQQo42yTcURlx8KS
         GraapwkoTOY6N+H/COiSRQ7t9BNMUSTwXYXIlrDhhMgtOuR+D1okLrkY90sss5JmbRIP
         Un4TZMuf9O4Wj3xXAYlUB71TK+CUA3pv1eXTXblP271t8VdjVN8XPm6dkVtDQQTXZ0TT
         UqXGGc2xSqK9a7nvSWVJJGoVGADkHqpRbHg/YEgHLD6hatcAYfkhkyD3H7XNTEJT4JE/
         IOiwFscbdkoJ2pqiONB/NjUFgvb4IJxzNb154A1hwlE14SGX5P6b5n6OuFcb6eu8yIAX
         2jZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=X5JtbaRKpQNt66W3vP0r+JXCBaH0/CYt+RJ9N8favnA=;
        b=yKFtYII4VY13D/UkrX5Ieai3UVSRAh9yHj9nO8Pnyk5pCAVAxsAy8D1kAz+2K5ADiI
         SXOt366YdsCvikX+0Txf7pQ1FfoFZSo9ZNWVtrXRIgnbHpecW+A5UGxY/8kM+yCkXspl
         XoEauozPfiLYapJiewVO/pPWJku2m3pCkqHll6+mLvBEBJvBiRDV9w5jK2LLU82SbtAM
         ebqFNzP+0vb993hAi9DztPciDSMomBDaXcChRkgbaIOhTihfD9f94KWomDyrZngHwJEm
         bYNYSFiHjYZrTQ77korcuJKHGA2cXs/Pu7/MNTf7aBixq8o0bRtjRFsRAs0d4W0RYixc
         kGwA==
X-Gm-Message-State: ACgBeo21eYaI9nVhy/LZzmUh3D31c9kATUrmuBC1BoQMZUFi/VRVDJfg
        T8Y/cBRREUvJYcm+wxa72u+tuX34qkw=
X-Google-Smtp-Source: AA6agR7V7rQS62oTQNFWTcpUV7z4pId9u1HM0xRVLalbjQpXRqien6PtGCntq8ioFUwbs2c9SYxVjw==
X-Received: by 2002:a5d:5984:0:b0:227:1a6c:a507 with SMTP id n4-20020a5d5984000000b002271a6ca507mr6484057wri.292.1662667091361;
        Thu, 08 Sep 2022 12:58:11 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id a22-20020a05600c2d5600b003a541d893desm3360682wmg.38.2022.09.08.12.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 12:58:11 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v6 1/5] security: create file_truncate hook from path_truncate hook
Date:   Thu,  8 Sep 2022 21:58:01 +0200
Message-Id: <20220908195805.128252-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220908195805.128252-1-gnoack3000@gmail.com>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 fs/namei.c                    |  6 +++---
 fs/open.c                     |  4 ++--
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 ++++++
 security/apparmor/lsm.c       |  6 ++++++
 security/security.c           |  5 +++++
 security/tomoyo/tomoyo.c      | 13 +++++++++++++
 7 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 53b4bc094db2..52105873d1f8 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -53,8 +53,8 @@
  * The new code replaces the old recursive symlink resolution with
  * an iterative one (in case of non-nested symlink chains).  It does
  * this with calls to <fs>_follow_link().
- * As a side effect, dir_namei(), _namei() and follow_link() are now 
- * replaced with a single function lookup_dentry() that can handle all 
+ * As a side effect, dir_namei(), _namei() and follow_link() are now
+ * replaced with a single function lookup_dentry() that can handle all
  * the special cases of the former code.
  *
  * With the new dcache, the pathname is stored at each inode, at least as
@@ -3211,7 +3211,7 @@ static int handle_truncate(struct user_namespace *mnt_userns, struct file *filp)
 	if (error)
 		return error;
 
-	error = security_path_truncate(path);
+	error = security_file_truncate(filp);
 	if (!error) {
 		error = do_truncate(mnt_userns, path->dentry, 0,
 				    ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
diff --git a/fs/open.c b/fs/open.c
index 8a813fa5ca56..0831433e493a 100644
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
@@ -1271,7 +1271,7 @@ struct file *filp_open(const char *filename, int flags, umode_t mode)
 {
 	struct filename *name = getname_kernel(filename);
 	struct file *file = ERR_CAST(name);
-	
+
 	if (!IS_ERR(name)) {
 		file = file_open_name(name, flags, mode);
 		putname(name);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 60fff133c0b1..dee35ab253ba 100644
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
diff --git a/include/linux/security.h b/include/linux/security.h
index 7bd0c490703d..f80b23382dd9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -394,6 +394,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
 				 struct fown_struct *fown, int sig);
 int security_file_receive(struct file *file);
 int security_file_open(struct file *file);
+int security_file_truncate(struct file *file);
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
 void security_task_free(struct task_struct *task);
 int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
@@ -1011,6 +1012,11 @@ static inline int security_file_open(struct file *file)
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
index e29cade7b662..98ecb7f221b8 100644
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
index 4b95de24bc8d..e491120c48ba 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1210,6 +1210,11 @@ int security_path_truncate(const struct path *path)
 	return call_int_hook(path_truncate, 0, path);
 }
 
+int security_file_truncate(struct file *file)
+{
+	return call_int_hook(file_truncate, 0, file);
+}
+
 int security_path_chmod(const struct path *path, umode_t mode)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
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
2.37.3

