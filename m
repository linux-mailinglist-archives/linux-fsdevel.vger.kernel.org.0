Return-Path: <linux-fsdevel+bounces-13965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602A2875C95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 04:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B8D28217F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 03:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7722C182;
	Fri,  8 Mar 2024 03:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFNmvKc9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA91CFB5;
	Fri,  8 Mar 2024 03:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709867497; cv=none; b=eUOfUhQn89y5J0TDtZtS47jhEmMEuCDIpeF/aneu+d9T4A9Qld1BqiD/1zBGe/4PtkOVwXH5Hsw34fuDUt6NiBWKGIHyYZQd++ktCgNoz6DZu9FPWc3KnD2EswgLQiGxe5sf0R3cDdYiIORqtVZvjj4raT1gmt8pVdQX/xvOZRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709867497; c=relaxed/simple;
	bh=v+fpOFaGE9IVEQFp5dGJ7B7iaCkVYgetZyUtqI6XqrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMSdn97MWCbXzdzPF1/2ZPQO7FbsBvlKPShVLn/wv42JFN8q+ab30AfPsJEB8fxZfz13TIQMeK4R8bd10wb1TAEguHyazZAK88TXU0wAU4v/dtS2l3UoptD5GCXzFRDkWxFohzVE2pI2QXptKWuiORXOGN12K9yVDDszlXkfa0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFNmvKc9; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a45c006ab82so225032266b.3;
        Thu, 07 Mar 2024 19:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709867494; x=1710472294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj6q92htsofy/f5VcV6/t4KrLGQPNiFAadjpchJR4oU=;
        b=fFNmvKc94+VczUi3OMbZM/WOlaewhV9uIkAo4F7SOtYyLxa2PEg0e25WUaWljlheTG
         uKLjOVuWvqO33nYS/pK0XMUylR8usjXFcyPMJq8ROD0H8w/H32C88F5HKiPweaxo5gMB
         RIWz1vLskmDoB6PIfVaws3XH7gkxM+wuNMwLJO03n1ErhlJc6DU5XksJZ8Kq/Co9ssqB
         H4hSoKHA0UkemvMnM+4hP9H+aVKbg3Poy7ZahW4P13wehc7rz9XNepILcjfME1bgsnrP
         MPcaSztkBmFwyKiv8CWpuQws2UBFmz/orUUbWsIMH3iCFQ7KtqIn/q6cfuoCGzNwoErS
         93mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709867494; x=1710472294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zj6q92htsofy/f5VcV6/t4KrLGQPNiFAadjpchJR4oU=;
        b=hAc1dnKog12gfEF2ldowQ9C+RhfUldkEzf7ymJTfgdnR6tKBSeYjb5pHQ94SlwsrKL
         SQjBgCrFd7YrMJgiBh9GfLh/5js+Cswzui8II/JXcA0ewQ/5f3i4UdNeSj3kFsHg3E4n
         MFSm6dYkyrUwuZrOKT9oGKex20CQIGQh4McLrJFwe9IdnoG85FEe0QD3crVv/ze/+wAP
         G7xgWTsHruqP+zWM54gH2TpBg7WGrOxls7mFDNjD5LWxakyGqDHCS13MTj2qD6v75THy
         bYIIzIahdCnK9OLcObyL6t51cpzKOAHTy5V+u+qDDoxv15Jt63jHLpWlHDKhhu0tp3SE
         PVgg==
X-Forwarded-Encrypted: i=1; AJvYcCV3x6FV3RfRYtBGGOUbjTj6TNjfxcjjvFeWIUBev67qN8Ifq0eY4wvjI8hfND5DJe28pKBN+gn1qh2Sbl0R0ItbJIv1EewSnohaRhvMCoRveVvO2yoESZr2BUHCxKCl9PG0rWzXUh9CVU3elxy34rK894A617z6pyIvipFX37plmq5AN1xLDLeQzw==
X-Gm-Message-State: AOJu0Yx/Il3tWHi6A4a7UPvQtimr1w61X9zvw0zCzwQj0dFZgNaWkSx9
	GR0RZTPuEDxqK8/6pGL7HtE/tv8OXA2yog5hqh+MAtpCRIRaNi2YP+vBcv1PfGWfvfEDlEvhesU
	d1/tAmr98GH4BrjInNXWgilvJlzo=
X-Google-Smtp-Source: AGHT+IGeKNrA4flz39TyY21Qq+eMtzgSQnDG1XmDYjlybgEaOqh2F/oNtXZp6fFMkAue7HFtuFShEgO4kQ1nU/EueDw=
X-Received: by 2002:a17:906:5953:b0:a44:b90b:3262 with SMTP id
 g19-20020a170906595300b00a44b90b3262mr13474080ejr.5.1709867493755; Thu, 07
 Mar 2024 19:11:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709675979.git.mattbobrowski@google.com>
 <20240306-flach-tragbar-b2b3c531bf0d@brauner> <20240306-sandgrube-flora-a61409c2f10c@brauner>
 <CAADnVQ+RBV_rJx5LCtCiW-TWZ5DCOPz1V3ga_fc__RmL_6xgOg@mail.gmail.com> <20240307-phosphor-entnahmen-8ef28b782abf@brauner>
In-Reply-To: <20240307-phosphor-entnahmen-8ef28b782abf@brauner>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Mar 2024 19:11:22 -0800
Message-ID: <CAADnVQLMHdL1GfScnG8=0wL6PEC=ACZT3xuuRFrzNJqHKrYvsw@mail.gmail.com>
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

On Thu, Mar 7, 2024 at 1:55=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> > >
> > > So, looking at this series you're now asking us to expose:
> > >
> > > (1) mmgrab()
> > > (2) mmput()
> > > (3) fput()
> > > (5) get_mm_exe_file()
> > > (4) get_task_exe_file()
> > > (7) get_task_fs_pwd()
> > > (6) get_task_fs_root()
> > > (8) path_get()
> > > (9) path_put()
> > >
> > > in one go and the justification in all patches amounts to "This is
> > > common in some BPF LSM programs".
> > >
> > > So, broken stuff got exposed to users or at least a broken BPF LSM
> > > program was written somewhere out there that is susceptible to UAFs
> > > becauase you didn't restrict bpf_d_path() to trusted pointer argument=
s.
> > > So you're now scrambling to fix this by asking for a bunch of low-lev=
el
> > > exports.
> > >
> > > What is the guarantee that you don't end up writing another BPF LSM t=
hat
> > > abuses these exports in a way that causes even more issues and then
> > > someone else comes back asking for the next round of bpf funcs to be
> > > exposed to fix it.
> >
> > There is no guarantee.
> > We made a safety mistake with bpf_d_path() though
> > we restricted it very tight. And that UAF is tricky.
> > I'm still amazed how Jann managed to find it.
> > We all make mistakes.
> > It's not the first one and not going to be the last.
> >
> > What Matt is doing is an honest effort to fix it
> > in the upstream kernel for all bpf users to benefit.
> > He could have done it with a kernel module.
> > The above "low level" helpers are all either static inline
> > in .h or they call EXPORT_SYMBOL[_GPL] or simply inc/dec refcnt.
> >
> > One can implement such kfuncs in an out of tree kernel module
> > and be done with it, but in the bpf community we encourage
> > everyone to upstream their work.
> >
> > So kudos to Matt for working on these patches.
> >
> > His bpf-lsm use case is not special.
> > It just needs a safe way to call d_path.
> >
> > +SEC("lsm.s/file_open")
> > +__failure __msg("R1 must be referenced or trusted")
> > +int BPF_PROG(path_d_path_kfunc_untrusted_from_current)
> > +{
> > +       struct path *pwd;
> > +       struct task_struct *current;
> > +
> > +       current =3D bpf_get_current_task_btf();
> > +       /* Walking a trusted pointer returned from bpf_get_current_task=
_btf()
> > +        * yields and untrusted pointer. */
> > +       pwd =3D &current->fs->pwd;
> > +       bpf_path_d_path(pwd, buf, sizeof(buf));
> > +       return 0;
> > +}
> >
> > This test checks that such an access pattern is unsafe and
> > the verifier will catch it.
> >
> > To make it safe one needs to do:
> >
> >   current =3D bpf_get_current_task_btf();
> >   pwd =3D bpf_get_task_fs_pwd(current);
> >   if (!pwd) // error path
> >   bpf_path_d_path(pwd, ...);
> >   bpf_put_path(pwd);
> >
> > these are the kfuncs from patch 6.
> >
> > And notice that they have KF_ACQUIRE and KF_RELEASE flags.
> >
> > They tell the verifier to recognize that bpf_get_task_fs_pwd()
> > kfunc acquires 'struct path *'.
> > Meaning that bpf prog cannot just return without releasing it.
> >
> > The bpf prog cannot use-after-free that 'pwd' either
> > after it was released by bpf_put_path(pwd).
> >
> > The verifier static analysis catches such UAF-s.
> > It didn't catch Jann's UAF earlier, because we didn't have
> > these kfuncs! Hence the fix is to add such kfuncs with
> > acquire/release semantics.
> >
> > > The difference between a regular LSM asking about this and a BPF LSM
> > > program is that we can see in the hook implementation what the LSM
> > > intends to do with this and we can judge whether that's safe or not.
> >
> > See above example.
> > The verifier is doing a much better job than humans when it comes
> > to safety.
> >
> > > Here you're asking us to do this blindfolded.
> >
> > If you don't trust the verifier to enforce safety,
> > you shouldn't trust Rust compiler to generate safe code either.
> >
> > In another reply you've compared kfuncs to EXPORT_SYMBOL_GPL.
> > Such analogy is correct to some extent,
> > but unlike exported symbols kfuncs are restricted to particular
> > program types. They don't accept arbitrary pointers,
> > and reference count is enforced as well.
> > That's a pretty big difference vs EXPORT_SYMBOL.
>
> There's one fundamental question here that we'll need an official answer =
to:
>
> Is it ok for an out-of-tree BPF LSM program, that nobody has ever seen
> to request access to various helpers in the kernel?

obviously not.

> Because fundamentally this is what this patchset is asking to be done.

Pardon ?

> If the ZFS out-of-tree kernel module were to send us a similar patch
> series asking us for a list of 9 functions that they'd like us to export
> what would the answer to that be?

This patch set doesn't request any new EXPORT_SYMBOL.
Quoting previous reply:
"
 The above "low level" helpers are all either static inline
 in .h or they call EXPORT_SYMBOL[_GPL] or simply inc/dec refcnt.
"

Let's look at your list:

> > > (1) mmgrab()
> > > (2) mmput()
> > > (3) fput()
> > > (5) get_mm_exe_file()
> > > (4) get_task_exe_file()
> > > (7) get_task_fs_pwd()
> > > (6) get_task_fs_root()
> > > (8) path_get()
> > > (9) path_put()

First of all, there is no such thing as get_task_fs_pwd/root
in the kernel.

The hypothetical out-of-tree ZFS can use the rest just fine.
One can argue that get_mm_exe_file() is not exported,
but it's nothing but rcu_lock-wrap plus get_file_rcu()
which is EXPORT_SYMBOL.

kfunc-s in patch 6 wrap get_fs_root/pwd from linux/fs_struct.h
that calls EXPORT_SYMBOL(path_get).

So upon close examination no new EXPORT_SYMBOL-s were requested.

Christian,

I understand your irritation with anything bpf related
due to our mistake with fd=3D0, but as I said earlier it was
an honest mistake. There was no malicious intent.
Time to move on.

