Return-Path: <linux-fsdevel+bounces-57234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC89B1FA70
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 16:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1205189617F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 14:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CD2263892;
	Sun, 10 Aug 2025 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBPtTeFC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9901927462;
	Sun, 10 Aug 2025 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754836385; cv=none; b=sPU6osiZUC0D9BLmpJVU69DQytAZFXHtpTS4PaIvOANpKlpO+Xn3UPsill4vZszKZWSXcZwyrXYl2UjXf8qbN7+Ayb1+pXfHS4woK/SGqhpk27AJCmMPqtLvtdfF4DRXHSlWsd16SH1w7YMzRiDxJYUQWIXzEKIlW54FX7NV0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754836385; c=relaxed/simple;
	bh=CJhjBKExR3c7p9ihQ8Yq1x9T2uLUyzu7TUtb7fzt74s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+nX3eJ7bP9rThbKkk9wIvnIweQ6Lox2FtSCVT2Nr+9tIbAkdGpCm4uNZnZJvXcnTBjQ5s0eO4Fj1nFmCarXlgOscp8iHt8GjSxJ2D13NU3Cl62SvpIgydUoQ8il10IrxetQzgUFxp4CXwPWI8ZPV5gkZsHo/wS8QUL+sgsMlxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBPtTeFC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae9c2754a00so682538666b.2;
        Sun, 10 Aug 2025 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754836382; x=1755441182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJhjBKExR3c7p9ihQ8Yq1x9T2uLUyzu7TUtb7fzt74s=;
        b=KBPtTeFCRJeoZAFx0nCuPxUJabtsJWh3pyYBNEnw1SwhTyDyOuNzn3WYVGafltAbka
         X1QJxK48r2TV6jH91zMJO1jXuqPM6El/PC0JvAlLIHNTy+Y5yqC1yq5q0/Gquc8ZTD1d
         /d9Fut3mg94KoFlsMYMyi+QLclP7IG1Z6O7W0AhBWLTmjVkGE4BhxF6u3op80kRE+3z6
         i8Q23ANFd+of2dQrsDBqWmhJLX9IRe9bU4whBTlTSdmOrHsfQY2nd+8BJj88feh+PP6U
         GTo5WrMZk+mD7gEBzB2O4q71CovGJAh/U5/WbeBiiYdXY9/9mfepVrHVEVtRbgnWoGAl
         wZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754836382; x=1755441182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJhjBKExR3c7p9ihQ8Yq1x9T2uLUyzu7TUtb7fzt74s=;
        b=WoX0G1OnFj4tC/YEOMbvXUXjn2xRt0mwDmWRgDHsQt58Ew3fq/wNXN1Fr7qBieVdSp
         YkU1iaBodWreDt9C/7watvaXWmI2pLXugrISxwkDdhk7F9tRuPNnrJ7iGM+Csk3x/H3G
         dO/ukoOPYhzUKOS1aQzEcHxUJ41wygvIR4KSyOUG7RPnJdXjDi2wRnVH5ZjxYLfQClYa
         lhBjn7GjpHZU06Nx1OHID5r6nnyDcTKKe/f6LQ0dKOlBDYyE1XuqBAZtBxtmvs6iOk7J
         ZqBHH1oBFPuDpeTg1qRhlRzpon0rNSUbyN71093st3EHDH67RtzGO6CS8tPOiO3mhLlW
         GjLw==
X-Forwarded-Encrypted: i=1; AJvYcCU53qAjyIXZsKfpMw6L0NvDQ3f97znWeJcT4h5f2RLLyQz81qsA1qqbJwEY0IbF6M/tapl9ajHK1NFOLoME@vger.kernel.org, AJvYcCVGrFBfMkqdm2GvUHO/y/x59PAD++KDZwPwaYZZLy+mNVlxM1A8rQ+sZZ5h2i+cAoISBvueG42dWFLJ4384@vger.kernel.org
X-Gm-Message-State: AOJu0YxwLfKCZdV45PG8GWtyt2ggMuEoZPrPViFaXhng3a0g7gDXbRAN
	DNmBYVxec8TWef+RKd55sUqarn/EajdIFPsIQUzH9ziOYG9ThrtutLPtbcvEvbfSvNXS/pCNOS/
	XYbFiPECJ5fvEGJD5e130S8mU3tkDJcHdZCqep/s=
X-Gm-Gg: ASbGncs1No6J9kdubG16Vr2pdN2z7hkI1GpM2xLPEWfVzIc06E4TnkRzOb+VwRGtN5l
	LLkIXc3jigzp1KQj9CiCw5Yi/KaUxHk2Lxzq1sfSZEQngjKR1aTtgPNP/bNqQRNoatdQFhx4V6W
	BhYERcZkgkajMvBUXZveqMheOPZuI23JI0ym+VsLn7KLr3DU0GS+0YEmhKtelCFzNEtPilpKUAX
	dAhQnk=
X-Google-Smtp-Source: AGHT+IEmLFippxPo1yWpvRmkH1XCrTMyj2CVWyfRoMuEjgvGmddka6dEo2F6UI78eEYemrSb84SZ3W0I36GxnJQguZw=
X-Received: by 2002:a17:907:934a:b0:ae6:f163:5d75 with SMTP id
 a640c23a62f3a-af9c63b017dmr764449266b.11.1754836381487; Sun, 10 Aug 2025
 07:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhmA862ZPAXd=g3vKJAvwAdobAnB--7MqHV87Vmh0USFw@mail.gmail.com>
 <20250804173228.1990317-1-paullawrence@google.com> <CAOQ4uxiFVt8eVmP5hUkjvascK-rVNyZzAec_tiGQf7N0PYDdTQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxiFVt8eVmP5hUkjvascK-rVNyZzAec_tiGQf7N0PYDdTQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 10 Aug 2025 16:32:50 +0200
X-Gm-Features: Ac12FXxr9byjNW2nQMobzxNF-4ZzU1DKKMiM6TnNG_zfEaqNRdDpRWqdvRy20Iw
Message-ID: <CAOQ4uxgYgbzcR1XV1kM6hEis6Lfnbo0xWYzdc0exAAPq-M6rew@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: Set backing file at lookup
To: Paul Lawrence <paullawrence@google.com>
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 3:25=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Aug 4, 2025 at 7:32=E2=80=AFPM Paul Lawrence <paullawrence@google=
.com> wrote:
> >
> > Based on our discussion, I put together two simple patches.
> >
> > The first adds an optional extra parameter to FUSE_LOOKUP outargs. This=
 allows
> > the daemon to set a backing file at lookup time on a successful lookup.
> >
> > I then looked at which opcodes do not require a file handle. The simple=
st seem
> > to be FUSE_MKDIR and FUSE_RMDIR. So I implemented passthrough handling =
for these
> > opcodes in the second patch.
> >
> > Both patches sit on top of Amir's tree at:
> >
> > https://github.com/amir73il/linux/commit/ceaf7f16452f6aaf7993279b1c10e7=
27d6bf6a32
> >
>
> I think you based your patches on ceaf7f16452f^ and patch 1/2 replaces co=
mmit
> ceaf7f16452f ("fuse: support setting backing inode passthrough on getattr=
")
>
> Right?
>
> That makes sense to me because that last patch was a hacky API,
> but then you made some other changes to my patch which I did not understa=
nd why.

Push a new version of fuse-backing-inode-wip based on
https://github.com/amir73il/libfuse/commits/fuse_passthrough_iops/

Please base your work on the above branch with the helpers instead of
modifying them.

Thanks,
Amir.

