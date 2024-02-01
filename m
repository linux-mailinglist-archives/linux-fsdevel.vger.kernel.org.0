Return-Path: <linux-fsdevel+bounces-9890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CDD845CCA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CAF6B2F90D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F406626B6;
	Thu,  1 Feb 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw6K3Rcf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0792677A06
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803001; cv=none; b=u8m8Ug7RJyvM8MpAatLpxnU/MIQyypOLDV0Bb4tQ8qdpj4dovvHOxbVeGFkWjL1TcZMbiUYhf7MWzXCQXWkPw9YEdViDZMp6ZeERTQJucyOwFAm//pfbTi8pLA45hWDplE25GANQFYdfwWE7KbdTc7xULgnJKpUt24DCzYOD6aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803001; c=relaxed/simple;
	bh=FCFhufrhWHHryrZvvdumI8famv+DtWFegTEUE1hnBN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKNF1/Dp7Kg2F0zqASybjeVRAAPqUHWRkBNhO8Vqq0mvjD605hqRNHTQHdWcVBelfiY5XapHCC3cdxW28aUVTCm8CJCiZj6k4O3H6OYOvrjs/NnMB0NpWVFs0V6moOizHXjaMmtHX1tsVVvR3ZxkflwvWEqlvtdWuIySNrqTd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw6K3Rcf; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc236729a2bso1063970276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 07:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706802999; x=1707407799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCFhufrhWHHryrZvvdumI8famv+DtWFegTEUE1hnBN4=;
        b=Rw6K3Rcf5iV8hz9Jbbq9pZaJt/x5x2mDuPKpqRbBoBZWOHGmzGIXE2SPa/F6cK2+yA
         B2KOTG8moQDmxUayqN1OyoW1CpFrHEPPME7/S2LxujCuYMlNa45IIJw+KiAMv9I8is6D
         M85UVjIURxc0nIGac+UXavMr36tY25CRhEYwgLjsRexyw3DWTbd0G1mg5hmK0PuhYnA/
         i83T7ExwRTJbHaULRkS/+nbeGLQhiFhJAq/sbcAhB54FSZI8hchS3Vqwp3WTrIRlvD6v
         DlyOCIXG8RtT63gefwxTN0Rlrc0iQxPydqHaJL9MWDrGV6x1lZZSd83SLENGf/cvQbHb
         Cqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802999; x=1707407799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCFhufrhWHHryrZvvdumI8famv+DtWFegTEUE1hnBN4=;
        b=BWVvVUP8VOnxA9Fno8VJ9YOM402kIrq/JNx6xLtaAdHfDn+NCEU0AG/1K7bQz0QrDg
         0wwAmHsmyBg2p0TTIlZ6kpXaNejP2A24dtFqXDk4kDYKfYxZJA5UPSHPJifTMoNH7Xq7
         u5tZVe+w3NSYD4+uF7B7llFlnCeWYELNYy5IfsytTv7u1eH/GbX8Q9QG3uCKaHyFlH0Z
         PMiSdIR9AmXUKkGX9xJcuh8Nexby/Ok1JvW/AdCVNqe6RVnRozbaXD2QYSeRjuAgMOju
         5FcUtjrBpA9KCE4xgp5hzrWV37HL67h3MuYsm5lm5cqAbHsheqXgC5yrVPixo2Rm4K4R
         yaEQ==
X-Gm-Message-State: AOJu0YyqyrZlunMTn1RpwrQv4rEdbtFhTRZDCaluDvyuPm3Y5Ndw+v4a
	z5NJTrEzSyoZFeV+VCyRPOkB7zcvQVRphqI/T9bXFkaE3VhOxL1lqzCsEVj899wOU/+zikYonaO
	B9CV+dk8SZP0MMoJ7hMbi6Z5JbA0=
X-Google-Smtp-Source: AGHT+IFjwxim1iQlzuxMdMgjvdDwoJhq0BNCb4jXelvmgV3696HY8U+tLhL5aea0WpkxG7BVeS7aqq4yxewkuAQVOTA=
X-Received: by 2002:a25:8742:0:b0:dc6:3a84:2aae with SMTP id
 e2-20020a258742000000b00dc63a842aaemr2481053ybn.42.1706802997429; Thu, 01 Feb
 2024 07:56:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <CAOQ4uxi_SqKq_sdaL1nFgjqonh2_b910XOgMbzeY4aP1tj-qGw@mail.gmail.com>
 <7d194156-4763-42ea-b89c-e01be7d3e22d@fastmail.fm>
In-Reply-To: <7d194156-4763-42ea-b89c-e01be7d3e22d@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Feb 2024 17:56:25 +0200
Message-ID: <CAOQ4uxh5+v3NQK4=TJ7XfVtNCmNYMmAEKyASON6eJFP5OipJWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] fuse: inode IO modes and mmap
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Bernd Schubert <bschubert@ddn.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 4:30=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> Hi Amir,
>
> sorry for a bit late reply (*).
>
> On 2/1/24 11:30, Amir Goldstein wrote:
> > On Thu, Feb 1, 2024 at 1:08=E2=80=AFAM Bernd Schubert <bschubert@ddn.co=
m> wrote:
> >>
> >> This series is mostly about mmap, direct-IO and inode IO modes.
> >> (new in this series is FOPEN_CACHE_IO).
> >> It brings back the shared lock for FOPEN_DIRECT_IO when
> >> FUSE_DIRECT_IO_ALLOW_MMAP is set and is also preparation
> >> work for Amirs work on fuse-passthrough and also for
> >
> > For the interested:
> > https://github.com/amir73il/linux/commits/fuse-backing-fd-010224/
> >
> > Bernd,
> >
> > Can you push this series to your v2 branch so that I can rebase
> > my branch on top of it?
>
> Do you mind if I push this to a different branch to keep the branch clean=
?
>

I don't mind, I just thought that it would be nice if the branch fuse_io_mo=
de-v2
actually contained the patches that were posted as V2 to the mailing list..=
.

Thanks,
Amir.

