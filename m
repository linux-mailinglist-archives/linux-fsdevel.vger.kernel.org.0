Return-Path: <linux-fsdevel+bounces-8385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB688359BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 04:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04BE282B50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 03:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2927522A;
	Mon, 22 Jan 2024 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZUJKxYa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66FC5223
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 03:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705894196; cv=none; b=Xe3aUz0Hc7S3R0xJgqsvnmAsVSk7/lbiffy/0xuOBmFDPabr9Naf1Uj8siRW6LF9Qau1+PLdDkxWicYAdUC6BX2S0qyynhOJ4b9IFMiTTcNLbrVOeRwIn/T9wsM3VzkQQs2IlE1uFAfsoDcPie+AXAFpoPegkmTZoVVXZguZbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705894196; c=relaxed/simple;
	bh=D6KDXy9ilFLseKEmaDPcQM+MRyWyd//dQ+8H+q6qiPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAoAw9NTv09H//4x9by2iGf/fdR+O9l+TcFCP/qKa63X1aoxfPWT8JUyEzLscm9ESQAMMnLrbe0fUhj2xHuQGRpD86E/CXYKfQzg+peavv5olyvORuCYoH6r1FfzNStG73Mo3pEMU8ppI1TLwk7BHJIw7t5Ifkg1+SaLSYadx5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZUJKxYa; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dae7cc31151so1709651276.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 19:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705894194; x=1706498994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xf+pSu4bPzzZI2W7JvwVERQp95BfV0IRqQvQUdRUYfc=;
        b=aZUJKxYaDMq6Rwxt5Ry7rnGvuez4jjDqO3HygUkcIGAve+xOK1pP0wvzPdusbtyi2t
         kXtT1SNZzvapb0Rp1GFZ0EgeU8+MIAKh71G1AHhxVmksAq/01S2jT3zc78QSiGcrpwU6
         bqxS/TQA59pQT8qsINGFz9/u0pQxG36GWjtYDVTKKacv36W5UFqVsa96OStcotoSBdem
         EIgls+9TGkNUS2gJU76Sw//mcUZOem8TNhgJgH/VyzapQ87UoILejH6fDUawpwCvBEV1
         YP3U1uHR19LgTRan337wd8eZWknGedzXW+XKL8AJIM3rdf7ZPCy/t3xThHh6lgaHxxBn
         tgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705894194; x=1706498994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xf+pSu4bPzzZI2W7JvwVERQp95BfV0IRqQvQUdRUYfc=;
        b=re9MwhQ+NzFiIYyEwxWAbcY7btFtVmVphjfhEVxvGOaGlMHJGzm+lGdqdnHtxLaA1k
         Y5dCbJGeVvvCFbEn6xeGHLOnB+VcXxQase0GMNiErI/SvRCiYQzo3RpmcR56U6mxrbH6
         veCkjVMdsWGPXiHahF7tW8tcdRfPiE0roe6iJ2j2CmFLkzRtLwf71QE501N3GBnLlxnd
         +RzeXKmVbzbC/SLsUiYYfBhxD/TNse30vXbj0W5gacX5B5e5r1vuxnWAhWPtHVxr7Ct+
         IwX6N8LwmelMpaXRd4ygjP20/xwGpnRKxwg6PSLPhHBAyQAXNAtzOkbCEmlZfIM81zPB
         2+Vw==
X-Gm-Message-State: AOJu0YzWzHrZgAX3E7uI4x9J47cNkLWyHxMs9OtnBs3tt9lb0v8T5IaP
	xmsEqIeVQ7QxU8bv7g1VzTGdwvIvEWIekvI+v5pRN8RRUoPCpGD8lb9YciqeqnUk3sCqZpxbvYp
	x7eIwfM2c8ZOQCbfb8UxqkoE+KqyR68uDPIfDcLG5Wh0oX4HaOA==
X-Google-Smtp-Source: AGHT+IECg2K98D/NXHJLefj5mL0s/mzJRp5qfcZTN4YBXtGn6v9QKjw3AYrT/VtSj5Q0OsC/Ofamgsr/WiUdaiQNAmA=
X-Received: by 2002:a25:268b:0:b0:dc2:2f4d:5209 with SMTP id
 m133-20020a25268b000000b00dc22f4d5209mr1502852ybm.100.1705894193555; Sun, 21
 Jan 2024 19:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpHJX8zeQY6t5rrKps6GxbadRZBE+Pzk21wHfqZC8PFVCA@mail.gmail.com>
 <115288f8-bd28-f01f-dd91-63015dcc635d@suse.cz> <ZFvGP211N+CuGEUT@moria.home.lan>
 <CA+CK2bBmqL5coj7=hXfyj2sBZ+go9ozjZihzp4hmykxpKfQphA@mail.gmail.com> <Za3CbL5U7dFp6aL2@casper.infradead.org>
In-Reply-To: <Za3CbL5U7dFp6aL2@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 21 Jan 2024 19:29:41 -0800
Message-ID: <CAJuCfpGpL6-7KEFFDY=nR5fA1zMi3-8MmJG=6iuHdpUcv07qnA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Memory profiling using code tagging
To: Matthew Wilcox <willy@infradead.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, g@casper.infradead.org, 
	Kent Overstreet <kent.overstreet@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 5:18=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sun, Jan 21, 2024 at 06:39:26PM -0500, Pasha Tatashin wrote:
> > On Wed, May 10, 2023 at 12:28=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > > Hasn't been addressed yet, but we were just talking about moving the
> > > codetag pointer from page_ext to page last night for memory overhead
> > > reasons.
> > >
> > > The disadvantage then is that the memory overhead doesn't go down if =
you
> > > disable memory allocation profiling at boot time...
> > >
> > > But perhaps the performance overhead is low enough now that this is n=
ot
> > > something we expect to be doing as much?
> > >
> > > Choices, choices...
> >
> > I would like to participate in this discussion, specifically to
>
> Umm, this is a discussion proposal for last year, not this.  I don't
> remember if a followup discussion has been proposed for this year?

My bad. I should submit a proposal for followup discussion for this
year. Will do that this coming week.

>
> > 2. Reducing the memory overhead by not using page_ext pointer, but
> > instead use n-bits in the page->flags.
> >
> > The number of buckets is actually not that large, there is no need to
> > keep 8-byte pointer in page_ext, it could be an idx in an array of a
> > specific size. There could be buckets that contain several stacks.
>
> There are a lot of people using "n bits in page->flags" and I don't
> have a good feeling for how many we really have left.  MGLRU uses a
> variable number of bits.  There's PG_arch_2 and PG_arch_3.  There's
> PG_uncached.  There's PG_young and PG_idle.  And of course we have
> NUMA node (10 bits?), section (?), zone (3 bits?)  I count 28 bits
> allocated with all the CONFIG enabled, then 13 for node+zone, so it
> certainly seems like there's a lot free on 64-bit, but it'd be
> nice to have it written out properly.
>
> Related, what do we think is going to happen with page_ext in a memdesc
> world (also what's going to happen with the kmsan goop in struct page?)
>
> I see page_idle_ops, page_owner_ops and page_table_check_ops.
> page_idle_ops only uses the 8 byte flags.  page_owner_ops uses an extra
> 64 bytes (!).  page_table_check uses an extra 8 bytes.
>
> page_idle looks to be for folios only.  page_table_check seems like
> it should be folded into pgdesc.  page_owner maybe gets added to every
> allocation rather than every page (but that's going to be interesting
> for memdescs which don't normally need an allocation).
>
> That seems to imply that we can get rid of page_ext entirely, which will
> be nice.  I don't understand kmsan well enough to understand what to
> do about it.  If it's per-allocation, we can handle it like page_owner.
> If it really is per-page, we can make it an ifdef in struct page itself.
> I think it's OK to grow struct page for such a rarely used debugging
> option.

