Return-Path: <linux-fsdevel+bounces-11712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D804F85660F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 15:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC381F26008
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BC4132C28;
	Thu, 15 Feb 2024 14:33:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98785132466;
	Thu, 15 Feb 2024 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007637; cv=none; b=aKTezvMF3FbS4xkqqJdmWW+7fyvZwN76S8UwyouQXs5g5uxoDRNcm1tf50S5xkxMnjo35SWRzw9bJqYUbOI0kYZ/I+Qmip9hF6bqULrXY93IoxrIrFAx5fqC9xBMkRXxe75pRlQspnFrEIGp1kQmva0WIkuDj98fwnZwivPse5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007637; c=relaxed/simple;
	bh=JjG8FYokVUNHfzEnKKz3D+XcAp7il/pNBEJYDLFwHK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DR0bTkNmioWNsQ690tanQdWZsDETZurpjS1unnkrGoEGWrIDq9pAZaCMKJ1rQyRXv/wFuIlFi3Z2Do8Myj8zU2duxiWadQLnD2CaEtStag5zdHEpGvXSupP5inJdIFvO3s2Kbrh3Pfjgcz8+WSGAKh2STiHvxY3WDvWr5GuFkIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 41FEXX5I090129;
	Thu, 15 Feb 2024 23:33:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Thu, 15 Feb 2024 23:33:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 41FEXWSX090118
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 15 Feb 2024 23:33:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <76bcd199-6c14-484f-8d4d-5a9c4a07ff7b@I-love.SAKURA.ne.jp>
Date: Thu, 15 Feb 2024 23:33:32 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] LSM: add security_execve_abort() hook
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, Eric Biederman <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Serge Hallyn <serge@hallyn.com>
References: <894cc57c-d298-4b60-a67d-42c1a92d0b92@I-love.SAKURA.ne.jp>
 <ab82c3ffce9195b4ebc1a2de874fdfc1@paul-moore.com>
 <1138640a-162b-4ba0-ac40-69e039884034@I-love.SAKURA.ne.jp>
 <202402070631.7B39C4E8@keescook>
 <CAHC9VhS1yHyzA-JuDLBQjyyZyh=sG3LxsQxB9T7janZH6sqwqw@mail.gmail.com>
 <CAHC9VhTTj9U-wLLqrHN5xHp8UbYyWfu6nTXuyk8EVcYR7GB6=Q@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhTTj9U-wLLqrHN5xHp8UbYyWfu6nTXuyk8EVcYR7GB6=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/02/15 6:46, Paul Moore wrote:
>> To quickly summarize, there are two paths forward that I believe are
>> acceptable from a LSM perspective, pick either one and send me an
>> updated patchset.
>>
>> 1. Rename the hook to security_bprm_free() and update the LSM hook
>> description as I mentioned earlier in this thread.
>>
>> 2. Rename the hook to security_execve_revert(), move it into the
>> execve related functions, and update the LSM hook description to
>> reflect that this hook is for reverting execve related changes to the
>> current task's internal LSM state beyond what is possible via the
>> credential hooks.
> 
> Hi Tetsuo, I just wanted to check on this and see if you've been able
> to make any progress?
> 

I'm fine with either approach. Just worrying that someone doesn't like
overhead of unconditionally calling security_bprm_free() hook.
If everyone is fine with below one, I'll post v4 patchset.

 fs/exec.c                     |    1 +
 include/linux/lsm_hook_defs.h |    1 +
 include/linux/security.h      |    5 +++++
 security/security.c           |   12 ++++++++++++
 4 files changed, 19 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index af4fbb61cd53..cbee988445c6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1530,6 +1530,7 @@ static void free_bprm(struct linux_binprm *bprm)
 		kfree(bprm->interp);
 	kfree(bprm->fdpath);
 	kfree(bprm);
+	security_bprm_free();
 }
 
 static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int flags)
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 76458b6d53da..0ef298231de2 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -54,6 +54,7 @@ LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct f
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, const struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, const struct linux_binprm *bprm)
+LSM_HOOK(void, LSM_RET_VOID, bprm_free, void)
 LSM_HOOK(int, 0, fs_context_submount, struct fs_context *fc, struct super_block *reference)
 LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
 	 struct fs_context *src_sc)
diff --git a/include/linux/security.h b/include/linux/security.h
index d0eb20f90b26..b12d20071a8f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -299,6 +299,7 @@ int security_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(const struct linux_binprm *bprm);
 void security_bprm_committed_creds(const struct linux_binprm *bprm);
+void security_bprm_free(void);
 int security_fs_context_submount(struct fs_context *fc, struct super_block *reference);
 int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc);
 int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param);
@@ -648,6 +649,10 @@ static inline void security_bprm_committed_creds(const struct linux_binprm *bprm
 {
 }
 
+static inline void security_bprm_free(void)
+{
+}
+
 static inline int security_fs_context_submount(struct fs_context *fc,
 					   struct super_block *reference)
 {
diff --git a/security/security.c b/security/security.c
index 3aaad75c9ce8..ba2f480b2bdb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1223,6 +1223,18 @@ void security_bprm_committed_creds(const struct linux_binprm *bprm)
 	call_void_hook(bprm_committed_creds, bprm);
 }
 
+/**
+ * security_bprm_free() - Notify of completion of an exec()
+ *
+ * This hook is called when a linux_bprm instance is being destroyed, after
+ * the bprm creds have been released, and is intended to cleanup any internal
+ * LSM state associated with the linux_bprm instance.
+ */
+void security_bprm_free(void)
+{
+	call_void_hook(bprm_free);
+}
+
 /**
  * security_fs_context_submount() - Initialise fc->security
  * @fc: new filesystem context


