Return-Path: <linux-fsdevel+bounces-24349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F6093DAD1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 00:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FFB28447E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 22:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DDF14F10E;
	Fri, 26 Jul 2024 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wc3rdS1E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC7F14B07B;
	Fri, 26 Jul 2024 22:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722034140; cv=none; b=MOTpUYOfFlaybfpWz02/mqEoTTwbPJxKWaEPFtV9+h49klZYmVwHcjkumtDMMfQtdJ0aTRusYw/gib5IwhU0ZSun1j6K7RqiykjEckRlsmlUX8F51XHNeVl+gZ2SAso3zv/Vaorpjj2fAbzVfgYP1EEHlCaYBaOqXR6aO9qYN9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722034140; c=relaxed/simple;
	bh=UeXNi5/5x+ORsAToXewzwwH6ezZJLc/ceAiTjgU3wHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJeB2tKsOHMqmnuEwm/gXT6W21OmGQwqIlVaQRMPH36KDVI/YZvYwYOhwQ3lD2zpunjhOGvG1WqlXMprn4WiD9Ho5z+o6RfkR8rHVY6Z4JcVjvbTChnWgmGEpIZGzCqBwDK/czioRRO5rgPd8I0gK1JwcLnPhht/LXGMw27g020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wc3rdS1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9B2C4AF0E;
	Fri, 26 Jul 2024 22:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722034139;
	bh=UeXNi5/5x+ORsAToXewzwwH6ezZJLc/ceAiTjgU3wHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wc3rdS1EsFEHbKeUbjxGmwK6jXbfCiuqrHQNxjPaSx3i0PtC1007lCJnbQJq0VSCO
	 jlWof+u5Wehm008aiag/QjL4mN/aWCoA81Hxy7oVgZObUNYC5TRR8dRm2rIaptXgpM
	 jK6MMmo9h2jt+jl5pfmbiwH0E5oEGETVpV5vj0shGR/d619cHT0iGrIEbwraWBL2RF
	 o36sGCrXqsL1tNmxT8xI4/Xnw01/PdlaBXVPQJeBtJNyrbJyDax8tteE/YlTdy9jaE
	 m0vDXswU1B8mWqvttOWpdpLWitDK7INm0y94vOEPPJtCbXRBWNCbYwVqauOX74uW5l
	 61su0XThyu82g==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f025b94e07so21396391fa.0;
        Fri, 26 Jul 2024 15:48:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaDCFm+8DW7h64FXjqS/RlKrVQd377dcPGhmIeIFek9azvC0YR7YBmDKYyRNlzrqnzxLlZAWNGbqn59o+uJA2l68MjrUMZIjXEUMSutw==
X-Gm-Message-State: AOJu0YxglPvt/g24UMHM9KZZgzfudunD/8TDf8I35sozXkM4FNozTl7E
	nyqprLtunzq3DnbrZRZb13v7Hm8aI4H6H4lXjsb4jrpA1nofcCSeeP3u9yAiA8YcOvteh5HliJC
	pAIm7XZMemF9iNpue1zcNlietN8k=
X-Google-Smtp-Source: AGHT+IHp2jaSjOho6TFn36kgJIa/KvBGKr2LaHosGV1q44KSQk68+IQued9vIPPb2FrDce0lbBKKgA5FXXjdwPd2xbM=
X-Received: by 2002:ac2:4db2:0:b0:52c:e086:7953 with SMTP id
 2adb3069b0e04-5309b269bedmr662385e87.4.1722034137877; Fri, 26 Jul 2024
 15:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726085604.2369469-1-mattbobrowski@google.com>
 <20240726085604.2369469-2-mattbobrowski@google.com> <CAPhsuW7fOvLM+LUf11+iYQH1vAiC0wUonXhq3ewrEvb40eYMdQ@mail.gmail.com>
 <ZqQZ7EBooVcv0_hm@google.com>
In-Reply-To: <ZqQZ7EBooVcv0_hm@google.com>
From: Song Liu <song@kernel.org>
Date: Fri, 26 Jul 2024 15:48:45 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4i_+xoWXKcPvmUidNBuN7f1rLzfvn7uCSpyk9bbZb67A@mail.gmail.com>
Message-ID: <CAPhsuW4i_+xoWXKcPvmUidNBuN7f1rLzfvn7uCSpyk9bbZb67A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: introduce new VFS based BPF kfuncs
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, kpsingh@kernel.org, andrii@kernel.org, 
	jannh@google.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	jolsa@kernel.org, daniel@iogearbox.net, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 2:49=E2=80=AFPM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> On Fri, Jul 26, 2024 at 02:25:26PM -0700, Song Liu wrote:
> > On Fri, Jul 26, 2024 at 1:56=E2=80=AFAM Matt Bobrowski <mattbobrowski@g=
oogle.com> wrote:
> > >
> > [...]
> > > +       len =3D buf + buf__sz - ret;
> > > +       memmove(buf, ret, len);
> > > +       return len;
> > > +}
> > > +__bpf_kfunc_end_defs();
> > > +
> > > +BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> > > +BTF_ID_FLAGS(func, bpf_get_task_exe_file,
> > > +            KF_ACQUIRE | KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_RET_NUL=
L)
> > > +BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE | KF_SLEEPABLE)
> >
> > Do we really need KF_SLEEPABLE for bpf_put_file?
>
> Well, the guts of fput() is annotated w/ might_sleep(), so the calling
> thread may presumably be involuntarily put to sleep? You can also see
> the guts of fput() invoking various indirect function calls
> i.e. ->release(), and depending on the implementation of those, they
> could be initiating resource release related actions which
> consequently could result in waiting for some I/O to be done? fput()
> also calls dput() and mntput() and these too can also do a bunch of
> teardown.
>
> Please correct me if I've misunderstood something.

__fput() is annotated with might_sleep(). However, fput() doesn't not
call __fput() directly. Instead, it schedules a worker to call __fput().
Therefore, it is safe to call fput() from a non-sleepable context.

Thanks,
Song

