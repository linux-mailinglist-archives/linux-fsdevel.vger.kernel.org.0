Return-Path: <linux-fsdevel+bounces-65742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C710FC0F6BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3046F4E5E2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB6430EF91;
	Mon, 27 Oct 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD248UYf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A017D30CD9D
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583457; cv=none; b=JtGNqnYRBKS23qHrn4DS21eGDAi+TaQI3qIJxTdjk0WoXNMBKJUoSbGym5vXhLe1o3cSLJtrgk4RVKL3j5LUcjH209pbYM0KjT6kB9rYwio/dc7C0G8rUN9zLzG+ND1g8Ntc3HIxXtRM6e+FsrspqL/BG0qjWupm2IbikP2FiF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583457; c=relaxed/simple;
	bh=llbzDd2QLrV5pzwwKyY3saIQ/viJdYRcNYd4bwXYh58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLzu8uWbtL8CGx6ESeIpI3jEY5Mmwy6QBhr93VsFhMDfHyiM2qlqm7lFzRQSJiIJ3MirlKK29N0whafnvmLYm8A1GdZo768fpG9P0CyGr89stidIB5X/V+wlMo0BvFMCXtDpFVwTr2vUhUzkKo8eWk3uYgWGTf0pV6POA+TRTZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OD248UYf; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3737d0920e6so82382221fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761583454; x=1762188254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FN9KichN928gxkvnLw8mJRrue+6jKsSxc39oAgWeCE=;
        b=OD248UYf0yxfZ5KDMFKtfL8mYueNgm/fSRsSLkQqNT7Du1yrObmbeTpdAvdM3bTfJk
         xFgPAugQlNJJNSHOPuDqApFhHtPkoU3xx+TPFhOwckIQGdXQEvBH5A2emOAdDwOv0bxW
         r69Zy/fUeMGbq4lH/2zjSnaRFEDeWt6zCEdcZaMFKFty30xs19g9rJwawVk22lyjYtSb
         2dGn712fL3wUvP1BVw5jtRKFSBMLongr6dPQvKqRV65oYNzTbbYaacmMjbsIkupQ9cZn
         TCiZ09CjDAahn/OsiLpVRGk7uCMlFM11moY5lr5DZDdfPh9Y6hUuCh9vGvuXClcW+Mra
         4KNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761583454; x=1762188254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FN9KichN928gxkvnLw8mJRrue+6jKsSxc39oAgWeCE=;
        b=IGFMfydA8Nku7ehLbJTxJLAniEFBm2rjqQhh4juTcV4SfFcmWOhEEKGbx/8KhyhSZi
         7PDbzvqNTtx3FLa8T8f8bVibtpQpK+XV3YRQUX2DErg/oOCCCSo4yJHcbCIQgcOdvWdN
         SF9kg+q0bfl7JQ2rivPb6zqMQ0ZOnuOWQDa94GX4S/4J/qeeZNeQhkNPD1QgV4/7Vp6Q
         T0ISMR/vDtks42FnJ/7Aue51Z9qDZ7h8vJx7Idj/G9DJRXN89QhcuqIx+/qlekJooGWJ
         VBaJt5ju884aPlFR6rCSiEmv8v2dJPBwtAI4T5qqKm5aYyd/kqDTQw7IpDVJn8TM6+1P
         DTvw==
X-Forwarded-Encrypted: i=1; AJvYcCWSaoPODkx2s1PpCj6Lhvn30dQAcgdoo4zfSbz2TMfs2Swia35xMJP99KeKiUVWH6vFiy4Pi6HqA91dVa/E@vger.kernel.org
X-Gm-Message-State: AOJu0Yytpyw8fBJ7W1Ctg4d4/BdhE9Fv1SPJlZLSV4oWNtB4uJJsMl4x
	uCsgQ3iXmqReAu83mV8WexUuAoYoAv2JR167qXRNDR3snMNnf87y1hAktSUxH4rneCoU/WX86J8
	KGdZGRQM5GzZMA9ld/OUuyMasVQ0QooU=
X-Gm-Gg: ASbGnctI0CtLMm0A4ALkmSXSFcPbXwGVhL9clv+Qq7Y/MiO5WcJJafU660DLV4Ch+Q7
	zI/LzqSE/AR6vNdYaJcExMRWPvIHQrLPJAYrncTua5KZHyTYC8Btjpf6KKuyiUlFTWF7le9VTXR
	NjFV3KLRAOuaFOSSpoJoiILpgMEZv0Cv5ERW789Q7dNOebqHjwDerCgK1y9AwjgQ4wmsGJgiVLL
	Pm1ZeXK1yru1fICjxtGrorFQywrRB2GKL4pw+WCr0fsvtzOKT2WsRQRSLGmeHv27wJhJ7hzydjs
	tBa/r5k70TWKuYi1Dxs/TQ4pGg==
X-Google-Smtp-Source: AGHT+IEtw/VRJIkd/hKjLd1t17JLCA2o/Y1e9zHYDFZxLzQU/58nmWjpVpHgyoWAa67qkJQrpjznyWIFV/aORWCx6uM=
X-Received: by 2002:a05:651c:434d:20b0:351:786c:e533 with SMTP id
 38308e7fff4ca-379076a9d94mr771371fa.15.1761583453305; Mon, 27 Oct 2025
 09:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024215008.3844068-1-joannelkoong@gmail.com> <aP9jmwrd5r-VPWdg@bfoster>
In-Reply-To: <aP9jmwrd5r-VPWdg@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 27 Oct 2025 09:43:59 -0700
X-Gm-Features: AWmQ_bm1NHi7v0iLMXvzUw3mpX3Cd2NXEthfxlJ9CLQ0bafWSE0pBnpkGOvzB5Q
Message-ID: <CAJnrk1Yu0dkYCfTCzBzBiqMuYRxpyVPBh2YkJcP6YhYRf0zNMw@mail.gmail.com>
Subject: Re: [PATCH] iomap: fix race when reading in all bytes of a folio
To: Brian Foster <bfoster@redhat.com>
Cc: brauner@kernel.org, hch@infradead.org, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 5:16=E2=80=AFAM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Fri, Oct 24, 2025 at 02:50:08PM -0700, Joanne Koong wrote:
> > There is a race where if all bytes in a folio need to get read in and
> > the filesystem finishes reading the bytes in before the call to
> > iomap_read_end(), then bytes_accounted in iomap_read_end() will be 0 an=
d
> > the following "ifs->read_bytes_pending -=3D bytes_accounting" will also=
 be
> > 0 which will trigger an extra folio_end_read() call. This extra
> > folio_end_read() unlocks the folio for the 2nd time, which sets the loc=
k
> > bit on the folio, resulting in a permanent lockup.
> >
> > Fix this by returning from iomap_read_end() early if all bytes are read
> > in by the filesystem.
> >
> > Additionally, add some comments to clarify how this accounting logic wo=
rks.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Fixes: 51311f045375 ("iomap: track pending read bytes more optimally")
> > Reported-by: Brian Foster <bfoster@redhat.com>
> > --
> > This is a fix for commit 51311f045375 in the 'vfs-6.19.iomap' branch. I=
t
> > would be great if this could get folded up into that original commit, i=
f it's
> > not too logistically messy to do so.
> >
> > Thanks,
> > Joanne
> > ---
> >  fs/iomap/buffered-io.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 72196e5021b1..c31d30643e2d 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -358,6 +358,25 @@ static void iomap_read_init(struct folio *folio)
> >       if (ifs) {
> >               size_t len =3D folio_size(folio);
> >
> > +             /*
> > +              * ifs->read_bytes_pending is used to track how many byte=
s are
> > +              * read in asynchronously by the filesystem. We need to t=
rack
> > +              * this so that we can know when the filesystem has finis=
hed
> > +              * reading in the folio whereupon folio_end_read() should=
 be
> > +              * called.
> > +              *
> > +              * We first set ifs->read_bytes_pending to the entire fol=
io
> > +              * size. Then we track how many bytes are read in by the
> > +              * filesystem. At the end, in iomap_read_end(), we subtra=
ct
> > +              * ifs->read_bytes_pending by the number of bytes NOT rea=
d in so
> > +              * that ifs->read_bytes_pending will be 0 when the filesy=
stem
> > +              * has finished reading in all pending bytes.
> > +              *
> > +              * ifs->read_bytes_pending is initialized to the folio si=
ze
> > +              * because we do not easily know in the beginning how man=
y
> > +              * bytes need to get read in by the filesystem (eg some r=
anges
> > +              * may already be uptodate).
> > +              */
>
> Hmm.. "we do this because we don't easily know how many bytes to read,"
> but apparently that's how this worked before by bumping the count as
> reads were submitted..? I'm not sure this is really telling much. I'd
> suggest something like (and feel free to completely rework any of
> this)..

Ahh with that sentence I was trying to convey that we need to do this
because we don't easily know in the beginning how many bytes need to
get read in (eg if we knew we'll be reading in 2k bytes, then we could
just set that to 2k instead of the folio size, and skip all the
accounting stuff). I will get rid of this and replace it with your
suggestion.

>
> "Increase ->read_bytes_pending by the folio size to start. We'll
> subtract uptodate ranges that did not require I/O in iomap_read_end()
> once we're done processing the read. We do this because <reasons>."
>
> ... where <reasons> explains to somebody who might look at this in a
> month or year and wonder why we don't just bump read_bytes_pending as we
> go.

Sounds good, I will use this for v2.
>
> >               spin_lock_irq(&ifs->state_lock);
> >               ifs->read_bytes_pending +=3D len;
> >               spin_unlock_irq(&ifs->state_lock);
> > @@ -383,6 +402,9 @@ static void iomap_read_end(struct folio *folio, siz=
e_t bytes_pending)
>
> This function could use a comment at the top to explain it's meant for
> ending read submission (not necessarily I/O, since that appears to be
> open coded in finish_folio_read()).
>
> >               bool end_read, uptodate;
> >               size_t bytes_accounted =3D folio_size(folio) - bytes_pend=
ing;
> >
>
> "Subtract any bytes that were initially accounted against
> read_bytes_pending but skipped for I/O. If zero, then the entire folio
> was submitted and we're done. I/O completion handles the rest."

Will add this in v2.

>
> Also, maybe I'm missing something but the !bytes_accounted case means
> the I/O owns the folio lock now, right? If so, is it safe to access the
> folio from here (i.e. folio_size() above)?

I believe it is because there's still a reference on the folio here
since this can only be reached from the ->read_iter() and
->readahead() paths, which prevents the folio from getting evicted
(which is what I think you're referring to?).

Thanks,
Joanne
>
> Comments aside, this survives a bunch of iters of my original
> reproducer, so seems Ok from that standpoint.
>
> Brian
>
> > +             if (!bytes_accounted)
> > +                     return;
> > +
> >               spin_lock_irq(&ifs->state_lock);
> >               ifs->read_bytes_pending -=3D bytes_accounted;
> >               /*
> > --
> > 2.47.3
> >
>

