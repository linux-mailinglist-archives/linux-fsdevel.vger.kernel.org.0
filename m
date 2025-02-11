Return-Path: <linux-fsdevel+bounces-41523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26F8A31053
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 16:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002CB188BDDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 15:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECC2253B76;
	Tue, 11 Feb 2025 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6O0KglR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB8253B40;
	Tue, 11 Feb 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289133; cv=none; b=hQFrA9y+zAe3M2Ys0ZlQWEArrrXUNnhb10KIPnKOVnRN0HnYgz2iwOG8ijZZPSn4hlOYpFnSdjevSm+CJC7nXcGzX2kkUrb57YkHEaLH7Gk52te75AfRL0wLxEXjVhWKi5CfmECbM7MQkjOddzyIndUKK6HY4IGc5CTiEUIav9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289133; c=relaxed/simple;
	bh=xqUcmDwCoyALSlg/iq4Ahz2NCKFR7RHF99ifAkpgABA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SD4Z2H9/gNfhJZL2Zx9m5heCegdnnWy8e6WjD/yaqqT1MKngrDsG4nRaHzSziSnHdGrad+/mZG7hZLy1Wa52UJwMlAD7oLqjCAXm9kqmi8859RspCQagMK6yi8qIldCNWUd2eZdRAyRfIf+mtx61UdVAUlmCH7CyIvcWLbngrLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6O0KglR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7ee6f54faso30216066b.2;
        Tue, 11 Feb 2025 07:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739289130; x=1739893930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCrV+/vS2+UFuM2Eed4XTr2tEResErbC6iJFpQzC5Yo=;
        b=m6O0KglRxdOCXNN84ScVHqKMd9XkKmmxRFNZpQ23ZH4TiQ9Xvt2V+hEsX4mPYkoDdC
         ldRPPxGctvu8RnUiu/bDmxpDOKO5CPB0INtB4u7A5Msz5e9BbKB0QGwUbuLUG28U09Qi
         mYPYw8XFLhVRw1xoDCcb3zNmlqGOAOLG+6PLNp3kR1rcDhcWmYn6SzEtyED3y8b62+LJ
         SEQPMnpklk4B6CvYYUIrdsjM50d6SQdVhub3rANtVwXsb1dZNyx7gDK7yYc6wr7DUeeN
         V2aCOIKqsrI8XjwWvqcr5Ci2upOz3ppwfeolsK2eHtQj1YIvu6Aw4ZFgn0yUpjXi62DN
         /B4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739289130; x=1739893930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCrV+/vS2+UFuM2Eed4XTr2tEResErbC6iJFpQzC5Yo=;
        b=JvrzJgowfe/Rw2tJAS3zz1gWy9i2HRvrx+K5RGcDNHw9g/BARsnJlDHQ/nL0msUrDp
         35dGJ7wQ4lEem3McUd/SxUCBl4qWLzF/uCYJ9Je1BXKr2SRDi7mtux353bJck7yygLKr
         Oe7ygJSPvnXR8c0zcfE1WROP0onSoNYu3bEMIh6dfk2NY08JFLnzAbn+ur13+SJdcn50
         ujKOK+DOkS6Eyd2Eaa3lZwupgH4F3AjuvFyUaogFiUnP32W6Bx0u7uPWdZzVUWdrWNmi
         BlGoXHhSL7N/erfk0Tr1UJWHvlkP9IWQJz56ff/BrbRGXaUWhJ0Uki+eCVw2X2/QpstI
         yKjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIWOJDsOcvVPcfytPlWiirZRvJ9Hc4uNQWrhu1zZboCuNkTLWkWqdfVcK9T1/92aFzkAy4N4lI2GLi/jwjlw==@vger.kernel.org, AJvYcCX/ImosNl/DjQ/uoDyRiIHViZ0LL1+TjV/G70fSNvxHsUpEh+lrE4LPiGJC9b64Dg7jLYRuES9pJpotObLS@vger.kernel.org
X-Gm-Message-State: AOJu0YxD/oIk7CEVBhKddSHMrsAn2Tcrx7VYs5cF7XW2rW07cI1F1A6J
	2QHjQjCtAqU+G3QxEoVC7ryOkMB+RwPf4jnhOyK1rGErzDrlPsevRpVOxC8Sl25jt6ukMLS1NHs
	gT5nvQkjlfnL+BU8Oqdw38PZ64LbAkGpMNhI=
X-Gm-Gg: ASbGnctGGJTQHsDFNuaNGkGuIZVHX30jfldolnxXUgmBvQ5RE25rMr75ofcvJaPFe7i
	b5bLvHmq9QACZGc709Sk/Ru0fxnn2YfA206Fd04jUa3KC3SOG6eJlFQhSWSDRdcn8KFgYchu3
X-Google-Smtp-Source: AGHT+IGghc24xQcQ91tSh/oIDvUWDO6WHa5jkEQjx6xnhh7zPfkzvUHpKaZoaP8zdhdtbf+Gg5ASyTeTjaZynkoAfGM=
X-Received: by 2002:a05:6402:4607:b0:5d0:9054:b119 with SMTP id
 4fb4d7f45d1cf-5de450706d0mr37804457a12.21.1739289129646; Tue, 11 Feb 2025
 07:52:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-3-mszeredi@redhat.com>
 <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
 <CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
 <CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com> <CAJfpegsuN+C4YiA9PAuY3+-BJ959aSAaXTYBwKNCjEnhXVw0pg@mail.gmail.com>
In-Reply-To: <CAJfpegsuN+C4YiA9PAuY3+-BJ959aSAaXTYBwKNCjEnhXVw0pg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 11 Feb 2025 16:51:57 +0100
X-Gm-Features: AWEUYZlQsFJYhMUvRxZ4zx5qE10DCY5tPsmat-k8X2DjCyZ0wi-qBo1PPNeP_fQ
Message-ID: <CAOQ4uxjkBQP=x6+2YPYw4pCfaNy0=x48McLCMPJdEJYEb85f-A@mail.gmail.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 1:34=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 11 Feb 2025 at 13:01, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Really? I looked at the next patch before suggesting this
> > I did not see the breakage. Can you point it out?
>
> When lookup "falls off" of the normal lower layers while in metacopy
> mode with an absolute redirect, then it jumps to the data-only layers.
> The above suggestion imitates this falling off when it's really a
> permission problem, which would result in weird behavior, AFAICS.
>

Yes, I see it now.
I don't have a better idea at the moment.

> > BTW, this patch is adding consistency to following upperredirect
> > but the case of upperredirect and uppermetacopy read from
> > index still does not check metacopy/redirect config.
>
> True.  Also that case should probably "loop back" to verifying that
> the redirection indeed results in the same origin as pointed to by the
> index, right?
>

It sounds very complicated. Is that even possible?
Do we always know the path of the upper alias?
IIRC, the absolute redirect path in upper is not necessary
the absolute path where the origin is found.
e.g. if there are middle layer redirects of parents.

> > Looking closer at ovl_maybe_validate_verity(), it's actually
> > worse - if you create an upper without metacopy above
> > a lower with metacopy, ovl_validate_verity() will only check
> > the metacopy xattr on metapath, which is the uppermost
> > and find no md5digest, so create an upper above a metacopy
> > lower is a way to avert verity check.
>
> I need to dig into how verity is supposed to work as I'm not seeing it
> clearly yet...
>

The short version - for lazy data lookup we store the lowerdata
redirect absolute path in the ovl entry stack, but we do not store
the verity digest, we just store OVL_HAS_DIGEST inode flag if there
is a digest in metacopy xattr.

If we store the digest from lookup time in ovl entry stack, your changes
may be easier.

> > So I think lookup code needs to disallow finding metacopy
> > in middle layer and need to enforce that also when upper is found
> > via index.
>
> That's the hard link case.  I.e. with metacopy=3Don,index=3Don it's
> possible that one link is metacopyied up, and the other one is then
> found through the index.  Metacopy *should* work in this case, no?
>

Right. So I guess we only need to disallow uppermetacopy from
index when metacoy=3Doff.

Thanks,
Amir.

