Return-Path: <linux-fsdevel+bounces-56554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98651B1910A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 01:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B286017BE31
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Aug 2025 23:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6B9204592;
	Sat,  2 Aug 2025 23:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cgPACfat"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0735979
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Aug 2025 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754178410; cv=none; b=VosqJt5Bu4oTJUSKFM52/wQ9YNCEz4UxyacB926gQf18PoTGaxzjynAQ/25Mm1da3mjDF9cCskM4qTpLBK/qMR6SScqpTajQ1xjWJipT13KKnh6VIc3xLpJZGAE7HE/Jj/cgUR5tbpFdnlaWS80WqUeURTOQ33fRdw59qrmqiIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754178410; c=relaxed/simple;
	bh=vAc/4KiHAcjlsBQPHI3wMhShkkf1hfeQY3lbP94F0mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f24uuItIC5Mjy9+KLpmfrOM7biE4gYK1ReFcbQxlHkzca4B4c3GYAftufZct95b2boC4J49C6fPOgvoe98QvikrESGT1BSKbOGBehSA7p8WDTcYcLCUqnBiSFf/GlwgMBasQ3JqZPxmdWcGw4Dxzogm6+VWsWmn1YBJ94opBW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=cgPACfat; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4af156685e2so10320901cf.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Aug 2025 16:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754178408; x=1754783208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omSxCOyrH+cAC0v6maS2PTOyG9YcJYfYvPlLW3DY1LU=;
        b=cgPACfat0WhI8UuC2n8WP0kbRDCjkhg0j6kz0R6iMWhaa83EHI+pZc8A9rse91mHpG
         URd5Pm5YArkSOGxuO9aq/aSLMYEqFjojqI/lfgVjkqc+djODqw0ow28sKDEkzjmwvvSM
         HeKUFh7gMBei1E4OxNZwqzql40QU7t/IJtPTvWjTdMdbAhlYoIqrGahPzOm4zRPD2gZF
         blFBD4UxSdcl8NhLw3ebkw4SfL8NACRQ6ZvntGH7p0RLidog89esDacio51ADmAHbVe8
         vvo8rFXGFojfzfswxTN+pfspK5Y2FDQh/2jktHBQbaf4vASEjmgG3KR40W1FSK3U4wni
         mIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754178408; x=1754783208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omSxCOyrH+cAC0v6maS2PTOyG9YcJYfYvPlLW3DY1LU=;
        b=nS8MC/XEY+Seh1D1I+x8ZAavSYVO+3eTdeTsm1inwJKlCyhZWo2QO27Ma5XVZPizv1
         mNzzKbeYE/YislsxO/7Je06EssuD+jixZZ1bm8b9boSyH/5O90z2TNMkL4XjrXMw4uCq
         DiGIIvmBOpu0Mo1C27HD1xGHi2hqKOK9+OIrmBcW2aCLqSY3zINro7WlGealDyQ0DNyY
         qWn096Ztqtbpo5OrA6LiU9PLPvH0Id6CbNcrASgeERWIt9bdnE/MkTJfsjIFoQAoQc+s
         tgB0M4iVw1bn5oyjGRAIY+vIKFmkzSkrnFqRPsZ835ZMdL6FHzLwq6JUGDXNwtB+T7Zu
         gyZA==
X-Forwarded-Encrypted: i=1; AJvYcCU9cXjl+O3C2/kg0m0CSaBhI6/h+kUqDYnVSFCEFfiyOFmjygdAY3m4pxcCeCa17oQBLOYO6CEORo85yRDu@vger.kernel.org
X-Gm-Message-State: AOJu0Yya497yQGQaFOyJmP6hm9p4408TJLqzknl7ECjxaZ5WgOYhSTPl
	kQCOVWEPLXmuoAAp/KnwSajjdw9vL2CPVORK1v8OOLJiJSy0REYc+wIvXjqz0rwZOpG5Fe43RT8
	DygNp33fjlk4oKXv2CZOqSi3tz8stwC5T9/Upegq1qA==
X-Gm-Gg: ASbGncuyCgKd6rWVbr5cxqOV2Y5bQ0Y4fLJnL4m1PuUdmE6p+2dzgqRNQ1WoyrfIJMb
	YVtp6wDZAj0WvqBvPllrEOnrrJQz2FVPQnDTWYz7E6Tu6HZkpTaNirFNSiYHAz551NELVaFCg16
	iUEbjm3+7NNPGWti1ICpi//Zo81a0i6zffWoXjFhLIQ8QTmFX7uGG2MNWcW0pOQE9wg9aU1qDIh
	287
X-Google-Smtp-Source: AGHT+IHdEITyYGYGGvkUJ/FLXWfXeXO8iQNocqY+DuXZ+nO0UMVJgqKLU07m6mpEY1xZc8NU3/+RPBwpxH4hgExqjBU=
X-Received: by 2002:ac8:5e4e:0:b0:4ab:3963:c650 with SMTP id
 d75a77b69052e-4aef16dc96cmr147684491cf.10.1754178407719; Sat, 02 Aug 2025
 16:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-10-pasha.tatashin@soleen.com> <20250729171454.GO36037@nvidia.com>
In-Reply-To: <20250729171454.GO36037@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 2 Aug 2025 19:46:11 -0400
X-Gm-Features: Ac12FXzVHD70UwSnRqGNkZr2cSuqC2q4gMi23eZp3qK6a2xJfpUPm-pdMLJYecM
Message-ID: <CA+CK2bDz0t4+r9Yw+rpf_8K_GFDygXQ_b6wvPFtNYkssfX7wew@mail.gmail.com>
Subject: Re: [PATCH v2 09/32] liveupdate: kho: move to kernel/liveupdate
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

On Tue, Jul 29, 2025 at 1:14=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Jul 23, 2025 at 02:46:22PM +0000, Pasha Tatashin wrote:
> > Move KHO to kernel/liveupdate/ in preparation of placing all Live Updat=
e
> > core kernel related files to the same place.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  Documentation/core-api/kho/concepts.rst       |  2 +-
> >  MAINTAINERS                                   |  2 +-
> >  init/Kconfig                                  |  2 ++
> >  kernel/Kconfig.kexec                          | 25 ----------------
> >  kernel/Makefile                               |  3 +-
> >  kernel/liveupdate/Kconfig                     | 30 +++++++++++++++++++
> >  kernel/liveupdate/Makefile                    |  7 +++++
> >  kernel/{ =3D> liveupdate}/kexec_handover.c      |  6 ++--
> >  .../{ =3D> liveupdate}/kexec_handover_debug.c   |  0
> >  .../kexec_handover_internal.h                 |  0
> >  10 files changed, 45 insertions(+), 32 deletions(-)
> >  create mode 100644 kernel/liveupdate/Kconfig
> >  create mode 100644 kernel/liveupdate/Makefile
> >  rename kernel/{ =3D> liveupdate}/kexec_handover.c (99%)
> >  rename kernel/{ =3D> liveupdate}/kexec_handover_debug.c (100%)
> >  rename kernel/{ =3D> liveupdate}/kexec_handover_internal.h (100%)
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thank you,
Pasha

