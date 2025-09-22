Return-Path: <linux-fsdevel+bounces-62412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5896B91D37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 16:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB615190069F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 14:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33242D73B3;
	Mon, 22 Sep 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZukVEC2T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35FB2D640D
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553099; cv=none; b=ZEIcCRS8YxGwZLyEqikfjPkEHXoP8bgQQ3Ow2AZz/d+UKkVuQQaAN/S9u9lOFcRr/ZfoZ3bX11VjzO2avqOxDtSFuqv1HVOIoeCUz2De6a/BOhFKA27whGKzz5uJ+xNuItjkjMCwfEKcCNL72wkOcPZ1cElhaqdjn+RuvQ7QRjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553099; c=relaxed/simple;
	bh=bk/uSOBhjlLpezuJ67nR7iyn8eOOajtcOPPkD+iN/3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuvZLlojGJSsuXsGC/Ss/IwCzbo67g9T7ZwgYanIGw8Syp2haDhwG8skEYir8n3zksPPfz9IdGmidetAaljPG0ax29LwCdHIVV9PsE1IPvw3G5ZBtES1O7M5LT3+iFk0e8i5K7yMu4SQ1RXRS4xetN/R+KHhu1H9fPXIgwL2nHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ZukVEC2T; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b7a967a990so50592411cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 07:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758553097; x=1759157897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFVWZlAioBD8f+qAHkBJ/aidH/GZeFQvA+qClIUvAWI=;
        b=ZukVEC2TBHAzXAq1pJ57A+FQBf77prwd0uZpcCm7CiP1eyDs3Vm3KRA1I9PFOqLsH2
         2wPq27j3F3bQuCq5fUt9llx7sjeF0BMZUBWAY8ZQEmyf/liW3pqzv1IOYnT9I2ZBoEPX
         pswDF/EeI1DbHR/d3UeGJ2PgS1punXOeZhNwsrLv47atcgf9gqpDOTzDmtehGDYkw2O6
         20nmty0XcDB2YOvGe5MubykrS2Z4b+3MQBtcpKezm3apfn5w0CtFyp8/Pgnr3vWniMoD
         3szXovJtaP+6UTxvOsxqJmuft80jXG7XKzWwC/W5XaiDnCL1Ah13iLj6JoyKmexoszIY
         dDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758553097; x=1759157897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFVWZlAioBD8f+qAHkBJ/aidH/GZeFQvA+qClIUvAWI=;
        b=lrtWTiMUqSEa6Y/5LDvP6FybFMjcBjfxHxCGgcga0s4xtWdzCmZfmosjanfaQ+3ek/
         04Dy+d9GJKO+yzp9yqZ8Tbb9P5LQAj31bk7LzCYPZ+tTILYbAYwFRIxm4jN8GIJcWe3l
         rJEnofujePbOFi5c6mwvNTb3GJUUdeEdrEqqvd6fP+n4HPXWtxosXzvF8EWZFpifE0wH
         lmxMgdxOmfPmui/Q/8OMvqnWs+I07rQ0Y0l0gCbL6awxhYWoz/RIyIttMduFQt8kY6IK
         u00kVbtTw9HAU1ovtaXDasYv3EIKUscmy+SAOC7AIdnO3IXSM+sBPuJ2k9TRIcURAfEo
         7nhg==
X-Forwarded-Encrypted: i=1; AJvYcCXLzs8lm72CW1+oBigwLa6x9EtbZ6CQ/NweQZEA3HvbH4ung6vGvqBMp46eQlPQX6SaZgC6/khTu5SRAz/h@vger.kernel.org
X-Gm-Message-State: AOJu0YwNleO8wn6UhiLoP2ZQzgVp2SfnMesD0xN6rIR6MnfXX5kktcN8
	vHAWQ9v40PhJEEOsgIxjuV+/u8j8gKVKpTXkzyJ7XeQZQqDJa1IE709VD+UjOTuihx/hsexKOEi
	RZ2lehJ9OLB9wvWl5a6OEN14CGtd434ubxQ8JFCIitA==
X-Gm-Gg: ASbGncssMW8r42sSwIOXrYiLQzuDpVMgfnxOHwY8LV5h0qPM06jAtOTXhLWN/bKHAAM
	gxyRhmG2HyBwwq4MdH9s611XJ7CGETSu0wmQdmpHix102x8mQ+rOD2rcRPTcmrUFmxHDNVmA7CO
	54MZIL3RC4axYfM8WoNYrm8S/up0w8E3y/1HwpjxA2moawIB2g1uRf8G5WU3D4XeGDQipttDlLR
	pMh
X-Google-Smtp-Source: AGHT+IFB/CQ+Stx8wqmihXNU+u019GIyHx6IROg0+AJtIcKFDHMuxhnTyNrT+0blnUsLunK7sMerRGUSSQ0zeNBJCw8=
X-Received: by 2002:a05:622a:1aa0:b0:4b5:d70a:2245 with SMTP id
 d75a77b69052e-4c073ab0d34mr174036401cf.77.1758553096737; Mon, 22 Sep 2025
 07:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-9-pasha.tatashin@soleen.com> <20250814133009.GC802098@nvidia.com>
In-Reply-To: <20250814133009.GC802098@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 22 Sep 2025 10:57:39 -0400
X-Gm-Features: AS18NWDigaezp8KdbFsh6YfrVI9s8S_j72gr5tDnCBaGxghJTTvfOltyGvHBbhQ
Message-ID: <CA+CK2bDDo7xVxFd=-vkkXuUyStj9ShmURmGNPkMyJvi96KrV7Q@mail.gmail.com>
Subject: Re: [PATCH v3 08/30] kho: don't unpreserve memory during abort
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 9:30=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Aug 07, 2025 at 01:44:14AM +0000, Pasha Tatashin wrote:
> >  static int __kho_abort(void)
> >  {
> > -     int err =3D 0;
> > -     unsigned long order;
> > -     struct kho_mem_phys *physxa;
> > -
> > -     xa_for_each(&kho_out.track.orders, order, physxa) {
> > -             struct kho_mem_phys_bits *bits;
> > -             unsigned long phys;
> > -
> > -             xa_for_each(&physxa->phys_bits, phys, bits)
> > -                     kfree(bits);
> > -
> > -             xa_destroy(&physxa->phys_bits);
> > -             kfree(physxa);
> > -     }
> > -     xa_destroy(&kho_out.track.orders);
>
> Now nothing ever cleans this up :\

It is solved with stateless KHO. The current implementation is broken,
dropping everything in abort should never happen for stuff that was
independently preserved.

> Are you sure the issue isn't in the caller that it shouldn't be
> calling kho abort until all the other stuff is cleaned up first?
>
> I feel like this is another case of absuing globals gives an unclear
> lifecycle model.

Yes. But, we have a fix for that.

Pasha

