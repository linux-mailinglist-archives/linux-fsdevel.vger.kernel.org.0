Return-Path: <linux-fsdevel+bounces-3964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6887FA7D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 18:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7317B20FE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 17:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297A2374E9;
	Mon, 27 Nov 2023 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXuNZeuL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6462731A7F;
	Mon, 27 Nov 2023 17:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07924C433CC;
	Mon, 27 Nov 2023 17:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701105407;
	bh=Z3mxDdL+PqtA5yH4uMuYEk7MynKzhH/smSi/F1rtE9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lXuNZeuLJCg63BOS4ss7Wt8rZEIywAcpSSKZBh5TRbzs5Mr2vZ5doOw2df+2WHN5o
	 Gzp3PHA+x6DuH02m1C4/wap/6TL9i6k7/sp9h0ihgTftEkk32YTCZt409LvnfCEtUA
	 itS7AsiywMtafK9vnHIEk5ZaDXe5ii2ROlcb6giBFxiSNBBEHEhqCjt9XD3dyYFib5
	 Lid/+GSnv83MDpNjmJVG7RiOLtGdgWYen2Uo0a6uk5Z9e9AsxDRYU9a7G3/DFGVrrM
	 a6Ytwjwhi7VTzBI1pxcsP06QGmQ4vdygE20GOvhhEhbEHbSma1jIMVapdVUqo5P/0L
	 YxaOYQQh4pz/Q==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50aab0ca90aso6460337e87.0;
        Mon, 27 Nov 2023 09:16:46 -0800 (PST)
X-Gm-Message-State: AOJu0YwvW+Iu1mno0FNmjpDYeCjz1YjrE9oT39Xx/6AkiCLzB8Ecd7bm
	B1QsveAMuPorljUpS3dEVgYHNDAlSK1i0kDvPt8=
X-Google-Smtp-Source: AGHT+IE94nVGO+Nt+JsTf2kcz8yM3o+hyvAYX3KAh+Mc2jj7ivqZIujRneJNEfFqdSqJg23Z63EuFI5EGGcU4nJQ2dY=
X-Received: by 2002:ac2:532f:0:b0:505:6cc7:e0f7 with SMTP id
 f15-20020ac2532f000000b005056cc7e0f7mr8104295lfh.44.1701105405175; Mon, 27
 Nov 2023 09:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123233936.3079687-1-song@kernel.org> <20231123233936.3079687-6-song@kernel.org>
 <CAADnVQKHTdGiBFh_sVr+jdsA8di8i4HHivp98QCOnHZGoHAW5Q@mail.gmail.com>
In-Reply-To: <CAADnVQKHTdGiBFh_sVr+jdsA8di8i4HHivp98QCOnHZGoHAW5Q@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 27 Nov 2023 09:16:32 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6GhuX_pprU-182vg6D1hRktd0sMoELCe0_uLNwSdhPqA@mail.gmail.com>
Message-ID: <CAPhsuW6GhuX_pprU-182vg6D1hRktd0sMoELCe0_uLNwSdhPqA@mail.gmail.com>
Subject: Re: [PATCH v13 bpf-next 5/6] selftests/bpf: Add tests for filesystem kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, fsverity@lists.linux.dev, 
	Eric Biggers <ebiggers@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, 
	Amir Goldstein <amir73il@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 6:09=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 23, 2023 at 3:40=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > +static const char expected_value[] =3D "hello";
> > +char value[32];
> > +
> > +SEC("lsm.s/file_open")
> > +int BPF_PROG(test_file_open, struct file *f)
> > +{
> > +       struct bpf_dynptr value_ptr;
> > +       __u32 pid;
> > +       int ret;
> > +
> > +       pid =3D bpf_get_current_pid_tgid() >> 32;
> > +       if (pid !=3D monitored_pid)
> > +               return 0;
> > +
> > +       bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
> > +
> > +       ret =3D bpf_get_file_xattr(f, "user.kfuncs", &value_ptr);
> > +       if (ret !=3D sizeof(expected_value))
> > +               return 0;
> > +       if (bpf_strncmp(value, ret, expected_value))
>
> Hmm. It doesn't work like:
> if (bpf_strncmp(value, ret, "hello"))

This also works. I used expected_value because there is a size
check above. We can also make do something like

if (ret !=3D sizeof("hello"))
             return 0;
if (bpf_strncmp(value, ret, "hello"))
             return 0;

Both of the two work.

Thanks,
Song

