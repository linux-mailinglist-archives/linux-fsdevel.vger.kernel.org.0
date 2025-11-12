Return-Path: <linux-fsdevel+bounces-68114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B10ABC5481D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 21:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB26A348D8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 20:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41992D8370;
	Wed, 12 Nov 2025 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UlYBa8ac"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F328152A
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980466; cv=none; b=oSJzxcPt93rT5Hku9qqnZeKs/9DgCVXVGfWbiDFNf1Omi0jdvjT3RNQC1qBNAxMkjvfMfWpZ3ot93Jg11QOl0BF6YWyysOQjo+uytPMRUH7F5nRdfpl0jSLEFzCe3M2ASlWVC5yIdCbuGPHTDKwZLLRjnXe02svTu4MBcUWBE20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980466; c=relaxed/simple;
	bh=usPtXPTZX6TXkeQ1v1bYEhzjiCuAM3VVnx8IxUxXsXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1f57k2h924zl9ZZmHqjvvfjSAkXVzzvpWBniPSAilBZ1uDjfgcXzv2/ACZ0aIEI8dQIDm2ZMhNrvQiDR/lHFK8Yav4j1r83dEjeZyU3Tf19CDF4tLbLDAyXU4Of7DWz59G0r0qzyqdAsiCr++qFJE6LggS6yBN6R31CJNo0LQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=UlYBa8ac; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso279482a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 12:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762980462; x=1763585262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dB48jiAJQmCTSUKKfFbF2w4Wvbq8+BICA0uZNvppCf0=;
        b=UlYBa8acZxIXxOCsd+IeAlRvOszYm0rcdeqrR+hs41Y9TNEpKoIvzNBg1HXwZ9JQNn
         4pEKzyUeVBEcpJxDJ4/FdgGpPeVChVeV+HStsILsNJuIBnz0OOxtSA6tnKbOZuByreGX
         V/H3+gRzxUL1vhOF745KA1vBK6SMRDvWaeiyXbsK6cmCdFhuehs860a88UtqaNOGCQK8
         w3EZmyLKw7sZpgDvd5rLKTlqO7Zv7ROfXuwzXl3+q2s0vIU+oUwuBi1TluI4kCD+Hcls
         16CYAofa4hItWp3/2SmeHyHOdxzMQx6fIZgBddgGI6m55D61j/ymcE58PUlg0AFEqwgn
         THKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762980462; x=1763585262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dB48jiAJQmCTSUKKfFbF2w4Wvbq8+BICA0uZNvppCf0=;
        b=PFQqYbjimZrpzujN2mBLc/AgU4vZhcIiJr4l3ATvZ94b3yhMfYSJIFz23SwNCv37Q/
         1aMU21frbA+tqxZhZm49l1i+yezYjVrQpfMxILDxcQNroNWSCIA/kLYAcmSzPxEl4bDZ
         bT0pl8FHBmn2OdQu5lcJAcOxuhFqSOwDiQl5zPZNJe+bYENsc4fOT2e67miMaaFirwtT
         DPrhFmQLd8D3eBWfkRJI5ati5J4YOxgvohhiPr42MYd+g8WBf8j+NusUfsO4vU1VoNYL
         /nSMmGfZZwh27uagTScwakOesSix+o4Ecwtved6d5vHfa5nPrNjnVrg50P/l9Ev4W7MU
         q8iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJHl17lKuZLUrK7KRitx65Nzbbr+16ebGrbQxi5BZ3/2xR1vt8K1feZJnZiyn1soDawac/jrSnc4d9TZJ0@vger.kernel.org
X-Gm-Message-State: AOJu0YzC/uQOp/K/z5Gp6zUlCtl+URvUxVAuJz/eruy0/HcqUTtZIq6/
	WAKZ0Wdlqv4IyhxQ6gT1pMBilfxsQqhNLYCeIyirmuslLJNKT9YSY6jsjmQYjWmVmPm9bi4Zz1W
	8nTYk5X0QewYih+V9WylGMtGwNRowF9pgP4gBIXqFwA==
X-Gm-Gg: ASbGncvcj3nAzdQ6dlwvltp7w9StOGIl9XyUF9LrUsLHEHhwluyaAgSXnzGKMKwUV4F
	wNi4J30/68IjgB7QuC6z/LOnDRbx0cPKWWPIX8lZDsRWEqhaAKbONto4TsZ39ZG7qaKgDU/grrx
	4ExmisxJ50DmKuXkTxNvGZG5ocNgmk3/Hwz2mtFlA5Sg14ZHamKaHyzTfxCXXri/tJG0mbXRKj4
	h0+EvFwKeGqYTJJqFdkModdJ8iorlZTevjlEyXYdcbiq+ce6VKltj/mEg==
X-Google-Smtp-Source: AGHT+IHnCxJ5sXULWNZ4xyt6eOXGzcL5bRRpxTbpBkagcIsWqapM9iv+G712dgCOMjYDLl8hNWljgh4gZ1/4nXWnvWg=
X-Received: by 2002:a05:6402:280d:b0:641:270:2c8a with SMTP id
 4fb4d7f45d1cf-64334ce2bf2mr656038a12.14.1762980462571; Wed, 12 Nov 2025
 12:47:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-7-pasha.tatashin@soleen.com> <aRTwZNKFvDqb1NG5@kernel.org>
In-Reply-To: <aRTwZNKFvDqb1NG5@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 12 Nov 2025 15:47:05 -0500
X-Gm-Features: AWmQ_bkVh8Sk3xM0csiNTGOKzpW_RilqarlOG4vqEffeEKya7lO37kZmCW2_pO8
Message-ID: <CA+CK2bAhJ+Lbm6v375RuZKs40q34gsKHE-N+dD8gKqgzsHCqww@mail.gmail.com>
Subject: Re: [PATCH v5 06/22] liveupdate: luo_session: add sessions support
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 3:39=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Fri, Nov 07, 2025 at 04:03:04PM -0500, Pasha Tatashin wrote:
> > Introduce concept of "Live Update Sessions" within the LUO framework.
> > LUO sessions provide a mechanism to group and manage `struct file *`
> > instances (representing file descriptors) that need to be preserved
> > across a kexec-based live update.
> >
> > Each session is identified by a unique name and acts as a container
> > for file objects whose state is critical to a userspace workload, such
> > as a virtual machine or a high-performance database, aiming to maintain
> > their functionality across a kernel transition.
> >
> > This groundwork establishes the framework for preserving file-backed
> > state across kernel updates, with the actual file data preservation
> > mechanisms to be implemented in subsequent patches.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/liveupdate/abi/luo.h |  81 ++++++
> >  include/uapi/linux/liveupdate.h    |   3 +
> >  kernel/liveupdate/Makefile         |   3 +-
> >  kernel/liveupdate/luo_core.c       |   9 +
> >  kernel/liveupdate/luo_internal.h   |  39 +++
> >  kernel/liveupdate/luo_session.c    | 405 +++++++++++++++++++++++++++++
> >  6 files changed, 539 insertions(+), 1 deletion(-)
> >  create mode 100644 kernel/liveupdate/luo_session.c
> >
> > diff --git a/include/linux/liveupdate/abi/luo.h b/include/linux/liveupd=
ate/abi/luo.h
> > index 9483a294287f..37b9fecef3f7 100644
> > --- a/include/linux/liveupdate/abi/luo.h
> > +++ b/include/linux/liveupdate/abi/luo.h
> > @@ -28,6 +28,11 @@
> >   *     / {
> >   *         compatible =3D "luo-v1";
> >   *         liveupdate-number =3D <...>;
> > + *
> > + *         luo-session {
> > + *             compatible =3D "luo-session-v1";
> > + *             luo-session-head =3D <phys_addr_of_session_head_ser>;
>
> 'head' reads to me as list head rather than a header. I'd use 'hdr' for t=
he
> latter.

Or just use the full name: "header" ? It is not too long as well.

Pasha

>
> --
> Sincerely yours,
> Mike.

