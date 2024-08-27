Return-Path: <linux-fsdevel+bounces-27372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821CA960C81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 15:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E3D1C22A73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 13:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4241BB6B7;
	Tue, 27 Aug 2024 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhBPZsBP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB019DFB6
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766508; cv=none; b=gNdBhDLK0I5wkbV7/xJ+FKhRvsXdGbCJr4wL1Yfqf/enoSnxYtmDGvioG51BIbuNP/f0XvqNvq9UguILdzWhpSyW+9EJA5V57Rlyabx+ql3oIrT4zc/VOhgaoAbAXE+5G+oVZvAhOGFKW5JWl1Ja6f4Gvhj9ShzY4mMjPFQK1oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766508; c=relaxed/simple;
	bh=Lgh8g6IfrFfgeR8zFlBnZ+Givhs1MuWh0NCD29+wV08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sugUzwHa5LOY7uci3psRaKheJid90YfVTir+YUUqo+bOho+hRddcx/uxkl1Zvr62xCoxMhS4Hz+yrrV/lh7rkod2Q3EHeGwEQ38RnVY0q+mnS9RE4Aa1UX0B29ci8/VFul1SoSj5oYciAhMYvBk9yregfQBRmv7wxMInKTJGb3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhBPZsBP; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6bf6755323cso32253896d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724766505; x=1725371305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAyAnVrIGiz6Qj54k2/PY2+oA2UtriB4fEhkDK/1RnA=;
        b=XhBPZsBPqdUzLpcVGgFtjg/A50lpSPUixlV01+b7ussgKZ5iN2zU8MRM9Gc4Tgfrx3
         cPK2SLtIYaO5tcMuWmkCgMafcZbNPTds0erhuwGudMlN9tNq5xE6ebMqrkKh66MNpZLR
         UBdajbZO/sXwz9GlHpNX8qYIPLBHtKVw3s7Oe8BLgtL4yLCrt7QPasDtul8rzCYPirT1
         HVNNNOCAEbFpU/pNG9yzgKpdw1q7jNUAYC7hqIk/jAhZl0WCVkkXsvpcbcDKGwzTX51h
         z93Yt7jAOGMvihs3a316B5BqxVMbK8Qu+9HhefaO+w0HCR0vOkoMPLfWHEc98lJbiuNh
         Q27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724766505; x=1725371305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAyAnVrIGiz6Qj54k2/PY2+oA2UtriB4fEhkDK/1RnA=;
        b=W0J9WrkQySlOxkRdJ0kZQ7/nPRT4YydnkwyobR7EgstbjnDcyTeqX34IF4wukBbPvC
         p+xPWAFayZraoOV7/Kh1U8WMqMMrZNPgFw+6NAuTvURiYusi1oGiFETl/ovOIoxiq4mt
         f3cVkfbztTyIZ+q/CEeq+n0hfKUtzowQkrVi47BmXINz2eZVGkAgntqQXs2EbCzMahCd
         fxRf+GX4cbLJEMrV+1sCmDfpqljfUCXBOAKp7Su8gPww+hQ77XdrcysVAafjgk28r5yd
         vA3ghdjGlph4HC7lU6Io3t3Pq05UEJFHU9jSTmb/Sf9t3m81aBfPddgWDLa9q1o+O+bE
         KEbA==
X-Gm-Message-State: AOJu0YwoUCVwXWfyw6ha45fgZZkIbb2Jx+/fSZTRkC6H1r+G1hKhONUd
	ltBMF/R1y8/qJwxfoaVE2EcL+YLPphfSE0sBdwSbMX8qpRpVjLs47nxm3G1p/lGEibddUVsl5FA
	Hco7t7tb1RLH9q0RfkTWSxIQDVoheTbncMro=
X-Google-Smtp-Source: AGHT+IF4QTLE8uQ3u5gvN+mGbzuOKSiapzDNxDYnwbkS5Xfr3xBJoOln0OTwU1riz+7/4GteV1U/g3C2utCiHwl+vsI=
X-Received: by 2002:a05:6214:311c:b0:6bb:7a04:3408 with SMTP id
 6a1803df08f44-6c32b695ea0mr30195656d6.11.1724766505409; Tue, 27 Aug 2024
 06:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bB3C_zbpq6U+FdrjbwJAOKFJk1ZLLETrR+5xqRmv44SQ@mail.gmail.com>
In-Reply-To: <CAOw_e7bB3C_zbpq6U+FdrjbwJAOKFJk1ZLLETrR+5xqRmv44SQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 27 Aug 2024 15:48:13 +0200
Message-ID: <CAOQ4uxi=9WpKFb24=Hha_mwj9=bsj9qxiv0f0Z-FMfuBRCvdJA@mail.gmail.com>
Subject: Re: FUSE passthrough: fd lifetime?
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 11:42=E2=80=AFAM Han-Wen Nienhuys <hanwenn@gmail.co=
m> wrote:
>
> Hi folks,

Hi Han-Wen,

For future reference, please CC FUSE and libfuse maintainers
and FUSE passthrough developer (me) if you want to make sure
that you got our attention.

>
> I am implementing passthrough support for go-fuse. It seems to be
> working now (code:
> https://review.gerrithub.io/c/hanwen/go-fuse/+/1199984 and
> predecessors), but I am unsure of the correct lifetimes for the file
> descriptors.
>
> The passthrough_hp example seems to do:
>
> Open:
>   backing_fd =3D ..
>   backing_id =3D ioctl(fuse_device_fd,
>      FUSE_DEV_IOC_BACKING_OPEN, backing_fd)
>
> Release:
>   ioctl(fuse_device_fd,
>      FUSE_DEV_IOC_BACKING_CLOSE, backing_id)
>   close(backing_fd)
>

If you look closer, that is not exactly what passthough_hp does.
What it does is:

Open #1:
   backing_fd1 =3D ..
   backing_id =3D ioctl(fuse_device_fd,
      FUSE_DEV_IOC_BACKING_OPEN, backing_fd1)

Open #2 (of the same inode):
   backing_fd2 =3D ..
   /* No ioctl, reusing existing backing_id for inode */

Release #1:
   /* No ioctl */
   close(backing_fd1)

Release #2:
   ioctl(fuse_device_fd,
      FUSE_DEV_IOC_BACKING_CLOSE, backing_id)
   close(backing_fd2)

Not necessary.

passthrough_hp needs to keep backing_fd open because of
operations that are not passthrough.
It does not do that for keeping the backing_fd object alive.
Only the ioctls manage the lifetime of the backing fd object in the kernel.

> In the case of go-fuse, the backing_fd is managed by client
> code, so I can't ensure it is kept open long enough. I can work around
> this by doing
>
> Open:
>    new_backing_fd =3D ioctl(backing_fd, DUP_FD, 0)
>    backing_id =3D ioctl(fuse_device_fd,
>      FUSE_DEV_IOC_BACKING_OPEN, new_backing_fd)
>
> Release:
>   ioctl(fuse_device_fd,
>      FUSE_DEV_IOC_BACKING_CLOSE, backing_id)
>   close(new_backing_fd)
>
> but it would double the number of FDs the process uses.
>
> I tried simply closing the backing FD right after obtaining the
> backing ID, and it seems to work. Is this permitted?

Yes.

BTW, since you are one of the first (publicly announced) users of
FUSE passthrough, it would be helpful to get feedback about API,
which could change down the road and about your wish list.

Specifically, I have WIP patches for
- readdir() passthrough
- stat()/getxattr()/listxattr() passthrough

and users feedback could help me decide how to prioritize between
those (and other) FUSE passthrough efforts.

Thanks,
Amir.

