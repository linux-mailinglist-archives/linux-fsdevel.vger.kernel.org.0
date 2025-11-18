Return-Path: <linux-fsdevel+bounces-68826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE27BC67406
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D60DF364243
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 04:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB6B28C854;
	Tue, 18 Nov 2025 04:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="PCVedF94"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34DC28751A
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 04:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763440150; cv=none; b=Y6B5XoggTw2oGUi3ggWOl9iGwlEEKbIK3/MDkKR4GXObqtrlGSPlrUf1jBkUDGMDxRVbOaiTcLo0zdbCZnedFa20diccZNXHisRyZe9C/UChGz2l/hlv4WFrnzc6+N3zsKzNRndh7WCOSS6z0rK5QQwzN17bULcTiwOfYe857NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763440150; c=relaxed/simple;
	bh=X6KnXlrlW3t/I9mrc0okamZX2WiqE0y9NcPRZWpOOdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgMfrFNxnGaddW/2nQqwxg+xtHuvx2Nof5t9WuuDRzw4tC0A/BBfLBgbyUyC5lczOWHxhtnxsCFJEgRQrYOFQPi8vIa5tZRRhcMSIXVPxsysC4QIyYH3Kk8H8iyi8JZmOndnZUqUHx7aVuHzCzXG64xtWE5IOG0hY2p1NY++vRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=PCVedF94; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso8496141a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 20:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763440146; x=1764044946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVK4IdpOEfypRyCSONdTJzqLYJ2T4mhuvQFJg1heiHk=;
        b=PCVedF94X8LrJryuCcqF5hEsK2SqZcqiple3XkA3ILr5WOj6MYvnVM8RMKxL4c6T0k
         n6v0dQyNapdOomwNAMRT897eA9VGSrQ20Ho7UkoqLzB5ms1QD37IWqi3u8+uCr1REGxx
         vOESGmVIwIe8oPnnsNHRJKoGaHs7StUx+ckNZUsJFLmXyorIMV5HJ2eZ74XWY+IS/ZrT
         NO60eSOuNF3+KM6P5XJ37Jhb9ZB8IZxJ+VAwtkOz25D12NW5AnXSRv14CTDDoLlLQPeo
         UeZnPivTNCYoFOMNrzaB2D+KM4FuneVYFGisvGLNZGfH/eiOoyGz3E0xC11WOi/wM4ok
         enOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763440146; x=1764044946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nVK4IdpOEfypRyCSONdTJzqLYJ2T4mhuvQFJg1heiHk=;
        b=DwffVunYwt7144RiIfxRYLtrz7ZgGn6+kpPNZl4UqVM4qEpSJTJm/VY2xPLiity+MU
         DoF9FNKeK/YNLPWwq/yvyIV6X9k6MCDfLHwN//C2metFxLKEn/LQJp8HLqeSH8POcTdl
         54gFrNDOwUlHlcqrTL1AxP9/PRrbo760A7Kti0Xe9qKCXsQciz/j/cXFfVXNI5p7wZFj
         kxIU9x6xrsz3kEDKrLAgsDREBZBBSzIKjqJP01FU6Ten07VJifmNG6dayoMq98cZ2jJk
         CKweMZNgMPHs3rBhKp2BiGxN2jgNleHR+5YYUnXE+PN03hVb0SRJJ0rdTW8rmdYRrQZn
         Do4g==
X-Forwarded-Encrypted: i=1; AJvYcCUbFy+CNQ0LHnTlCF36EmgKUS7DN5qoe0/b81fyo/2k4qdBlpUvpo/S0/LOG+Teh9tpEFG2Rbb3pc7wUXAu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+5Tgs8KKLsqQgJgZFFtylFu+i/f+PSWs3OAb13E0SMt6CH46G
	CQRbrjEZQQ3VzaT3tsarTD1BLPW4hKoK1zDhuPzv/rEoeVHNERflA8P8jSPRL6CpBw1sZa6nfsU
	HSgIqa2xjf7py3WkV3JEsVkofLQSmxTFhNQrSxYqyzw==
X-Gm-Gg: ASbGncuvfA2jyM/UrgTjeg59mTty8/eU7aiY+11l/ge/u5H11OOi7YGW6x7WzmYwaLw
	LNm5Nn9MVZrN05p6Ie8DCFPzo8qSZNHe+iQxzZ9F/ldjGvzNtGS6DAOgUF22asrJ/1/38jvi1MV
	4BX8WipgInkcM0tK0g5660ItiUmHBVv3TTUYcoDkU2EGkyblvHyeVoCeL+B0O3EQis+G5/QTt3v
	72PqYkQ0wNxlP+p1nePCoEsypd1HCyv8AhXzB1TwwZn9U+GG1YjLjYSYt4soaDf6CezIqBe5+8g
	VB4=
X-Google-Smtp-Source: AGHT+IF6ySItcOMgaBoEyxRCTrysqlaU4//aieWHoBgnptA91clHqaU2ww5S0PiyBiCx/e+NYj7wY0E/YvrpgMWF5v4=
X-Received: by 2002:a05:6402:35d6:b0:640:9993:3cb8 with SMTP id
 4fb4d7f45d1cf-64350e039ffmr13236688a12.5.1763440146078; Mon, 17 Nov 2025
 20:29:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-5-pasha.tatashin@soleen.com> <aRoEduya5EO8Xc1b@kernel.org>
 <CA+CK2bC_z_6hgYu_qB7cBK2LrBSs8grjw7HCC+QrtUSrFuN5ZQ@mail.gmail.com> <aRuPcjyNBZqlZuEm@kernel.org>
In-Reply-To: <aRuPcjyNBZqlZuEm@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 23:28:28 -0500
X-Gm-Features: AWmQ_bnXjUULcNqlTihBFO8sKCACG8mKavb9e7Sf8PiMX_A8JxJdQG4B0RQX_fk
Message-ID: <CA+CK2bC1HviYczgs8=sh8Rt6rxgPgWuda4DGYpg+oLfHn5b2ow@mail.gmail.com>
Subject: Re: [PATCH v6 04/20] liveupdate: luo_session: add sessions support
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
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
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
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:11=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Mon, Nov 17, 2025 at 10:09:28AM -0500, Pasha Tatashin wrote:
> >
> > > > +     }
> > > > +
> > > > +     for (int i =3D 0; i < sh->header_ser->count; i++) {
> > > > +             struct luo_session *session;
> > > > +
> > > > +             session =3D luo_session_alloc(sh->ser[i].name);
> > > > +             if (IS_ERR(session)) {
> > > > +                     pr_warn("Failed to allocate session [%s] duri=
ng deserialization %pe\n",
> > > > +                             sh->ser[i].name, session);
> > > > +                     return PTR_ERR(session);
> > > > +             }
> > >
> > > The allocated sessions still need to be freed if an insert fails ;-)
> >
> > No. We have failed to deserialize, so anyways the machine will need to
> > be rebooted by the user in order to release the preserved resources.
> >
> > This is something that Jason Gunthrope also mentioned regarding IOMMU:
> > if something is not correct (i.e., if a session cannot finish for some
> > reason), don't add complicated "undo" code that cleans up all
> > resources. Instead, treat them as a memory leak and allow a reboot to
> > perform the cleanup.
> >
> > While in this particular patch the clean-up looks simple, later in the
> > series we are adding file deserialization to each session to this
> > function. So, the clean-up will look like this: we would have to free
> > the resources for each session we deserialized, and also free the
> > resources for files that were deserialized for those sessions, only to
> > still boot into a "maintenance" mode where bunch of resources are not
> > accessible from which the machine would have to be rebooted to get
> > back to a normal state. This code will never be tested, and never be
> > used, so let's use reboot to solve this problem, where devices are
> > going to be properly reset, and memory is going to be properly freed.
>
> A part of this explanation should be a comment in the code.

Done.

>
> --
> Sincerely yours,
> Mike.

