Return-Path: <linux-fsdevel+bounces-21899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F1190DE72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 23:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9F31F24B31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 21:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFEE1779A5;
	Tue, 18 Jun 2024 21:32:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C0313AA44;
	Tue, 18 Jun 2024 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746357; cv=none; b=vFzYlrgrOk4mFy2q/2tLVE/bwMsil/3ahPyTYmskB+4TDEw57al9iZTfFMgfsQoL6wAAlV/mXSXA0Pe6t34SyuHSC7tK3EIEpSvNUK5J4I3Yr3r8kmQmvOV2luZWfsVALxhcC/8F0i18PKYSuy7H2znvGwpzFRNaaBOZu1hyFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746357; c=relaxed/simple;
	bh=y7l156obeOBJmxFExjFmh0A+yh+ya4ydluLwK8XF1EE=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=j2dZa3xunQqFXwHVGHdWQExu8q639G+zyeS+FL3acg6fzuqfxsFb13sKYlM0KmhUGq+/2UvXWhOq7GRqRXQr49KTmME+PNu/eOoPGwUlSE2NtCWw6LHBLg6J5Plm9Zixt3hqanx+cirSQvLw1dWMvAEnebPW8672wEz4ih5P4LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:47062)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJgRE-005R6Y-Kl; Tue, 18 Jun 2024 15:32:24 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:34896 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJgRD-0023Sy-FS; Tue, 18 Jun 2024 15:32:24 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
  akpm@linux-foundation.org,  apais@linux.microsoft.com,  ardb@kernel.org,
  brauner@kernel.org,  jack@suse.cz,  keescook@chromium.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  nagvijay@microsoft.com,  oleg@redhat.com,
  tandersen@netflix.com,  vincent.whitchurch@axis.com,
  viro@zeniv.linux.org.uk,  apais@microsoft.com,  ssengar@microsoft.com,
  sunilmut@microsoft.com,  vdso@hexbites.dev
References: <20240617234133.1167523-1-romank@linux.microsoft.com>
	<20240617234133.1167523-2-romank@linux.microsoft.com>
	<20240618061849.Vh9N3ds2@linutronix.de>
	<c4644f2c-fad3-4d98-8301-acdc0ff2f3a6@linux.microsoft.com>
Date: Tue, 18 Jun 2024 16:21:09 -0500
In-Reply-To: <c4644f2c-fad3-4d98-8301-acdc0ff2f3a6@linux.microsoft.com> (Roman
	Kisel's message of "Tue, 18 Jun 2024 09:30:22 -0700")
Message-ID: <87sexakkvu.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJgRD-0023Sy-FS;;;mid=<87sexakkvu.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/gB2O6TobRXQAk0tnw1xCtXBe434z0Hw0=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Roman Kisel <romank@linux.microsoft.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 441 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 4.1 (0.9%), b_tie_ro: 2.8 (0.6%), parse: 1.11
	(0.3%), extract_message_metadata: 4.8 (1.1%), get_uri_detail_list: 2.6
	(0.6%), tests_pri_-2000: 3.2 (0.7%), tests_pri_-1000: 2.4 (0.5%),
	tests_pri_-950: 1.14 (0.3%), tests_pri_-900: 0.81 (0.2%),
	tests_pri_-90: 74 (16.7%), check_bayes: 72 (16.4%), b_tokenize: 7
	(1.5%), b_tok_get_all: 10 (2.3%), b_comp_prob: 2.2 (0.5%),
	b_tok_touch_all: 51 (11.5%), b_finish: 0.73 (0.2%), tests_pri_0: 333
	(75.6%), check_dkim_signature: 0.39 (0.1%), check_dkim_adsp: 2.5
	(0.6%), poll_dns_idle: 1.13 (0.3%), tests_pri_10: 2.4 (0.5%),
	tests_pri_500: 8 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/1] binfmt_elf, coredump: Log the reason of the failed
 core dumps
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Roman Kisel <romank@linux.microsoft.com> writes:

> On 6/17/2024 11:18 PM, Sebastian Andrzej Siewior wrote:
>> On 2024-06-17 16:41:30 [-0700], Roman Kisel wrote:
>>> Missing, failed, or corrupted core dumps might impede crash
>>> investigations. To improve reliability of that process and consequently
>>> the programs themselves, one needs to trace the path from producing
>>> a core dumpfile to analyzing it. That path starts from the core dump file
>>> written to the disk by the kernel or to the standard input of a user
>>> mode helper program to which the kernel streams the coredump contents.
>>> There are cases where the kernel will interrupt writing the core out or
>>> produce a truncated/not-well-formed core dump.
>> How much of this happened and how much of this is just "let me handle
>> everything that could go wrong".
> Some of that must be happening as there are truncated dump files. Haven't run
> the logging code at large scale yet with the systems being stressed a lot by the
> customer workloads to hit all edge cases. Sent the changes to the kernel mail
> list out of abundance of caution first, and being ecstatic about that: on the
> other thread Kees noticed I didn't use the ratelimited logging. That has
> absolutely made me day and whole week, just glowing :) Might've been a close
> call due to something in a crash loop.

Another reason you could have truncated coredumps is the coredumping
process being killed.

I suspect if you want reasons why the coredump is truncated you are
going to want to instrument dump_interrupted, dump_skip and dump_emit
rather than their callers.  As they don't actually report why the
failed.

Are you using systemd-coredump?  Or another pipe based coredump
collector?  It might be the dump collector is truncating things.

Do you know if your application uses io_uring?  There were some weird
issues with io_uring and coredumps that were causing things to get
truncation at one point.  As I recall a hack was put in the coredump
code so that it worked but maybe there is another odd case that still
needs to be handled.
>
> I think it'd be fair to say that I am asking to please "let me handle (log)
> everything that could go wrong", ratelimited, as these error cases are present
> in the code, and logging can give a clue why the core dump collection didn't
> succeed and what one would need to explore to increase reliability of the
> system.

If you are looking for reasons you definitely want to instrument
fs/coredump.c much more than fs/binfmt_elf.c.  As fs/coredump.c is the
code that actually performs the writes.

One of these days if someone is ambitious we should probably merge the
coredump code from fs/binfmt_elf.c and fs/binfmt_elf_fdpic.c and just
hardcode the coredump code to always produce an elf format coredump.
Just for the simplicity of it all.

Eric

