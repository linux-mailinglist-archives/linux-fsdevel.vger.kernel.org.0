Return-Path: <linux-fsdevel+bounces-9241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F98E83F5C5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 15:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F851C22712
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077E9241EA;
	Sun, 28 Jan 2024 14:17:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010CC2E401;
	Sun, 28 Jan 2024 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706451458; cv=none; b=WotWdGPlOi4JRejcFX8VRxEXKyHYGpuFkskuQ+cyUvrstGyL26t6c6Q8/DnSmJGMhoQIG+NCn6GthCiVKZOflMD0Enevx4rOEaNso/oUXoJJFmwXhe7w0/saHu7rdL4yXvtJIjw6ZMwYQVzdK7K/R/+j10iI+dDkVO7F+l7hQHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706451458; c=relaxed/simple;
	bh=lAYJ65VbD9qteDUGspUOYa8U+uiNPZmnxlvPQfvCwEo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KhzBj8JyL4KqqLA6RjV7xhBsq/+BTEpB4GoNPahKTGVWayQ84QUIv835CCzD4OMO9EElvlfBkmOVI/b7xIla9Js/5CYCD29di8wfRq7PyezdJcfsyatMlf4sQFMVqwxBLsKGawCueNEqPOCG2HhvHM+OqMgIRSElqHgvOR0c1+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40SEH9sV024935;
	Sun, 28 Jan 2024 23:17:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sun, 28 Jan 2024 23:17:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40SEGAAX024134
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 28 Jan 2024 23:17:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <515fc2e9-0df8-4985-a3c5-f918d784ee83@I-love.SAKURA.ne.jp>
Date: Sun, 28 Jan 2024 23:17:08 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/3] tomoyo: replace current->in_execve flag with
 security_bprm_aborting_creds() hook
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

TOMOYO was using current->in_execve flag in order to restore previous state
when previous execve() request failed. Since security_bprm_aborting_creds()
hook was added, switch to use it.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/tomoyo/tomoyo.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 04a92c3d65d4..de572705772a 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -18,34 +18,24 @@ struct tomoyo_domain_info *tomoyo_domain(void)
 {
 	struct tomoyo_task *s = tomoyo_task(current);
 
-	if (s->old_domain_info && !current->in_execve) {
-		atomic_dec(&s->old_domain_info->users);
-		s->old_domain_info = NULL;
-	}
 	return s->domain_info;
 }
 
 /**
- * tomoyo_cred_prepare - Target for security_prepare_creds().
- *
- * @new: Pointer to "struct cred".
- * @old: Pointer to "struct cred".
- * @gfp: Memory allocation flags.
+ * tomoyo_bprm_aborting_creds - Target for security_bprm_aborting_creds().
  *
- * Returns 0.
+ * @bprm: Pointer to "struct linux_binprm".
  */
-static int tomoyo_cred_prepare(struct cred *new, const struct cred *old,
-			       gfp_t gfp)
+static void tomoyo_bprm_aborting_creds(const struct linux_binprm *bprm)
 {
-	/* Restore old_domain_info saved by previous execve() request. */
+	/* Restore old_domain_info saved by execve() request. */
 	struct tomoyo_task *s = tomoyo_task(current);
 
-	if (s->old_domain_info && !current->in_execve) {
+	if (s->old_domain_info) {
 		atomic_dec(&s->domain_info->users);
 		s->domain_info = s->old_domain_info;
 		s->old_domain_info = NULL;
 	}
-	return 0;
 }
 
 /**
@@ -554,8 +544,8 @@ static const struct lsm_id tomoyo_lsmid = {
  * registering TOMOYO.
  */
 static struct security_hook_list tomoyo_hooks[] __ro_after_init = {
-	LSM_HOOK_INIT(cred_prepare, tomoyo_cred_prepare),
 	LSM_HOOK_INIT(bprm_committed_creds, tomoyo_bprm_committed_creds),
+	LSM_HOOK_INIT(bprm_aborting_creds, tomoyo_bprm_aborting_creds),
 	LSM_HOOK_INIT(task_alloc, tomoyo_task_alloc),
 	LSM_HOOK_INIT(task_free, tomoyo_task_free),
 #ifndef CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER
-- 
2.18.4



