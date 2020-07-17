Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946DE224245
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 19:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgGQRnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 13:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbgGQRn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:43:28 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14324C0619D8
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 72so5765211ple.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VgVzk3Bx0tFecnG4gjh1+Ha9QnaGtBiSO/07cJ5aIic=;
        b=P9wZGTz9kK87pk10JSjyeaYOwu3p8Hfu/PPN8Cqsr3PJ0FnwzXmuAanSGOXH+XufNn
         UGMyz9EewPl0KUHt/2mfyI/MF3CIuVhr9BnY/vP2FQpp/9oAxuK97coDok7X/qTdiL/p
         CWsWFl09X1BivvYM84vIOZ5Nt2D6inee/AzfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VgVzk3Bx0tFecnG4gjh1+Ha9QnaGtBiSO/07cJ5aIic=;
        b=YG6Y+m9ShwPI12UjjcBuad+Qo6LD/lEe8UmDQMTVayN1A9rV/LpovAdACvosaACrqD
         xVUYGU7CaLbhbGdr2ZmdhNJ0RHEX4M4ATIdKAumFqYGkG6BS/jVFiSJdZQqyrC210ydD
         JvYG3Af/fFj3EC905Ol7DE179SD1aPUWgHg0E4uo1jQpxxQCgEOEoHZvpR2tjPbEPk7+
         og+eGPz6MUgiEOx0iTetVb/bVYEr7gJJfOvZzGq9NbwQ5G3x+FaYEIZYsKS1PQsMzK6H
         tXsvD5qqfvKS0PWNtRKQf3UoYId6git5Nv6ixUMJcAyRPTOT1R2rqXhfqlIhqE/iz90o
         XAOA==
X-Gm-Message-State: AOAM530CN/G2xM2+1mZGfV7aT4pi4slqhFX8TYTkWVLrvyE5IvVaeL/g
        QoGuR09lvm0m+P4Hp1emyJV0VQ==
X-Google-Smtp-Source: ABdhPJywKisRHDmZ0UzVuEO9PA2Jw3E3QQXLwP64C0+JkJhdfIUbQCsQUKOJFyV9KZXHGsPTAEGMjQ==
X-Received: by 2002:a17:902:7688:: with SMTP id m8mr8685633pll.12.1595007806514;
        Fri, 17 Jul 2020 10:43:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7sm3365739pjy.54.2020.07.17.10.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 10:43:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] LSM: Add "contents" flag to kernel_read_file hook
Date:   Fri, 17 Jul 2020 10:43:07 -0700
Message-Id: <20200717174309.1164575-13-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717174309.1164575-1-keescook@chromium.org>
References: <20200717174309.1164575-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As with the kernel_load_data LSM hook, add a "contents" flag to the
kernel_read_file LSM hook that indicates whether the LSM can expect
a matching call to the kernel_post_read_file LSM hook with the full
contents of the file. With the coming addition of partial file read
support for kernel_read_file*() API, the LSM will no longer be able
to always see the entire contents of a file during the read calls.

For cases where the LSM must read examine the complete file contents,
it will need to do so on its own every time the kernel_read_file
hook is called with contents=false (or reject such cases). Adjust all
existing LSMs to retain existing behavior.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/kernel_read_file.c             |  2 +-
 include/linux/ima.h               |  6 ++++--
 include/linux/lsm_hook_defs.h     |  2 +-
 include/linux/lsm_hooks.h         |  3 +++
 include/linux/security.h          |  6 ++++--
 security/integrity/ima/ima_main.c | 10 +++++++++-
 security/loadpin/loadpin.c        | 14 ++++++++++++--
 security/security.c               |  7 ++++---
 security/selinux/hooks.c          |  5 +++--
 9 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 2e29c38eb4df..d73bc3fa710a 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -39,7 +39,7 @@ int kernel_read_file(struct file *file, void **buf,
 	if (ret)
 		return ret;
 
-	ret = security_kernel_read_file(file, id);
+	ret = security_kernel_read_file(file, id, true);
 	if (ret)
 		goto out;
 
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 502e36ad7804..259023039dc9 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -23,7 +23,8 @@ extern int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot);
 extern int ima_load_data(enum kernel_load_data_id id, bool contents);
 extern int ima_post_load_data(char *buf, loff_t size,
 			      enum kernel_load_data_id id);
-extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
+extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
+			 bool contents);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
@@ -91,7 +92,8 @@ static inline int ima_post_load_data(char *buf, loff_t size,
 	return 0;
 }
 
-static inline int ima_read_file(struct file *file, enum kernel_read_file_id id)
+static inline int ima_read_file(struct file *file, enum kernel_read_file_id id,
+				bool contents)
 {
 	return 0;
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index aaa2916bbae7..c2ded57c5d9b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -188,7 +188,7 @@ LSM_HOOK(int, 0, kernel_load_data, enum kernel_load_data_id id, bool contents)
 LSM_HOOK(int, 0, kernel_post_load_data, char *buf, loff_t size,
 	 enum kernel_read_file_id id)
 LSM_HOOK(int, 0, kernel_read_file, struct file *file,
-	 enum kernel_read_file_id id)
+	 enum kernel_read_file_id id, bool contents)
 LSM_HOOK(int, 0, kernel_post_read_file, struct file *file, char *buf,
 	 loff_t size, enum kernel_read_file_id id)
 LSM_HOOK(int, 0, task_fix_setuid, struct cred *new, const struct cred *old,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 812d626195fc..b66433b5aa15 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -650,6 +650,7 @@
  *	@file contains the file structure pointing to the file being read
  *	by the kernel.
  *	@id kernel read file identifier
+ *	@contents if a subsequent @kernel_post_read_file will be called.
  *	Return 0 if permission is granted.
  * @kernel_post_read_file:
  *	Read a file specified by userspace.
@@ -658,6 +659,8 @@
  *	@buf pointer to buffer containing the file contents.
  *	@size length of the file contents.
  *	@id kernel read file identifier
+ *	This must be paired with a prior @kernel_read_file call that had
+ *	@contents set to true.
  *	Return 0 if permission is granted.
  * @task_fix_setuid:
  *	Update the module's state after setting one or more of the user
diff --git a/include/linux/security.h b/include/linux/security.h
index e748974c707b..a5d66b89cd6c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -390,7 +390,8 @@ int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
 int security_kernel_post_load_data(char *buf, loff_t size,
 				   enum kernel_load_data_id id);
-int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
+int security_kernel_read_file(struct file *file, enum kernel_read_file_id id,
+			      bool contents);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
@@ -1028,7 +1029,8 @@ static inline int security_kernel_post_load_data(char *buf, loff_t size,
 }
 
 static inline int security_kernel_read_file(struct file *file,
-					    enum kernel_read_file_id id)
+					    enum kernel_read_file_id id,
+					    bool contents)
 {
 	return 0;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1a7bc4c7437d..dc4f90660aa6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -602,6 +602,7 @@ void ima_post_path_mknod(struct dentry *dentry)
  * ima_read_file - pre-measure/appraise hook decision based on policy
  * @file: pointer to the file to be measured/appraised/audit
  * @read_id: caller identifier
+ * @contents: whether a subsequent call will be made to ima_post_read_file()
  *
  * Permit reading a file based on policy. The policy rules are written
  * in terms of the policy identifier.  Appraising the integrity of
@@ -609,8 +610,15 @@ void ima_post_path_mknod(struct dentry *dentry)
  *
  * For permission return 0, otherwise return -EACCES.
  */
-int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
+int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
+		  bool contents)
 {
+	/* Reject all partial reads during appraisal. */
+	if (!contents) {
+		if (ima_appraise & IMA_APPRAISE_ENFORCE)
+			return -EACCES;
+	}
+
 	/*
 	 * Do devices using pre-allocated memory run the risk of the
 	 * firmware being accessible to the device prior to the completion
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index db320a43f42e..a1778ebef137 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -117,11 +117,21 @@ static void loadpin_sb_free_security(struct super_block *mnt_sb)
 	}
 }
 
-static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
+static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
+			     bool contents)
 {
 	struct super_block *load_root;
 	const char *origin = kernel_read_file_id_str(id);
 
+	/*
+	 * If we will not know that we'll be seeing the full contents
+	 * then we cannot trust a load will be complete and unchanged
+	 * off disk. Treat all contents=false hooks as if there were
+	 * no associated file struct.
+	 */
+	if (!contents)
+		file = NULL;
+
 	/* If the file id is excluded, ignore the pinning. */
 	if ((unsigned int)id < ARRAY_SIZE(ignore_read_file_id) &&
 	    ignore_read_file_id[id]) {
@@ -178,7 +188,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 
 static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 {
-	return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
+	return loadpin_read_file(NULL, (enum kernel_read_file_id) id, contents);
 }
 
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
diff --git a/security/security.c b/security/security.c
index 090674f1197a..800af5403176 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1657,14 +1657,15 @@ int security_kernel_module_request(char *kmod_name)
 	return integrity_kernel_module_request(kmod_name);
 }
 
-int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
+int security_kernel_read_file(struct file *file, enum kernel_read_file_id id,
+			      bool contents)
 {
 	int ret;
 
-	ret = call_int_hook(kernel_read_file, 0, file, id);
+	ret = call_int_hook(kernel_read_file, 0, file, id, contents);
 	if (ret)
 		return ret;
-	return ima_read_file(file, id);
+	return ima_read_file(file, id, contents);
 }
 EXPORT_SYMBOL_GPL(security_kernel_read_file);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1a5c68196faf..6d183bbc12a6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4004,13 +4004,14 @@ static int selinux_kernel_module_from_file(struct file *file)
 }
 
 static int selinux_kernel_read_file(struct file *file,
-				    enum kernel_read_file_id id)
+				    enum kernel_read_file_id id,
+				    bool contents)
 {
 	int rc = 0;
 
 	switch (id) {
 	case READING_MODULE:
-		rc = selinux_kernel_module_from_file(file);
+		rc = selinux_kernel_module_from_file(contents ? file : NULL);
 		break;
 	default:
 		break;
-- 
2.25.1

