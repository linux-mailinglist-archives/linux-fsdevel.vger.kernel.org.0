Return-Path: <linux-fsdevel+bounces-56616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C52FB19BB9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 08:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C405C7A8EF7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 06:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5983233736;
	Mon,  4 Aug 2025 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lO1hjeQg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E6A22D4C0
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290286; cv=none; b=XwE2yormbSYSEg/4FWJs26uY+m7veMjnKzlycVWotV1sNicx5xhyCaiTSwpWucR4zT9MK+kH4aaSnvn96DYvI8YEH1LYCiPJyY4K0Si2/XAUjBdEl9WTYB1Qf3TS/0Oh7+cnZoHassc/W/z6pjkh/2ggaIVdeEbWG6Qqn3doBgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290286; c=relaxed/simple;
	bh=AuHw3Q+s89vthrT+onb+aRrlNeHjbcR7n1dDceQEW04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aH+uMpUDQXVN0VQ4X+sHccCvRIoAwfvqdp0HwcO1QF7VgUNgugV2BlhZeS1OTMpEYGw0jpWxCw2y9FJz9zsPRAfxEIeWHTfhfshSnMi3HkZtJtdN/CBQxXx0NrMzbJtyC77sLaxCfQtMLbN81OcI6W5UXlRswwaaJTq0K3Jx+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lO1hjeQg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2400f746440so31250985ad.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Aug 2025 23:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754290284; x=1754895084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0OOSzyo7d6/tfFos1hXNw0iQjhEsi0n1KjZ6e/WbQ5Y=;
        b=lO1hjeQgIWsQMr8ieYxziX+sLcbMzQBo+CzPFFJr8Pt4pbsl6DvJfON1C8c8kWtzAD
         G0yrualP7/oRTKr3wu8PzGY9LtD/DZC9IqKmZYOFjeaCTOS509Gzg6ztANrJc57Slt4o
         2v7UwOWrPsWCTj7jZmYK1aNSBcabFrClWEhAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754290284; x=1754895084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OOSzyo7d6/tfFos1hXNw0iQjhEsi0n1KjZ6e/WbQ5Y=;
        b=KxcA/X83CNuFxoo84LLfyCO6yZg/3j5J1jkV8PohyuYmXSyllZFLy7giGhBnQzijce
         c7RaRCYi1QS5XuREpH4Y8tVw+uOj3C/GmnnTuan5yMs10/n0T8aaDJT6ich3+Vctzo8Y
         E0W4Ycc6jgE80NWwZvOwHJ5PY4SJtgnstqfilJODiCmjNlkKBKDQAj5UKAD7J5iT7IDY
         vtcYBu1790haBOngG5pvuJcrRmLnsZ1GY595xfMVanUsbKbrafpa/gk1ws3JjVBoiNiX
         dVg8t9oRBKS2kKdiSDyPa/2DsXRQKSHw9KByWedXZo/7Y3n3F2zJlvxm6AyrwHBxqFYy
         RpEg==
X-Forwarded-Encrypted: i=1; AJvYcCVlejBUMq+EAscPCtjK7UwUbK46ZyAK2Azw9v8sPey2LTZi/RzKsiTMeMlGgAPH/XDVLbPaonynmnjJh0IA@vger.kernel.org
X-Gm-Message-State: AOJu0YxyDhQGdWH+jrNAxOrj+HODJdOIey/5L5CLJjpmlQ2BEvY4jgZa
	OUqh9bcRHo3WstMhZetnjxfWYL5d9YnmyE8OcuxMb8MibM1taQw/HuKRm07j2diz0w==
X-Gm-Gg: ASbGnctvncWIovDaPC+p72BSS1KgBXocZHkZuhZMMEhmVIRAFvMLzfwvakdLy+l89GZ
	1RnfYCDU7XLUP3m1XBZ9PvESUKvhXfL/1lkoA1itNsnnFi6hB4sq4/GYLv+e4hsIo2UQSUaZeRb
	fd7sP2t3RRka08ygrRKpISk09drv9In0MdKdfqq46JH0xNGMdMuFKRHWwukYbUwzg4iZuxMFOew
	hwAo6UwaZsdeVBb2U+CPCRa/6AHCeEVFWtZkEqb3Rv4bKWISlCFDGV9XMLcEBn6GPvA7PM/Y0iq
	IuWiYOdCTUyBSUQvLEzbNaL/8hylnqwt4AYGxwss+fHHbBsD2PVboTmvYW6VWgFBz30DjmmuywK
	ilfARmOBFGPlcI2NiRzl8h+sftw==
X-Google-Smtp-Source: AGHT+IHeG04vWPQLSEI5EHbS/VdNFUYX46iHYs9mR4PwPLXMkV/VqjBr1d8WMag8Q6tl/bIutdGYog==
X-Received: by 2002:a17:903:24f:b0:240:6fda:582a with SMTP id d9443c01a7336-24246f82e11mr124853375ad.23.1754290283941;
        Sun, 03 Aug 2025 23:51:23 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3668:3855:6e9a:a21e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a909sm100170555ad.123.2025.08.03.23.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 23:51:23 -0700 (PDT)
Date: Mon, 4 Aug 2025 15:51:16 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
	brauner <brauner@kernel.org>, "James.Bottomley" <James.Bottomley@hansenpartnership.com>, 
	ardb <ardb@kernel.org>, "boqun.feng" <boqun.feng@gmail.com>, david <david@fromorbit.com>, 
	djwong <djwong@kernel.org>, hch <hch@infradead.org>, linux-efi <linux-efi@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	mcgrof <mcgrof@kernel.org>, mingo <mingo@redhat.com>, pavel <pavel@kernel.org>, 
	peterz <peterz@infradead.org>, rafael <rafael@kernel.org>, will <will@kernel.org>, 
	Joanne Koong <joannelkoong@gmail.com>, linux-pm <linux-pm@vger.kernel.org>, 
	senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/4] power: wire-up filesystem freeze/thaw with
 suspend/resume
Message-ID: <cudrf6vttxuxrihqcd5bw52oagvkw7oyvgil37l5iq6njsnqlm@ljgewfzdttx4>
References: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
 <20250720192336.4778-1-safinaskar@zohomail.com>
 <tm57gt2zkazpyjg3qkcxab7h7df2kyayirjbhbqqw3eknwq37h@vpti4li6xufe>
 <CAJfpegsSshtqj2hjYt8+00m-OqXMbwpUiVJr412oqdF=69yLGA@mail.gmail.com>
 <19873ac5902.f6db52da11419.248728138565404083@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19873ac5902.f6db52da11419.248728138565404083@zohomail.com>

On (25/08/04 10:02), Askar Safin wrote:
> What about this timeout solution: https://lore.kernel.org/linux-fsdevel/20250122215528.1270478-1-joannelkoong@gmail.com/ ?
> Will it work? As well as I understand, currently kernel waits 20 seconds, when it tries to freeze processes when suspending.
> So, what if we use this Joanne Koong's timeout patch, and set timeout to 19 seconds?

I think the problem with this approach is that not all fuse connections
are remote (over the network).  One can use fuse to mount vfat/ntfs or
even archives.  Destroying those connections for suspend is unlikely to
be loved by users.

