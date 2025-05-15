Return-Path: <linux-fsdevel+bounces-49161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F04AB8CCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 18:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F58B3B9A9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 16:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C9D253F05;
	Thu, 15 May 2025 16:48:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5BE72638;
	Thu, 15 May 2025 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327702; cv=none; b=Qoe2eK7r3rcknE+ZhneTEcKOxjlqA52y94dk0Iqi0Q7tmh/HOBu3pnfKOfiuKbIk3NNoo9Q8jU3jViYZDVpbZTuhaL4RsbyW/RoUgFfrsO8pdMH2R5P7GjkApZvFm1MmXfhXYTpY/4NPU8xNSWrrjd0voY9eylEFIf2+ZsHlKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327702; c=relaxed/simple;
	bh=ajLCurLFo3eANTDUWWiiZgG4NaMGIOdM5yB4dSWeAs0=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=ah5HHWDxxCpMtGFpXK13HxEqriMEX07NTJCf5ak/MPMrmgWAN8tWl7taVSjqCSAbd4frv/3UEWnufGCN3kjKiz24iyf7obE60e8s+mUMyPULiKD1QBEfAsxHw3XkqvkQd/0+MJ7juiu/vNh7MWVsc7EqNpqdiwoNV2pMhV+iTiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:52516)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uFbko-008tj4-0n; Thu, 15 May 2025 10:48:18 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:60030 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uFbkm-008mIa-JT; Thu, 15 May 2025 10:48:17 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Kees Cook <kees@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>,  Jann Horn <jannh@google.com>,
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
References: <20221006082735.1321612-1-keescook@chromium.org>
	<20221006082735.1321612-2-keescook@chromium.org>
	<20221006090506.paqjf537cox7lqrq@wittgenstein>
	<CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com>
	<86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org>
	<h65sagivix3zbrppthcobnysgnlrnql5shiu65xyg7ust6mc54@cliutza66zve>
	<D03AE210-6874-43B6-B917-80CD259AE2AC@kernel.org>
	<CAG48ez0aP8LaGppy6Yon7xcFbQa1=CM-HXSZChvXYV2VJZ8y7g@mail.gmail.com>
	<871pss17hq.fsf@email.froward.int.ebiederm.org>
	<CAGudoHH-Jn5_4qnLV3qwzjTi2ZgfmfaO0qVSWW5gqdqkvchnDQ@mail.gmail.com>
	<202505140822.6AB755B6@keescook>
Date: Thu, 15 May 2025 11:48:07 -0500
In-Reply-To: <202505140822.6AB755B6@keescook> (Kees Cook's message of "Wed, 14
	May 2025 08:42:22 -0700")
Message-ID: <87bjrtrfaw.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1uFbkm-008mIa-JT;;;mid=<87bjrtrfaw.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/dsw9mCdXAA3N8gGK7mkVPwWeN8eQaLZ4=
X-Spam-Level: ***
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XMGenDplmaNmb Diploma spam phrases+possible phone number
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Kees Cook <kees@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 883 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 8 (1.0%), b_tie_ro: 7 (0.8%), parse: 1.28 (0.1%),
	extract_message_metadata: 15 (1.7%), get_uri_detail_list: 3.6 (0.4%),
	tests_pri_-2000: 27 (3.1%), tests_pri_-1000: 7 (0.8%), tests_pri_-950:
	1.59 (0.2%), tests_pri_-900: 1.27 (0.1%), tests_pri_-90: 93 (10.6%),
	check_bayes: 91 (10.3%), b_tokenize: 22 (2.5%), b_tok_get_all: 14
	(1.6%), b_comp_prob: 8 (0.9%), b_tok_touch_all: 40 (4.5%), b_finish:
	1.39 (0.2%), tests_pri_0: 667 (75.5%), check_dkim_signature: 0.85
	(0.1%), check_dkim_adsp: 3.6 (0.4%), poll_dns_idle: 1.32 (0.1%),
	tests_pri_10: 2.4 (0.3%), tests_pri_500: 56 (6.3%), rewrite_mail: 0.00
	(0.0%)
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: too long (recipient list exceeded maximum allowed size of 512 bytes)
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Kees Cook <kees@kernel.org> writes:

> On Wed, May 14, 2025 at 02:03:31AM +0200, Mateusz Guzik wrote:
>> On Wed, May 14, 2025 at 12:17=E2=80=AFAM Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>> >
>> > Jann Horn <jannh@google.com> writes:
>> >
>> > > On Tue, May 13, 2025 at 10:57=E2=80=AFPM Kees Cook <kees@kernel.org>=
 wrote:
>> > >> On May 13, 2025 6:05:45 AM PDT, Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>> > >> >Here is my proposal: *deny* exec of suid/sgid binaries if fs_struc=
t is
>> > >> >shared. This will have to be checked for after the execing proc be=
comes
>> > >> >single-threaded ofc.
>> > >>
>> > >> Unfortunately the above Chrome helper is setuid and uses CLONE_FS.
>> > >
>> > > Chrome first launches a setuid helper, and then the setuid helper do=
es
>> > > CLONE_FS. Mateusz's proposal would not impact this usecase.
>> > >
>> > > Mateusz is proposing to block the case where a process first does
>> > > CLONE_FS, and *then* one of the processes sharing the fs_struct does=
 a
>> > > setuid execve(). Linux already downgrades such an execve() to be
>> > > non-setuid, which probably means anyone trying to do this will get
>> > > hard-to-understand problems. Mateusz' proposal would just turn this
>> > > hard-to-debug edgecase, which already doesn't really work, into a
>> > > clean error; I think that is a nice improvement even just from the
>> > > UAPI standpoint.
>> > >
>> > > If this change makes it possible to clean up the kernel code a bit, =
even better.
>> >
>> > What has brought this to everyone's attention just now?  This is
>> > the second mention of this code path I have seen this week.
>> >
>>=20
>> There is a syzkaller report concerning ->in_exec handling, for example:
>> https://lore.kernel.org/all/67dc67f0.050a0220.25ae54.001f.GAE@google.com=
/#t
>>
>> [...]
>> > It looks like most of the lsm's also test bprm->unsafe.
>> >
>> > So I imagine someone could very carefully separate the non-ptrace case
>> > from the ptrace case but *shrug*.
>> >
>> > Perhaps:
>> >
>> >         if ((is_setid || __cap_gained(permitted, new_old)) &&
>> >             ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
>> >              !ptracer_capable(current, new->user_ns))) {
>> > +               if (!(bprm->unsafe & LSM_UNSAFE_PTRACE)) {
>> > +                       return -EPERM;
>> > +               }
>> >                 /* downgrade; they get no more than they had, and mayb=
e less */
>> >                 if (!ns_capable(new->user_ns, CAP_SETUID) ||
>> >                     (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)) {
>> >                         new->euid =3D new->uid;
>> >                         new->egid =3D new->gid;
>> >                 }
>> >                 new->cap_permitted =3D cap_intersect(new->cap_permitte=
d,
>> >                                                    old->cap_permitted);
>> >          }
>> >
>> > If that is what you want that doesn't look to scary.  I don't think
>> > it simplifies anything about fs->in_exec.  As fs->in_exec is set when
>> > the processing calling exec is the only process that owns the fs_struc=
t.
>> > With fs->in_exec just being a flag that doesn't allow another thread
>> > to call fork and start sharing the fs_struct during exec.
>> >
>> > *Shrug*
>> >
>> > I don't see why anyone would care.  It is just a very silly corner cas=
e.
>>=20
>> Well I don't see how ptrace factors into any of this, apart from being
>> a different case of ignoring suid/sgid.
>
> I actually think we might want to expand the above bit of logic to use
> an explicit tests of each LSM_UNSAFE case -- the merged
> logic is very difficult to read currently. Totally untested expansion,
> if I'm reading everything correctly:
>
> 	if (bprm->unsafe &&
> 	    (is_setid || __cap_gained(permitted, new_old))) {
> 		bool limit_caps =3D false;
> 		bool strip_eid =3D false;
> 		unsigned int unsafe =3D bprm->unsafe;
> 		/* Check each bit */
>
> 		if (unsafe & LSM_UNSAFE_PTRACE) {
> 			if (!ptracer_capable(current, new->user_ns))
> 				limit_caps =3D true;
                                strip_eid  =3D true;
You missed the euid stripping there.
> 			unsafe &=3D ~LSM_UNSAFE_PTRACE;
> 		}
> 		if (unsafe & LSM_UNSAFE_SHARE) {
> 			limit_caps =3D true;
> 			if (!ns_capable(new->user_ns, CAP_SETUID))
> 				strip_eid =3D true;
> 			unsafe &=3D ~LSM_UNSAFE_SHARE;
> 		}
> 		if (unsafe & LSM_UNSAFE_NO_NEW_PRIVS) {
> 			limit_caps =3D true;
> 			if (!ns_capable(new->user_ns, CAP_SETUID))
> 				strip_eid =3D true;
> 			unsafe &=3D ~LSM_UNSAFE_NO_NEW_PRIVS;
> 		}
>
> 		if (WARN(unsafe, "Unhandled LSM_UNSAFE flag: %u?!\n", unsafe))
> 			return -EINVAL;
>
> 		if (limit_caps) {
> 			new->cap_permitted =3D cap_intersect(new->cap_permitted,
> 							   old->cap_permitted);
> 		}
> 		if (strip_eid) {
> 			new->euid =3D new->uid;
> 			new->egid =3D new->gid;
> 		}
> 	}


I think I would simplify this all to:

	if ((id_changed || __cap_gained(permitted, new, old)) &&
            !ptracer_capable(current->new_user_ns)) {
        	if (!ns_capable(new->user_ns, CAP_SETUID)) {
                	new->euid =3D old->euid;
                        new->egid =3D old->egid;
                }
                new->cap_permitted =3D cap_intersect(new->cap_permitted,
                				   old->cap_permitted);
        }
        if ((id_changed || __cap_gained(permitted, new, old)) &&
            (bprm->unsafe & ~LSM_UNSAFE_PTRACE)) {
        	return -EPERM;
        }

The code of no_new_privs doesn't prevent capset so ignoring the results
of ns_capable when NO_NEW_PRIVS is set doesn't make sense.

If we are going to do anything please let's find ways to understand
what is happening and simplify this code, not add to it's complexity.

Eric

