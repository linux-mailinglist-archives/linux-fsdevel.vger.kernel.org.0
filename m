Return-Path: <linux-fsdevel+bounces-51971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 666ECADDC6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 21:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE34D1940DB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 19:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A3C2EBBAB;
	Tue, 17 Jun 2025 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIvXlNt9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3484025CC55;
	Tue, 17 Jun 2025 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188786; cv=none; b=aGmgTKqT9b3gSd3+H3Zi1SRCSfYaSS55+l2He+kNI0UPDe1A5PtBC77RrA5zR/DTsH6hhtc+Lyy9w54FV5MqSTSlJoaHTLKmcWZ6oC0cDL3fs4EyyTatEO0SYskzJJsY9G9WDA8/IpuTsontFSJOEDjI4G65MJr0ZRCWhYRBG8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188786; c=relaxed/simple;
	bh=Aah+HSubQPUZAeKPHbnCgcwk4Pv9SienJRhWfGPoXVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWsLebQpS2haiET7OHa4tKIlpauQVT2mGy5Lckb6VJrthuyRiD1hP0ZzeIl/MOnMdUSO+WaXPaHa+fNOhsr6UB0Kk0rMrLwYbO0iHMuge8vZTaJXzIcgDyq7zsGXlwITwzQO4Qhi3LiZHWmfC2gb4N5wABjUkegUJeY+DikwzLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIvXlNt9; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a58b120bedso77055871cf.2;
        Tue, 17 Jun 2025 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750188784; x=1750793584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbe97D9Jmiian0+4yUZsYXhkQisqb/mr4o3dbA/bJbM=;
        b=eIvXlNt9iyF/mPArua6df1n3/rJuQ+pFsG1PPUuw6DLAa3Y2FZbIR1fQHAS+UNFX/i
         LR0Xa2OkVEh3jRuWxu63FZUpHOLyMtg938xHwqvohr/pksFtREV5WNLmeXt8JfjaWkdr
         0bkKN0iKqe2C6CJyDIpJllJVUfV514ltt3GlKgVkP4x5/807C5/HFukbvcHhzBIk6LQD
         Y38S0M5SL8iYUOOVZ1sZEQvJnMNKAVg8cyGdOxPJH2uyp+hs06R7smrFMwaAoe5dFFGJ
         /IgUenZ/pp1UX2RzaBqBM1A+fG/rV9dhiUpeBNkzNMNsmEdzVIWYVZ0TY41qeI3kDp7W
         qfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188784; x=1750793584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbe97D9Jmiian0+4yUZsYXhkQisqb/mr4o3dbA/bJbM=;
        b=XQHwrVsE1L2fJiQlIt6YiQqLeWf+6ukLoZaYRnQcQeqpblpEYRAnk/xfJFSuOXTHqN
         SVqBDlTbUlJBh5gXlfAl0Nj10sbaDF/nO2rRSvYbZhU1S+XpUHAd2a/DJexxFWQCah9/
         FyCEnBo+veA+ICv4iAdJOtFYEub62ZcZHCNhAZ/LN1k+59cRg+0R9eTvMGwx9s2vwEHy
         xruBtZ0fz60ocfgUVVOXDkyVqj0VpVFnIoVRfHAaSrrGf4PjLn9Hysx3toXgkdl0HlBr
         FDCskqUSIRTWzsmpGoHmMin6HZxXeKhOXmatmDEIZKFbjuxU+asH2/c4vzlgsJihXAs4
         dekQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRyK0lKh0YB6ABbnEQ7Lk6pIYNqbOTfKPFqBLTyPzQYPIUhGj29+u8OeiiVVsYQhJBsRqiMxK+l7cTe1BLHQ==@vger.kernel.org, AJvYcCWN2x+dnPazGXpA9uKNAqlqb30WVmOl3ySGHFGwLsrYQGPKWFXwbnFuWHDqCkCGMZDRM5Sps24uduKj@vger.kernel.org, AJvYcCWihMmb9RN6fyucfUJXxtM0txMDhTIaTOD+Eawjlyt45c8nPz2Mzp3FtygTqMUguUPBU+Y5X/BOXB7p@vger.kernel.org, AJvYcCWy+Mbyhgp+sbhofuoF6ITxYm4NuyrwbmrqYvVDJ05XwUsnJSo9jkVyPh3XsxkbwjU9QKIM4FtyqJhV6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr1TMALpzGQn4PP2r4jlB/bB7iH94oou5IFQ7umP8gVRC2JEla
	oEKZM3PY9NnYLGo6UV2XhMuj/1h0y7+ldoRCizLqG7ss90kYnZycVmK72IW8ZE0iNTIFjEUNLXG
	6A//qLuZLSYwLSI2C7deH4AyjAefYsF0=
X-Gm-Gg: ASbGncs/6/87RPalc2Fsb567j1cPPJIqi7HS4xldWt6pb4me1FJXmACnTQajZQCymh9
	hxcCFKElRGslDT6YhPwRzERhJaQM4UnQjstNob4wI6hxglzc6l9Tv4/lNO3cvINgKBDcHhP/XnW
	HPD5cjjE/JF+cPKwf1hJV7SOT8wuR89HZ8IzCduFAMmmiH74Xr50F+VmrcoEUN9jeY3TGTjQ==
X-Google-Smtp-Source: AGHT+IFs6szxS2r+gjeGsdqBiGo142lu+0TsxSL7Er/xKXXNedfsriBhcmkChn6VnN0EHL7qZN8FowNXo/P6UdDTHZM=
X-Received: by 2002:a05:622a:1102:b0:477:e78:5a14 with SMTP id
 d75a77b69052e-4a73c484bbfmr241088891cf.3.1750188784164; Tue, 17 Jun 2025
 12:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616125957.3139793-1-hch@lst.de> <20250616125957.3139793-7-hch@lst.de>
 <CAJnrk1YtD2eYbtjxY4JWR3r75h1QyjwHPy+1NQBRUNrDmTUnQQ@mail.gmail.com> <20250617044420.GC1824@lst.de>
In-Reply-To: <20250617044420.GC1824@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Jun 2025 12:32:52 -0700
X-Gm-Features: AX0GCFtRXAXeBs7bZNwJubD_2Slv0ZPzqWieKyeC3F6xMTrYOWwRlJxyDQUIKJ0
Message-ID: <CAJnrk1ZYj0TvoLS=sE46p_8=b+3cZ=VNT1Zvd=HMembWUptHPQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] iomap: move all ioend handling to ioend.c
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 9:44=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, Jun 16, 2025 at 01:52:10PM -0700, Joanne Koong wrote:
> > >  #define IOEND_BATCH_SIZE       4096
> > >
> > > -u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
> > >  u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
> > >
> >
> > Should iomap_finish_ioend_direct() get moved to ioend.c as well?
>
> It is pretty deeply tied into the direct I/O code, so I don't think
> it is easily possible.   But I'll take another look.

Yeah, you're right. When I was testing this out yesterday it compiled
cleanly for me because I had CONFIG_BLOCK=3Dn set.

