Return-Path: <linux-fsdevel+bounces-36091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECE19DB991
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 15:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC59D163C91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 14:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A64C1ADFF5;
	Thu, 28 Nov 2024 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8TDVzD/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304F6192D77
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803941; cv=none; b=qCgkwJl4/ftL18s4sIRhaGlU8SnWFKff7W2x7zvw05UVMRDKNST8JsH3baAJK+h7dpnwz9j/s5UCeDyBow5Gh1/820N8ZPTbNT/ktz6FptJuJYx4bnju4XmuPhGD7//fG273yl5IySiO7CFLdNdNo5JSCDtejLJUQb6JcEGl3VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803941; c=relaxed/simple;
	bh=for9TWrz6L6IrPs1Jg2UZudm90Mq79lqGbOP19fWYJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SuiwUaFpCsNmDLCuWizjw7yR1V0o9UUyGc8ewJ55hfZYgKYTERJHYlvUNm/JGpI9fJKtR5d8+//yeTO9q8ch7rlJhpiq9QLe2YHTHMkU6v51GjQQrINJmoc//Jzd5fMrgtQwvLElELMlLRiDNksh8tikuvhmcwTlzApp5XKUkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8TDVzD/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-382296631f1so749632f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 06:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732803937; x=1733408737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y9H2KdGl+boA01lLJRT8aEd6c+eG50yoltTq0B7NJUk=;
        b=I8TDVzD/rAXsaUA7/T065GNTK9l9esZgl4y1agGH96ai9gIdasRWerTmNisytH24vN
         hQa718aGJDmct0U01C/k0lfltZF8iHy9tgTZ0cwpP3b3tzU/N0KRqCh9H865x6jtQgJj
         WMiLWTaC8G/dFg+VkCtDLZlGqGC3AS5u28l6hf5YB7p4NISR+VKFaF09MNDvK15fkjip
         SlvHryeCbdC9MC4LYMUgCovchvZYoWThecTrbKO95dWTTJAhmMCAQ9wPK3ihO+LMwTIh
         lpZ7cDLAYw2rN0TlUvgIWlV5cdNpV5Pb3/74xIOZJLjCWIMwHsFDGC4WCiRAKPuj9R7j
         g9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732803937; x=1733408737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9H2KdGl+boA01lLJRT8aEd6c+eG50yoltTq0B7NJUk=;
        b=ELTB0eojDWcFVeTOZnVsX71+sfvQDg/VxMkrb/BJ68Ymlcba2HxtYDCi594QQaLaIb
         PO5H8jeDWa9+zrgH9neN4o7+7NpVRpTrUX0krIcVpTZzwNuFADUA4BCO4j4IXK+puKgb
         PJY7PuLDVYNDfPmyS2aK1tYm5r72+OxJg9l5NiWmyN0rxL5a7xfi9/s4FwORlKpRgw24
         OjkWMdF9ddy9Oyy5vKp5dP2AFz+6RR6bfEIWmMwcorM5PcXKC2PqJzmDemrq0guFJ4YH
         e4IZwK+QB+49ewvyCQRWouiDKfTM+nI3+NEOdCREHGQqbYE0P7aDRzZdpbjSMsd7i2Q5
         rrAw==
X-Forwarded-Encrypted: i=1; AJvYcCWBAqlQeuPIfNkZukWqRJxGJGX696ww8+RRCp7z8PK7hR29jPf0MQOOr0MN4jjM3PcsO7/8W+y7+3ZC6x7y@vger.kernel.org
X-Gm-Message-State: AOJu0YwWapWu1jOOdVZyEs9R/3732UsPy923i7iVXrfo2fVEeggJt1Nf
	0o/IA0c4gZA8oJfZWl7ynx99h9CjJNTUAF2YYei7jAEaLqkAwMeFRUV8x34I
X-Gm-Gg: ASbGncseA+OgdEyXQ6mEsn09IoBlWTX7wQolqQG5cHoizIaCPk7Eqf4RNUf5wuBJowd
	Sa5xpTA3cozHRB7Nm/86micUh7LMNRRHs0hWgnKO9Xmfp49b7kTeE7s1aWgpWMzcHxIIHWhn+Kc
	wYli6huUFPReonvYfC9FcTMshjnfOcJ91E+C2F5crKnI1Klcf+3y6ls7IIgdbLhVTo/f4q2azj0
	M2Oh6gcWiCvQeG7TkyOFBZs3CGTh6xwIbZ8Y9usQVv4bLER9nnD5ifqAYbXkYORhRuBe9131Md3
	fZ2JvyVfkqETnGM+pW67v6xd0tc0WmN1iuVGzyLXMxuesUA=
X-Google-Smtp-Source: AGHT+IH6LENWEcui/76Wxjlo2n1qqyeSbdCIiW8oE9Ls6qNqcxHfMSMxvFmR8lBiWgcHFGqKIbcjHw==
X-Received: by 2002:a05:6000:20c6:b0:37d:53dd:4dec with SMTP id ffacd0b85a97d-385c6ebcca0mr4782597f8f.15.1732803937053;
        Thu, 28 Nov 2024 06:25:37 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd92eabsm1739342f8f.111.2024.11.28.06.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 06:25:36 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: don't block write during exec on pre-content watched files
Date: Thu, 28 Nov 2024 15:25:32 +0100
Message-Id: <20241128142532.465176-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2a010c412853 ("fs: don't block i_writecount during exec") removed
the legacy behavior of getting ETXTBSY on attempt to open and executable
file for write while it is being executed.

This commit was reverted because an application that depends on this
legacy behavior was broken by the change.

We need to allow HSM writing into executable files while executed to
fill their content on-the-fly.

To that end, disable the ETXTBSY legacy behavior for files that are
watched by pre-content events.

This change is not expected to cause regressions with existing systems
which do not have any pre-content event listeners.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

This patch is on top of your fsnotify_hsm rebased branch.
It passed LTP sanity tests, but did not test filling an executable
on-the-fly.

Josef, can you verify that this works as expected.

Also pushed to fsnotify_hsm branch in my github.

Thanks,
Amir.

 fs/binfmt_elf.c       |  4 ++--
 fs/binfmt_elf_fdpic.c |  4 ++--
 fs/exec.c             |  8 ++++----
 include/linux/fs.h    | 17 +++++++++++++++++
 kernel/fork.c         | 12 ++++++------
 5 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 106f0e8af177..8054f44d39cf 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1257,7 +1257,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		}
 		reloc_func_desc = interp_load_addr;
 
-		allow_write_access(interpreter);
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
 
 		kfree(interp_elf_ex);
@@ -1354,7 +1354,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	kfree(interp_elf_ex);
 	kfree(interp_elf_phdata);
 out_free_file:
-	allow_write_access(interpreter);
+	exe_file_allow_write_access(interpreter);
 	if (interpreter)
 		fput(interpreter);
 out_free_ph:
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index f1a7c4875c4a..c13ee8180b17 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -394,7 +394,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 			goto error;
 		}
 
-		allow_write_access(interpreter);
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
 		interpreter = NULL;
 	}
@@ -467,7 +467,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 
 error:
 	if (interpreter) {
-		allow_write_access(interpreter);
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
 	}
 	kfree(interpreter_name);
diff --git a/fs/exec.c b/fs/exec.c
index 98cb7ba9983c..c41cfd35c74c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -912,7 +912,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	    path_noexec(&file->f_path))
 		return ERR_PTR(-EACCES);
 
-	err = deny_write_access(file);
+	err = exe_file_deny_write_access(file);
 	if (err)
 		return ERR_PTR(err);
 
@@ -927,7 +927,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
  * Returns ERR_PTR on failure or allocated struct file on success.
  *
  * As this is a wrapper for the internal do_open_execat(), callers
- * must call allow_write_access() before fput() on release. Also see
+ * must call exe_file_allow_write_access() before fput() on release. Also see
  * do_close_execat().
  */
 struct file *open_exec(const char *name)
@@ -1471,7 +1471,7 @@ static void do_close_execat(struct file *file)
 {
 	if (!file)
 		return;
-	allow_write_access(file);
+	exe_file_allow_write_access(file);
 	fput(file);
 }
 
@@ -1797,7 +1797,7 @@ static int exec_binprm(struct linux_binprm *bprm)
 		bprm->file = bprm->interpreter;
 		bprm->interpreter = NULL;
 
-		allow_write_access(exec);
+		exe_file_allow_write_access(exec);
 		if (unlikely(bprm->have_execfd)) {
 			if (bprm->executable) {
 				fput(exec);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd6d0eddea9b..2aeab643f1ab 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3089,6 +3089,23 @@ static inline void allow_write_access(struct file *file)
 	if (file)
 		atomic_inc(&file_inode(file)->i_writecount);
 }
+
+/*
+ * Do not prevent write to executable file when watched by pre-content events.
+ */
+static inline int exe_file_deny_write_access(struct file *exe_file)
+{
+	if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
+		return 0;
+	return deny_write_access(exe_file);
+}
+static inline void exe_file_allow_write_access(struct file *exe_file)
+{
+	if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
+		return;
+	allow_write_access(exe_file);
+}
+
 static inline bool inode_is_open_for_write(const struct inode *inode)
 {
 	return atomic_read(&inode->i_writecount) > 0;
diff --git a/kernel/fork.c b/kernel/fork.c
index 1450b461d196..015c397f47ca 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -625,8 +625,8 @@ static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
 	 * We depend on the oldmm having properly denied write access to the
 	 * exe_file already.
 	 */
-	if (exe_file && deny_write_access(exe_file))
-		pr_warn_once("deny_write_access() failed in %s\n", __func__);
+	if (exe_file && exe_file_deny_write_access(exe_file))
+		pr_warn_once("exe_file_deny_write_access() failed in %s\n", __func__);
 }
 
 #ifdef CONFIG_MMU
@@ -1424,13 +1424,13 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 		 * We expect the caller (i.e., sys_execve) to already denied
 		 * write access, so this is unlikely to fail.
 		 */
-		if (unlikely(deny_write_access(new_exe_file)))
+		if (unlikely(exe_file_deny_write_access(new_exe_file)))
 			return -EACCES;
 		get_file(new_exe_file);
 	}
 	rcu_assign_pointer(mm->exe_file, new_exe_file);
 	if (old_exe_file) {
-		allow_write_access(old_exe_file);
+		exe_file_allow_write_access(old_exe_file);
 		fput(old_exe_file);
 	}
 	return 0;
@@ -1471,7 +1471,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 			return ret;
 	}
 
-	ret = deny_write_access(new_exe_file);
+	ret = exe_file_deny_write_access(new_exe_file);
 	if (ret)
 		return -EACCES;
 	get_file(new_exe_file);
@@ -1483,7 +1483,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 	mmap_write_unlock(mm);
 
 	if (old_exe_file) {
-		allow_write_access(old_exe_file);
+		exe_file_allow_write_access(old_exe_file);
 		fput(old_exe_file);
 	}
 	return 0;
-- 
2.34.1


