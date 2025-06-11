Return-Path: <linux-fsdevel+bounces-51229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C08AD4A9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 08:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717FF1897E55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 06:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED9F226CF1;
	Wed, 11 Jun 2025 06:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLy+d+PM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0810380;
	Wed, 11 Jun 2025 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749621665; cv=none; b=kkaZ7N/grYMvXTby5jBsoNDsKeZ9kN/1VFL3nsRoj6mP3IyxinpS7KSNcoAP9jEakA19HPfPJXuzp0MYx1IT8H/dogFFmnfCLLZGAm1691Y93nMqGebhUqV8hF33NP/y3c7S9vAU3iTsRVekzuBV1OCl+HhWdUdpQCji8kVL2AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749621665; c=relaxed/simple;
	bh=JhBTnTkthr7PPFmdkzURh58erYJFz3QOeA4kJL6ernA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfmtEOH0mtIT/SA0xcMuyp1kHOGXhSzK5mdiOhOo/E996bhyqY2N+HvSde9mz8e5yAP1hVQaYwAPhvvn4illfilD7jO9ehjOU5xLNzNCg6aIqswjitZhWm7ghUibrNP4QE1FWb5akfmPBevtAVFcC780GpsFDyZtSw38lJXRPEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLy+d+PM; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a589b7dd5fso103504061cf.0;
        Tue, 10 Jun 2025 23:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749621662; x=1750226462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0U626+Kas0WOY5EEisoYfKEC1Z3GaeV4ouCwUeF2IGc=;
        b=PLy+d+PMyVu3inYGIonfluGqR0u5uih5oWFFYxh6DKSGioVRfYWlXfX0ADFqXXM5xj
         XgNcD+AXRgxO90TP+GAmeAxxUXqHgYTgYe6h64pioT184oqprYbaddR2ea1qMQJv7zdw
         odwKoY12H2EWG1wA3mDdrWI7coUyYez2cakYV5tOD10IXPdRpxduYfJVlkvcngSZcsuR
         qj2Yvi0lYsNUnOArfQP7uRuUPE5bxRHfczxUDyKsvDdSpzxZrG8x6tmvuDqXy1BukLHE
         kD73Pc7zXQw5TjEgioUFDyBiabD2KVFPnTs0VfviFtRU87eSFN4GTfHallhOdXLgjXvo
         F1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749621662; x=1750226462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0U626+Kas0WOY5EEisoYfKEC1Z3GaeV4ouCwUeF2IGc=;
        b=CHVFPmZ2g0fHu0+ImZckN8lm7G6Mgi0n7CNrP1hslwEckAAUUge7hZEkuPG4T8i17h
         oD+2VBMURHBOa6CKjY09yHXMema/PeuvEQA8RUcSRCenzvOU9ax5wJdxNqHzx23Yc1yl
         D5HGO/3LmmDLXO4KI1U7OUrt5ZFE+25OhhRjPJ2QVooRufKLmbwXPmtUVl7P9JYhGf7V
         PxvXVBd5dCfQWveGIbOpdPFQoOk1V9sd2OtTmdkvOHouMKanHAZM6Jmx4j5Dbi7ujg07
         AcgiUg/NR7ysayLhTt0yoTT0j9SlfvVlGLNj9f9jDg6nqvWcFEQfnekjdO4ENmrcoS6M
         fd+w==
X-Forwarded-Encrypted: i=1; AJvYcCUHsMZtANFa4tymEiKxMwi6UF+gQ3b+YANImrTM8o4jdXjFqJdxVKBH1WjdOSFd+821P53qZEZZSwPg@vger.kernel.org, AJvYcCXT8yy5jOkIMw3Ef6yqjkxYmnJBIKc+DkvchY3tX1xF+CXAg+3W6/cerGmbHzacP8rkNN5X1sVgFCvTrHA3@vger.kernel.org
X-Gm-Message-State: AOJu0YyrNA52hQjjbpk/AySKQR21c78yxmkRRqbDBEL6e8XAEUfFX1cj
	wDRVAYZ5OHNvv1I3g9GJWh326T1bavovCD+YQvxK+NxWEmdqvm+8j9riuL9r8IMOXf8bo66qlcb
	sYqmnPnDdfb9XgW/G5ZM1wrFaBe1e4YfCozvsu8A=
X-Gm-Gg: ASbGncsHwHPtFIchd87CAkPwDfSN48T8atZjEAwKmnwuRfyH/uPXJx/M7ssaqYT3qUZ
	3o59hmbBp+k0wOG7VNlY4NkoMx3Q2tg4beyJrpq/s69cTdq3+COD5LAQcnu/oE6A+upNosVQ+u+
	btc/EsZ1EdnUqLzoQVqLNhJYtuPZST6cubAEk/FvFOkMSk2Mgc464LilalZWs=
X-Google-Smtp-Source: AGHT+IH+tU7dk2Aj20UVxAniqlc6aIhzV+JX7zQgjc9sqs0KnNUnTk0mqohD17Rto2b1OpdC0exwmmEGYLme83LWPMY=
X-Received: by 2002:a05:622a:5510:b0:476:b06a:716e with SMTP id
 d75a77b69052e-4a714c0c187mr30996241cf.34.1749621662384; Tue, 10 Jun 2025
 23:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-3-joannelkoong@gmail.com> <aEZm-tocHd4ITwvr@infradead.org>
 <CAJnrk1Z-ubwmkpnC79OEWAdgumAS7PDtmGaecr8Fopwt0nW-aw@mail.gmail.com>
 <aEeo7TbyczIILjml@infradead.org> <aEgyu86jWSz0Gpia@infradead.org>
 <CAJnrk1b6eB71BmE_aOS77O-=77L_r5pim6GZYg45tUQnWChHUg@mail.gmail.com> <aEkARG3yyWSYcOu6@infradead.org>
In-Reply-To: <aEkARG3yyWSYcOu6@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 10 Jun 2025 23:00:51 -0700
X-Gm-Features: AX0GCFsiZ8F_8_oKfN31REhmnFBHB0Dx_xAkhvynTyAyvAiO0p1B_qSsxVP1G44
Message-ID: <CAJnrk1b8edbe8svuZXLtvWBnsNhY14hBCXhoqNXdHM6=df6YAg@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] iomap: add IOMAP_IN_MEM iomap type
To: Christoph Hellwig <hch@infradead.org>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 9:04=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Jun 10, 2025 at 01:13:09PM -0700, Joanne Koong wrote:
> > > synchronous ones.  And if the file system fragmented the folio so bad=
ly
> > > that we'll now need to do more than two reads we're still at least
> > > pipelining it, although that should basically never happen with moder=
n
> > > file systems.
> >
> > If the filesystem wants granular folio reads, it can also just do that
> > itself by calling an iomap helper (eg what iomap_adjust_read_range()
> > is doing right now) in its ->read_folio() implementation, correct?
>
> Well, nothing tells ->read_folio how much to read.  But having a new

Not a great idea, but theoretically we could stash that info (offset
and len) in the folio->private iomap_folio_state struct. I don't think
that runs into synchronization issues since it would be set and
cleared while the file lock is held for that read.

But regardless I think we still need a new variant of read_folio
because if a non block-io iomap wants to use iomap_read_folio() /
iomap_readahead() for the granular uptodate parsing logic that's in
there, it'll need to provide a method for reading a partial folio. I
initially wasn't planning to have fuse use iomap_read_folio() /
iomap_readahead() but I realized there's some cases where fuse will
find it useful, so i'm planning to add that in.

> variant of read_folio that allows partial reads might still be nicer
> than a iomap_folio_op.  Let me draft that and see if willy or other mm
> folks choke on it :)

writeback_folio() is also a VM level concept so under that same logic,
should writeback_folio() also be an address space operation?

A more general question i've been trying to figure out is if the
vision is that iomap is going to be the defacto generic library that
all/most filesystems will be using in the future? If so then it makes
sense to me to add this to the address space operations but if not
then I don't think I see the hate for having the folio callbacks be
embedded in iomap_folio_op.

>
> > For fuse at least, we definitely want granular reads, since reads may
> > be extremely expensive (eg it may be a network fetch) and there's
> > non-trivial mempcy overhead incurred with fuse needing to memcpy read
> > buffer data from userspace back to the kernel.
>
> Ok, with that the plain ->read_folio variant is not going to fly.
>
> > > +               folio_lock(folio);
> > > +               if (unlikely(folio->mapping !=3D inode->i_mapping))
> > > +                       return 1;
> > > +               if (unlikely(!iomap_validate(iter)))
> > > +                       return 1;
> >
> > Does this now basically mean that every caller that uses iomap for
> > writes will have to implement ->iomap_valid and up the sequence
> > counter anytime there's a write or truncate, in case the folio changes
> > during the lock drop? Or were we already supposed to be doing this?
>
> Not any more than before.  It's is still option, but you still
> very much want it to protect against races updating the mapping.
>
Okay thanks, I think I'll need to add this in for fuse then. I'll look
at this some more

