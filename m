Return-Path: <linux-fsdevel+bounces-48923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F20F0AB6005
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 02:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D98861051
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 00:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715F24C85;
	Wed, 14 May 2025 00:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DATdbPta"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C9C19A;
	Wed, 14 May 2025 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747181027; cv=none; b=QiPA11YcsUz8FKUKnJF/pAWmpmccHd5NWYbS+KoCR4Z7Z2Bu95nuocLRGNxj7/sYuIz+a+5itIyV7/afg4h6AfMIZVfWtC8ABFn1gBBDRglShKsHEEBpNw3L/b3rK5JVtrQtqN9/0qQaNmqU3dnSbP7wGyDqPu7RIiy1h/Vw5FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747181027; c=relaxed/simple;
	bh=NzvvLdmlFhPXase6EuO/2IrU2MZi+iI7evphEgCmIx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tds1gpBmYtSj6wqY9H8bWvOfeVFNjPzg2QvMGiwezJzscGpEKVkFmz3amNsDAZAOsAvYMpdPYB7mOzzRHwS7QR64qN9df2pWtzSkBJnzEiK0ZJKdpfgzN2zqJbXU2xrOGr1nqnVnTZpuvJXktgHnoOEfxLupUYm990EqG18ICyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DATdbPta; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f6fb95f431so677756a12.0;
        Tue, 13 May 2025 17:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747181024; x=1747785824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lqSoGgVBEs4e77J4dvCBv01iW/I9gHcChJC6DVoY/E=;
        b=DATdbPta+VU+UKSs3fFENFrI/+k6Ai/8IxAe+ZcSfss8rtB/4ItrFqxos5X3Cv4qHW
         WeK6eM7qDkl9Su22Cvk/QJ8rulDuH5FE3dwLyiFShqG/5XFCeXrHm9nxw7X9YyTFYhJm
         FomSv+xQ6Qvg858NSfaj/RXCTGhM41MLoPDTD760KV0lMiUFm2I6G+ClOnRjmpMXOACw
         5UOBr6/GMtgSZtJxnKExlpEo5+8nh7gyEL7aI+uIcuVo569UcNHuPWPOPWPZ6pCdvqmP
         BF3drQ5mSXN9c+Ua0Lt396vc+fp7OReEioDDw3ODAlaOmdIKsD7YQcIanvkATP9GCSGx
         H40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747181024; x=1747785824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lqSoGgVBEs4e77J4dvCBv01iW/I9gHcChJC6DVoY/E=;
        b=jHjfceY25z4nI8A6B51aVOSSsqPqtRtT+VNtUCaq7VqsphdpgIF+gh4mhcT9mWLach
         t307iRLhLzwzUqNZAh78I9cKoPQVN7iZVzH/8I742q98wfbenxxfiHK8D+gNa/p5siK3
         AFWgCBfxMqnyiQhJbkug8eSUMKIoCiZ0wWBssBITHGCQiK2utCVMibxh9/W+evQexd+c
         nKxf2V7LRbK4lvEJikQC4yOeMcupnKpgcVUdoEIg2rnt/XBv7R2Ub34xN7znObFkZZhQ
         Ec5RSId0bBVbRODp42CqsUdZ2N9ezRUUU109YAUDmQAJdXYleEc53I3gPkLbCBjsp6BR
         HdMg==
X-Forwarded-Encrypted: i=1; AJvYcCUNZx54SZST5HaG2/6nMRJM108MuqFP7RkQhCdJa2sS0gW1Wdso0NdsfZxvMyTvEOsjXzwqSMzoaILouPpLM0KjYwvccvqu@vger.kernel.org, AJvYcCVO0fVCMPYjcnkS+kjRLhvUQ8yj5YDl7aE4f5o5T9Tfp/gks8W6aKdCaMPVHWblFESPMOTdQxzaDoBUzd8F@vger.kernel.org, AJvYcCWIlQWi2DqdKv6bnF730l6eIdGUMWE+ImZaZzFN7JvBzUwY1Ex3UOVff/DdETAJbpXK2wlwgYb61Q==@vger.kernel.org, AJvYcCWgq0g96/cAmnhUZHlRWR/IHk5ts7PKDtYiAOTbW+zHOOSCHolIRwsrydkee3Om+au1QRt0CvZiXuB9b2ao@vger.kernel.org, AJvYcCXMiI4HUJ9VUxc8ClmYimnE9nBH0ZpeKSePDtjEshwIo08xwTVJ2QWHf9pIY8brL1sVy74gxc6ZXP3Reyw3cMMa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2OHnsJyH/hb3xlWWAZtJ6oslkFDU46wI4C6Q2M1TytU+QboQc
	Sd11GsSEuZ7KrR6bPSKcIMLvtWwonZcDgu2mjr4hP6gbOJE08qJCAngfXjolkz2Ur0Ir0JMHZ01
	sDu0AwI2c3FEgABk9QJWSntb78vk=
X-Gm-Gg: ASbGncuGJsv7az8tlDNNvI+wBZQs9Fw7pS0R3IqxUuBsxyE3gX/o/eCRrJLMDM4Lmkl
	L41w36BaPKvaa6+JRR8dqYT29/mxg+0qP4y8lPLRL2VOHAJw0xcSyTiyJuF3lDyM8fc8F0UbR13
	PboiK+C8wEICf4Ew5JucSIu/9GO4tE73adUfD/ejes2w==
X-Google-Smtp-Source: AGHT+IGRlSkJ0UH4AJ6sv5ErNW8p3B/IKPPQ+Oz8ZXhFjDVyTM4z7WXblF2mhP+ITGzr1p9iVxs23uJFZScuNAmdKVU=
X-Received: by 2002:a17:907:1785:b0:ad2:cce:8d5e with SMTP id
 a640c23a62f3a-ad4f71dc930mr154641766b.7.1747181023932; Tue, 13 May 2025
 17:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221006082735.1321612-1-keescook@chromium.org>
 <20221006082735.1321612-2-keescook@chromium.org> <20221006090506.paqjf537cox7lqrq@wittgenstein>
 <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com>
 <86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org> <h65sagivix3zbrppthcobnysgnlrnql5shiu65xyg7ust6mc54@cliutza66zve>
 <D03AE210-6874-43B6-B917-80CD259AE2AC@kernel.org> <CAG48ez0aP8LaGppy6Yon7xcFbQa1=CM-HXSZChvXYV2VJZ8y7g@mail.gmail.com>
 <871pss17hq.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <871pss17hq.fsf@email.froward.int.ebiederm.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 14 May 2025 02:03:31 +0200
X-Gm-Features: AX0GCFst7wU9kVixjwdrqiox0NLTh4DbO3zQ5nACeNFmn77IHwc5Pm1sBQG733I
Message-ID: <CAGudoHH-Jn5_4qnLV3qwzjTi2ZgfmfaO0qVSWW5gqdqkvchnDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, Jorge Merlino <jorge.merlino@canonical.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, 
	Andy Lutomirski <luto@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Eric Paris <eparis@parisplace.org>, Richard Haines <richard_c_haines@btinternet.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Todd Kjos <tkjos@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Prashanth Prahlad <pprahlad@redhat.com>, 
	Micah Morton <mortonm@chromium.org>, Fenghua Yu <fenghua.yu@intel.com>, 
	Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-hardening@vger.kernel.org, oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 12:17=E2=80=AFAM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Jann Horn <jannh@google.com> writes:
>
> > On Tue, May 13, 2025 at 10:57=E2=80=AFPM Kees Cook <kees@kernel.org> wr=
ote:
> >> On May 13, 2025 6:05:45 AM PDT, Mateusz Guzik <mjguzik@gmail.com> wrot=
e:
> >> >Here is my proposal: *deny* exec of suid/sgid binaries if fs_struct i=
s
> >> >shared. This will have to be checked for after the execing proc becom=
es
> >> >single-threaded ofc.
> >>
> >> Unfortunately the above Chrome helper is setuid and uses CLONE_FS.
> >
> > Chrome first launches a setuid helper, and then the setuid helper does
> > CLONE_FS. Mateusz's proposal would not impact this usecase.
> >
> > Mateusz is proposing to block the case where a process first does
> > CLONE_FS, and *then* one of the processes sharing the fs_struct does a
> > setuid execve(). Linux already downgrades such an execve() to be
> > non-setuid, which probably means anyone trying to do this will get
> > hard-to-understand problems. Mateusz' proposal would just turn this
> > hard-to-debug edgecase, which already doesn't really work, into a
> > clean error; I think that is a nice improvement even just from the
> > UAPI standpoint.
> >
> > If this change makes it possible to clean up the kernel code a bit, eve=
n better.
>
> What has brought this to everyone's attention just now?  This is
> the second mention of this code path I have seen this week.
>

There is a syzkaller report concerning ->in_exec handling, for example:
https://lore.kernel.org/all/67dc67f0.050a0220.25ae54.001f.GAE@google.com/#t

> AKA: security/commoncap.c:cap_bprm_creds_from_file(...)
> > ...
> >       /* Don't let someone trace a set[ug]id/setpcap binary with the re=
vised
> >        * credentials unless they have the appropriate permit.
> >        *
> >        * In addition, if NO_NEW_PRIVS, then ensure we get no new privs.
> >        */
> >       is_setid =3D __is_setuid(new, old) || __is_setgid(new, old);
> >
> >       if ((is_setid || __cap_gained(permitted, new, old)) &&
> >           ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
> >            !ptracer_capable(current, new->user_ns))) {
> >               /* downgrade; they get no more than they had, and maybe l=
ess */
> >               if (!ns_capable(new->user_ns, CAP_SETUID) ||
> >                   (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)) {
> >                       new->euid =3D new->uid;
> >                       new->egid =3D new->gid;
> >               }
> >               new->cap_permitted =3D cap_intersect(new->cap_permitted,
> >                                                  old->cap_permitted);
> >       }
>
> The actual downgrade is because a ptrace'd executable also takes
> this path.
>
> I have seen it argued rather forcefully that continuing rather than
> simply failing seems better in the ptrace case.
>
> In general I think it can be said this policy is "safe".  AKA we don't
> let a shared fs struct confuse privileged applications.  So nothing
> to panic about.
>
> It looks like most of the lsm's also test bprm->unsafe.
>
> So I imagine someone could very carefully separate the non-ptrace case
> from the ptrace case but *shrug*.
>
> Perhaps:
>
>         if ((is_setid || __cap_gained(permitted, new_old)) &&
>             ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
>              !ptracer_capable(current, new->user_ns))) {
> +               if (!(bprm->unsafe & LSM_UNSAFE_PTRACE)) {
> +                       return -EPERM;
> +               }
>                 /* downgrade; they get no more than they had, and maybe l=
ess */
>                 if (!ns_capable(new->user_ns, CAP_SETUID) ||
>                     (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)) {
>                         new->euid =3D new->uid;
>                         new->egid =3D new->gid;
>                 }
>                 new->cap_permitted =3D cap_intersect(new->cap_permitted,
>                                                    old->cap_permitted);
>          }
>
> If that is what you want that doesn't look to scary.  I don't think
> it simplifies anything about fs->in_exec.  As fs->in_exec is set when
> the processing calling exec is the only process that owns the fs_struct.
> With fs->in_exec just being a flag that doesn't allow another thread
> to call fork and start sharing the fs_struct during exec.
>
> *Shrug*
>
> I don't see why anyone would care.  It is just a very silly corner case.

Well I don't see how ptrace factors into any of this, apart from being
a different case of ignoring suid/sgid.

I can agree the suid/sgid situation vs CLONE_FS is a silly corner
case, but one which needs to be handled for security reasons and which
currently has weirdly convoluted code to do it.

The intent behind my proposal is very much to get the crapper out of
the way in a future-proof and simple manner.

In check_unsafe_exec() you can find a nasty loop over threads in the
group to find out if the fs struct is used by anyone outside of said
group. Since fs struct users are not explicitly tracked and any of
them can have different creds than the current thread, the kernel opts
to ignore suid/sgid if there are extra users found (for security
reasons). The loop depends on no new threads showing up as the list is
being walked, to that end copy_fs() can transiently return an error if
it spots ->in_exec.

The >in_exec field is used as a boolean/flag, but parallel execs using
the same fs struct from different thread groups don't look serialized.
This is supposed to be fine as in this case ->in_exec is not getting
set to begin with, but it gets unconditionally unset on all execs.

And so on. It's all weird af.

Initially I was thinking about serializing all execs using a given
fs_struct to bypass majority of the fuckery, but that's some churn to
add and it still leaves possible breakage down the road -- should this
unsafe sharing detection ever become racing nobody will find out until
the bad guys have their turn with it.

While unconditional unsharing turns out to be a no-go because of
chrome, one can still do postpone detection until after the caller is
single-threaded. By that time, if this is only the that thread and
fs_struct has ->users =3D=3D 1, we know there is nobody sharing the struct
or racing to add a ref to it. This allows treating ->users as a
regular refcount, removes the weird loop over threads and removes the
(at best misleading) ->in_exec field.

With this in place it becomes trivial to also *deny* suid/sgid exec
instead of trying to placate it. If you are sharing fs and are execing
a binary in the first place, things are a little fishy. But if you are
execing a suid/sgid, the kernel has to ignore the bit so either you
are doing something wrong or are trying to exploit a bug. In order to
sort this crapper out, I think one can start with a runtime tunable
and a once-per-boot printk stating it denied such an exec (and stating
how to bring it back). To be removed some time after hitting LTS
perhaps.

--=20
Mateusz Guzik <mjguzik gmail.com>

