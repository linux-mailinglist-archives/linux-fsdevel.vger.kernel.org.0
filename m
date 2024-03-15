Return-Path: <linux-fsdevel+bounces-14519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE0A87D35E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 19:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5861C2211D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1D450A69;
	Fri, 15 Mar 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Z/ZWKzH7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146020310;
	Fri, 15 Mar 2024 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526247; cv=none; b=pKzCBjFlL6V/oFYrAsgUqxRvwU8cvHB8Z9juWU9952lBXmcTcsLS1WDPPkJK+ayNDSpiuOKl812WXw58rqEJ7ROZqVafYinwIZy7EG3PneV78QgSh3RdVjXq9wClQNevfFvWll85AEGGn+b+fdcf8tW/QKFtmAx3WlB2r0gFU5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526247; c=relaxed/simple;
	bh=C25MXQHA40uV4GLLPq6rWFr+sjYebOCkqkMP+9WqSmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nd+4xcKWg+My0LOEP6FfnyDcTUYMh1eAF+t7nPxQOd+2gS5v3kO5ZPLpWrZfPBs7Nh7KGkdZN6zHg/VdDmV8uPqkGHe3l+NwoaJHoHypRCp/GIDtVxcBPRWB5NvwE7WCq3gLmDcOIbFedvkI2JQqFjZtjTvWjNNVmEO5P0/sbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Z/ZWKzH7; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso260071866b.2;
        Fri, 15 Mar 2024 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710526242; x=1711131042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vvztQ9R6kS3LLaEzPtb4PkQkdZH06n2URzp7Npwuwk=;
        b=Z/ZWKzH7cPUad1ak3plQAJQ38lvCNL6ZX2lZy4gbAHMsSLuW48KMxlbV7PLAiY7bT2
         1JZvrx8iuq6bbBoV9uB34upIHv25k8ehBJfoAWKlGFQjEg6qkqxs6HaO98EuAcGHZjp5
         1FmzpR8KZe9mfNFMvPuotwtznIjBYWqfqF7LegDzo2pl5+Lc6Pou75LHYVjyKkM4Sv2O
         0DPjaNkPJ3ufF4Ruye0PPkwMMelhDveLmRBbXNpio3nEsLi9Zac+QP/hjxWqMLOdPf62
         d+aeVFpOUtZJc+yPdP8/rcqikrOWJsPA46fvtkvpycGAANI+3m5v7gp/dhWGSpITUsGf
         tWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710526242; x=1711131042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vvztQ9R6kS3LLaEzPtb4PkQkdZH06n2URzp7Npwuwk=;
        b=ZQRc6XFi3azpBCOnJ5gu3tqGqMZd4vjHXBBB1OvITHg8vvl3AdwMvQ0FoaZo9Vzgo7
         D6pVFkWjA63u/J6dXzLRhWxTWWBAlxpiZsMFI0M31MlVv3DR2owC3yD0hOVGapOCe0q3
         teyQ77ODUccqNG+i34mLML9DiaFcPUhEHh8qD6saYeZQtEYruE7/pNV1ZrN0E5TQZxPC
         UXPJa8d78Es+V3G/CwRf/a3kaA7CFRCckDqE1dU/Zj/bxrQ/IQf0y8hfDmLklFOpb/3e
         wzu0tYlx/BSlVgNn205Vv6o5FDemp0aRe+1OUr+dG+ZHZ18oPo0eCMSkO5V/e8foeDEv
         AFOA==
X-Forwarded-Encrypted: i=1; AJvYcCXm0D9gAiTCPlue9oyPrgGZJQixHIOEClROelifGv+PylfCAu3lLHhCTRqjvr7WBKoOsBP//zHboWBRmOFDmVjj+9clxLJGrDWlFqaGYvo4STAjR4cgjhgfIwaY7buL7V+cEPius4Fps2m+Fw==
X-Gm-Message-State: AOJu0YzJx6NSkgdYTIhJThpCJFRxdMp6dfxcq41955icLfcjNvi4FLy6
	Ro3m9XDtF3Pz6q/tZRIOiPshDl81IhJcRZ8y8KYAtNDh60+Or1mMGzn49WZAB6fDzg==
X-Google-Smtp-Source: AGHT+IGmE1hE7r5LCz1k5oYh5+BcCGT9TTZYLN0ExtvMuVZ15iQOYj4bzU0GgE1LYLz2d9qOed8Jmg==
X-Received: by 2002:a17:906:7fc8:b0:a46:2760:3c9b with SMTP id r8-20020a1709067fc800b00a4627603c9bmr3360991ejs.34.1710526242402;
        Fri, 15 Mar 2024 11:10:42 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id jx11-20020a170906ca4b00b00a46937bc44esm510480ejb.135.2024.03.15.11.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:10:41 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: linux-security-module@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Khadija Kamran <kamrankhadijadj@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alfred Piccioni <alpic@google.com>,
	John Johansen <john.johansen@canonical.com>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] lsm: introduce new hook security_vm_execstack
Date: Fri, 15 Mar 2024 19:08:48 +0100
Message-ID: <20240315181032.645161-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315181032.645161-1-cgzones@googlemail.com>
References: <20240315181032.645161-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new hook guarding instantiations of programs with executable
stack.  They are being warned about since commit 47a2ebb7f505 ("execve:
warn if process starts with executable stack").  Lets give LSMs the
ability to control their presence on a per application basis.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 fs/exec.c                     |  4 ++++
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 ++++++
 security/security.c           | 13 +++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 8cdd5b2dd09c..e6f9e980c6b1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -829,6 +829,10 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	BUG_ON(prev != vma);
 
 	if (unlikely(vm_flags & VM_EXEC)) {
+		ret = security_vm_execstack();
+		if (ret)
+			goto out_unlock;
+
 		pr_warn_once("process '%pD4' started with executable stack\n",
 			     bprm->file);
 	}
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 185924c56378..b31d0744e7e7 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -49,6 +49,7 @@ LSM_HOOK(int, 0, syslog, int type)
 LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
 	 const struct timezone *tz)
 LSM_HOOK(int, 1, vm_enough_memory, struct mm_struct *mm, long pages)
+LSM_HOOK(int, 0, vm_execstack, void)
 LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct file *file)
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
diff --git a/include/linux/security.h b/include/linux/security.h
index d0eb20f90b26..084b96814970 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -294,6 +294,7 @@ int security_quota_on(struct dentry *dentry);
 int security_syslog(int type);
 int security_settime64(const struct timespec64 *ts, const struct timezone *tz);
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages);
+int security_vm_execstack(void);
 int security_bprm_creds_for_exec(struct linux_binprm *bprm);
 int security_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file);
 int security_bprm_check(struct linux_binprm *bprm);
@@ -624,6 +625,11 @@ static inline int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	return __vm_enough_memory(mm, pages, cap_vm_enough_memory(mm, pages));
 }
 
+static inline int security_vm_execstack(void)
+{
+	return 0;
+}
+
 static inline int security_bprm_creds_for_exec(struct linux_binprm *bprm)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 0144a98d3712..f75240d0d99d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1125,6 +1125,19 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
+/**
+ * security_vm_execstack() - Check if starting a program with executable stack
+ * is allowed
+ *
+ * Check whether starting a program with an executable stack is allowed.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_vm_execstack(void)
+{
+	return call_int_hook(vm_execstack);
+}
+
 /**
  * security_bprm_creds_for_exec() - Prepare the credentials for exec()
  * @bprm: binary program information
-- 
2.43.0


