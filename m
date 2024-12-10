Return-Path: <linux-fsdevel+bounces-36874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AF59EA3B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 01:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669A7165A6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 00:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1985518E3F;
	Tue, 10 Dec 2024 00:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XC9OZJ2j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C4B4C98
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733790681; cv=none; b=H3KOw2onuo/37wu3WxcCBLpDarpyz7eQQX++UHds8aYM7mo4mSTtcdJ1yP5cq7P9ra7KEJ+35fFVTTKcztjkTfGWyzuGCLGU0VNY/K3399rxT7o2EdUnOdp9zPto4BcessAYY4X7Z8o1mzNBBxN/jSEhe7v6oKiLioURJp+5Mqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733790681; c=relaxed/simple;
	bh=1pnI20Smtw4D1zuIwoV/mrna1N7AgKybLzRgoore8OU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeJR/w967A49hL2DfNmwNQgM4md23LtZ9MpHADPBe7yZrzzP9LHXtGvBTs+7oyVx1Mg0GBAV0zyRnnR+fbkWzqp6BLUM4gGp/Z/3D+HBGyHqDFXIln0GlWSjI/PV7PxPqBATzDv59OtrSZIgUrMOwkw5sJRGpEDNKrw23Ehni+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XC9OZJ2j; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467777d7c83so1309141cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 16:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733790679; x=1734395479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikPbgYxO0t0c9ZcDpHeL8nnuCsazWiAHyamVVDUkbtg=;
        b=XC9OZJ2jg5wureZhnTa5+71iAEpzC9ifFwIFBwU4OcMUOoXBVtjBITPpzxY/tOAEAb
         ohuSPeihplZTwK+BqDxtgvd/NPC24yM5C3TjCEvj7PH1RrEOfuztcB5U2q1wQUXFLE6l
         +Vn+PVvj0IcC5LzQlGDAXwig6c9fao4uHtSH5xTnvCt1++CWvYoAbkyBqMHTtxkGS8sQ
         67RY0ICWrz/EUSZpl2jJpZijO5Y3XsJH66PO6UxSk9c2Wbg595EYE77cs6CUXLyNbUSi
         zkn5Qmswuba0M6WbZ2NSvhTGb7qYTl9DqwA/GHNpREesJ1kB9wlUcWBKd4nSXb35ZBOV
         IhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733790679; x=1734395479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikPbgYxO0t0c9ZcDpHeL8nnuCsazWiAHyamVVDUkbtg=;
        b=fM0fC3BbaWdqyU1lozQ4hLhNegrnvkJNh+3z7PSPkD8/8pV+d55mpbRBR9AIo8JuNK
         p58BNHr4i8/oa/OZk9eCn6q7iCofBOORO7KshJGXQVnA+N1F+jWrtXjyEJ/ISk02x7O2
         +vk/T8SAnovIEx55n+3whbxhpDkHktTEewIiR4Ki3I0ctqYZ/Klmoa2dXlDbSJRy++Sv
         mNiTg0anrot8Mrx2HXtBhhS36KxR74ysbAdNKclRH8/w7jskDjjQ8kKooyYRUu11L9PO
         1srvxe8kfP3zkc/2WRosGB7XH5SK9y1WM9KbaNv+SO+ekOePurc2fyxwUO3l28bp5lj6
         A1xw==
X-Forwarded-Encrypted: i=1; AJvYcCVXcw8JdAIpoWF6rjH/KXb/tnBkXJ00h1FyaZx70FsmQJAE7wr32MjfXNFKtZgigMrNlCMyLGtmH4KdcWz3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4HBw370zeDcVpLj5PpfhJ46bjoKuf2dsoVzZNYOprzY5j8KPz
	L/h80xiT5j/WkMvzNRc+5yifjopTlQU6o5eBODos1+WV9WIBAAi4IRXE/J20623iKL+1MKwo+fl
	6YtXjY/NxHHYLPEVpCS5kIaTf7qk=
X-Gm-Gg: ASbGncvWZkuyO+29p0NoqHr03FPuM6+W0GPGiuRKNWOt72vifNmgbWs4NZ7f6op4FPS
	6n7nxDO3VmJKotJD4sn4XT2OoLyhhsBv8aTCJPg8VPjtdWIoq0YU=
X-Google-Smtp-Source: AGHT+IFKVupt/8RP0TpwFtu2yKchZyV/3Ye+yuIDvbh0PfaDOessZ63jRHmOZeHuOIvWIJ1H41c76lnXjnW/HI1F+vU=
X-Received: by 2002:ac8:5956:0:b0:460:8e3b:6790 with SMTP id
 d75a77b69052e-46734f95ab4mr237237431cf.48.1733790678924; Mon, 09 Dec 2024
 16:31:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
 <f9b63a41-ced7-4176-8f40-6cba8fce7a4c@linux.alibaba.com> <CAJnrk1bwat_r4+pmhaWH-ThAi+zoAJFwmJG65ANj1Zv0O0s4_A@mail.gmail.com>
 <Z1N505RCcH1dXlLZ@casper.infradead.org>
In-Reply-To: <Z1N505RCcH1dXlLZ@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Dec 2024 16:31:08 -0800
Message-ID: <CAJnrk1Yi-DgFqUprhMYGKJG8eygEK=HmVmZiUCat2KrjP+a=Bg@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] fuse: support large folios
To: Matthew Wilcox <willy@infradead.org>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, shakeel.butt@linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 2:25=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Fri, Dec 06, 2024 at 09:41:25AM -0800, Joanne Koong wrote:
> > On Fri, Dec 6, 2024 at 1:50=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibab=
a.com> wrote:
> > > -       folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> > > +       folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBEGIN =
|
> > > fgf_set_order(len),
> > >
> > > Otherwise the large folio is not enabled on the buffer write path.
> > >
> > >
> > > Besides, when applying the above diff, the large folio is indeed enab=
led
> > > but it suffers severe performance regression:
> > >
> > > fio 1 job buffer write:
> > > 2GB/s BW w/o large folio, and 200MB/s BW w/ large folio
> >
> > This is the behavior I noticed as well when running some benchmarks on
> > v1 [1]. I think it's because when we call into __filemap_get_folio(),
> > we hit the FGP_CREAT path and if the order we set is too high, the
> > internal call to filemap_alloc_folio() will repeatedly fail until it
> > finds an order it's able to allocate (eg the do { ... } while (order--
> > > min_order) loop).
>
> But this is very different frrom what other filesystems have measured
> when allocating large folios during writes.  eg:
>
> https://lore.kernel.org/linux-fsdevel/20240527163616.1135968-1-hch@lst.de=
/

Ok, this seems like something particular to FUSE then, if all the
other filesystems are seeing 2x throughput improvements for buffered
writes. If someone doesn't get to this before me, I'll look deeper
into this.


Thanks,
Joanne
>
> So we need to understand what's different about fuse.  My suspicion is
> that it's disabling some other optimisation that is only done on
> order 0 folios, but that's just wild speculation.  Needs someone to
> dig into it and look at profiles to see what's really going on.

