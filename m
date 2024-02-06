Return-Path: <linux-fsdevel+bounces-10472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA80784B74F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E044B2A1A4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A9E131E34;
	Tue,  6 Feb 2024 14:01:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B3131754;
	Tue,  6 Feb 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707228076; cv=none; b=RJwbFUscWhkjDOWZc9/385JRgjv07b03fkvGjRvQbwiZefXeAUdJzs35JFRbWV4sErUlSAPL1q66Ol98mAGLvFebDLOKhK9r6j5wSN+ITt30HtAAr0YJd+a0C0fbyiASEO8dKKkz5W1/BGexZXlL9MCz5DP2DLixLlfH69AnOPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707228076; c=relaxed/simple;
	bh=Nbxk054PI3VscSXZTq7j5mcMj6TYP/G6hIvTG+1Zj1I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IhtWMJjnwJSrfOdLU37HoA6dimn0nNHEN/TVpOI7KSHq6UjbC5GVAHQkG9NBNcchA54xzLAe1fsNLlI6NPhhvw50f8Qa86hVfzepILugvhJrdtXujnkWir97j87GxwKeHoi26NIbfARoxYdHA5SjgPaQIJuZ5+/UkQYo0DzJIfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 416E1Bkl019432;
	Tue, 6 Feb 2024 23:01:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Tue, 06 Feb 2024 23:01:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 416DwfKQ018763
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 6 Feb 2024 22:59:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6ec07f34-c597-4872-813b-639334fcd2cf@I-love.SAKURA.ne.jp>
Date: Tue, 6 Feb 2024 22:59:57 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 3/3] fs/exec: remove current->in_execve flag
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <72da7003-a115-4162-b235-53cd3da8a90e@I-love.SAKURA.ne.jp>
In-Reply-To: <72da7003-a115-4162-b235-53cd3da8a90e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Addition of security_execve_abort() hook made it possible to remove
this flag.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: Serge E. Hallyn <serge@hallyn.com>
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



