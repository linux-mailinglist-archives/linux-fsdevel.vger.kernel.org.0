Return-Path: <linux-fsdevel+bounces-69456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37159C7B7B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 20:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DFE24E5612
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FDD2FF15F;
	Fri, 21 Nov 2025 19:20:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9852D8367;
	Fri, 21 Nov 2025 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763752820; cv=none; b=QvpB7+hPiS630JGDi1vvwcrtT9CL5/mq2ZdYP6PyaXT7C1E4UOdXtydkHg4rBBBNF7YgBCAK/v2UN2GrhDsc3Zol7OWhtAs3ZTViTcX012BDXK7EtpaGzwrewwhVgzunS/XspurT8b8JtekPzMOMWnFKbTyO4e18PlLptIeoKi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763752820; c=relaxed/simple;
	bh=JTxhSWA6jxw9e4SLyOt7ueqSOQ+RMIIFCViCtct749k=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=CYwahzyNfyUz1iuvheaRsCQa0yk6gOEA7fpzyB3v5hPX3wZ0ddUEfiiaywoRPTBAOdC8lRIki1GvrMhLuiqUPjDFG56FF2dIJ7ln3cjG6hAaluBOU0TZ+LK471ihbWhssrhvsGp7RR3U5NK9mMxiUIJ3kdcjcP856xwiBubp4L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:56436)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vMWfr-00EM7W-Dy; Fri, 21 Nov 2025 12:20:03 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:50660 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vMWfp-000k4P-Vv; Fri, 21 Nov 2025 12:20:03 -0700
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
In-Reply-To: <GV2PPF74270EBEED0840E45459881C0EDD4E4D5A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	(Bernd Edlinger's message of "Fri, 21 Nov 2025 12:26:48 +0100")
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
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
	<87o6ovx38h.fsf@email.froward.int.ebiederm.org>
	<GV2PPF74270EBEEFA106F4EF26B087ED898E4D5A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<GV2PPF74270EBEED0840E45459881C0EDD4E4D5A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Fri, 21 Nov 2025 13:19:55 -0600
Message-ID: <87ikf3w5us.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1vMWfp-000k4P-Vv;;;mid=<87ikf3w5us.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18mnrD+bsi9GaqPd61WTLqlIJTub8z3bTo=
X-Spam-Level: ****
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  1.5 TR_Symld_Words too many words that have symbols inside
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XM_B_Phish_Phrases Commonly used Phishing Phrases
	*  1.0 XM_B_SpammyTLD Contains uncommon/spammy TLD
	*  0.0 TR_XM_PhishingBody Phishing flag in body of message
	*  1.5 XM_B_SpammyTLD3 Phishing rule with uncommon/spammy TLD Combo
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Bernd Edlinger <bernd.edlinger@hotmail.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 871 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 11 (1.2%), b_tie_ro: 9 (1.1%), parse: 1.97 (0.2%),
	 extract_message_metadata: 32 (3.7%), get_uri_detail_list: 6 (0.7%),
	tests_pri_-2000: 48 (5.5%), tests_pri_-1000: 11 (1.3%),
	tests_pri_-950: 1.33 (0.2%), tests_pri_-900: 1.19 (0.1%),
	tests_pri_-90: 124 (14.3%), check_bayes: 123 (14.1%), b_tokenize: 23
	(2.7%), b_tok_get_all: 17 (1.9%), b_comp_prob: 4.6 (0.5%),
	b_tok_touch_all: 73 (8.4%), b_finish: 0.89 (0.1%), tests_pri_0: 619
	(71.1%), check_dkim_signature: 0.63 (0.1%), check_dkim_adsp: 2.4
	(0.3%), poll_dns_idle: 0.67 (0.1%), tests_pri_10: 3.1 (0.4%),
	tests_pri_500: 13 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] exec: Move cred computation under exec_update_lock
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: too long (recipient list exceeded maximum allowed size of 512 bytes)
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Bernd Edlinger <bernd.edlinger@hotmail.de> writes:

> On 11/21/25 10:35, Bernd Edlinger wrote:
>> On 11/21/25 08:18, Eric W. Biederman wrote:
>>> Bernd Edlinger <bernd.edlinger@hotmail.de> writes:
>>>
>>>> Hi Eric,
>>>>
>>>> thanks for you valuable input on the topic.
>>>>
>>>> On 11/21/25 00:50, Eric W. Biederman wrote:
>>>>> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>>>>>
>>>>>> Instead of computing the new cred before we pass the point of no
>>>>>> return compute the new cred just before we use it.
>>>>>>
>>>>>> This allows the removal of fs_struct->in_exec and cred_guard_mutex.
>>>>>>
>>>>>> I am not certain why we wanted to compute the cred for the new
>>>>>> executable so early.  Perhaps I missed something but I did not see any
>>>>>> common errors being signaled.   So I don't think we loose anything by
>>>>>> computing the new cred later.
>>>>>
>>>>> I should add that the permission checks happen in open_exec,
>>>>> everything that follows credential wise is just about representing in
>>>>> struct cred the credentials the new executable will have.
>>>>>
>>>>> So I am really at a loss why we have had this complicated way of
>>>>> computing of computed the credentials all of these years full of
>>>>> time of check to time of use problems.
>>>>>
>>>>
>>>> Well, I think I see a problem with your patch:
>>>>
>>>> When the security engine gets the LSM_UNSAFE_PTRACE flag, it might
>>>> e.g. return -EPERM in bprm_creds_for_exec in the apparmor, selinux
>>>> or the smack security engines at least.  Previously that callback
>>>> was called before the point of no return, and the return code should
>>>> be returned as a return code the the caller of execve.  But if we move
>>>> that check after the point of no return, the caller will get killed
>>>> due to the failed security check.
>>>>
>>>> Or did I miss something?
>>>
>>> I think we definitely need to document this change in behavior.  I would
>>> call ending the exec with SIGSEGV vs -EPERM a quality of implementation
>>> issue.  The exec is failing one way or the other so I don't see it as a
>>> correctness issue.
>>>
>>> In the case of ptrace in general I think it is a bug if the mere act of
>>> debugging a program changes it's behavior.  So which buggy behavior
>>> should we prefer?  SIGSEGV where it is totally clear that the behavior
>>> has changed or -EPERM and ask the debugged program to handle it.
>>> I lean towards SIGSEGV because then it is clear the code should not
>>> handle it.
>>>
>>> In the case of LSM_UNSAFE_NO_NEW_PRIVS I believe the preferred way to
>>> handle unexpected things happening is to terminate the application.
>>>
>>> In the case of LSM_UNSAFE_SHARE -EPERM might be better.  I don't know
>>> of any good uses of any good uses of sys_clone(CLONE_FS ...) outside
>>> of CLONE_THREAD.
>>>
>>>
>>> Plus all of these things are only considerations if we are exec'ing a
>>> program that transitions to a different set of credentials.  Something
>>> that happens but is quite rare itself.
>>>
>>> In practice I don't expect there is anything that depends on the exact
>>> behavior of what happens when exec'ing a suid executable to gain
>>> privileges when ptraced.   The closes I can imagine is upstart and
>>> I think upstart ran as root when ptracing other programs so there is no
>>> gaining of privilege and thus no reason for a security module to
>>> complain.
>>>
>>> Who knows I could be wrong, and someone could actually care.  Which is
>>> hy I think we should document it.>>
>> 
>> 
>> Well, I dont know for sure, but the security engine could deny the execution
>> for any reason, not only because of being ptraced.
>> Maybe there can be a policy which denies user X to execute e.g. any suid programs.
>> 
>> 
>> Bernd.
>> 
>
> Hmm, funny..
>
> I installed this patch on top of
>
> commit fd95357fd8c6778ac7dea6c57a19b8b182b6e91f (HEAD -> master, origin/master, origin/HEAD)
> Merge: c966813ea120 7b6216baae75
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Thu Nov 20 11:04:37 2025 -0800
>
> but it does panic when I try to boot:
>
> [  0.870539]     TERM=1inux
> [  0.870573] Starting init: /bin/sh exists but couldn't execute it (error -14) 0.8705751 Kernel panic- not syncing: No working init found. Try passing i mit= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance
> [  0.870577] CPU: UID: 0 PID: 1 Comm: sh Not tainted 6.18.0-rc6+ #1 PREEMPT(voluntary)
> [  0.870579] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBo x 12/01/2006
> [  0.870580] Call Trace:
> [  0.870590]  <TASK>
> [  0.870592]  vpanic+0x36d/0x380
> [  0.870607]  ? __pfx_kernel_init+0x10/0x10
> [  0.870615]  panic+0x5b/0x60
> [  0.870617]  kernel_init+0x17d/0x1c0
> [  0.870623]  ret_from_fork+0x124/0x150
> [  0.870625}  ? __pfx_kernel_init+0x10/0x10
> [  0.870627]  ret_from_fork_asm+0x1a/0x30
> [  0.870632]  </TASK>
> [  0.8706631 Kernel Offset: 0x3a800000 from Oxffffffff81000000 (relocation ran ge: 0xffffffff80000000-0xffffffffbfffffff)
> [  0.880034] ---[ end Kernel panic - not syncing: No working init found. Try passing init option to kernel. See Linux Documentation/admin-guide/init.rst for guidance. 1---`
>
>
> Is that a known problem?

Nope.  It looks like the code needs a little bit bug fixing testing.

I will take see about taking a look.

Eric

