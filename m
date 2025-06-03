Return-Path: <linux-fsdevel+bounces-50542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87326ACD034
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 01:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F5017715E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 23:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71859253359;
	Tue,  3 Jun 2025 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbUmJx91"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C636B2066CF;
	Tue,  3 Jun 2025 23:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992816; cv=none; b=YKYONHMzflehBS6Zzq7BIJAFqXeP+IrK210VxGgYsePKgQFStDCXNDkiKoFcqMjKhA2X53k01Vv+M6lmue81d55OZIKVuWRYN7RDTymlK2S4+ngvDxuZe2IMob9ARBGiO0SpiWfDwiQPVWOiDazzyjqoejVAa2y5WiB67FkXeAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992816; c=relaxed/simple;
	bh=G6HTrgY8s0ABn2090OgkfKLlCb3pzWh2OSW5n7m8PzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgaLtKMk8UbYuTPPv0jQQfwU//4wwdzZBWasMPiNW8hSFjjyjHbI83h7KU4TbP7DHrFMkxE2TpNeWKZabjJQps+sY3kw4riS9t3stW8ZvrMRL3RszKK9irnzJGKr9bdOk3O2b12IY3Wv/IYdBRA5pkDsP6NUU0j9/E4skUwLlt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbUmJx91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68C8C4CEEF;
	Tue,  3 Jun 2025 23:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748992816;
	bh=G6HTrgY8s0ABn2090OgkfKLlCb3pzWh2OSW5n7m8PzU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NbUmJx91iy/w/IK5R0+Cdo5UJz/LFbcnT4kT26yxDO+HIDcIQWmscRvwBeN3eN52x
	 4Z7rHysC5lPHkqfpR3w6mYy4n5UbBx2OZ249PdP9tT9pZ6vmjsELhLKNav7NIuP3h5
	 bT+S3PVFceH1+FUaPMcooMXfp6MmN5gJRFsGGKDP9zmoBJ+tLXTq2VoXE5WyctIk4j
	 3BQeKPVuiC7BL8V9CS8HS8LnU60DReTxo11SrPParwnSaXnjbQ1ePz02Vit5Gli3pY
	 XqWQL5pPrLieasMjfmWU6lzHGsVlBLD0to4ZoWDUDx18xurRTVoCalCq/OdJHvPuyo
	 vE6GZqk9OGYug==
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a44b3526e6so54923671cf.0;
        Tue, 03 Jun 2025 16:20:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjswvYVf0Whm2YcUMbqVObWgLSFcDt4jFgU7nOcUYxhFqAiu3c2oDXGV8DyzRM9RFfGrhJHkTbfRCXWj0p@vger.kernel.org, AJvYcCUzjYGhbH6kwDG3fgH8DNWzm9YVang8tBqSbezlF7JGhBM3c3hwydvYPmIk+ExdlZJbx45B+r8iCfVhkIYU@vger.kernel.org, AJvYcCXETEJztUs11k7ewwVcZA4fFV/mAHVZObdp54YhILMIxzMNgCCAMvk6OmFa7P2lBru1VWAOjnY1p80EmRX+98BW8HDIFogv@vger.kernel.org
X-Gm-Message-State: AOJu0YyEbvK+XClsLMtZPFFo8HnH1x9dMc0NgqeCig8LlW7sq3JLimrO
	ynkSWWydroiLrUctuLdeN76ogs8fUr1EqGk//YqwRrA7c3CVmpVo3/IwP3lofk6X0Utqyau+3Sm
	fxbQyC4huQhVy7RfuivFDKidoPTsjZ78=
X-Google-Smtp-Source: AGHT+IH4Kd1zp8ji2+OmIj64se2PS6DJY05aRquelehbqiinjRk4WB/znGty+R9MDWOshmgqyXVU24LS5KDCLoNBSEU=
X-Received: by 2002:a05:622a:544b:b0:476:980c:10a9 with SMTP id
 d75a77b69052e-4a5a57fc70bmr13760421cf.21.1748992815883; Tue, 03 Jun 2025
 16:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603065920.3404510-1-song@kernel.org> <20250603065920.3404510-4-song@kernel.org>
 <CAEf4BzasOmqHDnuKd7LCT_FEBVMuJxmVNgvs52y5=qLd1bB=rg@mail.gmail.com>
 <CAPhsuW7mwut7SYubAUa5Ji7meDP1Bn8ZD9s+4sqjBDim7jGrWA@mail.gmail.com> <CAEf4Bzbm=mnRM=PYBLDTogrb+bNk2TnTj-kGr3=oFNEyQm8hKw@mail.gmail.com>
In-Reply-To: <CAEf4Bzbm=mnRM=PYBLDTogrb+bNk2TnTj-kGr3=oFNEyQm8hKw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 3 Jun 2025 16:20:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6rdJpP4pqtgU2WC8-KOkNObeY5ELMy_ga_0YjJJj0NaA@mail.gmail.com>
X-Gm-Features: AX0GCFv8ElnQFepo78HRXo57cLt23SB-SkBGmvc12qF61wcH0yiwIRcZkJdh_7E
Message-ID: <CAPhsuW6rdJpP4pqtgU2WC8-KOkNObeY5ELMy_ga_0YjJJj0NaA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Introduce path iterator
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, gnoack@google.com, 
	m@maowtm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 2:45=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jun 3, 2025 at 2:09=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > On Tue, Jun 3, 2025 at 11:40=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > [...]
> > > > +__bpf_kfunc struct path *bpf_iter_path_next(struct bpf_iter_path *=
it)
> > > > +{
> > > > +       struct bpf_iter_path_kern *kit =3D (void *)it;
> > > > +       struct path root =3D {};
> > > > +
> > > > +       if (!path_walk_parent(&kit->path, &root))
> > > > +               return NULL;
> > > > +       return &kit->path;
> > > > +}
> > > > +
> > > > +__bpf_kfunc void bpf_iter_path_destroy(struct bpf_iter_path *it)
> > > > +{
> > > > +       struct bpf_iter_path_kern *kit =3D (void *)it;
> > > > +
> > > > +       path_put(&kit->path);
> > >
> > > note, destroy() will be called even if construction of iterator fails
> > > or we exhausted iterator. So you need to make sure that you have
> > > bpf_iter_path state where you can detect that there is no path presen=
t
> > > and skip path_put().
> >
> > In bpf_iter_path_next(), when path_walk_parent() returns false, we
> > still hold reference to kit->path, then _destroy() will release it. So =
we
> > should be fine, no?
>
> you still need to handle iterators that failed to be initialized,
> though? And one can argue that if path_walk_parent() returns false, we
> need to put that last path before returning NULL, no?

kit->path is zero'ed on initialization failures, so we can path_put() it
safely. For _next() returns NULL case, we can either put kit->path
in _destroy(), which is the logic now, or put kit->path in the last
_next() call and make _destroy() a no-op in that case. I don't have
a strong preference either way.

Thanks,
Song

