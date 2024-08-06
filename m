Return-Path: <linux-fsdevel+bounces-25097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F7C948E33
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 13:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E926C1C2324F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 11:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77A41C379F;
	Tue,  6 Aug 2024 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XluvNxbM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D161C233C
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722945337; cv=none; b=mXoYok5i+Miu2aoMVqcVXst79BlvOw21Q1K6upe76vJ07Tr0Q7N5gFc9ZjYiQRbpiGS/T9GRLZU7c+etlq1dUWw+Fj4OFDRdQesnENAHO+iElGpxkmFVmq9urF1K19XXpOcoLI1RIm678zK2f9A4IrooAt6adnLTvTLXxfxxKZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722945337; c=relaxed/simple;
	bh=l3Hxs192ZIU/QlINb5D9l2U/6mCPGZxc33pyYkARqWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5WI8dn4YUmQ/JrTWmn4QNnURK0H4Li/W9MiVJiYY4qpubqsNtEs3NGlWqrTn5NbZC9uNJa7z/gNCPCogp6CCuV7nR3e8czKHSButfFt2fxiqjWscqsFCyQiAQwtCjb0+uzl2qOOgAbBj/mfOZpuHROG9wW0C+sLEcgYaM1nAGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XluvNxbM; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b797fb1c4aso4193006d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 04:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722945334; x=1723550134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlSPvJLIW4qUMTCPFGl/NV88GgQ1ugTgncNXCuPo7qM=;
        b=XluvNxbMlrJ89oml+OAn7gQV1hKJSZZY1cb7M5wjOQKOLNYbkYIYn7IIfopLmzzUjv
         77j6u6LkVJWF17WJVmsTz6Mm2nyCvJNyFpChcm9hJo2JofWLWjTwi7fa7qi8uDB9yssG
         91zZ4f923+Tip7YtUPun16yNm4b6rXIkIzFpmgPetZyTx9QHjSrrdJpefXLEc1XklKr4
         eM/CtkQGj0dLMMGMD3hr20C/iLvMydkFF2GHbEukdXKnhNZcoFuJViJdSJmuukN/1nXZ
         rHyOvA+MIQfBL/BBfs/UmlB2kN0d7191ElZOXG9Rd47HXa/qdpOQzswUrLAB5KpodoCj
         WZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722945334; x=1723550134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlSPvJLIW4qUMTCPFGl/NV88GgQ1ugTgncNXCuPo7qM=;
        b=u2j8dwZnGenxeEhwNAbt9ImoK5/OQOWPa5bEFiUlHnYAyDOtVvkcDp9oDbMl/5XIWW
         W4MM4NBXrRTvFircv0KZNF+9D8XxeObgI+Xe2SRztzid0TrnMQdGP8oOcR89zV24d063
         329W8rs3IwZGpqc66gtGM3zeTbU75J8Iak7XPGnI4oPQ7Y8NLDvzHfrvU6R578Vs91Ib
         js8M8ke4/04piyc3z0G95VC+EFiJS9ZnpJa6V91jGdDNY+47cbOuVoM0ci+ZgfDM1zmh
         RzovVWIlFY46eDKDjCXJ8kZ/K0aQ876zKtvC1qdfiEo5CxCeSQ2LpO3b5IZeWFPbH26Z
         frdA==
X-Forwarded-Encrypted: i=1; AJvYcCWUJPwc/H7GjjSRbnrhkR63iyrsGZNwnNvCbpQP8zlhNb9mE3MxaanyPqov6iI/UVKPjFVC/FbC/JA3gVex9kd+z5MniQxj0ui+Njhvng==
X-Gm-Message-State: AOJu0YxFBMa9LeSYqBcBbqRzXckGUTyr9ehZMEfU0uLadbXFhFezJImK
	Xrq46uYO80PHbwlZB/C7WAN5YG/KOkdmPbyWGGPwAPT0DU19CCPw1rZbRA+QfYiql8Uj844eV56
	QJzUT4gAO/zfaQLy7LZXRMSG08l0=
X-Google-Smtp-Source: AGHT+IFsoHps/mQx31mGPxMYrcwThlxh+M3gpd3hSJbNLL4HIMl01Xv6l9GoqRqMiUI1YWR35nYMwCSCmUPBfS8JueQ=
X-Received: by 2002:a05:6214:5d12:b0:6b0:7413:e0e9 with SMTP id
 6a1803df08f44-6bb98348810mr164918866d6.5.1722945334369; Tue, 06 Aug 2024
 04:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804080251.21239-1-laoar.shao@gmail.com> <20240805134034.mf3ljesorgupe6e7@quack3>
In-Reply-To: <20240805134034.mf3ljesorgupe6e7@quack3>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 6 Aug 2024 19:54:58 +0800
Message-ID: <CALOAHbCor0VoCNLACydSytV7sB8NK-TU2tkfJAej+sAvVsVDwA@mail.gmail.com>
Subject: Re: [PATCH] fs: Add a new flag RWF_IOWAIT for preadv2(2)
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 9:40=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 04-08-24 16:02:51, Yafang Shao wrote:
> > Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Our big data workloads are deployed on XFS-based disks, and we frequent=
ly
> > encounter hung tasks caused by xfs_ilock. These hung tasks arise becaus=
e
> > different applications may access the same files concurrently. For exam=
ple,
> > while a datanode task is writing to a file, a filebeat[0] task might be
> > reading the same file concurrently. If the task writing to the file tak=
es a
> > long time, the task reading the file will hang due to contention on the=
 XFS
> > inode lock.
> >
> > This inode lock contention between writing and reading files only occur=
s on
> > XFS, but not on other file systems such as EXT4. Dave provided a clear
> > explanation for why this occurs only on XFS[1]:
> >
> >   : I/O is intended to be atomic to ordinary files and pipes and FIFOs.
> >   : Atomic means that all the bytes from a single operation that starte=
d
> >   : out together end up together, without interleaving from other I/O
> >   : operations. [2]
> >   : XFS is the only linux filesystem that provides this behaviour.
> >
> > As we have been running big data on XFS for years, we don't want to swi=
tch
> > to other file systems like EXT4. Therefore, we plan to resolve these is=
sues
> > within XFS.
> >
> > Proposal
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >
> > One solution we're currently exploring is leveraging the preadv2(2)
> > syscall. By using the RWF_NOWAIT flag, preadv2(2) can avoid the XFS ino=
de
> > lock hung task. This can be illustrated as follows:
> >
> >   retry:
> >       if (preadv2(fd, iovec, cnt, offset, RWF_NOWAIT) < 0) {
> >           sleep(n)
> >           goto retry;
> >       }
> >
> > Since the tasks reading the same files are not critical tasks, a delay =
in
> > reading is acceptable. However, RWF_NOWAIT not only enables IOCB_NOWAIT=
 but
> > also enables IOCB_NOIO. Therefore, if the file is not in the page cache=
, it
> > will loop indefinitely until someone else reads it from disk, which is =
not
> > acceptable.
> >
> > So we're planning to introduce a new flag, IOCB_IOWAIT, to preadv2(2). =
This
> > flag will allow reading from the disk if the file is not in the page ca=
che
> > but will not allow waiting for the lock if it is held by others. With t=
his
> > new flag, we can resolve our issues effectively.
> >
> > Link: https://lore.kernel.org/linux-xfs/20190325001044.GA23020@dastard/=
 [0]
> > Link: https://github.com/elastic/beats/tree/master/filebeat [1]
> > Link: https://pubs.opengroup.org/onlinepubs/009695399/functions/read.ht=
ml [2]
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Dave Chinner <david@fromorbit.com>
>
> Thanks for the detailed explanation! I understand your problem but I have=
 to
> say I find this flag like a hack to workaround particular XFS behavior an=
d
> the guarantees the new RWF_IOWAIT flag should provide are not very clear =
to
> me.

Its guarantee is clear:

  : I/O is intended to be atomic to ordinary files and pipes and FIFOs.
  : Atomic means that all the bytes from a single operation that started
  : out together end up together, without interleaving from other I/O
  : operations.

What this flag does is avoid waiting for this type of lock if it
exists. Maybe we should consider a more descriptive name like
RWF_NOATOMICWAIT, RWF_NOFSLOCK, or RWF_NOPOSIXWAIT? Naming is always
challenging.

Since this behavior is required by POSIX, it shouldn't be viewed as an
XFS-specific behavior. Other filesystems might adopt this rule in the
future as well.

> I've CCed Amir who's been dealing with similar issues with XFS at his
> employer and had some patches as far as I remember.
>
> What you could possibly do to read the file contents without blocking on
> xfs_iolock is to mmap the file and grab the data from the mapping. It is
> still hacky but at least we don't have to pollute the kernel with an IO
> flag with unclear semantics.

The file size to be read is not fixed, which is why we prefer to use
the traditional read API rather than mmap. We have implemented a
hotfix version of this commit on many of our production servers, and
it works well as expected. While I agree that mmap() is another viable
option, we may consider switching to it in the future if this new flag
introduces any issues.

--=20
Regards
Yafang

