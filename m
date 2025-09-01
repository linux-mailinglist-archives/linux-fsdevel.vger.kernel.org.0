Return-Path: <linux-fsdevel+bounces-59884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABD8B3EAAD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2FA27A27B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025B32D594C;
	Mon,  1 Sep 2025 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JUg8uf7X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA862D5943
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740181; cv=none; b=QbiBVV9qQUInLGOI55fe2efbC2vRK548T1LfYsbGmWTsxr3AZCM8wNCScVMuSWADKPGhEFtMeoymPIiVjYlEl0bGZvDN6KOEfo3FAfmXtB7f83vjvbAAY7GQBs1yqzPu0oBpmBh5/TTFZoATa4OkoWURMBSIMLXKmbraiHwLz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740181; c=relaxed/simple;
	bh=xqYJE8gaVl+wcM64SwwllZC2T3TpIFwcaihrMWL4cIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNjxpyQceEshMz7J9SmffSVT+gQVPRNB3xXAXILjhSKTS85Z3wVs282+7YQgwlqJHGInqP/jDhgaCkLCEfp0ZYTW1fR8p0M7G8QreWrNnnjikszGJ9Xu3ZPKEqc0blpyFkd7iihqbeq30KpnSodhOhFzJr2AZGYsvku7f7Lee0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JUg8uf7X; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so659913666b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756740178; x=1757344978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqYJE8gaVl+wcM64SwwllZC2T3TpIFwcaihrMWL4cIs=;
        b=JUg8uf7X+sd62dUrgDjDBARVHfoecLgogxwr/NGwQktafn3QHdHuM6ay6REiyqEFmS
         nmOeoDDM9b9hytnQd0qI/VbqW1NCOklq8AO/T+fuchWKYMiCDUy61IqQeOhpV/3f6tQ3
         CpLvzDZIAFfU7+x23GATwYPeXNAorhlKyLAFL8gnHRaRMM9PGvC+h96SVhwk4l/N/o7I
         PldHfQwA21oFYYkPPRs1lQ6QSZ2wYskEL8j6kJnXtTM8sawPhvef2FkELIBus/zTNWMZ
         f8UYKsibuCgIB56AZzfHbexEjbhTbR0mYDE9zkZ/IdA4f+GEcqNOc7TM6qVcXk0mIdtI
         O3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756740178; x=1757344978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqYJE8gaVl+wcM64SwwllZC2T3TpIFwcaihrMWL4cIs=;
        b=CGM1kJjxLOUMmpmxIwJyRXWWt8CMWe9DyFGhZjLDUtM2UQREICJc7Ro7ZYydcHgEKD
         W0VysthmULvEYWfulHhuGqWzlPOOGSuHc9n358nZPoYaS3i5B7moHIrkD7G06t2lc2vL
         KlITPMZHBBBh7ZGScyRDx2wPhiVcCmSyfUn8TJvlL5TyUhbsy1eI5I3bTS7rEeLV3yvy
         XZ+1+W4kw+7bFHElnpUUuAxI8hu8/KHG2HVB2UBG/sE2ze4fJ417pF2SN1r8FtEH6ok5
         /zI3V3V9jx2PWvZDqm0/htSNdsTaZzAsQ4iDcNw3u+gK5h0NtctHqGpzKCgBVh+AvGN/
         CxPA==
X-Forwarded-Encrypted: i=1; AJvYcCUS13hb4otCNCGZOdDnJbH0kFoDkCHQXi8yCCf+fMUnrtImD+DbiPoj0DCmn7UEU5QuGLsnv0B4FOpqFELq@vger.kernel.org
X-Gm-Message-State: AOJu0YzlRNAzlLwXWCnnboZRsEmx24ZXmnevs7jREW/PYXmhWWklw0LP
	KnCIkNmJpWcuxBN+/kwMgQINCcirAlDK7XFu6t/8FuvVKgAVu/XF/Alfhs5tYNKHADL2+GgSf2o
	9CyWqRO4adr9vTicYL+i9S6Sr22CAlL6CS5GcUTY6Gg==
X-Gm-Gg: ASbGncs0i8tFvwsWwpR3Py/uHRxdnM4M/J3MAUsys/SG3QJKKjxc1h9gkdaXx+Kyqxl
	KTXL4WqvN3s+qzdr5QT4jEjngNHSEaUd+rmnZ/u/f2NwBYaEPPH/5vCQTp2PpVXO65DVcaNqN3h
	BUtAnk9uKPRIlE+z028Em9OGeDY68xmBtLKkJJ/9YEMgQYGbjleN/1mpjJwMupUbrBKtXUQqj6U
	iehbIBcwj3GJNoAzOVMI7B+z6GgggDwxmY=
X-Google-Smtp-Source: AGHT+IGyHGBQU5Fmr9N1bQCrhCA+i8zJzAFx27YAdwJf0bpouLhs7aYdtEtaq8rinlUX8phhR2x58GzGpQKldL70zDk=
X-Received: by 2002:a17:907:60cf:b0:afe:a7f0:80e6 with SMTP id
 a640c23a62f3a-b01d9756fb9mr875954466b.33.1756740177075; Mon, 01 Sep 2025
 08:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-7-max.kellermann@ionos.com> <ce720df8-cdf2-492a-9eeb-e7b643bffa91@redhat.com>
 <CAKPOu+-_E6qKmRo8UXg+5wy9fACX5JHwqjV6uou6aueA_Y7iRA@mail.gmail.com> <0bcb2d4d-9fb5-40c0-ab61-e021277a6ba3@redhat.com>
In-Reply-To: <0bcb2d4d-9fb5-40c0-ab61-e021277a6ba3@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 17:22:45 +0200
X-Gm-Features: Ac12FXxiiebv9X2d18G9zaz1-52NeLol_OdOPtBiylMXolSmoqbk-OqNT_yTCiM
Message-ID: <CAKPOu+8SdvDAcNS12TjHWq_QL6pXnw4Pnhrq2_4DgJg8ASc67A@mail.gmail.com>
Subject: Re: [PATCH v5 06/12] mm, s390: constify mapping related test
 functions for improved const-correctness
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com, 
	willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net, 
	andreas@gaisler.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, weixugc@google.com, 
	baolin.wang@linux.alibaba.com, rientjes@google.com, shakeel.butt@linux.dev, 
	thuth@redhat.com, broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, 
	mpe@ellerman.id.au, nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 5:11=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> >> Should this also be *const ?
> >
> > No. These are function protoypes. A "const" on a parameter value
> > (pointer address, not pointed-to memory) makes no sense on a
> > prototype.
>
> But couldn't you argue the same about variable names? In most (not all
> :) ) we keep declaration + definition in sync. So thus my confusion.

Variable names in the prototypes have no effect either, but they serve
as useful documentation.

Whereas the "const" on a parameter value documents nothing - it's an
implementation detail whether the function would like to modify
parameter values. That implementation detail has no effect for the
caller.

Of course, we could have "const" in the prototype as well. This boils
down to personal taste. It's not my taste (has no use, has no effect,
documents nothing, only adds noise for no gain), so I didn't add it.
If you prefer to have that, I'll leave my taste and home and add it,
but only after you guys make up your minds about whether you want to
have const parameters at all.

