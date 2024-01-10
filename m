Return-Path: <linux-fsdevel+bounces-7720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4BF829DE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 16:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE1E1F28CAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 15:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69224C3C3;
	Wed, 10 Jan 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WhD/6MP6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D9F4C3AE
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-555aa7fd668so5007946a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 07:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1704901656; x=1705506456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioFiiBHR52hjIdzvcsREnH6I97Ku4C9Wv6P6MdH9Wh4=;
        b=WhD/6MP6mAbxASjPHCVpdFAwzdaL2RMmbxDXaVIOPghfujPQW87Cqa0q/PTXbgxDjI
         kq7qh3Nr49HBasmSahg6487pThiN1C2UdhuBjKmSFDS84kJcsM1Ofzp5t1Er4PX55/yr
         yVRaZbK2tNekr7JKe7Jvn3OMArSF3zyHT/DA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704901656; x=1705506456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioFiiBHR52hjIdzvcsREnH6I97Ku4C9Wv6P6MdH9Wh4=;
        b=TcvwK1ZPBP6hU+7Gp9bxmreriqhREhWBmQXzycCb/dmZUSq2vnAmvZBIjGMWgP/yJ6
         4Ra/YMrCckbEdsQSTgWy4Ikf5gV77dyOzcU9Rjbw2rHU/DmLma0CviQ6BcdW9mZxZyaT
         YxEYHNm3ZoxMIHp0vOmwIwVih2nlK53TVADX7LwSy+Y8frSmgQFU6Px7sjbpkdeoE6oq
         buKO+NITrxF3EormfWBFQCY8WRGz+wcMu0rD34T7Dbd7TnRpWeHYJnhorPIzsY6c5+CA
         q6q28QegciVxZwBHkJGuT3Wy0u6uTXx05xAjSnMpdlPuXP3/Msij/5+r3oNuJInX+vWm
         yspg==
X-Gm-Message-State: AOJu0Yx1QFSsfyxLggTGdybgiIZtc2lJR1N5SpDAEfHB5/1qtZmNRjJe
	uKLLvBHHIEiEslxdTqRTnyY25gd9wdOjyPUEqWDhVO7ZZP6yolRhYYG3G0lH
X-Google-Smtp-Source: AGHT+IHA+OuPYsC1tzBqWdoxLHVwHiWSsYMXS2IR9ogBlapWDdJ3nk3Ig2HJ+z1HcTjDmTh0nn25aP29soAg7wAC96c=
X-Received: by 2002:a17:906:7d18:b0:a28:d163:ea39 with SMTP id
 u24-20020a1709067d1800b00a28d163ea39mr713908ejo.108.1704901655434; Wed, 10
 Jan 2024 07:47:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <9b5cd13bc9e9c570978ec25b25ba5e4081b3d56b.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <CAJfpegugS1y4Lwznju+qD2K-kBEctxU5ABCnaE2eOGhtFFZUYg@mail.gmail.com> <2wob4ovppjywxmpl5rvuzpktltdlyto5czpglb5il5cehkel6m@tarta.nabijaczleweli.xyz>
In-Reply-To: <2wob4ovppjywxmpl5rvuzpktltdlyto5czpglb5il5cehkel6m@tarta.nabijaczleweli.xyz>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 10 Jan 2024 16:47:23 +0100
Message-ID: <CAJfpeguE6E=s_t8WFVrJcXUar9ifr5+rhsmoJZYW5xWrTzRbMw@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] fuse: file: limit splice_read to virtiofs
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jan 2024 at 16:19, Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:

> > We need to find an alternative to refusing splice, since this is not
> > going to fly, IMO.
> The alternative is to not hold the lock. See the references in the
> cover letter for why this wasn't done. IMO a potential slight perf
> hit flies more than a total exclusion on the pipe.

IDGI.  This will make splice(2) return EINVAL for unprivileged fuse
files, right?

That would be a regression, not a perf hit, if the application is not
falling back to plain read; a reasonable scenario, considering splice
from files (including fuse) has worked on linux for a *long* time.

Thanks,
Mikos

