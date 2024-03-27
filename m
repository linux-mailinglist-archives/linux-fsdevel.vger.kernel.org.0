Return-Path: <linux-fsdevel+bounces-15479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6828388F119
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 22:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA521C29DAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 21:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C7F153591;
	Wed, 27 Mar 2024 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXmyyNGr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271C1514FD;
	Wed, 27 Mar 2024 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575712; cv=none; b=SyGF6PEmAHbTBTqHyZfkYMCVNwNXaPD0mbG/Vio9ZGcZuGAKlbPodyzjTt8Y6fvBwCgNyZoyJwqU3+H9CE8HAnab6s9d/b8BjIFoH+WjY3qz6Gd3D24KD7+2C3NoU+NA0xwPpQAjTAbOQsGCgoBL7/v9GV1yGrai1fZIMPTnpV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575712; c=relaxed/simple;
	bh=jmyWyMGFwOtdmdQNcIkC5X3aKzO5r8vG4Waa5MjtpDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLXQrTDv4Y/QwkQs9SgAiQJTGDPG/kWhzQFH8ugj+hrcGYQVZ6ZzEx2oi/EGM+UjNEfnop+CTPCzghAPFlqC0z/LUc+qWLG6zypJJAUOb3ZjP8WLIRFqIZOR92o+u9Uwf+W2v5+T/x937GbecOfVWmkcZrifI+ga/NfC1rAsB3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXmyyNGr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34005b5927eso141100f8f.1;
        Wed, 27 Mar 2024 14:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711575709; x=1712180509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzkPeJjBZryBqMmL4486tp2idMhhYHpknALnqkob6rs=;
        b=YXmyyNGrE372EMwKscYn+ImMASKT030Pb23kcQqRdrH/X/L1S3Q7OWZa728MhckVKO
         8D1Jxdmu08QowZ7zuiFs+F9JYPS/lgs0or6iSAib55NkzqrbDsTCeRlBVgiDkv714JaN
         /ddOHxVD6O+1ESAXC+y9nsCZ9ovxGU1FKgl3SNK/3NTn0DD6/iveHxYiFkUj+3e6cD1U
         S8SjvqT29XSE4bsVJqhn8u5Mx3JB/mp1fgmjhZ5Hejc6XfkqIFVzZ6aAfXakf8QAbmMP
         CA0SZEMY4mx+BcIK+rpKMA9f6WqJu8dHofsf+R8XP7UTKclK2GhgTlFYiu9INHfMbZF2
         Aaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575709; x=1712180509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzkPeJjBZryBqMmL4486tp2idMhhYHpknALnqkob6rs=;
        b=Nw0RyJZqljoG4FrX5AmQjLZgbVwQAS0CLqu+gkjy9g853nUDIq3TawIVguSpGbrk1/
         FHvqRFDX9frDKe+kF53qfQ6UkB6BZeOC566Ww4qmf2Fw2AvZ3HAqN2RPqUUKSZ/zibrl
         tXUSCT21aqPLskvQdPDX1TY5z1Hxm5k31aDwPIueRKETXqWXA+RfVpADHtOkKH+8gYG7
         asvvw8VA7weOgJhN+8b0fL5Q+nHwXiF0MfUFG+liIZxbUtD9ctoXBsPXinhqnTCLJQr7
         fhn/U2l1lUOIW8XFOJbVr1yi+R8aQeEyqkFYlMJn81eCkMGHeo2Oo8W7XC/yKoOf06rb
         jm0w==
X-Forwarded-Encrypted: i=1; AJvYcCXZKwePwrd2xTq7TdYFy+auUn+Un6zkCw9lDwn4QJtnvfN6LEuYt9JzynvMVheAKbIzTmyJjVTB6JBSBy+XQG3yHX47ZAuNDIeywHMRDJd4cgXCEo++ImRssOnwkL9w6XDQLm9XauRSv75bopEYd3MHMqRbqbg/4xkH4/w1MBPBF1WKmekYEklALA==
X-Gm-Message-State: AOJu0Yyi6peQyrL3C+dY/XH5NDlUprAi18Da64j1rVHoTlGxMCggYfRl
	VWTQJeFL9cnO4FRMlt4Sq6aF5bVbTIiI3JRZAefXIL6Fzi9iKzZfWSQ1PjEwLyESasmoG9QjlxP
	K13MuJB+dgsGNXjBT72DBXEKKrFY=
X-Google-Smtp-Source: AGHT+IH8bsjkbEPq5nFZa25RNEBMUp4NHKWgJkZvhsLEiO/AS+v/zIitCzEw8DN2gbwGn9LjyHANzGigswDNTFCf8qM=
X-Received: by 2002:a05:6000:b04:b0:33e:40a3:22c8 with SMTP id
 dj4-20020a0560000b0400b0033e40a322c8mr425338wrb.33.1711575708527; Wed, 27 Mar
 2024 14:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709675979.git.mattbobrowski@google.com>
 <20240306-flach-tragbar-b2b3c531bf0d@brauner> <20240306-sandgrube-flora-a61409c2f10c@brauner>
 <CAADnVQ+RBV_rJx5LCtCiW-TWZ5DCOPz1V3ga_fc__RmL_6xgOg@mail.gmail.com>
 <20240307-phosphor-entnahmen-8ef28b782abf@brauner> <CAADnVQLMHdL1GfScnG8=0wL6PEC=ACZT3xuuRFrzNJqHKrYvsw@mail.gmail.com>
 <20240308-kleben-eindecken-73c993fb3ebd@brauner> <CAADnVQJVNntnH=DLHwUioe9mEw0FzzdUvmtj3yx8SjL38daeXQ@mail.gmail.com>
 <20240311-geglaubt-kursverfall-500a27578cca@brauner> <CAADnVQLnzrxyUM-EiorEP_qvfmdiSK5Kj1WtGjFoAogygHSvmA@mail.gmail.com>
 <20240318-individual-gekennzeichnet-1658fcb8bf27@brauner>
In-Reply-To: <20240318-individual-gekennzeichnet-1658fcb8bf27@brauner>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Mar 2024 14:41:36 -0700
Message-ID: <CAADnVQ+noVorD70rmtESE3MkDHnkQgraNNBCadJ=0x6-nBwhvA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/9] add new acquire/release BPF kfuncs
To: Christian Brauner <brauner@kernel.org>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@google.com>, 
	Jann Horn <jannh@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 6:14=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Mar 13, 2024 at 02:05:13PM -0700, Alexei Starovoitov wrote:
>
> But this whole polemic just illustrates that you simply didn't bother to
> understand how the code works. The way you talk about UAF together with
> SLAB_TYPESAFE_BY_RCU is telling. Please read the code instead of
> guessing.

Ok. Fair enough. I've read the code and old threads from Sep-Nov.
I think the concerns about typesafe_by_rcu made folks believe in
races that don't exist.


           if (unlikely(!atomic_long_inc_not_zero(&file->f_count)))
..
            *  (a) the file ref already went down to zero and the
            *      file hasn't been reused yet or the file count
            *      isn't zero but the file has already been reused.

..
            if (unlikely(file !=3D rcu_dereference_raw(*fdentry)) ||

The first part of the comment is partially incorrect.
(it's in the wrong place).

The file ref could have been down to zero and not reused yet,
but it's before atomic_long_inc_not_zero.
Once the code reaches 2nd check the file guaranteed to be reused
and it went through init_file(), because that's the only code
that brings it back from zero.
This race is ok:

cpu0                                    cpu1
file =3D rcu_dereference_raw(*fdentry);
// file->f_count =3D=3D 1
                                        rcu_assign_pointer(fdt->fd[fd], NUL=
L);
                                        fput() // reaches zero

atomic_long_inc_not_zero()
// will not succeed.

This race is ok too:
cpu0                                    cpu1
file =3D rcu_dereference_raw(*fdentry);
// file->f_count =3D=3D 1
                                        rcu_assign_pointer(fdt->fd[fd], NUL=
L);

atomic_long_inc_not_zero()
// succeeds. f_count =3D=3D 2
                                        fput() // f_count =3D=3D 1

file !=3D rcu_dereference_raw(*fdentry)
// will fail
but it doesn't have to.
This is a safe race.
It's no different if cpu0 went through
these steps including successful last check
                                        and then cpu1 did close(fd)

The file held by cpu0 is not on the
path to zero.

Similarly, back then, there was a concern about two parallel __fget_files_r=
cu()
where one cpu incremented refcnt, failed some check and didn't do fput yet.
In this case the file is not on the path to zero either.
Both cpu-s saw non-zero f_count when they went through atomic_long_inc_not_=
zero.
The file is not on the path to be reused.

Now the second part of the comment
"the file count isn't zero but the file has already been reused"
is misleading.

The (file !=3D rcu_dereference_raw(*fdentry)) check is racy.
Another cpu could have replaced that slot right after that check.
Example:
cpu0 doing lockless __fget_files_rcu() while cpu1 doing sys_close.
__fget_files_rcu() will be returning a file that doesn't exist in fdt.
And it's safe.

This race is possible:
cpu0                                    cpu1
file =3D rcu_dereference_raw(*fdentry);
                                        fput() reaches zero
                                        file_free
                                        alloc_empty_file // got same file
                                        init_file // f_count =3D 1
atomic_long_inc_not_zero()
// succeeds. f_count =3D=3D 2
file !=3D rcu_dereference_raw(*fdentry))
// preventing a reuse of a file that
was never in this fdt.

The only value of this check is to make sure that this file
either _is_ or _was_ at some point in this fdt.
It's not preventing reuse per-se.

This race is possible:
cpu0                                    cpu1
file =3D rcu_dereference_raw(*fdentry);
                                        fput() reaches zero
                                        file_free
                                        alloc_empty_file // got same file
                                        init_file // f_count =3D 1
                                        fd_install
atomic_long_inc_not_zero()
// succeeds. f_count =3D=3D 2
file =3D=3D rcu_dereference_raw(*fdentry))
// success, though the file _was reused_.

I suggest to revise the comment.

>
> You've been provided:
>
> a) good reasons why the patchset in it's current form isn't acceptable
>    repeated multiple times

We will improve commit logs in the next revision.

> b) support for exporting a variant of bpf_d_path() that is safe to use

good, but bpf_d_path kfunc alone is not useful.
As Jann noted back in September:
https://lore.kernel.org/all/CAG48ez2d5CW=3DCDi+fBOU1YqtwHfubN3q6w=3D1LfD+ss=
+Q1PWHgQ@mail.gmail.com/

The conversion of files to typesafe_by_rcu broke that verifier
assumption about mm->exe_file and we need kfuncs to safely
acquire/release file reference to fix that breakage.

> c) a request that all kfunc exports for the vfs will have to be located
>    under fs/, not in kernel/bpf/

we've added kfuncs to
net/netfilter/, net/xfrm/, net/ipv4/, kernel/cgroup/, drivers/hid/
because maintainers of those subsystems demonstrated understanding
of what bpf is doing and what these kfuncs are for.

We can put them in fs/, but you need to demonstrate willingness to
understand the problem we're solving instead of arguing
about how hard file typesafe_by_rcu is to understand.

> d) a path on how to move forward with additional kfunc requests:
>    Clear and documented rules when it's ok for someone to come along and
>    request access to bpf kfuncs when it's to be rejected and when it's
>    ok to be supported.

There are ~36500 EXPORT_SYMBOL in the kernel.
Are there "clear documented rules when it's ok for someone to"
add or remove them?
There is a gentleman's agreement that maintainers of subsystems need to
be cc-ed when new EXPORT_SYMBOL-s are added.
In this case no new EXPORT_SYMBOLs are requested.

Compare that to 221 bpf helpers (which are uapi, and for the last
2 years we didn't add a single one) and 151 bpf kfuncs which are
not uapi as clearly documented in Documentation/bpf/kfuncs.rst
When developers want to add them they cc bpf@vger and relevant
subsystems just like we did with netfilter, xfrm, cgroup, hid.
kfunc deprecation rules are also documented in kfunc.rst

> You repeatedly threatening to go over the heads of people will not make
> them more amenable to happily integrate with your subsystem.

This is not it. We made our own mistakes with bpf_d_path safety, and now
file typesafe_by_rcu broke bpf safety assumptions.
We have to fix it one way or the other.
It's bpf that got affected by your changes.
But we don't demand that you fix bpf bits. We're fixing them.
But you have to provide technical reasons why file acquire/release
kfuncs are not suitable.
"Only 3 people understand typesafe_by_rcu" is not it.

