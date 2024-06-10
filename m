Return-Path: <linux-fsdevel+bounces-21318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF7E901DF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 11:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8698B26F4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 09:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0927405A;
	Mon, 10 Jun 2024 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZisejgPa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B622EFB;
	Mon, 10 Jun 2024 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011204; cv=none; b=MmB/rO7KwTBOdsi0KeMCwkwFNBpU7zZUDke7di1Wpig/zjn93oskjpBHquzYkNdKL/DpgnRBYuiUR4sfpciDKtFZo4G7rqzbIvE0Mkb7qcfDwv63VNDb9HaLWYPsqfD16HOBDIHzKjd9Sf5eUqBcwiFP+WDN48JAE+CP703Ojlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011204; c=relaxed/simple;
	bh=q6lblwuyKHgZ/yL/mAF2nOwQMFY5X7xdWlTmfJ2nCvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asUU+8+sqfMvQjLgrr/io/ywryFJXtroO8/fZyHdT2hU2SDHqt5eX9ranvD/6zxVIoWkwxPNYAz9HJCS/uR+G/Q/m2bt5TyNHWcKuMvgKj3zzNQRVWQdwgEXSZSAoUXdUf2z8N2lH/UWs9ZfHxgr/xzgFkjUUBwLClTX0BTmee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZisejgPa; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62c6317d15cso41504167b3.2;
        Mon, 10 Jun 2024 02:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718011202; x=1718616002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6lblwuyKHgZ/yL/mAF2nOwQMFY5X7xdWlTmfJ2nCvs=;
        b=ZisejgPao4UELib7hXT5162HjgPnsiAKrlPAmo0QWHeV8rdZ4JXZAB0ySacH3gt4j6
         T76CQgq20kxdn/G9HOp3ySv5AFiNrpe/iwRzCrZJmANlj6vWepznwYx+GNf1FHzS0fN1
         YrmEOISZzRMcXJws1vCFuye9SSPYOVBM8EyUGth5Iu96+4EzDixQgbOQBwqXIPjN7bHS
         DQ4uOVxFW2Nrsy9dHQlfBAfngen3ZrkmV3adoPvgold1uFLe/wHB9+eD5LMKOvlQ/MxO
         iRA3G17zu+eY1XE4j9qSvBCLWgRrZY4ZYBtirMTjbnqa/3MBQ6y0iJuI9FqQIvieCf34
         YXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011202; x=1718616002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6lblwuyKHgZ/yL/mAF2nOwQMFY5X7xdWlTmfJ2nCvs=;
        b=l+PW+lHKja2dgaZtgUQwEPJwKQ519q9Lorc6GBg1wp404nYO7Tv+ORMatJvEl3fQZd
         G2FFiFUNVrKXz8DCPNoCfoMsKEbHDJ7LUgDgaoqi6VYvwUg80cf3ystfnlEEi7idlmxR
         B3r9LY+SPQlzWCw0KV+8JAN2Kwh0i7Zw1UUoYB3L9VCxv4wsG08XYShnE5Ul9bYBiS0u
         +B5rrT+8i5vxxZVq3CHQO6ffxFAQFDHjmVl5d9qvSj19E+mWE0n8d/I7kGD45EAVKEg6
         p1Rkq5PIdUPtjSBE///yaLC9otkfu5B++QTGEwSnQpdhx75ikNBn1Hh/WDGNZx4/cVwK
         LbyA==
X-Forwarded-Encrypted: i=1; AJvYcCW6XzQpcMPnWSDN0rdTZ1Y4TE+0uvjuzI2tJAwi3ozloHFR3EteaHbXg6nKVJtriMWm7RcjQXzd4cHIJcdQRxrd6R9YDCp9Ae5jhhMaJBFNgLVttmSTThjB6jHz5B6ZIfFbbSECYYBj1A==
X-Gm-Message-State: AOJu0YycZHFxO/q1xmGIri58RDdXptWlugFXgd4kaDeKadjFyK+qQxbb
	7fXaxpmBErKq8rBUtzxLgWt6VTL1QMBOyxENRMm09BwaDwc09TgCjT+69RlZdqf+IIpCV7ifww3
	E5bgIdQwQu0ir354A3UkAzfDf/wk4lo5q
X-Google-Smtp-Source: AGHT+IE9PbTftrmyyQdAhb8m/FqbwgpLeAMIK0UKQmBn7t3TnNIOksrZrSy68WrCPCi5ditMiGx0i9JmUdqbxP9ptHI=
X-Received: by 2002:a81:ee0d:0:b0:61a:f59a:c1b5 with SMTP id
 00721157ae682-62cd55f4bf2mr83202467b3.23.1718011201912; Mon, 10 Jun 2024
 02:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xne47dpalyqpstasgoepi4repm44b6g6rsntk2ln3aqhn4putw@4cen74g6453o>
 <20240524161101.yyqacjob42qjcbnb@quack3> <20240531145204.GJ52987@frogsfrogsfrogs>
 <20240603104259.gii7lfz2fg7lyrcw@quack3> <vbiskxttukwzhjoiic6toscqc6b2qekuwumfpzqp5vkxf6l6ia@pby5fjhlobrb>
 <20240603174259.GB52987@frogsfrogsfrogs> <20240604085843.q6qtmtitgefioj5m@quack3>
 <20240605003756.GH52987@frogsfrogsfrogs> <CAOQ4uxiVVL+9DEn9iJuWRixVNFKJchJHBB8otH8PjuC+j8ii4g@mail.gmail.com>
 <ZmEemh4++vMEwLNg@dread.disaster.area> <tnj5nqca7ewg5igfvhwhmjigpg3nxeic4pdqecac3azjsvcdev@plebr5ozlvmb>
In-Reply-To: <tnj5nqca7ewg5igfvhwhmjigpg3nxeic4pdqecac3azjsvcdev@plebr5ozlvmb>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 10 Jun 2024 12:19:50 +0300
Message-ID: <CAOQ4uxg6qihDRS1c11KUrrANrxJ2XvFUtC2gHY0Bf3TQjS0y4A@mail.gmail.com>
Subject: Re: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and FS_IOC_FSGETXATTRAT
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 11:17=E2=80=AFAM Andrey Albershteyn <aalbersh@redha=
t.com> wrote:
>
> On 2024-06-06 12:27:38, Dave Chinner wrote:
...
> >
> > The only reason XFS returns -EXDEV to rename across project IDs is
> > because nobody wanted to spend the time to work out how to do the
> > quota accounting of the metadata changed in the rename operation
> > accurately. So for that rare case (not something that would happen
> > on the NAS product) we returned -EXDEV to trigger the mv command to
> > copy the file to the destination and then unlink the source instead,
> > thereby handling all the quota accounting correctly.
> >
> > IOWs, this whole "-EXDEV on rename across parent project quota
> > boundaries" is an implementation detail and nothing more.
> > Filesystems that implement project quotas and the directory tree
> > sub-variant don't need to behave like this if they can accurately
> > account for the quota ID changes during an atomic rename operation.
> > If that's too hard, then the fallback is to return -EXDEV and let
> > userspace do it the slow way which will always acocunt the resource
> > usage correctly to the individual projects.
> >
> > Hence I think we should just fix the XFS kernel behaviour to do the
> > right thing in this special file case rather than return -EXDEV and
> > then forget about the rest of it.
>
> I see, I will look into that, this should solve the original issue.

I see that you already got Darrick's RVB on the original patch:
https://lore.kernel.org/linux-xfs/20240315024826.GA1927156@frogsfrogsfrogs/

What is missing then?
A similar patch for rename() that allows rename of zero projid special
file as long as (target_dp->i_projid =3D=3D src_dp->i_projid)?

In theory, it would have been nice to fix the zero projid during the
above link() and rename() operations, but it would be more challenging
and I see no reason to do that if all the other files remain with zero
projid after initial project setup (i.e. if not implementing the syscalls).

>
> But those special file's inodes still will not be accounted by the
> quota during initial project setup (xfs_quota will skip them), would
> it worth it adding new syscalls anyway?
>

Is it worth it to you?

Adding those new syscalls means adding tests and documentation
and handle all the bugs later.

If nobody cared about accounting of special files inodes so far,
there is no proof that anyone will care that you put in all this work.

Thanks,
Amir.

