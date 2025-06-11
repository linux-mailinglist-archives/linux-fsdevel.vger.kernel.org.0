Return-Path: <linux-fsdevel+bounces-51350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96483AD5DD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 20:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0523AA188
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 18:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22380288CB4;
	Wed, 11 Jun 2025 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDieeVu8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA4225BF17;
	Wed, 11 Jun 2025 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749665323; cv=none; b=XVnCd4IACe7jsSa375S6Lkz6nbuf7xLKOUyLhmlC9EdS3uHhpV8Gptydzm7jFt59m/hr4Z3n2vv5y8T+V/zqmvsR4ydCe1VRYfehZznnBkcmgDrGc5nIPuSgIfMOsjHVEVfuxtKWw9V8yytqPBiW9W9Ss/a36XSx/O7Cqpu8xYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749665323; c=relaxed/simple;
	bh=vuuuUMNJTrbQEHqQfENAGTBD+eC4GhUdnYLcn0MH/mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrz72i+skQG2JEp6kuVLTxNsiSi9K8mu66Y6Lpuf7ndmGrzcSHfZj9nff0mqrnA0Hq9xqvPhIFWkJrhcKD6tDJZZdBHRTx78gZ43MYqll5DZY8jEkHoVa466vcCb+Bwc16aIwIEjeBVkZSBn2w15NHjRerUpcPctKsL8rdDyKOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDieeVu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF1EC4CEF7;
	Wed, 11 Jun 2025 18:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749665322;
	bh=vuuuUMNJTrbQEHqQfENAGTBD+eC4GhUdnYLcn0MH/mo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LDieeVu8mKI6wIBQ8ZdpWUZUldPV9W0BwMM4LUOtbgqvvI4d0dtyk/SmXmQcfSaIR
	 d6TnwRoMNtpY2sAOYNUwrazXaCv4ekn4sW7LK2+1VGqEtvkHjYkxUCR9+bp0zDRSuU
	 KJCUi9kSsfFeRWtJgtF7/hH5uGaY7geR8/vMde+87w1jt2vCfo6pr2TV2t0d8zflOb
	 RAky1CQfM9+j8Y9RKDCDL8A4/T4Q0UsFlvFDxLELvdB7HQW8SYY8rme9CVEUNY9IE7
	 WtHdIfp6Qaj7Em7YQKdBuzyInfzFSTbeUTEqoqxssqdiC3toNkz/jnhfTWxSTcyjOO
	 5yfOuTdcgf7DQ==
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fa980d05a8so1978976d6.2;
        Wed, 11 Jun 2025 11:08:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVduRSp4ap98z1mjQzIgAUH30ijMd0isDFfMzn7a9TKBKHA1PatbbxBiI/AeQoFvOdhjLE/wUFOm5Bpja7y@vger.kernel.org, AJvYcCWDjEwDVtHqJfo82V2esdRXUAiOc0Fx/lwhFjYLSgd/lj7QH+QVyprMcNjWGb0V4zLy1Es=@vger.kernel.org, AJvYcCXfM5dEVawYAjsAge2Cvt9rFc3h4bRg56utcQvuYGP+f/T9d5AJ2AsOCdOFK0tJDEcswmaO/hbvLYugTlXd5g==@vger.kernel.org, AJvYcCXimap53u38UvBIzmLw1T92OwfGDLEuCYVs4ATk8wCDZHAJauz+5WviGluy+auC7+bQsoWb0/G+4w/Cj71eZfgvdYBnygAj@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGOu7rxk50a6iSQJ/1Pd/tmIAFjiNud0CT7i6MsOCwki+uIzV
	DrL8nZHwOoJq1/7J/vTH79zdLnoyuCSfj04nFnHTxwJhtVdz3/B+bfSJukeOv5d6J6D3zXF+OTm
	tmD/VY5AJvQVcjPXCJPMxrPRzNOe31fY=
X-Google-Smtp-Source: AGHT+IGzNRxckgFW6/9tgae8ZuBzm8ytC4tCv/ilGsBolC7Bp6fawNV0TjQIMFe+Fjv7DtylNA1bhEMA95ml5uL/rzw=
X-Received: by 2002:a05:6214:e4d:b0:6fa:b1bb:8315 with SMTP id
 6a1803df08f44-6fb2c31b52emr62514016d6.6.1749665321863; Wed, 11 Jun 2025
 11:08:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606213015.255134-1-song@kernel.org> <20250606213015.255134-2-song@kernel.org>
 <174959847640.608730.1496017556661353963@noble.neil.brown.name>
 <CAPhsuW6oet8_LbL+6mVi7Lc4U_8i7O-PN5F1zOm5esV52sBu0A@mail.gmail.com>
 <20250611.Bee1Iohoh4We@digikod.net> <CAPhsuW6jZxRBEgz00KV4SasiMhBGyMHoP5dMktoyCOeMbJwmgg@mail.gmail.com>
 <e7115b18-84fc-4e8f-afdb-0d3d3e574497@maowtm.org>
In-Reply-To: <e7115b18-84fc-4e8f-afdb-0d3d3e574497@maowtm.org>
From: Song Liu <song@kernel.org>
Date: Wed, 11 Jun 2025 11:08:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4LfhtVCe8Kym4qM6s-7n5rRMY-bBkhwoWU7SPGQdk=bw@mail.gmail.com>
X-Gm-Features: AX0GCFuvcvlocezfv1YysEsbb8GlPxqoc1TmFc95N3B5xJlTqTWXOvm7IcF3gM8
Message-ID: <CAPhsuW4LfhtVCe8Kym4qM6s-7n5rRMY-bBkhwoWU7SPGQdk=bw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/5] namei: Introduce new helper function path_walk_parent()
To: Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	NeilBrown <neil@brown.name>, Jan Kara <jack@suse.cz>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, 
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, 
	gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 10:50=E2=80=AFAM Tingmao Wang <m@maowtm.org> wrote:
[...]
> > I think we will need some callback mechanism for this. Something like:
> >
> > for_each_parents(starting_path, root, callback_fn, cb_data, bool try_rc=
u) {
> >    if (!try_rcu)
> >       goto ref_walk;
> >
> >    __read_seqcount_begin();
> >     /* rcu walk parents, from starting_path until root */
> >    walk_rcu(starting_path, root, path) {
> >     callback_fn(path, cb_data);
> >   }
> >   if (!read_seqcount_retry())
> >     return xxx;  /* successful rcu walk */
> >
> > ref_walk:
> >   /* ref walk parents, from starting_path until root */
> >    walk(starting_path, root, path) {
> >     callback_fn(path, cb_data);
> >   }
> >   return xxx;
> > }
> >
> > Personally, I don't like this version very much, because the callback
> > mechanism is not very flexible, and it is tricky to use it in BPF LSM.
>
> Aside from the "exposing mount seqcounts" problem, what do you think abou=
t
> the parent_iterator approach I suggested earlier?  I feel that it is
> better than such a callback - more flexible, and also fits in right with
> the BPF API you already designed (i.e. with a callback you might then hav=
e
> to allow BPF to pass a callback?).  There are some specifics that I can
> improve - Micka=C3=ABl suggested some in our discussion:
>
> - Letting the caller take rcu_read_lock outside rather than doing it in
> path_walk_parent_start
>
> - Instead of always requiring a struct parent_iterator, allow passing in
> NULL for the iterator to path_walk_parent to do a reference walk without
> needing to call path_walk_parent_start - this way might be simpler and
> path_walk_parent_start/end can just be for rcu case.
>
> but what do you think about the overall shape of it?

Personally, I don't have strong objections to this design. But VFS
folks may have other concerns with it.

Thanks,
Song

[...]

