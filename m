Return-Path: <linux-fsdevel+bounces-10144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A66848544
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 11:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259591F275D4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 10:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60925D913;
	Sat,  3 Feb 2024 10:54:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEBF482FF;
	Sat,  3 Feb 2024 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706957645; cv=none; b=X9gh7kl8ATI+1tyyBkFkm8c+/hu9IXw7cfH2/6v9ih6c3Ymu+SGfYco/mBu2ntzh6n5mMY6oYkv9twZ79BI/ZdD75rGDxvD5r+xCyZetam/icgNZUeX6/cnRbLtPYuka5A0SvjAH2EdmMTZTmt8RKRRESH+9aq+46o39bdadB2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706957645; c=relaxed/simple;
	bh=F+69FTeIjzSdatJi0VG2CjE/hSQPwZ6HCaeuaIWBHzw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ANW0UvDLbWFxqo8uZAAYCKtkmlZkTZ05dJbyugP3uDD/hxs0XP77Pkk/FYHC9sMtpAVHim60Wc6cYX0xVTxwsHCK16Whhtb7WQwF6Nyp0mX6YwMLFRGsTBN6fH1gXcWOEa1/SgtY27dwhl80kwVk77Y3DrEzmVTLHRt14IXVuG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 413Arep7052729;
	Sat, 3 Feb 2024 19:53:40 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Sat, 03 Feb 2024 19:53:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 413AqOr0052397
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 3 Feb 2024 19:53:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c62a36de-716e-439d-80a2-57e6a3c22db0@I-love.SAKURA.ne.jp>
Date: Sat, 3 Feb 2024 19:53:39 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/3] fs/exec: remove current->in_execve flag
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

Addition of security_execve_abort() hook made it possible to remove
this flag.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/exec.c             | 3 ---
 include/linux/sched.h | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index d6d35a06fd08..c197573b2940 100644
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



