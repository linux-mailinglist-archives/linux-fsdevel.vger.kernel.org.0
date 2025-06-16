Return-Path: <linux-fsdevel+bounces-51716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915FFADAA3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 10:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310313A480F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 08:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B0420C497;
	Mon, 16 Jun 2025 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exIiur6r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E761DF271;
	Mon, 16 Jun 2025 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750061207; cv=none; b=TLzMFMZYsK9a7ftIvdybTNFKPhNv2GHPTO937buSVolq2LLbqf27+VufaUJqTfAHAtlLsMjDTFCUfrrHjihlO1WoHCs5ots7FX4+R/R3Ez3qKEuCNhnT3AGjaZEpmFKK0p6kIr3Psu+rTWZooNYApwICvaqIqBZXJf6ypVWnxm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750061207; c=relaxed/simple;
	bh=9b3yr9/fU38j4jGwczwOwRj64uUfu0bNpRnOd0HP2Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtXoKiK1Hs4/CHUCXueH23jFjvl0qLkZzUT8KPQknxnjDlBG5J0xd1Tz/rBWVeBcA9zez/sMHdmCrTSFZIUUXv7qZ6Mv8j4pAUQ/pCpF8ldV+WDBfqToetT+ktiptCq2te/yEZBZ62rCCL92nP60WILYz12ojI9z6JprlKy6/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exIiur6r; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad883afdf0cso822181366b.0;
        Mon, 16 Jun 2025 01:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750061204; x=1750666004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9b3yr9/fU38j4jGwczwOwRj64uUfu0bNpRnOd0HP2Go=;
        b=exIiur6rdgKNqgjWqqG32sC/H2UTKEq+jKkzaL1vxEsvK9UHtbjuN87jja+qdr26SD
         jQHQFWzC6uEEIGIEg7KPzw5ocudtEKCzZao2gBm4NiW3wNKmFBlia57r4cWqWdDUan9g
         nYTd40u6uk4JMCsRctdYdOt4dOTDh1L542PCkbRjo7YZH6gf7kTH4P+MWNE7zWi1zNXa
         Hb/+gAwLgbbDaHlFcPJgw4oXOT4wjaOT6lfi5GsBsuztSg8eRHb3ZTxoZ/h2d7bV4dqX
         03uSV4/9jiml1wUeEsX77nb4rPjpiZyNWVbzBACMRNmmfKuk7ZWU2OjU6N5txoIWiIij
         lh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750061204; x=1750666004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9b3yr9/fU38j4jGwczwOwRj64uUfu0bNpRnOd0HP2Go=;
        b=anWuiKs/Fzu38Rv0QCTiZtIAyR8z2rloHEyd2J+cVT8sW98V5TlXZ9RW5uXrJrB2zs
         y4TesoS/d3iohBCwdEHPRYHnGgi9rOnd0w8AuDZ/hZpzi+vd+bY8ilUo5zuwTJsp7NF+
         bHXU3w1cmZYfL5GRp/S7cv6/2+kJueqPpsnNHEoGp8kLMeS1hkY5RDADdDs/SgkQQS7H
         brZ56mrYmUv1hiinMQMNHjG9HfNQ06dz6W0eNiru6h3eCE7YyKUJFOcPGtSDWysbGKQi
         Urf7gyebph1BNwkUUU9A4J9dZjx78DblH45BUbQmmwmS58u99aVo5nHZLq7p0ynjrz79
         JhjA==
X-Forwarded-Encrypted: i=1; AJvYcCW1gHAG16EFxekpOzyV3e/DjmPSrmqP+jLURjQ78uT/M+ecAAWRwjh+pP5gqtbsohGX2WLdeIgdzUU7VSKt2g==@vger.kernel.org, AJvYcCWB4h8W2MdZmvCDFe9kB7fNSo/d5cO2KoRlWDUGKxmOz50PfzVefJB3X0PIgTtrmkCMStCMfmWJgFH6AUng@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJpaYVLDyo4hN3rC5JoGDIubygkExt9/rwWihTUtDuGHpj3eG
	BtSIx2ye6f9V4XRoE43oBiWzWFUAAkSqfEoSmX6uL7cvT1Xb1SFTNfWZMXheu27Om+QzZ3fQbR5
	meP0BoTjG9IZpYGVAiObWxrJBafnSHg4=
X-Gm-Gg: ASbGncuGNemK3btLeLAhYk1TbKDfQ3GQfLUdVjugmH3j5uAwhRxn0gXNlaa0afCoVDW
	iqtczfDmN7FAb5aYYVn5cdXAQ+bNabc3zqo2zWzv7SMuk0hTvfXGfOo0V0C5ERCbYa6lUKzAdSV
	K/qLLc/yLWB76NPwOBvr652fNZ40gnMyQGHPXzfhgk7X8=
X-Google-Smtp-Source: AGHT+IGHxUceeoxNpJtKKM9dmzRSszHDyZ3AAXPhNVbpdJRhBeeIWJNS7i4KLtneasqEt+iuVM5Ser1gNHJlJ2E6evI=
X-Received: by 2002:a17:907:dab:b0:ad8:9428:6a3c with SMTP id
 a640c23a62f3a-adfad31ccc4mr795455266b.11.1750061203209; Mon, 16 Jun 2025
 01:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602171702.1941891-1-amir73il@gmail.com> <oxmvu3v6a3r4ca26b4dhsx45vuulltbke742zna3rrinxc7qxb@kinu65dlrv3f>
In-Reply-To: <oxmvu3v6a3r4ca26b4dhsx45vuulltbke742zna3rrinxc7qxb@kinu65dlrv3f>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Jun 2025 10:06:32 +0200
X-Gm-Features: AX0GCFuXVPh2CUexzoY1r3neBevRJzG35z8EW0jz0GKdX06N8brw-rPOsVDBNyo
Message-ID: <CAOQ4uxicRiha+EV+Fv9iAbWqBJzqarZhCa3OjuTr93NpT+wW-Q@mail.gmail.com>
Subject: Re: [PATCH v3] ovl: support layers on case-folding capable filesystems
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 9:20=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Mon, Jun 02, 2025 at 07:17:02PM +0200, Amir Goldstein wrote:
> > Case folding is often applied to subtrees and not on an entire
> > filesystem.
> >
> > Disallowing layers from filesystems that support case folding is over
> > limiting.
> >
> > Replace the rule that case-folding capable are not allowed as layers
> > with a rule that case folded directories are not allowed in a merged
> > directory stack.
> >
> > Should case folding be enabled on an underlying directory while
> > overlayfs is mounted the outcome is generally undefined.
> >
> > Specifically in ovl_lookup(), we check the base underlying directory
> > and fail with -ESTALE and write a warning to kmsg if an underlying
> > directory case folding is enabled.
> >
> > Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Link: https://lore.kernel.org/linux-fsdevel/20250520051600.1903319-1-ke=
nt.overstreet@linux.dev/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Miklos,
> >
> > This is my solution to Kent's request to allow overlayfs mount on
> > bcachefs subtrees that do not have casefolding enabled, while other
> > subtrees do have casefolding enabled.
> >
> > I have written a test to cover the change of behavior [1].
> > This test does not run on old kernel's where the mount always fails
> > with casefold capable layers.
> >
> > Let me know what you think.
> >
> > Kent,
> >
> > I have tested this on ext4.
> > Please test on bcachefs.
>
> Where are we at with getting this in? I've got users who keep asking, so
> hoping we can get it backported to 6.15

I'm planning to queue this for 6.17, but hoping to get an ACK from Miklos f=
irst.

Thanks,
Amir.

