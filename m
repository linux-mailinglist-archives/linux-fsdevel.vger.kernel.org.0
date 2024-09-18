Return-Path: <linux-fsdevel+bounces-29624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D094F97B88C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 09:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E98B26177
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 07:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD1674C08;
	Wed, 18 Sep 2024 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NhJW+rW8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FB2139D09
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726644601; cv=none; b=QiXjJ0MwnzcyoQIJjdxXfJ5ZR6FhjwTHMnILefNkHOPWyxcPN5u1KLXOSGchh46HnRybPz988LJdhZaXnAJAAKdt8w72xodnQ58Sqf2EXX6gcFQ9wkMr19DHUDx/fewbLKF00CTfQqlhGaQnSumeZhcO2USZaEsl4kW0IPNkG7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726644601; c=relaxed/simple;
	bh=EDfeSyZFvmRF9rf7ss/J0EKOqAlEqZKmnMLx0Mnbx74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZPnQarcNpoPXn4SJ1WYTQKo2cpFd4sELn1SF8XFB5/tv5ARNndDxvwqmtIIncmNjJqQOldB3aLHhNc3TSXw1dHRwVuvzqd4WyMuuZkKBOn+qg+q4RY9AtUU1IXW9Hs55zXL2O4d0TUb3SfnVgZpuB0s0ygBhw1bVJk5bP1kg6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NhJW+rW8; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so1037091666b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 00:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1726644597; x=1727249397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AaqK//hZBLo2oIqhod19wZfuGAupgiXcSBJ3kCKP+m4=;
        b=NhJW+rW8spdTRYYSjZpTzK6pdZFQ/BJ2ymDGhvSY2rC2MQ36tP+C4yeJz7PrhT9zMD
         IT43U08EqN0SZypttV8KS5MxuL+OhF+ApeWg6WB451r3S+QjoagcooECUH8NmyVoFvqt
         IxdKFz19h4vUjqi5kaFm68aoUo+OkHTEbZ0JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726644597; x=1727249397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AaqK//hZBLo2oIqhod19wZfuGAupgiXcSBJ3kCKP+m4=;
        b=GRm/5SVmVYWUp7kwCKDc5WT6cHaGc3QKYB01b36NOdZjwdY/l6bj669v+nbeVvUDR/
         e2xWaH4fBH2fTOINifPo1q4g0tNYzryO229qy+L0m66IFybX7NhC/q8ziKo3n/BwQxXy
         1rCydxvqR735ExSs/B3Z71fblxaLfbuXO7Nym9mKMyGkZCACmlYLlmNuLSaban98UgiZ
         nbryyjZm4cSqLKEvo9XVnrl+zGPCUMksW4hPLF4R9d1wGVeWlOXR8IXnuBtlDldCr9rm
         yuWtZn3k8uiaCex4eYsxaFq9jgUzWCx8PJKPk3FcOuzJJDQxOEhPYAvJW6Ati4pUcXQG
         dIxw==
X-Forwarded-Encrypted: i=1; AJvYcCWzB022ZyzQrxcZEDbd2IeVmmfHS2lO4kIorI3K9WOCm9tkOqPTLxRIivMnyNegIq8Sfkxn8ZF1FIX0yzhl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+VddL1fDmB1LGc7Ys/HTibDaflSTIiPLpExplCdd5qGZdN8OU
	qbEbXLObK+bssl1WNnDW7ZSoYdK0W9lRFKYjvHkgfZpy0+rm56Qr+9HhNiJo5v8pcuF+FxTER8o
	oUTPyaPRRNqjOeA/1gcYPsnac3oKTXxM2xLUq4Q==
X-Google-Smtp-Source: AGHT+IHkLTJcNCYmVUD850Ltq184lCiP7dYT1kAuOYVGuf+Ylsh3NLvLo49AZgcBwwXDs/eMr6GesbkZHDODLoHuEu8=
X-Received: by 2002:a17:907:948b:b0:a8a:9207:c4c1 with SMTP id
 a640c23a62f3a-a9029671623mr2445363666b.58.1726644596686; Wed, 18 Sep 2024
 00:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830162649.3849586-1-joannelkoong@gmail.com>
 <20240830162649.3849586-2-joannelkoong@gmail.com> <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com>
 <CAJnrk1ZSEk+GuC1kvNS_Cu9u7UsoFW+vd2xOsrbL5i_GNAoEkQ@mail.gmail.com>
 <02b45c36-b64c-4b7c-9148-55cbd06cc07b@fastmail.fm> <CAJnrk1ZSp97F3Y2=C-pLe_=0D+2ja5N3572yiY+4SGd=rz1m=Q@mail.gmail.com>
 <b05ad1ae-fe54-4c0c-af4e-22a6c6e7d217@fastmail.fm>
In-Reply-To: <b05ad1ae-fe54-4c0c-af4e-22a6c6e7d217@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 Sep 2024 09:29:44 +0200
Message-ID: <CAJfpegsBG_=7Ns=n45Cwc8082OZ7Kg1WU+xoMPNDyyP+V1ik+Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] fuse: add optional kernel-enforced timeout for requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com, Jakob Blomer <Jakob.Blomer@cern.ch>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 00:00, Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:

> > I like this idea a lot. I like that it enforces per-request behavior
> > and guarantees that any stalled request will abort the connection. I
> > think it's fine for the timeout to be an interval/epoch so long as the
> > documentation explicitly makes that clear. I think this would need to
> > be done in the kernel instead of libfuse because if the server is in a
> > deadlock when there are no pending requests in the lists and then the
> > kernel sends requests to the server, none of the requests will make it
> > to the list for the timer handler to detect any issues.
> >
> > Before I make this change for v7, Miklos what are your thoughts on
> > this direction?

I have no problem with epochs, but there are scalability issue with
shared lists.  So I'm not sure.  Maybe the individual timers would be
the best solution but I don't know the overhead and the scalability of
that solution either.

Thanks,
Miklos

