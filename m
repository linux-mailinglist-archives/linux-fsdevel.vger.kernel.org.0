Return-Path: <linux-fsdevel+bounces-9240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CED983F5C2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 15:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8244E1C2270A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 14:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6573828DD6;
	Sun, 28 Jan 2024 14:17:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2865925773;
	Sun, 28 Jan 2024 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706451435; cv=none; b=j5PfVRl1gMBSsZ45XKY08o1ecpFK88CyuEYuafs/7yLjNKFKsOJLA0Q8xYIvqfumbJEr2byWmUOREn2BBJPBMVXckPl3PIkP+gsdK65m2HcQn40RbKCJW3+Z9tGAxwDhRavL4zw86NtMVrSlITaSCAoSWlWCOPdVsh5gzPseLXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706451435; c=relaxed/simple;
	bh=BqdmzxJqM5geoy5x3EiANW+NvN/y/ZuUVzh+k4a2aY0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cW88Xf5smdsVLwOJFb68aieuAqxAwNhHrg88TOaYWqaiRbRojzuaig6D5Lms1ntLry2vxsinuMc2n89pRx16+MG/VVQ6L4ryjndoYLnEtZf00ATq7DK/MkB7XZO0q4LUhZ2OMVe5JdvENVp1EYSYydWObHSMv0IvKwWhM5r0z1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40SEGghk024795;
	Sun, 28 Jan 2024 23:16:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Sun, 28 Jan 2024 23:16:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40SEGAAW024134
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 28 Jan 2024 23:16:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <613a54d2-9508-4f87-a163-a25a77a101cd@I-love.SAKURA.ne.jp>
Date: Sun, 28 Jan 2024 23:16:41 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/3] LSM: add security_bprm_aborting_creds() hook
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <e938c37b-d615-4be4-a2da-02b904b7072f@I-love.SAKURA.ne.jp>
In-Reply-To: <e938c37b-d615-4be4-a2da-02b904b7072f@I-love.SAKURA.ne.jp>
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
this patch adds security_bprm_aborting_creds() hook which is called only
when an execve() request failed after successful prepare_bprm_creds() call.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/exec.c                     |  1 +
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  5 +++++
 security/security.c           | 14 ++++++++++++++
 4 files changed, 21 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index af4fbb61cd53..9d198cd9a75c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1519,6 +1519,7 @@ static void free_bprm(struct linux_binprm *bprm)
 	}
 	free_arg_pages(bprm);
 	if (bprm->cred) {
+		security_bprm_aborting_creds(bprm);
 		mutex_unlock(&current->signal->cred_guard_mutex);
 		abort_creds(bprm->cred);
 	}
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 185924c56378..ec44ff913cee 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -54,6 +54,7 @@ LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct f
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, const struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, const struct linux_binprm *bprm)
+LSM_HOOK(void, LSM_RET_VOID, bprm_aborting_creds, const struct linux_binprm *bprm)
 LSM_HOOK(int, 0, fs_context_submount, struct fs_context *fc, struct super_block *reference)
 LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
 	 struct fs_context *src_sc)
diff --git a/include/linux/security.h b/include/linux/security.h
index d0eb20f90b26..cf78fb14ef3c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -299,6 +299,7 @@ int security_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(const struct linux_binprm *bprm);
 void security_bprm_committed_creds(const struct linux_binprm *bprm);
+void security_bprm_aborting_creds(const struct linux_binprm *bprm);
 int security_fs_context_submount(struct fs_context *fc, struct super_block *reference);
 int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc);
 int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param);
@@ -648,6 +649,10 @@ static inline void security_bprm_committed_creds(const struct linux_binprm *bprm
 {
 }
 
+static inline void security_bprm_aborting_creds(const struct linux_binprm *bprm)
+{
+}
+
 static inline int security_fs_context_submount(struct fs_context *fc,
 					   struct super_block *reference)
 {
diff --git a/security/security.c b/security/security.c
index 0144a98d3712..f426841e576a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1223,6 +1223,20 @@ void security_bprm_committed_creds(const struct linux_binprm *bprm)
 	call_void_hook(bprm_committed_creds, bprm);
 }
 
+/**
+ * security_bprm_aborting_creds() - Destroy creds for a process during exec()
+ * @bprm: binary program information
+ *
+ * Prepare to destroy the new security attributes which became unused due to
+ * failed execve operation.  @bprm points to the linux_binprm structure.
+ * This hook is a good place to undo changes which cannot be discarded by
+ * abort_creds().
+ */
+void security_bprm_aborting_creds(const struct linux_binprm *bprm)
+{
+	call_void_hook(bprm_aborting_creds, bprm);
+}
+
 /**
  * security_fs_context_submount() - Initialise fc->security
  * @fc: new filesystem context
-- 
2.18.4



