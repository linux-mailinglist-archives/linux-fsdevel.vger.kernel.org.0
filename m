Return-Path: <linux-fsdevel+bounces-28341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B685969853
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FA22819BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 09:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B955A1C769F;
	Tue,  3 Sep 2024 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaGvgWX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F791C7668;
	Tue,  3 Sep 2024 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354535; cv=none; b=jHJTYXcGD82D8TBN2o1nLbH5DkfekcATUzoHhEGIPi2OYw8JTZjj3QcEhepnvS5vhTrWx3kLePv+r+7f1vpfZsIxj8dU0lNABAm0177rPLwbG9O2up9qiLgEYpPAOzM3d9KsU3P9ptxjGcOMQfWAY5vcNMFp3ZWFeOqn8K5pMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354535; c=relaxed/simple;
	bh=yXsteYTYHdjmkVWZSfy+ZgdcoEsEZ5Blm2+Q2trApDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Et88qLaHa8PNtLRrmuAV8hb3co1BhA9/p3PCp2U/OXUPuSC6qU9LMlFT8srnUS/tC8EYenBMVs/JrGzgXUZyUC3dyUdmZyqKNRzJ8CaPQkesXDdap9wjJwWolV0agbiI+FO8ZdXkWA81lm1raDMURf+0wE+vt/3Fr1+HurC/aho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaGvgWX7; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c35ac3a7e6so13523646d6.1;
        Tue, 03 Sep 2024 02:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725354532; x=1725959332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNSUaAuCT1hhn3yR4/PJ6F5Hry7OaS+mwt0V2W/ErFM=;
        b=jaGvgWX7lWVjeXIzlw+KCB6mCYYwj+RahLH0KTZ1GrLs0Eyeu2rHb+xz7T6jntNOPn
         dNOfiZ6ePBynmh/OwcpgEjl3UvY00NypsEy1nCG3dKCB3/NZDp8VT39lxFASIXFJ2LMp
         UzL1wK833hf7dPJi6gNTZdRO+bQKfvfVG57ro6nOdL3xJrgQgIfvmYQQ0G8VjDKEneHr
         HPP7BFPZ3+YHWBz7f7yOmOCzLiIUPE1mwriTt8iTRo5sJciWxtrV3/+qt5kXxdB1t7jl
         AkguWTNPWV+hQEghwkL67z1k1T7qbPYrgfX2RsJwOZy4y5ZLUoLLuz8HH9bU9sbdGjQY
         Fsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725354532; x=1725959332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNSUaAuCT1hhn3yR4/PJ6F5Hry7OaS+mwt0V2W/ErFM=;
        b=hE2/xUC5i+ucO+KCP9DA2uHjGSeGMU0J8RsyG7w6PUj/Y3LphDr8/u2k69pApK9G4n
         M8cCnD4w+lMUJfKyLyf34aLXwIEocqkhggYlNsbU/FkHlhR4uRBlV6YuJj1fhhfM/rcu
         1mGVWPEjRWgdWxFxRaD94tYQXCgorawKCUOmvF0SR24OgqXfQAIj09wQ0+H+gzIKJm6E
         WxxBZUwqTXUEXuwKoAIa1zVbHzPP1fJJ0UgPpKIEiDzytAbnF7S5JSkPQRBI11HjjQbE
         msR4MFP98Qqjc9ETWfhbiTy1RbWlh2MEEXqco+4AeXUIvESxYiRm3FT14WtnUSCPfzUe
         WaJA==
X-Forwarded-Encrypted: i=1; AJvYcCUcgDh0jfpR50TVkqDfNJHnjBq1TrdMCwHgGa0HhOmZ256Wmo2s+Dq8s2SYRVdFANGHzzak1xvzfgllRmqk@vger.kernel.org, AJvYcCWT+RDJ5aGSGRfNMkG9qEE09wiwek+VGTX+rH3hCDscmcQaJSnJUbotX7PrkQTeV9cwJb8HSrhCEMD4@vger.kernel.org, AJvYcCXG9YTT4+uoorvpsHxSDKxEcxgPhgBlcR3hbfioV32CX42mnrXJrls7or1Us9jMA14Zs2G20hZckU4yl+mx5g==@vger.kernel.org, AJvYcCXhr/8L83IYcjEE5dsJhig2i2G9hEBC+2vgEA3PMe6gykFXm6zu/ZWjCZuYIVfSxdnB04ZuSqv6ifN/lsea7IBjIw==@vger.kernel.org, AJvYcCXsYm/Vv3z6FyvnVK8LwKckkUHVCKb1TzJ/1M0qM6ecj/ixkMjYCVWIulTbKAK/Mg84demY3cm53g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZs20h4OLQgKEGBRD1KGT35Qi8KE1+a3uWeZkk3CqCkQgzs6W/
	Ew9RgtyKHdH7wyw9yxR1F1n6TWzhqzrMP6livaZ50AXl6Y82cywzuDQndfAncLU1jxsVKfL0aIx
	/W1+tJ2mWhoV+0qaLazEQAH8g0is=
X-Google-Smtp-Source: AGHT+IEue1Qt36L3+EfoJIWpUvc4YTUfQcRxk5QLj8xifrUj4YYSFty/txvVnZIkWcK44hKqb/xh7JAqfqX+IIFtem8=
X-Received: by 2002:a05:6214:5b0f:b0:6c1:6c23:8eaa with SMTP id
 6a1803df08f44-6c3551c9af2mr137265166d6.10.1725354532384; Tue, 03 Sep 2024
 02:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
 <20240902164554.928371-1-cyphar@cyphar.com> <20240902164554.928371-2-cyphar@cyphar.com>
 <CAOQ4uxgS6DvsbUsEoM1Vr2wcd_7Bj=xFXMAy4z9PphTu+G6RaQ@mail.gmail.com> <20240903.044647-some.sprint.silent.snacks-jdKnAVp7XuBZ@cyphar.com>
In-Reply-To: <20240903.044647-some.sprint.silent.snacks-jdKnAVp7XuBZ@cyphar.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Sep 2024 11:08:40 +0200
Message-ID: <CAOQ4uxhXa-1Xjd58p8oGd9Q4hgfDtGnae1YrmDWwQp3t5uGHeg@mail.gmail.com>
Subject: Re: [PATCH xfstests v2 2/2] open_by_handle: add tests for u64 mount ID
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: fstests@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Alexander Aring <alex.aring@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Christoph Hellwig <hch@infradead.org>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 8:41=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> wro=
te:
>
> On 2024-09-02, Amir Goldstein <amir73il@gmail.com> wrote:
> > On Mon, Sep 2, 2024 at 6:46=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com>=
 wrote:
> > >
> > > Now that open_by_handle_at(2) can return u64 mount IDs, do some tests=
 to
> > > make sure they match properly as part of the regular open_by_handle
> > > tests.
> > >
> > > Link: https://lore.kernel.org/all/20240828-exportfs-u64-mount-id-v3-0=
-10c2c4c16708@cyphar.com/
> > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > ---
> > > v2:
> > > - Remove -M argument and always do the mount ID tests. [Amir Goldstei=
n]
> > > - Do not error out if the kernel doesn't support STATX_MNT_ID_UNIQUE
> > >   or AT_HANDLE_MNT_ID_UNIQUE. [Amir Goldstein]
> > > - v1: <https://lore.kernel.org/all/20240828103706.2393267-1-cyphar@cy=
phar.com/>
> >
> > Looks good.
> >
> > You may add:
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> > It'd be nice to get a verification that this is indeed tested on the la=
test
> > upstream and does not regress the tests that run the open_by_handle pro=
gram.
>
> I've tested that the fallback works on mainline and correctly does the
> test on patched kernels (by running open_by_handle directly) but I
> haven't run the suite yet (still getting my mkosi testing setup working
> to run fstests...).

I am afraid this has to be tested.
I started testing myself and found that it breaks existing tests.
Even if you make the test completely opt-in as in v1 it need to be
tested and _notrun on old kernels.

If you have a new version, I can test it until you get your fstests setup
ready, because anyway I would want to check that your test also
works with overlayfs which has some specialized exportfs tests.
Test by running ./check -overlay -g exportfs, but I can also do that for yo=
u.

Thanks,
Amir.

