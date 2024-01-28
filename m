Return-Path: <linux-fsdevel+bounces-9242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D79B83F5C8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 15:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59389281BFB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 14:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9979241E7;
	Sun, 28 Jan 2024 14:18:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096E28DB3;
	Sun, 28 Jan 2024 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706451485; cv=none; b=P/PzXR1WOyUM6tgST4UCYpxe0AupRi8RzJoKGzSzh2qc/2Pz35Hm0VdFrLeu21eHIOMRNL3QB1Eve2f555neyPPNqD9rlUp6+WL4wbqvX9fUVupB7r1X+IUCC0xEN5AX73XS2rdqeOT7tbzV+GXqSx1QUx72P/urispYDjGwiNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706451485; c=relaxed/simple;
	bh=qpIaIii+FVz8FWE3By1Sq0aq8rDyLNTqxfwl0gu5I68=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kowG2kDhIFKQN9aAgp+8yghf27C+qfh2Z25xbUzboH88lLr5V7IzGX+hY9N6xEK7o1Ysh5Z8pjzzp302AsnHsbtxpo6r113qkvBj12TSaUOMVrZ9E2ezyk0b9kiT7lqRYK+2cf0cOGepvfUym2bT1XNF2ueg8pPS32m02EKC0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40SEHX5K025050;
	Sun, 28 Jan 2024 23:17:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Sun, 28 Jan 2024 23:17:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40SEGAAY024134
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 28 Jan 2024 23:17:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a8e4f641-0f3d-49fe-a87c-eba9cfbe8099@I-love.SAKURA.ne.jp>
Date: Sun, 28 Jan 2024 23:17:32 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/3] fs/exec: remove current->in_execve flag
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

Addition of security_bprm_aborting_creds() hook made it possible to remove
this flag.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/exec.c             | 3 ---
 include/linux/sched.h | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 9d198cd9a75c..f93cfc957e25 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1865,7 +1865,6 @@ static int bprm_execve(struct linux_binprm *bprm)
 	 * where setuid-ness is evaluated.
 	 */
 	check_unsafe_exec(bprm);
-	current->in_execve = 1;
 	sched_mm_cid_before_execve(current);
 
 	sched_exec();
@@ -1882,7 +1881,6 @@ static int bprm_execve(struct linux_binprm *bprm)
 	sched_mm_cid_after_execve(current);
 	/* execve succeeded */
 	current->fs->in_exec = 0;
-	current->in_execve = 0;
 	rseq_execve(current);
 	user_events_execve(current);
 	acct_update_integrals(current);
@@ -1901,7 +1899,6 @@ static int bprm_execve(struct linux_binprm *bprm)
 
 	sched_mm_cid_after_execve(current);
 	current->fs->in_exec = 0;
-	current->in_execve = 0;
 
 	return retval;
 }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffe8f618ab86..66ada87249b1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -919,9 +919,6 @@ struct task_struct {
 #ifdef CONFIG_RT_MUTEXES
 	unsigned			sched_rt_mutex:1;
 #endif
-
-	/* Bit to tell TOMOYO we're in execve(): */
-	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
 #ifndef TIF_RESTORE_SIGMASK
 	unsigned			restore_sigmask:1;
-- 
2.18.4



