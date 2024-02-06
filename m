Return-Path: <linux-fsdevel+bounces-10470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD15184B72B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDAF1C25815
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C35131E48;
	Tue,  6 Feb 2024 13:59:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B1131721;
	Tue,  6 Feb 2024 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227976; cv=none; b=Hn47xMu9nenpFdPI5noEQhF1bS4I9r2JkZEJbsm5CFu3jDMFxSVhZGYeqCey24Ta9r/9JYQl17ng92LYjbzgdyCJ7jS0EG1L9aY6aHxtAftGDK3SEb9KDGHLsHXhkPio+YXf5n/f1AMCua/aeyji5LLhCPHPRd1xyNEHU/31N9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227976; c=relaxed/simple;
	bh=/tfr0DcQzkypATH7SClMO+VuGfSS1tj0Xv863TTrGkI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EqdmnZArgCrG6gmQmx+jDIflnnHAWvNTFMn+teSkgbmJPrIhLCZ/1D80vpP+O/NLR0wJ6miajqbuy3oNm7UBH34G0Swc2Gx8L3B4FCy/Kzvt77ouMIVTz6+yuAbNbN/TECiGicTrlktHIOPkULeGrcMB1z7J6AlmkxYwyneNIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 416DxU3O018974;
	Tue, 6 Feb 2024 22:59:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Tue, 06 Feb 2024 22:59:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 416DwfKP018763
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 6 Feb 2024 22:59:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5a78cc55-9203-47b4-985d-d5991c9e7fe6@I-love.SAKURA.ne.jp>
Date: Tue, 6 Feb 2024 22:59:31 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 2/3] tomoyo: replace current->in_execve flag with
 security_execve_abort() hook
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <72da7003-a115-4162-b235-53cd3da8a90e@I-love.SAKURA.ne.jp>
In-Reply-To: <72da7003-a115-4162-b235-53cd3da8a90e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

TOMOYO was using current->in_execve flag in order to restore previous state
when previous execve() request failed. Since security_execve_abort() hook
was added, switch to use it.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: Serge E. Hallyn <serge@hallyn.com>
---
 security/tomoyo/tomoyo.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 04a92c3d65d4..a11dba3a9753 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -18,34 +18,22 @@ struct tomoyo_domain_info *tomoyo_domain(void)
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
- *
- * Returns 0.
+ * tomoyo_execve_abort - Target for security_execve_abort().
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
@@ -554,8 +542,8 @@ static const struct lsm_id tomoyo_lsmid = {
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


