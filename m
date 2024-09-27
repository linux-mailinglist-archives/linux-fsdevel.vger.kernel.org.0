Return-Path: <linux-fsdevel+bounces-30265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F41D988881
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 17:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8DE282D03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20331C1738;
	Fri, 27 Sep 2024 15:46:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DD613C914;
	Fri, 27 Sep 2024 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727451994; cv=none; b=dkD/w7Ndiby6LON1O/1AUJ7fgGaz3paLjhGSAAweyaVX2Hb8P0q/2oiE3TESLJjk82KvKJFBb5vbNNxsIK218TotV+k/lu7ahrjKTn9sKEGk88fsNc8KGkk07tHQMLYynpLPAYs3d9oLy2Sr5YqXj9+66IfXpk7741p6JDQGb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727451994; c=relaxed/simple;
	bh=tZZoVXnv/PRD54q+iCr5mOAfer9k2Sw1tPHZcIZfnww=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=Tb2gT1ofcMo522GlLpFye6hQhl4TbPEicvpEzfyMWxntwpTB35XwQWP48os7oeidcBKjYcdAevjhVItW4LS7UM4hNMfrb9lp6J+3R8hR4ERxtXV9kwUaxGZtnrVesY9A3YRd38Av5AA4gprNJ2oT9dsu6T9nkyXL1Z9UHO1iJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:36308)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1suDAr-00AfzR-Hh; Fri, 27 Sep 2024 09:46:29 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:50292 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1suDAq-00Chi3-EP; Fri, 27 Sep 2024 09:46:29 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Kees Cook
 <kees@kernel.org>,  linux-fsdevel@vger.kernel.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,  Tycho
 Andersen <tandersen@netflix.com>,  Zbigniew =?utf-8?Q?J=C4=99drzejewski-S?=
 =?utf-8?Q?zmek?=
 <zbyszek@in.waw.pl>,  Aleksa Sarai <cyphar@cyphar.com>
References: <20240927151746.391931-1-tycho@tycho.pizza>
Date: Fri, 27 Sep 2024 10:45:58 -0500
In-Reply-To: <20240927151746.391931-1-tycho@tycho.pizza> (Tycho Andersen's
	message of "Fri, 27 Sep 2024 09:17:45 -0600")
Message-ID: <87ikuhw155.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1suDAq-00Chi3-EP;;;mid=<87ikuhw155.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19JXeMpjE5lwEscr8j+IipPi94Su8pZcjo=
X-Spam-Level: ******
X-Spam-Virus: No
X-Spam-Report: 
	*  7.0 XM_URI_RBL URI blacklisted in uri.bl.xmission.com
	*      [URIs: waw.pl]
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
	*      [score: 0.3455]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ******;Tycho Andersen <tycho@tycho.pizza>
X-Spam-Relay-Country: 
X-Spam-Timing: total 529 ms - load_scoreonly_sql: 0.02 (0.0%),
	signal_user_changed: 3.9 (0.7%), b_tie_ro: 2.7 (0.5%), parse: 0.70
	(0.1%), extract_message_metadata: 16 (3.0%), get_uri_detail_list: 1.56
	(0.3%), tests_pri_-2000: 30 (5.7%), tests_pri_-1000: 1.85 (0.3%),
	tests_pri_-950: 0.89 (0.2%), tests_pri_-900: 0.73 (0.1%),
	tests_pri_-90: 214 (40.5%), check_bayes: 213 (40.3%), b_tokenize: 6
	(1.1%), b_tok_get_all: 93 (17.5%), b_comp_prob: 1.61 (0.3%),
	b_tok_touch_all: 111 (20.9%), b_finish: 0.69 (0.1%), tests_pri_0: 250
	(47.4%), check_dkim_signature: 0.36 (0.1%), check_dkim_adsp: 3.2
	(0.6%), poll_dns_idle: 1.96 (0.4%), tests_pri_10: 1.56 (0.3%),
	tests_pri_500: 6 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 1/2] exec: add a flag for "reasonable" execveat() comm
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: cyphar@cyphar.com, zbyszek@in.waw.pl, tandersen@netflix.com, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, kees@kernel.org, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, tycho@tycho.pizza
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Tycho Andersen <tycho@tycho.pizza> writes:

> From: Tycho Andersen <tandersen@netflix.com>
>
> Zbigniew mentioned at Linux Plumber's that systemd is interested in
> switching to execveat() for service execution, but can't, because the
> contents of /proc/pid/comm are the file descriptor which was used,
> instead of the path to the binary. This makes the output of tools like
> top and ps useless, especially in a world where most fds are opened
> CLOEXEC so the number is truly meaningless.
>
> Change exec path to fix up /proc/pid/comm in the case where we have
> allocated one of these synthetic paths in bprm_init(). This way the actual
> exec machinery is unchanged, but cosmetically the comm looks reasonable to
> admins investigating things.

Perhaps change the subject to match the code.

> Signed-off-by: Tycho Andersen <tandersen@netflix.com>
> Suggested-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> CC: Aleksa Sarai <cyphar@cyphar.com>
> Link: https://github.com/uapi-group/kernel-features#set-comm-field-before=
-exec
> ---
> v2: * drop the flag, everyone :)
>     * change the rendered value to f_path.dentry->d_name.name instead of
>       argv[0], Eric
> ---
>  fs/exec.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index dad402d55681..9520359a8dcc 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1416,7 +1416,18 @@ int begin_new_exec(struct linux_binprm * bprm)
>  		set_dumpable(current->mm, SUID_DUMP_USER);
>=20=20
>  	perf_event_exec();
> -	__set_task_comm(me, kbasename(bprm->filename), true);
> +
> +	/*
> +	 * If fdpath was set, execveat() made up a path that will
> +	 * probably not be useful to admins running ps or similar.
> +	 * Let's fix it up to be something reasonable.
> +	 */
> +	if (bprm->fdpath) {
> +		BUILD_BUG_ON(TASK_COMM_LEN > DNAME_INLINE_LEN);
> +		__set_task_comm(me, bprm->file->f_path.dentry->d_name.name, true);

We can just do this regardless of bprm->fdpath.

It will be a change of behavior on when executing symlinks and possibly
mount points but I don't think we care.  If we do then we can add make
it conditional with "if (bprm->fdpath)"

At the very least using the above version unconditionally ought to flush
out any bugs.

It should be 99% application invisible as all an application can see
is argv0.  So it is only ps and friends where the comm value is visible.

Eric

