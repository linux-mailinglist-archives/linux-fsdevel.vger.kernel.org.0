Return-Path: <linux-fsdevel+bounces-41548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D82DA31788
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 22:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04CA1882CE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 21:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800DC266570;
	Tue, 11 Feb 2025 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpZotw/o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAFF266F1F;
	Tue, 11 Feb 2025 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308907; cv=none; b=CxLtHipsoDVCQ5GeAONU0Kg864vRm7LMVF2L0WuzEAUv1WStz3jndMaZL1vp7RorE+ysnf6M41/rk8qiWmOGZBTNPEJzqLa6uhmW+hgwoZuJTIOTD21+zEpLkstkPos6JsBI3KbBMlExefGZcgOAKypGlrPDdluVqWDgzlzYQU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308907; c=relaxed/simple;
	bh=yah4m2+8MkEn7/6Orz97UvZ+6/UmNEr/IWyRGPDJMEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QF+3lNHYEYg9JXPuMtHSgW/CBgHlpGjLIPYhBz4hdZViXTA8rDbg0y0coZK4oAy37MO2XSpAqIPLvixKVwU2quN85Nmg1KPrlj0ZKK+9FK3T1KnNdEsfqEaR1CUGLoPeZ3UpDfvph7FlXc5M5v9QsmBE0Va3QeGnrgpFLh7ThfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpZotw/o; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-471a25753a4so11355011cf.0;
        Tue, 11 Feb 2025 13:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739308903; x=1739913703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSbVqMiTkl0LXiSTIcddvXxCMvvitAPamcbDbPBQmiQ=;
        b=LpZotw/oMbeDByzgq8oVA0QdxXDxyh79exC6MUqAErDP9BPWRF4wCmwWYOTS8EpHbZ
         ZrHUIeGFVsqk332USrmj44hK6pxE64i4yPLdyxROUFEmVfGjDUTrENTDVicc94vzds6x
         RKUpLPJ+uORDEVhnwHxu59IKrG4DLYRUUBKLN73GPoP6atQYpJH8+dYjnAFbwXc03Cbr
         XHgdAMVx++do2+AFMMuNTW38nrDRXBK4ttO0hy/OGV6+xhSQ5QUNGOhQOAc+QCKCVTyK
         tM0mHNDrBgUK9nxVsG8EdD/440zOeeaWiJ7rydHbjFqD2F1vVEde7gQkbA/S0AMfKfUU
         obdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739308903; x=1739913703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSbVqMiTkl0LXiSTIcddvXxCMvvitAPamcbDbPBQmiQ=;
        b=NFTHgT7XYtI0A+MsXniYLbcjE7uRcT1uO8uBVXzPI8XiiHfZLs6JdFsuVMOs8BF/I/
         OTYtZ/9RQbSc+4yFtRv0OrHELnG2rRUl/n5KrYphNxHOkPBorCx9bSiGrfJ2GwCMltJb
         e0U6QmnZgNl2++bDCBTSTnfmo9gB3caeI1NpMofSLUdF+egDJ52NiCU2mUuHdztZyKCl
         91bgrvx8EgwY8S5RLpL6hnY30baKIKAsPwjcynj0AEBX68Upcx55BC8mIjSAdtViOeUX
         abdCGyYbOYTvkAzYv+4N8p9hfO/KYyEW4Khli/J689ld8UfFZnH1XS9AYmPa+4CU5zgr
         K6/g==
X-Forwarded-Encrypted: i=1; AJvYcCWMn4TVGs2s9U6veOgO7t9Dsa1MtUCtkB60R6s+PCVbeLmfcJwSGaAqqZ1ZXouMpvdSR1sE/XkCFwXuTz8s@vger.kernel.org, AJvYcCWz/YXcIVyFPJb9x+gxiqYTA8saR2FHhGKr8qMP0IaMF0bOHjXSTtMelH9wBTb5gAE4j68yfiDk5hkKMx/T@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5AZQsWeX0i/Ki+OtqGEZ6IjeJXK2rgGdkRMIuhQQc2e6D39rP
	OgAVlx/19FtTcgdfCb0JIfpJW9/FhYXCPwRMK/k+/1GNJjxTdGdywj09qS1YWLV4R4niDCgIuWs
	pKnWE8ssZUXk5S820Rpz0Ufi+2BM=
X-Gm-Gg: ASbGncvzHs2Up3NjXTfgtAOcCq6eK9CTKD7yxt1mHWSRxg/lFAbPpDB6P4PWxkmyF0J
	TdTT1Z8j/RAOk21hykbL8NyZ5Vtg1D/9n4XA9bpjo7PRGcfw4RFUxVV7aXFeHCZk76JsGlOP+vQ
	==
X-Google-Smtp-Source: AGHT+IFKtQ8UVZLdbtYyP9WyYfW9qhBvBgtzQYc9asKQ0u4aMfE1y2wI3lrrdXfr8aSY2alE3XEyecLsRiaNx7vXddo=
X-Received: by 2002:ac8:7fd4:0:b0:467:7a27:f3bb with SMTP id
 d75a77b69052e-471b07141bamr5850091cf.49.1739308903079; Tue, 11 Feb 2025
 13:21:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <9cd88643-daa8-4379-be0a-bd31de277658@suse.cz> <20250207172917.GA2072771@perftesting>
 <8f7333f2-1ba9-4df4-bc54-44fd768b3d5b@suse.cz> <CAJnrk1aNVMCfTjL0vo-Qki68-5t1W+6-bJHg+x67kHEo_-q0Eg@mail.gmail.com>
 <Z6ct4bEdeZwmksxS@casper.infradead.org> <CAJnrk1aY0ZFcS4JvmJL=icigencsCD8g4qmZiTuoPWj2S2Y_LQ@mail.gmail.com>
 <81298bd1-e630-4940-ae5b-7882576b6bf4@suse.cz> <CAJnrk1aBc5uvL78s3kdpXojH-B11wtOPSDUJ0XnCzmHH+eO2Nw@mail.gmail.com>
 <20250210191235.GA2256827@perftesting> <Z6pjSYyzFJHaQo73@casper.infradead.org>
 <8a99f6bf3f0b5cb909f11539fb3b0ef0d65b3a73.camel@kernel.org>
 <ecee2d1392fcb9b075687e7b59ec69057d3c1bb3.camel@kernel.org>
 <CAJnrk1ZkhNdCf_v4KHmsFoh3EcEaKY0Z8SVn2nJouVDxTZxv=A@mail.gmail.com> <85f1b4ca-cdc7-48d0-a985-4185eff1b49a@suse.cz>
In-Reply-To: <85f1b4ca-cdc7-48d0-a985-4185eff1b49a@suse.cz>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 11 Feb 2025 13:21:31 -0800
X-Gm-Features: AWEUYZkpMikWRVzu_vH7tBi2VNxxuVFAUWBL_42-xI-v2Um0L-YoYF3TFagCMm0
Message-ID: <CAJnrk1ZFfb7p01nkN=+tTJFt925PEAQyB=zRcsUM7Ue+TV2pZA@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Heusel <christian@heusel.eu>, Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 1:01=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/11/25 20:23, Joanne Koong wrote:
> > On Tue, Feb 11, 2025 at 6:01=E2=80=AFAM Jeff Layton <jlayton@kernel.org=
> wrote:
> >>
> >> On Mon, 2025-02-10 at 17:38 -0500, Jeff Layton wrote:
> >> > On Mon, 2025-02-10 at 20:36 +0000, Matthew Wilcox wrote:
> >> > > On Mon, Feb 10, 2025 at 02:12:35PM -0500, Josef Bacik wrote:
> >> > > > From: Josef Bacik <josef@toxicpanda.com>
> >> > > > Date: Mon, 10 Feb 2025 14:06:40 -0500
> >> > > > Subject: [PATCH] fuse: drop extra put of folio when using pipe s=
plice
> >> > > >
> >> > > > In 3eab9d7bc2f4 ("fuse: convert readahead to use folios"), I con=
verted
> >> > > > us to using the new folio readahead code, which drops the refere=
nce on
> >> > > > the folio once it is locked, using an inferred reference on the =
folio.
> >> > > > Previously we held a reference on the folio for the entire durat=
ion of
> >> > > > the readpages call.
> >> > > >
> >> > > > This is fine, however I failed to catch the case for splice pipe
> >> > > > responses where we will remove the old folio and splice in the n=
ew
> >> > > > folio.  Here we assumed that there is a reference held on the fo=
lio for
> >> > > > ap->folios, which is no longer the case.
> >> > > >
> >> > > > To fix this, simply drop the extra put to keep us consistent wit=
h the
> >> > > > non-splice variation.  This will fix the UAF bug that was report=
ed.
> >> > > >
> >> > > > Link: https://lore.kernel.org/linux-fsdevel/2f681f48-00f5-4e09-8=
431-2b3dbfaa881e@heusel.eu/
> >> > > > Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
> >> > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> > > > ---
> >> > > >  fs/fuse/dev.c | 2 --
> >> > > >  1 file changed, 2 deletions(-)
> >> > > >
> >> > > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> >> > > > index 5b5f789b37eb..5bd6e2e184c0 100644
> >> > > > --- a/fs/fuse/dev.c
> >> > > > +++ b/fs/fuse/dev.c
> >> > > > @@ -918,8 +918,6 @@ static int fuse_try_move_page(struct fuse_co=
py_state *cs, struct page **pagep)
> >> > > >   }
> >> > > >
> >> > > >   folio_unlock(oldfolio);
> >> > > > - /* Drop ref for ap->pages[] array */
> >> > > > - folio_put(oldfolio);
> >> > > >   cs->len =3D 0;
> >> > >
> >> > > But aren't we now leaking a reference to newfolio?  ie shouldn't
> >> > > we also:
> >> > >
> >> > > -   folio_get(newfolio);
> >> > >
> >> > > a few lines earlier?
> >> > >
> >> >
> >> >
> >> > I think that ref was leaking without Josef's patch, but your propose=
d
> >> > fix seems correct to me. There is:
> >> >
> >> > - 1 reference stolen from the pipe_buffer
> >> > - 1 reference taken for the pagecache in replace_page_cache_folio()
> >> > - the folio_get(newfolio) just after that
> >> >
> >> > The pagecache ref doesn't count here, and we only need the reference
> >> > that was stolen from the pipe_buffer to replace the one in pagep.
> >>
> >> Actually, no. I'm wrong here. A little after the folio_get(newfolio)
> >> call, we do:
> >>
> >>         /*
> >>          * Release while we have extra ref on stolen page.  Otherwise
> >>          * anon_pipe_buf_release() might think the page can be reused.
> >>          */
> >>         pipe_buf_release(cs->pipe, buf);
> >>
> >> ...so that accounts for the extra reference. I think the newfolio
> >> refcounting is correct as-is.
> >
> > I think we do need to remove the folio_get(newfolio); here or we are
> > leaking the reference.
> >
> > new_folio =3D page_folio(buf->page) # ref is 1
> > replace_page_cache_folio() # ref is 2
> > folio_get() # ref is 3
> > pipe_buf_release() # ref is 2
> >
> > One ref belongs to the page cache and will get dropped by that, but
> > the other ref is unaccounted for (since the original patch removed
> > "folio_put()" from fuse_readpages_end()).
> >
> > I still think acquiring an explicit reference on the folio before we
> > add it to ap->folio and then dropping it when we're completely done
> > with it in fuse_readpages_end() is the best solution, as that imo
> > makes the refcounting / lifetimes the most explicit / clear. For
> > example, in try_move_pages(), if we get rid of that "folio_get()"
> > call, the page cache is the holder of the remaining reference on it,
> > and we rely on the earlier "folio_clear_uptodate(newfolio);" line in
> > try_move_pages() to guarantee that the newfolio isn't freed out from
> > under us if memory gets tight and it's evicted from the page cache.
> >
> > imo, a patch like this makes the refcounting the most clear:
> >
> > From 923fa98b97cf6dfba3bb486833179c349d566d64 Mon Sep 17 00:00:00 2001
> > From: Joanne Koong <joannelkoong@gmail.com>
> > Date: Tue, 11 Feb 2025 10:59:40 -0800
> > Subject: [PATCH] fuse: acquire explicit folio refcount for readahead
> >
> > In 3eab9d7bc2f4 ("fuse: convert readahead to use folios"), the logic
> > was converted to using the new folio readahead code, which drops the
> > reference on the folio once it is locked, using an inferred reference
> > on the folio. Previously we held a reference on the folio for the
> > entire duration of the readpages call.
> >
> > This is fine, however for the case for splice pipe responses where we
> > will remove the old folio and splice in the new folio (see
> > fuse_try_move_page()), we assume that there is a reference held on the
> > folio for ap->folios, which is no longer the case.
> >
> > To fix this and make the refcounting explicit, acquire a refcount on th=
e
> > folio before we add it to ap->folios[] and drop it when we are done wit=
h
> > the folio in fuse_readpages_end(). This will fix the UAF bug that was
> > reported.
> >
> > Link: https://lore.kernel.org/linux-fsdevel/2f681f48-00f5-4e09-8431-2b3=
dbfaa881e@heusel.eu/
> > Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
>
> Can we add some tags?
>
> Reported-by: Christian Heusel <christian@heusel.eu>
> Closes: https://lore.kernel.org/all/2f681f48-00f5-4e09-8431-2b3dbfaa881e@=
heusel.eu/
> Closes: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-=
/issues/110
> Reported-by: Mantas Mikul=C4=97nas <grawity@gmail.com>
> Closes: https://lore.kernel.org/all/34feb867-09e2-46e4-aa31-d9660a806d1a@=
gmail.com/
> Closes: https://bugzilla.opensuse.org/show_bug.cgi?id=3D1236660
> Cc: <stable@vger.kernel.org>
>

Ok, I'll add these tags in and formally submit this patch to Miklos's tree.

> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/file.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 7d92a5479998..6fa535c73d93 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -955,8 +955,10 @@ static void fuse_readpages_end(struct fuse_mount
> > *fm, struct fuse_args *args,
> >                 fuse_invalidate_atime(inode);
> >         }
> >
> > -       for (i =3D 0; i < ap->num_folios; i++)
> > +       for (i =3D 0; i < ap->num_folios; i++) {
> >                 folio_end_read(ap->folios[i], !err);
> > +               folio_put(ap->folios[i]);
> > +       }
> >         if (ia->ff)
> >                 fuse_file_put(ia->ff, false);
> >
> > @@ -1049,6 +1051,12 @@ static void fuse_readahead(struct readahead_cont=
rol *rac)
> >
> >                 while (ap->num_folios < cur_pages) {
> >                         folio =3D readahead_folio(rac);
> > +                       /*
> > +                        * Acquire an explicit reference on the folio i=
n case
> > +                        * it's replaced in the page cache in the splic=
e case
> > +                        * (see fuse_try_move_page()).
> > +                        */
> > +                       folio_get(folio);
>
> It would be more efficient to use __readahead_folio() instead of doing a =
folio_get()
> to counter a folio_put() in readahead_folio(). An adjusted comment can ex=
plain why
> we use __readahead_folio().

imo, the explicit get makes the code the most readable, but I also
don't feel strongly enough about it to insist. I'll make this change
in the patch.

>
> >                         ap->folios[ap->num_folios] =3D folio;
> >                         ap->descs[ap->num_folios].length =3D folio_size=
(folio);
> >                         ap->num_folios++;
> > --
> > 2.43.5
> >
> >> --
> >> Jeff Layton <jlayton@kernel.org>
>

