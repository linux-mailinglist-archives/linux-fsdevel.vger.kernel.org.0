Return-Path: <linux-fsdevel+bounces-48974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0916AB6FF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 17:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797311BA3D53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1DC27A925;
	Wed, 14 May 2025 15:35:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8D279347;
	Wed, 14 May 2025 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747236934; cv=none; b=b/e7GNgr+99BjUgWvLo3EF7pd646bjBi1EfyLvHkdrWebu2DhpHDaLXE55oIE4h12ltA1pyjG2iK190+aKMgZHoWH1zr8/aTD4PfPKxgBvuu/XJKyC2nS0sHBjFMX+CkyYQaGYZTbOw6T52zAGBSj5U5kBe/mpF7eAUk56eV/uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747236934; c=relaxed/simple;
	bh=TXsg3rVQI5EWEm9d4xVT7VoVWMCObXxtjMfP9Aj8Mwc=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=qa68tIL7SJgino6w6YBi662CI0kmhms0TAWdBQhjtNxeqnnZyhKZPod/6LDSXa1O4jpbcdVyfpvvp6a4nGAHjlLfHD2Ou1bGuAgSeH7w+vuVC32UREPLk5eL9C76mM8OCZ9P9WnvbZh90h/IvHnuWThQlCYrUTTSRr2biwwAeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:49888)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uFE8k-006uzG-UU; Wed, 14 May 2025 09:35:26 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:60158 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uFE8j-006IWS-AS; Wed, 14 May 2025 09:35:26 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jann Horn <jannh@google.com>,  Kees Cook <kees@kernel.org>,  Kees Cook
 <keescook@chromium.org>,  Christian Brauner <brauner@kernel.org>,  Jorge
 Merlino <jorge.merlino@canonical.com>,  Alexander Viro
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
	<871pss17hq.fsf@email.froward.int.ebiederm.org>
	<CAGudoHH-Jn5_4qnLV3qwzjTi2ZgfmfaO0qVSWW5gqdqkvchnDQ@mail.gmail.com>
Date: Wed, 14 May 2025 10:33:59 -0500
In-Reply-To: <CAGudoHH-Jn5_4qnLV3qwzjTi2ZgfmfaO0qVSWW5gqdqkvchnDQ@mail.gmail.com>
	(Mateusz Guzik's message of "Wed, 14 May 2025 02:03:31 +0200")
Message-ID: <87r00rw6jc.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1uFE8j-006IWS-AS;;;mid=<87r00rw6jc.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/oc8BJGiP9VT1ko+0pFzLuGtC4DPR/lYE=
X-Spam-Level: ******
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 T_XMDrugObfuBody_08 obfuscated drug references
	*  1.0 XM_B_Phish_Phrases Commonly used Phishing Phrases
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  1.0 XM_Body_Dirty_Words Contains a dirty word
	*  1.0 XMGenDplmaNmb Diploma spam phrases+possible phone number
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ******;Mateusz Guzik <mjguzik@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1099 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 11 (1.0%), b_tie_ro: 9 (0.8%), parse: 1.37 (0.1%),
	 extract_message_metadata: 15 (1.3%), get_uri_detail_list: 5.0 (0.5%),
	tests_pri_-2000: 12 (1.1%), tests_pri_-1000: 5 (0.5%), tests_pri_-950:
	1.18 (0.1%), tests_pri_-900: 0.95 (0.1%), tests_pri_-90: 159 (14.5%),
	check_bayes: 156 (14.2%), b_tokenize: 19 (1.7%), b_tok_get_all: 17
	(1.6%), b_comp_prob: 5 (0.5%), b_tok_touch_all: 107 (9.7%), b_finish:
	1.52 (0.1%), tests_pri_0: 879 (80.0%), check_dkim_signature: 0.83
	(0.1%), check_dkim_adsp: 3.2 (0.3%), poll_dns_idle: 1.28 (0.1%),
	tests_pri_10: 3.6 (0.3%), tests_pri_500: 8 (0.7%), rewrite_mail: 0.00
	(0.0%)
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: too long (recipient list exceeded maximum allowed size of 512 bytes)
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Mateusz Guzik <mjguzik@gmail.com> writes:

> On Wed, May 14, 2025 at 12:17=E2=80=AFAM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Jann Horn <jannh@google.com> writes:
>>
>> > On Tue, May 13, 2025 at 10:57=E2=80=AFPM Kees Cook <kees@kernel.org> w=
rote:
>> >> On May 13, 2025 6:05:45 AM PDT, Mateusz Guzik <mjguzik@gmail.com> wro=
te:
>> >> >Here is my proposal: *deny* exec of suid/sgid binaries if fs_struct =
is
>> >> >shared. This will have to be checked for after the execing proc beco=
mes
>> >> >single-threaded ofc.
>> >>
>> >> Unfortunately the above Chrome helper is setuid and uses CLONE_FS.
>> >
>> > Chrome first launches a setuid helper, and then the setuid helper does
>> > CLONE_FS. Mateusz's proposal would not impact this usecase.
>> >
>> > Mateusz is proposing to block the case where a process first does
>> > CLONE_FS, and *then* one of the processes sharing the fs_struct does a
>> > setuid execve(). Linux already downgrades such an execve() to be
>> > non-setuid, which probably means anyone trying to do this will get
>> > hard-to-understand problems. Mateusz' proposal would just turn this
>> > hard-to-debug edgecase, which already doesn't really work, into a
>> > clean error; I think that is a nice improvement even just from the
>> > UAPI standpoint.
>> >
>> > If this change makes it possible to clean up the kernel code a bit, ev=
en better.
>>
>> What has brought this to everyone's attention just now?  This is
>> the second mention of this code path I have seen this week.
>>
>
> There is a syzkaller report concerning ->in_exec handling, for example:
> https://lore.kernel.org/all/67dc67f0.050a0220.25ae54.001f.GAE@google.com/=
#t

Thanks that grounds the conversation.

I am trying to think how there could be a real race (and not a
theoretical race) between copy_fs and bprm_execve.

Unless I am missing something the write in bprm_execve to
current->fs->in_exec happens after the point of no-return
and de_thread.

Unless the exec fails without getting to de_thread, or
we are in the multi-threaded case.

So I think it would be sensible to do something like:

	/* Clear in_exec if we set it */
	if (!(bprm->unsafe & LSM_UNSAFE_SHARE)) {
		spin_lock(&current->fs->lock);
        	current->fs->in_exec =3D 0;
	        spin_unlock(&current->fs->lock);
        }

I expect that will cause KCSAN to be quiet as well as fixing
any real races that might happen when exec fails.

In all but the most extreme cases there should be no contention
on the lock so I don't see a downside of taking the fs->lock.

>> AKA: security/commoncap.c:cap_bprm_creds_from_file(...)
>> > ...
>> >       /* Don't let someone trace a set[ug]id/setpcap binary with the r=
evised
>> >        * credentials unless they have the appropriate permit.
>> >        *
>> >        * In addition, if NO_NEW_PRIVS, then ensure we get no new privs.
>> >        */
>> >       is_setid =3D __is_setuid(new, old) || __is_setgid(new, old);
>> >
>> >       if ((is_setid || __cap_gained(permitted, new, old)) &&
>> >           ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
>> >            !ptracer_capable(current, new->user_ns))) {
>> >               /* downgrade; they get no more than they had, and maybe =
less */
>> >               if (!ns_capable(new->user_ns, CAP_SETUID) ||
>> >                   (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)) {
>> >                       new->euid =3D new->uid;
>> >                       new->egid =3D new->gid;
>> >               }
>> >               new->cap_permitted =3D cap_intersect(new->cap_permitted,
>> >                                                  old->cap_permitted);
>> >       }
>>
>> The actual downgrade is because a ptrace'd executable also takes
>> this path.
>>
>> I have seen it argued rather forcefully that continuing rather than
>> simply failing seems better in the ptrace case.
>>
>> In general I think it can be said this policy is "safe".  AKA we don't
>> let a shared fs struct confuse privileged applications.  So nothing
>> to panic about.
>>
>> It looks like most of the lsm's also test bprm->unsafe.
>>
>> So I imagine someone could very carefully separate the non-ptrace case
>> from the ptrace case but *shrug*.
>>
>> Perhaps:
>>
>>         if ((is_setid || __cap_gained(permitted, new_old)) &&
>>             ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
>>              !ptracer_capable(current, new->user_ns))) {
>> +               if (!(bprm->unsafe & LSM_UNSAFE_PTRACE)) {
>> +                       return -EPERM;
>> +               }
>>                 /* downgrade; they get no more than they had, and maybe =
less */
>>                 if (!ns_capable(new->user_ns, CAP_SETUID) ||
>>                     (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)) {
>>                         new->euid =3D new->uid;
>>                         new->egid =3D new->gid;
>>                 }
>>                 new->cap_permitted =3D cap_intersect(new->cap_permitted,
>>                                                    old->cap_permitted);
>>          }
>>
>> If that is what you want that doesn't look to scary.  I don't think
>> it simplifies anything about fs->in_exec.  As fs->in_exec is set when
>> the processing calling exec is the only process that owns the fs_struct.
>> With fs->in_exec just being a flag that doesn't allow another thread
>> to call fork and start sharing the fs_struct during exec.
>>
>> *Shrug*
>>
>> I don't see why anyone would care.  It is just a very silly corner case.
>
> Well I don't see how ptrace factors into any of this, apart from being
> a different case of ignoring suid/sgid.

It is simple.  Ptrace is the case for ignoring suid/sgid, and since
that is the only case that is likely to happen in practice, and the
only case people actually care about everything all of the other cases
just got lumped on to ptrace case.

> I can agree the suid/sgid situation vs CLONE_FS is a silly corner
> case, but one which needs to be handled for security reasons and which
> currently has weirdly convoluted code to do it.
>
> The intent behind my proposal is very much to get the crapper out of
> the way in a future-proof and simple manner.
>
> In check_unsafe_exec() you can find a nasty loop over threads in the
> group to find out if the fs struct is used by anyone outside of said
> group. Since fs struct users are not explicitly tracked and any of
> them can have different creds than the current thread, the kernel opts
> to ignore suid/sgid if there are extra users found (for security
> reasons). The loop depends on no new threads showing up as the list is
> being walked, to that end copy_fs() can transiently return an error if
> it spots ->in_exec.
>
> The >in_exec field is used as a boolean/flag, but parallel execs using
> the same fs struct from different thread groups don't look serialized.
> This is supposed to be fine as in this case ->in_exec is not getting
> set to begin with, but it gets unconditionally unset on all execs.
>
> And so on. It's all weird af.
>
> Initially I was thinking about serializing all execs using a given
> fs_struct to bypass majority of the fuckery, but that's some churn to
> add and it still leaves possible breakage down the road -- should this
> unsafe sharing detection ever become racing nobody will find out until
> the bad guys have their turn with it.
>
> While unconditional unsharing turns out to be a no-go because of
> chrome, one can still do postpone detection until after the caller is
> single-threaded. By that time, if this is only the that thread and
> fs_struct has ->users =3D=3D 1, we know there is nobody sharing the struct
> or racing to add a ref to it. This allows treating ->users as a
> regular refcount, removes the weird loop over threads and removes the
> (at best misleading) ->in_exec field.

The problem is that after becoming single threaded there is no way to
fail the exec.  The process calling exec must be terminated, or
you drop privs as we currently do.

That terminating the process that calls exec absolutely sucks for
debug-ability, plus you are changing where the work happens which
means auditing all of the security hooks, which is pain.

So I really don't think we want to perform the test after de_thread.

> With this in place it becomes trivial to also *deny* suid/sgid exec
> instead of trying to placate it. If you are sharing fs and are execing
> a binary in the first place, things are a little fishy. But if you are
> execing a suid/sgid, the kernel has to ignore the bit so either you
> are doing something wrong or are trying to exploit a bug. In order to
> sort this crapper out, I think one can start with a runtime tunable
> and a once-per-boot printk stating it denied such an exec (and stating
> how to bring it back). To be removed some time after hitting LTS
> perhaps.

There is a potential cleanup here that is worth exploring.

Not allowing clone(CLONE_THREAD | CLONE_FS).  AKA forcing
all threads to share an fs_struct.

If we can do that then the reference to fs_struct can live in
signal_struct (potentially duplicated in current for performance).

Still that doesn't let us remove fs->in_exec.


Hmm..


The real issue is in_exec, and the convolutions it requires to maintain
it.

The simplest thing I can think of that doesn't meaningfully change
user-space behavior is to make any other calls to clone/fork and execve
fail with -EAGAIN, while our current execve is running.

In practice we already do that with clone/fork in copy_fs so we don't
need to worry about that case introducing regressions.

I can't see a meaningful use for racing calls of execve, so that
should not be a big deal.

That prevents any races with clearing the state if only one thread of a
process can be in execve at a time.

It would allow replacing both current->in_execve and
current->fs->in_exec.

We would probably use the sighand lock to protect whatever flag we use
in signal_struct.  We can't use signal->flags as we are going to want
to keep this separate from the de_thread and group exit logic.

....

Those are the directions I would suggest exploring if you want simplicity.

Eric

