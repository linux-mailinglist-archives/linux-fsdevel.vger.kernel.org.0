Return-Path: <linux-fsdevel+bounces-10471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E3F84B74C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D8C1C211A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480AE131E54;
	Tue,  6 Feb 2024 14:00:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D94131E34;
	Tue,  6 Feb 2024 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707228028; cv=none; b=GnR1Qg0LkOS4Bl6eK6xe9XXWLmKXAwkLRq2q/07HHaSnf9NF98oeMZMHKGorWWBXvF7bdcb/iQ4+/s0/Yhe8jVkCyV8odfKBQmlIRaqEzv8XkJbqLsMboxJbvZRAn4rPZMA7KkcUm1ZhKDn2JXoOu/b8xau5qdF/QaqcCVJJacw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707228028; c=relaxed/simple;
	bh=pI+XqziRRNlFDN2kQrkoXJViSst38JT5dHIw2NxfTK0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jKX/qf3vALWojS4iapQx4qJwPfY0eZw6l0eS0aGMcYDJvTjqIzP1By2h2NnU+Cm8xPDkRQSXqllshEVZKZ5DBt6wIgzbZJAV8l4H7VJQvG7qpd/qOsEHWazeVggQHaQu/zwi6MP4MczhEVmuuJCekwe+wBMmQ2nHyEAVKZ5d6Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 416E0NKR019243;
	Tue, 6 Feb 2024 23:00:23 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Tue, 06 Feb 2024 23:00:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 416DwfKO018763
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 6 Feb 2024 22:59:07 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <894cc57c-d298-4b60-a67d-42c1a92d0b92@I-love.SAKURA.ne.jp>
Date: Tue, 6 Feb 2024 22:59:08 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 1/3] LSM: add security_execve_abort() hook
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <72da7003-a115-4162-b235-53cd3da8a90e@I-love.SAKURA.ne.jp>
In-Reply-To: <72da7003-a115-4162-b235-53cd3da8a90e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A regression caused by commit 978ffcbf00d8 ("execve: open the executable
file before doing anything else") has been fixed by commit 4759ff71f23e
("exec: Check __FMODE_EXEC instead of in_execve for LSMs") and commit
3eab830189d9 ("uselib: remove use of __FMODE_EXEC"). While fixing this
regression, Linus commented that we want to remove current->in_execve flag.

The current->in_execve flag was introduced by commit f9ce1f1cda8b ("Add
in_execve flag into task_struct.") when TOMOYO LSM was merged, and the
reason was explained in commit f7433243770c ("LSM adapter functions.").

In short, TOMOYO's design is not compatible with COW credential model
introduced in Linux 2.6.29, and the current->in_execve flag was added for
emulating security_bprm_free() hook which has been removed by introduction
of COW credential model.

security_task_alloc()/security_task_free() hooks have been removed by
commit f1752eec6145 ("CRED: Detach the credentials from task_struct"),
and these hooks have been revived by commit 1a2a4d06e1e9 ("security:
create task_free security callback") and commit e4e55b47ed9a ("LSM: Revive
security_task_alloc() hook and per "struct task_struct" security blob.").

But security_bprm_free() hook did not revive until now. Now that Linus
wants TOMOYO to stop carrying state across two independent execve() calls,
and TOMOYO can stop carrying state if a hook for restoring previous state
upon failed execve() call were provided, this patch revives the hook.

Since security_bprm_committing_creds() and security_bprm_committed_creds()
hooks are called when an execve() request succeeded, we don't need to call
security_bprm_free() hook when an execve() request succeeded. Therefore,
this patch adds security_execve_abort() hook which is called only when an
execve() request failed after successful prepare_bprm_creds() call.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: Serge E. Hallyn <serge@hallyn.com>
---
 fs/exec.c                     |  1 +
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  5 +++++
 security/security.c           | 11 +++++++++++
 4 files changed, 18 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index af4fbb61cd53..d6d35a06fd08 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1521,6 +1521,7 @@ static void free_bprm(struct linux_binprm *bprm)
 	if (bprm->cred) {
 		mutex_unlock(&current->signal->cred_guard_mutex);
 		abort_creds(bprm->cred);
+		security_execve_abort();
 	}
 	do_close_execat(bprm->file);
 	if (bprm->executable)
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 76458b6d53da..fd100ab71a33 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -54,6 +54,7 @@ LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct f
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, const struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, const struct linux_binprm *bprm)
+LSM_HOOK(void, LSM_RET_VOID, execve_abort, void)
 LSM_HOOK(int, 0, fs_context_submount, struct fs_context *fc, struct super_block *reference)
 LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
 	 struct fs_context *src_sc)
diff --git a/include/linux/security.h b/include/linux/security.h
index d0eb20f90b26..31532b30c4f0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -299,6 +299,7 @@ int security_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(const struct linux_binprm *bprm);
 void security_bprm_committed_creds(const struct linux_binprm *bprm);
+void security_execve_abort(void);
 int security_fs_context_submount(struct fs_context *fc, struct super_block *reference);
 int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc);
 int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param);
@@ -648,6 +649,10 @@ static inline void security_bprm_committed_creds(const struct linux_binprm *bprm
 {
 }
 
+static inline void security_execve_abort(void)
+{
+}
+
 static inline int security_fs_context_submount(struct fs_context *fc,
 					   struct super_block *reference)
 {
diff --git a/security/security.c b/security/security.c
index 3aaad75c9ce8..10adc4d3c5e0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1223,6 +1223,17 @@ void security_bprm_committed_creds(const struct linux_binprm *bprm)
 	call_void_hook(bprm_committed_creds, bprm);
 }
 
+/**
+ * security_execve_abort() - Notify that exec() has failed
+ *
+ * This hook is for undoing changes which cannot be discarded by
+ * abort_creds().
+ */
+void security_execve_abort(void)
+{
+	call_void_hook(execve_abort);
+}
+
 /**
  * security_fs_context_submount() - Initialise fc->security
  * @fc: new filesystem context
-- 
2.18.4



