Return-Path: <linux-fsdevel+bounces-25314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1796B94AA94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00AF4B2D039
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFC181AD7;
	Wed,  7 Aug 2024 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjyJtDvu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD7D2AF10;
	Wed,  7 Aug 2024 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041637; cv=none; b=joSW+7ZnoorMOgQ0cCewcWt1xiww+bZK9fWKgngRdSPO4t0qGKbM28z7+wBCfunmWc76FT1rm3o/GYOOrkdkT7Wy/PZlikevlAjc1PEf0hvbFgWbyBy5iMmiDzL0ohdgjhaI4Sl6MfLoDNrI5v1HkcWOqt3H5IlFuEunfUu3Vt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041637; c=relaxed/simple;
	bh=k1e+DTQXa7piacsCi07AoGlsl2Ell7kt4QgGzVwMFVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/dhtFKFa5iPVUiA6ZZhJORa+/eSObtJXHkiY3dPtErSJ5ey7RtBaCgX/xWwqfs9YPm+x4RbVFYslq5Mv05yoS99wqSDRLjtzUtkkmmMqmmJfslJH+FcKPlkbiK/bjtpKLMpVBGwQ1tTOwz8i2ZVnLQSuY78y2r3IHHfBZOE8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjyJtDvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7774C4AF10;
	Wed,  7 Aug 2024 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723041636;
	bh=k1e+DTQXa7piacsCi07AoGlsl2Ell7kt4QgGzVwMFVc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WjyJtDvu37cHalY8JqgwLoXJJXrj3NajA58HKmckLxS1NaOGflhm4cUp5TJOzPAfQ
	 h8xHRx/1cu7NFkrgjrmnZ6a3NNM+l/pwCUmZOpN2R2lcSJvN7G/9yjFgiUpEe7MRwi
	 R4wVi0QrZG53kCISs+L4RbN2zmBfjHpl4xLCCiaDZk1aO0Zcor7usoHhpkdgVETSuc
	 gtb/TCwJZvWknyUB//hlqLL+E0KMMkwGhtd2NcC11W6kSd4r5HO565Ck/fr396p8DH
	 krREJOdlwjtKznFRsHwWT2gKTT3LlxQoIysMPg3Cg0Dt8ak38yr/Qrymz1apzXsF4x
	 Fj6thivaX+8Ow==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso18759451fa.0;
        Wed, 07 Aug 2024 07:40:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1UyYBELryRHt4gBtoqS42nYU0kgLFxM/LsEEj60MmuQec5CcvjYyDNk+PoJ/ytP52EX+fPL+1MeByBDfkYUja9y5lULhyR3omz6JpL6L61ARImKHE7g+wUandrpWtdAlQmKNUv8qKsOmC+g==
X-Gm-Message-State: AOJu0Yyyj/9My1Bmxkypa7FWiALfAC58SaA2s3/wv1JpEasHxs2jl6gq
	xVDBncwDfzTqDsh+dIMJGBDEHn8vWmhOTlobVyxFw09X/hi7c+pd33necQZ24vXKVTRWriKNAa7
	9r/jzIEDTYtoMDrZPpK3dog+mMpk=
X-Google-Smtp-Source: AGHT+IG8u7VLCIctznC1zbQzPAcfPRcCY1SH+DZ2iQifiI5hG6p3xEn7G3j4ohzdL+JRu98xIT8kzmoyXqagtuHioI4=
X-Received: by 2002:a05:6512:33c3:b0:52c:d645:eda7 with SMTP id
 2adb3069b0e04-530bb374068mr13030948e87.18.1723041635109; Wed, 07 Aug 2024
 07:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806230904.71194-1-song@kernel.org> <20240806230904.71194-4-song@kernel.org>
 <ZrM_dOOcdbC7sMTV@krava>
In-Reply-To: <ZrM_dOOcdbC7sMTV@krava>
From: Song Liu <song@kernel.org>
Date: Wed, 7 Aug 2024 07:40:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7PEUKyOCYctTy6K3v0m+-UA83cvYpFS3-Ur0rU9LoNxg@mail.gmail.com>
Message-ID: <CAPhsuW7PEUKyOCYctTy6K3v0m+-UA83cvYpFS3-Ur0rU9LoNxg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/3] selftests/bpf: Add tests for bpf_get_dentry_xattr
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, 
	eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, 
	liamwisehart@meta.com, lltang@meta.com, shankaran@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 2:33=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Tue, Aug 06, 2024 at 04:09:04PM -0700, Song Liu wrote:
> > Add test for bpf_get_dentry_xattr on hook security_inode_getxattr.
> > Verify that the kfunc can read the xattr. Also test failing getxattr
> > from user space by returning non-zero from the LSM bpf program.
> >
> > Acked-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/bpf_kfuncs.h      |  9 +++++
> >  .../selftests/bpf/prog_tests/fs_kfuncs.c      |  9 ++++-
> >  .../selftests/bpf/progs/test_get_xattr.c      | 37 ++++++++++++++++---
> >  3 files changed, 49 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/s=
elftests/bpf/bpf_kfuncs.h
> > index 3b6675ab4086..efed458a3c0a 100644
> > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > @@ -78,4 +78,13 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dyn=
ptr *data_ptr,
> >
> >  extern bool bpf_session_is_return(void) __ksym __weak;
> >  extern __u64 *bpf_session_cookie(void) __ksym __weak;
> > +
> > +struct dentry;
> > +/* Description
> > + *  Returns xattr of a dentry
> > + * Returns__bpf_kfunc
>
> nit, extra '__bpf_kfunc' suffix?

Good catch.. I somehow got it from bpf_sock_addr_set_sun_path.

Please let me if we need to respin for this change.

Thanks,
Song

> jirka

[...]

