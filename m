Return-Path: <linux-fsdevel+bounces-50408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F340BACBED6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 05:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DF53A1C5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 03:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEC6185B67;
	Tue,  3 Jun 2025 03:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV7a/OC/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8264C92;
	Tue,  3 Jun 2025 03:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748920945; cv=none; b=bgF/112cM7CoPtJI0gKoE197hHazebCOwL7+VGoGK6wlsZLPSgvcTec6yCdzqwzv4QbmSlRWXf39PT21d92Dhb6ZHG9ZNBpR2BMZ56zmiOkFmmEYpt6gVJF4EAgf5UzqIADBaI8+IJHFbuDrnii2gcsPWjj52LA7cZB9S1FUCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748920945; c=relaxed/simple;
	bh=i19NzsXDPVo9ojnTn956Gc0PDlnUWTUuY/fvidyihYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdR5kR6bdv7s2wS+6Fnu7D8L2eWahaLfRbpoONh4feQYP8fp1hB0OSOMsHRj6+V1GOT5cr9T0xGZV6lE7pTqPCa3pbjc4HwZKx2bZ8mpGaIxTlD2AmtHvDtcnOK8tEp0N6dUEBPSKHR1DPQ131wUbjn+p9fn43p9qnwSi/ZbC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV7a/OC/; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso47295896d6.3;
        Mon, 02 Jun 2025 20:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748920943; x=1749525743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iu1+64eVa+A+/xgIKxgK+zc6qDTtGhIQebotQsqQUP0=;
        b=VV7a/OC/vkuZdd//IlSLGbr5YFNRbDsjVbspF06VFJDXE92BDGTeeCrnDxZE8ihIjA
         Ywlm1OjDd2k2n1IJ2g1LMAgJuZy9T8pIoBuhdGVd8AtkdHcEiV9UygzuQnyVWmG+qlRN
         lkWZFBCEXu5yQG9wE/XT25/Fhk2Bshs/RgqK0UcXRM1CFdcwtwKtVmLAsE73I4cPKFRu
         OqXaTE5hPeX6OTWIChtXkPi0GZvo9F8uC5SmzRxXAAkUzhN5hEW0XxVVpRY1KUAslASt
         DuuUjC4N6MSSjHPaUydNfrsC/sQyFbrUqMP6MvFXniQuU3tJ5Dck+JtTq4rj4ZyWcxyy
         ZSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748920943; x=1749525743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iu1+64eVa+A+/xgIKxgK+zc6qDTtGhIQebotQsqQUP0=;
        b=m6ODePIlVhWd7xNoce+2HLZHRVxmftgsNMctUxmzaphoNV15zOhphmfDlRSmvJwdYl
         riq40VodYFos+Q6tXRS8sA8Mu62OmF4grRGBEuwIeKxbft3LW7CtM9eoFWHRssQ90BO4
         xSlYLSoNffKF4sLDkUy7WfJd1DjbsPhLafW1ntcUCxyNAVL9iCEe9+35TsxUdPSsYApy
         PMNn1csr3u7jPEY7TZ2YSDsIjPvL8d8Y3UXtmZMM6XlLgoaI+XaPcsjXWGrvtlTNxJAB
         lEk4t+wqsMk9DX8kbQQ3W4+9eAKyWgRgR66ihciuA3CPpqDpDTsPwU2bZus3atSVdLVA
         ZuWA==
X-Forwarded-Encrypted: i=1; AJvYcCUOAsmVdjo0Qy7nPNa5Mb9GPWkrWYjks+HKV0xU6tinEEgqEn3A/AJO3/MXaXzWv4mLAjqBUSliI/7T2o5l@vger.kernel.org, AJvYcCVJlR1OTBjBB4aEGTQT8rZB3uAvK7uIjxPOJ+j/bHlKkXF6U0rAkyIdxxaHLjLutfWg5+rqwJ5x0ypl@vger.kernel.org
X-Gm-Message-State: AOJu0YwClJXQFdJ7IiBbV2EIdp3U4nKphNaZDs0GjTn0Dq5TFcDMqTgu
	x4T5yp4yVLCKV3krTZcjVMdkGQvpFRcyutm0BB/MgIW4CpBi2w8upWCfn/6deJ1+B2HjfBsm/Ju
	oImgHMpncsScfdl1xa3rj+831r2sMUwf3DtUxskU=
X-Gm-Gg: ASbGncuyJ6Cqmx/jyWQOIvKDh3zuXUTwvrqp5H+pdxUQAp2bZTJ+h0bk7TDAxXebYGj
	YpysSZ5Wa5jQj/ah+YA3J113HblvJoGSsivAU1UjuYIaVZnI9Z7t17CtESvuKnS9BJA51vddidU
	UobfrEIrLhWC3B09qouriOlkAmxf8GlucHBQ==
X-Google-Smtp-Source: AGHT+IHXBzJxu7+dys2Iem/epsLSJVFiih4qOJ7cLUQS4sSa6SKT1oUPVO8QOMHxRp1VNcRAHI2vxU4L395bRjNCeMc=
X-Received: by 2002:a05:6214:194a:b0:6f2:c88a:50b2 with SMTP id
 6a1803df08f44-6faceb617a0mr259438216d6.3.1748920942917; Mon, 02 Jun 2025
 20:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <aD03HeZWLJihqikU@infradead.org> <CALOAHbDxgvY7Aozf8H9H2OBedcU1efYBQiEvxMg6pj1+arPETQ@mail.gmail.com>
 <aD5obj2G58bRMFlB@casper.infradead.org>
In-Reply-To: <aD5obj2G58bRMFlB@casper.infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 3 Jun 2025 11:21:46 +0800
X-Gm-Features: AX0GCFuSXkrS5GL4xNfIUgd-flIciY34mZzNDxGJNgBNuvJSFvacoKqdev2FA54
Message-ID: <CALOAHbCWra+DskmcWUWJOenTg9EJQfS23Hi-rB1GLYmcRUKf4A@mail.gmail.com>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, djwong@kernel.org, 
	cem@kernel.org, linux-xfs@vger.kernel.org, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 11:13=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Jun 03, 2025 at 11:03:40AM +0800, Yafang Shao wrote:
> > We want to preserve disk functionality despite a few bad sectors. The
> > option A  fails by declaring the entire disk unusable upon
> > encountering bad blocks=E2=80=94an overly restrictive policy that waste=
s
> > healthy storage capacity.
>
> What kind of awful 1980s quality storage are you using that doesn't
> remap bad sectors on write?

Could you please explain why a writeback error still occurred if the
bad sector remapping function is working properly?

--=20
Regards
Yafang

