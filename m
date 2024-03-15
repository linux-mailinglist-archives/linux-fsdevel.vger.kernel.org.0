Return-Path: <linux-fsdevel+bounces-14525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632E887D39F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 19:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C376281D06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E4E14A9F;
	Fri, 15 Mar 2024 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dlPSKZwL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EC0FC0E;
	Fri, 15 Mar 2024 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527440; cv=none; b=iyqvoxLgyvfCqJj9/5llHIgIrcqxG2zazxCgoyjZTuAZJIv6XBiAqwdjJV2qMR20JH+TGHvD7FUCdrLLIBMFzr6n3JXgXatE6/HNE3sIIUeTlivIBv1MP7fIl3+B638RkOjTzoQ+cMssRuhnPFkDsuVb0HGjhVDHLojkKLSa0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527440; c=relaxed/simple;
	bh=xK5t2MEBduj0jxE0jFQRIWHPq413A/oQU2rxAo+9Dx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5sC66VlfnUtX9MXhC4oVOWHQsVNq8c26QyCorMnL50YWWK6xXJhn6M+UFH+IMKWX2uqIHaKzkz0CjS0dCLzJUG2ebwTgRt5+a6Vqb0TLieIqQuZTA7rPn2ZC8PFi/si8rJm+IFm29dSo++5KNpKibdFAVjMeAmpOzi5CA3hgl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dlPSKZwL; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dd14d8e7026so2146456276.2;
        Fri, 15 Mar 2024 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710527435; x=1711132235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spSR6qRGR6QrhghZSwpU7jLDpc5od9SU7Ron6pMaToY=;
        b=dlPSKZwLr0A4vBbSY8/IMAIP4EiJrxwDmNJ0h5b2JdcpW8UDSL9a3QPjAT/rQ+qUWj
         l/7LJ5WkQPtyhrJQk6ycBdR2Ki/Nyu149dNFLimqQouD9EcUR/RYXPKeZy7qwvF+8YBT
         dfHrKCuloCj8VhP/Xcd9Fp1j8PQ0TBfiefXqaAeFNLCqqV0+3THITCUiDanXAyikeDZQ
         1Dpch7aHUd2NpaH6dLzHzNs3dQYUGgeOHiQdNj6PULp5DhlFlWyrpgsBzR5Dy4AZwpo4
         EX+YowyE2dx6MpAFjIHRPCYybzP09GRD2+X4Mj2Nu7bZ7PpU5WSLgI5YHAmZOcj6AQ25
         RpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710527435; x=1711132235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spSR6qRGR6QrhghZSwpU7jLDpc5od9SU7Ron6pMaToY=;
        b=sc6DQa/siKa+bFXp8CoGw9uAR8mpkSCZ0Oz16vvM70+/ZMe1qA/PA8WeWoFqfxO2gN
         YJ0jDpTM0KooUoZaC/mHzVvEqdvfjpWA285bTD+tNySwg7iwflq4kqweEfPt0iEDZC8f
         AvjBAf31jYJPk2zIpuby2dkIUQQqqcJbRjsIlInvFBNSpwG7bemDT4ajtOx6pIoFoxvB
         6Q+7cNzt7tXe0zgx/cg2gqaSi1M6JsFNNySo/R//ONgUy3JSaB2X82llwrbHeq0kCztR
         PdA/f/RorxM9exEP8Fzv57/GZ6Cbbqcn9X7BQxynXb8Lm8R03S2kVXWM6OrXeXvUkql3
         qK8A==
X-Forwarded-Encrypted: i=1; AJvYcCU3GTRfhvtt31/cqOI5J+pG7UE1k8uJJcfCYMMxfrNdkR8ZnRMxBxv2ZsYNZl0vvlhuMcZVphZ5GCjB9w5RomYq3fJpNaSkyze3NKG0VSUX9RuhEDocjdvpbz2CbUykajtlQLdD2jj4+O4DIQ==
X-Gm-Message-State: AOJu0YyUvcxn/xtQ7mLPyH98uUoh4yZF0GFWBEX4AtXlgUfwptLDffbp
	nOG5xngRVASDTiKB15gzTg9HR0oLtONh7a2/4QhOD+saHLiHjbwjYzCm4dhFWjrgp3skoZB0xrm
	GTk/7SyDmcBtU/A1ed2oJbnLo+Y8vdSwNalUBTA==
X-Google-Smtp-Source: AGHT+IHJpxfHmnBK/IJ5Pv9HDwv1gImnsof0Ltw87oFO+Eu96nE6pWjn/dgNPyvXJNRVuJo7nHd7rz0f0MENO9NTOk4=
X-Received: by 2002:a25:c7d4:0:b0:dcc:5a25:ae88 with SMTP id
 w203-20020a25c7d4000000b00dcc5a25ae88mr5970741ybe.19.1710527434195; Fri, 15
 Mar 2024 11:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315181032.645161-1-cgzones@googlemail.com>
 <20240315181032.645161-2-cgzones@googlemail.com> <f6d1b9fc-dfb1-4fd8-bfa0-bd1349c4a1c1@schaufler-ca.com>
In-Reply-To: <f6d1b9fc-dfb1-4fd8-bfa0-bd1349c4a1c1@schaufler-ca.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Fri, 15 Mar 2024 19:30:23 +0100
Message-ID: <CAJ2a_DfGHBuVBLTWniNektRsY_6P=x37XT-31+P6mV9dgJvt0Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] lsm: introduce new hook security_vm_execstack
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Alfred Piccioni <alpic@google.com>, John Johansen <john.johansen@canonical.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Mar 2024 at 19:22, Casey Schaufler <casey@schaufler-ca.com> wrot=
e:
>
> On 3/15/2024 11:08 AM, Christian G=C3=B6ttsche wrote:
> > Add a new hook guarding instantiations of programs with executable
> > stack.  They are being warned about since commit 47a2ebb7f505 ("execve:
> > warn if process starts with executable stack").  Lets give LSMs the
> > ability to control their presence on a per application basis.
>
> This seems like a hideously expensive way to implement a flag
> disallowing execution of programs with executable stacks. What's
> wrong with adding a flag VM_NO_EXECUTABLE_STACK?

That would be global and not on a per application basis.
One might want to exempt known legacy programs.
Also is performance a concern for this today's rare occurrence?

> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  fs/exec.c                     |  4 ++++
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  6 ++++++
> >  security/security.c           | 13 +++++++++++++
> >  4 files changed, 24 insertions(+)
> >
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 8cdd5b2dd09c..e6f9e980c6b1 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -829,6 +829,10 @@ int setup_arg_pages(struct linux_binprm *bprm,
> >       BUG_ON(prev !=3D vma);
> >
> >       if (unlikely(vm_flags & VM_EXEC)) {
> > +             ret =3D security_vm_execstack();
> > +             if (ret)
> > +                     goto out_unlock;
> > +
> >               pr_warn_once("process '%pD4' started with executable stac=
k\n",
> >                            bprm->file);
> >       }
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_def=
s.h
> > index 185924c56378..b31d0744e7e7 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -49,6 +49,7 @@ LSM_HOOK(int, 0, syslog, int type)
> >  LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
> >        const struct timezone *tz)
> >  LSM_HOOK(int, 1, vm_enough_memory, struct mm_struct *mm, long pages)
> > +LSM_HOOK(int, 0, vm_execstack, void)
> >  LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
> >  LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, cons=
t struct file *file)
> >  LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index d0eb20f90b26..084b96814970 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -294,6 +294,7 @@ int security_quota_on(struct dentry *dentry);
> >  int security_syslog(int type);
> >  int security_settime64(const struct timespec64 *ts, const struct timez=
one *tz);
> >  int security_vm_enough_memory_mm(struct mm_struct *mm, long pages);
> > +int security_vm_execstack(void);
> >  int security_bprm_creds_for_exec(struct linux_binprm *bprm);
> >  int security_bprm_creds_from_file(struct linux_binprm *bprm, const str=
uct file *file);
> >  int security_bprm_check(struct linux_binprm *bprm);
> > @@ -624,6 +625,11 @@ static inline int security_vm_enough_memory_mm(str=
uct mm_struct *mm, long pages)
> >       return __vm_enough_memory(mm, pages, cap_vm_enough_memory(mm, pag=
es));
> >  }
> >
> > +static inline int security_vm_execstack(void)
> > +{
> > +     return 0;
> > +}
> > +
> >  static inline int security_bprm_creds_for_exec(struct linux_binprm *bp=
rm)
> >  {
> >       return 0;
> > diff --git a/security/security.c b/security/security.c
> > index 0144a98d3712..f75240d0d99d 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1125,6 +1125,19 @@ int security_vm_enough_memory_mm(struct mm_struc=
t *mm, long pages)
> >       return __vm_enough_memory(mm, pages, cap_sys_admin);
> >  }
> >
> > +/**
> > + * security_vm_execstack() - Check if starting a program with executab=
le stack
> > + * is allowed
> > + *
> > + * Check whether starting a program with an executable stack is allowe=
d.
> > + *
> > + * Return: Returns 0 if permission is granted.
> > + */
> > +int security_vm_execstack(void)
> > +{
> > +     return call_int_hook(vm_execstack);
> > +}
> > +
> >  /**
> >   * security_bprm_creds_for_exec() - Prepare the credentials for exec()
> >   * @bprm: binary program information

