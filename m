Return-Path: <linux-fsdevel+bounces-70356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1687C9845D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 17:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEB3A4E26C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA50B335085;
	Mon,  1 Dec 2025 16:34:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705CC3346AC;
	Mon,  1 Dec 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606840; cv=none; b=JpxkdQGUWdFp88D3NW4VuHDfERd63Gnw5X+UYu9I0dZPvK3XO4vx+9hOkKbyT8EYnHesQtCyQTIjWJcIXLkTCZ+NFwPH2VE0+1A1/G+XrEr+gZOmaMTR1BHaD3DRODbTrNmOZFGSoEOu3Wka7O1h3H/VFXHniDDKektMam87vUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606840; c=relaxed/simple;
	bh=KKXMY60fzcmlXfqjSzlbbHZRwQdsCfygDV9sIcYYUxc=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=KBVUkvWQcqVf/8swYjk1Kt9Zij1FqPlb9pNgdE3JMv3wfHLPe6ZT6Srs1goA12UuNsALKoVEZzPk/cRwEA0RvVe/azol5Ooxvfx/4pg97WivOyypC6TOdpboDgKr43JPg09shwsJxQ86BgUJIzzC6Kp7tXpCrmqiSt3jhdOqWpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:50512)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vQ6Pi-009mGN-1t; Mon, 01 Dec 2025 09:06:10 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:40282 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vQ6Pg-00Cg1V-BQ; Mon, 01 Dec 2025 09:06:09 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Bernd Edlinger <bernd.edlinger@hotmail.de>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Alexey Dobriyan <adobriyan@gmail.com>,  Oleg
 Nesterov <oleg@redhat.com>,  Kees Cook <kees@kernel.org>,  Andy Lutomirski
 <luto@amacapital.net>,  Will Drewry <wad@chromium.org>,  Christian Brauner
 <brauner@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  Michal
 Hocko <mhocko@suse.com>,  Serge Hallyn <serge@hallyn.com>,  James Morris
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
 Dumazet <edumazet@google.com>,  zohar@linux.ibm.com,
  linux-integrity@vger.kernel.org,  Ryan Lee <ryan.lee@canonical.com>,
 apparmor <apparmor@lists.ubuntu.com> 
In-Reply-To: <6dc556a0a93c18fffec71322bf97441c74b3134e.camel@huaweicloud.com>
	(Roberto Sassu's message of "Tue, 25 Nov 2025 12:55:00 +0100")
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
	<6dc556a0a93c18fffec71322bf97441c74b3134e.camel@huaweicloud.com>
Date: Mon, 01 Dec 2025 10:06:00 -0600
Message-ID: <87v7iqtcev.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1vQ6Pg-00Cg1V-BQ;;;mid=<87v7iqtcev.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/O4IKUzWWwapDxt1axB69s37nkia9NNac=
X-Spam-Level: ****
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  1.0 XMGappySubj_02 Gappier still
	*  0.5 XMGappySubj_01 Very gappy subject
	*  1.2 XM_Multi_Part_URI URI: Long-Multi-Part URIs
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XM_B_Phish_Phrases Commonly used Phishing Phrases
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
	*  0.5 TR_AI_Phishing Email matches multiple AI-related patterns
	*  0.0 TR_XM_PhishingBody Phishing flag in body of message
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Roberto Sassu <roberto.sassu@huaweicloud.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 576 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 2.8 (0.5%), b_tie_ro: 1.85 (0.3%), parse: 1.32
	(0.2%), extract_message_metadata: 17 (2.9%), get_uri_detail_list: 2.5
	(0.4%), tests_pri_-2000: 24 (4.1%), tests_pri_-1000: 14 (2.5%),
	tests_pri_-950: 1.46 (0.3%), tests_pri_-900: 1.33 (0.2%),
	tests_pri_-90: 118 (20.4%), check_bayes: 116 (20.1%), b_tokenize: 24
	(4.1%), b_tok_get_all: 11 (1.9%), b_comp_prob: 3.5 (0.6%),
	b_tok_touch_all: 74 (12.9%), b_finish: 0.62 (0.1%), tests_pri_0: 385
	(66.9%), check_dkim_signature: 0.44 (0.1%), check_dkim_adsp: 2.7
	(0.5%), poll_dns_idle: 0.61 (0.1%), tests_pri_10: 1.64 (0.3%),
	tests_pri_500: 7 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Are setuid shell scripts safe? (Implied by
 security_bprm_creds_for_exec)
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: too long (recipient list exceeded maximum allowed size of 512 bytes)
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Roberto Sassu <roberto.sassu@huaweicloud.com> writes:

> + Mimi, linux-integrity (would be nice if we are in CC when linux-
> security-module is in CC).
>
> Apologies for not answering earlier, it seems I don't receive the
> emails from the linux-security-module mailing list (thanks Serge for
> letting me know!).
>
> I see two main effects of this patch. First, the bprm_check_security
> hook implementations will not see bprm->cred populated. That was a
> problem before we made this patch:
>
> https://patchew.org/linux/20251008113503.2433343-1-roberto.sassu@huaweicloud.com/

Thanks, that is definitely needed.

Does calling process_measurement(CREDS_CHECK) on only the final file
pass review?  Do you know of any cases where that will break things?

As it stands I don't think it should be assumed that any LSM has
computed it's final creds until bprm_creds_from_file.  Not just the
uid and gid.

If the patch you posted for review works that helps sort that mess out.

> to work around the problem of not calculating the final DAC credentials
> early enough (well, we actually had to change our CREDS_CHECK hook
> behavior).
>
> The second, I could not check. If I remember well, unlike the
> capability LSM, SELinux/Apparmor/SMACK calculate the final credentials
> based on the first file being executed (thus the script, not the
> interpreter). Is this patch keeping the same behavior despite preparing
> the credentials when the final binary is found?

The patch I posted was.

My brain is still reeling from the realization that our security modules
have the implicit assumption that it is safe to calculate their security
information from shell scripts.

In the first half of the 90's I remember there was lots of effort to try
and make setuid shell scripts and setuid perl scripts work, and the
final conclusion was it was a lost cause.

Now I look at security_bprm_creds_for_exec and security_bprm_check which
both have the implicit assumption that it is indeed safe to compute the
credentials from a shell script.

When passing a file descriptor to execat we have
BINPRM_FLAGS_PATH_INACCESSIBLE and use /dev/fd/NNN as the filename
which reduces some of the races.

However when just plain executing a shell script we pass the filename of
the shell script as a command line argument, and expect the shell to
open the filename again.  This has been a time of check to time of use
race for decades, and one of the reasons we don't have setuid shell
scripts.

Yet the IMA implementation (without the above mentioned patch) assumes
the final creds will be calculated before security_bprm_check is called,
and security_bprm_creds_for_exec busily calculate the final creds.

For some of the security modules I believe anyone can set any label they
want on a file and they remain secure (At which point I don't understand
the point of having labels on files).  I don't believe that is the case
for selinux, or in general.

So just to remove the TOCTOU race the security_bprm_creds_for_exec
and security_bprm_check hooks need to be removed, after moving their
code into something like security_bprm_creds_from_file.

Or am I missing something and even with the TOCTOU race are setuid shell
scripts somehow safe now?

Eric

