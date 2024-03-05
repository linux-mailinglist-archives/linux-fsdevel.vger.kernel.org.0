Return-Path: <linux-fsdevel+bounces-13645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58118872578
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 18:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80772B21B9E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 17:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAE51758F;
	Tue,  5 Mar 2024 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aanUvFDM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCFB17583
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658862; cv=none; b=BOXpS2Sa+xHoBR8psZbWBVoORMhsAm6sSTvlt9nkhRPEoM38NkJEFZ92nz89rrzTdJ5az6n5M6e4TMCSRezuxlfyLWyYUVYejjni8fSnpqoqtF2H/PuGQAut51SEru0q2IN8CjIShqu5imWc/69eegx6lDQz+mXvHBxnALE4zLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658862; c=relaxed/simple;
	bh=wc8h8ElvELoqiIs99dRWA9TPub+31Jl541MIwckqRx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASZKY1x4sUt48h6lkniTo7lELSR2Ft1fexJxFrQtJ4vaB6YUuTi8ATFUYU74xZac2MVoVDn6NRJ4ailKOzaiA9a1fMUCle3tdjMLcFg9kCj2J5PIeRLXzUwf8fmfwXk7BaXP9X1JF6lUx6ftwywt4zj5fm8q8XKM4fDoY6wQUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aanUvFDM; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42ed3bdd680so17960101cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 09:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709658860; x=1710263660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzO6p1wDOtrZv3xxgkOAAE38ISSfe9uB/wFAD09RgmE=;
        b=aanUvFDMYVvTuXzudwct/sSE0SA/rENy8tMr2ih1gVWjOt09McFmBvDryfNYatNhrD
         rHjM1R7QmqIlOFXRlPqfaccFGmj4e6uXMDlVgQ9LsJanGSHjOrXJMurctEulssV+Y+93
         9eFDPbXQ6Uv5fzpcTQILGAvNPjoODzn5vdyw//k1F/9dL1q5UJXcBf26a7f3RUz0IxgX
         Kp8AkOyUGS9fKIUTJvJF2pPms1jBVC35qNydOUklWQQUUBYVW2H9ajDa++sj8TugFQD4
         P8ebSvJ8ALGFZlQo66mgpToxFiMdEeRJZJKebuQ7cgSdrKMZaRWhrKKmJ2PEPOMpLin7
         JjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709658860; x=1710263660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzO6p1wDOtrZv3xxgkOAAE38ISSfe9uB/wFAD09RgmE=;
        b=txFWRgc7uqC08r0QHo0+FqkUUTDB+K39IunxNlLzJc4XCLn+XMiV4mbEEwujOdUNQL
         GM7LEiaMYTyUGyB1uiLCThe7AgtrHd2lDQik3R8RGR8hloH5xxNVjLV5XLLZkb2AimO1
         3f8VjEUTjA/99izxbNJStgc0xNGb1SnzmieepDlilCpG2xLb8NyTwrXOktoWwkDed4am
         42eylLrpmadgDTqvypz93hJrJz3Xem+WVKSMAG8x6LyeTNLZuFEYKih8XzzHVKQEljx5
         Afq5JL2SUl4muACv49Xqx3mKVV8XElwoOkz/BwXsXUuNX7mTiQAWmFxqOvhsKeZokpGt
         NKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2QfrxDftzTSAnfUg1AtuKNu0uim0vqp/LDhAAUBPowmIXljo0wKR3uIHvGkM7eGyidDUzskRPopjtOlz4JDoQqLhOPIDq8cVQIGftTg==
X-Gm-Message-State: AOJu0Yw5DKC2gM88LF62PA1aR/vXd9oUSgn6em0UZ8hW2Y9UQmyBICSc
	2EtOYFHHZORKwQ04uAZ6taiD0MgYn455o3PaVy0nCk4wPx7DV6e1QdVcND2xpw9WOmYdVeP/HpM
	IwsppdH9KhT+0oRexUsxDuPyi0Ls=
X-Google-Smtp-Source: AGHT+IGb4N9lNzUzj8heqiwU42ylZZY49XgpTxbB7CLRdg/QJKbeHDM1sd4/+4Jq17y6jt5IB3yP5dAlllKsGeCH4t0=
X-Received: by 2002:ac8:5ad3:0:b0:42e:6de7:35e2 with SMTP id
 d19-20020ac85ad3000000b0042e6de735e2mr2675683qtd.25.1709658860028; Tue, 05
 Mar 2024 09:14:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229174145.3405638-1-meted@linux.ibm.com> <CAOQ4uxh+Od_+ZuLDorbFw6nOnsuabOreH4OE=uP_JE53f0rotA@mail.gmail.com>
 <fc1ac345-6ec5-49dc-81db-c46aa62c8ae1@linux.ibm.com> <CAOQ4uxje7JGvSrrsBC=wLugjqtGMfADMqUBKPhcOULErZQjmGA@mail.gmail.com>
 <1423c8eb-4646-4998-8e6a-43f9f8dd8be5@linux.ibm.com>
In-Reply-To: <1423c8eb-4646-4998-8e6a-43f9f8dd8be5@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 5 Mar 2024 19:14:08 +0200
Message-ID: <CAOQ4uxgRFVK70c7Pquq_1iqM4Q7XdT7w_Dk0U+WGaeuA3wXrTg@mail.gmail.com>
Subject: Re: [PATCH] fanotify: move path permission and security check
To: Mete Durlu <meted@linux.ibm.com>
Cc: jack@suse.cz, repnop@google.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 3:57=E2=80=AFPM Mete Durlu <meted@linux.ibm.com> wro=
te:
>
> On 3/2/24 10:58, Amir Goldstein wrote:
> > On Fri, Mar 1, 2024 at 3:16=E2=80=AFPM Mete Durlu <meted@linux.ibm.com>=
 wrote:
> >>
> >> On 3/1/24 10:52, Amir Goldstein wrote:
> >>> On Thu, Feb 29, 2024 at 7:53=E2=80=AFPM Mete Durlu <meted@linux.ibm.c=
om> wrote:
> >>>>
> >>>> In current state do_fanotify_mark() does path permission and securit=
y
> >>>> checking before doing the event configuration checks. In the case
> >>>> where user configures mount and sb marks with kernel internal pseudo
> >>>> fs, security_path_notify() yields an EACESS and causes an earlier
> >>>> exit. Instead, this particular case should have been handled by
> >>>> fanotify_events_supported() and exited with an EINVAL.
> >>>
> >>> What makes you say that this is the expected outcome?
> >>> I'd say that the expected outcome is undefined and we have no reason
> >>> to commit to either  EACCESS or EINVAL outcome.
> >>
> >> TLDR; I saw the failing ltp test(fanotify14) started investigating, re=
ad
> >> the comments on the related commits and noticed that the fanotify
> >> documentation does not mention any EACESS as an errno. For these reaso=
ns
> >> I made an attempt to provide a fix. The placement of the checks aim
> >> minimal change, I just tried not to alter the logic more than needed.
> >> Thanks for the feedback, will apply suggestions.
> >>
> >
> > Generally speaking, the reasons above themselves are good enough
> > reasons for fixing the documentation and fixing the test code, but not
> > enough reasons to change the code.
> >
> > There may be other good reasons for changing the code, but I am not
> > sure they apply here.
> >
>
> I understand the concerns and the reasoning. My findings and suggestions
> are below.
>
> >>
> >> The main reason is the following commit;
> >> * linux: 69562eb0bd3e ("fanotify: disallow mount/sb marks on kernel
> >> internal pseudo fs")
> >>
> >> fanotify_user: fanotify_events_supported()
> >>       /*
> >>        * mount and sb marks are not allowed on kernel internal pseudo
> >>            * fs, like pipe_mnt, because that would subscribe to events=
 on
> >>            * all the anonynous pipes in the system.
> >>        */
> >>       if (mark_type !=3D FAN_MARK_INODE &&
> >>           path->mnt->mnt_sb->s_flags & SB_NOUSER)
> >>           return -EINVAL;
> >>
> >> It looks to me as, when configuring fanotify_mark with pipes and
> >> FAN_MARK_MOUNT or FAN_MARK_FILESYSTEM, the path above should be taken
> >> instead of an early return with EACCES.
> >>
> >
> > It is a subjective opinion. I do not agree with it, but it does not mat=
ter if
> > I agree with this statement or not, what matters it that there is no cl=
ear
> > definition across system calls of what SHOULD happen in this case
> > and IMO there is no reason for us to commit to this behavior or the oth=
er.
> >
> >> Also the following commit on linux test project(ltp) expects EINVAL as
> >> expected errno.
> >>
> >> * ltp: 8e897008c ("fanotify14: Test disallow sb/mount mark on anonymou=
s
> >> pipe")
> >>
> >> To be honest, the test added on above commit is the main reason why I
> >> started investigating this.
> >>
> >
> > This is something that I don't understand.
> > If you are running LTP in a setup that rejects fanotify_mark() due to
> > security policy, how do the rest of the fanotify tests pass?
> > I feel like I am missing information about the test regression report.
> > I never test with a security policy applied so I have no idea what
> > might be expected.
> >
> Ah, I always run with defconfig which has SELINUX enabled and by default
> SELINUX is configured to `enforcing` (so far I tested with x86 and s390x
> but a quick grep shows most other architectures also have it enabled on
> their defconfigs). With SELINUX enabled LTP's fanotify14 shows failures
> on
>
> fanotify14.c:284: TINFO: Testing FAN_MARK_MOUNT with anonymous pipe
> fanotify14.c:284: TINFO: Testing FAN_MARK_FILESYSTEM with anonymous pipe
>
> since they return -EACCES instead of -EINVAL.Other test cases pass.
> Once I disable SELINUX, ALL test cases pass.
>
> >>>
> >>> If we do accept your argument that security_path_notify() should be
> >>> after fanotify_events_supported(). Why not also after fanotify_test_f=
sid()
> >>> and fanotify_test_fid()?
> >>
> >> I tried to place the checks as close as possible to their original
> >> position, that is why I placed them right after
> >> fanotify_events_supported(). I wanted to keep the ordering as close as
> >> possible to original to not break any other check. I am open to
> >> suggestions regarding this.
> >>
> >
> > It is a matter of principle IMO.
> > If you argue that access permission errors have priority over validity
> > of API arguments, then  fanotify_test_{fsid,fid}() are not that much
> > different (priority-wise) from fanotify_events_supported().
> >
> > My preference is to not change the code, but maybe Jan will
> > have a different opinion.
>
> I understand the argument, then I propose patching the LTP and appending
> the documentation. My first idea is to send a patch for LTP so that,
> fanotify14 could check if SELINUX is enforcing and change the testcases
> expected errno accordingly. How does that sound?

LTP patch sounds good to me.
How to fix the test to support SELINUX it will be up to LTP maintainers
to comment.

Thanks,
Amir.

