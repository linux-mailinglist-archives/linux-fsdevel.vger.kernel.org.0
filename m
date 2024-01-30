Return-Path: <linux-fsdevel+bounces-9517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A72A8421C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 11:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0F81F27BD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 10:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410726BB2A;
	Tue, 30 Jan 2024 10:44:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F76A03A;
	Tue, 30 Jan 2024 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611443; cv=none; b=fZ/tbsvnVyqqwtqemq4VirWeP+Vg6fonAKXpffylNMaS8umUJvaNHDWtcaQLn4x/u4HmU63YGuFMDe4biFl3/GCmnwreChrgYtL7lZ1CjmpittEBTGX5OoY25KVqyOQG4Hjdt7LxjEy70uPMHS2L2H/PFwWtv1GB2bwdi7nznIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611443; c=relaxed/simple;
	bh=LR4Tqdwk6o5B3sBkOoFmCKb782ENpektt/aVbGbwqOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDn/6LwfTwhrFKK1uwtfht69SiPaiy3g/s33mIwJ1PewMkFcyZzhzNiaVcgAVQraEtRp/1OQymndMaPwkSLDYDDd5XOvnJ3Bs+9UOrLtUh6RhY5Quecwg8114MsitkpcfmlzIdRee/1sGrYuf/bnHP2BYz7nrBXwph91ekj6H8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40UAh0Lq008630;
	Tue, 30 Jan 2024 19:43:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Tue, 30 Jan 2024 19:43:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40UAh0YY008627
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 30 Jan 2024 19:43:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <56432241-1947-4701-a3d1-febd57fb3096@I-love.SAKURA.ne.jp>
Date: Tue, 30 Jan 2024 19:42:59 +0900
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
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <e938c37b-d615-4be4-a2da-02b904b7072f@I-love.SAKURA.ne.jp>
 <613a54d2-9508-4f87-a163-a25a77a101cd@I-love.SAKURA.ne.jp>
 <87frygbx04.fsf@email.froward.int.ebiederm.org>
 <dbf0ef61-355b-4dcb-8e51-9298cf847367@I-love.SAKURA.ne.jp>
 <8734ug9fbt.fsf@email.froward.int.ebiederm.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <8734ug9fbt.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/01/30 3:15, Eric W. Biederman wrote:
> If you aren't going to change your design your new hook should be:
> 	security_execve_revert(current);
> Or maybe:
> 	security_execve_abort(current);
> 
> At least then it is based upon the reality that you plan to revert
> changes to current->security.  Saying anything about creds or bprm when
> you don't touch them, makes no sense at all.  Causing people to
> completely misunderstand what is going on, and making it more likely
> they will change the code in ways that will break TOMOYO.

Fine for me. The current argument is redundant, for nobody will try to
call security_execve_abort() on a remote thread.

> 
> 
> What I understand from the documentation you provided about TOMOYO is:
> - TOMOYO provides the domain transition early so that the executable
>   can be read.
> - TOMOYO did that because it could not detect reliably when a file
>   was opened for execve and read for execve.
> 
> Am I wrong in my understanding?
> 
> If that understanding is correct, now that (file->f_mode & __FMODE_EXEC)
> is a reliable indication of a file used exclusively for exec then it
> should be possible to take advantage of the new information and get
> TOMOYO and the rest of the execve playing nicely with each other without
> having to add new hooks.

current->in_execve flag has two purposes: "whether to check permission" and
"what domain is used for checking permission (if need to check permission)".

One is to distinguish "open from execve()" and "open from uselib()".
This was replaced by the (file->f_mode & __FMODE_EXEC) change, for
__FMODE_EXEC was now removed from uselib(). But this is after all about
"whether to check permission".

The other is to emulate security_execve_abort(). security_execve_abort() is
needed because TOMOYO checks permission for opening interpreter file from
execve() using a domain which the current thread will belong to if execve()
succeeds (whereas DAC checks permission for opening interpreter file from
execve() using credentials which the current thread is currently using).
This is about "what domain is used for checking permission".

Since security_file_open() hook cannot see bprm->cred, TOMOYO cannot know
"what domain is used for checking permission" from security_file_open().
TOMOYO can know only "whether to check permission" from security_file_open().

Since TOMOYO cannot pass bprm->cred to security_file_open() hook using
override_creds()/revert_creds(), TOMOYO is passing "what domain is used for
checking permission" to security_file_open() via "struct task_struct"->security.
"struct task_struct"->security is updated _before_ security_file_open() for the
interpreter file is called.

Since security_execve_abort() was missing, when execve() failed, TOMOYO had
to keep the domain which the current thread would belong to if execve() succeeded.
The kept domain is cleared when TOMOYO finds that previous execve() was finished
(indicated by current->in_execve == 0) or when TOMOYO finds that new execve() is
in progress (indicated by current->in_execve == 0 when security_cred_prepare() is
called).

It is not possible to extract "what domain is used for checking permission" from
"whether file->f_mode includes __FMODE_EXEC". Talking about the
(file->f_mode & __FMODE_EXEC) change (i.e. "whether to check permission") is
pointless when talking about "what domain is used for checking permission".


