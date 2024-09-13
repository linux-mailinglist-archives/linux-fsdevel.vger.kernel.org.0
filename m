Return-Path: <linux-fsdevel+bounces-29273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8989776D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 04:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E741C2437A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 02:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436731D31BC;
	Fri, 13 Sep 2024 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d38hknNr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4432A84D2C;
	Fri, 13 Sep 2024 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726194055; cv=none; b=qssX6wwaS4VUX3EWXaiZcLGWhSC4MvqKSe/G7n3BK+ugmgFPEtBFcoCSu2cg8l7zQWfiQxKk3nlNkFNfWmt3FMhYUpOK7G8WeOQDhJxCG3bI3/gif7CNGJ1SlWq0B/p9r/W87PzC11rr4J06pAtiyNOdPpcT1p+SP6yoLj1j20I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726194055; c=relaxed/simple;
	bh=ty3xYTxWvBQ0iNr/gp4gzxWMHqmses0ZJVOBK3pt0qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAFCWoWjtTy9ahzAAKCMnG/tWBriziWT8LTdTBfqPkcb39dEL34dslYPuep1YzcNfxO7SwsJ0psbqk1Skyj5463O8COhvo6ULcUJ9TMcwsuYesAmC53SBjahcRfbafgzMs4MMATmLvcPpMCUdtqctPOBb3oztEPeYIqm6ACpKGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d38hknNr; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c35427935eso9488536d6.3;
        Thu, 12 Sep 2024 19:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726194053; x=1726798853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YuGlKzxhtY5rBL2eIZIp8+LMnunU1KOYKGMKR0vy8Y=;
        b=d38hknNr/z4owc9IOMCwIhnhymdWN9dCFImGKnORv27pu5pUc5Z9wv8hfWONf7AjHu
         xOGba8M595eXv5ElYOK5f5GDox41jQP31xr3myHVk6I2gh+My4rqvXBHQnGlZt5FhnI1
         BXLiu7Ox+EjZ2Dwl8PE40hGo9eY3kldvtg4NjtXucNGmYpwqMiS7tNjwPokZaRdwgNOS
         m+XHjqcE1KmBXqayM7FZiAYK1Mv6XDlBkP5E62IXASpEOgQQjKya62yfsvs8Nyzwg73p
         fk8fNIP14gzB4k4hopVKBzMeGEReIgBIGU2mXfdgayc2YzbJe9BZYBV73Nr4CV3vh5yo
         k26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726194053; x=1726798853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YuGlKzxhtY5rBL2eIZIp8+LMnunU1KOYKGMKR0vy8Y=;
        b=AVQtXE63rVZ6QCYJq0Fidm6JURHQiXYYRMSVK0DNYGLyhXUQi6hqY3B+VnUu9xxQ+F
         +O00UP8MpT4RKCKzet9r3Kb/HlmCLfw3GYJzkb6sb1BC+wpk7GD0sKMCCJfr8xK7g02w
         vCOW6mUOSN/a9Yi9z/7i3IAV9q4Pn/gzMQi89NBsrotwH7TpbNzHYrc+/Vjc27iGgVsH
         fWwvJZD+zxgeU13ncABNojTVDDvLa6HKG4daDeWmpN8zxahJKS2kiwOkh+RNxMfeAyg3
         bLMLqK6hBO8oSNF4foTNK0Ctxn/Ap2EnJLyw2Gwtg+ScyUHJOapiaPSemODG3/8OhGG2
         eJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPMZu5+ooJqWgjDLnGJKR4SRXhcekX9/gdMaHJlq+/5FjNw5C0YWoxe05glNoT2noq+GAsnKO3MPDFIx2aog==@vger.kernel.org, AJvYcCVTRrzVZ8fqcYR0P9W/Ag/vvrwD3D1X9MLkGjUqbVrZvEhefLPtIQJo740ccBU/QKa8g1WOhENyUo39E9gqJIN9GmpN@vger.kernel.org, AJvYcCVbv07GQmG4x1koNK3wVSw6tLQKsH8Kq52kpg65eIfmkLuRCXPtmIF3n1VWJpdI8109YzcR/tsK@vger.kernel.org, AJvYcCVhNIGo3TIqI45B5+TSQhB7LE63+0r1/zTKP03NN+LSPVwTOCTnX4ehkAqTurgcYhp53/9oWg==@vger.kernel.org, AJvYcCWL4+P6Bx2lYYTuPQhZAloWAU0gTDT6j9ev+Ct2wONQTwtf4ueFBPH9xTm4XqQtiVeLuoDFxYm5vLoxnCsti9LhOjo3zNnJ@vger.kernel.org, AJvYcCXSdnSvKL4NOczUzVMxoi0xvMzJktiJZfeTXmYBp1W/dPEbKYPRNLb6TuwIoR4wkpukfsAp@vger.kernel.org, AJvYcCXcA2SYDDH1fIE8JaOUX6fmIHRuBbgEc8gfGao/U+Nwp+nlWtJgGIjz/YqBc2Va1+Bz+NH+Be81Uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YycGRE4PSjJ7J9hQjXttPR/HFr9bl9LAGt3nMg0GeStSbxpedme
	sURj9Lt0yhx1JLdGbKZNYAUYYlYz4UOR83ufR7u0I9cYIf+duZAzNfTDuGt1ppdv4s53WSuTNko
	m6FKpaaPbuwcsfT4x4oqACTtGsYw=
X-Google-Smtp-Source: AGHT+IEALOyw7njQRSkttfTBxiECARy2DIo72UCyaA7S1zsv/zTsiW7a3znz7/TXgkua05e1Jrm3oxglJjkOnal6MfM=
X-Received: by 2002:a05:6214:4886:b0:6c5:30c9:c055 with SMTP id
 6a1803df08f44-6c57355ac2dmr79834256d6.14.1726194053000; Thu, 12 Sep 2024
 19:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828030321.20688-1-laoar.shao@gmail.com> <20240828030321.20688-5-laoar.shao@gmail.com>
 <ozoyqz5a7zssggowambojv4x6fbhdl6iqjopgnycca223jm6sz@pdzdmshhdgwn>
In-Reply-To: <ozoyqz5a7zssggowambojv4x6fbhdl6iqjopgnycca223jm6sz@pdzdmshhdgwn>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 13 Sep 2024 10:20:16 +0800
Message-ID: <CALOAHbD0eEOPft2E_RwxrdB0aHC_qV9JGjA2NJvhYeNy1joDRA@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] bpftool: Ensure task comm is always NUL-terminated
To: Justin Stitt <justinstitt@google.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, alx@kernel.org, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 5:14=E2=80=AFAM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Hi,
>
> On Wed, Aug 28, 2024 at 11:03:17AM GMT, Yafang Shao wrote:
> > Let's explicitly ensure the destination string is NUL-terminated. This =
way,
> > it won't be affected by changes to the source string.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Reviewed-by: Quentin Monnet <qmo@kernel.org>
> > ---
> >  tools/bpf/bpftool/pids.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
> > index 9b898571b49e..23f488cf1740 100644
> > --- a/tools/bpf/bpftool/pids.c
> > +++ b/tools/bpf/bpftool/pids.c
> > @@ -54,6 +54,7 @@ static void add_ref(struct hashmap *map, struct pid_i=
ter_entry *e)
> >               ref =3D &refs->refs[refs->ref_cnt];
> >               ref->pid =3D e->pid;
> >               memcpy(ref->comm, e->comm, sizeof(ref->comm));
> > +             ref->comm[sizeof(ref->comm) - 1] =3D '\0';
>
> ...
>
> >               refs->ref_cnt++;
> >
> >               return;
> > @@ -77,6 +78,7 @@ static void add_ref(struct hashmap *map, struct pid_i=
ter_entry *e)
> >       ref =3D &refs->refs[0];
> >       ref->pid =3D e->pid;
> >       memcpy(ref->comm, e->comm, sizeof(ref->comm));
> > +     ref->comm[sizeof(ref->comm) - 1] =3D '\0';
>
> Excuse my ignorance, do we not have a strscpy() equivalent usable in bpf
> code?

To my knowledge, there is no direct equivalent of the standard
strcpy() function available in bpftool or libbpf code.

--=20
Regards
Yafang

