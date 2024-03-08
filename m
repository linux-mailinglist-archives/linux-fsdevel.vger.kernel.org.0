Return-Path: <linux-fsdevel+bounces-14006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93FD876748
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 16:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8482728311A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 15:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF3C1EB5B;
	Fri,  8 Mar 2024 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZANEPlx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDD115C0;
	Fri,  8 Mar 2024 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911425; cv=none; b=ebjnSqVdpg6RtvmrOzVfFXIokDPH58wwF8WTkluEFPYRR63IMxyxG5GuB27eFLf3Xc29n/CsOQIU8udx8lHYLzBvnXo0uRULkSI1zeJ0OqQV+fcRjcftHRqn9gCtYGMIX5NTY3DrLNWCxklVtYg++p0y+/zSwzQ3S8aNuPkXTzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911425; c=relaxed/simple;
	bh=smFQqtDCLvrCK6zU35YKk9vivzb3zYgAYB2LYuAuGDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvrQ0Xu4nWlu+P/ME4DqMfkXhTzh3V70ChZXG636Sw8AF6pf2GRmSMDK8XfF97jP31UAulgzIOwPTiWSCRjy0uEXhl1TvsKgmnTiBYHzSqGJ8XZ2DTZYoyY3uJWnAvx1l6pD1YETMDLmSMqSjMoN5956/aRKQG84aq5ShhuSvt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZANEPlx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29a61872f4eso1490952a91.2;
        Fri, 08 Mar 2024 07:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709911424; x=1710516224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcBcmCbNUNK8QMRYlD0suSpFuYeDhzgpUC/IVV9/I8w=;
        b=dZANEPlxwM5oPCBvysfsLEwt5BNASQmYvo5PvBmmGsOI0UnLaIxwoweL9P6HcyPFvD
         dIvcarMHLLGKTwrwX9ysbLHqaypr+WoqFDdtx8/vF7IhIW3ZFwfijegrKLpMajWzpXfI
         ISsSSJvPVm17jdRrvEDTbuGeoaX6SxUAZwi/gvwMt8GTe6ST5CyfW4RAHlAa2f0OjVHY
         7I6PJXSq1M5pG1UEwxsjgfKMy3pvmWVsp137FG7NzkV4McQIZMdsdsf3HAvWfcSQPwCA
         FA+EGg6mFMCV3iA94fY9KXnjdu3xq1MmKIO69AuVyPBMJ1rgwfKVrbHBU8IxUCz0jjdF
         3oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709911424; x=1710516224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcBcmCbNUNK8QMRYlD0suSpFuYeDhzgpUC/IVV9/I8w=;
        b=m1zEzv8mmpofpKmxvVpDtIoN0TkV+k0thCTcH2XBbOy1eVwNaZ8hFTJOUzthKXRzuM
         TU8gdo5LEXWUVfNuztImE2Fw80pm3Hpq+e1rDl9QPJuvMHKYbHmtr3gLMqmy4X110OG+
         gJzRng4EDN9wnPuwNea7atLZ/g8G7JcuxP4OusoOX8g+cQ9RUKh85ccVkp1sa60SzxnX
         DFfe7EV/tKtgIH0e2SccRbs+nHcpJlHUsMPDaJ71Kw4A+f6S85fODME+KAOp3Un0QGR9
         uS/qdZZE2MUPR1GftTsSJ0KbzkLJQgiK6KA6MSKOX1RvK0jjUx5guERbH8tkXc9bUZuN
         yaxA==
X-Forwarded-Encrypted: i=1; AJvYcCVaMoiBGTKQ5WlIYqVj3vXjZrqJGkFyTMfGkwnQJ5Eaz/vegg3IC3o6Hba9rMRCITih2W4OJwziEbKC3lkSwPXK+hAcU60AakJ4n408zdBi6CiHRLWQ5GQOjE+aToz3SLTeJGehLITWmtIhFXuTDYqJYlXRUawEpdQt5koV4YvNbvP6rhZqS/Qkh1xWGLnUWfnyYF8KP3gkh1nu4BaiimerkPgkf4DHHxB/riBjNv88IqO8Mfo9kpzXaxdfqNLfyV0Y4xNbSyDgL6b63mSR/DB6SDhFb/MO45SjJ2T27PHpyNRSciD8ilNYSerY4jZEN32Fw3+//nUbKGC7
X-Gm-Message-State: AOJu0Yyc+eaKz47yYcEHXvrA3cMxcGFkwPQNL7dqbfVq8289YvnnaMZN
	DZGv6i5zVPf/VOPV1FyGL+aH9qB7M+sZEyoG1KTXGuYeno3pOLNNR8Ki71MEtcAYPngOdNLsPKe
	z9Gp+1MrqUcB9JquCKE2758yNhXc=
X-Google-Smtp-Source: AGHT+IF9xXotb4fKJPIBJiGa5DZoshLJXVEv2bCNouhUyzFoUp1xvycg5pN3kRgz/qcs+lTDSybyD1fvb7+yeBualoQ=
X-Received: by 2002:a17:90b:613:b0:29b:90d7:36dc with SMTP id
 gb19-20020a17090b061300b0029b90d736dcmr281082pjb.19.1709911423609; Fri, 08
 Mar 2024 07:23:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com> <20240306182440.2003814-25-surenb@google.com>
In-Reply-To: <20240306182440.2003814-25-surenb@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 8 Mar 2024 16:23:30 +0100
Message-ID: <CANiq72mUJ6Nv+tDFoGbRYJs8Nzw18peFU3U-2cnz9MViyiG5ow@mail.gmail.com>
Subject: Re: [PATCH v5 24/37] rust: Add a rust helper for krealloc()
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 7:26=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> +void * __must_check rust_helper_krealloc(const void *objp, size_t new_si=
ze,
> +                                        gfp_t flags) __realloc_size(2)

The `__realloc_size(2)` should be placed earlier, i.e. this triggers:

rust/helpers.c:162:20: error: GCC does not allow '__alloc_size__'
attribute in this position on a function definition [-Wgcc-compat]

With that fixed:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

