Return-Path: <linux-fsdevel+bounces-44958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B14A6FB04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B473B1702
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5BA257AED;
	Tue, 25 Mar 2025 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDElJhse"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767EEA937;
	Tue, 25 Mar 2025 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905012; cv=none; b=IU1fziTOpVvGAypjb//2qClaVqE0XdkFr3wzR/9uzI9pNdVKGHnXLwMFe6lnEVfhIyqgxgO21bhYK4wq4EWvyWjJ3GTOXGJu9ZdQ4RdRR4AjT2x7UvNAvyq7P/uHhJBrT+Qow0PJZzd6IZhadho5n29SDTogc3uemGxKqwMRQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905012; c=relaxed/simple;
	bh=A/HVEfJcYRT01uF6p+bjIsoGXJumPIltSSZeiBV1byA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6+t+Td2Lg3vpO3kKL2hy5F7ziwYZggU1Df4mdeFVImaHZm63Z8HlyVrBROE7BFutLxmdXIvK4+/f/DGpktSpcwEsOCvLB9MXkN1Js0utbRem001gOG4g/O891LY+vQmXBx945NYMPuAxj94PaTfpnqFVMyemC6SNRHE5Ew1xRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDElJhse; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2aeada833so1026422766b.0;
        Tue, 25 Mar 2025 05:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742905009; x=1743509809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YwMoGN98deik8uPYk+jICPEOK3Aa0K3ta2oIfbGfLw=;
        b=XDElJhseBmlrc3xHaRYHs+Jv2nnd99JiIkilyaQ+GUmGgNpva+DBkGFbHLfyRiAc4q
         D9MVRPSOYTxXSVcR0CHrOJqH2XNswTqmiUbqwptkFSW/QzdGXlkn27XxYHcy4uVQguhK
         wzKB6EAUal56g4abQyAb6kQT6i12S1l+rRnZYVytvYQag3a+qgj/P3k468CcyvVRM4+A
         7+xcME9hTx/xx3LZnydAHinyuAMIO9Tnj7fk+GzjTiQeG96DMwTjjRhHL69K7fcacfwm
         uWt3fK2VvLnbCh6Pxl37/zJPBqvbAHUPPZ7zrN7B4b1HnN3dEyv2p9um3th0PVQLHX4N
         LrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742905009; x=1743509809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YwMoGN98deik8uPYk+jICPEOK3Aa0K3ta2oIfbGfLw=;
        b=rXkmJoPHnlDmmJ+gkUK8gpuPFrApXNk2NXtFW0GT6IYQyBZicQ1rywdV+7iSr0P4Bp
         1kENYv9mtYPx8XgGuE8fVF5KGuTRlWEXGP8Ao9r4Bdu3d95hTipWd9aV/yvWEEgHjCY9
         HQQrAoquI5gCdXdJXcD4vn9HqzBvZPtCLYVUJZvP2or2HZQw/Xp7H6R7K6sB2KfxuxPc
         1c6cKrkU8GWe+v+lszIX4n0y6vWwqc/fvu7XVF/uqpdZcVwMaVm7nAFkm2YuNw+DvkDh
         x82g2fZ21W7rdujsldRjKD6NV97woRLeX7cFMnhgUNIxPLHYMw7hNnPhpu1bjF5ylYAJ
         cmOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPDHOJq+Yz/TWdWkCOyZ1UErPR7zDjLOFng3Rlv7VaedzHdVKFO4pT670maq6ZDoZc51CpRAkGHK7ltaGd@vger.kernel.org, AJvYcCVbq/YezcLoLx7Kexe9+bP9lkIqR1p2XBXTPtnnz1zmmNu7pf/mwsFoBbD56nLWPdrY/3GMOwN7P2o5zSBhdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKKw5+l9JQyqno/IEjnvTGKBfrpkGqcXvU7hcQrxpct+XOqntA
	JNQUvAWYYXWIFKAj/q5nwpkJ3+7/0EDPdbJjXINBzNQN1YSW/b5nob/trskYam2oa2xjg8rm8pQ
	KeeBmaexuCJz4bpn8K+DtfvaquzUfWERG
X-Gm-Gg: ASbGncsBipHfMr0v/b7TbIsnLzpJgbj0fSg4LHm34uG5auIeZU2O8CVJfiLHpMnl22w
	qQorwYz3LDK3Sm+3P1eX6vjZcnuz5N3Zo7c0uitsoEsUAhQnds14//7/+BsnzQA7vUZdFJo63mI
	zVvXwaSgWb7clr1ypFO8rLAzNTNJH6rGcBWpU=
X-Google-Smtp-Source: AGHT+IEh5kgWuYcKo36DTgjK2wx0ObTGE58OJAEbZCdPYzv2jYpEeNhIbzGSogxiqqoWpxFyWSXcfctHK9/nU6lWsP4=
X-Received: by 2002:a17:906:c10b:b0:ac2:d6c4:958d with SMTP id
 a640c23a62f3a-ac3f0176d24mr1753102366b.18.1742905008170; Tue, 25 Mar 2025
 05:16:48 -0700 (PDT)
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
In-Reply-To: <CAJfpeguhVYAp5aKeKDXDwip-Z0hc=3W4t=TMLr+-cbEUODf2vA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 25 Mar 2025 13:16:35 +0100
X-Gm-Features: AQ5f1Jpwz9fIfJs_p0muEkmk0cSF1jqwMl_r4GomS2pemCSeZg3habMN0cxsbPc
Message-ID: <CAOQ4uxgenjB-TQ4rT9JH3wk+q6Qb8b4TgoPxA0P3G8R-gVm+WA@mail.gmail.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Giuseppe Scrivano <gscrivan@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 12:48=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Thu, 20 Feb 2025 at 12:39, Giuseppe Scrivano <gscrivan@redhat.com> wro=
te:
> >
> > Miklos Szeredi <miklos@szeredi.hu> writes:
> >
> > > On Thu, 20 Feb 2025 at 10:54, Giuseppe Scrivano <gscrivan@redhat.com>=
 wrote:
> > >>
> > >> Miklos Szeredi <miklos@szeredi.hu> writes:
> > >>
> > >> > On Tue, 11 Feb 2025 at 16:52, Amir Goldstein <amir73il@gmail.com> =
wrote:
> > >
> > >> >> The short version - for lazy data lookup we store the lowerdata
> > >> >> redirect absolute path in the ovl entry stack, but we do not stor=
e
> > >> >> the verity digest, we just store OVL_HAS_DIGEST inode flag if the=
re
> > >> >> is a digest in metacopy xattr.
> > >> >>
> > >> >> If we store the digest from lookup time in ovl entry stack, your =
changes
> > >> >> may be easier.
> > >> >
> > >> > Sorry, I can't wrap my head around this issue.  Cc-ing Giuseppe.
> > >
> > > Giuseppe, can you describe what should happen when verity is enabled
> > > and a file on a composefs setup is copied up?
> >
> > we don't care much about this case since the composefs metadata is in
> > the EROFS file system.  Once copied up it is fine to discard this
> > information.  Adding Alex to the discussion as he might have a differen=
t
> > opinion/use case in mind.
>
> Okay.
>
> Amir, do I understand correctly that your worry is that after copy-up
> verity digest is still being used?  If that's the case, we just need
> to make sure that OVL_HAS_DIGEST is cleared on copy-up?
>
> Or am I still misunderstanding this completely?

Sorry, I have somehow missed this email.

TBH, I am not sure what is expected to happen in the use case in question
on copy up - that is if a full copy up on any metadata change is acceptable=
.

Technically, we could allow a metacopy upper as long as we take the md5dige=
st
from the middle layer but that complicates things and I am not sure if we n=
eed
to care - can't wrap my head around this case either.

Thanks,
Amir.

