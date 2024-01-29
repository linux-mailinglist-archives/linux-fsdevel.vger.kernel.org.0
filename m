Return-Path: <linux-fsdevel+bounces-9292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9314483FD23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 05:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2914D1F20E0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 04:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E1B12B91;
	Mon, 29 Jan 2024 04:11:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0374C11737;
	Mon, 29 Jan 2024 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706501463; cv=none; b=b3sa1sy/pbzSbxOzlgBIlCSTdttTnUSxARZu8xMewQMbCnTAOgmk4vJY6pDQ0f4i1Btk4cftPdPLF9sRYqxRpV5R/jqtudcjqFHD4KLVtnbQWgEbT5tNBcWBx3/PJspUmYfveHzy6fNLMfueszYCShXHPmfy1+FsmnD7xbXMyAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706501463; c=relaxed/simple;
	bh=gFyTubGzeynFIHyzwqQ79bgdGLJ3Vo4vTFTq75BZOVU=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=iHDBsGXacWGmPfInzf7gQ3ptZ0tj3+3kb7ji1c5UfvVeUNoBG2stAQR7CMaI4nrxx0eGPfvrdQPjPIOBKuDPaaTHtkLNguli1bR1/DaSpOr7jX9xVMgWyulrXFu5Mf0ZRCxCHEJJMP/zsEizy4ntfEavWelXOr7TgGyPFYFG8MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:43946)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rUIyy-00DJEa-8E; Sun, 28 Jan 2024 21:10:52 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:51358 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rUIyx-006FYI-AA; Sun, 28 Jan 2024 21:10:51 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,  Kees Cook
 <keescook@chromium.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Paul
 Moore <paul@paul-moore.com>,  James Morris <jmorris@namei.org>,  "Serge E.
 Hallyn" <serge@hallyn.com>,  <linux-security-module@vger.kernel.org>
 <linux-security-module@vger.kernel.org>,  <linux-fsdevel@vger.kernel.org>
 <linux-fsdevel@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>
References: <e938c37b-d615-4be4-a2da-02b904b7072f@I-love.SAKURA.ne.jp>
	<613a54d2-9508-4f87-a163-a25a77a101cd@I-love.SAKURA.ne.jp>
Date: Sun, 28 Jan 2024 22:10:19 -0600
In-Reply-To: <613a54d2-9508-4f87-a163-a25a77a101cd@I-love.SAKURA.ne.jp>
	(Tetsuo Handa's message of "Sun, 28 Jan 2024 23:16:41 +0900")
Message-ID: <87frygbx04.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rUIyx-006FYI-AA;;;mid=<87frygbx04.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18UA/hqWrZfwwrfC68Hn14pOeoqB042ceA=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: ***
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4940]
	*  0.7 XMSubLong Long Subject
	*  0.5 XMGappySubj_01 Very gappy subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
X-Spam-Relay-Country: 
X-Spam-Timing: total 342 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 3.9 (1.1%), b_tie_ro: 2.7 (0.8%), parse: 0.62
	(0.2%), extract_message_metadata: 9 (2.6%), get_uri_detail_list: 1.10
	(0.3%), tests_pri_-2000: 2.9 (0.9%), tests_pri_-1000: 1.98 (0.6%),
	tests_pri_-950: 0.89 (0.3%), tests_pri_-900: 0.87 (0.3%),
	tests_pri_-90: 57 (16.6%), check_bayes: 56 (16.4%), b_tokenize: 6
	(1.7%), b_tok_get_all: 8 (2.3%), b_comp_prob: 1.59 (0.5%),
	b_tok_touch_all: 38 (11.2%), b_finish: 0.58 (0.2%), tests_pri_0: 254
	(74.3%), check_dkim_signature: 0.42 (0.1%), check_dkim_adsp: 1.89
	(0.6%), poll_dns_idle: 0.35 (0.1%), tests_pri_10: 1.52 (0.4%),
	tests_pri_500: 7 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/3] LSM: add security_bprm_aborting_creds() hook
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> A regression caused by commit 978ffcbf00d8 ("execve: open the executable
> file before doing anything else") has been fixed by commit 4759ff71f23e
> ("exec: Check __FMODE_EXEC instead of in_execve for LSMs") and commit
> 3eab830189d9 ("uselib: remove use of __FMODE_EXEC"). While fixing this
> regression, Linus commented that we want to remove current->in_execve flag.
>
> The current->in_execve flag was introduced by commit f9ce1f1cda8b ("Add
> in_execve flag into task_struct.") when TOMOYO LSM was merged, and the
> reason was explained in commit f7433243770c ("LSM adapter functions.").
>
> In short, TOMOYO's design is not compatible with COW credential model
> introduced in Linux 2.6.29, and the current->in_execve flag was added for
> emulating security_bprm_free() hook which has been removed by introduction
> of COW credential model.

How is it not compatible?  Especially how is TOMOYO's design not
compatible with how things are today?

The discussion talks about not allowing reading of executables by programs
that can exec them.

At this point with __FMODE_EXEC being placed on the files for exec,
and with only execve using that mode all of your considerations should
be resolved.

So it appears to me that Tomoyo is currently compatible with COW
credentials even if it was not historically.

As such can we get a cleanup to actually make Tomoyo compatible.
Otherwise because Tomoyo is the only use of whatever you are doing
it will continue to be very easy to break Tomoyo.

The fact that somewhere Tomoyo is modifying a credential that the rest
of the kernel sees as read-only, and making it impossible to just
restore that credential is very concerning from a maintenance
perspective.

Can't Tomoyo simply allow reading of files that have __FMODE_EXEC
set when allow_execve is set, without needing to perform a domain
transition, and later back out that domain transition?


>  include/linux/security.h      |  5 +++++
>  security/security.c           | 14 ++++++++++++++
>  4 files changed, 21 insertions(+)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index af4fbb61cd53..9d198cd9a75c 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1519,6 +1519,7 @@ static void free_bprm(struct linux_binprm *bprm)
>  	}
>  	free_arg_pages(bprm);
>  	if (bprm->cred) {
> +		security_bprm_aborting_creds(bprm);
>  		mutex_unlock(&current->signal->cred_guard_mutex);
>  		abort_creds(bprm->cred);

Why isn't abort_creds calling security_free_cred enough here?
>  	}

Eric

