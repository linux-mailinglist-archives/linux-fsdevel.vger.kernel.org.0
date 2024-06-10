Return-Path: <linux-fsdevel+bounces-21359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F59D902A10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 22:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283961C215A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B989D4D8C5;
	Mon, 10 Jun 2024 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QP0ZVlXn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B16A101E2
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2024 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052285; cv=none; b=k0Z9xjsRfw6UDLEtEzAuvKMclEc2dxEcniEs3pWqRmaftlj4LqaIPEfb3VtVCH94zErxrQ/M4gOY3zTF+raH1JOHhZgDBqFOpkJHQTnqTqn8t1Od6qULALGonux5ce2T5YRubdA3ABnDpR6zBy1KWpP5TJ9s+MSimusDfa5/EnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052285; c=relaxed/simple;
	bh=2AMpvZTyySR52Q575EvvbyYkR5oPISP1+4gct2WOnNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlxBOMSSj/Jali4aqx2tlHsI5hnWvbGWOOK4WKNGd21Xuqe4kGmwuQM6/N1RCqIkNQMT9DChoxuudR6Y/WWo3jCpVGgXUtKNI+3/ZrevI6wgJFzPxW9InHZwr2cgq0heG8FNokscGqFKes/qermLluh9XyGtkElYcvvPC8rp6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QP0ZVlXn; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-df771b45e13so4963618276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2024 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718052282; x=1718657082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcoA750Bj+ZN7bjH86sGDKqLI2brF1ReIBjp5AaBwhc=;
        b=QP0ZVlXnPzi9JHSb9MI9yByHECUpe4ZIOkg61l1ioIz6jTHJyBd37Q4pAlyRAPgt6l
         8xBkGM9N3hGvqj9btiOzmw15M2HlRmJepSNRYlltUuhGxA06IujUR6b9v/c18HlMAcwW
         HFy2SpzSUz6k/LX3LWIay8nUXv5OO70g85CJTwA1oftokNjYyTaOA0t9IZnY34QKZos+
         4NJWoAOBgseg5HOG0euABPH732rkWSmydSiduFVHKZlYxBV4a7zA+v9FZQhTgMw8ofXO
         4+KKoEXDEIFUpxXB9nncLl+JqfLtevtlRePW3g+p00iveGKE4aD2l3JKrNsZZjmxygie
         VKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718052282; x=1718657082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcoA750Bj+ZN7bjH86sGDKqLI2brF1ReIBjp5AaBwhc=;
        b=mcBAYQxc/fDfInwEjnfIGg4BTqNjUwj9/wqbobjHMl1fQVtG+Yyz/ZVTD3yZiIVsRQ
         7xGOfYjgt0hOshjUSGryBEdKHnO4lUN2fHvLTVDZjMcfXqZYEXJLZh+BIu0KjEdI1Dsi
         oMtrssQaEMip3N+lAMJAcIn0jB6/omVPmFWxTPv2ayJKpls2ZEshgqj3gFAdbuY2xGYr
         Jw7A4sJ+psLY3N0kRhRw9Hm7xmK0Mfi8M5Yvc+2DD1rDxKWMNf1NYEdXtaZ7gB5OLYV3
         RpHnR6haawUJtS28PFXjHYGa7FigOM6OBnI24QZwBv18FvErAkctfp9mXBcpIDi/UOL3
         5m2A==
X-Forwarded-Encrypted: i=1; AJvYcCXBecqd+1yTeuCh2WmWBqnedj7F0855YcVNflhRWwemixLzz+l6+DqF493fziej/X9QsGoV2iyxY23x9+vkzDc2fM0dc4wyVHTVSKrLug==
X-Gm-Message-State: AOJu0YyLUrKvMKXFNGes/VELkDX4h65ol3nm1EBSS6SI4vAhR1UBzS10
	ldqxnAFw2qkfOJ+DiudAnBMHKq1+h4M9FBrKJqiHjInj26eu6fCSi+97y9DZ2IXPDZrUuRBcc+T
	x7yWq9aO80t6Znx9ax9woISEs9Ixtf6KQLd7x
X-Google-Smtp-Source: AGHT+IG3SmWEZjN2PWG+EsAgWFrCFp7Ijii/YP3+foCW4tNLPIKtnByY5hj7IEgbBVJSG4st69P97jNgbcAYtpOSl/w=
X-Received: by 2002:a25:5f44:0:b0:df7:c087:57a1 with SMTP id
 3f1490d57ef6-dfaf66d1ddamr8231100276.51.1718052282366; Mon, 10 Jun 2024
 13:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <894cc57c-d298-4b60-a67d-42c1a92d0b92@I-love.SAKURA.ne.jp>
 <ab82c3ffce9195b4ebc1a2de874fdfc1@paul-moore.com> <1138640a-162b-4ba0-ac40-69e039884034@I-love.SAKURA.ne.jp>
 <202402070631.7B39C4E8@keescook> <CAHC9VhS1yHyzA-JuDLBQjyyZyh=sG3LxsQxB9T7janZH6sqwqw@mail.gmail.com>
 <CAHC9VhTTj9U-wLLqrHN5xHp8UbYyWfu6nTXuyk8EVcYR7GB6=Q@mail.gmail.com>
 <76bcd199-6c14-484f-8d4d-5a9c4a07ff7b@I-love.SAKURA.ne.jp> <202405011257.E590171@keescook>
In-Reply-To: <202405011257.E590171@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Jun 2024 16:44:31 -0400
Message-ID: <CAHC9VhTucjgxe8rc1j3r3krGPzLFYmPeToCreaqc3HSUkg6dZA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] LSM: add security_execve_abort() hook
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Eric Biederman <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Serge Hallyn <serge@hallyn.com>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 4:04=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
> On Thu, Feb 15, 2024 at 11:33:32PM +0900, Tetsuo Handa wrote:
> > On 2024/02/15 6:46, Paul Moore wrote:
> > >> To quickly summarize, there are two paths forward that I believe are
> > >> acceptable from a LSM perspective, pick either one and send me an
> > >> updated patchset.
> > >>
> > >> 1. Rename the hook to security_bprm_free() and update the LSM hook
> > >> description as I mentioned earlier in this thread.
> > >>
> > >> 2. Rename the hook to security_execve_revert(), move it into the
> > >> execve related functions, and update the LSM hook description to
> > >> reflect that this hook is for reverting execve related changes to th=
e
> > >> current task's internal LSM state beyond what is possible via the
> > >> credential hooks.
> > >
> > > Hi Tetsuo, I just wanted to check on this and see if you've been able
> > > to make any progress?
> > >
> >
> > I'm fine with either approach. Just worrying that someone doesn't like
> > overhead of unconditionally calling security_bprm_free() hook.
>
> With the coming static calls series, this concern will delightfully go
> away. :)
>
> > If everyone is fine with below one, I'll post v4 patchset.
>
> I'm okay with it being security_bprm_free(). One question I had was how
> Tomoyo deals with it? I was depending on the earlier hook only being
> called in a failure path.
>
> > [...]
> > @@ -1530,6 +1530,7 @@ static void free_bprm(struct linux_binprm *bprm)
> >               kfree(bprm->interp);
> >       kfree(bprm->fdpath);
> >       kfree(bprm);
> > +     security_bprm_free();
> >  }
>
> I'm fine with security_bprm_free(), but this needs to be moved to the
> start of free_bprm(), and to pass the bprm itself. This is the pattern we
> use for all the other "free" hooks. (Though in this case we don't attach
> any security context to the brpm, but there may be state of interest in
> it.) i.e.:
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 40073142288f..7ec13b104960 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1532,6 +1532,7 @@ static void do_close_execat(struct file *file)
>
>  static void free_bprm(struct linux_binprm *bprm)
>  {
> +       security_bprm_free(bprm);
>         if (bprm->mm) {
>                 acct_arg_size(bprm, 0);
>                 mmput(bprm->mm);
>

Tetsuo, it's been a while since we've heard from you in this thread -
are you still planning to work on this?  If not, would you object if
someone else took over this patchset?

--=20
paul-moore.com

