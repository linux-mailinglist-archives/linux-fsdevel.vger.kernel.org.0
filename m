Return-Path: <linux-fsdevel+bounces-40649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04543A2635F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 20:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E3F188386C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40501209F22;
	Mon,  3 Feb 2025 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3K67Zhr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C418B1D54E2;
	Mon,  3 Feb 2025 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609995; cv=none; b=uerEIc9X5Nr2nSa+gpsIcbNJwU0KsBwndJ6elYUxrz55WnyfFXPLFzGDUwiAuy+RNG2Q0jia7hS3ECXsDrsLhbBvbgKsFNqMxrtFy5VRQ2W6+l9RnDNAm/+mPO/ZFJGHbSJ6a9FdJ8ZJ+lm4eJk6NjV7dLcCvzPkTfq67mZkjoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609995; c=relaxed/simple;
	bh=+1ApW4IlAm2vszV6c8fXzisqnz+/2CfL7ImesJHt21o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRRgJgrFm+NgORHsiCRNIBJq0tFSA9I8Datc1D1zTlijxWb715aZtX5Jp3+Jb8APXiFT76A8kHYkQeR/zGV1c46QG474LnKNJv+wpnGSefRo76MRk49lECZGdjoAbQLtRXT6WnZy6Yv2oAebTOB/NoEhmAGCfOkVZGBSy1WQA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3K67Zhr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so10270101a12.2;
        Mon, 03 Feb 2025 11:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738609992; x=1739214792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ATR9LxFA3KoC/fdAoLngmiNQOq725F3mvwwXFxD3H8=;
        b=b3K67ZhrLo6DTNTZLwjAG6axdhNweZt7CI/zEcLFrvfZt3h3YntievSDb/ekSLFzUn
         sAVn33I9LpH1MiPPm4/DtDyZ8ARvtuEN1WBvc81wvjbZOIgQ81UJ57HIJlTMN3PreVYH
         7FxLhOur4kCmLD4Gyg9KlLwlPE9M6Rp/izzlQp3EAODcIVSBwcTF+FJCM+rX+Yg3SSM2
         ShIbLLiX51+6qp6ma45q7+ofBwOpUc3Xflrtm84nJGlOpxao4e0amtCt7+4UtlX9Hw0g
         30bsq4RTyEW62AzI9P7nGcUc9jIVJZiqayx9U9tb9ywVwUFlYfiA5JGjUri5kDBCoz/P
         MJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738609992; x=1739214792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ATR9LxFA3KoC/fdAoLngmiNQOq725F3mvwwXFxD3H8=;
        b=oTcVwLcURzmLo7mR539Hf02uDqgtme04fGOaFCwSahFjjFbk96g4Uj+V4UdB06CMyl
         2AC3/PUtZgHunyfRRLkhHpiIenotS6gZKBFSXORwZaVMJGECBcKEO6VZo3H8mtrzXwh0
         MSs7HX3nImeyvOiuZitKBjH7I4nuFL+Wgcs7xrKnOI3gpUkEROTRHS2v6TZTCEKIZI6N
         BV0bCtjWEZvNJJ28d/bjzlXqNEx/nirwp+iTAkadWkoZ5Nx7Hvt5vK6Mmw2FatcixXrg
         xg37aWBE/K2b/F9L5Y8MJH0pYzJuQ6njECOMqEH9D8i9d7XBQ3ZQz8Wpi6d1hS2QVxeN
         DHGw==
X-Forwarded-Encrypted: i=1; AJvYcCVvuWAUkJaHjj80QUkCXa8aYSlwFtaumZcTXXFzXdkGTVx0yZNuT+QWW4c5PU5SNZ94W5ZNyvRQ@vger.kernel.org, AJvYcCXzdvt8VrgFFWbOGB8Xf/rDHl5iyaTUkA095HrU7fAym2Zfh6dyL7bif4UQvnKv/svULmMMp57eOvw6OkKblg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiEZalqD0eeRz9ch/BznAZXSl5CGY3XXnfZoN0/qrBfQeVL6D2
	jIxCOr47jsZuTU40AYVgA8zeYlVT388nGeLxYqSsL9uz0jPZPjr0oC18CarzkgROH5hyRu+W96c
	fxK91H04TDg88wQotB9a4VM7ulhI=
X-Gm-Gg: ASbGncsNYZF9kmyzjbznXJ07AX8mdZgqBjMMq/7vclbBrayqxx5wSTQX4+jQF6fHhA7
	UKPxBxFqzA2B827BC3T7AvZG+83CQ3FflnmwBwa/ribEFIxu/2dfLKkWvOiRO9RXHPa/5Dj7l
X-Google-Smtp-Source: AGHT+IHoUcc/NEfy0zrtKJNLB/LJ11pg9p2CpWwrLlAv/hvy8PdAb9v8V+vQ7xlB4K/Be7095Dm8pBwgxwdDeUjg9/4=
X-Received: by 2002:a17:907:2d08:b0:ab6:99b2:ad0c with SMTP id
 a640c23a62f3a-ab6cfe1753dmr2384632166b.50.1738609991340; Mon, 03 Feb 2025
 11:13:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203185519.GA2888598@zen.localdomain>
In-Reply-To: <20250203185519.GA2888598@zen.localdomain>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 3 Feb 2025 20:12:59 +0100
X-Gm-Features: AWEUYZlBvrMbmjcMOb9YHHR7LGTSALu84kO5NmJa7V_r_sKmEyHsZYSx4qSObRc
Message-ID: <CAOQ4uxjiYQHUVkYnv5owPHHvs6BP128Zvuf_LGciENjyJkLa6w@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Long Duration Stress Testing Filesystems
To: Boris Burkov <boris@bur.io>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC fstests

On Mon, Feb 3, 2025 at 7:54=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> At Meta, we currently primarily rely on fstests 'auto' runs for
> validating Btrfs as a general purpose filesystem for all of our root
> drives. While this has obviously proven to be a very useful test suite
> with rich collaboration across teams and filesystems, we have observed a
> recent trend in our production filesystem issues that makes us question
> if it is sufficient.
>
> Over the last few years, we have had a number of issues (primarily in
> Btrfs, but at least one notable one in Xfs) that have been detected in
> production, then reproduced with an unreliable non-specific stressor
> that takes hours or even days to trigger the issue.
> Examples:
> - Btrfs relocation bugs
> https://lore.kernel.org/linux-btrfs/68766e66ed15ca2e7550585ed09434249db91=
2a2.1727212293.git.josef@toxicpanda.com/
> https://lore.kernel.org/linux-btrfs/fc61fb63e534111f5837c204ec341c876637a=
f69.1731513908.git.josef@toxicpanda.com/
> - Btrfs extent map merging corruption
> https://lore.kernel.org/linux-btrfs/9b98ba80e2cf32f6fb3b15dae9ee92507a9d5=
9c7.1729537596.git.boris@bur.io/
> - Btrfs dio data corruptions from bio splitting
> (mostly our internal errors trying to make minimal backports of
> https://lore.kernel.org/linux-btrfs/cover.1679512207.git.boris@bur.io/
> and Christoph's related series)
> - Xfs large folios
> https://lore.kernel.org/linux-fsdevel/effc0ec7-cf9d-44dc-aee5-56394224252=
2@meta.com/
>
> In my view, the common threads between these are that:
> - we used fstests to validate these systems, in some cases even with
>   specific regression tests for highly related bugs, but still missed
>   the bugs until they hit us during our production release process. In
>   all cases, we had passing 'fstests -g auto' runs.
> - were able to reproduce the bugs with a predictable concoction of "run
>   a workload and some known nasty btrfs operations in parallel". The most
>   common form of this was running 'fsstress' and 'btrfs balance', but it
>   wasn't quite universal. Sometimes we needed reflink threads, or
>   drop_caches, or memory pressure, etc. to trigger a bug.
> - The relatively generic stressing reproducers took hours or days to
>   produce an issue then the investigating engineer could try to tweak and
>   tune it by trial and error to bring that time down for a particular bug=
.
>
> This leads me to the conclusion that there is some room for improvement i=
n
> stress testing filesystems (at least Btrfs).
>
> I attempted to study the prior art on this and so far have found:
> - fsstress/fsx and the attendant tests in fstests/. There are ~150-200
>   tests using fsstress and fsx in fstests/. Most of them are xfs and
>   btrfs tests following the aforementioned pattern of racing fsstress
>   with some scary operations. Most of them tend to run for 30s, though
>   some are longer (and of course subject to TIME_FACTOR configuration)
> - Similar duration error injection tests in fstests (e.g. generic/475)
> - The NFSv4 Test Project
>   https://www.kernel.org/doc/ols/2006/ols2006v2-pages-275-294.pdf
>   A choice quote regarding stress testing:
>   "One year after we started using FSSTRESS (in April 2005) Linux NFSv4
>   was able to sustain the concurrent load of 10 processes during 24
>   hours, without any problem. Three months later, NFSv4 reached 72 hours
>   of stress under FSSTRESS, without any bugs. From this date, NFSv4
>   filesystem tree manipulation is considered to be stable."
>
>
> I would like to discuss:
> - Am I missing other strategies people are employing? Apologies if there
>   are obvious ones, but I tried to hunt around for a few days :)
> - What is the universe of interesting stressors (e.g., reflink, scrub,
>   online repair, balance, etc.)
> - What is the universe of interesting validation conditions (e.g.,
>   kernel panic, read only fs, fsck failure, data integrity error, etc.)
> - Is there any interest in automating longer running fsstress runs? Are
>   people already doing this with varying TIME_FACTOR configurations in
>   fstests?
> - There is relatively less testing with fsx than fsstress in fstests.
>   I believe this creates gaps for data corruption bugs rather than
>   "feature logic" issues that the fsstress feature set tends to hit.
> - Can we standardize on some modular "stressors" and stress durations
>   to run to validate file systems?
>
> In the short term, I have been working on these ideas in a separate
> barebones stress testing framework which I am happy to share, but isn't
> particularly interesting in and of itself. It is basically just a
> skeleton for concurrently running some concurrent "stressors" and then
> validating the fs with some generic "validators". I plan to run it
> internally just to see if I can get some useful results on our next few
> major kernel releases.
>
> And of course, I would love to discuss anything else of interest to
> people who like stress testing filesystems!
>
> Thanks,
> Boris
>

