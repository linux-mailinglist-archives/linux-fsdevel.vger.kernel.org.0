Return-Path: <linux-fsdevel+bounces-50398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75031ACBDE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 02:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC131891772
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 00:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8649779EA;
	Tue,  3 Jun 2025 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDIBmkBm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584D819;
	Tue,  3 Jun 2025 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748909434; cv=none; b=RB2lIu4DJ2DqQBg7lz3FNhq/c2HBrFz7m1dNAYY1La9wD7d9/xb10ksxPCUmv8LiuQApXlyQPKS0bLS3H8ji0xgsggftXWw+Qp+qUjCa/dAvg2lNmjFQ67ijTXN2ZHmW/ol2InQu+em7oIjz/FWDjFipYE1qzq0LhrdnfVZ3oeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748909434; c=relaxed/simple;
	bh=uGA87I1mzavJRknA7wPlXknnnkn0qXVAM2+9h4xZdC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApZan4pT7+HuVuf4WfvnMjGGM37TW4QyUlh8MbFcd/sqvyAXxiZFMad+VSpMlnWIHetbF7WP2fLYdJsBpGucRCLMhyYKbGghJX5VGI3qqOo/B+C5DFftHI2qKlmWZLRcDyNUEKKgRmRAGw4U4Hy6riO6YTsbkT7gD8eq2IBsQl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDIBmkBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37321C4CEF7;
	Tue,  3 Jun 2025 00:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748909433;
	bh=uGA87I1mzavJRknA7wPlXknnnkn0qXVAM2+9h4xZdC0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rDIBmkBml9LGAH+EERUP1TXhNPosTbFb5/Ogdf0dzbwyEbxWZg6P3QLXmnhroca6n
	 5RjhB6MdDh9kBhshdEgPSo03fpN2cXr55y+WGbQJ3fFCA0VBJBQrL/+CVDMEvR1HkF
	 EWp3Jt00jtrnYxHMhCLh8X69DQPwDj872kwlDiDhGteRfR8nXm3BN6fBomXQN1uO+6
	 GMyKu3loDHvU8xbEgzA7B+IEy3Vy6YOVHWUiOzgNQ0Gqq8pC9zdEGr3AFFRP7wWQTC
	 xyvbcZKRzXamMCicJ/thyjN+AZWFtmnIctaVhmDzXOt9y/RjEquQ/GciVL80SUxOyl
	 VtfqGAUBxvurw==
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a44b0ed780so37297141cf.3;
        Mon, 02 Jun 2025 17:10:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/McKiFQGcXaqQ9ArVAnKiuvSRp+jYvg6SqFf759kgCbOa7qgH5fVsmKyKFDRCaNg2cO0JpSRFfgN8xeJP3w==@vger.kernel.org, AJvYcCVr1EofXWiejC9tpZTvNYSn4dWIhFV0Xv/tcgTRn1K8Lmd1I2tCtbOkh4tsav3eVOhLpGDq+R2hvAmx0NRWuZcJzHs8ilUK@vger.kernel.org, AJvYcCWhBo2s33WSEpHWDnjYUj1QmRaRYoMSwiI+9oiJkF8ldN/U8YDhw7pNqGBuSPabnji1c3U=@vger.kernel.org, AJvYcCXABFE48RtUf7un9KhiM1JA0G0W1Rkda0zgdnfIQQ3mwkL9H865JtLJNSPVHQ792f5B20PXc3MIjoIgytX2@vger.kernel.org
X-Gm-Message-State: AOJu0YwRfqDxGR5hRFYIn0+KooqDL3Evy9xJHDkvCuBQ6F38QwuBjSId
	16LvpKNOpFK8WuErdwE8mDuUdo7lb9hGAW7erpROvg5fF8Mula+sFC/qrNKjkJN+FMh2cA/ILZF
	5PUd365yiqTr0ULTITbXaW+J3u5m56Bc=
X-Google-Smtp-Source: AGHT+IGLoWOMZqwgUhv/sbLHWl18RR1cYj5R8+PiGfLfXkdenx2MxtCZSCErWxDOzCQYqDhrdQ8b5fX+Q0Un1ay+z+s=
X-Received: by 2002:a05:622a:2618:b0:4a3:d015:38b4 with SMTP id
 d75a77b69052e-4a443fa39b3mr247970341cf.34.1748909432291; Mon, 02 Jun 2025
 17:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528222623.1373000-1-song@kernel.org> <20250528222623.1373000-3-song@kernel.org>
 <027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org> <CAPhsuW5BhAJ2md8EgVgKM4yiAgafnhxT9aj_a4HQkr=+=vug-g@mail.gmail.com>
In-Reply-To: <CAPhsuW5BhAJ2md8EgVgKM4yiAgafnhxT9aj_a4HQkr=+=vug-g@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 2 Jun 2025 17:10:21 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6W+HR8BOVTCbM+AVYCEzuoSR21RWUpaEE0xvOpv8Zbog@mail.gmail.com>
X-Gm-Features: AX0GCFuQUdKGxM2HVyeibXvrobPM4KaUyLZSwqxHa7AxJ_JG5qW3H7aNcTpNlR8
Message-ID: <CAPhsuW6W+HR8BOVTCbM+AVYCEzuoSR21RWUpaEE0xvOpv8Zbog@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] landlock: Use path_parent()
To: Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com, 
	amir73il@gmail.com, repnop@google.com, jlayton@kernel.org, 
	josef@toxicpanda.com, gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 6:36=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Sat, May 31, 2025 at 6:51=E2=80=AFAM Tingmao Wang <m@maowtm.org> wrote=
:
> [...]
> > I'm not sure if the original behavior was intentional, but since this
> > technically counts as a functional changes, just pointing this out.
>
> Thanks for pointing it out! I think it is possible to keep current
> behavior. Or we can change the behavior and state that clearly
> in the commit log. Micka=C3=ABl, WDYT?
>
> >
> > Also I'm slightly worried about the performance overhead of doing
> > path_connected for every hop in the iteration (but ultimately it's
> > Micka=C3=ABl's call).  At least for Landlock, I think if we want to blo=
ck all
>
> Maybe we need a flag to path_parent (or path_walk_parent) so
> that we only check for path_connected when necessary.

More thoughts on path_connected(). I think it makes sense for
path_parent (or path_walk_parent) to continue walking
with path_connected() =3D=3D false. This is because for most security
use cases, it makes sense for umounted bind mount to fall back
to the permissions of the original mount OTOH, it also makes sense
for follow_dotdot to reject this access at path lookup time. If the
user of path_walk_parent decided to stop walking at disconnected
path, another check can be added at the caller side.

If there are no objections, I will remove the path_connected check
from path_walk_parent().

Thanks,
Song

