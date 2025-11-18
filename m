Return-Path: <linux-fsdevel+bounces-69004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07131C6B129
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 4206428ECE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E4B2D321D;
	Tue, 18 Nov 2025 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hBE8Scyy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0E33587A7
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763488744; cv=none; b=jvNv0x8ogM/intDQ2R+VpaZc6JxGvDu78qsoMAR7WAnW7hCRDejInKw7flyOhJZIswXepRo9K64BDdNnpECR9tJKQu8vwelaUX2gol8wvgWnTpkZxPCh9sGsj8irG6SwVjBptmLIweRb2u1JP1c5wtP9TsoRKDZQgxPdlZU8k5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763488744; c=relaxed/simple;
	bh=WoCqjadCn7E60Uv19TSWcPYC1liefLwhctkXkeCoKEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+ch/Bi+zj/A7qUWwZcLlYBJrJ9ecHvkmmnNKh6ZVu52Lr+I/3+QCZU/LwKnnEZ8/VKdpsIVPHT/L9yx0uRbGhKuvIOCEAKuD+imaGsaho+EndKNee3MF1DveAPWbtcXvINqnLR/1KPMJzjcn2LKk10xmNODgob8Ov5YZ5Dl8do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=hBE8Scyy; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so9282949a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 09:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763488737; x=1764093537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+caJNDkTSm4p2uWmUOI1wRaGCCJeFpF1smMqUtSo0I4=;
        b=hBE8ScyyQgzhLvo1smZoJ89RdTUtroqz12PxUGxCEd9bnqUAgYlKMPTi4uW40OfCS3
         y3cZKVNLk1caBrD+dKUP1SJpe0auqNx2Hxp4N/7h4JLhGToZsOMbOWahPxFVkURMmfm8
         tNz0CAg0cFw6SPbW4F7kwlO4w4cofgBFa+FZU94jVz5SpZr+BJK5Vm+3OJX2ELOHI8T3
         nvwD+U2y0EvErot6fxbz9paFPLLukbp+ly/+l7UaPIrTmPAIWl7v6ITa7KFZn0HsdEtA
         vfMGd+0y0KVYY2PctMKqTZekJ59H0OFBU9VuJ5kLI3hfyOwEHb8Eu/ShGrfZ88t2iwjH
         v8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763488737; x=1764093537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+caJNDkTSm4p2uWmUOI1wRaGCCJeFpF1smMqUtSo0I4=;
        b=psKfVZjp8L7owyK2WzkrSNrxNTGhDZIDtmhT27ykxzYeUd4pUU8l5rKGd7BSzFrpMK
         eAOCrPUOlZ/ImA41A5vIqgiZBEK/QRQ7Y+aG7oGin2JBGUA09AIWBPNYcHblIEJjGean
         8mXkyxJqmw84f/CYkT4E9RwXh0afYfM/cIRK7trOnsRiJhytCYwE2bZ2qs+xnM10/buL
         4vBhrLUJTOjxdoOyUGr11Ylxop5345wGhWbdWXNlzw6bK1pFfpZ4DePMGK/IUjZHgY3X
         0k7891YlpXmfCERfL4XB2b/KQNFFzZeNWcbLYf9YTHs01//3Zv58wankNdMZeacnv5pf
         9NgA==
X-Forwarded-Encrypted: i=1; AJvYcCWxICiXt9uSbB6YteIQLLBb9rBljMHIeqAq9NgrUK6+/ahCZI/FMVpgFKg1mAOwGr6GZjASVZuZgy1JnIKz@vger.kernel.org
X-Gm-Message-State: AOJu0YwVYf4yxW47OloerkZaryIJDrAUmhCZ24KTqW9ODhSEe1totWGv
	alwxcrMTwMdE23wvOk3/jeYEx8ShsGQS8UU2F/E79Amcjc8TlhjBG1gTFxUDZ5KixNqy46ZcpLR
	5XmnXGJWNEQyJtDCJYUz2zpD1vvzvU9PlZxkALFhHSQ==
X-Gm-Gg: ASbGncuFlrrrKmO/W25CBtOVOr3+2OG30oum+Fy4bhapxy/y6F7oLhcnIGKpFZdVfDM
	+oksXXxAbx4+1NTo985CFKF6x9SSEynphpXYQPJv71xYweoKKFZPMfMtivAUU06Ugt2b/RzLcFY
	z/Pd1G8JqTjVfa9h0UiSxj6rzlMKVuniA1c6wl2NgrQLpT5bbv5uKxsyqoXYk/N6Fld1n8ev6Qk
	ZKYhuxmIcQa+i/ZFJYORXcNoWnqUYJIzMeNbR7+OTT4DJQI28AQDETpGxsE1pErNGrURXfwFsx+
	EqA=
X-Google-Smtp-Source: AGHT+IHLtEGa6tvFkUsvSNc6SGJ8gqqqGO2E3eFWqdurGTWqPWn/X+W1lUYZN0I7kpLDC0TLDDfvSxnHQDVTVoLPRis=
X-Received: by 2002:a05:6402:26d1:b0:634:ce70:7c5 with SMTP id
 4fb4d7f45d1cf-64350e89998mr16647067a12.17.1763488737365; Tue, 18 Nov 2025
 09:58:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-7-pasha.tatashin@soleen.com> <aRyvG308oNRVzuN7@google.com>
 <mafs05xb744pb.fsf@kernel.org>
In-Reply-To: <mafs05xb744pb.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 18 Nov 2025 12:58:20 -0500
X-Gm-Features: AWmQ_bkVrSTIot3zGMN2pIgE0TFCb1-KBBBDf9maAEVJdIwW1B5_ckvdlEwn_pk
Message-ID: <CA+CK2bAqisSdZ7gSBd7=hGd1VbLHX5WXfBazR=rO8BOVCRx3pg@mail.gmail.com>
Subject: Re: [PATCH v6 06/20] liveupdate: luo_file: implement file systems callbacks
To: Pratyush Yadav <pratyush@kernel.org>
Cc: David Matlack <dmatlack@google.com>, jasonmiu@google.com, graf@amazon.com, 
	rppt@kernel.org, rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 12:43=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Tue, Nov 18 2025, David Matlack wrote:
>
> > On 2025-11-15 06:33 PM, Pasha Tatashin wrote:
> >> This patch implements the core mechanism for managing preserved
> >> files throughout the live update lifecycle. It provides the logic to
> >> invoke the file handler callbacks (preserve, unpreserve, freeze,
> >> unfreeze, retrieve, and finish) at the appropriate stages.
> >>
> >> During the reboot phase, luo_file_freeze() serializes the final
> >> metadata for each file (handler compatible string, token, and data
> >> handle) into a memory region preserved by KHO. In the new kernel,
> >> luo_file_deserialize() reconstructs the in-memory file list from this
> >> data, preparing the session for retrieval.
> >>
> >> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> >
> >> +int liveupdate_register_file_handler(struct liveupdate_file_handler *=
h);
> >
> > Should there be a way to unregister a file handler?
> >
> > If VFIO is built as module then I think it  would need to be able to
> > unregister its file handler when the module is unloaded to avoid leakin=
g
> > pointers to its text in LUO.

I actually had full unregister functionality in v4 and earlier, but I
dropped it from this series to minimize the footprint and get the core
infrastructure landed first.

For now, safety is guaranteed because
liveupdate_register_file_handler() and liveupdate_register_flb() take
a module reference. This effectively pins any module that registers
with LUO, meaning those driver modules cannot be unloaded or upgraded
dynamically, they can only be updated via Live Update or full reboot.

I plan to introduce unregister support in a future improvements to
relax this constraint. The design I have in mind is:
1. Unregistration will acquire the singleton lock on /dev/liveupdate
to ensure no new sessions can be created during teardown.
2. Verify that there are no incoming/outgoing sessions.
2.  File-Handler can only be unregistered if there are no FLBs
currently registered against it.

Pasha

> Good point. We also need when using FLB. You would first do
> liveupdate_register_file_handler(), and then do
> liveupdate_register_flb(). If the latter fails, you would want to
> unregister the file handler too.
>
> --
> Regards,
> Pratyush Yadav

