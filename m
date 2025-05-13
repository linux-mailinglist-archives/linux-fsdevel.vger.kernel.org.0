Return-Path: <linux-fsdevel+bounces-48920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0FBAB5F38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 00:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0382E3B3B08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 22:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0A720C485;
	Tue, 13 May 2025 22:17:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5801F2B83;
	Tue, 13 May 2025 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174654; cv=none; b=ZYwuVcsmLneYS2Pw3I10pYjvzC5rGM4j4Y5xg8VJplyP5CVKnuOyvadNHrjgoftINFU85J50UcMLSJomzOoHElBfJBq8rm0j/+ps+EFkFmrcRNwAj+892xUQ2Z3DXg9qlLV2aSlqo844W0J94MGs6qoy93EB5O4TPMR/rVZJDdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174654; c=relaxed/simple;
	bh=EqI+Zbf+yprFaOnpVj9CMNRe5vztGlLJaZ5wSl6b0nc=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=IC376gfu5/cNxtEZcrecJsqkN8pD9qTqnJS41lVbAE96Ww3F84uHI8UGgX7505sOUtLXQ04/ItVryTimtZDG2HYFSoDdB3YRKfRIdczQbsn+pN6Xuc84VqjfzeNns3L3I3nAJGWzj5agg+tgIJEPAdeqg8AbH/ttD+zObfKyB+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:44070)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uExwB-005sqC-Le; Tue, 13 May 2025 16:17:23 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:34512 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uExwA-004yCk-FO; Tue, 13 May 2025 16:17:23 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Jann Horn <jannh@google.com>
Cc: Kees Cook <kees@kernel.org>,  Mateusz Guzik <mjguzik@gmail.com>,  Kees
 Cook <keescook@chromium.org>,  Christian Brauner <brauner@kernel.org>,
  Jorge Merlino <jorge.merlino@canonical.com>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Thomas Gleixner <tglx@linutronix.de>,  Andy
 Lutomirski <luto@kernel.org>,  Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  Andrew Morton <akpm@linux-foundation.org>,
  linux-mm@kvack.org,  linux-fsdevel@vger.kernel.org,  John Johansen
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
References: <20221006082735.1321612-1-keescook@chromium.org>
	<20221006082735.1321612-2-keescook@chromium.org>
	<20221006090506.paqjf537cox7lqrq@wittgenstein>
	<CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com>
	<86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org>
	<h65sagivix3zbrppthcobnysgnlrnql5shiu65xyg7ust6mc54@cliutza66zve>
	<D03AE210-6874-43B6-B917-80CD259AE2AC@kernel.org>
	<CAG48ez0aP8LaGppy6Yon7xcFbQa1=CM-HXSZChvXYV2VJZ8y7g@mail.gmail.com>
Date: Tue, 13 May 2025 17:16:49 -0500
In-Reply-To: <CAG48ez0aP8LaGppy6Yon7xcFbQa1=CM-HXSZChvXYV2VJZ8y7g@mail.gmail.com>
	(Jann Horn's message of "Tue, 13 May 2025 23:09:48 +0200")
Message-ID: <871pss17hq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1uExwA-004yCk-FO;;;mid=<871pss17hq.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19MKpBmCOdib17JedfBy1DoBc7s2t+3dns=
X-Spam-Level: ****
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XMGenDplmaNmb Diploma spam phrases+possible phone number
	*  1.0 XM_B_Phish_Phrases Commonly used Phishing Phrases
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Jann Horn <jannh@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 686 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 11 (1.6%), b_tie_ro: 9 (1.4%), parse: 1.44 (0.2%),
	 extract_message_metadata: 6 (0.9%), get_uri_detail_list: 3.2 (0.5%),
	tests_pri_-2000: 3.5 (0.5%), tests_pri_-1000: 6 (0.8%),
	tests_pri_-950: 1.26 (0.2%), tests_pri_-900: 1.06 (0.2%),
	tests_pri_-90: 78 (11.4%), check_bayes: 77 (11.2%), b_tokenize: 14
	(2.1%), b_tok_get_all: 14 (2.0%), b_comp_prob: 4.6 (0.7%),
	b_tok_touch_all: 39 (5.8%), b_finish: 0.96 (0.1%), tests_pri_0: 551
	(80.4%), check_dkim_signature: 0.58 (0.1%), check_dkim_adsp: 3.4
	(0.5%), poll_dns_idle: 1.49 (0.2%), tests_pri_10: 2.3 (0.3%),
	tests_pri_500: 15 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: too long (recipient list exceeded maximum allowed size of 512 bytes)
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Jann Horn <jannh@google.com> writes:

> On Tue, May 13, 2025 at 10:57=E2=80=AFPM Kees Cook <kees@kernel.org> wrot=
e:
>> On May 13, 2025 6:05:45 AM PDT, Mateusz Guzik <mjguzik@gmail.com> wrote:
>> >Here is my proposal: *deny* exec of suid/sgid binaries if fs_struct is
>> >shared. This will have to be checked for after the execing proc becomes
>> >single-threaded ofc.
>>
>> Unfortunately the above Chrome helper is setuid and uses CLONE_FS.
>
> Chrome first launches a setuid helper, and then the setuid helper does
> CLONE_FS. Mateusz's proposal would not impact this usecase.
>
> Mateusz is proposing to block the case where a process first does
> CLONE_FS, and *then* one of the processes sharing the fs_struct does a
> setuid execve(). Linux already downgrades such an execve() to be
> non-setuid, which probably means anyone trying to do this will get
> hard-to-understand problems. Mateusz' proposal would just turn this
> hard-to-debug edgecase, which already doesn't really work, into a
> clean error; I think that is a nice improvement even just from the
> UAPI standpoint.
>
> If this change makes it possible to clean up the kernel code a bit, even =
better.

What has brought this to everyone's attention just now?  This is
the second mention of this code path I have seen this week.

AKA: security/commoncap.c:cap_bprm_creds_from_file(...)
> ...
> 	/* Don't let someone trace a set[ug]id/setpcap binary with the revised
> 	 * credentials unless they have the appropriate permit.
> 	 *
> 	 * In addition, if NO_NEW_PRIVS, then ensure we get no new privs.
> 	 */
> 	is_setid =3D __is_setuid(new, old) || __is_setgid(new, old);
>=20
> 	if ((is_setid || __cap_gained(permitted, new, old)) &&
> 	    ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
> 	     !ptracer_capable(current, new->user_ns))) {
> 		/* downgrade; they get no more than they had, and maybe less */
> 		if (!ns_capable(new->user_ns, CAP_SETUID) ||
> 		    (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)) {
> 			new->euid =3D new->uid;
> 			new->egid =3D new->gid;
> 		}
> 		new->cap_permitted =3D cap_intersect(new->cap_permitted,
> 						   old->cap_permitted);
> 	}

The actual downgrade is because a ptrace'd executable also takes
this path.

I have seen it argued rather forcefully that continuing rather than
simply failing seems better in the ptrace case.

In general I think it can be said this policy is "safe".  AKA we don't
let a shared fs struct confuse privileged applications.  So nothing
to panic about.

It looks like most of the lsm's also test bprm->unsafe.

So I imagine someone could very carefully separate the non-ptrace case
from the ptrace case but *shrug*.

Perhaps:

 	if ((is_setid || __cap_gained(permitted, new_old)) &&
 	    ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
 	     !ptracer_capable(current, new->user_ns))) {
+		if (!(bprm->unsafe & LSM_UNSAFE_PTRACE)) {
+			return -EPERM;
+		}
  		/* downgrade; they get no more than they had, and maybe less */
  		if (!ns_capable(new->user_ns, CAP_SETUID) ||
  		    (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)) {
  			new->euid =3D new->uid;
  			new->egid =3D new->gid;
  		}
  		new->cap_permitted =3D cap_intersect(new->cap_permitted,
  						   old->cap_permitted);
         }

If that is what you want that doesn't look to scary.  I don't think
it simplifies anything about fs->in_exec.  As fs->in_exec is set when
the processing calling exec is the only process that owns the fs_struct.
With fs->in_exec just being a flag that doesn't allow another thread
to call fork and start sharing the fs_struct during exec.

*Shrug*

I don't see why anyone would care.  It is just a very silly corner case.

Eric

