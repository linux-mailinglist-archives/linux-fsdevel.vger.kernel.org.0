Return-Path: <linux-fsdevel+bounces-45015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C00A702A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CCFF16961C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D439618C930;
	Tue, 25 Mar 2025 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Zw6CK/7A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408FD1494CC
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910149; cv=none; b=ihO7qKfPV0xBbglL4sddYo4SMLSvw/aOHsqNS9B8Gl3bXQi7OjCY2kFBlrvoL+2O1VWTVFNq7TBovAEmSL4YldYIVbm3rYkL85E88zptCFBioBpTw3KenWFf21RzlZBZxhgaHc3ysVsO3TpfT+7++hSS0mH/2uR5FwLbTCCzKfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910149; c=relaxed/simple;
	bh=hpA/CRXb52LPSL7rr23mY9XTZ6x9+Dx1Iu0W3zA4vCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPc+3ZO/p31zsgRjCIXomUTrK4zKliBWntrApTb/7wnoREIJ/KJvj5OfeMXlZ8AjKyNVWtAu0bPab3QA1nA0qGZYB3Fg57l7XXunvaN/qFRniJTBNBL3ohP0Vu+085kALlYOmqnDVbLanJ3ClQWqX5RDXABf26Qujy715SSRxpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Zw6CK/7A; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4774193fdffso31295511cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 06:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1742910146; x=1743514946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cUmjKAMgU1F0bXOEKYUEcJktWlivLvvPjvlPAmCFq0A=;
        b=Zw6CK/7AA2QUUKSMU1z4eLZsrVpixjNGfNCsUcPM+u+O5j8edIXXBd1FS/7NqbQOip
         wlQLk/+zYAfaufFZ4HzNn366UrS2SQP79OTPfV1XhvPETn2JFkNf/BmnkLjuV6hVqdex
         APoWqx4hm1u2QlkFuWP/4r/dhfJd6nzicYfwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742910146; x=1743514946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUmjKAMgU1F0bXOEKYUEcJktWlivLvvPjvlPAmCFq0A=;
        b=N14395+tz6P0gRnfq7+sFOkhZenNgN3FAj8jQWJUgwtgZ6A6Vm7nyCQMnhXVpG3vxs
         isCk3nJIBKm07WDq9cvmAvmjYLjUgD/TKINsRpTHLcwyl5iPwFE3SVLTZJvffIY2hkPV
         hyzHery5QQomhQszSZxxsh0P4j6salDcwAhR537w/WKmXovVYf8mBMoTzy1lKv+jIic4
         s1ZqRVSPnNYvNidr3t8d/SijiVPNvXuRNy4evNSK2raf78FusItKEvshNyNW4X8yvZX0
         P8CirtQcmZU2NzcWqtAQFTvCzvTAldxyvJ1elJv7FkR1RXGDyv0K+XJSyKA1zf2iW6KO
         plbw==
X-Forwarded-Encrypted: i=1; AJvYcCU9e6LA0Fn8Z4018SplVjOWCu1fLgrWSOG6OE3xmAfR7tYUB5yy01siVpRulxa2wTKp+7o/pPa8+GRm31GR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3TddtN9ijJZSQspfCumI5K5jJOJutKbOvsqjgXzv9GDDrmKhi
	mx3hODkzUozqdv8XgTI0tKut/PZaRVuN86WF3ieA21y24WrhfVJE7IwYibd/ikjD+oSn5My9VEd
	KeFSwgDBRaeFpkNOzsf6TBEXCgAk5tfq86y8oOQ==
X-Gm-Gg: ASbGncuyLFfbpX6MN/j0PVQH940Umy92Mj1Rh9mR6ppdyGX6/zuQtxK9ITxoPPFrLUI
	ND9Hc/7QGljACaLPXsfl/eTOub4Zk43RyyoLN9xuOjD7X6XXfNKT4jWiU9ScgytXFMYUptVWXKO
	bHh1ok9O4GWX68xxJ/f7r+NqpF
X-Google-Smtp-Source: AGHT+IFebhz2tD4H/OxL2khsyI2/0i6TQPegRukkIN6hEa/XX4A90DNmWTNr4UCErJLnyN8ki6j5EAQTnc8rRcnULvk=
X-Received: by 2002:a05:622a:1c09:b0:476:6b20:2cef with SMTP id
 d75a77b69052e-4771de60f86mr298621481cf.41.1742910146022; Tue, 25 Mar 2025
 06:42:26 -0700 (PDT)
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
 <CAJfpegs1hKDGne7c3q4zs+O5Z4p=X3PK8yFXhyCY2iAjs4orig@mail.gmail.com>
 <1b196080679851d7731c0f4662d07640d483be4e.camel@redhat.com> <87frj1fd3b.fsf@redhat.com>
In-Reply-To: <87frj1fd3b.fsf@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Mar 2025 14:42:14 +0100
X-Gm-Features: AQ5f1JqTk3eMadH2E2UQWlRHTPxFLpzZRMll15gjiFDDvMeEypEM8P6IjXo4KgY
Message-ID: <CAJfpegtvPW6tTfGbOUtW3GMe8UxX2Laqjopb1oSoUNgBWNUe9g@mail.gmail.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Alexander Larsson <alexl@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Colin Walters <walters@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 14:34, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>
> Alexander Larsson <alexl@redhat.com> writes:
>
> > On Tue, 2025-03-25 at 11:57 +0100, Miklos Szeredi wrote:
> >> On Tue, 11 Feb 2025 at 13:01, Amir Goldstein <amir73il@gmail.com>
> >> wrote:
> >> > Looking closer at ovl_maybe_validate_verity(), it's actually
> >> > worse - if you create an upper without metacopy above
> >> > a lower with metacopy, ovl_validate_verity() will only check
> >> > the metacopy xattr on metapath, which is the uppermost
> >> > and find no md5digest, so create an upper above a metacopy
> >> > lower is a way to avert verity check.
> >> >
> >> > So I think lookup code needs to disallow finding metacopy
> >> > in middle layer and need to enforce that also when upper is found
> >> > via index.
> >>
> >> So I think the next patch does this: only allow following a metacopy
> >> redirect from lower to data.
> >>
> >> It's confusing to call this metacopy, as no copy is performed.  We
> >> could call it data-redirect.  Mixing data-redirect with real meta-
> >> copy
> >> is of dubious value, and we might be better to disable it even in the
> >> privileged scenario.
> >>
> >> Giuseppe, Alexander, AFAICS the composefs use case employs
> >> data-redirect only and not metacopy, right?
> >
> > The most common usecase is to get a read-only image, say for
> > /usr. However, sometimes (for example with containers) we have a
> > writable upper layer too. I'm not sure how important metacopy is for
> > that though, it is more commonly used to avoid duplicating things
> > between e.g. the container image layers. Giuseppe?
>
> for the composefs use case we don't need metacopy, but if it is possible
> it would be nice to have metacopy since idmapped mounts do not work yet
> in a user namespace.  So each time we run a container in a different
> mapping we need a fully copy of the image which would be faster with
> metacopy.

Okay, so there is a usecase for compose + metacopy.

Problem seems to be that this negatively affects the security of the
setup, because the digest is now stored on the unverified upper layer.
Am I misunderstanding this?

Thanks,
Miklos

