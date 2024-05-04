Return-Path: <linux-fsdevel+bounces-18742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 865688BBE45
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 23:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132C51F218FF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 21:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6959884E10;
	Sat,  4 May 2024 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8pdwU+P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8283A84DEC;
	Sat,  4 May 2024 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714859451; cv=none; b=epYmCIOnK1n8TThdQTTxk32DTVSC/nGtKjDx2j4Oof+tYaY/bQ7IHDF5T3RS6y+agSKqybyR8uy/JkoIghGToduvpxQCIkdURlUeGZpwFGReXhmfdlbZvIFrlany0R0mnUGdlGSCeYbqEVhvje1IJ7PH42ZDB3J2BaPT7qdJw0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714859451; c=relaxed/simple;
	bh=VpJQPM7rd1rBkvd50aikN/qFqNg/enyy5dkWT9AuB3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+Hy0Ae04AusGp+W0Oas5P/9a0ix1FQNdZS8Mx2tc70/DcnUYu9zcnRExYt1JVYOjfhzeirKYR4yTiZVnBXidGNINcN6nmHQprRxAY3OFn0X0K/0jcnKe8VpWPflLkrG5SkGaQbcBTsbX3U/5ICFQPk4HA+XeEpSGiJIV7thxD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8pdwU+P; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-23ee34c33ceso526151fac.3;
        Sat, 04 May 2024 14:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714859449; x=1715464249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpJQPM7rd1rBkvd50aikN/qFqNg/enyy5dkWT9AuB3o=;
        b=E8pdwU+PaBXY/dYVpENy57cuC8T5NBEpPI2kuJ2JtgdtNhitSkqGfsioYXSFdzkHUc
         YLQgEFHadmmQEfZITv55MxMfQaBJzLx716Naa9+efxI0x1iwu3fDn+nIQiyl2pdAz/xI
         25iAUcKclZKROhtyiYW8Qfrz8dN1aLq2eTdhUuUXQWECknDHltOMKutKUJyaolVAP3+/
         oPSyErXSdGo0m9eNYcGqDMl5BDCKfcNE1dffXtsbIRTymskC0Ayf+7JoJhoyFoztzmAV
         8zsQddV3C22CA/v+EEet5zOx1YhbOG6CMzIFMXCQZFO6v6BBAOPe/ybLBLZz06XX1Fnk
         GV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714859449; x=1715464249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpJQPM7rd1rBkvd50aikN/qFqNg/enyy5dkWT9AuB3o=;
        b=r46SwKiWJMIqgOoVlSMm+Iz00aZsBIcLMRmG7fDyeD/KLUKDZbAV377b5MdkwLroxF
         BGYfyy24vUhQuM0b9C3l0eX6Nhk0bT84NACSDH6vtdySuG8hzvlXJ89irpgp20TMV5D9
         7eVB7jS3oSkCLrnFGVhGhgbu3zYUpS9IAs67UkuOzim4+94QnL/1GkbaRUv56cSYVkRv
         zxIHb6+SfQw70lkJqbZiS8czcsc/LPPfnsWNoxjh4Ddoek+sDtdi4z750H9A/TO7gtdv
         LsGPiuKQMKo/+U+30VElkjB5+5mwa/t8abJ23cinCeAW1derXZcbi1prk6aajL8F7NDE
         buLA==
X-Forwarded-Encrypted: i=1; AJvYcCUZm6q3Q7mY7BYappeU2VeHFfiyNOc1USZLIHxQNIsmG/NkYuBlNLPyxPIjbPzbFcNU6Ea0B8RFJRSmvezj+qmogcq9fy6X0wEc1yG3chyACqYb1UsHIKZNiANunXjS2tHZXsuVb6wXyhqnD9zbc277mUfsa+mtZenkRvZqL6qtDg==
X-Gm-Message-State: AOJu0YypNgu/boMdl3RxF0tzjfjCMHFPW8t/KFMblMkHvYBrQojlQ461
	J9ai6bdCNdQKEa5LS3+idk6L3gX/n5HnoYePZEMoo5ApHrtzpvdCDstaN84ojaxExkuiQHam3p3
	xLGsf8TS6kyJW7kNQArebCX7LW5DvDQ==
X-Google-Smtp-Source: AGHT+IEfIDc1Dp3d+rYVTN+vUKk+O6oshDN1/zbT1wKKFvG31uW6hZIU+LiMrjmBLrq5Ki956c3IYm/QQbLl0W7TSQU=
X-Received: by 2002:a05:6871:826:b0:23e:4c7e:d018 with SMTP id
 q38-20020a056871082600b0023e4c7ed018mr7074428oap.41.1714859449483; Sat, 04
 May 2024 14:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504-rasch-gekrochen-3d577084beda@brauner>
 <2024050424-drift-evil-27de@gregkh>
In-Reply-To: <2024050424-drift-evil-27de@gregkh>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 4 May 2024 14:50:36 -0700
Message-ID: <CAEf4BzbhdNcwJS8oofJQSOjSj7vyc2zR9n-mMZvrqtUw-YiaYQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] ioctl()-based API to query VMAs from /proc/<pid>/maps
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 8:34=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Sat, May 04, 2024 at 01:24:23PM +0200, Christian Brauner wrote:
> > On Fri, May 03, 2024 at 05:30:01PM -0700, Andrii Nakryiko wrote:
> > > Implement binary ioctl()-based interface to /proc/<pid>/maps file to =
allow
> > > applications to query VMA information more efficiently than through t=
extual
> > > processing of /proc/<pid>/maps contents. See patch #2 for the context=
,
> > > justification, and nuances of the API design.
> > >
> > > Patch #1 is a refactoring to keep VMA name logic determination in one=
 place.
> > > Patch #2 is the meat of kernel-side API.
> > > Patch #3 just syncs UAPI header (linux/fs.h) into tools/include.
> > > Patch #4 adjusts BPF selftests logic that currently parses /proc/<pid=
>/maps to
> > > optionally use this new ioctl()-based API, if supported.
> > > Patch #5 implements a simple C tool to demonstrate intended efficient=
 use (for
> > > both textual and binary interfaces) and allows benchmarking them. Pat=
ch itself
> > > also has performance numbers of a test based on one of the medium-siz=
ed
> > > internal applications taken from production.
> >
> > I don't have anything against adding a binary interface for this. But
> > it's somewhat odd to do ioctls based on /proc files. I wonder if there
> > isn't a more suitable place for this. prctl()? New vmstat() system call
> > using a pidfd/pid as reference? ioctl() on fs/pidfs.c?
>
> See my objection to the ioctl api in the patch review itself.

Will address them there.


>
> Also, as this is a new user/kernel api, it needs loads of documentation
> (there was none), and probably also cc: linux-api, right?

Will cc linux-api. And yes, I didn't want to invest too much time in
documentation upfront, as I knew that API itself will be tweaked and
tuned, moved to some other place (see Christian's pidfd suggestion).
But I'm happy to write it, I'd appreciate the pointers where exactly
this should live. Thanks!

>
> thanks,
>
> greg k-h

