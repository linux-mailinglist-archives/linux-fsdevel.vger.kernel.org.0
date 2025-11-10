Return-Path: <linux-fsdevel+bounces-67716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5943FC478D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EE81886444
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C85E257820;
	Mon, 10 Nov 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="EU27gWJm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12DA241103
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788723; cv=none; b=gN3So95Uw1AQNFho5/GruZaBsSWkWx8s8vDIIPJwG8zMCIvVmFD/kJlET4GAMSaVoeIJOjVy+iXocghwBVTJyc+8xgAWIA8lvJaZjvAk8hOfmwAxl+vOe4lb45O4xk9G0Wq1iJlWVuXPaG6TV91ayAgZJyZj8nKySJtKIP9V/nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788723; c=relaxed/simple;
	bh=9h+ZKAhSsqgldYZEpyKXHMieyzaB7ycGyDH+cOcDlpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixw4TmGIal/b2+r3AvmHdd/LjPlhRIu2jKQI334KFFJLunnpjDcLkqeGZK6aqBSLWQALXJDa0yci2+DQF8YDLYYPY67C4wcdTutaSc7lzpSZagbHGwOX87QafPao7Aap6EHCVGOqUOonOmiNwkEoNPzPGyNCqK7eCXWyTxUYnEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=EU27gWJm; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640ace5f283so3854528a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 07:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762788720; x=1763393520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvyB1b8oEOYU6YUvXYl67lC2NdpCRz0gUoF3IKmaXbs=;
        b=EU27gWJmq9JMelxQDi91PUccxgQEgBJt2PC/4+W9A4/gHw0peAFW15LiEK4TPsKvBo
         pVQeWBusfBajc+LtnW3SssKIsXnO2vYY3l3HG0t4HZUns37MbBaAr23rMcPlzyizQoit
         RXXgr+RsqtarA6PWSrsktGuX89tEJgR/XBUab5cSnWl0FYBk804f3DTAANJbMbeEEH+a
         VXOJIiMC2GskgXImXbKqPAs7v4Iz895nfsBByO0xuHQ1SWYaoUm/IYbMSKSjjTXBoD0y
         nBoO7Jfyh+yFLCY7Cx7/o4NUzgN4ReN7mSDzzMAYikRWoUL58o2kxL7Pk+Irpwvm0zMf
         bGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788720; x=1763393520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yvyB1b8oEOYU6YUvXYl67lC2NdpCRz0gUoF3IKmaXbs=;
        b=t9yWuWoNo4tghXoUQpPupMfVS+yj7DqFnKRrPk9cXFyZgpTO4mYxNC7oFzqpz4Vsri
         rEqwc93/btg7zBOoz47+Cz8+UCsJ0t21J6T2UtgwdYkC4cDXBlIfOeI98vOGofoENWOv
         p5dkYVEeS+oD682BFoQkQ9qGPYPjm0UtbrnNQ6G4BS/WBu2/Yr8Jblxu4bOYH0T47FmU
         f1QXLrscDwp+dLD79C9XHl+yQu6D0hgFNg92P7YStSRJtAGhXTeiRof2x9EjPvidE7YP
         TBN1uPoryHs4s/m+xYhSQBcubq9xAAum5XbdA++rdEj7hl1A5vei/bMEy3vMVPxGrBRm
         h38g==
X-Forwarded-Encrypted: i=1; AJvYcCWMPvw3+jcwHp6jVEwXe2JH7jr9Kcsdn4PyCNACrbQULFzMtvK+BddugRO2aon9D9O/HUgBWnacOR/Dc4OT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy64FpiCveDZnyv7Xqm78dMHVoUzk/Gq/9Id06zaL6NufgvUAS8
	Rtn2BCZo/fFmCCJzMUze3EzcGc29ztTqPMv9TJQYuFQ6KjFWmUAjvsCTVyjIcRi5SfRIDvNnstD
	/BukDVqEOtPCbttzMdhfa3x1QzXqgAwBPvKu/WOWE/A==
X-Gm-Gg: ASbGncvtOgwkeQJT1AEVU1yyNAW9FJC/0KZzJMmJJvbtt6MVeBB/r6Yabb/oVKiU8WD
	F9kiIPJzdRf04g3YDpA4cgeQ0yG6KTdaghOJtHoftwBWzatUchFfO5KzlDjMniwDdJAX6PRbeCu
	HxBg2zypSna741FF/sCeODgjGPnOcT3ULnHfEDjEJdT2+t11mdZdgWzj6WNz/rJ6MLYcIPIY/tZ
	Bhp/9JCj2P8iyNKEpltpnXbnDf7B5wdZEZOC73gJ3OpdTMS/O0tvTMtyA==
X-Google-Smtp-Source: AGHT+IEWEmCpMEiE/sigVWI2wEcl1lVXHLXnEbH4KM274tOZXUBy76PsgNh+OSo+pFw8/8SS+R3xNlWxCqdsS2OcqhQ=
X-Received: by 2002:a05:6402:51cd:b0:63c:4d42:992b with SMTP id
 4fb4d7f45d1cf-6415dc1304emr7523926a12.13.1762788719813; Mon, 10 Nov 2025
 07:31:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-6-pasha.tatashin@soleen.com> <aRHe3syRvOrCYC9u@kernel.org>
In-Reply-To: <aRHe3syRvOrCYC9u@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 10 Nov 2025 10:31:23 -0500
X-Gm-Features: AWmQ_bnDFpVyCmvtk4rzMsE7lIBuj-Os5t1X5u5kjgkokRKpm2UiGZaOTcTCYY0
Message-ID: <CA+CK2bA=cQkibx4dSxJQTVxVxqkAsZPfFoPJip6rx8DqX62aEA@mail.gmail.com>
Subject: Re: [PATCH v5 05/22] liveupdate: kho: when live update add KHO image
 during kexec load
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

On Mon, Nov 10, 2025 at 7:47=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Fri, Nov 07, 2025 at 04:03:03PM -0500, Pasha Tatashin wrote:
> > In case KHO is driven from within kernel via live update, finalize will
> > always happen during reboot, so add the KHO image unconditionally.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index 9f0913e101be..b54ca665e005 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/kexec_handover.h>
> >  #include <linux/libfdt.h>
> >  #include <linux/list.h>
> > +#include <linux/liveupdate.h>
> >  #include <linux/memblock.h>
> >  #include <linux/page-isolation.h>
> >  #include <linux/vmalloc.h>
> > @@ -1489,7 +1490,7 @@ int kho_fill_kimage(struct kimage *image)
> >       int err =3D 0;
> >       struct kexec_buf scratch;
> >
> > -     if (!kho_out.finalized)
> > +     if (!kho_out.finalized && !liveupdate_enabled())
> >               return 0;
>
> This feels backwards, I don't think KHO should call liveupdate methods.

It is backward, but it is a requirement until KHO becomes stateless.
LUO does not have dependencies on userspace state of when kexec is
loaded. In fact the next kernel must be loaded before the brownout as
it is an expensive operation. The sequence of events should:

1. Load the next kernel in memory
2. Preserve resources via LUO
3. Do Kexec reboot

Pasha

