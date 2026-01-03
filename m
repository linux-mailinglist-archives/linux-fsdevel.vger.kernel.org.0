Return-Path: <linux-fsdevel+bounces-72341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C06ACF00B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 03 Jan 2026 15:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD853301D5C8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jan 2026 14:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E3930C62C;
	Sat,  3 Jan 2026 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZNl5r1C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8622D0610
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Jan 2026 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767449431; cv=none; b=nbXyedPZ3W9M36wxXjJtImvlJLKrvHF/SVmE3rN6GXTjxbv838IZR5L3HswF9iT8eU5Eu6fv7/dwO/bqp4RLXgjjLS+CJP9rxrBLNmmSpx7gGZqWUz8VueqwTWtbq2sdMBT+DjnVzOuEFZ6OmVECs/ED7ezzno2JrlQz0mNaP7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767449431; c=relaxed/simple;
	bh=0jeERn9NpZZ2fejBdcmKiErTpF5nJP3LfgwB+jSsQ2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWor9JR3P2//N4XvCHewnaA2V4wnBEehBkarZYL0utZfflF4YYvPuDlq1XI9FQWk+cpnCJen5VNqGy7nKPzT2QmnXtVEOhtHQhgGXvgJZtDYhR6vfFzXQY4i+qfaxxsY/3x69Z2ftg+pCAEVjNvUwHDIcEc92oRJh07YQElXYUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZNl5r1C; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so21293435e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Jan 2026 06:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767449428; x=1768054228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpakONkt0cdtCmYKrus/j6VwGnJGjtAMDlF2yJRIvJY=;
        b=AZNl5r1CDLiCEyodFDXCiQRTGl96ONNPexRmGRQ/ywAYBAqk7tw4bBpUEIYwlp9YFN
         JY3krEyLdXIOntHcD6rQhSTC0FEY2sruPz1gxuQ2SWmuZr5njOVJ1NyTeIvTpnDSRLXL
         fQw9ZmtVDqFf9cu0cbO5rvO41+lhwYre8qv5bug2FXE+51iKvrDzjtJfSHlBOs7FR9P7
         lwpCbV5dVsPkXr7RVyeYhEOvN3a52aoAqqKgZphqK0Xc3ntu0YInHNIBlqn18mzTv8gu
         MLh70IOtkkHIhAIhT1fvha6f0Q3A03Ks6MTVsYMOZUElMWCNJ2bEzbfnJ8zM4Qcg0xp3
         huZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767449428; x=1768054228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xpakONkt0cdtCmYKrus/j6VwGnJGjtAMDlF2yJRIvJY=;
        b=Yr9VS7da9I/wkeeLVMDhf5JkJ0pAuWrd+cJUQ2/JSULWH0cJCcco9+p9nYH6+SF3hr
         sSq64cqONSvnQ0qB+TXKCMAuBAQpo+QsCcEcS6k5GiBNcdxZFbvh2rB979r2liznqTGX
         uMN2KEuM3ZwULdqWtN0+ZXBAjVDaPOkhBv5+hbW6COBdq7Gk1rRp+wa6ODfdHTPuIjc3
         IvO/YTu2+K18yJCqYaBt96336hFugPsvoXGJfPdTGXOEHYlzPso/+xn8uD0NoKYy4oGh
         6w58EGdDNHdR5+KwZ/yldT8fJSEmq1nPJwAB0Vewlkvuft+eKsjoGjiM9mRvQ247XTMt
         bJ5w==
X-Forwarded-Encrypted: i=1; AJvYcCWFo37pKMLkxwzLpUQ0OApTz3Y4T6gmQphAEtYS1EJ3tXtxql5B2EKGebsgPPW8vlvRT2ITd42tvAhxOdRv@vger.kernel.org
X-Gm-Message-State: AOJu0YwOGKtK6EQ8nMRTgHElo3bnvr57ve1/kak7ZlaBfDDB35pqAtXn
	5at43fh2NcGTEY/0fIjkz8ekAimEA1GsF523QQWwm1nNQKtPR2ucwcG8
X-Gm-Gg: AY/fxX6K7mnQv3TQGFhF5UHies12R16+IxjeURfgQUXDxZwr0PfiS7NSnBgBxXnIpbv
	qTtasYwW4Lqd/Y/tVznWBa8mkwnbK9s3otU6zkNA5fPXv8BU0wzMjeM8fSEfePn+xaNnX5AKjcN
	nG4cUv92m0jNUdQePwAjEAgGEr8slx1y+u8NZGNGAKFu9d7pXV7DPQUGXIpKgmP1FgoHZiN/Zqt
	fe8luVlFl4ZcEF6tWxD3ZdMQzAxbEfkmc8WYequnbEC/hVw4PryQxa8NmfNB7g90CgcZ1ouiLtB
	nV+2/gYImMgw8S2WCmRWP7w0Pcr3lr/KjptIOXGEkONbY/Yck+CdPIK+T7fOaHxGBUEoZD1uWV0
	YfBv4Nz5D2c3eRp20s3zPFcd+FXG3cHP5pCwaHt4r3ZwDM9+28vABzm2ab+6DIpVT68KiIdSj6g
	OcACaFa6pRBRYPAnKdRybSkYIXyRSF7kNhexznv1R9jlZbqXKOkwAk
X-Google-Smtp-Source: AGHT+IGRYaGVqJD6FZ0S4FmHf27IFkeNrxyxfsk1iX42EQS64FQ53veY1xfx5Vp60d1k8JN3XPGmMA==
X-Received: by 2002:a05:600c:1c21:b0:47b:e2a9:2bd9 with SMTP id 5b1f17b1804b1-47d19583142mr658909105e9.31.1767449427663;
        Sat, 03 Jan 2026 06:10:27 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d13ed0asm41096705e9.3.2026.01.03.06.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 06:10:27 -0800 (PST)
Date: Sat, 3 Jan 2026 14:10:25 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
Message-ID: <20260103141025.2651dbbd@pumpkin>
In-Reply-To: <8efcbf41-7c74-4baf-9d75-1512f4f3fb03@bsbernd.com>
References: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
	<8efcbf41-7c74-4baf-9d75-1512f4f3fb03@bsbernd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Jan 2026 23:27:16 +0100
Bernd Schubert <bernd@bsbernd.com> wrote:

> On 12/30/25 13:10, Thomas Wei=C3=9Fschuh wrote:
> > Using libc types and headers from the UAPI headers is problematic as it
> > introduces a dependency on a full C toolchain.
> >=20
> > Use the fixed-width integer types provided by the UAPI headers instead.
> > To keep compatibility with non-Linux platforms, add a stdint.h fallback.
> >=20
> > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> > ---
> > Changes in v2:
> > - Fix structure member alignments
> > - Keep compatibility with non-Linux platforms
> > - Link to v1: https://lore.kernel.org/r/20251222-uapi-fuse-v1-1-85a61b8=
7baa0@linutronix.de
> > ---
> >  include/uapi/linux/fuse.h | 626 +++++++++++++++++++++++---------------=
--------
> >  1 file changed, 319 insertions(+), 307 deletions(-) =20
>=20
> I tested this and it breaks libfuse compilation
>=20
> https://github.com/libfuse/libfuse/pull/1410
>=20
> Any chance you could test libfuse compilation for v3? Easiest way is to
> copy it to <libfuse>/include/fuse_kernel.h and then create PR. That
> includes a BSD test.
>=20
>=20
> libfuse3.so.3.19.0.p/fuse_uring.c.o -c
> ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c
> ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c:197:5: error:
> format specifies type 'unsigned long' but the argument has type '__u64'
> (aka 'unsigned long long') [-Werror,-Wformat]
>   196 |                 fuse_log(FUSE_LOG_DEBUG, "    unique: %" PRIu64
> ", result=3D%d\n",
>       |                                                       ~~~~~~~~~
>   197 |                          out->unique, ent_in_out->payload_sz);
>       |                          ^~~~~~~~~~~
> 1 error generated.
>=20
>=20
> I can certainly work it around in libfuse by adding a cast, IMHO,
> PRIu64 is the right format.

Or use 'unsigned long long' for the 64bit values and %llu for the format.
I'm pretty sure that works for all reasonable modern architectures.

You might still want to use the fuse_[us][8|16|32|64] names but they
can be defined directly as char/short/int/long long.

	David


>=20
>=20
> Thanks,
> Bernd
>=20


