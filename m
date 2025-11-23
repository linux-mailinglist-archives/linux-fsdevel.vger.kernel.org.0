Return-Path: <linux-fsdevel+bounces-69596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967BCC7E979
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 00:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F333A3E59
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 23:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4662701C4;
	Sun, 23 Nov 2025 23:23:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B7B2A1CF;
	Sun, 23 Nov 2025 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763940185; cv=none; b=g+WeIHXzQkVHWD7uRwKe3L5oPMKWEpQOZLU/nJQkJew7MeKPQ74MrTqUIHTcaaT2Lf3zgX7PXDgHMBtC7BDM1gnV4ORPpECMInKfVmvboyNXXfKBBsG5Gn5zEKzAVGfIcLEu4iU5NtsYsLL/azb83Dx4YR3CfV+raOEr3CPnupc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763940185; c=relaxed/simple;
	bh=E0bJzgneMHyXjq+X02QhPnT3P8kNjgP0/PSN87NvvfI=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=YwQTyN9HkTaiYuwx8HK8UTVLnBW54y/VO9moDBtXOEZeaLm3wB8xV9fApi10qehxEM6gt8+WIQi1PB3aEsQZjWOaOr1cUAwMoJ2hAlOGIxjmZ/DXzjN/9m1l8Z37hAQxY0rDOCC2AiabEkXVh6bFK5cnmnjLHZpLEsUDfztTpUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:44430)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vNJPq-000Vmp-5s; Sun, 23 Nov 2025 16:22:46 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:44852 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vNJPp-001fVL-4Z; Sun, 23 Nov 2025 16:22:45 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Bernd Edlinger <bernd.edlinger@hotmail.de>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Alexey Dobriyan <adobriyan@gmail.com>,  Kees
 Cook <kees@kernel.org>,  Andy Lutomirski <luto@amacapital.net>,  Will
 Drewry <wad@chromium.org>,  Christian Brauner <brauner@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  Michal Hocko
 <mhocko@suse.com>,  Serge Hallyn <serge@hallyn.com>,  James Morris
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
In-Reply-To: <aSNX5B9a5iSjJcM1@redhat.com> (Oleg Nesterov's message of "Sun,
	23 Nov 2025 19:52:20 +0100")
References: <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<GV2PPF74270EBEEE807D016A79FE7A2F463E4D6A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<87tsyozqdu.fsf@email.froward.int.ebiederm.org>
	<87wm3ky5n9.fsf@email.froward.int.ebiederm.org>
	<87h5uoxw06.fsf_-_@email.froward.int.ebiederm.org>
	<aSNX5B9a5iSjJcM1@redhat.com>
Date: Sun, 23 Nov 2025 17:22:36 -0600
Message-ID: <87tsykuyf7.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1vNJPp-001fVL-4Z;;;mid=<87tsykuyf7.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX188bdynm4AjSoejNdWJaikuesUTwrwxz14=
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  1.5 TR_Symld_Words too many words that have symbols inside
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 456 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 11 (2.4%), b_tie_ro: 10 (2.1%), parse: 1.00
	(0.2%), extract_message_metadata: 3.5 (0.8%), get_uri_detail_list:
	1.52 (0.3%), tests_pri_-2000: 2.9 (0.6%), tests_pri_-1000: 11 (2.4%),
	tests_pri_-950: 1.34 (0.3%), tests_pri_-900: 0.99 (0.2%),
	tests_pri_-90: 83 (18.3%), check_bayes: 82 (17.9%), b_tokenize: 18
	(3.9%), b_tok_get_all: 14 (3.0%), b_comp_prob: 4.2 (0.9%),
	b_tok_touch_all: 40 (8.8%), b_finish: 1.30 (0.3%), tests_pri_0: 325
	(71.2%), check_dkim_signature: 0.52 (0.1%), check_dkim_adsp: 2.6
	(0.6%), poll_dns_idle: 0.78 (0.2%), tests_pri_10: 1.96 (0.4%),
	tests_pri_500: 8 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] exec: Move cred computation under exec_update_lock
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: too long (recipient list exceeded maximum allowed size of 512 bytes)
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Oleg Nesterov <oleg@redhat.com> writes:

> Eric,
>
> sorry for delay, I am on PTO, didn't read emails this week...
>
> On 11/20, Eric W. Biederman wrote:
>>
>> Instead of computing the new cred before we pass the point of no
>> return compute the new cred just before we use it.
>>
>> This allows the removal of fs_struct->in_exec and cred_guard_mutex.
>>
>> I am not certain why we wanted to compute the cred for the new
>> executable so early.  Perhaps I missed something but I did not see any
>> common errors being signaled.   So I don't think we loose anything by
>> computing the new cred later.
>>
>> We gain a lot.
>
> Yes. I LIKE your approach after a quick glance. And I swear, I thought about
> it too ;)
>
> But is it correct? I don't know. I'll try to actually read your patch next
> week (I am on PTO untill the end of November), but I am not sure I can
> provide a valuable feedback.
>
> One "obvious" problem is that, after this patch, the execing process can crash
> in a case when currently exec() returns an error...

Yes.

I have been testing and looking at it, and I have found a few issues,
and I am trying to see if I can resolve them.

The good news is that with the advent of AT_EXECVE_CHECK we have a
really clear API boundary between errors that must be diagnosed
and errors of happenstance like running out of memory.

The bad news is that the implementation of AT_EXECVE_CHECK seems to been
rather hackish especially with respect to security_bprm_creds_for_exec.

What I am hoping for is to get the 3 causes of errors of brpm->unsafe
( LSM_UNSAFE_SHARE, LSM_UNSAFE_PTRACE, and LSM_UNSAFE_NO_NEW_PRIVS )
handled cleanly outside of the cred_guard_mutex, and simply
retested when it is time to build the credentials of the new process.

In practice that should get the same failures modes as we have now
but it would get SIGSEGV in rare instances where things changed
during exec.  That feels acceptable.



I thought of one other approach that might be enough to put the issue to
bed if cleaning up exec is too much work.  We could have ptrace_attach
use a trylock and fail when it doesn't succeed.  That would solve the
worst of the symptoms.

I think this would be a complete patch:

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 75a84efad40f..5dd2144e5789 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -444,7 +444,7 @@ static int ptrace_attach(struct task_struct *task, long request,
 	 * SUID, SGID and LSM creds get determined differently
 	 * under ptrace.
 	 */
-	scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR,
+	scoped_cond_guard (mutex_try, return -EAGAIN,
 			   &task->signal->cred_guard_mutex) {
 
 		scoped_guard (task_lock, task) {
-- 
2.41.0


Eric

