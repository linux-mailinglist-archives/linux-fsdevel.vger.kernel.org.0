Return-Path: <linux-fsdevel+bounces-72250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBC3CEA82B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 19:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0944A30341F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 18:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5670130B539;
	Tue, 30 Dec 2025 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8R0I3GX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3945528489E
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767120871; cv=none; b=MbZzyhVh4U39+7s7JAYlIOSvZy29hx42z8v0368Rd2ybHqxh8dchmInPWbfoosqoxIvWAxxdBW/akQEOb6qOZtiL9wCCEeDX5zB7NujqQ2LcAAlKnYPL3Iy0AGfm06jpEdu+9K0cfq0lQZLIzGDxUjm3hX+5BGECCqjOk6ZoR6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767120871; c=relaxed/simple;
	bh=5U3vGebn4pXPzpajbr/GLSTyaARgk7iZ/LHuQy6Qans=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=md8FMhFtDP6oV++UiLrceh9Xa1Cgkiw6CTtdZOW46XHxzJm6LGBCLZEEqVnbv4aF8wMyWbSjZL406Yoc/NVutwia/Kbc2fhroZzw3Cv4/a0uxSZg6OdEPdx+juVv0L/fck0R7H9WpNvX1o9mggilk/L68h+Co3kmrV90XhdW3Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8R0I3GX; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee05b2b1beso110979271cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 10:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767120869; x=1767725669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5U3vGebn4pXPzpajbr/GLSTyaARgk7iZ/LHuQy6Qans=;
        b=l8R0I3GXVNkQhm2jQ+E6HnfZ2fvvGc0BfdGkanyiZ4f4Sz3Ow+lnGF9bcxWseTjiOu
         Bu6QlfmxDOQATOkyA1idrTCMths8qpUEK8yXGjAa+8TH8n5PD7eIZFgx5Hj8HJXAYfTh
         JSJthWRDqMoQTEEAwnUtvooGyG1uzLNFyCSZuGKuOYt7x2C5+Evh9NyygJqRPqLAbNNs
         nHs+OQmorfJS+5/7qNtO2s+D55DTENK4lsY+Y5pltwKtnANt6RchlhDWV1xYb+gyS296
         AOXkIYCEmOdYxoSW4pWFrriE/9B3AM5ERRaWFD16oZ9PlGNAYmP1b0DiRXw4hxLuz87n
         DwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767120869; x=1767725669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5U3vGebn4pXPzpajbr/GLSTyaARgk7iZ/LHuQy6Qans=;
        b=Kc1xbkBRrQgllXJvUBZCeS1b89oaP0i2x7llimdPv5Vs2OgP9ana8AXwY/MSJAzpb2
         Mr68uCcE6aUaPEeUB41/dfP31sF80ETixR6rf0KbHhQ3KeaKU2m6son5qVVpOAcxts5A
         4wzJmgjr7tFert3kxrf8qP1OhJSh3cEsZYdZ3QWFsyMuWK+Brrju3tfsoW9SH11a40Tr
         JEYhtSfmYbG7ZmOWEOhu+PkBODIl6XX2R/SD1OwTjdKALu+IoU6tSSian444KLHHPtXe
         vaInDp88HniUhGrZ9nJsmtUaTSYspfwtb6GrxiS3173caylCDP496Cz20HP05xLJJps2
         iJ6Q==
X-Gm-Message-State: AOJu0YyrZZ2wulGcvClH347TLZKyCgg0FELFIojkVsof4ahovuO8zWau
	ez2JZvprtGxDUcrb+wsw/+ptQELtaK7m1aLmBjeYd+HjwS2afHebJAIRgy3wMZIkKUTg2Bwls9I
	eF3OglWit/acglnYq2cm4XVPVqf4V+bI=
X-Gm-Gg: AY/fxX5Vzc2WJsGTA0+f1r+cBDX72sWUPUueRoLtV95KJt+0kw4dqqP7RUyrWh+Lnj7
	Ybvjzrqak9h4Zr0dRSutEPR8kjo8+chEkxp7I84yIcqESY0LLlDyiEIaslMB/wPqQkRI5kwxPQZ
	H/ThVHSLjYSsyEryBnB1SGap6B6WbtIADddVePyh99F5+VIcvm7+ncNi+NU0IzAEIhXxvxuqX+0
	7irnl+W6mZEj2mu9AqisTrCB8k9Qv+WY+cCykyLXfTVw3o+YZoIUnETCFgcsvtMJqqbgg==
X-Google-Smtp-Source: AGHT+IEhwL4HXxN4e0xZH3Y+OJY2m1MdSeUpazz4rQfJGxddAjlU3VapV4/GtBswxoDr3BWgYHJw9/k3eThlM7+81wg=
X-Received: by 2002:a05:622a:208:b0:4ee:18e7:c4de with SMTP id
 d75a77b69052e-4f4abdd8e00mr494377691cf.78.1767120869036; Tue, 30 Dec 2025
 10:54:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGmFzSc=YbHdaFbGQOrs_E4-MBXrM7QwXZ0DuKAGW1Ers2q=Rg@mail.gmail.com>
 <CAJnrk1ZOYnXpY0qf3yU41gQUHjyHOdBhAdyRPt_kaBmhvjr_9g@mail.gmail.com> <CAGmFzSdQ2Js5xUjb-s2vQkNB75Y5poOr_kTf4_8wqzeSgA6mJg@mail.gmail.com>
In-Reply-To: <CAGmFzSdQ2Js5xUjb-s2vQkNB75Y5poOr_kTf4_8wqzeSgA6mJg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 30 Dec 2025 10:54:18 -0800
X-Gm-Features: AQt7F2r0hmnbmvQRioAP-5mxB7q8kGCr_wEkdbPHMBVfwIOr41aKEIfCDkfS4cs
Message-ID: <CAJnrk1Z=kqQc5SM2Z1ObgEMeCttT8J83LjeX19Ysc1jCjvA79A@mail.gmail.com>
Subject: Re: feedback: fuse/io-uring: add kernel-managed buffer rings and zero-copy
To: Gang He <dchg2000@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 5:40=E2=80=AFPM Gang He <dchg2000@gmail.com> wrote:
>
> Hi Joanne,
>
> I used passthrough_hp, the startup command is as below,
> cd libfuse/build/example
> ./passthrough_hp -o io_uring /mnt/xfs/ /mnt/fusemnt/
> then,
> cd /mnt/fusemnt/
> run some fio commands, e.g.,
> fio -direct=3D0 --filename=3Dsingfile --rw=3Dwrite -iodepth=3D1
> --ioengine=3Dlibaio --bs=3D1M --size=3D16G --runtime=3D60 --numjobs=3D1
> -name=3Dtest_fuse1

Hi Gang,

This requires the libfuse changes in [1] (which has a dependency on
the liburing changes in [2]). After building and installing liburing
and then building libfuse, you can then launch passthrough_hp with
something like: "sudo ./passthrough_hp ~/src/ ~/mnts/fuse
--nopassthrough -o io_uring -o io_uring_bufring -o io_uring_zero_copy"
(in the future, just "-o io_uring_zero_copy" will be enough). This was
(briefly) mentioned in the cover letter in [3] but it probably would
have been helpful if I had been more explicit about it, so I'll
emphasize this more in the next cover letter.

Thanks,
Joanne

[1] https://github.com/joannekoong/libfuse/commit/f15094b1881f9488b45026ae5=
1f18d13ced4a554
[2] https://github.com/joannekoong/liburing/tree/kmbuf
[3] https://lore.kernel.org/linux-fsdevel/20251223003522.3055912-1-joannelk=
oong@gmail.com/

>
> All the testing is executed in a virtual machine on x86_64(6cpu, 4G
> memory, 60G disk).
>
> Thanks
> Gang
>

