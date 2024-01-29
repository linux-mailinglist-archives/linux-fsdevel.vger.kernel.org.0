Return-Path: <linux-fsdevel+bounces-9295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F43B83FD4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 05:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88FA1F24C41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 04:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1C03C6BF;
	Mon, 29 Jan 2024 04:47:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7213E3C47A;
	Mon, 29 Jan 2024 04:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706503629; cv=none; b=nmDSClsKcgDTvKcOr7My3MBwMVJhrQsDDCKGD75yhvBZVGvJpjUGBdWliR9P3k3f4BcKm1Lr764awMuD8ZIgUCbXZLkk7EEOiyWZVPpEYGnOLjQki3IrGida0voBQck+38YaqdwpLsx0fAasSu59W7YpJH6u33ZN/2DnQwt4rZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706503629; c=relaxed/simple;
	bh=JoucwMxZd9PmjTkgLDJUpbbMuXcQwuV6dkhdjMXMF4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPtFyoUzSRl2olgHearmZ2qLwQLEWWgmZeGegAvz1opQn8xMJszQguIiuW+EP2vYcDmkrqXS6DTmC6KO9K0sfeI1GL7cmcr/HwzrvV2qg7I8Js9hefE3392hgPXr+tl8R9bAF1i3ElWj/7yAQ8a9LRBvm5sKCGvva8yFKr+VyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40T4kUgS074310;
	Mon, 29 Jan 2024 13:46:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Mon, 29 Jan 2024 13:46:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40T4kUgF074307
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 29 Jan 2024 13:46:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <dbf0ef61-355b-4dcb-8e51-9298cf847367@I-love.SAKURA.ne.jp>
Date: Mon, 29 Jan 2024 13:46:28 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] LSM: add security_bprm_aborting_creds() hook
Content-Language: en-US
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <e938c37b-d615-4be4-a2da-02b904b7072f@I-love.SAKURA.ne.jp>
 <613a54d2-9508-4f87-a163-a25a77a101cd@I-love.SAKURA.ne.jp>
 <87frygbx04.fsf@email.froward.int.ebiederm.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <87frygbx04.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/01/29 13:10, Eric W. Biederman wrote:
>> @@ -1519,6 +1519,7 @@ static void free_bprm(struct linux_binprm *bprm)
>>  	}
>>  	free_arg_pages(bprm);
>>  	if (bprm->cred) {
>> +		security_bprm_aborting_creds(bprm);
>>  		mutex_unlock(&current->signal->cred_guard_mutex);
>>  		abort_creds(bprm->cred);
> 
> Why isn't abort_creds calling security_free_cred enough here?

Because security_cred_free() from put_cred_rcu() is called from RCU callback
rather than from current thread doing execve().
TOMOYO wants to restore attributes of current thread doing execve().

> The fact that somewhere Tomoyo is modifying a credential that the rest
> of the kernel sees as read-only, and making it impossible to just
> restore that credential is very concerning from a maintenance
> perspective.

TOMOYO does not use "struct cred"->security.
TOMOYO uses only "struct task_struct"->security.

  struct lsm_blob_sizes tomoyo_blob_sizes __ro_after_init = {
      .lbs_task = sizeof(struct tomoyo_task),
  };

TOMOYO uses security_task_alloc() for allocating "struct task_struct"->security,
security_task_free() for releasing "struct task_struct"->security,
security_bprm_check() for updating "struct task_struct"->security,
security_bprm_committed_creds() for erasing old "struct task_struct"->security,
security_bprm_aborting_creds() for restoring old "struct task_struct"->security.

Commit a6f76f23d297 ("CRED: Make execve() take advantage of copy-on-write
credentials") made TOMOYO impossible to do above. current->in_execve flag was a
hack for emulating security_bprm_aborting_creds() using security_prepare_creds().

> Can't Tomoyo simply allow reading of files that have __FMODE_EXEC
> set when allow_execve is set, without needing to perform a domain
> transition, and later back out that domain transition?

No. That does not match TOMOYO's design.

allow_execve keyword does not imply "allow opening that file for non-execve() purpose".

Also, performing a domain transition before execve() reaches point of no return is
the TOMOYO's design, but COW credentials does not allow such behavior.


