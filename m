Return-Path: <linux-fsdevel+bounces-33838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C799BF9B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF55283AF0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 23:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F86120D4FA;
	Wed,  6 Nov 2024 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBMzrZ2L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11651D47B3;
	Wed,  6 Nov 2024 23:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934265; cv=none; b=iH+Y01Q7tTNd07mWm+542RIG94LMY6+DV7tPqkjA+MR/QptL06/P4R8/lUMYTvLH3lxoaLs78i/6r4nBqDXlMhBieUP02bmIbFoslWtH/tprMN0nU/p6ThhL3JRmSUdGv/pRezMwxThffQtksnXaZFYWuG40O42/BmXYy19CVyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934265; c=relaxed/simple;
	bh=LJog0ss1Rq6YixGwiMuVHQWlxNWoDT3i+VL71T8FxKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+y4cM8xX3ighXCNId9kJXxWT6vYM9cqCLHYawDuQ/c6B55YJ0z1GjPQNDQK0KdHnvHlVI4hzcs3h4vrpPKLdfX91P/rZC6ccc3ZwFcsdynVRTq26SZe7HH0qAuep0t9iHj/AuKEE0ReS4boU6T3UE7zjQE+MQYASJQCuirY2yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBMzrZ2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A706C4CED2;
	Wed,  6 Nov 2024 23:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730934264;
	bh=LJog0ss1Rq6YixGwiMuVHQWlxNWoDT3i+VL71T8FxKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iBMzrZ2Lxs447X7LP6KyyU7kbCBWXJzOCt86DVc6GZBJgTzrIC9VdgdaURyeHLL2A
	 jksnfeXOxKErnphvqywFaoJjVNiBLTaRBBOVpWVzdxnCblfzzSiMnGHT3D1K6uYqTb
	 KzumET41TirZSv/w3hN92tt6IzWyFN2D4U15lWxprJLeKqPwEucCMm4Tux8d81DSuX
	 pR6mOv/Bv53mfiE1BV8aeJFgflI98JrEZc5hLoHlfDtBr+zmicIV8GWI5teUSbhPSh
	 9rHrQ7d+FO+bIsniGwSNwVT6bq28RMqT8brjQ4XJpt/BMlfxSMhx2C8irWuGlAgkHw
	 tg6shfLE816Vw==
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a6bc0600f9so1592995ab.1;
        Wed, 06 Nov 2024 15:04:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUE1HkscbAyJWm/rCWAgAZSAfli7Nm0+bwGXL4WVyopgK0vK+Ml5zZ86u8RqdI0/ljffMfQODgiTfZjjnizGQ==@vger.kernel.org, AJvYcCVw7wtdRQq+uKayZmCQHIIQEfPy044411aI8r9WjEr4e1j+5kO7+8oxQTeWpl47NqDJfEE=@vger.kernel.org, AJvYcCXxp/HogQgqTfN5iL8BRxfYXegL3e7bNQv1E6GAAlMnzgXIN3J5+c9WLoDwvsOHByRq5TxCNmiXYrpeojcV@vger.kernel.org
X-Gm-Message-State: AOJu0YyQRktIpjqHors10ZMFHVGpC2sGzFGeVOhHhsa55E7NyPd5G0la
	ABtVzX30x1SzEteF4iPWJEfWe/QyEVpbN3Vpn7kqAJZC5Ex6T+CbfI8YKqtQeW7WzC5sYvLxk1y
	Qwm7Ca+6CzLcoJvtk4YzixanjGNM=
X-Google-Smtp-Source: AGHT+IFwH6T6YoQjGsGSHlqwd7YfbHj26gx1oEoml5lDFSTRj2K7ACZ45RLiwSQ0zhbxDoWsuV/whyZrlOg2pp/ISGM=
X-Received: by 2002:a05:6e02:1a05:b0:3a0:9952:5fcb with SMTP id
 e9e14a558f8ab-3a5e2513773mr305863725ab.17.1730934263802; Wed, 06 Nov 2024
 15:04:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAEf4BzZJuWcCLeUdmzhRVe9nyi9jAN8y=u2nK=mqzxXG6DTkDw@mail.gmail.com> <AM6PR03MB58481666F9D89607DFDD4C4F99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB58481666F9D89607DFDD4C4F99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Song Liu <song@kernel.org>
Date: Wed, 6 Nov 2024 15:04:12 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6ud21v2xz8iSXf=CiDL+R_zpQ+p8isSTMTw=EiJQtRSw@mail.gmail.com>
Message-ID: <CAPhsuW6ud21v2xz8iSXf=CiDL+R_zpQ+p8isSTMTw=EiJQtRSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] bpf/crib: Add open-coded style process
 file iterator and file related CRIB kfuncs
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, 
	snorcht@gmail.com, brauner@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 2:49=E2=80=AFPM Juntong Deng <juntong.deng@outlook.c=
om> wrote:
>
[...]
> >
> > CRIB is just one of possible applications of such kfuncs, so I'd steer
> > away from over-specifying it as CRIB.
> >
> > task_file open-coded iterator is generic, and should stay close to
> > other task iterator code, as you do in this revision.
> >
> > bpf_get_file_ops_type() is unnecessary, as we already discussed on v2,
> > __ksym and comparison is the way to go here.
> >
> > bpf_fget_task(), if VFS folks agree to add it, probably will have to
> > stay close to other similar VFS helpers.
> >
>
> Yes, I agree.
>
> Maybe we should put it in fs/bpf_fs_kfuncs.c?

fs/bpf_fs_kfuncs.c is a good place for bpf_fget_task().

Please note that currently all kfuncs in fs/bpf_fs_kfuncs.c are only
available to BPF LSM programs. We need to make some of them,
including bpf_fget_task, available to tracing functions.

Thanks,
Song

