Return-Path: <linux-fsdevel+bounces-57579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 003AFB23A23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 22:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E495C7A7B86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 20:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB682D063C;
	Tue, 12 Aug 2025 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfM4iAZB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577DE1E32B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755031469; cv=none; b=LZLm4IgMNCrc+pa9xgWReopGKUSA3PL1GSKJRAcSwbVdYohf8wBUuxPZ0s30997E+1X5EsiymHmfMzxb3UQRSJgu29ndBk0xMrMr+IHGFTGsLMDgeeJs/76rDCVpiMjMWQxtuyf4OlozbHeper4sFN4HY+BzuSV0N4tulKz7Vpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755031469; c=relaxed/simple;
	bh=VkcJwqDwGg6LLAKHoA5qyed4rKM82pF4Rfv4NWasyDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OND1on6RERNIQFTDBNZ1YH+ykQRVQYUTb91ccxvT/4KS92J80EydM6EUHjoAxA9GzF/JrZ62mOTskv7dKGT60X6Yc9wz13XwoKknr2dU1ocnbdSNoywoIwhGI/pLvaIw1JDJFVrwLzOv9e1EYG/qcYCLqsf3YHgitaxsfQ3zvSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfM4iAZB; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b07d777d5bso67132721cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 13:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755031467; x=1755636267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46EbTSDW40ci3W41IuS4qoeM0+YUaRcuxqyn2vPCywY=;
        b=DfM4iAZBdhTBOAEERYkG4aEGaoZlT0hTN7jksLQbJf+u0e930x7y9GW6NbaDJf9Z03
         4uNWcBDQbdc/8e8usZh7OiU9+9qiaC1PGfjG/x+0facAlwyz8NlMosbs5s58rAIZmiHs
         sx25rVKXzH2DuZH+k34T21pf9rpEciNYAGNbHk/s5h6Dw2JaeAtl5t34grSj/9uaLnXJ
         1jVbPtxqM1oofxiaU7RoDhLZrxNOGEQWjCXh+r2SFbSyKTIeJrJr+NQaOm8SioCCAO70
         QhGRiXxreqJVtYUX2frjPhq4n4pV/Zl0/h4w+q7ONuXJEKoDFq/f3BW5Lm0cvGeM06IR
         G66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755031467; x=1755636267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46EbTSDW40ci3W41IuS4qoeM0+YUaRcuxqyn2vPCywY=;
        b=RYzf68aqatxbphkXNPwwTA+A+BlRRVD7EH78snIqHtum/p1S6+QeqIU+E1F4hWpOIm
         4FXdPrlsXfxhP2Wh9a6KbjRePvl9dg2hJFzU5Fc3+qnrSs+1M1ch8XZmFX34lWB0krLj
         ihD7eZ9P0YEX8yFkdiMSJ0CUWz9AEr1e07kqZkQ7hVIv7NjMxtGfhnkXqh/tbNi5bCY4
         6SR1nKxyWHIFmzdzop5TxBSIwz9QcwZmQObVZdHV8eS+7/8Nx0KaYYsySv56M160Q/WG
         7cPD1aAWzzEhXJjQ4s1Fb8eBpwW8lJoFXsYvgvfmo4C/1WOn98sWnRWlX1Cfqu92eEE8
         hxcg==
X-Forwarded-Encrypted: i=1; AJvYcCWw+N+n1+prax+Ctf1ytcH/c0DGRFh0h5X8jmMgo8mOyWcQaTT3UXB/u2V9r1poh+kM2NdTQASmgDpFqs6B@vger.kernel.org
X-Gm-Message-State: AOJu0YxLqXM14NcyZfcASnwgSoVIVSzv9Ah4IxTiyGgiu0mvF+b5aHe5
	f9ggijHSDpYMkrvNBS0Df53TfSA6pklC5W4XlQ5bmbxtvL8F7fHJuzv2g/78A0QEk7o8cKxHMDg
	NVYzSRcA5+6wOpCSf9UaboTEpOpv1qS4=
X-Gm-Gg: ASbGncsvDW0hLGHuPptcQaHGZDCS8ChumiCDVx3pIIbRcUJHsNlBC+x6ygiC33VlMp8
	WXoNVnwUlg5kzCeLOCIw+Pdabc+qfDyQdGqDpcoO3sRBKOivqKjl667u3DdvpT/JK6rMIh1lkYx
	iscPvVfwEwh0BQkDIFw5hgdyt4YfPwt37yFi3s3Cdm3ouWIn2Agmomv6TTwJd7MR0oIvC1uSGtc
	0v9HMZ6
X-Google-Smtp-Source: AGHT+IGOfCe5DAcCPj/SBKMBIwDMexqdiudr9qmwtfTPYhUMCwq95oCGqTSTmEOb6E+1UXuCke1FusZ6oZ1qRqqNKmU=
X-Received: by 2002:a05:622a:90d:b0:4b0:7736:4861 with SMTP id
 d75a77b69052e-4b0fc891b04mr5142511cf.44.1755031467129; Tue, 12 Aug 2025
 13:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807175015.515192-1-joannelkoong@gmail.com>
 <CAJfpeguCOxeVX88_zPd1hqziB_C+tmfuDhZP5qO2nKmnb-dTUA@mail.gmail.com> <20250812195922.GL7942@frogsfrogsfrogs>
In-Reply-To: <20250812195922.GL7942@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 12 Aug 2025 13:44:15 -0700
X-Gm-Features: Ac12FXxCShTGrL8eX_eU24ceyDoH-29zwj67Qpofl9MlbXvZW5M5O8DG8T7fB1I
Message-ID: <CAJnrk1Zt9XoD2sPYGzFQwKsCHo_ityZ-4XzU_2Vii3g=w89bQg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: keep inode->i_blkbits constant
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 12:59=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Tue, Aug 12, 2025 at 10:27:41AM +0200, Miklos Szeredi wrote:
> > On Thu, 7 Aug 2025 at 19:51, Joanne Koong <joannelkoong@gmail.com> wrot=
e:
> > >
> > > With fuse now using iomap for writeback handling, inode blkbits chang=
es
> > > are problematic because iomap relies on inode->i_blkbits for its
> > > internal bitmap logic. Currently we change inode->i_blkbits in fuse t=
o
> > > match the attr->blksize value passed in by the server.
> > >
> > > This commit keeps inode->i_blkbits constant in fuse. Any attr->blksiz=
e
> > > values passed in by the server will not update inode->i_blkbits. The
> > > client-side behavior for stat is unaffected, stat will still reflect =
the
> > > blocksize passed in by the server.
> >
> > Not quite.  You also need to save ilog2(attr->blksize) in
> > fi->orig_i_blkbits and restore it after calling generic_fillattr() in
> > fuse_update_get_attr() just like it's done for i_mode and i_ino.
>
> Why is that?  Is the goal here that fstat() should always return the
> most recent blocksize the fuse server reported, even if the pagecache
> accounting still uses the blocksize first reported when the kernel
> created the incore struct inode?

My understanding is that it's because in that path it uses cached stat
values instead of fetching with another statx call to the server so it
has to reflect the blocksize the server previously set. It took me a
while to realize that the blocksize the server reports to the client
is unrelated to whatever blocksize the kernel internally uses for the
inode since the kernel doesn't do any block i/o for fuse; the commit
message in commit 0e9663ee452ff ("fuse: add blksize field to
fuse_attr") says the blocksize attribute is if "the filesystem might
want to give a hint to the app about the optimal I/O size".


Thanks,
Joanne

>
> --D

