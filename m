Return-Path: <linux-fsdevel+bounces-68275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1011EC57E79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 15:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FD74A55CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811B7242D7B;
	Thu, 13 Nov 2025 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Vm9XbdV4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001CC23E23C
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042208; cv=none; b=jxYpYZyfLyph8e7NcgFdgezz0n9Ipwd5h7QFUri3FzPnZoyA8dnDsVEPlotf7TadLimGeDUgjaES25epOB7AXhYzAQPydypWj7R7mW08v9Lht3K1dyZnhBkgj1IyyH+2X+EuYH2pKm4mF8cy/C80ifjgPcKoKJE641jcT6pKRvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042208; c=relaxed/simple;
	bh=AbsS8x7hw4WZr24xg0FQFBeLZr2h7y0e6Brit3vFQBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKm3XlrwBLLIKH+OdwhtWekRsK4VtN3EtY0ADn0Jqa6pRUXurBg9k5dzAlJ33KsA5A5HjpkgW8pXUpbcSpZcx0X4Qetj516Ogi8dNi5roSH3QVLqe7FYArflNJrryyEEIqWMpEIpKr+Q2dltUxpbQGFDIQA4caR7ARUXlnRFwyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Vm9XbdV4; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so1171890a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 05:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763042204; x=1763647004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6qyNFyNK1thmREVHkgbpHK+c6E8B7TJCRh3ULLZ5C1c=;
        b=Vm9XbdV4vFRDL6BfXDqwCxGBL8FfpOZo7z3xnht2zwnmRJdIO+2upWlqK8SgB6+sxG
         s7RZxMD7cEOodgPsw8TyUbE44Sju8mvVAMCumqCI4t+CrPOAW8jDEp8ygkMSK9HiTk6Q
         1kCEL57VtdPR1mswzee7hDC/bSdx5tqMTL/utyvROh4UdJcN7cr1jWUI2Ki1RhEUxD77
         B5R7wOnEsFCXuj/0fHrKo3fH5QCm7yHd10PSTVEJhLMy6lEbZMyhIi5oPG2FF5IoDtiI
         SmcubaUaheILv007a5U0imDLJrTr/J205+n3pqjVUx8SmcWXz861QW0JQNqkmTEZOahp
         MLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763042204; x=1763647004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qyNFyNK1thmREVHkgbpHK+c6E8B7TJCRh3ULLZ5C1c=;
        b=eoILm/swrNHfsjq+2dQRidd2PcILttgy8fE5rpjZB1o61R5Sbf5RCtgqs9YQhidQvW
         HmjOJWZj1PUKdHsRWWke69PcwGaR7lRkNyd7Q9bM5qkj/RxCG6tD6spzJgIqfZb6HMn+
         VgLHEzOk4PPSWdhgdDf9fCqFRefiyC3wjwOgGnebpPIwc/ctO4ccK64TpGHsExPmXOZz
         A30qOwUhF4d6BRs/cAWFnwE38IKLMSuRmH3A/Z3X5BbDUfS8J3Nj/rGoqVWtrGZY3Vfx
         c+CY7+5e+AY7CLFhK46Zqjb93IpVis7dHO3IkRpzhmJfuRs+ZSGCrNHoDuDnPXBMHaqv
         L6Fg==
X-Forwarded-Encrypted: i=1; AJvYcCV7MM71+KK02VJnplQrlf/T7XJNkryqt0Wv4Jv7XkpR6JStqpZu7Cd2jSjy3NEWRjeoaeqrOVID7wGK3uV4@vger.kernel.org
X-Gm-Message-State: AOJu0YzkzftDggM5/dlgy5McFTL5cqskLG9YibAEUo2EtXRyjNdJ85ww
	hJTqNpTYlEs5AB38hlt0aEzTXdJV5e8aJNDImPxP25OhqHxeID/fa9R0aqZSOU0k6sIgiAg6IiU
	XRCxXL7lVHsRnO7B7KXxbaLc+d0DSae+guwZbWWGvTA==
X-Gm-Gg: ASbGncsPRdYHKn3l3DLAlT/HRyaQY/VPvI2AsrMtep1Mx+YZ/COKEIKuFZ3PVdeXWTM
	CnRU+vkyt8aliCNlTDsr3faL/gKARlXVAGOjYaPDbzAf0Gibk11J0zj+qPgUMx10UrSqVPDBP7y
	P31+X9p7HimD5oo44Jk1zShplXR3VSdL7Eo7fSn2ktij+uiB2z9OG96zWEeIxqPDEg5pNSZsGlL
	5j8wf6g8XqX8yM92B9zFu8SkI82/i2lshZM1/Pe3ZaJCsTHviRna95gVKMlox/KGStw
X-Google-Smtp-Source: AGHT+IGY+tZRbaslLz2kOHg+aNV3t0hpe7oMeZfcGmL5vq41YDW/o61wTpChY/KiKQIFV5hvmww+CFYOhBuLb1d6YYI=
X-Received: by 2002:a05:6402:2106:b0:640:f481:984 with SMTP id
 4fb4d7f45d1cf-6431a395d5cmr5583802a12.2.1763042203396; Thu, 13 Nov 2025
 05:56:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-2-pasha.tatashin@soleen.com> <aRXfKPfoi96B68Ef@kernel.org>
In-Reply-To: <aRXfKPfoi96B68Ef@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 13 Nov 2025 08:56:06 -0500
X-Gm-Features: AWmQ_bmd0HSccxoETOjnPXP7LM0Avf6TAjDFvEucAEYN_rSyfWXxN426kJbKdTA
Message-ID: <CA+CK2bA9DtFd5sCfWg11TGdRj9JCgevO_mrjBsBvY1ebgUD4dQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/22] liveupdate: luo_core: luo_ioctl: Live Update Orchestrator
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

> > +/**
> > + * DOC: General ioctl format
> > + *
>
> It seems it's not linked from Documentation/.../liveupdate.rst

It is linked:
Here is uAPI: https://docs.kernel.org/next/userspace-api/liveupdate.html

And also from the main Doc:
https://docs.kernel.org/next/core-api/liveupdate.html
There is a link in "Sea Also" section: Live Update uAPI

> > + * The ioctl interface follows a general format to allow for extensibility. Each
> > + * ioctl is passed in a structure pointer as the argument providing the size of
> > + * the structure in the first u32. The kernel checks that any structure space
> > + * beyond what it understands is 0. This allows userspace to use the backward
> > + * compatible portion while consistently using the newer, larger, structures.
> > + *
> > + * ioctls use a standard meaning for common errnos:
> > + *
> > + *  - ENOTTY: The IOCTL number itself is not supported at all
> > + *  - E2BIG: The IOCTL number is supported, but the provided structure has
> > + *    non-zero in a part the kernel does not understand.
> > + *  - EOPNOTSUPP: The IOCTL number is supported, and the structure is
> > + *    understood, however a known field has a value the kernel does not
> > + *    understand or support.
> > + *  - EINVAL: Everything about the IOCTL was understood, but a field is not
> > + *    correct.
> > + *  - ENOENT: A provided token does not exist.
> > + *  - ENOMEM: Out of memory.
> > + *  - EOVERFLOW: Mathematics overflowed.
> > + *
> > + * As well as additional errnos, within specific ioctls.
>
> ...
>
> > --- a/kernel/liveupdate/Kconfig
> > +++ b/kernel/liveupdate/Kconfig
> > @@ -1,7 +1,34 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Copyright (c) 2025, Google LLC.
> > +# Pasha Tatashin <pasha.tatashin@soleen.com>
> > +#
> > +# Live Update Orchestrator
> > +#
> >
> >  menu "Live Update and Kexec HandOver"
> >
> > +config LIVEUPDATE
> > +     bool "Live Update Orchestrator"
> > +     depends on KEXEC_HANDOVER
> > +     help
> > +       Enable the Live Update Orchestrator. Live Update is a mechanism,
> > +       typically based on kexec, that allows the kernel to be updated
> > +       while keeping selected devices operational across the transition.
> > +       These devices are intended to be reclaimed by the new kernel and
> > +       re-attached to their original workload without requiring a device
> > +       reset.
> > +
> > +       Ability to handover a device from current to the next kernel depends
> > +       on specific support within device drivers and related kernel
> > +       subsystems.
> > +
> > +       This feature primarily targets virtual machine hosts to quickly update
> > +       the kernel hypervisor with minimal disruption to the running virtual
> > +       machines.
> > +
> > +       If unsure, say N.
> > +
>
> Not a big deal, but since LIVEUPDATE depends on KEXEC_HANDOVER, shouldn't
> it go after KEXEC_HANDOVER?

Sure, I'll move them to the end of the file.

Thanks,
Pasha

