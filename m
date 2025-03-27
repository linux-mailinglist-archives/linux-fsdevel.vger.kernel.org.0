Return-Path: <linux-fsdevel+bounces-45161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D418A73E7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 20:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A05189CFBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 19:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCFE18A6DB;
	Thu, 27 Mar 2025 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FZoQwW4d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A874BE1
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743103402; cv=none; b=YiLCx2+nOk9h12hPj0YTmL5xNg0117nAJ8wvT2Do/6LDKvt114nq6xS+RdTq9gMEpdFoK6ww+tSXAnnPLA3hqIVj0cb50hz/BePQpnTr7GvTFqlkoroGBcaVQ82Z1Y5r4OFDLF8FoNwgLOhh8u1VxEAvfTpftn+x1+xi2HZj/4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743103402; c=relaxed/simple;
	bh=TRjHrgaVBLp3454MVUPZtgyslXGw8GeCIfd220q/xiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2Krd/KCcwpMYnSEZioeQ5CArKNPhYZpHDH06Eozp61XvBfGiAEW7L2Jn+MnXhbC8GzWOjSaFn5HtWJsSnwmu+LEGxKUSgBu15RIXnVdmIFMwkXk1x0tXElxhe+UoWzAv/+RouOpbgHfV2VGqYawR9Mj1n0+Khd9L3b/6U3fU6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FZoQwW4d; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47690a4ec97so14292521cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 12:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1743103399; x=1743708199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9rRCOkKmuMTdXZoRz+hZ7Xd6AWiIvdkVjE7qOL93/iY=;
        b=FZoQwW4dJCgK4STfi3Q7Z98DQwR4V0l/O8L9NskMetBnAZP1CCB8888XYFC9rjHwLP
         YhcE/CSNsitRaC45p7PDBZvKhhl4+E4KLTG6V6lRFWKdIssbMpeyP0bW68KR6XRVq5Mq
         1rjo8w1VaZBRvHTduNAk6fG/EQz/LL44fLGLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743103399; x=1743708199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rRCOkKmuMTdXZoRz+hZ7Xd6AWiIvdkVjE7qOL93/iY=;
        b=d2mUl/bpKytgb2GkR5xVsua+mY1FNtXOuD8ULy9D4IPCUdPnZGeS5M1KsdUPI6R4bc
         dvwc8CmX0yurmhXrL7xSuusHF5/u+qsA4N0jRq6J1x06Wwq4t9LHPEj3c1GfB9xaONxZ
         Wv2ksZwXHyHukTucofRcLaPP0JfTVLqw9vhhFVxNsr0qdRhLZR1ZG5BTDhw/RHIvE2Nf
         wD1w8LaY2jUt20QWp1k8KCaAxPsr2RrIAwIwqi15acQzkUjstIb1a6xs2TIIKNuoGAcF
         b1kmVv14TfH4mtLoAQIp8ltfHWctQ0aZfZlIJWSMJzJs3Tp7Ne4E4MiKq6Hs0SmO87rh
         ouvA==
X-Forwarded-Encrypted: i=1; AJvYcCUgkE4vrk4qIr5yuOSRr0HbILgI1RPG81oWnBbx2lzECvUDIr6iWGO3nShOJ4kz9cKoAdncqo2m/txDHd85@vger.kernel.org
X-Gm-Message-State: AOJu0YyYt+J8c1HzLNfYBoQmxIX0q8os/zXxd30BcYR+ZybZK6MBz62Z
	kgcv55I2Rc4PRHGAARMR48iPHorqwLOSSTXNLX+hT3VQ4Z35x8WLpq5+1dHHd18ElQxuEtPy4nX
	+RoVEJ7JC3ZhyogfZRNPqVz1MgrYMDOVQyYT9Mg==
X-Gm-Gg: ASbGncv0RGAeFERd/1WFxC2OGbwp4AKuNDFkXc8C8plgU6/3QfgcEnKSyOwJQKKIP0L
	/6VPLeqR4JA4rqhY8LsS68+ZuYC8/4eeojDgC8uQj1PDu1qkUayyN6kxWNVTfSAq73Sr90P4D8K
	SWXyLtymhYNwe6IS8N8Cs5YOWn
X-Google-Smtp-Source: AGHT+IFbUthJyzmI+HXRWtZEF5pJ2amrkkAsI9g/G2us87Z3g1xVnUs87w+d1MkhI+sylrU7ZoGb7W9Q1KF5E1V/QZ0=
X-Received: by 2002:a05:622a:250b:b0:476:7e6b:d2a2 with SMTP id
 d75a77b69052e-4776e18f5d3mr84769151cf.35.1743103398692; Thu, 27 Mar 2025
 12:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-3-mszeredi@redhat.com>
 <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
 <CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
 <CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
 <CAJfpegsuN+C4YiA9PAuY3+-BJ959aSAaXTYBwKNCjEnhXVw0pg@mail.gmail.com>
 <CAOQ4uxjkBQP=x6+2YPYw4pCfaNy0=x48McLCMPJdEJYEb85f-A@mail.gmail.com>
 <CAJfpegvUdaCeBcPPc_Qe6vK4ELz7NXWCxuDcVHLpbzZJazXsqA@mail.gmail.com>
 <87a5ahdjrd.fsf@redhat.com> <CAJfpeguv2+bRiatynX2wzJTjWpUYY5AS897-Tc4EBZZXq976qQ@mail.gmail.com>
 <875xl4etgk.fsf@redhat.com> <CAJfpeguhVYAp5aKeKDXDwip-Z0hc=3W4t=TMLr+-cbEUODf2vA@mail.gmail.com>
 <CAOQ4uxgenjB-TQ4rT9JH3wk+q6Qb8b4TgoPxA0P3G8R-gVm+WA@mail.gmail.com>
 <CAJfpegu6mJ2NZr2rkCVexrayUt=wwNSyYv5AE694D04EH2vx2w@mail.gmail.com> <CAOQ4uxjad0hm10F1hMFX8uqZr+kJT-GibFNe9hAv_v971sb97A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjad0hm10F1hMFX8uqZr+kJT-GibFNe9hAv_v971sb97A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 27 Mar 2025 20:23:07 +0100
X-Gm-Features: AQ5f1JrVJvRm2RHIZqdOCuVcPYQFiC2gxuyc6S1g5L4W5_sxAhzF0-8nUPEnfGQ
Message-ID: <CAJfpegv44p8MhCWCQ2R93+iUCCrTZbk0KowZxVmsf=0tsbGHLA@mail.gmail.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
To: Amir Goldstein <amir73il@gmail.com>
Cc: Giuseppe Scrivano <gscrivan@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Mar 2025 at 18:14, Amir Goldstein <amir73il@gmail.com> wrote:
> origin xattr only checks from upper to uppermost lower layer IIRC,
> do definitely not all the way to lowerdata inode.

Makes sense.

> > so as long as the user is unable to change the origin integrity should
> > be guaranteed.  IOW, what we need is just to always check origin on
> > metacopy regardless of the index option.
> >
> > But I'm not even sure this is used at all, since the verity code was
> > added for the composefs use case, which does not use this path AFAICS.
> > Alex, can you clarify?
>
> I am not sure how composefs lowerdata layer is being deployed,
> but but I am pretty sure that the composefs erofs layers are
> designed to be migratable to any fs where the lowerdata repo
> exists, so I think hard coding the lowerdata inode is undesired.

Yeah, I understand the basic composefs architecture, and storing the
digest in the metadata inode makes perfect sense.

What I'm not sure is what is being used outside of that.

Anyway, I don't see any issue with the current architecture, just
trying to understand what this is useful for and possible
simplifications based on that.

For example the copy-up code is apparently unused, and could be
removed.  OTOH it could be useful for the idmapping case from
Guiseppe.

Thanks,
Miklos

Thanks,
Miklos

