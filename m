Return-Path: <linux-fsdevel+bounces-69258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E37C75DF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 19:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13768351A90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D3634CFD4;
	Thu, 20 Nov 2025 18:13:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E9F2FE59C;
	Thu, 20 Nov 2025 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662421; cv=none; b=gJDHAytPdGJbfnxPSRcJHvZmqPj9FtyalBtrRRSS1b4EG3Y5DCr2RWEgbpgMPkAHS30GLfTHPEGf4gzARozBJxiUzOMp2xv8Uy9VuOsKywRhUqZ7Hdls71MCTKZl65PiFd6BeTBji7GbcVx2bxUnxpFnUIGVeNW+OwnAYbIm2ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662421; c=relaxed/simple;
	bh=QIS6mpBdq2N3xQljBgRUlhU8C+c5gVyatzHM0SIxhyQ=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=cxt/aEyJotjk1o79gWNWXLKSN6hM3DxDYFkQHZUHaMHN3reTx9PaKLiFHx1JAz/bAiFNIis4F3DT/mPBuYuS+xrZ/3ROzwK2WTNcBpGkht8Ka/OP7LOlpTWu1OozuO/xvJssizzxYD/3dl6NGvgEOgbT5bsczrku6g4QEZIwYpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:36142)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vM8TC-0080O5-W2; Thu, 20 Nov 2025 10:29:23 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:33708 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vM8TB-00Fz5d-R2; Thu, 20 Nov 2025 10:29:22 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Alexey Dobriyan
 <adobriyan@gmail.com>,  Oleg Nesterov <oleg@redhat.com>,  Kees Cook
 <kees@kernel.org>,  Andy Lutomirski <luto@amacapital.net>,  Will Drewry
 <wad@chromium.org>,  Christian Brauner <brauner@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  Michal Hocko <mhocko@suse.com>,
  Serge Hallyn <serge@hallyn.com>,  James Morris
 <jamorris@linux.microsoft.com>,  Randy Dunlap <rdunlap@infradead.org>,
  Suren Baghdasaryan <surenb@google.com>,  Yafang Shao
 <laoar.shao@gmail.com>,  Helge Deller <deller@gmx.de>,  Adrian Reber
 <areber@redhat.com>,  Thomas Gleixner <tglx@linutronix.de>,  Jens Axboe
 <axboe@kernel.dk>,  Alexei Starovoitov <ast@kernel.org>,
  "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  linux-security-module@vger.kernel.org,  tiozhang
 <tiozhang@didiglobal.com>,  Luis Chamberlain <mcgrof@kernel.org>,  "Paulo
 Alcantara (SUSE)" <pc@manguebit.com>,  Sergey Senozhatsky
 <senozhatsky@chromium.org>,  Frederic Weisbecker <frederic@kernel.org>,
  YueHaibing <yuehaibing@huawei.com>,  Paul Moore <paul@paul-moore.com>,
  Aleksa Sarai <cyphar@cyphar.com>,  Stefan Roesch <shr@devkernel.io>,
  Chao Yu <chao@kernel.org>,  xu xin <xu.xin16@zte.com.cn>,  Jeff Layton
 <jlayton@kernel.org>,  Jan Kara <jack@suse.cz>,  David Hildenbrand
 <david@redhat.com>,  Dave Chinner <dchinner@redhat.com>,  Shuah Khan
 <shuah@kernel.org>,  Elena Reshetova <elena.reshetova@intel.com>,  David
 Windsor <dwindsor@gmail.com>,  Mateusz Guzik <mjguzik@gmail.com>,  Ard
 Biesheuvel <ardb@kernel.org>,  "Joel Fernandes (Google)"
 <joel@joelfernandes.org>,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  Hans Liljestrand <ishkamiel@gmail.com>,  Penglei
 Jiang <superman.xpt@gmail.com>,  Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>,  Adrian Ratiu <adrian.ratiu@collabora.com>,
  Ingo Molnar <mingo@kernel.org>,  "Peter Zijlstra (Intel)"
 <peterz@infradead.org>,  Cyrill Gorcunov <gorcunov@gmail.com>,  Eric
 Dumazet <edumazet@google.com>
In-Reply-To: <87tsyozqdu.fsf@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Thu, 20 Nov 2025 09:15:57 -0600")
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
	<AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
	<AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<GV2PPF74270EBEEE807D016A79FE7A2F463E4D6A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<87tsyozqdu.fsf@email.froward.int.ebiederm.org>
Date: Thu, 20 Nov 2025 11:29:14 -0600
Message-ID: <87wm3ky5n9.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1vM8TB-00Fz5d-R2;;;mid=<87wm3ky5n9.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18WRCiEc86RNupml3aU1I9F5t8x9s6oRjc=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XM_B_SpammyTLD Contains uncommon/spammy TLD
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Bernd Edlinger <bernd.edlinger@hotmail.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 514 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 11 (2.1%), b_tie_ro: 9 (1.8%), parse: 1.07 (0.2%),
	 extract_message_metadata: 17 (3.4%), get_uri_detail_list: 1.68 (0.3%),
	 tests_pri_-2000: 14 (2.8%), tests_pri_-1000: 11 (2.1%),
	tests_pri_-950: 1.22 (0.2%), tests_pri_-900: 1.10 (0.2%),
	tests_pri_-90: 92 (17.9%), check_bayes: 81 (15.7%), b_tokenize: 18
	(3.5%), b_tok_get_all: 8 (1.5%), b_comp_prob: 3.2 (0.6%),
	b_tok_touch_all: 49 (9.4%), b_finish: 0.90 (0.2%), tests_pri_0: 352
	(68.5%), check_dkim_signature: 0.56 (0.1%), check_dkim_adsp: 2.4
	(0.5%), poll_dns_idle: 0.53 (0.1%), tests_pri_10: 2.2 (0.4%),
	tests_pri_500: 8 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v18] exec: Fix dead-lock in de_thread with ptrace_attach
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: too long (recipient list exceeded maximum allowed size of 512 bytes)
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Bernd Edlinger <bernd.edlinger@hotmail.de> writes:
>
>> This introduces signal->exec_bprm, which is used to
>> fix the case when at least one of the sibling threads
>> is traced, and therefore the trace process may dead-lock
>> in ptrace_attach, but de_thread will need to wait for the
>> tracer to continue execution.
>
> A small quibble it isn't a dead lock.  It isn't even really a live lock,
> as it is possible to SIGKILL our way out.
>
> Thinking about this there is a really silly and simple way we can deal
> with this situation for PTRACE_ATTACH.  We can send SIGSTOP and wait for
> the thread to stop before doing anything with cred_guard_mutex.
>
> PTRACE_ATTACH already implies sending SIGSTOP so as long as we have
> enough permissions to send SIGSTOP I don't see that being a problem.
>
> The worst case I can see is that we get a case where we stop the
> process, the permission check fails under cred_guard_mutex and
> and ptrace attach has fails and has to send SIGCONT to undo it's
> premature SIGSTOP.  That might almost be visible, but it would still
> be legitimate because we can still check that we have permission to
> send SIGSTOP.

Bah no I am full of it.

The challenging behavior is in the semantics of the kernel operations.
We need to describe it as such please.

It is the same class of problem as a single threaded process calls exec
with a pipe attached to both stdin and stdout of the new process.

For the stdin and stdout we can say just use pull and nonblocking I/O.

The problem is that both PTRACE_ATTACH and PTRACE_SEIZE block over
the duration of exec, and if exec is waiting for a thread to exit,
and that thread is blocked in PTRACE_EVENT_EXIT waiting for that very
same tracer those processes will hang. Not deadlock.


I haven't seen anyone clearly describe the problem lately so I am
repeating it.


Just looking at the code I don't think there is any fundamental reason
to call commit_creds after de_thread.  If we can change that we can sort
this out without any change in userspace semantics.

If we can't move commit_creds we have to either give
PTRACE_ATTACH/PTRACE_SEIZE a non-block mode, or break out of
PTRACE_EVENT_EXIT in de_thread.

I will post a proof of concept of moving commit_creds in just a minute.

Eric

