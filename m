Return-Path: <linux-fsdevel+bounces-50517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 441BDACCEAD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 23:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2B91886397
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 21:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27E022539E;
	Tue,  3 Jun 2025 21:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZ8Goc0O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7E754918;
	Tue,  3 Jun 2025 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748984975; cv=none; b=EJpWi1XwQNG1swk98LwGvjoPmmNEMSePZaQ4y/JgqLAHR1S57Gh7PldvKFT2LdsodCoB9gEfkCdI6he7cyX9ezCbS5At5oAJf0fUBIFTuBus0s3ulqQD2AVsjBH75r67P6JMrVv0neZ3vRPZslW4/Pi4r6/FpTU30F0RemhcjWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748984975; c=relaxed/simple;
	bh=SK0VuAs7KqC4TjvZbevh+r/sXC+NMvrMP1MNVXAkAKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2qu8pxcSZPze+NtmmmEcRaIGHKBnGdamHFcZ9P4CwuEWpIkzLzW0batVEY8R36+/ARqOnlKg7ZCW7xrUq+Z8oEUnCIBM2wbfkD7peECBU54308ZlwB+IyQCBFbqShEM4s5yzIn7MyxtP9F6wISIVX1SLyG7EVwOV2eISusfkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZ8Goc0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C92FC4CEED;
	Tue,  3 Jun 2025 21:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748984974;
	bh=SK0VuAs7KqC4TjvZbevh+r/sXC+NMvrMP1MNVXAkAKs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mZ8Goc0OGGsxDAEqlsE9LVAsOa0tQJirxGW+Rp7CMZZCZ/kOR/XxiY/xBLZRo1Ujx
	 gvsJZASe9IhTFCOHtl2f/XSr7DTlu+OlSohSlgGJC+fH+P37olcb4waUFR0J8i730h
	 tH4HhMzH4AAI7TSWMC+bY0EZDEeBqDHGhdOmhSM5+Tlh2v54vUdnUiSzC8KUidaf2w
	 GdcKuBwpkqswsC/P3b5I8888Ak4z09MTjLZh7ibhK7cgSPmXRFctE2lizB2VIVFFrF
	 flKdGi7cedy5JLdsSCd6V4YbhcjaUmgrY/60VPEaChDohdarJgIzTuqxoXhdXGRoIu
	 dgxEKLVMpZEPw==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fad0820112so3882316d6.0;
        Tue, 03 Jun 2025 14:09:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlATlxGd7Uz4eR5BqvUiiYLFqHbEGvB+gLMxKyqlZAUWm3ixw1iUymTPvReM66KzDStTK3KzgyOn7s0sbq@vger.kernel.org, AJvYcCVuvm8jDWFbWMuMgX8g1hxkuxKi7T+YJKh/yGrjUYdHjRWH9PDt2XqlpVrGecqBG7O5IAaY7dfUOIjlRq+A@vger.kernel.org, AJvYcCXHzSajiURQWzBQdPEPUzk0WOwZWzw4C5wh5T6+kKeaXZOP8JRH6SljYNXaVHRl23zC0gkd51i2WTs6CUqTqenZn2WVQxIk@vger.kernel.org
X-Gm-Message-State: AOJu0YwuXcPR4Y7Lr/V06ZXCMqoGDLINy/63xRFhgq9Lh/txlN+cBz9k
	9ITxhcV2HMWCLoAMos0ITfHgH2ACwPrJjftpakQDyVygR16EmlY+G+C5nR/11CF0a42XUUZHvqu
	VyUKyBdnUd7m7QjNrZsNGuDP+IgTZM00=
X-Google-Smtp-Source: AGHT+IGIwMbDd0jXLmSygYRd4/MkAIct4a1Jw2aqmQh14hAObNsts2iJ6fo7aPaDUAURnnILo2I0fMYiXdCifc+2bRM=
X-Received: by 2002:ad4:5f45:0:b0:6e2:4da9:4e2d with SMTP id
 6a1803df08f44-6faf6a6c328mr8401036d6.9.1748984972741; Tue, 03 Jun 2025
 14:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603065920.3404510-1-song@kernel.org> <20250603065920.3404510-4-song@kernel.org>
 <CAEf4BzasOmqHDnuKd7LCT_FEBVMuJxmVNgvs52y5=qLd1bB=rg@mail.gmail.com>
In-Reply-To: <CAEf4BzasOmqHDnuKd7LCT_FEBVMuJxmVNgvs52y5=qLd1bB=rg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 3 Jun 2025 14:09:20 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7mwut7SYubAUa5Ji7meDP1Bn8ZD9s+4sqjBDim7jGrWA@mail.gmail.com>
X-Gm-Features: AX0GCFtqsYbKlyyk6L9CQ1-wot5BYMF3VoGjSP70JqKG6PkWNwWNyrGGQjbCro4
Message-ID: <CAPhsuW7mwut7SYubAUa5Ji7meDP1Bn8ZD9s+4sqjBDim7jGrWA@mail.gmail.com>
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

On Tue, Jun 3, 2025 at 11:40=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
[...]
> > +__bpf_kfunc struct path *bpf_iter_path_next(struct bpf_iter_path *it)
> > +{
> > +       struct bpf_iter_path_kern *kit =3D (void *)it;
> > +       struct path root =3D {};
> > +
> > +       if (!path_walk_parent(&kit->path, &root))
> > +               return NULL;
> > +       return &kit->path;
> > +}
> > +
> > +__bpf_kfunc void bpf_iter_path_destroy(struct bpf_iter_path *it)
> > +{
> > +       struct bpf_iter_path_kern *kit =3D (void *)it;
> > +
> > +       path_put(&kit->path);
>
> note, destroy() will be called even if construction of iterator fails
> or we exhausted iterator. So you need to make sure that you have
> bpf_iter_path state where you can detect that there is no path present
> and skip path_put().

In bpf_iter_path_next(), when path_walk_parent() returns false, we
still hold reference to kit->path, then _destroy() will release it. So we
should be fine, no?

Thanks,
Song

>
> > +}
> > +
> > +__bpf_kfunc_end_defs();
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a7d6e0c5928b..45b45cdfb223 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7036,6 +7036,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
> >         struct sock *sk;
> >  };
> >
> > +BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct path) {
> > +       struct dentry *dentry;
> > +};
> > +
> >  static bool type_is_rcu(struct bpf_verifier_env *env,
> >                         struct bpf_reg_state *reg,
> >                         const char *field_name, u32 btf_id)
> > @@ -7076,6 +7080,7 @@ static bool type_is_trusted_or_null(struct bpf_ve=
rifier_env *env,
> >                                     const char *field_name, u32 btf_id)
> >  {
> >         BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
> > +       BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct path));
> >
> >         return btf_nested_type_is_trusted(&env->log, reg, field_name, b=
tf_id,
> >                                           "__safe_trusted_or_null");
> > --
> > 2.47.1
> >
>

