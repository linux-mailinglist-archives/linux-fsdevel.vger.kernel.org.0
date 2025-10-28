Return-Path: <linux-fsdevel+bounces-65943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B701C162AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 18:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A2A1C2644C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4E334C9BF;
	Tue, 28 Oct 2025 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0q7IS4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143BF34C986
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672688; cv=none; b=qPRRIknp2E6iS0GNraiEK5HhMqf2xbXUIOkUB4Q7buILUukyvQAGG76pScxQ6oHCdVvriMamb8PVcB8v8XYcSunGSEaXq/OEi9Jl7msVCjF1BnaG9A5bAThpdudfZfL/Bk2JqNxA7sPZ0ndNYngrLeU/pu76iGMKJV11JF2xbNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672688; c=relaxed/simple;
	bh=312kALzQExqfGOxt7+4jsU7rN4yeB86+fm1NNPM6vtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgRnmY9lBogs0b9K7QXH7pNym8kV3XefY0rizRDHqWF01kYmjdZxQXnDDNlCo7m/wNxwnOCfvy7Pvr8ePK/qAYMB3oAcgBlkbzrNgMxYvLM+4T73K7VsdxCWY+Ki1Dky8kkvuPa+DCTFxGEhFHwYBciia5LrpFN9jYvtFm2Ey2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0q7IS4T; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4e88cacc5d9so55529981cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 10:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761672686; x=1762277486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oF+bJJkd9jEdDYZlEjy0RILJPUO9dWraJI5IjBEwc2I=;
        b=R0q7IS4TBADTB8rjeS3DnAYz0HaKllujkSx/K7ui8H9Xhi1FiUdCYe8sku2iunbw+A
         B5zc26kivOee2uCY6bbHsp3tvET6tcVL9myFmkphQ3OVaVwODd6rIvb5N/sSikGb4M/n
         pDvDkYyweyy9xoT6cd/TeVJ/g1qn+P984zpQm0XWnQpBPSx/+sUOfsAchv5mMc1WMdBo
         g2ts8q5e19wHXsGs8OyMBlPh0w2lZvQhKvgjgFrrywo+d4ydCqwH7X17Vv1qckzuDuLy
         HCVsZfXBH/YgSLx0HSPOWODiGa5oitZzsb7yC+wZs8Hh2JGy/H0kvL4LiJoQ/Z0wZ1JD
         +gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761672686; x=1762277486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oF+bJJkd9jEdDYZlEjy0RILJPUO9dWraJI5IjBEwc2I=;
        b=W1YhPapt2Vdzo0hR6N1h6VaxZfq9RrJxWUCuswpYfYm8HQWmK2oYe2VeFtf6gsPATZ
         7n9tbYF9cjdmucj6q3ODocXGk8x7JdI8yYiaLVADNB/M4sfGTEA6i80ed4HASQGenc0N
         IVaVXNywmQJtTOYUOWuvZMWJoY263ChG8xRgj6JWyvAwj0yTUB6b3kHQo7GBaRVxbe2W
         WWbItz8niIGQz4g5MDjYXiAMWKXu05R5vQZHzIX6uDouWdLhgtE5Mipg5B42dtnpeEHI
         qcTOTWiX38D8+4JxmuxVU2aLx5etiT78p1jTLmPhDQrggydY5Cnu+ckp6qYmt3CowStu
         tYfA==
X-Forwarded-Encrypted: i=1; AJvYcCWDsHDA64mno3nBvVRm8pZ8khI/TEckGM3J6VycccVqIXz85R8ucAfXxLA0x9zGqxFUhPM3c94ZxNWxSOvp@vger.kernel.org
X-Gm-Message-State: AOJu0YydsAKQhKxJke57EBuQqdleIDAn/nLWJXnfhvaauDEpbUojItN+
	+1ATtAg5WgS7iOSgbppUO0o+ciFnbJUyxxwhnjmpIaDIR4ab2vSLqAHQGyNBu31kOmv+4ACyJdd
	6pv9Ke03XY2YjFqeh7/+EocExQWtPdOU=
X-Gm-Gg: ASbGncsb+++95K+YpnfUnRf47rDBgd/FfFZuE/WVO6SV4Zm/YpzL+2GXqJM27rAoqe2
	ocJEIMsXPNj/mKJKJfz9DHvCIGIpjxgURwMdQY3jC/GgrKYQD+msz3APoxg5xm+2c1UfNU+EiTw
	wRL+YlZOOlNWcndLO+eWlf/hwiFhTkekM88KPNfSeS371wgqTPVKLH3da41h430Z91dKbJFoJy/
	ziuO8o7YH+ljwCgAcKQuLiFbw8Fer1MV9duHdAbL2pU5g46XkjHtLp4DMfnuIj2TG8bTgxlQJvT
	Rd/6FkkrDXdCmOA=
X-Google-Smtp-Source: AGHT+IH96Sg9CY5ItGC48dsce9ejNzwSGJXEOGQ2ui2LWyMupKwIJgBEdj+3yuV1yvZVH1D+ckEGDEHBdRsCnebdE74=
X-Received: by 2002:ac8:5e4c:0:b0:4e8:b669:992 with SMTP id
 d75a77b69052e-4ed07629320mr60405931cf.73.1761672685891; Tue, 28 Oct 2025
 10:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024215008.3844068-1-joannelkoong@gmail.com>
 <aP9jmwrd5r-VPWdg@bfoster> <CAJnrk1Yu0dkYCfTCzBzBiqMuYRxpyVPBh2YkJcP6YhYRf0zNMw@mail.gmail.com>
 <aQCnBDkpda7_RAwW@bfoster> <CAJnrk1Yu-_D2r7tnshhL+8_9m5wSdzpSzLmvm4_A+y7EPGqVtg@mail.gmail.com>
In-Reply-To: <CAJnrk1Yu-_D2r7tnshhL+8_9m5wSdzpSzLmvm4_A+y7EPGqVtg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 28 Oct 2025 10:31:14 -0700
X-Gm-Features: AWmQ_bmc06BMHi0uvi5eyVAys8Qbw6dQHM9BiGthO2rV5iRJ9toplVPVb_5Ho94
Message-ID: <CAJnrk1ahdfwaTTDSkJZtpnk4fk0FfsQBF1a9pr=DTyUTY5dkjg@mail.gmail.com>
Subject: Re: [PATCH] iomap: fix race when reading in all bytes of a folio
To: Brian Foster <bfoster@redhat.com>
Cc: brauner@kernel.org, hch@infradead.org, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:11=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Tue, Oct 28, 2025 at 4:16=E2=80=AFAM Brian Foster <bfoster@redhat.com>=
 wrote:
> >
> > On Mon, Oct 27, 2025 at 09:43:59AM -0700, Joanne Koong wrote:
> > > On Mon, Oct 27, 2025 at 5:16=E2=80=AFAM Brian Foster <bfoster@redhat.=
com> wrote:
> > > >
> > > > On Fri, Oct 24, 2025 at 02:50:08PM -0700, Joanne Koong wrote:
> > > > > There is a race where if all bytes in a folio need to get read in=
 and
> > > > > the filesystem finishes reading the bytes in before the call to
> > > > > iomap_read_end(), then bytes_accounted in iomap_read_end() will b=
e 0 and
> > > > > the following "ifs->read_bytes_pending -=3D bytes_accounting" wil=
l also be
> > > > > 0 which will trigger an extra folio_end_read() call. This extra
> > > > > folio_end_read() unlocks the folio for the 2nd time, which sets t=
he lock
> > > > > bit on the folio, resulting in a permanent lockup.
> > > > >
> > > > > Fix this by returning from iomap_read_end() early if all bytes ar=
e read
> > > > > in by the filesystem.
> > > > >
> > > > > Additionally, add some comments to clarify how this accounting lo=
gic works.
> > > > >
> > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > Fixes: 51311f045375 ("iomap: track pending read bytes more optima=
lly")
> > > > > Reported-by: Brian Foster <bfoster@redhat.com>
> > > > > --
> > > > > This is a fix for commit 51311f045375 in the 'vfs-6.19.iomap' bra=
nch. It
> > > > > would be great if this could get folded up into that original com=
mit, if it's
> > > > > not too logistically messy to do so.
> > > > >
> > > > > Thanks,
> > > > > Joanne
> > > > > ---
> > > > >  fs/iomap/buffered-io.c | 22 ++++++++++++++++++++++
> > > > >  1 file changed, 22 insertions(+)
> > > > >
> > > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > > index 72196e5021b1..c31d30643e2d 100644
> > > > > --- a/fs/iomap/buffered-io.c
> > > > > +++ b/fs/iomap/buffered-io.c
> > > > > @@ -358,6 +358,25 @@ static void iomap_read_init(struct folio *fo=
lio)
> > > > >       if (ifs) {
> > > > >               size_t len =3D folio_size(folio);
> > > > >
> > > > > +             /*
> > > > > +              * ifs->read_bytes_pending is used to track how man=
y bytes are
> > > > > +              * read in asynchronously by the filesystem. We nee=
d to track
> > > > > +              * this so that we can know when the filesystem has=
 finished
> > > > > +              * reading in the folio whereupon folio_end_read() =
should be
> > > > > +              * called.
> > > > > +              *
> > > > > +              * We first set ifs->read_bytes_pending to the enti=
re folio
> > > > > +              * size. Then we track how many bytes are read in b=
y the
> > > > > +              * filesystem. At the end, in iomap_read_end(), we =
subtract
> > > > > +              * ifs->read_bytes_pending by the number of bytes N=
OT read in so
> > > > > +              * that ifs->read_bytes_pending will be 0 when the =
filesystem
> > > > > +              * has finished reading in all pending bytes.
> > > > > +              *
> > > > > +              * ifs->read_bytes_pending is initialized to the fo=
lio size
> > > > > +              * because we do not easily know in the beginning h=
ow many
> > > > > +              * bytes need to get read in by the filesystem (eg =
some ranges
> > > > > +              * may already be uptodate).
> > > > > +              */
> > > >
> > > > Hmm.. "we do this because we don't easily know how many bytes to re=
ad,"
> > > > but apparently that's how this worked before by bumping the count a=
s
> > > > reads were submitted..? I'm not sure this is really telling much. I=
'd
> > > > suggest something like (and feel free to completely rework any of
> > > > this)..
> > >
> > > Ahh with that sentence I was trying to convey that we need to do this
> > > because we don't easily know in the beginning how many bytes need to
> > > get read in (eg if we knew we'll be reading in 2k bytes, then we coul=
d
> > > just set that to 2k instead of the folio size, and skip all the
> > > accounting stuff). I will get rid of this and replace it with your
> > > suggestion.
> > >
> > > >
> > > > "Increase ->read_bytes_pending by the folio size to start. We'll
> > > > subtract uptodate ranges that did not require I/O in iomap_read_end=
()
> > > > once we're done processing the read. We do this because <reasons>."
> > > >
> > > > ... where <reasons> explains to somebody who might look at this in =
a
> > > > month or year and wonder why we don't just bump read_bytes_pending =
as we
> > > > go.
> > >
> > > Sounds good, I will use this for v2.
> > > >
> > > > >               spin_lock_irq(&ifs->state_lock);
> > > > >               ifs->read_bytes_pending +=3D len;
> > > > >               spin_unlock_irq(&ifs->state_lock);
> > > > > @@ -383,6 +402,9 @@ static void iomap_read_end(struct folio *foli=
o, size_t bytes_pending)
> > > >
> > > > This function could use a comment at the top to explain it's meant =
for
> > > > ending read submission (not necessarily I/O, since that appears to =
be
> > > > open coded in finish_folio_read()).
> > > >
> > > > >               bool end_read, uptodate;
> > > > >               size_t bytes_accounted =3D folio_size(folio) - byte=
s_pending;
> > > > >
> > > >
> > > > "Subtract any bytes that were initially accounted against
> > > > read_bytes_pending but skipped for I/O. If zero, then the entire fo=
lio
> > > > was submitted and we're done. I/O completion handles the rest."
> > >
> > > Will add this in v2.
> > >
> > > >
> > > > Also, maybe I'm missing something but the !bytes_accounted case mea=
ns
> > > > the I/O owns the folio lock now, right? If so, is it safe to access=
 the
> > > > folio from here (i.e. folio_size() above)?
> > >
> > > I believe it is because there's still a reference on the folio here
> > > since this can only be reached from the ->read_iter() and
> > > ->readahead() paths, which prevents the folio from getting evicted
> > > (which is what I think you're referring to?).
> > >
> >
> > Yep, but also whether the size or anything can change.. can a large
> > folio split, for example?
> >
> > ISTM the proper thing to do would be to somehow ensure the read submit
> > side finishes (with the folio) before the completion side can complete
> > the I/O, then there is an explicit ownership boundary and these sorts o=
f
> > racy folio access questions can go away. Just my 02.
>
> Hmm, I don't think there's any way to ensure the read submit side
> finishes before the completion side completes.
> I think what we can do though is stash the size of the folio and just
> use that. I'll make this change to v3 to be safe.

Thinking about this some more, I think there is a simpler way to
ensure this, if we initialize ifs->read_bytes_pending to folio_size()
+ 1 where that + 1 bias ensures the folio won't have been unlocked by
the time we get to iomap_read_end().

I'll do it this way for v3, as stashing the folio size would mean
having to add it to the public iomap_read_folio_ctx struct.

Thanks,
Joanne

>
> Thanks,
> Joanne
>
> >
> > Brian
> >
> > > Thanks,
> > > Joanne
> > > >
> > > > Comments aside, this survives a bunch of iters of my original
> > > > reproducer, so seems Ok from that standpoint.
> > > >
> > > > Brian
> > > >
> > > > > +             if (!bytes_accounted)
> > > > > +                     return;
> > > > > +
> > > > >               spin_lock_irq(&ifs->state_lock);
> > > > >               ifs->read_bytes_pending -=3D bytes_accounted;
> > > > >               /*
> > > > > --
> > > > > 2.47.3
> > > > >
> > > >
> > >
> >

