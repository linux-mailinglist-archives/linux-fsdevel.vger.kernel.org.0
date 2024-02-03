Return-Path: <linux-fsdevel+bounces-10143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDD7848541
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 11:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9381C21A61
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 10:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49B25D8F8;
	Sat,  3 Feb 2024 10:53:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211D5DF32;
	Sat,  3 Feb 2024 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706957622; cv=none; b=p7lT6xOcHihbtjLXyU0OvFkpwHkeMy5lokkv6QC6uHJ+A3GROr+yr0dRZOGCWo2fLvk0oIsMPcUG4CEIOjdEPbrDvERNLHN5F6zS6WmBndN7Xi6JX2ipDOhJ+1VMQT9w8mARdPTPVOqipTH+br28UQSbcCw/isuyL3sby4e1PcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706957622; c=relaxed/simple;
	bh=8vqCj4OOBOrarMSM5zpD/UThJa847S4p6+egpVHsUbg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tGHukq/WiLRf0CK56O5OlotMR6NA6/bbfDVomDHlzeZFy8yQKJzn8HiKcZVocd9xd161NfICqvkD1SZ4yzzun9cR+FveBuP5/tZh1NQJ3vucycUEl/j6xdG2oHB1YOmDi+eKot60eDHYEdLVyERCT1AMMLzgvKXyGq9dOFuIH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 413ArIfe052647;
	Sat, 3 Feb 2024 19:53:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Sat, 03 Feb 2024 19:53:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 413AqOqx052397
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 3 Feb 2024 19:53:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2a901d27-dba5-4ff4-9e47-373c54965253@I-love.SAKURA.ne.jp>
Date: Sat, 3 Feb 2024 19:53:17 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/3] tomoyo: replace current->in_execve flag with
 security_execve_abort() hook
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
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
In-Reply-To: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

TOMOYO was using current->in_execve flag in order to restore previous state
when previous execve() request failed. Since security_execve_abort() hook
was added, switch to use it.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/tomoyo/tomoyo.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 04a92c3d65d4..9da11aaffeb9 100644
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
+ * tomoyo_execve_abort - Target for security_execve_abort().
  *
- * Returns 0.
+ * @bprm: void
  */
-static int tomoyo_cred_prepare(struct cred *new, const struct cred *old,
-			       gfp_t gfp)
+static void tomoyo_execve_abort(void)
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
+	LSM_HOOK_INIT(execve_abort, tomoyo_execve_abort),
 	LSM_HOOK_INIT(task_alloc, tomoyo_task_alloc),
 	LSM_HOOK_INIT(task_free, tomoyo_task_free),
 #ifndef CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER
-- 
2.18.4



