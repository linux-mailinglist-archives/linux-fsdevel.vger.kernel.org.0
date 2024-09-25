Return-Path: <linux-fsdevel+bounces-30086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA441986093
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 16:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8971C20C41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763A018C029;
	Wed, 25 Sep 2024 13:13:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CFC178364;
	Wed, 25 Sep 2024 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727269989; cv=none; b=fRIYQl4LIVrdmaGl/+zgYCifAidoDyKWjCEQXh+SazLYlcOlh2TdHduq8zwDbrAEbc8w+zsLmAr7aO/tnYDkO59W0pSs0dAg6J+fdi6JmbjwemwOAh7hOQ38J1hbtz5LMq8YD5+QiTLG8V8ubHrcAgEa1TqhKOJx9Hbh4l6tUho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727269989; c=relaxed/simple;
	bh=sbJ8aZpQr6pbj4aIFTdsqChrPekZT8zbN4JHc+deSzU=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=VK1Bj+Xa61vz82iXhQW7f7J5EYhJqECZ3RSgiKrXl9VLv4AXEvm9ovH1LsOtgs8EufQv1CoeoTxnoBWnCQG9fD950jNxUNs/IKIezbL8r2Pnc3Zk8+Jjf7NVjca7peb1aYIalr05MJVvHEMymnh8GMMr6QJ4fN/OxWhFoUfCT8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:51622)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1stRpJ-006czo-NF; Wed, 25 Sep 2024 07:13:05 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:42346 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1stRpI-007JzX-O3; Wed, 25 Sep 2024 07:13:05 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Kees Cook <kees@kernel.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Jeff
 Layton <jlayton@kernel.org>,  Chuck Lever <chuck.lever@oracle.com>,
  Alexander Aring <alex.aring@gmail.com>,  linux-fsdevel@vger.kernel.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  Tycho Andersen
 <tandersen@netflix.com>,  Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?=
 <zbyszek@in.waw.pl>,
  Aleksa Sarai <cyphar@cyphar.com>
References: <20240924141001.116584-1-tycho@tycho.pizza>
	<87msjx9ciw.fsf@email.froward.int.ebiederm.org>
	<8D545969-2EFA-419A-B988-74AD0C26020C@kernel.org>
	<ZvNEVT+AR6dX88KK@tycho.pizza>
Date: Wed, 25 Sep 2024 08:12:29 -0500
In-Reply-To: <ZvNEVT+AR6dX88KK@tycho.pizza> (Tycho Andersen's message of "Tue,
	24 Sep 2024 16:59:33 -0600")
Message-ID: <87cykrancy.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1stRpI-007JzX-O3;;;mid=<87cykrancy.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/yeLOS1QR7U73+X4NTDuprnZz0rCrRSGw=
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
	*      [score: 0.3860]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Tycho Andersen <tycho@tycho.pizza>
X-Spam-Relay-Country: 
X-Spam-Timing: total 397 ms - load_scoreonly_sql: 0.02 (0.0%),
	signal_user_changed: 3.8 (0.9%), b_tie_ro: 2.5 (0.6%), parse: 0.65
	(0.2%), extract_message_metadata: 10 (2.5%), get_uri_detail_list: 0.49
	(0.1%), tests_pri_-2000: 14 (3.6%), tests_pri_-1000: 3.2 (0.8%),
	tests_pri_-950: 1.37 (0.3%), tests_pri_-900: 1.04 (0.3%),
	tests_pri_-90: 205 (51.7%), check_bayes: 203 (51.2%), b_tokenize: 4.2
	(1.0%), b_tok_get_all: 5 (1.4%), b_comp_prob: 1.11 (0.3%),
	b_tok_touch_all: 189 (47.7%), b_finish: 0.74 (0.2%), tests_pri_0: 147
	(37.0%), check_dkim_signature: 0.35 (0.1%), check_dkim_adsp: 3.2
	(0.8%), poll_dns_idle: 1.75 (0.4%), tests_pri_10: 1.62 (0.4%),
	tests_pri_500: 6 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: cyphar@cyphar.com, zbyszek@in.waw.pl, tandersen@netflix.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, alex.aring@gmail.com, chuck.lever@oracle.com, jlayton@kernel.org, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, kees@kernel.org, tycho@tycho.pizza
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Tycho Andersen <tycho@tycho.pizza> writes:

> Yeah, on second thought we could do something like:
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 36434feddb7b..a45ea270cc43 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1416,7 +1416,10 @@ int begin_new_exec(struct linux_binprm * bprm)
>                 set_dumpable(current->mm, SUID_DUMP_USER);
>
>         perf_event_exec();
> -       __set_task_comm(me, kbasename(bprm->filename), true);
> +       if (needs_comm_fixup)
> +               __set_task_comm(me, argv0, true);
                                  ^^^^^ nit: make that kbasename(argv0)

The typical case is for applications to use the filename as argv0,
at which point the directories in the pathname are just noise.

With only 16 characters in TASK_COMM we want to keep the noise down.

Eric

