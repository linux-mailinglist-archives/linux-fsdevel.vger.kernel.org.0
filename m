Return-Path: <linux-fsdevel+bounces-11612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C4A855520
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 22:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7E92838DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 21:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F0A13F008;
	Wed, 14 Feb 2024 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E1Bx1wpp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5C913EFE8
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707947201; cv=none; b=Qg4IPpNssIAkdggvUabNh5ar/ri9HSOjILiw3Cr+ovUYfeIckMWExmrvaSvTOA6g/4wmC0sxJmyOH8zI9qTaEGdoQ1p6dxpvkXF69o0MYQD0oiW+s/O7qdU6+3b5WAUeIDfV9psfUoEyPnKfwbmHqpaHZ4PNkQ3reRloa8nhyXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707947201; c=relaxed/simple;
	bh=iqu23g7y6NBGnuB4RYMQSuWSBoJOt9RnF+l3nRCfaqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoT1XLFkelMUEIDrF45+4w7K2QYkBYP5oIgHdEOCE5U3LFfVGLD+2CuJx3tUCK+JVUhHKt5a3RuX6nXmFNqhVkz49XrDeE28Wj0Bu8xNpMcnC6t3f0by1dWxkIVkTGgkfV03MuA4IZdkUSw6OlOM24AhO7Rq61/SjPrh665aWN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E1Bx1wpp; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60778cd55caso2476887b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 13:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707947198; x=1708551998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfXt5BBp96PBHUeAG2AD0okLzCV3BnNVpMAUTXPElcw=;
        b=E1Bx1wpp+fEKY0Yf5teSeCgG0h0PkStXrNpGLPgyXRjETaaH3Hm5d9NsLCypnJSRtC
         p51RlsHrsskFSK8Hf+s1OBMqylwF1/iXSa0BQarEBBxO21WNTgNrLSl4IZ8g+gaoKyrg
         CjWuK59z4oA49yiI2svxQpK66r3862TnwlBbryu4FITo9PWV3eJPNr/UG4Ku/A2ZSNBr
         yaHCV0Dmbyy5B/3Vc+07Ldm3ebqK32uAabPzrBAlIjfzkuhnqfrQVKp7HLQsen363usP
         w9HCIiB0KCPS2mZuOzZtrt2+EfYQp24JOsjh0SvxBB6uPiGiJZ3zmbcvT566Db6j+poQ
         VYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707947198; x=1708551998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfXt5BBp96PBHUeAG2AD0okLzCV3BnNVpMAUTXPElcw=;
        b=seWodLKjpMYUQ8AdZGVf7tMTPVZd1fXBzqzdDwT4M3cWh7AvRHg2s6200bMeXDcqZi
         uT+kcbUEInGaVhBpEE16uPuU6XJmWpo1fEqGAqM1y7RACwZZAN7SK9n6yrXHjCZ7jtX1
         2MgThA9GEQfvXJc0xRiHIjqpn5uww6HMn61C4gRD1JAf0Pj177CK20T1EqGBZyyc2LMW
         HVSPDTifzWlxwpyzk/N9ebw/egEjQcTQEUwOepR0/gTW9qgVkDfoDpZLy4nqzzXzq2YU
         jTc+hI+geqhU9IsCNlr5Z5MdIoN/LLPYLJdPyYiTpdyCTakA5hg6d7svU0ZQ55J0Vuzw
         mAnA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ7TW6XIy3KIx9QPeB6YkWfneh6vpcyJVzipQZf8ZYDNEKeJha5FR+4X6Pq9VHihHgz54BEdtpzUZ0g25SGMHw3b86dYFIO17DYUTl0g==
X-Gm-Message-State: AOJu0YxuQegwEyOCcYRSxzdw3UcDZKwc75T/EwvMwyWjI5fq0cQ+Jnmq
	do5m+dHYhuChTu8tOGT/UR+wvDZHt/JyIClCC6MFUir/K5el2Nk3YgR/wFB2hPh7zXgTExwDy0D
	a2OpmAg8gQmKXFK4kKpBSXzE5UhLUcAFYVXbGUvyh1owncps=
X-Google-Smtp-Source: AGHT+IGvqYOVYZAdFMhlyEhxyJDcW+zX1tk0Wf/dMRNuhGGfi4qtbp4MC4vXzeW7hD1kJsj/YYPHXUwVWzd68a6kFT0=
X-Received: by 2002:a81:7994:0:b0:607:cc6a:dcc5 with SMTP id
 u142-20020a817994000000b00607cc6adcc5mr202900ywc.16.1707947198264; Wed, 14
 Feb 2024 13:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <894cc57c-d298-4b60-a67d-42c1a92d0b92@I-love.SAKURA.ne.jp>
 <ab82c3ffce9195b4ebc1a2de874fdfc1@paul-moore.com> <1138640a-162b-4ba0-ac40-69e039884034@I-love.SAKURA.ne.jp>
 <202402070631.7B39C4E8@keescook> <CAHC9VhS1yHyzA-JuDLBQjyyZyh=sG3LxsQxB9T7janZH6sqwqw@mail.gmail.com>
In-Reply-To: <CAHC9VhS1yHyzA-JuDLBQjyyZyh=sG3LxsQxB9T7janZH6sqwqw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 Feb 2024 16:46:27 -0500
Message-ID: <CAHC9VhTTj9U-wLLqrHN5xHp8UbYyWfu6nTXuyk8EVcYR7GB6=Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] LSM: add security_execve_abort() hook
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 11:01=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, Feb 7, 2024 at 9:34=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
> > On Wed, Feb 07, 2024 at 08:10:55PM +0900, Tetsuo Handa wrote:
> > > On 2024/02/07 9:00, Paul Moore wrote:
> > > >> @@ -1223,6 +1223,17 @@ void security_bprm_committed_creds(const st=
ruct linux_binprm *bprm)
> > > >>    call_void_hook(bprm_committed_creds, bprm);
> > > >>  }
> > > >>
> > > >> +/**
> > > >> + * security_execve_abort() - Notify that exec() has failed
> > > >> + *
> > > >> + * This hook is for undoing changes which cannot be discarded by
> > > >> + * abort_creds().
> > > >> + */
> > > >> +void security_execve_abort(void)
> > > >> +{
> > > >> +  call_void_hook(execve_abort);
> > > >> +}
> > > >
> > > > I don't have a problem with reinstating something like
> > > > security_bprm_free(), but I don't like the name security_execve_abo=
rt(),
> > > > especially given that it is being called from alloc_bprm() as well =
as
> > > > all of the execve code.  At the risk of bikeshedding this, I'd be m=
uch
> > > > happier if this hook were renamed to security_bprm_free() and the
> > > > hook's description explained that this hook is called when a linux_=
bprm
> > > > instance is being destroyed, after the bprm creds have been release=
d,
> > > > and is intended to cleanup any internal LSM state associated with t=
he
> > > > linux_bprm instance.
> > > >
> > > > Are you okay with that?
> > >
> > > Hmm, that will bring us back to v1 of this series.
> > >
> > > v3 was based on Eric W. Biederman's suggestion
> > >
> > >   If you aren't going to change your design your new hook should be:
> > >           security_execve_revert(current);
> > >   Or maybe:
> > >           security_execve_abort(current);
> > >
> > >   At least then it is based upon the reality that you plan to revert
> > >   changes to current->security.  Saying anything about creds or bprm =
when
> > >   you don't touch them, makes no sense at all.  Causing people to
> > >   completely misunderstand what is going on, and making it more likel=
y
> > >   they will change the code in ways that will break TOMOYO.
> > >
> > > at https://lkml.kernel.org/r/8734ug9fbt.fsf@email.froward.int.ebieder=
m.org .
> >
> > Yeah, I'd agree with Eric on this: it's not about bprm freeing, it's
> > catching the execve failure. I think the name is accurate -- it mirrors
> > the abort_creds() call.
>
> I'm sorry, but I would still much rather prefer security_bprm_free()
> both to reflect the nature of the caller as well as to abstract away a
> particular use case; this is also why I suggested a different hook
> description for the function header block.
>
> If you really want this to be focused on reverting the execvc changes
> (I do agree with Eric about "revert" over "abort") then please move
> this hook out of free_bprm() and into do_execveat_common() and
> kernel_execve().
>
> To quickly summarize, there are two paths forward that I believe are
> acceptable from a LSM perspective, pick either one and send me an
> updated patchset.
>
> 1. Rename the hook to security_bprm_free() and update the LSM hook
> description as I mentioned earlier in this thread.
>
> 2. Rename the hook to security_execve_revert(), move it into the
> execve related functions, and update the LSM hook description to
> reflect that this hook is for reverting execve related changes to the
> current task's internal LSM state beyond what is possible via the
> credential hooks.

Hi Tetsuo, I just wanted to check on this and see if you've been able
to make any progress?

--=20
paul-moore.com

