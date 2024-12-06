Return-Path: <linux-fsdevel+bounces-36683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E2C9E7B6D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 23:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7E2169B63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 22:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF881D6DBC;
	Fri,  6 Dec 2024 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmeNtrj4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164CF22C6C0
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523100; cv=none; b=rraaknSvYNnzHEw0FeAZrOEOfIdGSSvwjsGF3IKmOoNGFH8ZCi72HgLIGcFKFTwX9pVGX5NoOkYsA5+pavSRlg+Tqp9AVdsl7DaUqBX5fOfn1HQGeHEZGwwhyfzR9VSJzCplkSNQDtLjyk6v0FHXyyUhEI9aqUAZDM+eY2CNVqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523100; c=relaxed/simple;
	bh=dTTeGkhyYWWjtm9voFtufPCZ9ycQ8G+ZSL8JMapEs8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMpROvXiTWwlEVMDscTJjIzuJLF2ku34MaHgnA7kNbdQ4q24+Vk2O168E44NlPxVjWUhcV4fJlLNHGQaa7t03dbMLKzoHEvE5wP6w4IwLsKdnE3YcFYj8ceWn4xKrpgBnpVc3eN4WpLNClijb0djjSx4KvbFh+z6mPgpk3emMpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmeNtrj4; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b1b224f6c6so276853485a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 14:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733523097; x=1734127897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTTeGkhyYWWjtm9voFtufPCZ9ycQ8G+ZSL8JMapEs8c=;
        b=BmeNtrj4a3f08Ofnz/6VdI0RUt8f4LUf0FREq56daj6AEEDrg/rpch4rt/DSKZihIa
         HiQVW6dzeL7zE+am/0XZcHx6Q+tjrRRhFdrwkGhCD3okg0DFxXsSyIMVPb04lCN1X4BP
         ilWN+LZXH2HCqa/aaDyDQPPaftgI+OGm0vmSgkhDSBQuv8/7Qd0pm+MNX5JnC4ZwtU9F
         C5FMfIzea+I8JB2EsgFxkCTY7bfLKmbP5qscrXtrOWJc/HuPJbG4ggYQMiBMF5v7dtuC
         PxUlUdSSJ7i1MLc/6O1IWnCWpP5FdDGW9I4hu1fIZMKSwiOE2kQRci2peqyS4nuTPYDD
         2ISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733523097; x=1734127897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTTeGkhyYWWjtm9voFtufPCZ9ycQ8G+ZSL8JMapEs8c=;
        b=mzhp5A/3g/V7lxDcT1c/rNDPK4g8RDjxx5TXiWWDehdpgLYNg4aRE2Tn6YmU+lqRCQ
         054O+xKOuYsGUxEus+YyyjwZLlZFDDg4cKqgDPT0V9to0D2/gcrcjz93/y2bA7lnbptR
         sGOwZu5J3Okn/ZM0MS8t6RBcWPDYruvUJYZotLSiPzDb+CIBgiqqBnD4i0rRrDwY/n0W
         DVUNTn2+tf5AB7vhHjwEibwwEJ5OpzaZD9bBKdr0q/6TsEl/m59stlmh3g5RlqaDaV5T
         hYt6Of1rcYX5sNeoQNUi5spWZMvOEU3NszZ7tmia0505S0QZ6VtXaUkuVi6hE8ATln5P
         sXPg==
X-Forwarded-Encrypted: i=1; AJvYcCVjVkigHvj5pG5zdHWv4spS2yk7bMbxkss0jJ0AUxWDtzq/1YC1TDe0I7v5LZkiEYcePAvp7DSV72pcg9FF@vger.kernel.org
X-Gm-Message-State: AOJu0YwVQFYxOUb+6c3f3rMwcb8FigTFn1Gq9VnCan1uMY6nf1MKw2+W
	AHihqy0WbXy+bMTxIMuoCBnva9SlvmAN5npC3632kPeVEYNAgbDjQH4FfMhk7FtfVLLnuwL8gd8
	jeAJGDA2/p+4q8taPvPygTVlqdbU=
X-Gm-Gg: ASbGncubp6hSRNYY7PctJkeJzXPSO1w6hXCNWTsm8zYHKdlmSXl/w+8pEwMsW1G9pWt
	fvZ11iIE2CbpgJDXbozlYtmwfxT0XVI5kkEzDx3QTNzJJY4A=
X-Google-Smtp-Source: AGHT+IFuiVPldkSW6DrvzjcjdxTCYpKJPxJiakB+eHSVKJ5IP50mg1kx90ZMIrxJy6nJD6ovOOH+koFk3fGUTR94Tds=
X-Received: by 2002:a05:620a:4551:b0:7a9:aba6:d012 with SMTP id
 af79cd13be357-7b6bcaddc36mr793425485a.22.1733523096825; Fri, 06 Dec 2024
 14:11:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
 <f9b63a41-ced7-4176-8f40-6cba8fce7a4c@linux.alibaba.com> <CAJnrk1bwat_r4+pmhaWH-ThAi+zoAJFwmJG65ANj1Zv0O0s4_A@mail.gmail.com>
 <spdqvmxyzzbb6rajv6lvsztbf5xojtxfwu343jlihnq466u7ah@znmv7b6aj44x>
In-Reply-To: <spdqvmxyzzbb6rajv6lvsztbf5xojtxfwu343jlihnq466u7ah@znmv7b6aj44x>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 6 Dec 2024 14:11:26 -0800
Message-ID: <CAJnrk1ZLHwAcbTO-1W=Uvb25w9+4y+1RFXCQTxw_SQYv=+Q6vA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] fuse: support large folios
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 12:36=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Dec 06, 2024 at 09:41:25AM -0800, Joanne Koong wrote:
> > On Fri, Dec 6, 2024 at 1:50=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibab=
a.com> wrote:
> [...]
> > >
> > > >
> > > > Writes are still effectively one page size. Benchmarks showed that =
trying to get
> > > > the largest folios possible from __filemap_get_folio() is an over-o=
ptimization
> > > > and ends up being significantly more expensive. Fine-tuning for the=
 optimal
> > > > order size for the __filemap_get_folio() calls can be done in a fut=
ure patchset.
> >
> > This is the behavior I noticed as well when running some benchmarks on
> > v1 [1]. I think it's because when we call into __filemap_get_folio(),
> > we hit the FGP_CREAT path and if the order we set is too high, the
> > internal call to filemap_alloc_folio() will repeatedly fail until it
> > finds an order it's able to allocate (eg the do { ... } while (order--
> > > min_order) loop).
> >
>
> What is the mapping_min_folio_order(mapping) for fuse? One thing we can

The mapping_min_folio_order used is 0. The folio order range gets set here =
[1]

[1] https://lore.kernel.org/linux-fsdevel/20241125220537.3663725-13-joannel=
koong@gmail.com/

> do is decide for which range of orders we want a cheap failure i.e. witho=
ut
> __GFP_DIRECT_RECLAIM and then the range where we are fine with some
> effort and work. I see __GFP_NORETRY is being used for orders larger

The gfp flags we pass into __filemap_get_folio() are the gfp flags of
the mapping, and that gets set in inode_init_always_gfp() to
GFP_HIGHUSER_MOVABLE, which does include __GFP_RECLAIM.

If __GFP_RECLAIM is set and the filemap_alloc_folio() call can't find
enough space, does this automatically trigger a round of reclaim and
compaction as well?

> than min_order, please note that this flag still allows one iteration of
> reclaim and compaction, so not necessarily cheap.


Thanks,
Joanne

