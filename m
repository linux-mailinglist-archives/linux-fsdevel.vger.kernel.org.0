Return-Path: <linux-fsdevel+bounces-69360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B18C77AC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 08:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 152C54E96FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 07:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF19337104;
	Fri, 21 Nov 2025 07:19:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB69250BEC;
	Fri, 21 Nov 2025 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763709554; cv=none; b=aKM7Eek+p3lssHqo4dfg5FI3nf4cowlx4gonO6We3tkdQRm/2tDcEsWSQeSzwBEogidi1quK76ECjZYJxe+qHjILrlO2JmVilq/JoLoA5QWIlyyzL4DJ4xBuEBX8jYylKZ3wsAnFGcvMWvoO9dg4gwuYJ6Fk8bMO1NsP7mWbT2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763709554; c=relaxed/simple;
	bh=D/T+ry2i0aqr/sSamTTezDsRAWCyIn+Fl8q8hzbWTIY=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=X5G9RFLnXnxBhox0QCVNo/5qdNZXDQdTadfHCQLZl2tmA46iPNfEyxkjisQoZemkaSLrrQAmAv07qaXJrTj3JlXP3/MvBcXrWw5bAlsIg7XRUNgsHguer0455QfDHndYhSsS92XDUQMqNK+scEm9D5XtsXqawoKZwdlOhO7jSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:38322)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vMLQ6-00Cn6i-9s; Fri, 21 Nov 2025 00:19:02 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:55264 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vMLQ4-00CUPL-D2; Fri, 21 Nov 2025 00:19:01 -0700
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
In-Reply-To: <GV2PPF74270EBEEAD4CACA124C05BE1CE45E4D5A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	(Bernd Edlinger's message of "Fri, 21 Nov 2025 03:59:56 +0100")
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
	<87wm3ky5n9.fsf@email.froward.int.ebiederm.org>
	<87h5uoxw06.fsf_-_@email.froward.int.ebiederm.org>
	<87a50gxo0i.fsf@email.froward.int.ebiederm.org>
	<GV2PPF74270EBEEAD4CACA124C05BE1CE45E4D5A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Fri, 21 Nov 2025 01:18:54 -0600
Message-ID: <87o6ovx38h.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1vMLQ4-00CUPL-D2;;;mid=<87o6ovx38h.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/iHCtWSAl7NFlir4kFAhXy3/S8BzfxSNE=
X-Spam-Level: ****
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  1.5 TR_Symld_Words too many words that have symbols inside
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XM_B_SpammyTLD Contains uncommon/spammy TLD
	*  1.0 XM_B_Phish_Phrases Commonly used Phishing Phrases
	*  0.0 TR_XM_PhishingBody Phishing flag in body of message
	*  1.5 XM_B_SpammyTLD3 Phishing rule with uncommon/spammy TLD Combo
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Bernd Edlinger <bernd.edlinger@hotmail.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1314 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 12 (0.9%), b_tie_ro: 10 (0.8%), parse: 1.19
	(0.1%), extract_message_metadata: 15 (1.1%), get_uri_detail_list: 1.98
	(0.2%), tests_pri_-2000: 12 (0.9%), tests_pri_-1000: 9 (0.7%),
	tests_pri_-950: 0.95 (0.1%), tests_pri_-900: 0.82 (0.1%),
	tests_pri_-90: 89 (6.8%), check_bayes: 87 (6.6%), b_tokenize: 16
	(1.2%), b_tok_get_all: 14 (1.1%), b_comp_prob: 3.4 (0.3%),
	b_tok_touch_all: 47 (3.6%), b_finish: 1.34 (0.1%), tests_pri_0: 365
	(27.7%), check_dkim_signature: 0.58 (0.0%), check_dkim_adsp: 8 (0.6%),
	poll_dns_idle: 789 (60.1%), tests_pri_10: 1.92 (0.1%), tests_pri_500:
	805 (61.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] exec: Move cred computation under exec_update_lock
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: too long (recipient list exceeded maximum allowed size of 512 bytes)
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Bernd Edlinger <bernd.edlinger@hotmail.de> writes:

> Hi Eric,
>
> thanks for you valuable input on the topic.
>
> On 11/21/25 00:50, Eric W. Biederman wrote:
>> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>> 
>>> Instead of computing the new cred before we pass the point of no
>>> return compute the new cred just before we use it.
>>>
>>> This allows the removal of fs_struct->in_exec and cred_guard_mutex.
>>>
>>> I am not certain why we wanted to compute the cred for the new
>>> executable so early.  Perhaps I missed something but I did not see any
>>> common errors being signaled.   So I don't think we loose anything by
>>> computing the new cred later.
>> 
>> I should add that the permission checks happen in open_exec,
>> everything that follows credential wise is just about representing in
>> struct cred the credentials the new executable will have.
>> 
>> So I am really at a loss why we have had this complicated way of
>> computing of computed the credentials all of these years full of
>> time of check to time of use problems.
>> 
>
> Well, I think I see a problem with your patch:
>
> When the security engine gets the LSM_UNSAFE_PTRACE flag, it might
> e.g. return -EPERM in bprm_creds_for_exec in the apparmor, selinux
> or the smack security engines at least.  Previously that callback
> was called before the point of no return, and the return code should
> be returned as a return code the the caller of execve.  But if we move
> that check after the point of no return, the caller will get killed
> due to the failed security check.
>
> Or did I miss something?

I think we definitely need to document this change in behavior.  I would
call ending the exec with SIGSEGV vs -EPERM a quality of implementation
issue.  The exec is failing one way or the other so I don't see it as a
correctness issue.

In the case of ptrace in general I think it is a bug if the mere act of
debugging a program changes it's behavior.  So which buggy behavior
should we prefer?  SIGSEGV where it is totally clear that the behavior
has changed or -EPERM and ask the debugged program to handle it.
I lean towards SIGSEGV because then it is clear the code should not
handle it.

In the case of LSM_UNSAFE_NO_NEW_PRIVS I believe the preferred way to
handle unexpected things happening is to terminate the application.

In the case of LSM_UNSAFE_SHARE -EPERM might be better.  I don't know
of any good uses of any good uses of sys_clone(CLONE_FS ...) outside
of CLONE_THREAD.


Plus all of these things are only considerations if we are exec'ing a
program that transitions to a different set of credentials.  Something
that happens but is quite rare itself.

In practice I don't expect there is anything that depends on the exact
behavior of what happens when exec'ing a suid executable to gain
privileges when ptraced.   The closes I can imagine is upstart and
I think upstart ran as root when ptracing other programs so there is no
gaining of privilege and thus no reason for a security module to
complain.

Who knows I could be wrong, and someone could actually care.  Which is
hy I think we should document it.

Eric


