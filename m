Return-Path: <linux-fsdevel+bounces-10876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F35B384EFF8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 06:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F531F26871
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 05:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D19B56B8E;
	Fri,  9 Feb 2024 05:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+zrUFHY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67756B63;
	Fri,  9 Feb 2024 05:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707457122; cv=none; b=mYXvyc2cVmjO3rS3NNLPapZnnldDWiwW+NcPom/6qQ4Jgy7cOURWi9CRGKfo8mPBuPxyiSsCywINQtFjkzjRvI2RpRONVG5TDVBw1r6+CllbsPLX660cD/Iy2y3gKtm1oj21XKq7vBBZGKO/VUJu1cRucE3gvBppLtZ6lK11sVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707457122; c=relaxed/simple;
	bh=tV0isjsKbv8xrtfkEWlbYqhVclTpDzX3NjW4HZcAWpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwSIe3jBquQA+32S6676RyBv1wPwRTPYf+vBbisCR7AeMRQJHBKOZrTOgz/tpYN46n4YZ/MahqzMaM8ch5+1NV/ZQPOGBYPA/eUAPB4CO6h3CnxkyODO6bP1GYQCc+oa79dU7YB85kwm1EoBaeCAbT1Ofdcqxv55Tynpw4Mqf7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+zrUFHY; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-511717231bfso731522e87.2;
        Thu, 08 Feb 2024 21:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707457119; x=1708061919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2ON2A+lOO3nREYQrtCJ2Mpgawap/rmj0NZtvf1XemM=;
        b=m+zrUFHYzKAvlSbEJ7uyNX/C1fCkWCJ1M1+RkCWv1vy39LRULDl4dTAz+csaqcp4gp
         Osj44lmAC6MNSEQXg9fWeoyM502ZcISsuqbJ4g5CFZnqKCqZvkulIL4IHA8dLYZf7zfa
         7U45xewwMkPK1Vt5bpi7k9a4OZjIZ40Dc2Is59VgaDTrQ2IL2LmLSwTdSNLdj0DmZJVh
         2CV4siWjK0RWuoEE0I36n3Wx8pQq35znuCgpeWsycWIvKlP9opsoxGpWDB0Sc3ns4DAV
         yVMyxK9+AHdhtCRHezQ4XyLMgz/l7SJIstmCVkN3pDeOVD0+wFhklMD616zFvCdl/Uks
         Jihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707457119; x=1708061919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2ON2A+lOO3nREYQrtCJ2Mpgawap/rmj0NZtvf1XemM=;
        b=jYhcB33XuLG+urrFcaspi1OsYsiQaG2YZMlvdKtjsO0iTpnwkbfYwHWUtiTNUnBQOP
         /KcG0nKypo8r5dY2AfpNeJiunxVsAAaOKmSMZwRTmFSUgq7ztcxTRU7wydgXD12ehDJg
         SNyU1cDU/fLUjk23bXKC6Q2dlVRrZuH26LAOCpKnetY8lhHiLoNOxZxFB1ui/MRzv8Ln
         DKx6tjw0encSO6PiO0FF2upp+bIvhMQlD4nc3kRkgcrv3zeSzPXlYn/lopqIA6yJISh0
         UV39B9v8igH+T2rkct2digPvU4eVcbfgUZQLcoKW1FqIxYeQVhMTiSdDR52sEiFlETTB
         0FGA==
X-Forwarded-Encrypted: i=1; AJvYcCVxFrV1h09fqREVuYkZYRfRqoJmV8IbntPC1sc9r5cMkI1lv9w/HUdybguisC+/xXoXaaQ2Hw+MW8YrMMZMkOV/6chBufaVFEaJ6ehX6K5rHEYDuFGo7E2n2yZO0/X5sn0VpyPWrEtHnQE=
X-Gm-Message-State: AOJu0YzUG3Y0I440o/kGSN2GU5obbA9RjVlPe11namNNdDF5II7zSkRy
	8fm2Xn1Ew7xK/P7nHLGfRRaJF3qVxe529bngDChP5okf7YmcIxD5NZphNuMfxgrq+E0/eKnIFap
	UMhnQbUN4BzEBOAVO36q2OgDqDCsc2Ue8Kd4=
X-Google-Smtp-Source: AGHT+IGMlH2PriUAf55IhhR4053vLAuO/sXZe50YH+HHBn5j2JbcsqjbweiSwxVDwAiz4kQy1ufc9RS/6mDODdKwL88=
X-Received: by 2002:a19:c219:0:b0:511:6ff9:8b8d with SMTP id
 l25-20020a19c219000000b005116ff98b8dmr268670lfc.59.1707457118610; Thu, 08 Feb
 2024 21:38:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mswELNv2Mo-aWNoq3fRUC7Rk0TjfY8kwdPc=JSEuZZObw@mail.gmail.com>
 <20240207034117.20714-1-matthew.ruffell@canonical.com> <CAH2r5mu04KHQV3wynaBSrwkptSE_0ARq5YU1aGt7hmZkdsVsng@mail.gmail.com>
 <CAH2r5msJ12ShH+ZUOeEg3OZaJ-OJ53-mCHONftmec7FNm3znWQ@mail.gmail.com>
 <CAH2r5muiod=thF6tnSrgd_LEUCdqy03a2Ln1RU40OMETqt2Z_A@mail.gmail.com>
 <CAH2r5mvzyxP7vHQVcT6ieP4NmXDAz2UqTT7G4yrxcVObkV_3YQ@mail.gmail.com> <CAKAwkKuJvFDFG7=bCYmj0jdMMhYTLUnyGDuEAubToctbNqT5CQ@mail.gmail.com>
In-Reply-To: <CAKAwkKuJvFDFG7=bCYmj0jdMMhYTLUnyGDuEAubToctbNqT5CQ@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 8 Feb 2024 23:38:27 -0600
Message-ID: <CAH2r5mt9gPhUSka56yk28+nksw7=LPuS4VAMzGQyJEOfcpOc=g@mail.gmail.com>
Subject: Re: SMB 1.0 broken between Kernel versions 6.2 and 6.5
To: Matthew Ruffell <matthew.ruffell@canonical.com>
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org, rdiez-2006@rd10.de, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Are you specifying "wsize" on the mount in your example?  The intent
of the patch is to warn the user using a non-recommended wsize (since
the user can control and fix that) but to force round_down when the
server sends a dangerous wsize (ie one that is not a multiple of
4096).

On Thu, Feb 8, 2024 at 3:31=E2=80=AFAM Matthew Ruffell
<matthew.ruffell@canonical.com> wrote:
>
> Hi Steve,
>
> I built your latest patch ontop of 6.8-rc3, but the problem still persist=
s.
>
> Looking at dmesg, I see the debug statement from the second hunk, but not=
 from
> the first hunk, so I don't believe that wsize was ever rounded down to
> PAGE_SIZE.
>
> [  541.918267] Use of the less secure dialect vers=3D1.0 is not
> recommended unless required for access to very old servers
> [  541.920913] CIFS: VFS: Use of the less secure dialect vers=3D1.0 is
> not recommended unless required for access to very old servers
> [  541.923533] CIFS: VFS: wsize should be a multiple of 4096 (PAGE_SIZE)
> [  541.924755] CIFS: Attempting to mount //192.168.122.172/sambashare
>
> $ sha256sum sambashare/testdata.txt
> 9e573a0aa795f9cd4de4ac684a1c056dbc7d2ba5494d02e71b6225ff5f0fd866
> sambashare/testdata.txt
> $ less sambashare/testdata.txt
> ...
> 8dc8da96f7e5de0f312a2dbcc3c5c6facbfcc2fc206e29283274582ec93daa2a1496ca8ed=
d49e3c1
> 6b^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^
> ...
>
> Would you be able compile and test your patch and see if we enter the log=
ic from
> the first hunk?
>
> I'll be happy to test a V2 tomorrow.
>
> Thanks,
> Matthew
>
> On Thu, 8 Feb 2024 at 03:50, Steve French <smfrench@gmail.com> wrote:
> >
> > I had attached the wrong file - reattaching the correct patch (ie that
> > updates the previous version to use PAGE_SIZE instead of 4096)
> >
> > On Wed, Feb 7, 2024 at 1:12=E2=80=AFAM Steve French <smfrench@gmail.com=
> wrote:
> > >
> > > Updated patch - now use PAGE_SIZE instead of hard coding to 4096.
> > >
> > > See attached
> > >
> > > On Tue, Feb 6, 2024 at 11:32=E2=80=AFPM Steve French <smfrench@gmail.=
com> wrote:
> > > >
> > > > Attached updated patch which also adds check to make sure max write
> > > > size is at least 4K
> > > >
> > > > On Tue, Feb 6, 2024 at 10:58=E2=80=AFPM Steve French <smfrench@gmai=
l.com> wrote:
> > > > >
> > > > > > his netfslib work looks like quite a big refactor. Is there any=
 plans to land this in 6.8? Or will this be 6.9 / later?
> > > > >
> > > > > I don't object to putting them in 6.8 if there was additional rev=
iew
> > > > > (it is quite large), but I expect there would be pushback, and am
> > > > > concerned that David's status update did still show some TODOs fo=
r
> > > > > that patch series.  I do plan to upload his most recent set to
> > > > > cifs-2.6.git for-next later in the week and target would be for
> > > > > merging the patch series would be 6.9-rc1 unless major issues wer=
e
> > > > > found in review or testing
> > > > >
> > > > > On Tue, Feb 6, 2024 at 9:42=E2=80=AFPM Matthew Ruffell
> > > > > <matthew.ruffell@canonical.com> wrote:
> > > > > >
> > > > > > I have bisected the issue, and found the commit that introduces=
 the problem:
> > > > > >
> > > > > > commit d08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > > > Author: David Howells <dhowells@redhat.com>
> > > > > > Date:   Mon Jan 24 21:13:24 2022 +0000
> > > > > > Subject: cifs: Change the I/O paths to use an iterator rather t=
han a page list
> > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git/commit/?id=3Dd08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > > >
> > > > > > $ git describe --contains d08089f649a0cfb2099c8551ac47eef0cc23f=
df2
> > > > > > v6.3-rc1~136^2~7
> > > > > >
> > > > > > David, I also tried your cifs-netfs tree available here:
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-=
fs.git/log/?h=3Dcifs-netfs
> > > > > >
> > > > > > This tree solves the issue. Specifically:
> > > > > >
> > > > > > commit 34efb2a814f1882ddb4a518c2e8a54db119fd0d8
> > > > > > Author: David Howells <dhowells@redhat.com>
> > > > > > Date:   Fri Oct 6 18:29:59 2023 +0100
> > > > > > Subject: cifs: Cut over to using netfslib
> > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/=
linux-fs.git/commit/?h=3Dcifs-netfs&id=3D34efb2a814f1882ddb4a518c2e8a54db11=
9fd0d8
> > > > > >
> > > > > > This netfslib work looks like quite a big refactor. Is there an=
y plans to land this in 6.8? Or will this be 6.9 / later?
> > > > > >
> > > > > > Do you have any suggestions on how to fix this with a smaller d=
elta in 6.3 -> 6.8-rc3 that the stable kernels can use?
> > > > > >
> > > > > > Thanks,
> > > > > > Matthew
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Thanks,
> > > > >
> > > > > Steve
> > > >
> > > >
> > > >
> > > > --
> > > > Thanks,
> > > >
> > > > Steve
> > >
> > >
> > >
> > > --
> > > Thanks,
> > >
> > > Steve
> >
> >
> >
> > --
> > Thanks,
> >
> > Steve



--=20
Thanks,

Steve

