Return-Path: <linux-fsdevel+bounces-71506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4560ACC5D0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 03:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 924243010E2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 02:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E07218ACC;
	Wed, 17 Dec 2025 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndPxeDgU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552AC5464D
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 02:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765939722; cv=none; b=tBw5NSm6yLDUTtOe1Xqy1tTnaVpKcjNKLEtus98WUdFVYxBKe/4iNYAtzD/fv9qD64jKq/0RVJy2amx4NV9zvTpX8SKc2tp5tyr/g4zk5WLW+SHR3ewDno34/bb8HywOjOFR1JtkfCRUpLgeVkS1tgZJWSvobdaH9tCT27PwhEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765939722; c=relaxed/simple;
	bh=Uh7RHveH8xXW9Hfnz4BFu5lWuSWSj4itxI+b3endLLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IL4Q2e3wLVk4+X6I4rk8eaxEWN4b/ZUM0l7yfP1EcA1ihsHylfhs/xyhZYNJzaart8lHS/KZH29H2MZH1sswsce4D886KA3Kj/Tar5jGVvdGxifaWauncK0U0r2R1x+033tLbiv38vB1eyk2FFxzOGI438wKlyxH6OBIPbBF20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndPxeDgU; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee0ce50b95so1532321cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 18:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765939719; x=1766544519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPKRMuZ+/QbjJGnog+FPFDBCZSK+qTuV0BL8UXwwWP4=;
        b=ndPxeDgUITlp2/K+8++KBHoQLGjrfcV3Xb7TzgRKR9kSQB04Z4ETMnpaqafSiJIHaO
         l/wert9+HWsq2ILCGoZa5bVFcOQ+yvEHq/ubavr0inlNb6FduJ7ggfhGMhxhj/v6W7Nq
         GlltpwSqNsbyJVo2dFvF6vBu2V3CBCBOj2Bj99l7+0w/ctWTUuFCnlLvWK9ikYUej+8U
         ArKv3B1BkpqbthCMWxYqiyRbIX6sZ4SyqXLNK94mS/vWWVBrYiLmlfuThB8qX599awHj
         8H4dVDiqoe6ip5vq8mKMkdEeqX/v/TC/TaWvGcInB6NQ8iVbytEtxAd2oRGU130L4/TM
         u+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765939719; x=1766544519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hPKRMuZ+/QbjJGnog+FPFDBCZSK+qTuV0BL8UXwwWP4=;
        b=Ph5aIjysa29si3mLQ9XG9tzOFjYdNPVFrMeujhjdpANd9MNrp9Tboff333CId1M7kn
         tPBr1jurdPLGcHjDll4iCRqJf0UB3iTbopWJfzI5I68exXIvkUydnxrVxdbphKPyXVaH
         GpVCfmKTq1LKDOXGekLD4KzoR+VpGnatvfpwbpSyh2H2t/z4gjftIXVxKj5EwkHznS0u
         Jze/aJjQqpA5MF1au5lSh+cqzsvjyOnQmzP6+zYJyXx++A8LtxNY/6Ymr67eJPXuIDkV
         Sjz0HxnjqZla2WYWSNcda9OUrac9SIK19P1bBWTTRm3M6FSMtUXPKXlQUtWLUQrVziHo
         MK7g==
X-Forwarded-Encrypted: i=1; AJvYcCVJdgvlaoqvLatsFmrzEktkza0aVvGJhAmkrG/YA2ZZIG136ycggLjK5rs9yKuF9wGmjkjUbV6oDZbWzNrD@vger.kernel.org
X-Gm-Message-State: AOJu0YxsjSBq+tnMzfn5Na6gkdNkozbcQWK4hhjSlrL+ckUdb0fjb3uT
	12A75P+mFT+fazl56N8WKOjHjkWDpFEeds2Aq8BqJy7PCg2EFuJQvWoyOIBiJClZ84MXxbV4fB6
	tJx5BPbpsukCkqUehi8s8W4PSeKilAZgW3Y8njjU=
X-Gm-Gg: AY/fxX6yG/kW/6I1jRO3MIQPw/WCybAWv6EFISZtnLJyn+4TIWkLKhXVdgYaICoEXlP
	82qzFyw2vmJ1sJFhtTXkmgvn7qB37ov84vuyn3GLexHKsUdhDLmsVS8FtE1BgZIynVrdE0vyYUU
	VTD1bzUoj6T5fFQfOtcDvpCftdIyyCVq61QH5sTUxCQ9wDLe3QAixJG6xdLjTcMmbgz3xAGT1m4
	xMgoH8U+KWfXUowhgjlc8oMz728sJBkRZTUe9/IErtMhck8wR3OgWUyw0wQ+fvdDqndvh1hqI8h
	VOH6uNBciLI=
X-Google-Smtp-Source: AGHT+IEk37sbumwKC/o3soje0ALx+8awM5C/gCgZ20N3qOLa/LSB6vFmsmBCMp4Ce4zQ5cl2TIoOX4370tm7aIeXRQ4=
X-Received: by 2002:a05:622a:2512:b0:4ed:4ee:3a82 with SMTP id
 d75a77b69052e-4f1cf2c4b9cmr229346781cf.6.1765939719262; Tue, 16 Dec 2025
 18:48:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-5-luis@igalia.com>
 <CAJnrk1aN4icSpL4XhVKAzySyVY+90xPG4cGfg7khQh-wXV+VaA@mail.gmail.com>
 <0427cbb9-f3f2-40e6-a03a-204c1798921d@ddn.com> <CAJnrk1a8nFhws6L61QSw21A4uR=67JSW+PyDF7jBH-YYFS8CEQ@mail.gmail.com>
 <20251217010046.GC7705@frogsfrogsfrogs>
In-Reply-To: <20251217010046.GC7705@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 17 Dec 2025 10:48:27 +0800
X-Gm-Features: AQt7F2pHBAMnWNlQ_n0elAUyAhO_UUDEimO696wqnlHNoSB35dlgDG5W_mYULxs
Message-ID: <CAJnrk1bVZDA9Q8u+9dpAySuaz+JDGdp9AcYyEMLe9zME35Y48g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Bernd Schubert <bschubert@ddn.com>, Luis Henriques <luis@igalia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>, 
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 9:00=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Dec 17, 2025 at 08:32:02AM +0800, Joanne Koong wrote:
> > On Tue, Dec 16, 2025 at 4:54=E2=80=AFPM Bernd Schubert <bschubert@ddn.c=
om> wrote:
> > >
> > > On 12/16/25 09:49, Joanne Koong wrote:
> > > > On Sat, Dec 13, 2025 at 2:14=E2=80=AFAM Luis Henriques <luis@igalia=
.com> wrote:
> > > >>
> > > >> The implementation of LOOKUP_HANDLE modifies the LOOKUP operation =
to include
> > > >> an extra inarg: the file handle for the parent directory (if it is
> > > >> available).  Also, because fuse_entry_out now has a extra variable=
 size
> > > >> struct (the actual handle), it also sets the out_argvar flag to tr=
ue.
> > > >>
> > > >> Most of the other modifications in this patch are a fallout from t=
hese
> > > >> changes: because fuse_entry_out has been modified to include a var=
iable size
> > > >> struct, every operation that receives such a parameter have to tak=
e this
> > > >> into account:
> > > >>
> > > >>   CREATE, LINK, LOOKUP, MKDIR, MKNOD, READDIRPLUS, SYMLINK, TMPFIL=
E
> > > >>
> > > >> Signed-off-by: Luis Henriques <luis@igalia.com>
> > > >> ---
> > > >>  fs/fuse/dev.c             | 16 +++++++
> > > >>  fs/fuse/dir.c             | 87 ++++++++++++++++++++++++++++++----=
-----
> > > >>  fs/fuse/fuse_i.h          | 34 +++++++++++++--
> > > >>  fs/fuse/inode.c           | 69 +++++++++++++++++++++++++++----
> > > >>  fs/fuse/readdir.c         | 10 ++---
> > > >>  include/uapi/linux/fuse.h |  8 ++++
> > > >>  6 files changed, 189 insertions(+), 35 deletions(-)
> > > >>
> > > >
> > > > Could you explain why the file handle size needs to be dynamically =
set
> > > > by the server instead of just from the kernel-side stipulating that
> > > > the file handle size is FUSE_HANDLE_SZ (eg 128 bytes)? It seems to =
me
> > > > like that would simplify a lot of the code logic here.
> > >
> > > It would be quite a waste if one only needs something like 12 or 16
> > > bytes, wouldn't it? 128 is the upper limit, but most file systems won=
't
> > > need that much.
> >
> > Ah, I was looking at patch 5 + 6 and thought the use of the lookup
> > handle was for servers that want to pass it to NFS. But just read
> > through the previous threads and see now it's for adding server
> > restart. That makes sense, thanks for clarifying.
>
> <-- wakes up from his long slumber
>
> Why wouldn't you use the same handle format for NFS and for fuse server
> restarts?  I would think that having separate formats would cause type
> confusion and friction.
>
> But that said, the fs implementation (fuse server) gets to decide the
> handle format it uses, because they're just binary blobcookies to the
> clients.  I think that's why the size is variable.
>
> (Also I might be missing some context, if fuse handles aren't used in
> the same places as nfs handles...)

I think the fuse server would use the same NFS handle format if it
needs to pass it to NFS but with the server restart stuff, the handle
will also be used generically by servers that don't need to interact
with NFS (or at least that's my understanding of it though I might be
missing some context here too).

Thanks,
Joanne

>
> --D
>
> > Thanks,
> > Joanne
> >
> > >
> > >
> > > Thanks,
> > > Bernd
> >

