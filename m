Return-Path: <linux-fsdevel+bounces-50520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C02ACCF29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 23:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81DFE7A3F0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 21:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A7C23BCF0;
	Tue,  3 Jun 2025 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMTtnqrt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2AB226CF8;
	Tue,  3 Jun 2025 21:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748987110; cv=none; b=W5RNssB5uH/9GxPqzG5wofsC98+SiIv8jidvLZZw+b9xc6n6JtaTEG81j4aP5pViJ7d6OAbAgtUvOoeV0KWyBaicrg62LUwvJoM7Sfv1rxY/Z8JKMOaGlaP24TohdVaTa6tGYhCpKMayH4oySsPYsFw7+2hwKW9JQsgnv+xjNYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748987110; c=relaxed/simple;
	bh=RCs8/uMB+ezaarYU/ndq+IH9j+JTL8HLGA+9mgA2CWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qALWxcCs+blo60Q8OMiI293dKqbYg0gWWRQ8oGGDTKOBb52gJE4y85wy0Q2lHr2hHhwdLGFkN7lB3jvCSw0T3oHDhBH0S53IfoEeY8KIMS+L93UUGLh5Uv9Ehe1ygSegJzvsRtNwxnNiEonbelRXnGAhri5tJ1uoUSpiaa78fes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMTtnqrt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso4978554b3a.2;
        Tue, 03 Jun 2025 14:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748987108; x=1749591908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=819jl8ds/qzrOtBRq9UfsH7pGIYx+U6oQEMjUt1XFXA=;
        b=OMTtnqrtM+9yLJl8QDHREgemGKdVFvgRI4bLOVmrEJTvptoEUkYGVpXZtfFwp2/572
         wwnRUzw8siUcHOYdmpHwZnPbNVRqv8gA7m2LfpBEY6F77BNG6Q3ifmXhGPfmVQ5c2wTU
         WLKQhyHBsJBiDBfx1ptabECoe+/onbPxqXfbLasWKhnhgKGc8vLPfjHZv6d8Pc5ViBog
         Cxzc+EGVgh808ED3itcx2o83O/AsSlChA0e6xlPwU5vw/1wr7kqP59JLoFadRTL59d4p
         Vyt2KHPbfaeoogbk7dLEUCAzHRgnTLkc/m5ciLsnYg4Cmko4dgOxjAvTON6ZvL9H/PrA
         79Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748987108; x=1749591908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=819jl8ds/qzrOtBRq9UfsH7pGIYx+U6oQEMjUt1XFXA=;
        b=jcU9fxT6DeYhdfXcVaR+BHbtM1kYw6BdI9DiDIAfRRUiJ1y2NLiydE7Ub94yuVZn/C
         ia/yvwUvAi9RxEUCCkfBSBrZi8u7WVe37wAbg0woUSfl2raJAszAwzZTM4C+tBPS/jim
         FwuuKtLpil+Y+8B9aH2vyNc7go5BI9EJRyUQ/Dtr2qyQy2FcQw8xXOwSzmh249f+VVvp
         je3HREI0sjoUp0KKragDYZjMCCHXR75mhNg0un76gd1kWXxT6WihMxG3R7T+ZHXlq/5C
         PrZkgNm3cw3wzfHxWd6f6M20FKVCH6yH//5lDxP16zCO3LNxGOOGXsKC0C7jSBMJRIyN
         m3kg==
X-Forwarded-Encrypted: i=1; AJvYcCUJDK9ixVvMueH1kQKec9VZRoAA4nGvSpyLm83Ol93V+86KwlXM5zRiKq6clqkIjGKyqvM/3p9FZRzbcx4x9t3RFEnmnSr4@vger.kernel.org, AJvYcCXVizrmlODj4dLSE/Pe7NyxTnsd69fPz84n5EgnpabVkjNpMZFYYDQuJwXqCWSM9ylhb7dfNUj1wlcuEvFT@vger.kernel.org, AJvYcCXeUImCfac0SMcFYpZCZZQ8HwrL79Y0rk64bSGwcV4BNucT4YyZCZu4nMTHWlGeLkOGbMX3BAviIy4wuPvQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4+fRYVyZma0CUydSqZ099RuyG2nO2DU74XTMoPbePIh3YOeLS
	jepmGK1M0iHsUjhq0WP0oymqLyneEfC3OqmL32EI6vEx+0Kk6caWA5GF3LaqIkW7aEdMdiTNLUu
	/4P/5vzm/eKIzGGzjIUunhWBCEctfeIxxyg==
X-Gm-Gg: ASbGnct45w2X1GSnOWGXh1k7SmqLVwFMEvSM3txyxrl86qusQzPEnh5LgTSyK4ggyFp
	LgwQnPvdJfpNVRVfHdVACnHhylCHhmUXUcZRWwZPUzTiFMwUf/BnFT1Zew0UlvLAwb4/svFSxXQ
	6OPhXUdebCvvlOzIyXF2gyQcH30xQRrRd9DYDQFMVGNbrDOPlS
X-Google-Smtp-Source: AGHT+IF7MqQcSA/FsUXrpXDFQkq09C3I0U5aU6W0tB+ZTkwFNkLdxNttYUEiVQNLgyvtjX4iDkjJwYwdm7yVHveMMME=
X-Received: by 2002:a05:6a20:729d:b0:215:edce:4e2c with SMTP id
 adf61e73a8af0-21d22d08e2cmr569327637.28.1748987108576; Tue, 03 Jun 2025
 14:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603065920.3404510-1-song@kernel.org> <20250603065920.3404510-4-song@kernel.org>
 <CAEf4BzasOmqHDnuKd7LCT_FEBVMuJxmVNgvs52y5=qLd1bB=rg@mail.gmail.com> <CAPhsuW7mwut7SYubAUa5Ji7meDP1Bn8ZD9s+4sqjBDim7jGrWA@mail.gmail.com>
In-Reply-To: <CAPhsuW7mwut7SYubAUa5Ji7meDP1Bn8ZD9s+4sqjBDim7jGrWA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Jun 2025 14:44:56 -0700
X-Gm-Features: AX0GCFtNF4ppXnOnKhcp7EPaFV861gMLhwM4EEIUcYJLDXBOjd5THFRV5GW8gWM
Message-ID: <CAEf4Bzbm=mnRM=PYBLDTogrb+bNk2TnTj-kGr3=oFNEyQm8hKw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Introduce path iterator
To: Song Liu <song@kernel.org>
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

On Tue, Jun 3, 2025 at 2:09=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Tue, Jun 3, 2025 at 11:40=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> [...]
> > > +__bpf_kfunc struct path *bpf_iter_path_next(struct bpf_iter_path *it=
)
> > > +{
> > > +       struct bpf_iter_path_kern *kit =3D (void *)it;
> > > +       struct path root =3D {};
> > > +
> > > +       if (!path_walk_parent(&kit->path, &root))
> > > +               return NULL;
> > > +       return &kit->path;
> > > +}
> > > +
> > > +__bpf_kfunc void bpf_iter_path_destroy(struct bpf_iter_path *it)
> > > +{
> > > +       struct bpf_iter_path_kern *kit =3D (void *)it;
> > > +
> > > +       path_put(&kit->path);
> >
> > note, destroy() will be called even if construction of iterator fails
> > or we exhausted iterator. So you need to make sure that you have
> > bpf_iter_path state where you can detect that there is no path present
> > and skip path_put().
>
> In bpf_iter_path_next(), when path_walk_parent() returns false, we
> still hold reference to kit->path, then _destroy() will release it. So we
> should be fine, no?

you still need to handle iterators that failed to be initialized,
though? And one can argue that if path_walk_parent() returns false, we
need to put that last path before returning NULL, no?

>
> Thanks,
> Song
>
> >
> > > +}
> > > +
> > > +__bpf_kfunc_end_defs();
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index a7d6e0c5928b..45b45cdfb223 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -7036,6 +7036,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
> > >         struct sock *sk;
> > >  };
> > >
> > > +BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct path) {
> > > +       struct dentry *dentry;
> > > +};
> > > +
> > >  static bool type_is_rcu(struct bpf_verifier_env *env,
> > >                         struct bpf_reg_state *reg,
> > >                         const char *field_name, u32 btf_id)
> > > @@ -7076,6 +7080,7 @@ static bool type_is_trusted_or_null(struct bpf_=
verifier_env *env,
> > >                                     const char *field_name, u32 btf_i=
d)
> > >  {
> > >         BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
> > > +       BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct path));
> > >
> > >         return btf_nested_type_is_trusted(&env->log, reg, field_name,=
 btf_id,
> > >                                           "__safe_trusted_or_null");
> > > --
> > > 2.47.1
> > >
> >

