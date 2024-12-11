Return-Path: <linux-fsdevel+bounces-37107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8F39ED95B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 23:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CE518858A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 22:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BC21F2381;
	Wed, 11 Dec 2024 22:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoVU9NgK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D071EBFF9;
	Wed, 11 Dec 2024 22:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954785; cv=none; b=fJmQzoOBUqhkzEHNt3vKdL2AlBbnXHAUdSJ6d+uY6lNhwt819yqo6gdU0io6kjUmvX6qH5Er1LB5fiy9oIz25DJuVwXhpO8TmPuMjB5bOpuz/2L+8jP5LoQdLrtd220iQNCOkEsKIbBKJ6BY+sQxvREoxPaKCFaPpRE9ehsDHUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954785; c=relaxed/simple;
	bh=X4EAtAS1OhfURbSQQzDqxSCgSCBbt3AFd+kJZ8cZ/3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Txk0HUhUVUNmcXMpHbWUg6B46NuX3n5ebT+dZxFYRkF3kZn2Rk5eZnhYkM1j3Sk5u8Tg1vmoIszrv+jTV1zhH5R4uVsAW3+pUXv0ktdKFuTdGaMY5c3cZf6+ikVp4Ud7ozS639H5Zh+ecprU7SaxFLjzarDgVH8Eq3JS92PBMMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoVU9NgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06607C4CEDD;
	Wed, 11 Dec 2024 22:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733954785;
	bh=X4EAtAS1OhfURbSQQzDqxSCgSCBbt3AFd+kJZ8cZ/3A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LoVU9NgKsi7cXEjDOhpJ6k3JTcNUGDLZ2U+w8Mv9E096MrZMxbWUpu/5FrsTHs1Pj
	 Y5Xgi4gSwshUDLao9Iu3/AeksqB6Kxfa+a1NzHWE6I4Xn7zRCcWHKrGLMSkiwHPPm+
	 9vidJrytVUaTc4zj8JybO21Oig81n+5Mvn7oHxtnRibwOkeSfGR11RfJhcOzw6CiOf
	 pOxKiJI6HQ6FZFLXExeSH5GOhqsIKANZ8hU8fxYkxzfKV0uPHQc8v+2dULNOOQjuOi
	 atNlkzOOWpIe30ihdzd11PBQisYfGzFUqlwRwurnsdYZoGb4igBuxpWiYdd890oJma
	 bflRm7chrPYsA==
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a7750318a2so49229515ab.2;
        Wed, 11 Dec 2024 14:06:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW05+biaN49R9M9a22i15LMEkgDXZV3dGjIn7l3dR9TyiyO98f16P3chF9RodhvwTRuF61lpO8TRcMpmAHv@vger.kernel.org, AJvYcCWSo8Spqu9t/0hAFACqC/3pJWQuz6oI2ZCdxwr8L9h9BncYL5yd9QJu3/5KLuwrPiVfEuSrCyebO9uwp2WZeg==@vger.kernel.org, AJvYcCXd07WXeO2lFKRtT87sGG/YQxwfi6uwfI6vXLDvgQBjDZHcyiFkaSObZ3DBMpL1DC5eBWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzce0CjsG/nSsNX+JgO2m0TnCri3jlLQRW+M5H9lIvWDjeG7zWj
	cju/F3KHhJne19zoHkXKWT8YLoNX/wEo/dLZ1Ek2HawNSqzlwKYa0jJCBiPu4hpO1PAGZg1BkxR
	VKBkFMlQcAW/lBexhaHor1u5mDpY=
X-Google-Smtp-Source: AGHT+IHcWmShjsdK3EuqFjW+nJ/cJcTka/NlBTJUCBn8D2V4rX44id9mnYO0/aPgX+UeM8VEnscOLz//8NTC0Ad7KKo=
X-Received: by 2002:a05:6e02:1806:b0:3a3:4175:79da with SMTP id
 e9e14a558f8ab-3ac48d9eccamr11079115ab.13.1733954784384; Wed, 11 Dec 2024
 14:06:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50804FA149F08D34A095BA28993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20241210-eckig-april-9ffc098f193b@brauner> <CAADnVQKdBrX6pSJrgBY0SvFZQLpu+CMSshwD=21NdFaoAwW_eg@mail.gmail.com>
 <AM6PR03MB508072B5D29C8BD433AD186E993E2@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB508072B5D29C8BD433AD186E993E2@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Song Liu <song@kernel.org>
Date: Wed, 11 Dec 2024 14:06:13 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7zZuHf6dgDpYnibONoKt0p=zb0wCta1R1MtLv=Q=4FfA@mail.gmail.com>
Message-ID: <CAPhsuW7zZuHf6dgDpYnibONoKt0p=zb0wCta1R1MtLv=Q=4FfA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: Make fs kfuncs available for SYSCALL
 and TRACING program types
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:29=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> On 2024/12/10 18:58, Alexei Starovoitov wrote:
> > On Tue, Dec 10, 2024 at 6:43=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> >>
> >> On Tue, Dec 10, 2024 at 02:03:53PM +0000, Juntong Deng wrote:
> >>> Currently fs kfuncs are only available for LSM program type, but fs
> >>> kfuncs are generic and useful for scenarios other than LSM.
> >>>
> >>> This patch makes fs kfuncs available for SYSCALL and TRACING
> >>> program types.
> >>
> >> I would like a detailed explanation from the maintainers what it means
> >> to make this available to SYSCALL program types, please.
> >
> > Sigh.
> > This is obviously not safe from tracing progs.
> >
> >  From BPF_PROG_TYPE_SYSCALL these kfuncs should be safe to use,
> > since those progs are not attached to anything.
> > Such progs can only be executed via sys_bpf syscall prog_run command.
> > They're sleepable, preemptable, faultable, in task ctx.
> >
> > But I'm not sure what's the value of enabling these kfuncs for
> > BPF_PROG_TYPE_SYSCALL.
>
> Thanks for your reply.
>
> Song said here that we need some of these kfuncs to be available for
> tracing functions [0].

I meant we can put the new kfuncs, such as bpf_get_file_ops_type, in
bpf_fs_kfuncs.c, and make it available to tracing programs. But we
cannot blindly make all of these kfuncs available to tracing programs.
Instead, we need to review each kfunc and check whether it is safe
for tracing programs.

Thanks,
Song

> If Song saw this email, could you please join the discussion?
>
> [0]:
> https://lore.kernel.org/bpf/CAPhsuW6ud21v2xz8iSXf=3DCiDL+R_zpQ+p8isSTMTw=
=3DEiJQtRSw@mail.gmail.com/

