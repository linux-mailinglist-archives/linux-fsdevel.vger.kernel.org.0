Return-Path: <linux-fsdevel+bounces-48762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2BCAB3F49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 19:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB0819E3CEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A0B296D0A;
	Mon, 12 May 2025 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEKl78zh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642181E2602
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071382; cv=none; b=B82s/CnxNjd/qdZ/THU960SFvCnDuYQDLptScDNhVod3nGbQmXrwAILq/mzatYop8XXVXLJDH/TsZEO6vpKdnaSho1f3ZBZm5SgYxSWAjRSdjKb5orjEF2uG9fxvW6QVVONPKssomh7jOxyPgF+bsYY+xHwJYIsyZQrXo1I7024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071382; c=relaxed/simple;
	bh=1M8F9SBf3oUxRRinoHJubv7ZXA7G2tXD5y8ZwDMULzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAEYKJN9tWiDGsJWrh1dq4tWkRvO6vtAES4jpYFpfX3pWDzzPwx9hVkS3aXaZ6VeuL/YZ47b/ddhkU+nUImw0m5S19fZLNEDVgEm5eYcXlJ5BevRskqcY2Z0w5quPkihQCqEWjDt1rcsvGYft1xmlHjoybPARahRFlfzUg1uNrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEKl78zh; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4775ce8a4b0so84283611cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747071379; x=1747676179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/RUFT1zrsX4iHTa35eSYGxY3Ihkze9//Y2JXcaF+RU=;
        b=bEKl78zha94Fag3FSop3Ea4ZRnHbzD2FMfLKQ/uEtOcHsuFbSt5vl1vMwNsW6dyoB4
         eakmHfqTz7SjdSf8+JRsgNjdmJ6+Ld7xUHPE8qH8KE1Wy4EzBR9O+1iwV0tDON0REmGI
         ZM0uh423OkjIiq0EMfLivR58X8GP6dyBc9t5dwMlNA8xOVo3kP9RegKOSA1UUTvFvs+x
         xbr7WVxK4TAhwQkPdCRslx2L0OKpmJ5umBzxGlvmLOQBcv+fgS43Ibu2ZYKGFnajh1Id
         NMPHrCL5giPqeYBmHkzNiU+meqMaV++iqiCbwOd4u0s2DtEQP+xuOKSm7BQnmUE4vNC9
         nbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747071379; x=1747676179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/RUFT1zrsX4iHTa35eSYGxY3Ihkze9//Y2JXcaF+RU=;
        b=H6e7j8VtLi+AnuqN2cU+FfR5vM4J9lLZFauZ39VnSJRul05fuKuVEH3S6W/4MxRYqZ
         EjDV0oyzAF6mg1OkcVtECR3V/4H5IwjyBnAK0VeJp68z8qvch5SeCtC4JxnAkDEs0WXB
         VI4Jl3f0JIXlaGsfNETfVyj+OoWAOG9OyCS+po4pdLQwSB/vRX1BXhuLTVqxHvHFTHJ9
         xm5fQOaRhwpiiC/HDfAfe/1mT8IqT+UFTbBiFr1uuFGY7FGQKIL4OSR37/Z5IJ/fkyjY
         w04rYPWkV12l/E3F5seR7pRsf4EDoQhHY2e4ULaK0ysssNSomP3uvD5CqlrzkrNk6aDl
         MVHA==
X-Gm-Message-State: AOJu0YzDCarZs1cHijlZS5Oi/VQxczo84xdEPlOIAKxChn0vD1+Y7xGM
	Zk8o9vNQPGhU9PSn6nGTW6OxptTjujP+siK26BY7aLeNOh+qjeYVmh3fudASW0ZCBDFFk7uaM7r
	6/zPHJ5J2TDOSL9ez8jIkGwY4VwI=
X-Gm-Gg: ASbGncvkNGLK+aYlILj9ZXI7Eq81/Cv5QWGVZb/Nz1yct2DA4Alpu6nyXj5x0r0phI5
	5/NZc20q37/zGN9z12bssgkIn+S52Ts354carKhZcs2nkrOrNrBGf09B4ovC+jaJM2DfoUSaINM
	1BlLkdLxL68ke1c7uM0N8ISH+iy1F4p4PJ4gJM74YTdntGOi3P
X-Google-Smtp-Source: AGHT+IEVcTVR21Kf+JOAtjnStGB8kKf16i8sIsEjZT6HtVGPzQDkHhjsYnIG3M+Xt4Aaz0J9pOiL6oOXnEv599Xj1vM=
X-Received: by 2002:a05:622a:17c3:b0:494:7a8d:1550 with SMTP id
 d75a77b69052e-4947a8d203dmr51490051cf.48.1747071378993; Mon, 12 May 2025
 10:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418210617.734152-1-joannelkoong@gmail.com> <CAJfpegsMLhgp7i+KAeU828brziGPN4OB3td+kwhidQ3ywPNytA@mail.gmail.com>
In-Reply-To: <CAJfpegsMLhgp7i+KAeU828brziGPN4OB3td+kwhidQ3ywPNytA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 12 May 2025 10:36:08 -0700
X-Gm-Features: AX0GCFt04dfyFDwEExpCjinlLv7z7925q5JWGM4QqsPGhbCnQWIz4tlsKItfcu4
Message-ID: <CAJnrk1aOO_mCvgkr+AZKCnQerjgX+y5q5O1q+=yEqrfOv=SKkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: optimize struct fuse_conn fields
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 4:09=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Fri, 18 Apr 2025 at 23:06, Joanne Koong <joannelkoong@gmail.com> wrote=
:
> >
> > Use a bitfield for tracking initialized, blocked, aborted, and io_uring
> > state of the fuse connection. Track connected state using a bool instea=
d
> > of an unsigned.
> >
> > On a 64-bit system, this shaves off 16 bytes from the size of struct
> > fuse_conn.
> >
> > No functional changes.
>
> Not sure about that.
>
> AFAIK aligned int or long is supposed to be independent from
> neighboring fields on all architectures.  But that's definitely not
> true of bitfields and I'm not sure about bool.  Maybe
> READ_ONCE()/WRITE_ONCE() make accessing bool safe, but I haven't found
> any documentation about that.

Ohh interesting. That's a great point about race conditions from
modifying values that might be packed together. I will drop this patch
then.

Thanks,
Joanne
>
> Previous rule about bitfields in fuse_conn have been that they are either
>
>  - only set at INIT reply time, or
>  - losing a setting due to a race is a non-issue
>
> The new ones are not so clear cut, so it definitely needs some more
> explanation why they are safe (if they are safe).
>
> Thanks,
> Miklos

