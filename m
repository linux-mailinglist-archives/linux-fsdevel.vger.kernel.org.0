Return-Path: <linux-fsdevel+bounces-15121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFCE887357
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 19:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC651C20B5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 18:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6E86EB7B;
	Fri, 22 Mar 2024 18:46:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7F6E609;
	Fri, 22 Mar 2024 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133218; cv=none; b=duFMF5pWnwZ6n1kW8ECigABrFb8Du96JqGWZhV38fryECt6cTTHbGaeJfRm5dYodjqDUv81SKrHXRj/qJD6UyedaPwFs/cuxZ9+dJLCXG14jx4ioo0iiMZhQ6zaZq/ppxEqGyHhRBLqz2sVAs1Z2sgjogafCbW1s21WW1yxLuSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133218; c=relaxed/simple;
	bh=03Dg747A2OHVuEOp09BcVhm0o4yUsfAGR6i/kBtBbls=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=rOi1KJYZQDC/b/ut6G813Y/0Rflwxh4UTDkYJHpnof/ZLzImitsc18tO9DbbR70fZV0YB3lfRw7bvUHNLiUi5Xl1kgiEPanflkYmU8BHd3y2bhm1s6WLRIr5twJZ+W23+CdDsTsRHpTNPmgeHHENKrOiSCt8nCAvvNE2G7DYDkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:59970)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rnids-009kpI-Kq; Fri, 22 Mar 2024 11:25:20 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:53186 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rnidr-001ecQ-FZ; Fri, 22 Mar 2024 11:25:20 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Leo Yan <leo.yan@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Kees Cook
 <keescook@chromium.org>,  linux-fsdevel@vger.kernel.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Arnaldo Carvalho
 de Melo <acme@kernel.org>,  Namhyung Kim <namhyung@kernel.org>,  Ian
 Rogers <irogers@google.com>,  Al Grant <al.grant@arm.com>,  James Clark
 <james.clark@arm.com>,  Mark Rutland <mark.rutland@arm.com>
References: <20240322162759.714141-1-leo.yan@arm.com>
Date: Fri, 22 Mar 2024 12:24:54 -0500
In-Reply-To: <20240322162759.714141-1-leo.yan@arm.com> (Leo Yan's message of
	"Fri, 22 Mar 2024 16:27:59 +0000")
Message-ID: <87zfuqb2mx.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rnidr-001ecQ-FZ;;;mid=<87zfuqb2mx.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18snvkqDraPiZ7Bkn94EiEyuPU/BkxIg2g=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4997]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Leo Yan <leo.yan@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 592 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 13 (2.2%), b_tie_ro: 11 (1.9%), parse: 1.57
	(0.3%), extract_message_metadata: 19 (3.3%), get_uri_detail_list: 4.1
	(0.7%), tests_pri_-2000: 14 (2.4%), tests_pri_-1000: 4.1 (0.7%),
	tests_pri_-950: 1.59 (0.3%), tests_pri_-900: 1.27 (0.2%),
	tests_pri_-90: 134 (22.7%), check_bayes: 132 (22.3%), b_tokenize: 13
	(2.1%), b_tok_get_all: 12 (2.0%), b_comp_prob: 4.0 (0.7%),
	b_tok_touch_all: 100 (16.8%), b_finish: 1.18 (0.2%), tests_pri_0: 389
	(65.6%), check_dkim_signature: 0.78 (0.1%), check_dkim_adsp: 3.3
	(0.6%), poll_dns_idle: 0.61 (0.1%), tests_pri_10: 2.2 (0.4%),
	tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exec: Don't disable perf events for setuid root
 executables
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Leo Yan <leo.yan@arm.com> writes:

> Al Grant reported that the 'perf record' command terminates abnormally
> after setting the setuid bit for the executable. To reproduce this
> issue, an additional condition is the binary file is owned by the root
> user but is running under a non-privileged user. The logs below provide
> details:
>
>     $ sudo chmod u+s perf
>     $ ls -l perf
>     -rwsr-xr-x 1 root root 13147600 Mar 17 14:56 perf
>     $ ./perf record -e cycles -- uname
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.003 MB perf.data (7 samples) ]
>     Terminated
>
> Comparatively, the same command can succeed if the setuid bit is cleared
> for the perf executable:
>
>     $ sudo chmod u-s perf
>     $ ls -l perf
>     -rwxr-xr-x 1 root root 13147600 Mar 17 14:56 perf
>     $ ./perf record -e cycles -- uname
>     Linux
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.003 MB perf.data (13 samples) ]
>
> After setting the setuid bit, the problem arises when begin_new_exec()
> disables the perf events upon detecting that a regular user is executing
> a setuid binary, which notifies the perf process. Consequently, the perf
> tool in user space exits from polling and sends a SIGTERM signal to kill
> child processes and itself. This explains why we observe the tool being
> 'Terminated'.
>
> With the setuid bit a non-privileged user can obtain the same
> permissions as the executable's owner. If the owner has the privileged
> permission for accessing perf events, the kernel should keep enabling
> perf events. For this reason, this patch adds a condition checking for
> perfmon_capable() to not disabling perf events when the user has
> privileged permission yet.
>
> Note the begin_new_exec() function only checks permission for the
> per-thread mode in a perf session. This is why we don't need to add any
> extra checking for the global knob 'perf_event_paranoid', as it always
> grants permission for per-thread performance monitoring for unprivileged
> users (see Documentation/admin-guide/perf-security.rst).

This code change makes no sense.

The logic you are attempting to implement, allowing performance
measurements of a setuid application if it has sufficient capabilities
does make sense.

perfmon_capable tests if the current program has sufficient privileges
to use perf, not the program that enabled performance measurements.

The location perfmon_capable is being called in the new executable is
after the new executable gets it's new credentials.  AKA the suidroot
has already happened.  So it will always succeed for suidroot
executables.

I suggest you take a look at ptracer_capable that is used to test if the
ptracer has sufficient credentials to trace a suid root exectuable.

Eric



> Signed-off-by: Leo Yan <leo.yan@arm.com>
> Cc: Al Grant <al.grant@arm.com>
> Cc: James Clark <james.clark@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  fs/exec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index ff6f26671cfc..5ded01190278 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1401,7 +1401,8 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	 * wait until new credentials are committed
>  	 * by commit_creds() above
>  	 */
> -	if (get_dumpable(me->mm) != SUID_DUMP_USER)
> +	if ((get_dumpable(me->mm) != SUID_DUMP_USER) &&
> +	    !perfmon_capable())
>  		perf_event_exit_task(me);
>  	/*
>  	 * cred_guard_mutex must be held at least to this point to prevent

