Return-Path: <linux-fsdevel+bounces-38676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE34A066DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 22:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD9C1680AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 21:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F80204C28;
	Wed,  8 Jan 2025 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJje9Lez"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A462046BF
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jan 2025 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370234; cv=none; b=MtgE7/YG1a50O5fmHhi/WPT31J7elyHD0JmJ7NzxD1hE4/DLzWvbx8eGFDIaVFjbI2y374VbjKwqNvAPQxYhpfTP1jHXilYY/l9wm+4lBJ0Yw3v27FGDcknPgbw1bM2fAcA0sggGheQwzHto8VmFDOlnUqGvVPGgiHcS1h4NPvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370234; c=relaxed/simple;
	bh=U6p2e5J/tqYTFdB8h83NE+vdu0LHHAx+q1k9utwMfDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3Oqf1VDoOAxIzXFQH7s0tYyMccsORO4wfcIiZ7RVrb/tD/5nYZLaY5LCOoRmO13Ydlhf69ovfMxkSyFh2CK5uT7mv08lF+1fRJbafRSADCeDDa9XOMOhwcRZzvTyMQUOD1lVXEhFUcBcXa3xlhjbLmVTyaaF1pUJaWvPoC2MLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJje9Lez; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467b955e288so1536841cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2025 13:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736370232; x=1736975032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aekM0gG7v/9T/qO8c6QRFJvgoYVpMPAD0au29xUt6Vk=;
        b=nJje9Lezj0Ei2RqqOxht//ok6I1k8wDDX1H+Ypa+6TlqIG2usIM7iVV0UTaYBQm6nU
         T2Se3RzJZNc/FK5NOAKTbHc3hh6yHws8MOdl+LZePHKlTQrCSX7hBg0LXTaoqbef1BKc
         mNIefFU/HuXpNIrsrVB0/HXHhcgRokaJXU9c9S0jPHP9ZrkF7PUwLc2wS7LnrX6+QUn0
         8/DsmGp3AkPp+/f56TEJgcu/4RZb1S0hQsyrCbCoMBsBVhn37d9lg9I0BYqYfeVK6Z3C
         B6pyThr7KIvJsP1L1ZGjbZwOij2pi9Fz6xQQp5XjcjpEG+JvYN8RHB65al/UwoZAhayb
         E+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736370232; x=1736975032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aekM0gG7v/9T/qO8c6QRFJvgoYVpMPAD0au29xUt6Vk=;
        b=Kfp8WSvZwYgwerzjJjRrgpC3vI7cPOTP5Abqplgg1s3ZLsa2lGU6vaEaKqb0p6dYj3
         cw9QrY47HMcYpuvZeyomkHd4/adzWazliSlz3DOECnaCb29XAU/1sJsbdRHN+i+JPWPU
         HYtoZCh4c/Wq12xjt2Ct456qGhK+YNDeU9B4/dEyBvhIwXhP//JSO4yhEhG4t1Zq0uNt
         XOBzEz/Zp+zVSnpcr4RWV39oQl0XXNJSqeTa/55lvok8t/CdugpDfTT0UbvG12mi8p3W
         Ohis/aw6jLFJedf5yijja0TXuUvjO4rKZSkJaXi9zTXJlYTWofOf/pNlQs3id/tIh3Yn
         8UYg==
X-Forwarded-Encrypted: i=1; AJvYcCV8zOn5AssHoUiJwbo8Qk4zCmDor1qU2T8JDjnve85WQufHn5sd2wvMHEizaWXjep35XHlLp15EY0DX1yPi@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp8Yq7mK0ph1uZMqwp53XCed+2xlfCncFumes+BG2A7U6pkTd8
	P5cAHEpLXA2ZXI06tdz8gOHcvYgPU9v+J+t7Irn1rZnFT7qDIF62KEssD/QyhRLFPkr8ReWazlE
	bqRQmK8Ca89Cndse7SPcQ7kOdbJtM2Xe2
X-Gm-Gg: ASbGncs6VZxEW9qQIk487e8LvDcRsMVAmh1XezSi2V6/mZooBgiqd/Rdkfkr2jCR2DX
	E7DcHhVToRQlqCwiCQIFfSfvhPeCH0o14wEsix5TJg6TtPAQ6KBbJdw==
X-Google-Smtp-Source: AGHT+IGkfb4GAqQgeTcGndOCzf+4gDEZiXxfmUemuNzg7rNI0SNosx+2lRetahSeM/XT4pZvEFMfrKlWS+ipJ8Hixrs=
X-Received: by 2002:ac8:5851:0:b0:467:5444:caac with SMTP id
 d75a77b69052e-46c7109ec37mr69794901cf.55.1736370231636; Wed, 08 Jan 2025
 13:03:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
 <f9b63a41-ced7-4176-8f40-6cba8fce7a4c@linux.alibaba.com> <CAJnrk1bwat_r4+pmhaWH-ThAi+zoAJFwmJG65ANj1Zv0O0s4_A@mail.gmail.com>
 <Z1N505RCcH1dXlLZ@casper.infradead.org> <CAJnrk1Yi-DgFqUprhMYGKJG8eygEK=HmVmZiUCat2KrjP+a=Bg@mail.gmail.com>
In-Reply-To: <CAJnrk1Yi-DgFqUprhMYGKJG8eygEK=HmVmZiUCat2KrjP+a=Bg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 8 Jan 2025 13:03:40 -0800
X-Gm-Features: AbW1kvYs9njWwcOSwzx7poxfXzPQvrXPsvN4t_nfixOLcWnRE5UaWjWguubZmO0
Message-ID: <CAJnrk1ZKJa5BkSUZJpkFSi-0zKGcaSBxnLgo_2PqV2w-Q4pLaA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] fuse: support large folios
To: Matthew Wilcox <willy@infradead.org>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, shakeel.butt@linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 4:31=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Fri, Dec 6, 2024 at 2:25=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
> >
> > On Fri, Dec 06, 2024 at 09:41:25AM -0800, Joanne Koong wrote:
> > > On Fri, Dec 6, 2024 at 1:50=E2=80=AFAM Jingbo Xu <jefflexu@linux.alib=
aba.com> wrote:
> > > > -       folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBEGI=
N,
> > > > +       folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBEGI=
N |
> > > > fgf_set_order(len),
> > > >
> > > > Otherwise the large folio is not enabled on the buffer write path.
> > > >
> > > >
> > > > Besides, when applying the above diff, the large folio is indeed en=
abled
> > > > but it suffers severe performance regression:
> > > >
> > > > fio 1 job buffer write:
> > > > 2GB/s BW w/o large folio, and 200MB/s BW w/ large folio
> > >
> > > This is the behavior I noticed as well when running some benchmarks o=
n
> > > v1 [1]. I think it's because when we call into __filemap_get_folio(),
> > > we hit the FGP_CREAT path and if the order we set is too high, the
> > > internal call to filemap_alloc_folio() will repeatedly fail until it
> > > finds an order it's able to allocate (eg the do { ... } while (order-=
-
> > > > min_order) loop).
> >
> > But this is very different frrom what other filesystems have measured
> > when allocating large folios during writes.  eg:
> >
> > https://lore.kernel.org/linux-fsdevel/20240527163616.1135968-1-hch@lst.=
de/
>
> Ok, this seems like something particular to FUSE then, if all the
> other filesystems are seeing 2x throughput improvements for buffered
> writes. If someone doesn't get to this before me, I'll look deeper
> into this.
>
>
> Thanks,
> Joanne
> >
> > So we need to understand what's different about fuse.  My suspicion is
> > that it's disabling some other optimisation that is only done on
> > order 0 folios, but that's just wild speculation.  Needs someone to
> > dig into it and look at profiles to see what's really going on.


I got a chance to look more into this. This is happening because with
large folios, a large number of pages is diritied per write, and when
the kernel balances pages,  it uses "HZ * pages_dirtied /
task_ratelimit" to determine if an io timeout needs to be scheduled
while the writeback is happening in the background - for large folios,
where lots of pages are dirtied at once, this usually results in a io
timeout, while small folios skirt this because they incrementally
balance / write back pages. the io wait is what's incurring the extra
cost for large folios.

The entry point into this is in generic_perform_write() where fuse
writeback caching calls into this through
fuse_cache_write_iter()
    generic_file_write_iter()
        __generic_file_write_iter()
            generic_perform_write()

In generic_perform_write(), balance_dirty_pages_ratelimited() is
called per folio that's written. If we're doing a 1GB write where the
block size is 1MB, for small folios we write 1 page, call
balance_dirty_pages_ratelimited(), write the next page, call
balance_dirty_pages_ratelimited(), etc. In
balance_dirty_pages_ratelimited(), we only actually write back the
pages if the number of dirty pages exceeds ratelimit (on my running
system that's 16 pages), so effectively for small folios the number of
accumulated dirty pages is the ratelimit. Whereas with large folios,
we write 256 pages at a time, we call
balance_dirty_pages_ratelimited(), this is larger than the ratelimit,
we go to actually balance pages with balance_dirty_pages(), and then
we have to schedule an io wait. Small folios avoids scheduling this in
"if (pause < min_pause) { ... break; }" in balance_dirty_pages().

Without the io wait, I'm seeing a significant improvement in large
folio performance, eg running fio with bs=3D1M size=3D1G:
small folios: ~1300 MB/s
large folios (w/ io waits) : ~300 MB/s
large folios (w/out io waits): ~2400 MB/s

Also fwiw, nfs also calls into generic_perform_write() for handling
writeback writes (eg nfs_file_write()). Running nfs on my localhost, I
see a perf drop for size=3D1G bs=3D1M writes (~430 MB/s with large folios
and ~550 Mb/s with small folios), though it's nowhere as large as the
perf drop for fuse.

Matthew, what are your thoughts on the best way to address this? do
you think we should increase the min_pause threshold?


Thanks,
Joanne

