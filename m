Return-Path: <linux-fsdevel+bounces-28430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3E496A243
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812811C23B7B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF4719149E;
	Tue,  3 Sep 2024 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uJjnH20S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3941B18BC32
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376976; cv=none; b=sw10VsdQZ3R7arCFOLupWMbjh9QZz4U+FUeXRKqqzpAMsaBYYRnboEJWCP7fLiVYJZTO6Iirp5WUX9VAEGZdLXrCdVd2KGw+sINYi0IV+KZdIJmEn7JID7WNFft98czrv5ehSHnpsnHV1K1GxrcXRDPsg5RSJHqUpKrRHKQSZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376976; c=relaxed/simple;
	bh=m9+EEInhbUeEbxE72IFhmmu3hDRmd3xy+IVSGpLdFbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5vF8ABUiNjlfYN6fJjZv1F6LHPIqB9PkEsdzHiEVThqKsIHXuQTjVZxqaORitCNrAj/0KhVtO1gZkOHhVvXGnB689AE5P739sKhoD3swfHulFJuZlkm+3zjn7Muc+UM+gnXvBJJ4AW7X3wZpun6vgaaeRV+NywCc8ZI8UmG7xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uJjnH20S; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4C6693F323
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376973;
	bh=W2G+B52nfpWV66Muh3vpy4kJlGcNs6y+kgmZnTJmrIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=uJjnH20SbprhUoGRITJrRa6b+tGwEALaB8umZjbcd4e4CKptbIjCl+PUttUtaM7jH
	 QjFWXH+Xlzbat7bsodTueLclJNML8TeBx907/dwiJ00Dk0GMuXfdo9Ie1jQ4vxtke9
	 FnzXiRKi9KRE0AzhkeqkO9JIaoJschZc8uhQep327tmTLv1TmPXAOo/919pm/WQPKa
	 pCXEzvIEfT/dq/Hsc8oLjwMKCEtTmXlneiOi2b4rKzFi5u8HlpOxFTgAgLrPE8IAdv
	 D06linihLymHg2JkXVQOWDsf2e0QR9s0PROhOdfMmK8RGc8yVDoGi2Nsm5ISTToDXu
	 R5E4Qyh+5/pCw==
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-846c964112aso1890153241.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 08:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376972; x=1725981772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2G+B52nfpWV66Muh3vpy4kJlGcNs6y+kgmZnTJmrIE=;
        b=ef75UhuX3inVALo4fnvwXKrQQhajk0CciOMvA3ChCtEbuVW1SwO/Ky94yHauCKbyok
         gzFEfG1PjIlYU1cWQZf9ZmwlavzODse6EKCnhtT3+FU6/z/7kJyNFbPWV16e/LjmOrUQ
         oWU4fcyPhjI9DMPhT/qqr+J7Wv+O5RyQLEwOaXiMKxwmv2EmrttbIPxb7TRz+zRN+5HN
         U1vntexMFNqWwWKgBwJbLCEYQ6FE7HY5aDG/aokdQHK/uBxtypGuPb+PNzS8TvDyOrfK
         //usSQjsuzW+LLNA7Qaz2375e2M4dvlhQen/cI7GK41Nsh84oBFyu8Fbn8IJUvln7MFK
         VeHw==
X-Forwarded-Encrypted: i=1; AJvYcCX58gG9zcfocMpr2E8VbHeysfry5uWdH5xLFOlIox3RINVB2nrWn2CnotiRh1DgNL6sNCv9wwHelpXK7quB@vger.kernel.org
X-Gm-Message-State: AOJu0YxOU60HpAQn/pumie05Xsd0n5BYxRsPHueRtcGCaEx7JmDz/4MG
	JmmbWmUZEixk7n9a82AztcTbxJbuBV91auM0SewQ2OpgPv//jtjGOnuP840/GRuTJX+mIxV4sfR
	ZZSIOLXgBEByYCNftFjD8Z/zg1dUtHg77XwbiENAyobUCJ/bdcuKo34I3bR9GFYlVKtuRyLGY4L
	zBbtRNK2Cn3VgfxJD+pm78IBGcwxYRxrH8nXu/lAUG2gPHsv8eka7pVA==
X-Received: by 2002:a05:6102:a4e:b0:48f:3b56:a184 with SMTP id ada2fe7eead31-49a5cc6db43mr12611170137.5.1725376971879;
        Tue, 03 Sep 2024 08:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqP62OcNf7wEbEGUh0Ef4GQ2I5xhOJ5jFy/dKjwvZYDPHJMhkqmagPYM5wf6p8PUArP9Woc2GaZRuP9DHMNTU=
X-Received: by 2002:a05:6102:a4e:b0:48f:3b56:a184 with SMTP id
 ada2fe7eead31-49a5cc6db43mr12611149137.5.1725376971591; Tue, 03 Sep 2024
 08:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegtixg+NRv=hUhvkjxFaLqb_Vhb6DSxmRNxXD-GHAGiHGg@mail.gmail.com>
 <CAEivzxeva5ipjihSrMa4u=uk9sDm9DNg9cLoYg0O6=eU2jLNQQ@mail.gmail.com>
 <CAJfpegsqPz+8iDVZmmSHn09LZ9fMwyYzb+Kib4258y8jSafsYQ@mail.gmail.com>
 <20240829-hurtig-vakuum-5011fdeca0ed@brauner> <CAJfpegsVY97_5mHSc06mSw79FehFWtoXT=hhTUK_E-Yhr7OAuQ@mail.gmail.com>
 <CAEivzxdPmLZ7rW1aUtqxzJEP0_ScGTnP2oRhJO2CRWS8fb3OLQ@mail.gmail.com>
 <CAJfpegvC9Ekp7+PUpmkTRsAvUq2pH2UMAHc7dOOCXAdbfHPvwg@mail.gmail.com>
 <CAEivzxd1NtpY_GNnN2=bzwoejn7uUK6Quj_f0_LnnJTBxkE8zQ@mail.gmail.com>
 <CAJfpegtHQsEUuFq1k4ZbTD3E1h-GsrN3PWyv7X8cg6sfU_W2Yw@mail.gmail.com>
 <20240830-quantenphysik-kraulen-6ca8cfcaed70@brauner> <CAJfpegvFdGWuBnJzM9R_R1vrZbVE=8CcnEq4ZLmR5V6iR0vROg@mail.gmail.com>
In-Reply-To: <CAJfpegvFdGWuBnJzM9R_R1vrZbVE=8CcnEq4ZLmR5V6iR0vROg@mail.gmail.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Tue, 3 Sep 2024 17:22:40 +0200
Message-ID: <CAEivzxd_a-HbiajyxmeyUR7g4EFQJym6XWt_S67eKR5C1fMc6Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 3:49=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Fri, 30 Aug 2024 at 12:57, Christian Brauner <brauner@kernel.org> wrot=
e:
> >
> > On Thu, Aug 29, 2024 at 08:58:55PM GMT, Miklos Szeredi wrote:
> > > On Thu, 29 Aug 2024 at 19:41, Aleksandr Mikhalitsyn
> > > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > >
> > > > Let's think about it a bit more and if you confirm that we want to =
go
> > > > this way, then I'll rework my patches.
> > >
> > > And ACK from Christian would be good.
> >
> > Yeah, that all sounds good to me. I think Alex just followed the
> > cephfs precedent.
>
> Okay, so please drop this patchset from your tree, then I'll have a
> chance to review when Alex resends it.

Dear friends,

v4 is ready https://lore.kernel.org/all/20240903151626.264609-1-aleksandr.m=
ikhalitsyn@canonical.com
and tested with virtiofsd:

# ./check -g idmapped
FSTYP         -- virtiofs
PLATFORM      -- Linux/x86_64 ubuntu 6.11.0-rc6+ #21 SMP
PREEMPT_DYNAMIC Tue Sep  3 16:48:58 CEST 2024

generic/633 1s ...  1s
generic/644 0s ...  0s
generic/645 19s ...  18s
generic/656 1s ...  1s
generic/689 0s ...  0s
generic/696       [not run] this test requires a valid $SCRATCH_DEV
generic/697 0s ...  0s
generic/698       [not run] this test requires a valid $SCRATCH_DEV
generic/699       [not run] this test requires a valid $SCRATCH_DEV
Ran: generic/633 generic/644 generic/645 generic/656 generic/689
generic/696 generic/697 generic/698 generic/699
Not run: generic/696 generic/698 generic/699
Passed all 9 tests

Kind regards,
Alex

>
> Thanks,
> Miklos

