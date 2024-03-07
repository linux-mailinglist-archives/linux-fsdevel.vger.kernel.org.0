Return-Path: <linux-fsdevel+bounces-13837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B04B87470E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 05:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1CD1F23811
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 04:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63023168AB;
	Thu,  7 Mar 2024 04:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eM00rYaj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3719320E;
	Thu,  7 Mar 2024 04:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709784320; cv=none; b=ApsUS8pZocdbjprhJ8zmpJx6NUzVOl83ACoH3VFdMMzaMmtcP6VloEuYsNbmrFv/xMNEol/oZomvH5a2bQh1wh/fltPiRUpVZPEvZ7TOycFwxzv4ok1JjdsAO54xXtFxDwBIMeYfU1mkjp51QA2wbMnCXR9MS4x9Q1LgB543tyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709784320; c=relaxed/simple;
	bh=TiiCuRmVnTpYnTLXfeBn+pDoHaco+vwlVpQdslMcXWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMxSfTP2XbOwDGhFkeoGveraEE/yaBKLYF1s95dsIETzHlUPzAntnm6cylgqXBmYiZfHlVuAJPXWOL07SxAMZslzyCOz0y0phPfZ6NbrNBAL16gia3Mkklibifytl5fZUhNx9LqAVOswClHintPQDYacq9EA0Aqns2zrbeBEo80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eM00rYaj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412e6bdd454so4044455e9.1;
        Wed, 06 Mar 2024 20:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709784317; x=1710389117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8PRUjXlckosjFn/u+XfzRCaBdS+KKYLP6sTKKsBA34=;
        b=eM00rYajFfUv0egqxUPFxmIchERYD8k6yMqn7UDWnaOgRetwCfAPLkh18XKfMvNA6F
         u7xvXRzUxeWFyhRwB/XyaNe/L4+8sBHbi+26gpN/85vrqr8dxCvTao16qKBIek+qBHZ9
         KuHIa4UKDaMFDcxAKsExcoC7/rCFyngPLf4r4Bfzy9E7v/8L3olLmLxk20cM5+gc7Zj4
         j2eMfzJpPBubKVLrjns4I+UPvaMM3SoFCqbXZyb+Nq4+lO+9ron1pjR4MzOv6M5R/GRK
         WCgMvsbwfOC135/7tRrO/IUN/zKKk52dENo3zV4EH/Lmk7VgP8c5uJgXoUZwbL2twUJe
         d6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709784317; x=1710389117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8PRUjXlckosjFn/u+XfzRCaBdS+KKYLP6sTKKsBA34=;
        b=j8Xt/mClRGXii9+KQV4pV4YAqDQvhwRJy1Dv6V8DfiVLbnMjPGvq1hSPMpXYd70Iqz
         vm4PJ56zn6WmY1qCJZVDnBFltgwMpYMm8U6RuS11aePuQOC7l6vARwkExB0OUOj5+2p+
         w7Tho/eSvtuGRQ4c7j+Ex4+4gxQsSf983IBe2ICgAo7SIqTkyTG0952IUDxFMFKbQSFr
         uBnhP5reZj9NWzxaZYFZ1Xg1q0aHb/+VueOVai84EJnYB8kjQiNC9HkfTzGJKVhpRlDT
         dFXEUrGa1lsWWeLWUzJWaFW7SrdRk7LqPdAY/8rbi4f0v1/NGbtItLco0080gzMBfQIc
         oDIw==
X-Forwarded-Encrypted: i=1; AJvYcCWiyEnVxeZLtDM/qtTBmuwgXeQNLabDh3x2Mvd7hBaZAUN0ItxOIhn7Wqap0qZO417V1+Znv7Pzw/doD78RvrmYWFWJTv8ziAevDIdO8OSyU+TDY+t4D/Iz7ZlA4p+BPpWD04HKshctezfgt6yddkfUTeFQgni89FmghGHG8prW/ba7C2kWI5eAMQ==
X-Gm-Message-State: AOJu0YzpHR8Bc+EO5HI+gia8bEZ+wFtF+uXYPkA0sGpa5ezR15VqZzxn
	5deHHB1Z1TQWat9178eccaK0rNCsIFTzz0bbdYmlhYaoLYuzM9fCE7ciagIAKPGkXLFIsdMqLkM
	QP0dkDZ4vRLmDHc6EN/iWndo7eB8ptO4fI6E=
X-Google-Smtp-Source: AGHT+IEvxrBRLQoMA+pf6h65l4h3GLzHKuHqs09r7J0cKg49RQO+pvINH+nsOre2Nh717dizCn4WrJY+ZvWo48WFe6Y=
X-Received: by 2002:a05:600c:5105:b0:412:f244:5f0 with SMTP id
 o5-20020a05600c510500b00412f24405f0mr2979844wms.28.1709784316989; Wed, 06 Mar
 2024 20:05:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709675979.git.mattbobrowski@google.com>
 <20240306-flach-tragbar-b2b3c531bf0d@brauner> <20240306-sandgrube-flora-a61409c2f10c@brauner>
In-Reply-To: <20240306-sandgrube-flora-a61409c2f10c@brauner>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Mar 2024 20:05:05 -0800
Message-ID: <CAADnVQ+RBV_rJx5LCtCiW-TWZ5DCOPz1V3ga_fc__RmL_6xgOg@mail.gmail.com>
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

On Wed, Mar 6, 2024 at 4:13=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Wed, Mar 06, 2024 at 12:21:28PM +0100, Christian Brauner wrote:
> > On Wed, Mar 06, 2024 at 07:39:14AM +0000, Matt Bobrowski wrote:
> > > G'day All,
> > >
> > > The original cover letter providing background context and motivating
> > > factors around the needs for the BPF kfuncs introduced within this
> > > patch series can be found here [0], so please do reference that if
> > > need be.
> > >
> > > Notably, one of the main contention points within v1 of this patch
> > > series was that we were effectively leaning on some preexisting
> > > in-kernel APIs such as get_task_exe_file() and get_mm_exe_file()
> > > within some of the newly introduced BPF kfuncs. As noted in my
> > > response here [1] though, I struggle to understand the technical
> > > reasoning behind why exposing such in-kernel helpers, specifically
> > > only to BPF LSM program types in the form of BPF kfuncs, is inherentl=
y
> > > a terrible idea. So, until someone provides me with a sound technical
> > > explanation as to why this cannot or should not be done, I'll continu=
e
> > > to lean on them. The alternative is to reimplement the necessary
> > > in-kernel APIs within the BPF kfuncs, but that's just nonsensical IMO=
.
> >
> > You may lean as much as you like. What I've reacted to is that you've
> > (not you specifically, I'm sure) messed up. You've exposed d_path() to
> > users  without understanding that it wasn't safe apparently.
> >
> > And now we get patches that use the self-inflicted brokeness as an
> > argument to expose a bunch of other low-level helpers to fix that.
> >
> > The fact that it's "just bpf LSM" programs doesn't alleviate any
> > concerns whatsoever. Not just because that is just an entry vector but
> > also because we have LSMs induced API abuse that we only ever get to se=
e
> > the fallout from when we refactor apis and then it causes pain for the =
vfs.
> >
> > I'll take another look at the proposed helpers you need as bpf kfuncs
> > and I'll give my best not to be overly annoyed by all of this. I have n=
o
> > intention of not helping you quite the opposite but I'm annoyed that
> > we're here in the first place.
> >
> > What I want is to stop this madness of exposing stuff to users without
> > fully understanding it's semantics and required guarantees.
>
> So, looking at this series you're now asking us to expose:
>
> (1) mmgrab()
> (2) mmput()
> (3) fput()
> (5) get_mm_exe_file()
> (4) get_task_exe_file()
> (7) get_task_fs_pwd()
> (6) get_task_fs_root()
> (8) path_get()
> (9) path_put()
>
> in one go and the justification in all patches amounts to "This is
> common in some BPF LSM programs".
>
> So, broken stuff got exposed to users or at least a broken BPF LSM
> program was written somewhere out there that is susceptible to UAFs
> becauase you didn't restrict bpf_d_path() to trusted pointer arguments.
> So you're now scrambling to fix this by asking for a bunch of low-level
> exports.
>
> What is the guarantee that you don't end up writing another BPF LSM that
> abuses these exports in a way that causes even more issues and then
> someone else comes back asking for the next round of bpf funcs to be
> exposed to fix it.

There is no guarantee.
We made a safety mistake with bpf_d_path() though
we restricted it very tight. And that UAF is tricky.
I'm still amazed how Jann managed to find it.
We all make mistakes.
It's not the first one and not going to be the last.

What Matt is doing is an honest effort to fix it
in the upstream kernel for all bpf users to benefit.
He could have done it with a kernel module.
The above "low level" helpers are all either static inline
in .h or they call EXPORT_SYMBOL[_GPL] or simply inc/dec refcnt.

One can implement such kfuncs in an out of tree kernel module
and be done with it, but in the bpf community we encourage
everyone to upstream their work.

So kudos to Matt for working on these patches.

His bpf-lsm use case is not special.
It just needs a safe way to call d_path.
Let's look at one of the test in patch 9:

+SEC("lsm.s/file_open")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(path_d_path_kfunc_untrusted_from_current)
+{
+       struct path *pwd;
+       struct task_struct *current;
+
+       current =3D bpf_get_current_task_btf();
+       /* Walking a trusted pointer returned from bpf_get_current_task_btf=
()
+        * yields and untrusted pointer. */
+       pwd =3D &current->fs->pwd;
+       bpf_path_d_path(pwd, buf, sizeof(buf));
+       return 0;
+}

This test checks that such an access pattern is unsafe and
the verifier will catch it.

To make it safe one needs to do:

  current =3D bpf_get_current_task_btf();
  pwd =3D bpf_get_task_fs_pwd(current);
  if (!pwd) // error path
  bpf_path_d_path(pwd, ...);
  bpf_put_path(pwd);

these are the kfuncs from patch 6.

And notice that they have KF_ACQUIRE and KF_RELEASE flags.

They tell the verifier to recognize that bpf_get_task_fs_pwd()
kfunc acquires 'struct path *'.
Meaning that bpf prog cannot just return without releasing it.

The bpf prog cannot use-after-free that 'pwd' either
after it was released by bpf_put_path(pwd).

The verifier static analysis catches such UAF-s.
It didn't catch Jann's UAF earlier, because we didn't have
these kfuncs! Hence the fix is to add such kfuncs with
acquire/release semantics.

> The difference between a regular LSM asking about this and a BPF LSM
> program is that we can see in the hook implementation what the LSM
> intends to do with this and we can judge whether that's safe or not.

See above example.
The verifier is doing a much better job than humans when it comes
to safety.

> Here you're asking us to do this blindfolded.

If you don't trust the verifier to enforce safety,
you shouldn't trust Rust compiler to generate safe code either.

In another reply you've compared kfuncs to EXPORT_SYMBOL_GPL.
Such analogy is correct to some extent,
but unlike exported symbols kfuncs are restricted to particular
program types. They don't accept arbitrary pointers,
and reference count is enforced as well.
That's a pretty big difference vs EXPORT_SYMBOL.

> Because really, all I see immediately supportable is the addition of a
> safe variant of bpf making use of the trusted pointer argument
> constraint:
>
> [PATCH v2 bpf-next 8/9] bpf: add trusted d_path() based BPF kfunc bpf_pat=
h_d_path()

This kfunc alone is useful in limited cases.
See above example. For simple LSM file_open hook
the bpf prog needs bpf_get_task_fs_pwd() to use this d_path kfunc.

