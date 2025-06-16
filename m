Return-Path: <linux-fsdevel+bounces-51748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2947ADB055
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540AF167C57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F6C285CB7;
	Mon, 16 Jun 2025 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5xPsvgh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB71DA60F;
	Mon, 16 Jun 2025 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750077411; cv=none; b=XsE5VM2DQru6CNQgxCIUQ/UkRhblaguS7F93+0OnUFnjMERPxhdWIKjuImCftsNPjWWJMYcUd8yzTgpGm/DsAAFMx7dMLuxkDDzrzxQqefI5vTV4uczcxl733aZUFGRba8Z+B4FJfqP21fX306HRaW/r76ZF1/gvm93EVyuvACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750077411; c=relaxed/simple;
	bh=E812hfW0406H7NvFemlbqsEst1Zn896sqSoWky92NWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b47bSH3C+weiQBxSUmw4xwzy87fItgg+lFDSAwY9ST+RzGzvicHDGzyCG85SCH2EwZ5KcAEsiZNU0uEqNNAoW8NghTrz2uaz8IzGvkhsScn3UmowuIUEtuMxYOnQl9YaJ2bI69gCTkD0GEwVa83xv0zkiPlfy75w2pdrhj6fFPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5xPsvgh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6084dfb4cd5so10470266a12.0;
        Mon, 16 Jun 2025 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750077408; x=1750682208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E812hfW0406H7NvFemlbqsEst1Zn896sqSoWky92NWE=;
        b=V5xPsvgh3tcpR+anNWUOUNelqTHl/4q6bumUr5vqdW/mzPcxseHZxe6N4FDs13Wl9h
         a+EsFpIT1Oxaq0NTbxBidkEWTaucmcivjymPlikoo6UTEYZF56DQDGqL+Qd1K1Yr+IpQ
         z+Oi9Ler1tt58ek4YRMgcOX/I4l1f2hNp/M3Aw0zM+9hH4EKM7jyrZDvVSpurxoDUF4y
         q02SI3uAq8HxZj6z5yg20GTrzZOP/wU62dzrOkUtz7JJaOwiyvjPOGeRsNc6lmsqDt7k
         PP090xOWF60g8Ou6gwUv69PdXJVySwCxJ1B5yDm55ZOXOp6NB1ykX/CYtisfqwUzrAqn
         gqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750077408; x=1750682208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E812hfW0406H7NvFemlbqsEst1Zn896sqSoWky92NWE=;
        b=G5mHH1brfvBoyKvFid+rR2sAEbpp/qg1g7cvk+10j1lNzkLq7fGsrYgbK4hc4XvAS7
         u2BMPWNHAT+3Csa7nifbwZj2DX4reJx9DXGm0oaFxTEeIAsEzM7iDIZ2dvGLN3DHWY4/
         o/HvMuOoad0l+raxsWqrm4ykKDqU2yiUJFCRmDphrs+NzNoqyHcUMkjpcioTQWoLs3uM
         +V6Y6b0SixCsXWxiVwG27gYmf5iw+7Y2jOPMs/nHa8a/pfk2LeYWWkOvcvtwrdeo8lzk
         NjBmdYgr02EG3i4TR/usj05ZjhbShl8Es8P7Ym9TvHUdPyNf/n3y/SkhpULsk/j78AOI
         +aSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6gDz/lDyUHEvGKzkc7DaQ4jSJUpjvI4E31miGhqypFTqyXHQOTfMZvjalDhTBFeVD7+9TDbOnL3W5nBqX@vger.kernel.org, AJvYcCXq+aOTUe+Ei2SXRd+4v/ffBkb/uToHj9/mL8lTPoMzaQ44blvxJmdr56ed883s0pTabZJoTMIvxUnnYjjIJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPc1YR5K8oU+xtN6Nh0BtqPP3zcWgyF/KFW8+pMhd4E/E0LQdR
	PQVdYsZVHwm/N4QVHH221i3jRFCbVaaqCvM1DklPhLAK+pI9qxFABh/vm7EpDgu3afGC3at8fiF
	HwOfWKw6BlJGdxt7OMBausaaBmLfG6oUBcwrG
X-Gm-Gg: ASbGnctoWs0cl8F4JkzY4yWKG1x2YMu1V5QDnCVt2vU3vUf4275NJ5NGmfyiMpq8tdi
	dCibMhAu9K+0TBFR3wHdUtRJ+NmAcEhWxfVZQD0n6FHyks7Vqk4BDc3kuWJ0TpliIV2ht1dxf/D
	GUqyhDRW+3bM/O/sRgsdYvFI+JKXMePExkxRd9QTFuGZ7PVlJlkbLL7A==
X-Google-Smtp-Source: AGHT+IEKnITYkZ0BbDFFkInZp+lXLg0CNCwGyTee9uLelkteIZSsJo1E8MvhlyzRYchzVnxcwbcCjZ5EGi3rKDEoPEw=
X-Received: by 2002:a17:907:94cf:b0:ad5:2e15:2a7b with SMTP id
 a640c23a62f3a-adf4c6f7f43mr1055505466b.2.1750077407237; Mon, 16 Jun 2025
 05:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602171702.1941891-1-amir73il@gmail.com> <oxmvu3v6a3r4ca26b4dhsx45vuulltbke742zna3rrinxc7qxb@kinu65dlrv3f>
 <CAOQ4uxicRiha+EV+Fv9iAbWqBJzqarZhCa3OjuTr93NpT+wW-Q@mail.gmail.com> <bc6tvlur6wdeseynuk3wqjlcuv6fwirr4xezofmjlcptk24fhp@w4lzoxf4embt>
In-Reply-To: <bc6tvlur6wdeseynuk3wqjlcuv6fwirr4xezofmjlcptk24fhp@w4lzoxf4embt>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Jun 2025 14:36:35 +0200
X-Gm-Features: AX0GCFsHr5rlhCCrUcgXUFXdYjUoJyomh7PGebK8pa8g8I6tv7CG_cnQRPhPls0
Message-ID: <CAOQ4uxiYU_a_rmS9DBOaMizSFVsbiDQBRcf4-f=8hmL-TGbwxQ@mail.gmail.com>
Subject: Re: [PATCH v3] ovl: support layers on case-folding capable filesystems
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 2:28=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Mon, Jun 16, 2025 at 10:06:32AM +0200, Amir Goldstein wrote:
> > On Sun, Jun 15, 2025 at 9:20=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Mon, Jun 02, 2025 at 07:17:02PM +0200, Amir Goldstein wrote:
> > > > Case folding is often applied to subtrees and not on an entire
> > > > filesystem.
> > > >
> > > > Disallowing layers from filesystems that support case folding is ov=
er
> > > > limiting.
> > > >
> > > > Replace the rule that case-folding capable are not allowed as layer=
s
> > > > with a rule that case folded directories are not allowed in a merge=
d
> > > > directory stack.
> > > >
> > > > Should case folding be enabled on an underlying directory while
> > > > overlayfs is mounted the outcome is generally undefined.
> > > >
> > > > Specifically in ovl_lookup(), we check the base underlying director=
y
> > > > and fail with -ESTALE and write a warning to kmsg if an underlying
> > > > directory case folding is enabled.
> > > >
> > > > Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > > Link: https://lore.kernel.org/linux-fsdevel/20250520051600.1903319-=
1-kent.overstreet@linux.dev/
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >
> > > > Miklos,
> > > >
> > > > This is my solution to Kent's request to allow overlayfs mount on
> > > > bcachefs subtrees that do not have casefolding enabled, while other
> > > > subtrees do have casefolding enabled.
> > > >
> > > > I have written a test to cover the change of behavior [1].
> > > > This test does not run on old kernel's where the mount always fails
> > > > with casefold capable layers.
> > > >
> > > > Let me know what you think.
> > > >
> > > > Kent,
> > > >
> > > > I have tested this on ext4.
> > > > Please test on bcachefs.
> > >
> > > Where are we at with getting this in? I've got users who keep asking,=
 so
> > > hoping we can get it backported to 6.15
> >
> > I'm planning to queue this for 6.17, but hoping to get an ACK from Mikl=
os first.
>
> This is a regression for bcachefs users, why isn't it being considered fo=
r
> 6.16?

This is an ovl behavior change on fs like ext4 regardless of bcachefs.
This change of behavior, which is desired for your users, could expose othe=
r
users to other regressions.
I am not sure that it is a clear cut candidate for 6.16,
but I also don't feel very strongly this way or the other, so I will
let Miklos decide.

In any case, even if the change gets merged in 6.17, after the change
was exposed to the world for a bit and no regressions reported,
I have no objections backporting it to older kernels.

Thanks,
Amir.

