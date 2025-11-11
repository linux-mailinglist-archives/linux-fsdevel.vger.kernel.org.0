Return-Path: <linux-fsdevel+bounces-67992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 244A2C4FB91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 21:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C687234D0FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 20:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CBF32E699;
	Tue, 11 Nov 2025 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KD5Lswt/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A191F25783C
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762893618; cv=none; b=Euc54CCJBVSHH0yeprv1FGtimgE0Yn4yhapE8Lw3tNoug9FFwajZJfhYivO8nJPB+CmIIpdzojLT2Hmzj1QMljiOGri4KaT8MK0vQOerW9vJJEwgLZHl1a2b4yfF2cfBJrcr8ullPskN1Cfp9m9UzGisu9pUkVYK5M3cmEb+g5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762893618; c=relaxed/simple;
	bh=btQkr6RDk1NH/5MamMwUJDtwxh4vSiSBuYbejvufMhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpEdh47TNC87ZDwHyAanXe9eULrmhEz4pmGJ6NelqSHRso2c2XDSaWxL0uJ+qiBbRX0MiqS+9PPfuo+LcDoJOvBxhd1tdgpS3TIAUgj8CdwfRq0yWsx59ayRTwmo1amGqOh6OqxUnwHi17BbNPAgbjcBr2cS++SQB2DsblX5UTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=KD5Lswt/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so124204a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 12:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762893615; x=1763498415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FEWNC5DwWIOcHCGzzhjZ5KjnP7zvYaHcMNDin0urk5Y=;
        b=KD5Lswt/1taskpsK4UbBAHW1IBf8VVev9V7U45UKE64xy2AYPO3VgVc/SmD3/JAfnZ
         03z2LafjcCE210bfeqeSHQAcSvVAuWB47KCkcN9pz8ECtTurm5F1uQB7UKgnwFcJLljZ
         ZKcbyZ+QYVkwDBSoAcoeXg7wETYXdfyNz2k9/VJ2x3dM7s2xDHFfqJXQmsnHc6Bms7LH
         xXtW0yPdoQ+c2agBOnK3hMt9ytxudo82+A8pP/qd4z4doPgPCZcykWjfbPhzxhhBb+Pb
         7H4SLHPLRok3PVk9bv6iN99BW9U8Za5PPgCsDOYxgMlKyVKO84s1DVv+cB9illYj6yCG
         JlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762893615; x=1763498415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEWNC5DwWIOcHCGzzhjZ5KjnP7zvYaHcMNDin0urk5Y=;
        b=FLexySAkOIA8rRGcWVCKlXv0SnKzbKYylDl04ShHSfXdxVxCaPj0Q1XmwmbKVRicKb
         xb9Habti4DXNHXNicL3cfimHxZZQadJjDh9GsORJSCmwb3JxOhRvjNaByHrGDXTlk7hl
         MnSSzMzVylUc8dTSYCIm3cAxD8fiPcMUVFD+6BLknQcrvp7NX7BOhgxOkp++dGgUw9Bb
         YLIcdqGjLrC4CHVbVx6zbnCayHIS7tMmlGZ5/J+WzqV9k+OfMSl0DF6a5LSQNuauo378
         EtyVFFttUNKTgC7dxPkt4jj6jQX2vIxg8pKhKm94ZRXiJmRZNjbbl1IX8663SARoo22O
         guMg==
X-Forwarded-Encrypted: i=1; AJvYcCVtMD7fSCWOkUf5fz/IEjQcAwdYOciJWmG76I+H25EszmXmA3fRUACTcCzC8VjcmyrV3AUWY1mSzitM4gXK@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn3eCkDCKo3zJfZD6blB1RMXrjELRLzSmd6+8SGGhAfvRDHO3V
	F1z8kZ3E82r7i/DMa2qgj3d9ewwHrbMjkOitlP96OH/wph1YISL5M5S3/cbjSZ4ehV8wwTF4vJH
	cTR79CaxdO+GceoOFavNBRdK8W0GEdQDq2iryVUBpqg==
X-Gm-Gg: ASbGncsy9uYQVPEmhOyHh4YXgoVJsJBJSXT3elbTRNaEAezRipYq9rU2G+XG161CTaT
	3PfNRmtEwYsaFxHdTLLf7MUmyZQQ33+vbpx19Ig/GOFxChQGI0NJKHLvsgHtfIO2hFaqWBX4sX6
	IkC+fIqWsyMCTVpV793nuddvAR5/+wO+Ybsbw1kuaU8PjlbU26nR/54b8MpMUd8bUyNp+ymZibI
	cL0ntvr5M5kBFpSI5/D79s75EFECne5f9FsL/PpV0h5M6kHTiio7lBaUC1NKZ7w/8T8
X-Google-Smtp-Source: AGHT+IG2cjRv3TGWEc4gZfDUbaiY5wslxoai9FVdySiZOlZJ96VFj/VlY7pkuIOjpI5WMCQnGxd1eAfTceeYneOMjsI=
X-Received: by 2002:a05:6402:26c6:b0:639:d9f4:165e with SMTP id
 4fb4d7f45d1cf-6431a5755f0mr427744a12.29.1762893614411; Tue, 11 Nov 2025
 12:40:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com> <aRObz4bQzRHH5hJb@kernel.org>
In-Reply-To: <aRObz4bQzRHH5hJb@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 11 Nov 2025 15:39:36 -0500
X-Gm-Features: AWmQ_blaVxPLNZ6NFksFWHSVRdEa0McmUdt4XuCrjKEh2bGQvzq2cMu3aSw5QAM
Message-ID: <CA+CK2bDnaLJS9GdO_7Anhwah2uQrYYk_RhQMSiRL-YB=8ZZZWQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/22] liveupdate: luo_core: integrate with KHO
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

> >       kho_memory_init();
> >
> > +     /* Live Update should follow right after KHO is initialized */
> > +     liveupdate_init();
> > +
>
> Why do you think it should be immediately after kho_memory_init()?
> Any reason this can't be called from start_kernel() or even later as an
> early_initcall() or core_initall()?

Unfortunately, no, even here it is too late, and we might need to find
a way to move the kho_init/liveupdate_init earlier. We must be able to
preserve HugeTLB pages, and those are reserved earlier in boot.

Pasha

