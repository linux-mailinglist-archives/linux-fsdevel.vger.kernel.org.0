Return-Path: <linux-fsdevel+bounces-39963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD7AA1A6C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 16:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A763A8072
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38788212B0F;
	Thu, 23 Jan 2025 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jppCrRyi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D120C02D
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737645081; cv=none; b=YprJ7OrJpNV0O2o7e4Qpt/rJS9g9vlKo8SY56NSkiKl2IOzOHA009c/b+dt36Y0jm4Ag5r2ehsfUNB6xkWekLLHotKSvDjesyEgXMVCTO6M1fKUOoeTi8z7wRAkgAOXoZ9dMmT1UDuzdtrGoJTLDqqKPfJyNccADJ3goLmC8gSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737645081; c=relaxed/simple;
	bh=gi3Qlrge0KM4vQmsXlzZ9p9wu4pElkVrNWuh01I2o4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfHcv1mBnojbh1egTLUayUKtSXr3+9PLUlUTCihKgd0kfn0Lv/h/oy91EzWXvyOn7JS7acbened1gX8y2v0bjSsWzz7WXcu9+XHlzJypkBc1vUF9k6FNseaIpp5rsVDSM76KzZKzmBXWAdMWZiNPTQFu4MPkLQnRD/HNBYwYERM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jppCrRyi; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dc0522475eso2231100a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 07:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737645077; x=1738249877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gi3Qlrge0KM4vQmsXlzZ9p9wu4pElkVrNWuh01I2o4M=;
        b=jppCrRyiEAYpI4sNKL2DSTXGjuW60AH1BiBTuQRkH9iEDMHOTyLVIqJtlK4FYj6bLi
         6J84PpDZ9Kh9dGOhmrxOY5gKj6Vsv4hFhM1T58iuKIhaviyqx4zeo/adqO8CNVur5WOr
         4AGEuxBEiUsRKxuDoMIMWSLw4BZGlXJtS3x1JVyDftuZnO6Q3UQBQhwveFsxDERPUcDe
         dnLjIN1WjOv3m859z356mH9+CZp1WWOqrZMQ8qt7BRcdcdyrBU/fkd9CFwAq1fKq9r/i
         9a7OpFfJd6ZOhGD+DM8OuricnSv7Ny/HNqqKNGifsiwr/4HasvraU47OPfZZ2YWhy650
         0OCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737645077; x=1738249877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gi3Qlrge0KM4vQmsXlzZ9p9wu4pElkVrNWuh01I2o4M=;
        b=Xwwqmu+ppFjyoTfEh1JLv1msvy4+GNyPLcknI4JMFU9Nke31l+m0fY8XfLIUTGhsQL
         FaZMWkgeOis1/MJGuxwTDuP8/jbttZCM3qbrhE5FUe6JFrmll+8JIurFaWJlPOJZgGYn
         IqomtVsMekuhxho8+JIAq82iXgYdG1gztJuOYtx+0mSRkVS9Cr0h8Sr4+MpOJTFE9x8U
         DQuexSRrvkruCymiBb0AFfPCr3Yd3KSTRAta2aWCGC15JIFsLVjBH5urRS32ULF2YCe3
         fva1LWjoZB6DvX/CfMWTfKxXXM8EcGu14kxw+AORAiuAYWRA7CZxDhwo7OpWbJ6cTPAV
         gVyg==
X-Gm-Message-State: AOJu0Yy9ZENoJ07SAtxXv9r0d7aPHR9MdbBOC9+HzjXOssV+duXhqPhG
	UJeOYgw6synW7ml+pV3bWXL55SWf6X4R070s93iJXQBTJ3FDyT7wBhW0/YjQILYrHfzoUC4tK3L
	+tFyHijyLnt6scQMJvMBP0PSgz1sK5Q==
X-Gm-Gg: ASbGncukmhVYde/uwaD/1fIrMmn5ccMFnCGMwDSeE52PssGEaVCC2CE7G0XleS970F2
	gIlo57ObEqPfzYYqe1Il+SOtR0G4pSuYiZNu/R1cqeBKk2hm8bMmK4X5Y5olp
X-Google-Smtp-Source: AGHT+IHiZRKHd01H1vj1mdYLtGyYFGFxRnaf1JUgqwtFMKnMlj+QxrV6cl2RRGJFwRsQgXDjL5wHiG6IffOSufbI7UQ=
X-Received: by 2002:a17:907:d03:b0:aa6:730c:acb with SMTP id
 a640c23a62f3a-ab38b0b7ee8mr2485844166b.8.1737645077056; Thu, 23 Jan 2025
 07:11:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPbsSE6vngGRM6UvKT3kvWpZmj2eg7yXUMu6Ow5PykdC7s7dBQ@mail.gmail.com>
 <dnoyvsmdp7o6vgolrehhogqdki2rwj5fl3jmxh632kifbej6wc@5tzkshyj4rd5>
 <CAPbsSE5xJNVrqNugqD7Ox8FxT28kK49SBDFiRN84Dcn=DWzP9w@mail.gmail.com>
 <CAGudoHHWhUOcBNUu8WboxGFrb7nyBuRCruJ6=xT5DPaJ_xyd=A@mail.gmail.com> <CAPbsSE7QjCAtugQG=BH0n+nMUQUDnA7WznXCHqvkBfj304NpnQ@mail.gmail.com>
In-Reply-To: <CAPbsSE7QjCAtugQG=BH0n+nMUQUDnA7WznXCHqvkBfj304NpnQ@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 23 Jan 2025 16:11:05 +0100
X-Gm-Features: AWEUYZnCLPNg1RwalXHjz4EKMEc4U47xZHO_ajpNa3sSwyID5BJhMa0Ric6iw3c
Message-ID: <CAGudoHGkFhOZkrW6Kf+0Q-HMjDa1bCvT+JAtfS6F9PFiU=gorA@mail.gmail.com>
Subject: Re: Mutex free Pipes
To: Nick Renner <nr2185@nyu.edu>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 1:51=E2=80=AFAM Nick Renner <nr2185@nyu.edu> wrote:
Is this on-demand
> allocation and freeing of pages necessary? What are some reasons that
> the full pipe capacity shouldn't be allocated for the lifetime of a
> pipe?
>

Keeping all the capacity constantly allocated is just memory waste.

On my laptop alone there is 277 pipes which are empty vast majority of
the time. This translates to over 17MB of kernel memory which is not
allocated just in case.

I'll note though there is a possible workaround: the BSD systems back
pipes with pages which can be swapped out.

I don't know if this is worth doing though.

> Some of my results indicate that just this on-demand page management
> contributes something like ~25% overhead when continuously writing and
> reading multi-page buffers. But I'm not sure if there are some memory
> management concerns that are deemed more important than the cost of
> this overhead.

The real problem is the fact that the allocator is dog slow. Before
even considering not allocating these pages as needed, one would want
to fix that.

--=20
Mateusz Guzik <mjguzik gmail.com>

