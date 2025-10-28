Return-Path: <linux-fsdevel+bounces-65942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32226C16111
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 18:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE7114E1A16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 17:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE4F34888F;
	Tue, 28 Oct 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJTZrX+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97810347FD2
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671482; cv=none; b=bwv6UIOkFLogdssgQfiNS915JLeb38BDHQmpRONzUB5a2iLYImZpyl+8jN0zwAIIdFMZSQs7U8JOKboZ9mNsgHwI9JpGRR5Y0e7smq1r/68O1Prjk4AMGViNgaZ35DAituxD51rukamqP1T86Q6cyfNuQxH3JCgtqBt4LvtjbQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671482; c=relaxed/simple;
	bh=kZgsH6lzJoAU6OpRe6+uxwAkCXLMl8lqqKtT+jT1HyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFlaMgwnMR8sRNd/Ws+KdRrnXtO3rvrLKYEMa1zMcr1xiWHdSjFWP4Lj72En9cO9gc+Wf3YZXJlImI52J1bhMLDj/I6Nf4i0G6b6Ul3uggpRUKqBJvIaNosZ78QmvvN9dBPVlhxKyDT8NKbtC38xKv9B7Zbb4FcC31PBSeG9by4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJTZrX+X; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8906eb94264so730307785a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 10:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761671478; x=1762276278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DYwLdtGTGBx3HFNAiPkDsy2KxM0wYW5p7QWCXoUPqo=;
        b=kJTZrX+X9lcHW8wRVUogICSmjW0yVu7WckPzLE9DpVNLYwuufD94U/x2ev4XOl2D1H
         +/ufYJZl5mfrJ5p2CDgr2K+mmK0uB9rejjicDBiq/6Uad1+wcS+xwHl5QCuNWyp98wGo
         ahQCxlbx/76Ldrsv8lTm86bTKMl+tYxDMSCagciq2fKx4R/uXS4Pq4weVXNhkMaBTdYp
         7sYre3sfgLg1xAE8IKm6SXgGJ61CrdxHOOOGQ6gxql5Bmyc/K3bglrI1qPd8mqO/1ZO4
         s0mxohp88VqpIBC7wxk7AhlL2ya5OTRWrzUdJ4XHXXll6gXovW99zuijhBdSWpaoiVAb
         UE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671478; x=1762276278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DYwLdtGTGBx3HFNAiPkDsy2KxM0wYW5p7QWCXoUPqo=;
        b=lHoYH9MKooA/fmsy9tczF616dCiNLGlTTdinJ+fJzs6+vfuLnzYRX929naTbbP1Xfe
         bnFwXxoK6yJktpWFwmwjtUCH+XWA9eEK6I+4LaOObFFVe6K85UQuBX2IEfq14UbZ8q3S
         ZXg8WCnRxhvWM2YXio2Xe1QzLPryUNLLpEj9QBLqqRb23LB/jE81xpJ4ymZOfSB4m8G7
         B3QeRI93kOAIH5FXmxouil3CBgV7r8XaYh32qtG/u3oUBViFg1+FUSXYFDao8RAOZDzF
         9hUqn8/tb1w10QkM6Pv2j7l1r8Vl/QlY7DLGnFhZASRywFZ9ZtjR6evK9lYrxVHLumSy
         K4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs2QP2G2/D8ovNxN6RpjfeVWnqcyEoIfTzvknzubL394wCBFu7HYYnfsQJad2w/DQWRYDDkwkqMFWHNVFh@vger.kernel.org
X-Gm-Message-State: AOJu0YyYtQ0EoZQ8Pg0R9p6w4POgMcSpnr5Q7XjfeHSl0vZ4c4G0psFm
	IwenGErVWCE0pZG8fOma1bzKmEv6fD45lss6mB6gFtpXbrjgwaTweDPqGVnLTS6THqJdUe1i5Nc
	iZLODmfez5ozejIcueBXokDkXZ6RN94k=
X-Gm-Gg: ASbGnctCCnHWD4Ne7HporWJ56ACr5Q5YxN+caTYbjFhReQzlbfefXqIvhD6/nUApwI8
	HDwPUntV5e9FqGqrnSjtv9G+ni6XHKxuW7FrYyKCjnjtkPJrMob82GLhmsTC48X6xa84IBiw9TG
	aSwwZFdQhXujQGDyoWM9+qjupDAF85Zxk0dlhzGaMOsis0kUXr9Q8Xi79Dpsun2oCeMA3AL/22j
	/bIrGgm56OnDGdW3F8k9/7imSvryp3Rc+jPxpaQ3PzV7UxZgcFDRJHzYtKr+TsK5i/pP70DZoab
	inY49vbvaxuGCoo=
X-Google-Smtp-Source: AGHT+IG4DRzj3SqZLOpUAwqOToE6dk1uVLi+uG6R8WpztOcH8TMpS1a/XegpmmeQKyujUQOnWzu43+ddMKpRRDpJbh8=
X-Received: by 2002:a05:620a:288c:b0:89e:e474:4a3 with SMTP id
 af79cd13be357-8a8e6278e62mr7343585a.86.1761671478318; Tue, 28 Oct 2025
 10:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024215008.3844068-1-joannelkoong@gmail.com>
 <aP9jmwrd5r-VPWdg@bfoster> <CAJnrk1Yu0dkYCfTCzBzBiqMuYRxpyVPBh2YkJcP6YhYRf0zNMw@mail.gmail.com>
 <aQCnBDkpda7_RAwW@bfoster>
In-Reply-To: <aQCnBDkpda7_RAwW@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 28 Oct 2025 10:11:04 -0700
X-Gm-Features: AWmQ_bl4JGCcsl0Brpzh_UP14eRG-i3cQdoAoNV0kNOZMShs0HcAM8NEcsAaJpc
Message-ID: <CAJnrk1Yu-_D2r7tnshhL+8_9m5wSdzpSzLmvm4_A+y7EPGqVtg@mail.gmail.com>
Subject: Re: [PATCH] iomap: fix race when reading in all bytes of a folio
To: Brian Foster <bfoster@redhat.com>
Cc: brauner@kernel.org, hch@infradead.org, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:16=E2=80=AFAM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Mon, Oct 27, 2025 at 09:43:59AM -0700, Joanne Koong wrote:
> > On Mon, Oct 27, 2025 at 5:16=E2=80=AFAM Brian Foster <bfoster@redhat.co=
m> wrote:
> > >
> > > On Fri, Oct 24, 2025 at 02:50:08PM -0700, Joanne Koong wrote:
> > > > There is a race where if all bytes in a folio need to get read in a=
nd
> > > > the filesystem finishes reading the bytes in before the call to
> > > > iomap_read_end(), then bytes_accounted in iomap_read_end() will be =
0 and
> > > > the following "ifs->read_bytes_pending -=3D bytes_accounting" will =
also be
> > > > 0 which will trigger an extra folio_end_read() call. This extra
> > > > folio_end_read() unlocks the folio for the 2nd time, which sets the=
 lock
> > > > bit on the folio, resulting in a permanent lockup.
> > > >
> > > > Fix this by returning from iomap_read_end() early if all bytes are =
read
> > > > in by the filesystem.
> > > >
> > > > Additionally, add some comments to clarify how this accounting logi=
c works.
> > > >
> > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > Fixes: 51311f045375 ("iomap: track pending read bytes more optimall=
y")
> > > > Reported-by: Brian Foster <bfoster@redhat.com>
> > > > --
> > > > This is a fix for commit 51311f045375 in the 'vfs-6.19.iomap' branc=
h. It
> > > > would be great if this could get folded up into that original commi=
t, if it's
> > > > not too logistically messy to do so.
> > > >
> > > > Thanks,
> > > > Joanne
> > > > ---
> > > >  fs/iomap/buffered-io.c | 22 ++++++++++++++++++++++
> > > >  1 file changed, 22 insertions(+)
> > > >
> > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > index 72196e5021b1..c31d30643e2d 100644
> > > > --- a/fs/iomap/buffered-io.c
> > > > +++ b/fs/iomap/buffered-io.c
> > > > @@ -358,6 +358,25 @@ static void iomap_read_init(struct folio *foli=
o)
> > > >       if (ifs) {
> > > >               size_t len =3D folio_size(folio);
> > > >
> > > > +             /*
> > > > +              * ifs->read_bytes_pending is used to track how many =
bytes are
> > > > +              * read in asynchronously by the filesystem. We need =
to track
> > > > +              * this so that we can know when the filesystem has f=
inished
> > > > +              * reading in the folio whereupon folio_end_read() sh=
ould be
> > > > +              * called.
> > > > +              *
> > > > +              * We first set ifs->read_bytes_pending to the entire=
 folio
> > > > +              * size. Then we track how many bytes are read in by =
the
> > > > +              * filesystem. At the end, in iomap_read_end(), we su=
btract
> > > > +              * ifs->read_bytes_pending by the number of bytes NOT=
 read in so
> > > > +              * that ifs->read_bytes_pending will be 0 when the fi=
lesystem
> > > > +              * has finished reading in all pending bytes.
> > > > +              *
> > > > +              * ifs->read_bytes_pending is initialized to the foli=
o size
> > > > +              * because we do not easily know in the beginning how=
 many
> > > > +              * bytes need to get read in by the filesystem (eg so=
me ranges
> > > > +              * may already be uptodate).
> > > > +              */
> > >
> > > Hmm.. "we do this because we don't easily know how many bytes to read=
,"
> > > but apparently that's how this worked before by bumping the count as
> > > reads were submitted..? I'm not sure this is really telling much. I'd
> > > suggest something like (and feel free to completely rework any of
> > > this)..
> >
> > Ahh with that sentence I was trying to convey that we need to do this
> > because we don't easily know in the beginning how many bytes need to
> > get read in (eg if we knew we'll be reading in 2k bytes, then we could
> > just set that to 2k instead of the folio size, and skip all the
> > accounting stuff). I will get rid of this and replace it with your
> > suggestion.
> >
> > >
> > > "Increase ->read_bytes_pending by the folio size to start. We'll
> > > subtract uptodate ranges that did not require I/O in iomap_read_end()
> > > once we're done processing the read. We do this because <reasons>."
> > >
> > > ... where <reasons> explains to somebody who might look at this in a
> > > month or year and wonder why we don't just bump read_bytes_pending as=
 we
> > > go.
> >
> > Sounds good, I will use this for v2.
> > >
> > > >               spin_lock_irq(&ifs->state_lock);
> > > >               ifs->read_bytes_pending +=3D len;
> > > >               spin_unlock_irq(&ifs->state_lock);
> > > > @@ -383,6 +402,9 @@ static void iomap_read_end(struct folio *folio,=
 size_t bytes_pending)
> > >
> > > This function could use a comment at the top to explain it's meant fo=
r
> > > ending read submission (not necessarily I/O, since that appears to be
> > > open coded in finish_folio_read()).
> > >
> > > >               bool end_read, uptodate;
> > > >               size_t bytes_accounted =3D folio_size(folio) - bytes_=
pending;
> > > >
> > >
> > > "Subtract any bytes that were initially accounted against
> > > read_bytes_pending but skipped for I/O. If zero, then the entire foli=
o
> > > was submitted and we're done. I/O completion handles the rest."
> >
> > Will add this in v2.
> >
> > >
> > > Also, maybe I'm missing something but the !bytes_accounted case means
> > > the I/O owns the folio lock now, right? If so, is it safe to access t=
he
> > > folio from here (i.e. folio_size() above)?
> >
> > I believe it is because there's still a reference on the folio here
> > since this can only be reached from the ->read_iter() and
> > ->readahead() paths, which prevents the folio from getting evicted
> > (which is what I think you're referring to?).
> >
>
> Yep, but also whether the size or anything can change.. can a large
> folio split, for example?
>
> ISTM the proper thing to do would be to somehow ensure the read submit
> side finishes (with the folio) before the completion side can complete
> the I/O, then there is an explicit ownership boundary and these sorts of
> racy folio access questions can go away. Just my 02.

Hmm, I don't think there's any way to ensure the read submit side
finishes before the completion side completes.
I think what we can do though is stash the size of the folio and just
use that. I'll make this change to v3 to be safe.

Thanks,
Joanne

>
> Brian
>
> > Thanks,
> > Joanne
> > >
> > > Comments aside, this survives a bunch of iters of my original
> > > reproducer, so seems Ok from that standpoint.
> > >
> > > Brian
> > >
> > > > +             if (!bytes_accounted)
> > > > +                     return;
> > > > +
> > > >               spin_lock_irq(&ifs->state_lock);
> > > >               ifs->read_bytes_pending -=3D bytes_accounted;
> > > >               /*
> > > > --
> > > > 2.47.3
> > > >
> > >
> >
>

