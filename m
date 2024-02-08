Return-Path: <linux-fsdevel+bounces-10759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AF684DCFD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADF4283F9A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6CA6BFAA;
	Thu,  8 Feb 2024 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="trDtQzx+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE536BB59
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384704; cv=none; b=cOwv5S2oj9DfY0WtmzFPbooIQytZ0hU5QdW5T7yIqlo5wKjw3o1nqqF/RRcvFF151Zw7wsWcuLwZgHsJLVh3w0Cu7HDRLHQfdUp6LouXM93giRYObTMp2AIRghseL0CrdMjTnCiU1VIT6kXOgnP2ogKcWrMPCXSnxQ+sx0DSNMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384704; c=relaxed/simple;
	bh=L22Oeabi8zlqbDcxbZEBszW9hA1N7HgD2Byxa0e09zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuhhwl8Cm3j8vtH1IdCsszPTio6xHFE7CboNDeGStDj5ja01B2Zk+qovYpfAB090mHhfb1jItgIB1vL7bjQehS5KJbaHD9WH2SZEcI/6tmqBsmJEHZ6hOOGnvw997PGIv1lzc3X2epOfV8ZaT4rBi68HUMr6ZC5bFfgMIde5Un4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=trDtQzx+; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6926640590
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 09:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1707384698;
	bh=nZ1lAEgDVoUgablIhSVSELqdyjH+XNxHZkXZ2Yk8PWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=trDtQzx+bWWo1Swpjl15ZU7ZbQ8NGalEqphkc/SAxgQlLfKKIRqaWgqt+8t3tKwtx
	 yddH4nvrOD+ZdDQN64Jn1ZgN4bPCy09CCo2zYNBLPF+zB794PGD2JscNUY0PCkAEs+
	 YSyNl8hXSyVtP/Zs2FaMbZ+whmuLQnbge4fnJBR/yQAaXqiEEZLZf4fDk5svWFB7XQ
	 MAy12j6JEiqNOtLmK+bvUIj8egxCiohDqt7m7A10+BSKZ0vnSnLeqQxqBucemnRgCP
	 MD+eNyltpmVxL9avxmO0o8zy3hFfaYX/W7eogreY0f5U8FYCjn2vKJZK9a1DdMK9vr
	 TfsW5s63bqMiA==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2966737d3e3so1438376a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 01:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707384696; x=1707989496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZ1lAEgDVoUgablIhSVSELqdyjH+XNxHZkXZ2Yk8PWY=;
        b=fzsKityWH9OEQIi1P2R4yFyJpsEuzBR8Men1W2cLNgOygjNiMWu+DgklEOteLVdLt8
         TLMPAnIKxmZXZCkry+ca031auLZZdprU+jOBKwypaUaXK7GbX4Z1p3kQEDYesjOIJwye
         B43iCF4Ua8dm1oIbCnvhhnvCGWeHwdKIt3j0xeOfak/GQ/SGD45kkQdVxZYsS184qvTh
         dXB700qR8wEKr/0P6Dacm+R3SiOQUSFH0BrtbDnpe4tw6mnRMtuByw5CnSG2Pskng+AJ
         AhDSk4qB+GKhpkbxxyS1ygz9hx5GJdIZDBCzC9y7PA1KF7d8R2l+FHL7salCgr58Qnxc
         uccQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQs1zJ6WKHGT97cT0X9LjjxNp07X8XCTPPq5sKTwGFFxsPTFEIb9unJYORM+9eb07ksZ3q6yb8fy3DBDgg8Il+YRIHOsI/NnTT0B/7MA==
X-Gm-Message-State: AOJu0YwrLqNLxLQKZOB0m0XZi/O8nxQJsJFyJx4S8GMUHaGdHUGHClRN
	ebLKkpYwOzEvtWCUVhAS7sijG/DW/ecAVTM2L7XH9e++AawQFcQ/v6xbHTNAEGgCWJ2IvSQT44k
	xpD97TLOtt6CzJV53Bm4z46Hsj3rbfVDM678rRLMCdIzQl+Kt9AsgmsUN3chN0/jlbFTkh9Eqot
	q71cs6ts+khrrMJcTxsfcLGUKx03vnjmYGHWD183UnCrn/nH46Kkpa5A==
X-Received: by 2002:a17:90a:d90e:b0:290:d726:2a73 with SMTP id c14-20020a17090ad90e00b00290d7262a73mr5813661pjv.2.1707384696729;
        Thu, 08 Feb 2024 01:31:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFQTXaI2Fk/rg5oyLqGT7ctJtz6ELOGmYu+HOvP79WvRGL0jxmC8cOKTdrySyODsrG6lG9j1ysa4kPIVrO6EQ=
X-Received: by 2002:a17:90a:d90e:b0:290:d726:2a73 with SMTP id
 c14-20020a17090ad90e00b00290d7262a73mr5813643pjv.2.1707384696331; Thu, 08 Feb
 2024 01:31:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mswELNv2Mo-aWNoq3fRUC7Rk0TjfY8kwdPc=JSEuZZObw@mail.gmail.com>
 <20240207034117.20714-1-matthew.ruffell@canonical.com> <CAH2r5mu04KHQV3wynaBSrwkptSE_0ARq5YU1aGt7hmZkdsVsng@mail.gmail.com>
 <CAH2r5msJ12ShH+ZUOeEg3OZaJ-OJ53-mCHONftmec7FNm3znWQ@mail.gmail.com>
 <CAH2r5muiod=thF6tnSrgd_LEUCdqy03a2Ln1RU40OMETqt2Z_A@mail.gmail.com> <CAH2r5mvzyxP7vHQVcT6ieP4NmXDAz2UqTT7G4yrxcVObkV_3YQ@mail.gmail.com>
In-Reply-To: <CAH2r5mvzyxP7vHQVcT6ieP4NmXDAz2UqTT7G4yrxcVObkV_3YQ@mail.gmail.com>
From: Matthew Ruffell <matthew.ruffell@canonical.com>
Date: Thu, 8 Feb 2024 22:31:25 +1300
Message-ID: <CAKAwkKuJvFDFG7=bCYmj0jdMMhYTLUnyGDuEAubToctbNqT5CQ@mail.gmail.com>
Subject: Re: SMB 1.0 broken between Kernel versions 6.2 and 6.5
To: Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org, rdiez-2006@rd10.de, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steve,

I built your latest patch ontop of 6.8-rc3, but the problem still persists.

Looking at dmesg, I see the debug statement from the second hunk, but not f=
rom
the first hunk, so I don't believe that wsize was ever rounded down to
PAGE_SIZE.

[  541.918267] Use of the less secure dialect vers=3D1.0 is not
recommended unless required for access to very old servers
[  541.920913] CIFS: VFS: Use of the less secure dialect vers=3D1.0 is
not recommended unless required for access to very old servers
[  541.923533] CIFS: VFS: wsize should be a multiple of 4096 (PAGE_SIZE)
[  541.924755] CIFS: Attempting to mount //192.168.122.172/sambashare

$ sha256sum sambashare/testdata.txt
9e573a0aa795f9cd4de4ac684a1c056dbc7d2ba5494d02e71b6225ff5f0fd866
sambashare/testdata.txt
$ less sambashare/testdata.txt
...
8dc8da96f7e5de0f312a2dbcc3c5c6facbfcc2fc206e29283274582ec93daa2a1496ca8edd4=
9e3c1
6b^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^
...

Would you be able compile and test your patch and see if we enter the logic=
 from
the first hunk?

I'll be happy to test a V2 tomorrow.

Thanks,
Matthew

On Thu, 8 Feb 2024 at 03:50, Steve French <smfrench@gmail.com> wrote:
>
> I had attached the wrong file - reattaching the correct patch (ie that
> updates the previous version to use PAGE_SIZE instead of 4096)
>
> On Wed, Feb 7, 2024 at 1:12=E2=80=AFAM Steve French <smfrench@gmail.com> =
wrote:
> >
> > Updated patch - now use PAGE_SIZE instead of hard coding to 4096.
> >
> > See attached
> >
> > On Tue, Feb 6, 2024 at 11:32=E2=80=AFPM Steve French <smfrench@gmail.co=
m> wrote:
> > >
> > > Attached updated patch which also adds check to make sure max write
> > > size is at least 4K
> > >
> > > On Tue, Feb 6, 2024 at 10:58=E2=80=AFPM Steve French <smfrench@gmail.=
com> wrote:
> > > >
> > > > > his netfslib work looks like quite a big refactor. Is there any p=
lans to land this in 6.8? Or will this be 6.9 / later?
> > > >
> > > > I don't object to putting them in 6.8 if there was additional revie=
w
> > > > (it is quite large), but I expect there would be pushback, and am
> > > > concerned that David's status update did still show some TODOs for
> > > > that patch series.  I do plan to upload his most recent set to
> > > > cifs-2.6.git for-next later in the week and target would be for
> > > > merging the patch series would be 6.9-rc1 unless major issues were
> > > > found in review or testing
> > > >
> > > > On Tue, Feb 6, 2024 at 9:42=E2=80=AFPM Matthew Ruffell
> > > > <matthew.ruffell@canonical.com> wrote:
> > > > >
> > > > > I have bisected the issue, and found the commit that introduces t=
he problem:
> > > > >
> > > > > commit d08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > > Author: David Howells <dhowells@redhat.com>
> > > > > Date:   Mon Jan 24 21:13:24 2022 +0000
> > > > > Subject: cifs: Change the I/O paths to use an iterator rather tha=
n a page list
> > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?id=3Dd08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > >
> > > > > $ git describe --contains d08089f649a0cfb2099c8551ac47eef0cc23fdf=
2
> > > > > v6.3-rc1~136^2~7
> > > > >
> > > > > David, I also tried your cifs-netfs tree available here:
> > > > >
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dcifs-netfs
> > > > >
> > > > > This tree solves the issue. Specifically:
> > > > >
> > > > > commit 34efb2a814f1882ddb4a518c2e8a54db119fd0d8
> > > > > Author: David Howells <dhowells@redhat.com>
> > > > > Date:   Fri Oct 6 18:29:59 2023 +0100
> > > > > Subject: cifs: Cut over to using netfslib
> > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/li=
nux-fs.git/commit/?h=3Dcifs-netfs&id=3D34efb2a814f1882ddb4a518c2e8a54db119f=
d0d8
> > > > >
> > > > > This netfslib work looks like quite a big refactor. Is there any =
plans to land this in 6.8? Or will this be 6.9 / later?
> > > > >
> > > > > Do you have any suggestions on how to fix this with a smaller del=
ta in 6.3 -> 6.8-rc3 that the stable kernels can use?
> > > > >
> > > > > Thanks,
> > > > > Matthew
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
>
>
>
> --
> Thanks,
>
> Steve

