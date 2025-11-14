Return-Path: <linux-fsdevel+bounces-68432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37625C5C13B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 09:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25302356E52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 08:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BBC2FE04F;
	Fri, 14 Nov 2025 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="evaOi5GU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5141E1A3D
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110120; cv=none; b=fNiiH3jlxZhXav29T/p4gmG2XQ3/SYE8h347zix5H0b+ilBoqtCmSlfzPwnzqtR6OM/+tNuWXTKpSY1OhCS8D1t9Bk+in3uJSvgvKtJs4T+9R19PjRwGoCNKRjxlNUC6ghtJUOvw8jORfeJZs5GXTBAxrPksnM2PZPGoQRJlPfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110120; c=relaxed/simple;
	bh=aPkFt5pgZ5e0EivvBJmHgxFQ2zdgmAcuwvRaR8seaiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALlPy6qxQ4Xe1Je75Lm6AyEyXSnzL9WpOToOI/azP1A5KVoW8jO8Fju4lY/PPKR3e18lzCo1XX20qFYRpXBr7VKwXS9RF/6ctuWxTcbtY2o885/ceJ3mNh409ybdyF51iPHquoL7fwu1Ev8gjZdZlBniGP5qNLxBBodyF63pieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=evaOi5GU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed9d230e6dso22577361cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 00:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1763110118; x=1763714918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DNNmyBuwpR3UfaPYjzFL1B4VRUgsIofvorzn1qzbQ4Q=;
        b=evaOi5GUkwJ5+SKkXi43DhXSrdLbxsHs5pW4SXsEQPCp5eD7WVaQSyqY7uFUG/pPjF
         v+3Q0FXNEcFkvdHc6Lt4Na9nYJAK3WDQoLwUsLmdV3NdZlZxJ+FllCHb/YJGi0qnICbQ
         4uVBZRcELZU1eBGHAxTQBTr+ZrmNUirwzgUE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763110118; x=1763714918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNNmyBuwpR3UfaPYjzFL1B4VRUgsIofvorzn1qzbQ4Q=;
        b=gyum55Q3McEQYQxz85zdg1XiATZhKH7lLGU6D6R1M6cCetUt93xbzTEjtnXnK9Xwt9
         KN8NY8rKTmKQ7vVVbBgEqoruCy1SLsp6JH2okdT6c/vQjEB2ktom77jGPuijNi2Y1C7I
         J4Kx5e+UN4h//m8onvuJ2NHJ1IF6ZOws0KB+w0Daws8ECo3sBmI8C0L1tEXzlIrkETQn
         ThqLED1nmIOFYbu2U+xHMKI5Yper0dWJrUEmBiurf1BNqkhTxG9efR/mYXLXhr5Hajox
         xq4k8s69ZAJRckADpMvYIOA9PYQIeYzJD634f7eynCsSfBGRRLgKJt7IS26B4t/YNXi9
         uOTw==
X-Forwarded-Encrypted: i=1; AJvYcCUhpMrm4v3pkoC1pT6ugtnqv+eSWizVaQvBR5TI57caC/f01sV10i2W10gH3lnnODnnGumsm0iL67ByJLF+@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJfLe4kk0LB41X8FB0oz8FXZFyUEngNEpsIiJkOyqKglq40Ps
	WBl497+ZZCo2LC1CFR/1MiSDC6ITmTHkYAijDTxwypHwZ7d7Wlj4CAGmK/SKkFziGHoM7yCpTq/
	36FHPy/CegJmW+i/hCpBh8H6yQc022d5WgltSRlwKZQ==
X-Gm-Gg: ASbGncun39dfOIFCU+rToOYC2xlQH+LPTXJuXUL2P0QYm1OsI7vofr5FEtFtcadr+3m
	SPIlvecTDHdY7fLhmGZZ5Aa57n7Uw8lYyunNJjYemOeQrjw6pyT6GZAscfko8/uNta1BGtYhXKU
	TtJROJrVqrirFE7XaL3IY/oOoIuc6jp9GmR4H3HaBS34uqBfkG41L6R1bYWCvUSCOrRHC7yONqe
	BYRn+DwxnRhVilMnSO7Tvc6CenIfvz8GrNbowfiNGkwYR+V2re2cNaiJWLCxKE9BOiOi4sGuRxV
	QdJiiiWhW0MWv8Kj7kS+ZwIOsWNM
X-Google-Smtp-Source: AGHT+IEE39nKjr/XyPqkK8Q+37qKockFwzuopgUhjpbberx1E+mXJUbV7QojPQo3HTo3dh4nWkiPC8nVcLf/TKdgrdM=
X-Received: by 2002:a05:622a:1886:b0:4ed:b4ae:f5bb with SMTP id
 d75a77b69052e-4edf2140a18mr36064611cf.65.1763110117710; Fri, 14 Nov 2025
 00:48:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
 <20251113-work-ovl-cred-guard-v3-6-b35ec983efc1@kernel.org>
 <CAJfpegv=yshvPv432F6ytAcuBLWQnx5MvRQjKenmzg-WafZ_VA@mail.gmail.com> <CAOQ4uxjejHF5mp_vRdQG1W6HHdW87CphLH3tJ+Sucigo3hJfxw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjejHF5mp_vRdQG1W6HHdW87CphLH3tJ+Sucigo3hJfxw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Nov 2025 09:48:26 +0100
X-Gm-Features: AWmQ_bku1I4TVqhZQKw8rUvP1nadHWU033oHKABNOdGLlKLHPWqkHQ_N_TyP3qA
Message-ID: <CAJfpegsAkYX0x01tNZXTQwTEnNvEMqnq2cGYeu24rFESdqkz=Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/42] ovl: port ovl_create_tmpfile() to cred guard
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Nov 2025 at 09:30, Amir Goldstein <amir73il@gmail.com> wrote:

> For the record, where I stand is
> I don't like to see code with mixed 80 and 100 lines
> unless debug msg or something,
> so I wouldn't make it into one long line,
> but otoh I also don't keep to strict 80 anymore,
> so I won't break lines like this just for old times sake

Here the advantage of not adding more splits (and not removing them
either) would be less churn -> easier review.  But it's not a big
deal.

> and while at it, why are we using current_cred() and not new_cred
> for clarity?
>
> realfile = backing_tmpfile_open(&file->f_path, flags, &realparentpath,
>                                                    mode, new_cred);

I think both are okay.

Thanks,
Miklos

