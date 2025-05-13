Return-Path: <linux-fsdevel+bounces-48912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C83AB598D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 18:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D6B189C7F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 16:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720F92BEC2B;
	Tue, 13 May 2025 16:16:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FA02EB1D;
	Tue, 13 May 2025 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747153000; cv=none; b=gweGf6yj/xQOyQRohtm5bHA+gRkVhH8A5bT/vKIXQ6x12Wumc+VvFuj4Cnw2qUqlFtjpAIZFaGR72G1aZ0CxK6ifX6NrAj7tfMy+g947DQLAd9uJWGfztiJhVu/YqGJSozsHhg/y164U9P6ZDpZ1b6/AicKp+oiweQPRwhZJbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747153000; c=relaxed/simple;
	bh=zV40bY8h3kW0Hy4xgRE4IG3svvmYOVPxkHpIL4ByJ/M=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=PAkTnORWSUEbaJ2hD2euZEPa9ZvZ/TJqV6W+loQRZ+q8pbySWpl5WrSw7KQkwb53JngDtHEIIuKN1Nr3kJAvhyFg5FPB3GsjvvlaIzuXEFRYRocd7ufFwoQFo6xYuTA3mVw1c1PTJRBZhFk2sBOnJuWEhJyd1LE2U1DvqVqRGYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:58534)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uEraV-0057bO-9O; Tue, 13 May 2025 09:30:35 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:59502 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uEraS-00FteB-TR; Tue, 13 May 2025 09:30:34 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,  Jann Horn <jannh@google.com>,
  Christian Brauner <brauner@kernel.org>,  Jorge Merlino
 <jorge.merlino@canonical.com>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Thomas Gleixner <tglx@linutronix.de>,  Andy Lutomirski <luto@kernel.org>,
  Sebastian Andrzej Siewior <bigeasy@linutronix.de>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-fsdevel@vger.kernel.org,  John Johansen
 <john.johansen@canonical.com>,  Paul Moore <paul@paul-moore.com>,  James
 Morris <jmorris@namei.org>,  "Serge E. Hallyn" <serge@hallyn.com>,
  Stephen Smalley <stephen.smalley.work@gmail.com>,  Eric Paris
 <eparis@parisplace.org>,  Richard Haines
 <richard_c_haines@btinternet.com>,  Casey Schaufler
 <casey@schaufler-ca.com>,  Xin Long <lucien.xin@gmail.com>,  "David S.
 Miller" <davem@davemloft.net>,  Todd Kjos <tkjos@google.com>,  Ondrej
 Mosnacek <omosnace@redhat.com>,  Prashanth Prahlad <pprahlad@redhat.com>,
  Micah Morton <mortonm@chromium.org>,  Fenghua Yu <fenghua.yu@intel.com>,
  Andrei Vagin <avagin@gmail.com>,  linux-kernel@vger.kernel.org,
  apparmor@lists.ubuntu.com,  linux-security-module@vger.kernel.org,
  selinux@vger.kernel.org,  linux-hardening@vger.kernel.org,
  oleg@redhat.com
In-Reply-To: <h65sagivix3zbrppthcobnysgnlrnql5shiu65xyg7ust6mc54@cliutza66zve>
	(Mateusz Guzik's message of "Tue, 13 May 2025 15:05:45 +0200")
References: <20221006082735.1321612-1-keescook@chromium.org>
	<20221006082735.1321612-2-keescook@chromium.org>
	<20221006090506.paqjf537cox7lqrq@wittgenstein>
	<CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com>
	<86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org>
	<h65sagivix3zbrppthcobnysgnlrnql5shiu65xyg7ust6mc54@cliutza66zve>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 13 May 2025 10:29:47 -0500
Message-ID: <87o6vw1qc4.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1uEraS-00FteB-TR;;;mid=<87o6vw1qc4.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+f5aQcvtD7cJuBfQzEABOE535sdGOGPWo=
X-Spam-Level: ****
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4970]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XMGenDplmaNmb Diploma spam phrases+possible phone number
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  1.0 XM_B_Phish_Phrases Commonly used Phishing Phrases
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Mateusz Guzik <mjguzik@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 787 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 11 (1.4%), b_tie_ro: 10 (1.2%), parse: 1.65
	(0.2%), extract_message_metadata: 21 (2.6%), get_uri_detail_list: 4.8
	(0.6%), tests_pri_-2000: 13 (1.6%), tests_pri_-1000: 6 (0.7%),
	tests_pri_-950: 1.33 (0.2%), tests_pri_-900: 1.08 (0.1%),
	tests_pri_-90: 143 (18.2%), check_bayes: 139 (17.7%), b_tokenize: 15
	(1.9%), b_tok_get_all: 14 (1.8%), b_comp_prob: 7 (0.8%),
	b_tok_touch_all: 99 (12.6%), b_finish: 0.93 (0.1%), tests_pri_0: 574
	(72.9%), check_dkim_signature: 0.63 (0.1%), check_dkim_adsp: 2.5
	(0.3%), poll_dns_idle: 0.46 (0.1%), tests_pri_10: 2.3 (0.3%),
	tests_pri_500: 10 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: too long (recipient list exceeded maximum allowed size of 512 bytes)
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Mateusz Guzik <mjguzik@gmail.com> writes:

> On Thu, Oct 06, 2022 at 08:25:01AM -0700, Kees Cook wrote:
>> On October 6, 2022 7:13:37 AM PDT, Jann Horn <jannh@google.com> wrote:
>> >On Thu, Oct 6, 2022 at 11:05 AM Christian Brauner <brauner@kernel.org> wrote:
>> >> On Thu, Oct 06, 2022 at 01:27:34AM -0700, Kees Cook wrote:
>> >> > The check_unsafe_exec() counting of n_fs would not add up under a heavily
>> >> > threaded process trying to perform a suid exec, causing the suid portion
>> >> > to fail. This counting error appears to be unneeded, but to catch any
>> >> > possible conditions, explicitly unshare fs_struct on exec, if it ends up
>> >>
>> >> Isn't this a potential uapi break? Afaict, before this change a call to
>> >> clone{3}(CLONE_FS) followed by an exec in the child would have the
>> >> parent and child share fs information. So if the child e.g., changes the
>> >> working directory post exec it would also affect the parent. But after
>> >> this change here this would no longer be true. So a child changing a
>> >> workding directoro would not affect the parent anymore. IOW, an exec is
>> >> accompanied by an unshare(CLONE_FS). Might still be worth trying ofc but
>> >> it seems like a non-trivial uapi change but there might be few users
>> >> that do clone{3}(CLONE_FS) followed by an exec.
>> >
>> >I believe the following code in Chromium explicitly relies on this
>> >behavior, but I'm not sure whether this code is in active use anymore:
>> >
>> >https://source.chromium.org/chromium/chromium/src/+/main:sandbox/linux/suid/sandbox.c;l=101?q=CLONE_FS&sq=&ss=chromium
>> 
>> Oh yes. I think I had tried to forget this existed. Ugh. Okay, so back to the drawing board, I guess. The counting will need to be fixed...
>> 
>> It's possible we can move the counting after dethread -- it seems the early count was just to avoid setting flags after the point of no return, but it's not an error condition...
>> 
>
> I landed here from git blame.
>
> I was looking at sanitizing shared fs vs suid handling, but the entire
> ordeal is so convoluted I'm confident the best way forward is to whack
> the problem to begin with.
>
> Per the above link, the notion of a shared fs struct across different
> processes is depended on so merely unsharing is a no-go.
>
> However, the shared state is only a problem for suid/sgid.
>
> Here is my proposal: *deny* exec of suid/sgid binaries if fs_struct is
> shared. This will have to be checked for after the execing proc becomes
> single-threaded ofc.
>
> While technically speaking this does introduce a change in behavior,
> there is precedent for doing it and seeing if anyone yells.
>
> With this in place there is no point maintainig ->in_exec or checking
> the flag.
>
> There is the known example of depending on shared fs_struct across exec.
> Hopefully there is no example of depending on execing a suid/sgid binary
> in such a setting -- it would be quite a weird setup given that for
> security reasons the perms must not be changed.
>
> The upshot of this method is that any breakage will be immediately
> visible in the form of a failed exec.
>
> Another route would be to do the mandatory unshare but only for
> suid/sgid, except that would have a hidden failure (if you will).
>
> Comments?

What is the problem that is trying to be fixed?

A uapi change to not allow sharing a fs_struct for processes that change
their cred on exec seems possible.

I said changing cred instead of suid/sgid because there are capabilities
and LSM labels that we probably want this to apply to as well.

I think such a limitation can be justified based upon having a shared
fs_struct is likely to allow confuse suid executables.


Earlier in the thread there was talk about the refcount for fs_struct.
I don't see that problem at the moment, and I don't see how dealing with
suid+sgid exectuables will have any bearing on how the refcount works.

Eric



