Return-Path: <linux-fsdevel+bounces-11263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3309985230C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 01:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABD2BB22294
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 00:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C884A1854;
	Tue, 13 Feb 2024 00:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Fi+X0EZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70BF79C1
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 00:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783327; cv=none; b=tFg8ZWUSz5F2KtT3y8bSkVTHTNvYGNshJx6JsEq4+2lsmyOTrmF8u9MCZINhbxd5Nm4r/nDhsc0rjq5Y9YWJ0xWeRII6Yd/kImAYG/2wA2zMN0IVn+Umtg2m26fJsfYHXsqIMXfIuNvGW8UIlLbl6J2NzrHBtLdaMj5onDQe5LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783327; c=relaxed/simple;
	bh=7Wwz+pVnHJ9jIYCJ6OslYOBAl9//CS1GWKGLZ0scfs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8MFzApOgNF87Nn3qC9I9LFd01j2C11wKgZcT74cwcc44LU8IYu3ArrAg49xe6NxxMPWNasNmApOvtsndnRQUOZ2cpBMZkQkj/5OgJ99L4jkOHzIsolxQDt90kbcQAxtvnVcxaALaHGyS8DonxT2AZAz4bBhZx6HxgAToFkAzCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Fi+X0EZ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso3476499276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 16:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707783324; x=1708388124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Wwz+pVnHJ9jIYCJ6OslYOBAl9//CS1GWKGLZ0scfs8=;
        b=0Fi+X0EZMVaI/UinNhEXfp0t8Cm5470SB2bK6OadTq7R3yvD+/e0lXmBXENPBhxCDy
         IysoKO9VDa2guh3MlMCWAvFHHPbEq2TEKG0/1zVc/P5GwMHHucu8VszDo60LhpjLIU1s
         pZaiz3JxDGP5DhSNubs4wBl9pI4YT4BWZzyzrE1D2ImFXtmwl5DqWAo5gfj5UFKdrrs+
         HF3nTcIj9y3xQBaJcTV4EC3MmXTKb5gxTH4s/wMmVLWDAXTXW+JoIcnEYfwEOMv0nYeh
         X+eTco00/QlypK57fsP5qA3YaPj7IwiS7Vt3cc7xqW9huiwTvWw0jPmpjkZ2dxI3dn+Z
         euFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707783324; x=1708388124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Wwz+pVnHJ9jIYCJ6OslYOBAl9//CS1GWKGLZ0scfs8=;
        b=f/g1XDbTuSjBEHNPpl7qddntbdA3axihmE+jydoMUdWak8f8TZo2owUadwkzRoYjld
         aGL99GNGP1V1S38gBnhwKy38Z3kEijb9HrtwARhvRT4iqYo4iuJAXyGQB7MWUw53ORwn
         /18GLJFwsdjrpvlioGtl4tyz5/eUWIyRgY+IRhu4SKosdIpqcG3vFNcMd6nLcB7fHSLG
         OPLSG0u9+LKQFKTHrh7isvwckRESYqHdZqb8hR+0dhZGDVk8i+1qAkKyJgCNVmeRg71Q
         Z0ANuCtMh+p8jCQaEEre9AjGRvt5XPdrwmsanHoIYjVLyM7Zc71dY/tU2bhgfNW8duAd
         3bDw==
X-Forwarded-Encrypted: i=1; AJvYcCXgaHBd0X2UjeR3WdPKDbT6ALx+ZXBqJi51Uf+lSySj2Osbs1DqLbW9M6RYKbfnVxBeYKtIM399LFSsHzB5l4wmHswco6ajm+D+Y6GHkg==
X-Gm-Message-State: AOJu0Yz8q6idTnzPEq0Xtb4RQZwaoDl9kTNQBrr1CbMAlu4zQ6SVWP1n
	ihQUrDidIhHT6U1b38snO4wb3rF0PSniwIBihDQa1nEurXORKU8Kr0gk4c19WH0AaQ5FeHegg3X
	oNovORWdxJ+y/iCM6R2LiQUab7Ly3w7II2JKR
X-Google-Smtp-Source: AGHT+IFIduuZE1STvNicF9DxUXXadRzIx8lN/0f7DXD7a7IgTSoghi+1HrvGMrI5m8lZfvX3Zk7o2MADsuuEWWIky8I=
X-Received: by 2002:a25:ac68:0:b0:dc6:d158:98f0 with SMTP id
 r40-20020a25ac68000000b00dc6d15898f0mr6974706ybd.52.1707783323411; Mon, 12
 Feb 2024 16:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-34-surenb@google.com>
 <202402121445.B6EDB95@keescook>
In-Reply-To: <202402121445.B6EDB95@keescook>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 12 Feb 2024 16:15:12 -0800
Message-ID: <CAJuCfpEoS=ea90EHHc-Kwg3G3_ZWsVgKvhRiZ4SVuGARBe=vnA@mail.gmail.com>
Subject: Re: [PATCH v3 33/35] codetag: debug: mark codetags for reserved pages
 as empty
To: Kees Cook <keescook@chromium.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 2:45=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Feb 12, 2024 at 01:39:19PM -0800, Suren Baghdasaryan wrote:
> > To avoid debug warnings while freeing reserved pages which were not
> > allocated with usual allocators, mark their codetags as empty before
> > freeing.
>
> How do these get their codetags to begin with?

The space for the codetag reference is inside the page_ext and that
reference is set to NULL. So, unless we set the reference as empty
(set it to CODETAG_EMPTY), the free routine will detect that we are
freeing an allocation that has never been accounted for and will issue
a warning. To prevent this warning we use this CODETAG_EMPTY to denote
that this codetag reference is expected to be empty because it was not
allocated in a usual way.

> Regardless:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook

