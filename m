Return-Path: <linux-fsdevel+bounces-47622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF9AA144D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 19:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0308016724A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 17:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C52244686;
	Tue, 29 Apr 2025 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUpAU/UI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76AD248889;
	Tue, 29 Apr 2025 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946770; cv=none; b=sIqFUEIvfzkUwO3obD9DpCTWaPSLwYFaO8AMEC+qUtoyZIIRLU7+67w52gNdTDDPnHF8joHVx3UhCBEfZH/2/j0uScZjpULhJFD0x7eY5n59gXNThtAOxOC9EpEziLWH0e0KbgMZDl8gwSwjvfm3GB5/7/t3AXvALo9ZmbdYVAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946770; c=relaxed/simple;
	bh=hgJY3wh6a6UeaEJse5LqpLhP5AnH9wkmWf2TvEMe+u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbT7dhxEK/2MzJ02G/38EXUeUiLzO2mKw0GlfHbU9dFqGP/ffIUrOgFVnQuq+u1PAwJBzPG65UBjXJ+z/fzxl/28IJrctRRdFbyPdok13y9fjm77JTb5x6kk13qFdes0eGGBdDITZWGqoY6ZyQ9eKQqZkTb58NZ5gmcmiPKKtQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUpAU/UI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f6222c6c4cso9837885a12.1;
        Tue, 29 Apr 2025 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745946767; x=1746551567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsfvUz+i23ivaruHjbfi9ou4xDoXYHDfMl7yFqsBNNY=;
        b=VUpAU/UIBzNBVWj9MhlFiQsswEJebnpEQhmfFdiQ6CYYavHKECm4i6z0dKhMm0ALKy
         yq7VJb9gDHbQuiV0Z8S3UH6hNPCkvTAj6n2HiirjcrWI3WNWHTqrfqe61o2eczVf7yQm
         enXKJ3v2I1f1BMCMgdQliEBCzDFfa3pNT1FwTlnV8GCccunYcGFYGwA8NaAl//zqQPBe
         2ACqT3olUP2KgzxDodVYI/SvgTqQvyPqQwOUdGX1FzUv2rl3ZzVJen9yvI2GZz9+AeIF
         wa2DK4s9k9OUfM8EhsMxoY+pLwdbVvi1ZeCN7vmJXwGdjiQzxS/XIbwNDIJei4FRtfiy
         gq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745946767; x=1746551567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsfvUz+i23ivaruHjbfi9ou4xDoXYHDfMl7yFqsBNNY=;
        b=UQM1ijXJRaffRHj2A7es3DGh9zVLnMTSr1oNXjIKSZ2MqG0n6P2DFpjmQTgWOyjDmp
         X5nAlz0NegyTDWVc3jEYbH5WcunJG60Ums6LAL4VR5A1YHjwnMvzCKrsVnhKs7miNbsf
         U+y9GQ9OSfSE/1z+s5F6Akh2pz8cUXlsq6GSg8PYEAiPvUGXU6yw5zvTm2ruTw1zWWg5
         OWhSnK7XAx+/ZbYWORTfOHrP3ZEVf6c0T3PAa0M1lhreVZadJxoGBlKF44iRw7HjToyc
         6CDcMRCQ91kYw3Lza1HEcnntl01sftCGkIEnw1JdP5jnBLwCdVf6jNnOHkBKEWAemsI5
         kNWg==
X-Forwarded-Encrypted: i=1; AJvYcCVFgCkIpBpF5zkNW2r4yz0QPrJz+kc4b4mZqn/52PgJqi39G75eqncipcZJo9tHGob6cY+B1xz10ySL933I@vger.kernel.org, AJvYcCX8G1G8pevAyXgdFi79ofzwbryo+kLEtNihvalv8KuOOY2SmtYnvmKElbP4zOaXPLuAnIqoeQVg6Kbf2NLB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxas/v3fv/gU32TAnf2SckQPjEAg3dzo2tuVJnWtbB0/NER8I36
	k6NpsxFztFjc88BN5z2XRkvz8nG7bsAKrWhhL38RJjOgz0L2kcSh17vSV7rbpw7uR+mE3S5QXc6
	dt/zqZh50KEcCCuSpXB/xmLPtQayMz7XQ
X-Gm-Gg: ASbGncsgAP1jrV1tzIgTmjRXk9Q/JZyMBPDMv6tFEjdGiVUeh49MgCAEKJi0zHCWkSM
	VbnmBNxzC0L3bhxHqfuOoZk9SjG0TTmreffKIY6tx4ko+03p7KbdQmCxaWE2uOsufbMFoq3POsx
	juYSk9gOSFj0+7o7M5hjPU
X-Google-Smtp-Source: AGHT+IEFhOpRJtHhdameANKEr4F4uoVUaEZAhtAMKro2joPY0ijis9Vj5f2jUhCYho2E3q3oqxjBEekqlySWOza8xhU=
X-Received: by 2002:a05:6402:370c:b0:5f4:d60f:93f0 with SMTP id
 4fb4d7f45d1cf-5f83889e7bamr3636129a12.31.1745946766822; Tue, 29 Apr 2025
 10:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com> <20250324160003.GA8878@redhat.com>
 <20250429154944.GA18907@redhat.com>
In-Reply-To: <20250429154944.GA18907@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 29 Apr 2025 19:12:34 +0200
X-Gm-Features: ATxdqUEx3Vi0APNX--GO3y5NvRxsG1VNhvPaOpzMVNW8AhLlmPepqTW-UkJkA5E
Message-ID: <CAGudoHGeMmv0n8rujNdPiwZHa+JtDfBS1ym2C41iBpKzzLkUtQ@mail.gmail.com>
Subject: Re: [PATCH] exec: fix the racy usage of fs_struct->in_exec
To: Oleg Nesterov <oleg@redhat.com>
Cc: brauner@kernel.org, kees@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 5:50=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> Damn, I am stupid.
>
> On 03/24, Oleg Nesterov wrote:
> >
> > check_unsafe_exec() sets fs->in_exec under cred_guard_mutex, then execv=
e()
> > paths clear fs->in_exec lockless. This is fine if exec succeeds, but if=
 it
> > fails we have the following race:
> >
> >       T1 sets fs->in_exec =3D 1, fails, drops cred_guard_mutex
> >
> >       T2 sets fs->in_exec =3D 1
> >
> >       T1 clears fs->in_exec
>
> When I look at this code again, I think this race was not possible and th=
us
> this patch (applied as af7bb0d2ca45) was not needed.
>
> Yes, begin_new_exec() can drop cred_guard_mutex on failure, but only afte=
r
> de_thread() succeeds, when we can't race with another sub-thread.
>
> I hope this patch didn't make the things worse so we don't need to revert=
 it.
> Plus I think it makes this (confusing) logic a bit more clear. Just, unle=
ss
> I am confused again, it wasn't really needed.
>
> -------------------------------------------------------------------------=
----
> But. I didn't read the original report from syzbot,
> https://lore.kernel.org/all/67dc67f0.050a0220.25ae54.001f.GAE@google.com/=
#t
> because I wasn't CC'ed. and then - sorry Kees!!! - I didn't bother to rea=
d
> your first reply carefully.
>
> So yes, with or without this patch the "if (fs->in_exec)" check in copy_f=
s()
> can obviously hit the 1 -> 0 transition.
>
> This is harmless, but should be probably fixed just to avoid another repo=
rt
> from KCSAN.
>
> I do not want to add another spin_lock(fs->lock). We can change copy_fs()=
 to
> use data_race(), but I'd prefer the patch below. Yes, it needs the additi=
onal
> comment(s) to explain READ_ONCE().
>
> What do you think? Did I miss somthing again??? Quite possibly...
>
> Mateusz, I hope you will cleanup this horror sooner or later ;)
>
> Oleg.
> ---
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 5d1c0d2dc403..42a7f9b43911 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1495,7 +1495,7 @@ static void free_bprm(struct linux_binprm *bprm)
>         free_arg_pages(bprm);
>         if (bprm->cred) {
>                 /* in case exec fails before de_thread() succeeds */
> -               current->fs->in_exec =3D 0;
> +               WRITE_ONCE(current->fs->in_exec, 0);
>                 mutex_unlock(&current->signal->cred_guard_mutex);
>                 abort_creds(bprm->cred);
>         }
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 4c2df3816728..381af8c8ece8 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1802,7 +1802,7 @@ static int copy_fs(unsigned long clone_flags, struc=
t task_struct *tsk)
>                 /* tsk->fs is already what we want */
>                 spin_lock(&fs->lock);
>                 /* "users" and "in_exec" locked for check_unsafe_exec() *=
/
> -               if (fs->in_exec) {
> +               if (READ_ONCE(fs->in_exec)) {
>                         spin_unlock(&fs->lock);
>                         return -EAGAIN;
>                 }
>

good grief man ;)

I have this on my TODO list, (un)fortunately $life got in the way and
by now I swapped out almost all of the context. I mostly remember the
code is hard to follow. ;)

that said, maybe i'll give it a stab soon(tm). I have a testcase
somewhere to validate that this does provide the expect behavior vs
suid, so it's not going to be me flying blindly.
--=20
Mateusz Guzik <mjguzik gmail.com>

