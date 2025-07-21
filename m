Return-Path: <linux-fsdevel+bounces-55618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D10B0B0CB48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 22:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF067542B22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DC6239E65;
	Mon, 21 Jul 2025 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/eK7e00"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B4DEAC6
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 20:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128316; cv=none; b=FyTewxP8uMjRX7GYNVRid/LG6vaTcBsUl0lKeNZnxeRTnFLEtcAHr6OARlDvq5YTwyywiFAPCJ6hND4TVlmCVQFj52lqeKhWf1kWvuWQRFKoHmL15jOwKJyPw0isw9uPqxhEEuwgkijUri8rnH6ACjq8DKGG6XjbTOamcnOv/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128316; c=relaxed/simple;
	bh=74RpbiNARy5I8QMBe4QXTHNQ33XHrtQ4VNqLN5P9868=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahrzHIKtJuIfZ3drmcaoLSzzyIqvPZgIjaHkHvFCL8SoFH6mGzayG38xnijFTzBMjVmgNxL7TeynLshoEkNqHK4iA6GKIwtOpISGQ2jBGZlvA9HD/U6wvgUyE30dDTGqCtPahnX7kEycI8n1rQrfozdF3oXEIlqhYB626vI+3ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/eK7e00; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab5953f5dcso49472481cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 13:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753128313; x=1753733113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBX8V/+8DvQNYAdpuKWkUSxtQEyo22tkhOckHWPHiX8=;
        b=U/eK7e002nnrAAybn5GOBCpo3dP4aK/pi80M7QCsgflgCDdLQJgl/f07OFv6svAGWD
         V+NkowBY1xZRi1e0A3V8tedsI5LgoMN79fQGNsvS5fHK9f4NIbHRU2lzktyC+zbxH5RA
         /U9cIXrDebrfjs/QguoVqso4ksNS2XHweVySqVm9DUVYqR6veMDQN+J1vqihbhtLhna/
         W/8vW7zm4EKlDF2b5Erg/MX2H9TCM9cq1hv0ln+j+WEMc643km+YUmQ3S7av5I6pUL3y
         S88Bmw9A7/d304IyRXBE+VJTyi2LZ2kx+al9OuWAnJy2VvlmjzyghsPIWOf4K47bm/b6
         /X/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753128313; x=1753733113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBX8V/+8DvQNYAdpuKWkUSxtQEyo22tkhOckHWPHiX8=;
        b=FnV+Y4aENAjMSJkaxkofRB/2XEXD6NlOnbT8+kZcwKT/i4KE2n36VF9hD5UMBYCcsY
         1+PupzJ0BDFM5Nx6aU70tQs1aZa0+9YCoG+i9cXvfqXyFZv+FQkL13o+PD8Ci3ft7WFO
         r+3FXK6cmt6/mQbZCXx2E1NhGhS7d9+RdSGYNoJaPhmRfCechwqymgcqWXuB8jIMMxer
         UeOsri6Y56ktxH5WFWyd0S5/v0ez+Kkwwd0IWZGY7AyTyrQgm62LGXJQU/0kXVYM6ViX
         zne0cWRlmUafDnmpCMAMVvT5IbDEfBI1+IwbrKwy59GDeJpyoWQxoAKMuHAKpgUh+DcZ
         Elvw==
X-Forwarded-Encrypted: i=1; AJvYcCVnWsCT2bcPIOJragj3cw+LM1tMTRv4bTrXa5Ss+iBs/dzm6lIhPE9xbDXfvCPSKU+GSqq214IZV90Qvc7w@vger.kernel.org
X-Gm-Message-State: AOJu0YzdqwJ3Wr1eq50BHBhAR8teWqXXaFbZjQ0vvuaDOrsy6aIeqYjP
	JxUT7ehkqYdo3bWyCZmnVLSpBscPdCy/xy8cdi8aiEcNcQbB4ZOFsCFyT5fZOAez7f257hhfA8S
	l+gocXZ4P9VmcZ91tfO5ljPauRyqCXpo=
X-Gm-Gg: ASbGncvH8hJBTf0bFsHxrfop49+VBe7mUxFLfQv/VA3V61t/cj0gad5gkj0awga+2gw
	xjSAvK1cfj9crVx5foYI87U1Po+QO3BglVEkZ5I64Z5+34FMET6tuU55s60xhK7P1B2L3H6bVVb
	jCDl/eGa0+WcwITI3Ps0e1gAF6GgS7EU4GoPbYKQ0d00VdNKLbuuXOHvRqEfioHRuAWDmOoG8eD
	CwGH4Y0V0hu7ltbVjzvtw==
X-Google-Smtp-Source: AGHT+IEa8BgaJ7iJYA6pQ+EITDiEmHkFLsE/ueXidJwjFR2j6MP1Om8J0CnZs8Lk/KOfckoWjdpx6OYegnmw4g4cAM0=
X-Received: by 2002:ac8:5d43:0:b0:4ab:8862:7fed with SMTP id
 d75a77b69052e-4ab93d47dccmr266435591cf.30.1753128313232; Mon, 21 Jul 2025
 13:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
 <CAJnrk1YeJPdtHMDatQvg8mDPYx4fgkeUCrBgBR=8zFMpOn3q0A@mail.gmail.com> <CAOQ4uxj1GB_ZneEeRqUT=fc2nNL8qF6AyLmU4QCfYqoxuZauPw@mail.gmail.com>
In-Reply-To: <CAOQ4uxj1GB_ZneEeRqUT=fc2nNL8qF6AyLmU4QCfYqoxuZauPw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 21 Jul 2025 13:05:02 -0700
X-Gm-Features: Ac12FXyE7KgM1aUD9fK4gRCMPhTKyr8XcJLAUyf8skDL68B4PXWDd-qe0wrI0Eo
Message-ID: <CAJnrk1bE2ZHPNf-Pu+DBnOyqQWU=GZjvB+V-wvguszSwZTF0cQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the connection
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	John@groves.net, miklos@szeredi.hu, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 12:18=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Sat, Jul 19, 2025 at 12:23=E2=80=AFAM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> >
> > On Thu, Jul 17, 2025 at 4:26=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > generic/488 fails with fuse2fs in the following fashion:
> > >
> > > Unfortunately, the 488.full file shows that there are a lot of hidden
> > > files left over in the filesystem, with incorrect link counts.  Traci=
ng
> > > fuse_request_* shows that there are a large number of FUSE_RELEASE
> > > commands that are queued up on behalf of the unlinked files at the ti=
me
> > > that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
> > > aborted, the fuse server would have responded to the RELEASE commands=
 by
> > > removing the hidden files; instead they stick around.
> >
> > Tbh it's still weird to me that FUSE_RELEASE is asynchronous instead
> > of synchronous. For example for fuse servers that cache their data and
> > only write the buffer out to some remote filesystem when the file gets
> > closed, it seems useful for them to (like nfs) be able to return an
> > error to the client for close() if there's a failure committing that
> > data; that also has clearer API semantics imo, eg users are guaranteed
> > that when close() returns, all the processing/cleanup for that file
> > has been completed.  Async FUSE_RELEASE also seems kind of racy, eg if
> > the server holds local locks that get released in FUSE_RELEASE, if a
> > subsequent FUSE_OPEN happens before FUSE_RELEASE then depends on
> > grabbing that lock, then we end up deadlocked if the server is
> > single-threaded.
> >
>
> There is a very good reason for keeping FUSE_FLUSH and FUSE_RELEASE
> (as well as those vfs ops) separate.

Oh interesting, I didn't realize FUSE_FLUSH gets also sent on the
release path. I had assumed FUSE_FLUSH was for the sync()/fsync()
case. But I see now that you're right, close() makes a call to
filp_flush() in the vfs layer. (and I now see there's FUSE_FSYNC for
the fsync() case)

>
> A filesystem can decide if it needs synchronous close() (not release).
> And with FOPEN_NOFLUSH, the filesystem can decide that per open file,
> (unless it conflicts with a config like writeback cache).
>
> I have a filesystem which can do very slow io and some clients
> can get stuck doing open;fstat;close if close is always synchronous.
> I actually found the libfuse feature of async flush (FUSE_RELEASE_FLUSH)
> quite useful for my filesystem, so I carry a kernel patch to support it.
>
> The issue of racing that you mentioned sounds odd.
> First of all, who runs a single threaded fuse server?
> Second, what does it matter if release is sync or async,
> FUSE_RELEASE will not be triggered by the same
> task calling FUSE_OPEN, so if there is a deadlock, it will happen
> with sync release as well.

If the server is single-threaded, I think the FUSE_RELEASE would have
to happen on the same task as FUSE_OPEN, so if the release is
synchronous, this would avoid the deadlock because that guarantees the
FUSE_RELEASE happens before the next FUSE_OPEN.

However now that you pointed out FUSE_FLUSH gets sent on the release
path, that addresses my worry about async FUSE_RELEASE returning
before the server has gotten a chance to write out their local buffer
cache.

Thanks,
Joanne
>
> Thanks,
> Amir.

