Return-Path: <linux-fsdevel+bounces-9427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3697E8411DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 19:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CBE286AED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 18:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890C16F06E;
	Mon, 29 Jan 2024 18:15:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1593F9F3;
	Mon, 29 Jan 2024 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552132; cv=none; b=sv9cPvlGA6AWOVsYKwvps2AeY9IoXMP3HuNtrhVlgaD74VE/psn8aHQq1CuvMWnCDZe9DiwDKUJG8TinrYNaUtXHerjM5oMRuJ4Ngl4q/Yc0J34hYo2z1gJs4tcZQG7G7F9TMjVoH9A4cZqEUPXxQprtIXokcMwO1+gHnzN+dvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552132; c=relaxed/simple;
	bh=Am5aEz8EwJQXXuKnZa+C00jQvnC7PmkUOWBDLEGjGEk=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=Oj/xb+nYadSqdAADwogVPI9b2tOBXmG9sOeVa8Kz10Hd8Lvn2m0L5XxU5P8kF/7U9dGyg+0iJtxqJZ7YVh5mGNkZFUtFrbVeWFywz1JowRmYZXp6RUKee74k9GAAnfrmIKwDdCzpYyDuhDH5zPr701aAjKH+T+45mjorlUPDDbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:45144)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rUWAI-00ET44-Sf; Mon, 29 Jan 2024 11:15:26 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:35054 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rUWAH-00Edcf-6p; Mon, 29 Jan 2024 11:15:26 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,  Kees Cook
 <keescook@chromium.org>,  Christian Brauner <brauner@kernel.org>,  Jan
 Kara <jack@suse.cz>,  Paul Moore <paul@paul-moore.com>,  James Morris
 <jmorris@namei.org>,  "Serge E. Hallyn" <serge@hallyn.com>,
  linux-security-module@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  LKML <linux-kernel@vger.kernel.org>
References: <e938c37b-d615-4be4-a2da-02b904b7072f@I-love.SAKURA.ne.jp>
	<613a54d2-9508-4f87-a163-a25a77a101cd@I-love.SAKURA.ne.jp>
	<87frygbx04.fsf@email.froward.int.ebiederm.org>
	<dbf0ef61-355b-4dcb-8e51-9298cf847367@I-love.SAKURA.ne.jp>
Date: Mon, 29 Jan 2024 12:15:02 -0600
In-Reply-To: <dbf0ef61-355b-4dcb-8e51-9298cf847367@I-love.SAKURA.ne.jp>
	(Tetsuo Handa's message of "Mon, 29 Jan 2024 13:46:28 +0900")
Message-ID: <8734ug9fbt.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rUWAH-00Edcf-6p;;;mid=<8734ug9fbt.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18wl42UHne2LVIOqfwPN0l+F1RkALgM9RU=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4995]
	*  0.5 XMGappySubj_01 Very gappy subject
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
X-Spam-Relay-Country: 
X-Spam-Timing: total 728 ms - load_scoreonly_sql: 0.12 (0.0%),
	signal_user_changed: 12 (1.7%), b_tie_ro: 10 (1.4%), parse: 1.48
	(0.2%), extract_message_metadata: 15 (2.0%), get_uri_detail_list: 2.6
	(0.4%), tests_pri_-2000: 5 (0.7%), tests_pri_-1000: 2.9 (0.4%),
	tests_pri_-950: 1.34 (0.2%), tests_pri_-900: 1.07 (0.1%),
	tests_pri_-90: 202 (27.8%), check_bayes: 197 (27.0%), b_tokenize: 10
	(1.4%), b_tok_get_all: 8 (1.1%), b_comp_prob: 3.5 (0.5%),
	b_tok_touch_all: 171 (23.5%), b_finish: 0.88 (0.1%), tests_pri_0: 467
	(64.2%), check_dkim_signature: 0.82 (0.1%), check_dkim_adsp: 3.8
	(0.5%), poll_dns_idle: 0.37 (0.1%), tests_pri_10: 2.4 (0.3%),
	tests_pri_500: 13 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/3] LSM: add security_bprm_aborting_creds() hook
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> On 2024/01/29 13:10, Eric W. Biederman wrote:
>>> @@ -1519,6 +1519,7 @@ static void free_bprm(struct linux_binprm *bprm)
>>>  	}
>>>  	free_arg_pages(bprm);
>>>  	if (bprm->cred) {
>>> +		security_bprm_aborting_creds(bprm);
>>>  		mutex_unlock(&current->signal->cred_guard_mutex);
>>>  		abort_creds(bprm->cred);
>> 
>> Why isn't abort_creds calling security_free_cred enough here?
>
> Because security_cred_free() from put_cred_rcu() is called from RCU callback
> rather than from current thread doing execve().
> TOMOYO wants to restore attributes of current thread doing execve().

>
>> The fact that somewhere Tomoyo is modifying a credential that the rest
>> of the kernel sees as read-only, and making it impossible to just
>> restore that credential is very concerning from a maintenance
>> perspective.
>
> TOMOYO does not use "struct cred"->security.
> TOMOYO uses only "struct task_struct"->security.
>
>   struct lsm_blob_sizes tomoyo_blob_sizes __ro_after_init = {
>       .lbs_task = sizeof(struct tomoyo_task),
>   };
>
> TOMOYO uses security_task_alloc() for allocating "struct task_struct"->security,
> security_task_free() for releasing "struct task_struct"->security,
> security_bprm_check() for updating "struct task_struct"->security,
> security_bprm_committed_creds() for erasing old "struct task_struct"->security,
> security_bprm_aborting_creds() for restoring old "struct task_struct"->security.
>
> Commit a6f76f23d297 ("CRED: Make execve() take advantage of copy-on-write
> credentials") made TOMOYO impossible to do above. current->in_execve flag was a
> hack for emulating security_bprm_aborting_creds() using security_prepare_creds().
>
>> Can't Tomoyo simply allow reading of files that have __FMODE_EXEC
>> set when allow_execve is set, without needing to perform a domain
>> transition, and later back out that domain transition?
>
> No. That does not match TOMOYO's design.
>
> allow_execve keyword does not imply "allow opening that file for non-execve() purpose".

Huh?  I was proposing using the allow_execve credential to allow opening
and reading the file for execve purpose.  So you don't need to perform
a domain transition early.

> Also, performing a domain transition before execve() reaches point of no return is
> the TOMOYO's design, but COW credentials does not allow such behavior.

My question is simple.  Why can't TOMOYO use the changing of credentials
in task->cred to perform the domain transition?  Why can't TOMOYO work
with the code in execve?

I don't see anything that fundamentally requires you to have the domain
transition early.  All I have seen so far is an assertion that you
are using task->security.  Is there anything except for the reading
of the executable that having the domain transition early allows?

My primary concern with TOMOYO being the odd man out, and using hooks
for purposes arbitrary purposes instead of purposes they are logically
designed to be used for?

If you aren't going to change your design your new hook should be:
	security_execve_revert(current);
Or maybe:
	security_execve_abort(current);

At least then it is based upon the reality that you plan to revert
changes to current->security.  Saying anything about creds or bprm when
you don't touch them, makes no sense at all.  Causing people to
completely misunderstand what is going on, and making it more likely
they will change the code in ways that will break TOMOYO.


What I understand from the documentation you provided about TOMOYO is:
- TOMOYO provides the domain transition early so that the executable
  can be read.
- TOMOYO did that because it could not detect reliably when a file
  was opened for execve and read for execve.

Am I wrong in my understanding?

If that understanding is correct, now that (file->f_mode & __FMODE_EXEC)
is a reliable indication of a file used exclusively for exec then it
should be possible to take advantage of the new information and get
TOMOYO and the rest of the execve playing nicely with each other without
having to add new hooks.


If the maintenance concerns are not enough please consider the situation
from an attack surface concern.  Any hacked together poorly maintained
surface is ripe bugs, and the exploitation of those bugs.  Sometimes
those bugs will break you in obvious ways, other times those bugs
will break you in overlooked and exploitable ways.

Eric

