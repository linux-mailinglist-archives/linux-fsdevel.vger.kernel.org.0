Return-Path: <linux-fsdevel+bounces-57908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601ADB26A77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34C29E1997
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 14:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3872063FD;
	Thu, 14 Aug 2025 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FsQcS5Qb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEDE1EA7CB
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183505; cv=none; b=HpxVmyDHA/ga993SjawAFn5AGmX28kC2jn/0TOlFPxHof8JY1EacDOClN9o+jTI54nm5exzHzj3oXY8HFADb95f9xvJhhJLDUcMCigS1PKg90znNORctFjCgK522wwCgzmO7v4IgyIaUuFyVSJxAsYj0s56RLwg0FQmSIy0zK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183505; c=relaxed/simple;
	bh=MU3gYDGK17uqY3N6k7XJpgqHs7YiCVPOQMg82gPF2no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFaRhtoxDyn7MhcObzUlKcdVm7B1WrHpwr3VgOMFCoocm4co2PqA34dc4z1zFnAA+GVGF4I83jEyeEVvIAriwVTSD2NZXpwoHmqUOeCfVUSpEKikbbC6/HNy+fy6hQF3zZoj7N2BhfCb4URwY+S31ysYIcujFi6j/MYLYsSHD/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=FsQcS5Qb; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b109c4af9eso8858371cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1755183503; x=1755788303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sgUd9YdBOZy0kVdBoXU78NUeqQMRVWLT5DC2WvX4NE=;
        b=FsQcS5Qbo/1jLYAnxFQZ+qc1uAZjN5JiK3pDaliLv+x51YmAJkeLWfMbkEXP3JpbD4
         YvtN37O7qJIp7KrBSBGVlhefE4jp1yXkpyNK3shMVVpsFtgB2f1Et7qxIv9orFu5N+uY
         X3h2PrwVx26bZmuCuQIMoy6ZSJR2kXyLIxm8wOYNotAFCQXtJ7S+ArJ6KZyAu1Mv55aV
         rl3b6FCbmO4T1/+OgvcmDo3NOLsFOsUZWrEZwwFjQEAmcok1vy8IaL+1xFN7eobJ/7RO
         yRsHK1CSHRqocl070dM0b9lpEYsY6LloPKfg4RfOV41YcseqpC9Gq2ZhL7Beojijx4iN
         jcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183503; x=1755788303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sgUd9YdBOZy0kVdBoXU78NUeqQMRVWLT5DC2WvX4NE=;
        b=fJediCWd3U/fMRQmb+SamcOFB0JySF6o6h7cqY2IMoOKM8D+lfl5Xh7woA3tinwqs1
         /BCTofGTOEzs3u84XOumemhxBIXXp1wQexvwR1118O5Y7lANryfwKmM9cRXpDzvk7fin
         2UV324vdGuVNOIn2UAvDypJji9BpaZSzca/9ngTCAraSIu7C4aI10ofOMzm7W0Ap+qsw
         DhIQbHe4FxMo3b81wMu+//AhYRSm67YlPIMoYMTpd6SKuhs5HZ5crxbvf6zhpycssZ5p
         VfCzQXYnRMjxykNb1VR3zrxIiX/K7+FpXgwMv7R09dbewzBJiHaVA4w3+fznw6CxsqJz
         r35g==
X-Forwarded-Encrypted: i=1; AJvYcCU7ZaCXyo8ixpKtS+pxYg+8+gVaHqQPyDp4QRMIUFWbKGJARKWFZ0TIlex2pqn63y4TzaMqNFmY7KkzYQ8z@vger.kernel.org
X-Gm-Message-State: AOJu0YyDya5CT/jCNAgPYPGdIJsBKRUDAzB/9IWmgqJ8M6/fpzkiU3ET
	PIERi5WzEyDTFj+poE3WPCNvLjCRO60EtbVNfsNY7LVbGnhjH+r8JzgCOwDbV5EXLYXOINTbUNE
	dDv0T538997cK0ORBEagAo4UjniOmIMjQ71yfeEHiLg==
X-Gm-Gg: ASbGncuEWyjRunMscPBWdDxfw+aNTUyblZG8JKDosvU1u2bpul38kfXr3au6VDFWdqt
	XcsSg6ko8xMZppPFdN637mshMjb/haNPwA/mW2HA6A1glFc6xjYt3UKvSRFE0T9GQWzqYczpWw2
	e+co6DPc8mrUoNbf5+m4D84OdYY5F+WCwedSotzVxHi6igbbSi1TgCUp/+zW1mHjDVDHW8e6xnY
	kYU
X-Google-Smtp-Source: AGHT+IFHaAxoYBbg9LXBtGJVpwf11YGEdCLkE88L9yAIytLzKSm9bsg1ZUT6QEZSsty4xseoM6W0eewH0Y9mwveJD34=
X-Received: by 2002:ac8:7fd6:0:b0:4b0:695d:9ad0 with SMTP id
 d75a77b69052e-4b10a915ec4mr58260861cf.3.1755183502991; Thu, 14 Aug 2025
 07:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-2-pasha.tatashin@soleen.com> <20250814131153.GA802098@nvidia.com>
In-Reply-To: <20250814131153.GA802098@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 14 Aug 2025 14:57:45 +0000
X-Gm-Features: Ac12FXzhuAauSUYd9gdMUr4m-BLBsxxrJtaDxuhGuUwdJZFXccXBv2CW6TsGSmI
Message-ID: <CA+CK2bBWEFUU728aQ++7Yp5qXApsHzOTjy=nLMyd7WE27RfQbg@mail.gmail.com>
Subject: Re: [PATCH v3 01/30] kho: init new_physxa->phys_bits to fix lockdep
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

On Thu, Aug 14, 2025 at 1:11=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Aug 07, 2025 at 01:44:07AM +0000, Pasha Tatashin wrote:
> > -     physxa =3D xa_load_or_alloc(&track->orders, order, sizeof(*physxa=
));
> > -     if (IS_ERR(physxa))
> > -             return PTR_ERR(physxa);
>
> It is probably better to introduce a function pointer argument to this
> xa_load_or_alloc() to do the alloc and init operation than to open
> code the thing.

Agreed, but this should be a separate clean-up, this particular patch
is a hotfix that should land soon (it was separated from this this
series). Once it lands, we are going to do this clean-up.

Pasha

