Return-Path: <linux-fsdevel+bounces-68955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E52F9C6A592
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E014E2C650
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1156F2E2DF2;
	Tue, 18 Nov 2025 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ATjLX8UZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C951E47A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480291; cv=none; b=pUFdeL4ZWvrXXn3eDx9lU8MSruQYrx2uKzE5tZWcNoc7X7AMUM6xwOipZBUQIah8jcNPW2CpZ6T22IrWnqyjTmoOc3SS3YyMAY2Zlyb9k233YrqIRZm2rBysLvBhgLCd6zD10+zQWErh8SXDkhWCwXrLJZVL2XVR9BxA6Ir0+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480291; c=relaxed/simple;
	bh=B6uekXVR+jn/Plqa3NW/kjSUDt55yanBt9ufFPxdFs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcNicf+FXSQ0FiQm6rPCexe/XMUldNgnOD7dCSik1Guj6+5WAIaVJ4n7zXf2esBQnl5JU4fOKkK5Qvd2LTZph8/DXo47FtuFSS361B7wz9Zdvow6DIQDnSvPxlltnvyX/AJ4uRQGRbjQ2dZQhpOJq9N8yx64y73Ziml3wWEub4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ATjLX8UZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso8808663a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 07:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763480288; x=1764085088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6uekXVR+jn/Plqa3NW/kjSUDt55yanBt9ufFPxdFs0=;
        b=ATjLX8UZtWxHrtg5aJUXJkDwbx3GXE3jiyzFXB5PM6vXc+Q2JEWz5kEtrHB/BkQi0B
         vDp+xu5TaBP5K33rI3r2NtDI8h9JW77buIRtCONzRO6P7uCSbMsRCQPt3yTu7THpgGTj
         6IZx2QxgjkJWrn3hfyxWQNxp7I94xi9z7nFLnRqDxW7dHJVStPWZiwVMwiVjIQvd6Fbf
         OLhMLLFps9tS5pJxkJmEyFSKIuxcs4WTZA8LUiwjrpPfuIfsVUbgvow7VmvrKUfcG+9z
         m6mxe11b57pmEEq8FM5CmlPK7eESRS+31R6A+fU9CIcepoUabLjK/Jo4MRk2YKwR7ANj
         LJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480288; x=1764085088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B6uekXVR+jn/Plqa3NW/kjSUDt55yanBt9ufFPxdFs0=;
        b=oN3eFNDgqiCF4hcLxO3094FiuAzJvSMtzwzpvo4f0FggKUpQv8D4RGpI4QMGKc7h9b
         4F4mBltJsKkc+WpEH2f6EHx1JJNdbjdkrvpZa5JyE+xKfHMpijQIXSO1vHpVvgK20dYR
         sWJ/x2tCI8JiiOBtz7V/x8gVHXcsz4OFdarJVYApf/j/iUeZfZEud7kpNMXxP8PqLA6L
         o/XWdLVdA5O4cwG2tNet/ihoWCOWEVyFgsg+Q16/ei5jQVPCwEC+CnT12SlvtfjLamd1
         7Folaui54A+0aXb4W9QDtro/CWznYTZzmeFupZ1Mo9SuMWtzsdYJUDGAxUl+9sZEw3iD
         7g7A==
X-Forwarded-Encrypted: i=1; AJvYcCUk/F9e1bPJ8HE4mlyfyIiBVPqlBCQ2QzjqG7Yt6oj+n4KfUnH+jz0gcqyMe6ASHxpxgzbkh8atryrkezw1@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZ+QKChSq2qc/UbMewA3S36/dl5tgc5D4TRtZnpw0MtJuTQ6Z
	QJ32gOM3asNvmAJobOOWuHT80MvWXT69W9qlJh92EKuBEJzFYo9ox/QVv7HQHaEGoZbAg3H3xea
	yfiEYnUrQYqqPzCC0GqIcv4Ss4/IzNsxn1a6qNuoO4w==
X-Gm-Gg: ASbGnct4XpFYMBaFvg7WBYdJtH8r62gpdXXWQfdz6fSighiC+9gFAiPZGl69rqll3aw
	bINCQN/IygCXqvHu/YqnSyDM6fJdZO7X3Xv5A14DQITaPXEASEGQj55x1gyu0YSdV3FoYZ9gxdN
	Huf9l8bnR+QVKuOcAIIbWCiLTWDxLSLFQWVG28yjrLmeM5l6HxUAfwTY5CLwLtBDgRrxBJT9R0e
	KUxLv9uNTsZL9AmmfRE8CdkGAugeNBvlRT7dETOKTfHVnUfrCfEnGEavETVli35oqbXS+HCRbW8
	kjs=
X-Google-Smtp-Source: AGHT+IGrjPyW93BjIwBqBDRqzXa58mN2pSY6sOqPun6CMHKlu12QPm0Wx9wn3sNAxL6K2ljWwKgu92DgB9iBQq14qms=
X-Received: by 2002:a05:6402:2112:b0:641:1d64:8dce with SMTP id
 4fb4d7f45d1cf-64350e8e0fdmr16538410a12.17.1763480287895; Tue, 18 Nov 2025
 07:38:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-9-pasha.tatashin@soleen.com> <aRrtRfJaaIHw5DZN@kernel.org>
 <CA+CK2bBxVNRkJ-8Qv1AzfHEwpxnc4fSxdzKCL_7ku0TMd6Rjow@mail.gmail.com> <aRxYQKrQeP8BzR_2@kernel.org>
In-Reply-To: <aRxYQKrQeP8BzR_2@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 18 Nov 2025 10:37:30 -0500
X-Gm-Features: AWmQ_bmD9p5Nn1RKDLqeZ98HzkdyZzvLR0FYSVXPyrJripjLvaLejIY3K1PEUqg
Message-ID: <CA+CK2bASYtBndN24HZhkndDpsrU1rwjCokE=9eLZUq2Jhj6bag@mail.gmail.com>
Subject: Re: [PATCH v6 08/20] liveupdate: luo_flb: Introduce
 File-Lifecycle-Bound global state
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

On Tue, Nov 18, 2025 at 6:28=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Mon, Nov 17, 2025 at 10:54:29PM -0500, Pasha Tatashin wrote:
> > >
> > > The concept makes sense to me, but it's hard to review the implementa=
tion
> > > without an actual user.
> >
> > There are three users: we will have HugeTLB support that is going to
> > be posted as RFC in a few weeks. Also, in two weeks we are going to
> > have an updated VFIO and IOMMU series posted both using FLBs. In the
> > mean time, this series provides an FLB in-kernel test that verifies
> > that multiple FLBs can be attached to File-Handlers, and the basic
> > interfaces are working.
>
> Which means that essentially there won't be a real kernel user for FLB fo=
r
> a while.
> We usually don't merge dead code because some future patchset depends on
> it.

I understand the concern. I would prefer to merge FLB with the rest of
the LUO series; I don't view it as completely dead code since I have
added the in-kernel test that specifically exercises and validates
this API.

> I think it should stay in mm-nonmm-unstable if Andrew does not mind keepi=
ng
> it there until the first user is going to land and then FLB will move
> upstream along with that user.

My reasoning for pushing for inclusion now is that there are many
developers who currently depend on the FLB functionality. Having it in
a public tree, preferably upstream, or at least linux-next, would be
highly beneficial for their development and testing.

However, to avoid blocking the entire series, I am going to move the
FLB patch and the in-kernel test patch to be the last two patches in
LUOv7.

This way, the rest of the LUO series can be merged without them if
they are blocked, however, in this case it would be best if the two
FLB patches stayed in mm tree to allow VFIO/IOMMU/PCI/HugeTLB
preservation developers to use them, as they all depend on functional
FLB.

Pasha

