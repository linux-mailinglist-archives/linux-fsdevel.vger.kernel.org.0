Return-Path: <linux-fsdevel+bounces-59905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40207B3EE41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 21:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C617A1AD3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 19:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B4926B0A9;
	Mon,  1 Sep 2025 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dXEZCX+4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758F23D283
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756753406; cv=none; b=FcZNcbuXW3/Piz+e/FzuuqhYLMlNjijmlw8+ZAyKOFAZmXT3vBv4k0LoMVq+vNYRWUUaZbRQQlJ3A8KeJsa/YbOSD+d7pcG/Juh9y/Z9PT55Z/9CDBZVaJCPcdpoYnGJ5rMSd150gIi0jJr4gI63Wj7LYBEq/kLEoyBsO+pa5fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756753406; c=relaxed/simple;
	bh=S3hCdUT2ICLXa1GjNdU28dZZnKCVYtibeydsEJ9rZEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIyvFGmcBSXUkYj1k5a34ABTOsrRsJDR4mKvvabXLuuU+QHK0g2jIzbmGixsRi024g5FoEe7AFISHT1AKtoZVkjXMsSoR/VNZkQjq+Xul92laIQBg5LExk2LIIrZRqAQjzEVU+b1G5nLpfFzGxCJySoyzwjGLCMKVdi2lAUmWcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=dXEZCX+4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109c4af9eso40063271cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 12:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1756753403; x=1757358203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S3hCdUT2ICLXa1GjNdU28dZZnKCVYtibeydsEJ9rZEA=;
        b=dXEZCX+4rQJGhIL63KLKRHxqwjXdP2O6g2tY4k3x5FDsPLedpIApTg2PFgMjSph2sb
         W7+k6ybjgpB8T2XdOJZv3OdlsVYLiahsYawM8Q/8AwB05NAqBv9sxeToI8M2Rgph25dc
         wdyEOL16F1ynXsEJfcW7o23ZmJ0uhXGiOzLzsMdk2sqK25PahNNtJphys4q/8Gb/VEPY
         522sx3i2EhJeH97+0xb/adJ1cvG4HxYlAVzdBidmkMqWCLgZxDntJUw/NS4DKICJ+Jrm
         pAj12VClPYdAOehZgVfoDxJYk/OuCxxSO2v12TUzjm3O8ADkwkleByFpStlo+5BoK3Dg
         NDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756753403; x=1757358203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3hCdUT2ICLXa1GjNdU28dZZnKCVYtibeydsEJ9rZEA=;
        b=Qoq+1aYZ2R8BwS2jhOAd7YjvmvwVFpDAqVQ3vErIiiHMY3dhJ6BYDwo/mpld+29lbI
         SBIbCOtUR1o1kEWhuevRYIqX6Fzt/JviIpPEL2L02Qq0OfPZhhD4B8r7SHLh96LNA1BA
         GcdYtoDwgbqt+hRPPYGD8fzdaSRfuxgd14XexZuNA9YaXeAfWDa0a/5vmZRwDh1HAQR9
         rNaM3F1qVkkvygKwZE0yDcer+bJ4uWifLxE7uEV/vlyVHzBjxG3gHIDr3dbGMwmMmtlI
         BZMxboKVvylw/RWI/FgpxBkhPi9C+BsIHnRygAxBO9TV1/PrQNNxpltHx6/pzTW1d4JP
         PHDg==
X-Forwarded-Encrypted: i=1; AJvYcCVn5Xtfq0dHdDXaXeTSUyVvH5CWolAl1yN+jUUri1igcdUTtvOj8EVtfRd5Cm/oW6X1rUl7TfYjOLowFQzt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsdwyl4DfhQGa5IGGOZdZetTWJlt3TCMRT19/iqN8yHJlL54Au
	G5bEPtVZgQz7gCZIT53hnDJmgTv2jNu4d5SUpbO1R6SSF7SIogJ9Q/ZqLNVq9fCDeWaY9oi9mMl
	M110VsaR2ZqHN+YN/aP3fauy2k9T+2BlaAC8qe+SCFA==
X-Gm-Gg: ASbGncuqSSRmqH6g58MC2UWX/dOF8C0e3XszoRBmrFls7PQ/8qzXcEcoAdsRkYkbivU
	A53QkfaR043iHMNyiYtRdiSYlDGUoDDyTPkwtC7suKJq0A6twC1rbN+5+bxyDMsmPXfqzUHNXlc
	JrG+avVAQ9/rtkx2vJCDFxeJT2cxHIP3L/9zWgSofRr6lwmxkiO9sJBcXqhgvrnHudcjn04IUha
	yqym1syLxLIaiA=
X-Google-Smtp-Source: AGHT+IGC4IxxW7gTteEuAiFDY4ARihDdjTh7r8Mht+Ln0Ng2xWrhyAI5gEJNZ2B2JAdSBb2GjROz0/at0WjW2Aw4LfQ=
X-Received: by 2002:a05:622a:1a0a:b0:4ab:902c:5553 with SMTP id
 d75a77b69052e-4b31da17d84mr113554401cf.52.1756753403110; Mon, 01 Sep 2025
 12:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com> <20250826162019.GD2130239@nvidia.com>
 <aLXIcUwt0HVzRpYW@kernel.org> <CA+CK2bC96fxHBb78DvNhyfdjsDfPCLY5J5cN8W0hUDt9KAPBJQ@mail.gmail.com>
 <mafs03496w0kk.fsf@kernel.org>
In-Reply-To: <mafs03496w0kk.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 1 Sep 2025 19:02:46 +0000
X-Gm-Features: Ac12FXxIFoyzz5jiOJ4O5RxQRUabkrNBq-ldI0H08I8mR4jOJnwP6yzvNT_MXGI
Message-ID: <CA+CK2bAb6s=gUTCNjMrOqptZ3a_nj3teuVSZs86AvVymvaURQA@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, dmatlack@google.com, 
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
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> >> > This really wants some luo helper
> >> >
> >> > 'luo alloc array'
> >> > 'luo restore array'
> >> > 'luo free array'
> >>
> >> We can just add kho_{preserve,restore}_vmalloc(). I've drafted it here:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=kho/vmalloc/v1
> >
> > The patch looks okay to me, but it doesn't support holes in vmap
> > areas. While that is likely acceptable for vmalloc, it could be a
> > problem if we want to preserve memfd with holes and using vmap
> > preservation as a method, which would require a different approach.
> > Still, this would help with preserving memfd.
>
> I agree. I think we should do it the other way round. Build a sparse
> array first, and then use that to build vmap preservation. Our emails

Yes, sparse array support would help both: vmalloc and memfd preservation.

> seem to have crossed, but see my reply to Mike [0] that describes my
> idea a bit more, along with WIP code.
>
> [0] https://lore.kernel.org/lkml/mafs0ldmyw1hp.fsf@kernel.org/
>
> >
> > However, I wonder if we should add a separate preservation library on
> > top of the kho and not as part of kho (or at least keep them in a
> > separate file from core logic). This would allow us to preserve more
> > advanced data structures such as this and define preservation version
> > control, similar to Jason's store_object/restore_object proposal.
>
> This is how I have done it in my code: created a separate file called
> kho_array.c. If we have enough such data structures, we can probably
> move it under kernel/liveupdate/lib/.

Yes, let's place it under kernel/liveupdate/lib/. We will add more
preservation types over time.

> As for the store_object/restore_object proposal: see an alternate idea
> at [1].
>
> [1] https://lore.kernel.org/lkml/mafs0h5xmw12a.fsf@kernel.org/

What you are proposing makes sense. We can update the LUO API to be
responsible for passing the compatible string outside of the data
payload. However, I think we first need to settle on the actual API
for storing and restoring a versioned blob of data and place that code
into kernel/liveupdate/lib/. Depending on which API we choose, we can
then modify the LUO to work accordingly.

>
> --
> Regards,
> Pratyush Yadav

