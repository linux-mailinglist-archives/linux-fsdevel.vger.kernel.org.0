Return-Path: <linux-fsdevel+bounces-50083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9093AC8174
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 19:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474B918853FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 17:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E0B22E403;
	Thu, 29 May 2025 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBZyq5VG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB0CA5A;
	Thu, 29 May 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748538374; cv=none; b=m7uI6EavgH8AIYnTZejTdw7bbK1tWgN/dt/qDKZO9z/To9N1Vu33JJMb6254hwNl8Wh88F4gP98cLMNnzaMVgYe8fFN+KxBa/cyfVu+HOhyscnYfkX5y/LQ1mg/1HRj4OI7iwCvPyzTWYVIIPdRWq//ifoNr0+U9K0xObhEf+D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748538374; c=relaxed/simple;
	bh=ybSUIx4J4QXFnXrJeAufVFzpaPKzZtF4JsxTls+uIl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lntsWUX8/Xx0SjcGw3ynHQxyqvdg+u1ZixKpo21oDjmfqxemMfUS7qX4jE/CaNv0bpcsJGgVll+x0cM+fueChJewq/mXizF8jaMt6IWbLW0pe8iM6WiXmDv3puFuaKpVWnB0Ntfbep01nVyrDuwcph/jIg6b+t/+beRAg3K0Dm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBZyq5VG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368FDC4CEEA;
	Thu, 29 May 2025 17:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748538373;
	bh=ybSUIx4J4QXFnXrJeAufVFzpaPKzZtF4JsxTls+uIl4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vBZyq5VGzLFA6s/9JsFdwOPjiTUpK59x3vwYjz8e3YgnVp36nDUZC6rLY49QMNBKY
	 mOoxBJ1sRCksDa1uruyVZUvauRqLTPX2Dynze6DMlfcU5OrFn7J2DvfDhPPLWLmJKr
	 Nyt0cxe+HSjT+wEJwN3zTOvMZDy9cCf4qSLLdctfbYOvddw8pIjFX5tV3uTFApEohb
	 rKCwpm+0yshwBB1oiRHiKq/TbUy45cp+1ZBJKPT7/u9SIdEvcoA2A9Is1QkeOHh+r/
	 Eu+uVqXJzI0x05eakgXZizDu5BWSb3re2xmW/JZcmokxo5uzM3q5CRx1D8CG2UNmQC
	 0Bc9L5HEuhTCQ==
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47692b9d059so16177131cf.3;
        Thu, 29 May 2025 10:06:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJxGL1QX/yGVRcBjyOkQK7tmoOCo8vpw3AWoDXsp+vt3RNlSLkLsGb9+5eICg1R58YcelgPfjiw2WxIsEE@vger.kernel.org, AJvYcCVd/9OYx0AfVJVOov1LBBg6YVvdxr+IdtDONVhCS8OoTA1wZsfrzkJrdWQjs4TQDInppacEfmlVPEq9cksUmFhTs25Dm5yo@vger.kernel.org, AJvYcCWBCxBodFLX+Mc2uyk3o/WSn0C1GUogn6IH6bQ/Y3WpVCU4VmnfgtVHWVFLAuH9lGH9025lyGbEcYWGf9ymog==@vger.kernel.org, AJvYcCX5Ii6iurrx3i4i9fLtw5apt6/zOqgTfX3GOLKuonn2SOgfT2k8nYCmuC6LsTooidDA5+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywliro3GFOdoRytcpl7YWucvFMnJ0eYOa3lA13W7eshLrDmCatK
	iF2xkjuCYvEk5mqCt7b2J0jUaWl1PSTbh3YmJpA8I/nL2tB2C9yPpu2UqZZCPZrxNAU3CsJJgq2
	2yU0/U0BK5yOAD1Tq0ih8XEzVE9GLstQ=
X-Google-Smtp-Source: AGHT+IH9p7AzuRoU58gKl0Zi0c2yc63sDhav8grGGsjk3Kynjfd+8+kZGpJwRIHFZXjDBTGVZ0bfFxIKAjQGnzspt40=
X-Received: by 2002:ac8:5cd5:0:b0:48e:9e05:cede with SMTP id
 d75a77b69052e-4a4400e462amr7256201cf.52.1748538372435; Thu, 29 May 2025
 10:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528222623.1373000-1-song@kernel.org> <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV> <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com> <CAADnVQ+UGsvfAM8-E8Ft3neFkz4+TjE=rPbP1sw1m5_4H9BPNg@mail.gmail.com>
In-Reply-To: <CAADnVQ+UGsvfAM8-E8Ft3neFkz4+TjE=rPbP1sw1m5_4H9BPNg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 29 May 2025 10:05:59 -0700
X-Gmail-Original-Message-ID: <CAPhsuW78L8WUkKz8iJ1whrZ2gLJR+7Kh59eFrSXvrxP0DwMGig@mail.gmail.com>
X-Gm-Features: AX0GCFsdjKPZ4yFrJx9AiGup60wQDY6NN-nsSNLgH7TOfusfnwxZiRW6dRLoxZ4
Message-ID: <CAPhsuW78L8WUkKz8iJ1whrZ2gLJR+7Kh59eFrSXvrxP0DwMGig@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Christian Brauner <brauner@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, repnop@google.com, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 9:57=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
[...]
> >
> > How about we describe this as:
> >
> > Introduce a path iterator, which safely (no crash) walks a struct path.
> > Without malicious parallel modifications, the walk is guaranteed to
> > terminate. The sequence of dentries maybe surprising in presence
> > of parallel directory or mount tree modifications and the iteration may
> > not ever finish in face of parallel malicious directory tree manipulati=
ons.
>
> Hold on. If it's really the case then is the landlock susceptible
> to this type of attack already ?
> landlock may infinitely loop in the kernel ?

I think this only happens if the attacker can modify the mount or
directory tree as fast as the walk, which is probably impossible
in reality.

Thanks,
Song

