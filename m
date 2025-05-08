Return-Path: <linux-fsdevel+bounces-48513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE769AB04A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 22:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37DEB1C01000
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 20:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A46B2797B2;
	Thu,  8 May 2025 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7UeMaEI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBB3284667
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736212; cv=none; b=sedupzY0BEaPpspSSZC+t+/8u7DUwKSah+juUKmZA9M2ZH0BQEyyR05WNit0X5AC3cIkpeVWaichX+Gqw9LF0Z5p5Nk8XappU7YluUamU2EeDL1BOk5efKWT282JSW9BbCCZNSXj4Zw/a8r+nASHbafhZGVRAbBE5EUYGNPU+PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736212; c=relaxed/simple;
	bh=xStwR0TKk3XEVMFmvexPsnqkKVQBdyutG1QmysuFXSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nn4eAxiSKPHz92bciho13JzpC56AV+R2nSvapqZZmB0DyuTiqpqT8w+BTgbjvCi0EjKGs8+d8i8IxiSWPN+mtYKkbVTbC7i5ttyyuDSSNFueS7yKvAGqGOaDArPfrEFHGVJwkNANJ1okj6DviFH7S/Z/mC0dF5UWCp2yeh4PwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7UeMaEI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so205231066b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 May 2025 13:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746736209; x=1747341009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xStwR0TKk3XEVMFmvexPsnqkKVQBdyutG1QmysuFXSI=;
        b=B7UeMaEIHHHQYdbBm+DAksQ4Eq1vPj1Y1iYn5MMphKxqy8NYRYoBjDXYNylXnwNayl
         TbMlAieHtQr1Ujlidn+YL56T244a6w/saEUQNAk7sG+WO7l3Hm03H1wO/XRMvnNr/kaB
         i1ipzWAoVPXUwFaZ3iLCas4Z+WHr2QaVJZVDRt/1yLTwsNVD/QUVKcfnEOcUiS546T+V
         Sz846O9yySfw434iCsR/gjYsJcOvwnnrli5jIZNE08z/d+tEypvS1vruCDCoOiW580o9
         DP/hZG5fpSFREcQ2QGAwXng3ftjgHFKOrBf8kxbEutaUWCg76bNwymfldPqx5M2SYgIC
         Rh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746736209; x=1747341009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xStwR0TKk3XEVMFmvexPsnqkKVQBdyutG1QmysuFXSI=;
        b=VgMgsIgAck7CEcv0+X57CuADdCS3ig+fnWYXD4Ht31INHHVmb7hHvMxo3+bmI0lVqh
         oOaE/v0evY4y2rrZJyF9gHhbRgjYhQmyx97gPyrS8AaElT5uS8m4hwdbioDVbaBPNrhR
         vnLHiZUFaPVPIJ4oL6Ur29vfuOiiQta6ZMpcT2SAESbuGv+W09i4zyI3NU0IwEQC7MX8
         1QrWAHPnNxsT2xb1LBERlNAuvdJTPxrq86gzeYzjpFoKAJAWi4hTrwWa0qVT6AMDj58k
         OBqBcbqTA43tBOcYUrtPvpdwuwswSPAxCAq1YyR1iaFaR+XcRJcaaCVEgZ9lLHfs+dH4
         u+yw==
X-Forwarded-Encrypted: i=1; AJvYcCWqvq7wEKPXaNizQ3n4IUUHzaboSgffrhtDZNpe5LkyrkeJn33FuX1T4QAEgbivpJipBL+T21R8etOJmupy@vger.kernel.org
X-Gm-Message-State: AOJu0YzuvXyhFpeTEUG6Y85wuRzeuRi7OFrSOxpBSoKxunlqED6i6kCP
	ejqgD9eEboqWDrs4O4e+jOtUhacw71I+FJuJwIxg9N8TOl/lkUzN5+r1Q+sG3hvxQxbfmaO0Mt5
	F3YIB3zeTe4TaoC7nUQit4+IWS68=
X-Gm-Gg: ASbGnctorHfLSLariM0PGvgcgq0Uq2p1ofawlzSgytEQDVA4J4wxdtJi/M4YQKfl8LF
	iO8sFF4prTuvkttHaqxuzGoJttBMA+y90INVM+9V9nO3EqKXkhm5bMtUkg57+weEWl2AASU1Uwa
	z2uuZDwRGkW52wG2ikwY+kxw==
X-Google-Smtp-Source: AGHT+IGsPSRAmQcrm7CSPevNvUqq1IMcCeCuchXvjvsdwYNTNgDkBdCELlSuv/0YDlEafJiIKa9K2pqPeyA5PhoXFA4=
X-Received: by 2002:a17:907:86a0:b0:ace:c43a:63e9 with SMTP id
 a640c23a62f3a-ad21927d0b5mr108961266b.42.1746736208956; Thu, 08 May 2025
 13:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507204302.460913-1-amir73il@gmail.com> <20250507204302.460913-3-amir73il@gmail.com>
 <ad3c6713-1b4b-47e4-983b-d5f3903de4d0@nvidia.com> <CAOQ4uxin2B+wieUaAj=CeyEn4Z0xGUvBj5yOawKiuqPp+geSGg@mail.gmail.com>
 <3919219e-9678-46b8-a6bc-c83ccdf82400@nvidia.com>
In-Reply-To: <3919219e-9678-46b8-a6bc-c83ccdf82400@nvidia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 May 2025 22:29:57 +0200
X-Gm-Features: ATxdqUH9C9FkPj6YAasQLZlHUziM5ipXPRMdgxlqx9ZEwJXZ6ETky2mz8XcFeTU
Message-ID: <CAOQ4uxjoGu-Gs7g5wMB6YtCfZkmvKo+Q3=YAEOcEkC7K53P0Jw@mail.gmail.com>
Subject: Re: [PATCH 2/5] selftests/fs/statmount: build with tools include dir
To: John Hubbard <jhubbard@nvidia.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 9:30=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> On 5/8/25 4:36 AM, Amir Goldstein wrote:
> > On Thu, May 8, 2025 at 9:31=E2=80=AFAM John Hubbard <jhubbard@nvidia.co=
m> wrote:
> >> On 5/7/25 1:42 PM, Amir Goldstein wrote:
> > ...
> >> Yes, syscalls are the weak point for this approach, and the above is
> >> reasonable, given the situation, which is: we are not set up to recrea=
te
> >> per-arch syscall tables for kselftests to use. But this does leave the
> >> other big arch out in the cold: arm64.
> >>
> >> It's easy to add, though, if and when someone wants it.
> >
> > I have no problem adding || defined(__arm64__)
> > it's the same syscall numbers anyway.
> >
> > Or I could do
> > #if !defined(__alpha__) && !defined(_MIPS_SIM)
> >
> > but I could not bring myself to do the re-definitions that Christian
> > added in mount_setattr_test.c for
> > __NR_mount_setattr, __NR_open_tree, __NR_move_mount
> >
> > Note that there are stale definitions for __ia64__ in that file
> > and the stale definition for __NR_move_mount is even wrong ;)
> >
> > Christian,
> >
> > How about moving the definitions from mount_setattr_test.c into wrapper=
s.h
> > and leaving only the common !defined(__alpha__) && !defined(_MIPS_SIM)
> > case?
> >
>
> By the way, is this approach possibly something that the larger kselftest=
s
> could use (not in this series, of course)? I recall most of them are doin=
g
> something that is x86-only, as well. And so if you have made some observa=
tions
> about syscall numbers such as "only alpha and mips are different" (?), I
> could definitely take that and run with it for the overall kselftests.

I don't think this is generally correct.
It is correct for the syscall numbers in this file.

Thanks,
Amir.

