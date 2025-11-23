Return-Path: <linux-fsdevel+bounces-69576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B804DC7E681
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 20:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C2244E3D21
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 19:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA59246781;
	Sun, 23 Nov 2025 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fJxQgnH2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CB8225762
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763925954; cv=none; b=hKPldoTeSqHk2rCxlXl30m7isppGZdlV7Cx7QppcdYRqPe4UgcTzh2ymq7xAT9qqsQ0Demv123UFVapyIcGNil97HsAq+8hwWuyAiXYtu1xWncyP0pLKF43BPHBL6cq1oIuk9A2mrMO17tR5QQ8odLIw+/VS3pvSS/5zJfqDJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763925954; c=relaxed/simple;
	bh=DBsSkC+lKX7hhkdlAG71wPGPypyRvViV8UzuZHlhXTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLDtmKRZHDfyvU5Ke7xVXt7keiIqSZDoPeFHgDD9K8PKd3Obm4+gsjpWnrfl/rMvvW/TzPs5BODWpRuMcECeg3JN4HXLKKgp7dtUjOFbCnN4W+eYI6/+h2Oqsm81fkNBMYBg0wZtr/51HNUZygV/TF4H4pTpkWQcCH4h0VE9r/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=fJxQgnH2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so5624724a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 11:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763925950; x=1764530750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkF1W+HmVNp/SmXP72a3xWNyOn0/uzHxCyV8VfqPJ10=;
        b=fJxQgnH2i6eveDUEOj7v74SN07aSr9+7RRQhocUM09Ih1rHv5j0FhdaUhZzpojULw/
         C7Y+BgpORceAvoV/M46gYDxqqEIj6UpJ90v94Bh30Ne4KYJ0Xs5A9dA0AntTYNn5X+ob
         QDW2+gJ/m6KIW9mYZd1p7TH1i1OmeWbjg0Smpg/Yg9A39nK8PmIk+I4i19A6tyxtHwjG
         x+lhAbmqHkZLyme0Mg6QayIs9EsOl2+8KqJVlJ4T7IVl/ih469Gb98zcPqJ6kudNjMAP
         xDFWveHKjOfFNyP8VfbMH5L4DXhIL52Cjc3w8X4X23tGxiFuZk/HVK1jMEPx5MzTUQCG
         F0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763925950; x=1764530750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dkF1W+HmVNp/SmXP72a3xWNyOn0/uzHxCyV8VfqPJ10=;
        b=Uoal2qoDYFClGjn4LzCfbp80n3BbmulEGonVpdyMsazlVQXcfL4j0znwoYLEOkrcN7
         duVbVgj0lCMSK2pYnKrYrJvRN1NhFTCOpPWfI1AY44t3tjtuHKUfFDaqq2nuuRSj6g+L
         HSoFChVUGk7mwogWZ/DVO5E4mTTLGsiSPkFSW7dXdHxMp1Si/EF1wFMzPU/JVFwBjieP
         i8QmH8bdqsdUU5fjt8B+agTNhGRkpBXYwS+Z1XwiAM6cJQy1aHFRQz6SQjZm0817fYr7
         fdf8UqNpGiX2nU2ttzZJf0+a8ZGnu+YV0M58UFp+9+zwbIPw4cH1EuaP+jPTTEFsfn2p
         UHjA==
X-Forwarded-Encrypted: i=1; AJvYcCVR0+u97BhQj+iGFTVeg7v63K7ha5DqAcrpBGxOG7XKm+V7bJEy2+DLMCultqbr7azzudD62SBYwX4darfN@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqzjet3HpfdK3QQ5Us4FBy23MK9jv4P+a8ZT3hp4QZMlgh/igT
	Udl1VkmtiGF9ulHicl2ofxfvxbec1w547lq74A/dFREARzbdO/pMtRIdi4E9UdDk4oqJDrtiCPc
	dDzEDkKX6KcsuxPz9D3YRjb8rkfqs1NI1cGOtrRC2MA==
X-Gm-Gg: ASbGncvSLtHqbnnh3ZvFfCUTwA+sqJ2YPvpIgyE/RPapkhPIpsG8rIsgZ5pDwdACVRW
	olIy6Y95RkJ097aWfEnmjKXME0CLFzAlMYOvBj6wHuF532BNMBzkMYWgG/vfCr3cbPjATGEOAAc
	eKBO174uQ6LYSfSWfynAt2jIvM3SC8ptymtvy+caKmeJaasjLY2gwDgSsZ/HAvw1vPuZRfxriSD
	wCda+K2bY86T0T9xUp5QW+s1wtWjbDmcZaxGxOJUoZoeVPZ8zP0FX2zLxE++hSLcgSm
X-Google-Smtp-Source: AGHT+IEAMY0pvJyme6T1x/GXi+zAz7fUHPUOcouP4DWp2W4b/iQCr9XdKr/m0KnneLDceMLTWxGdGs7cWzgaueOTCwA=
X-Received: by 2002:a05:6402:2750:b0:640:f1ea:8d1b with SMTP id
 4fb4d7f45d1cf-64554665a54mr9031837a12.16.1763925949554; Sun, 23 Nov 2025
 11:25:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-6-pasha.tatashin@soleen.com> <aSMX_pnUShilO_sj@kernel.org>
In-Reply-To: <aSMX_pnUShilO_sj@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 23 Nov 2025 14:25:13 -0500
X-Gm-Features: AWmQ_bkm6GWLaDGmSYxA_sDe-BfkSNdLO3VJvb3Ilu_NQl85-GJkxSTO8YXhl0w
Message-ID: <CA+CK2bANLwj+nqDy8_dXgCBym_VFSFW26naqC3x7XED9tC-TYA@mail.gmail.com>
Subject: Re: [PATCH v7 05/22] liveupdate: luo_core: add user interface
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 9:20=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Nov 22, 2025 at 05:23:32PM -0500, Pasha Tatashin wrote:
> > Introduce the user-space interface for the Live Update Orchestrator
> > via ioctl commands, enabling external control over the live update
> > process and management of preserved resources.
> >
> > The idea is that there is going to be a single userspace agent driving
> > the live update, therefore, only a single process can ever hold this
> > device opened at a time.
> >
> > The following ioctl commands are introduced:
> >
> > LIVEUPDATE_IOCTL_CREATE_SESSION
> > Provides a way for userspace to create a named session for grouping fil=
e
> > descriptors that need to be preserved. It returns a new file descriptor
> > representing the session.
> >
> > LIVEUPDATE_IOCTL_RETRIEVE_SESSION
> > Allows the userspace agent in the new kernel to reclaim a preserved
> > session by its name, receiving a new file descriptor to manage the
> > restored resources.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks

>
> > ---
> >  include/uapi/linux/liveupdate.h  |  64 +++++++++++
> >  kernel/liveupdate/luo_core.c     | 179 ++++++++++++++++++++++++++++++-
> >  kernel/liveupdate/luo_internal.h |  21 ++++
> >  3 files changed, 263 insertions(+), 1 deletion(-)
>
> --
> Sincerely yours,
> Mike.

