Return-Path: <linux-fsdevel+bounces-41546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 284A1A31766
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 22:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7241F188C365
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 21:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A5E2690DE;
	Tue, 11 Feb 2025 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3a1K4IO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249AA2690C2;
	Tue, 11 Feb 2025 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308270; cv=none; b=E57RugerIFSIvXY67iy1s6S359yJw9iMgpqGRTK3SLyzYaCvUzBIO0Bw6l7xzAXsJtp0mFXFQemMt41yMbE33eux0/DIhhimW/ysT/+ZSR0vQ83h3f/ugw76SqarONQX5pJFcJfDFxuVeUDuUg5hFmHlunYyScAbN0pNWQ4D7q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308270; c=relaxed/simple;
	bh=g9hKvS61hmxPsx0BwGIxRf+eowTqjK810sZKQBmho+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNs47uOVBX7p55AvULZF70/0Qx5XXGHACvJ5JTJtihPuB0soISWedikdUS8UU5V773ASahjiltaysSMv9c6s95N3Z0JRTFnhXBN3PriMQzbhA3kHtFW9YPiQ2BzAviw58fQSfMm54mQkaXSUaxlwqidA1ROGnRN1u+MZc2wjy1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3a1K4IO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46fd4bf03cbso91308121cf.0;
        Tue, 11 Feb 2025 13:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739308267; x=1739913067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAuMfXRaQLdMu9tTkvgqRg79Mjm8+DLzP2FAOqvmZcg=;
        b=G3a1K4IOSK8VDi4xQWbISiqPB5aq8WvdTm229UsKi7m2sNc/83mPzuVUzbx2hBhDC9
         /A1dvsrIdV0VU9wp9vxbH0KbZodzxYjR0HgdJ3Btq2P2U19NsckVV0mOoZKUZz7PUQQm
         vGOeAPOCnUc9+jsEUMEpmadQ/DCrKCO2io3iSNWnnbxVzItDbmoPfGe9jnHlvR6ZeoZI
         bMkT6/8bpQ09EcBsr9r6Inf3qq1wMqK8QyRBNMHXxCLOo3BX5L+QoKx8w6k+ewNS1K1j
         ho1J6Rr1L6EmbejAvYFzbDvaOu01M99ew1/oX9JvNvG6SlGXBfEU21Rze9rxwYX5u/Dm
         RWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739308267; x=1739913067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAuMfXRaQLdMu9tTkvgqRg79Mjm8+DLzP2FAOqvmZcg=;
        b=uzLtfe/izosqCY4JCJWqIwXAFohSlcIblyE78KGir5Pb1jeCB3F7bYItfksSwToZi3
         lWXG2YacvbhpBFqKu/moGshR0rk3PSlvjXkri6HBCm/QdANmE0Ci8J1a1Mi13zvh/ckH
         WTu/3DMkrkOIq1+OJeMtZ8CH7/CdzZqJqU0xvj63Znqs7Aley4Wx8dc8j8ni4RXfj2ij
         3wC+TzrlUOrdNRO3CjMfFlDohtvh9k6zT6CcJdom4bOlUVVpB6sCP8r+Y1iGI1q9MHs1
         38y/wD4aEoCLYs53uO75ol/zljLA0YkFLabWNWMywru4cGSmTkBNNioQIy8iOGyO/krG
         6caQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhnw89uxYeUFOHww+R0XOlv86sTZdAuCYOKfQqcBBwZqHK1qzg7PVUwpqb9oLF0vmtnw8dGsiw/iBdpGf5@vger.kernel.org, AJvYcCXAWgwFtLAOwByUwm5E4ftarsPCrX6EAnnKhl/CC3VSUBIT3W3thYZvn/JU0MWWZPMbDA8AzL/eM/PsYfEr@vger.kernel.org
X-Gm-Message-State: AOJu0YyKEwaUXumGrfq+cN82gqPSgr4AFN5fCSlElNopebkP46FFWfin
	aHzN4PvLEBWvQcfUP8MSp9RGmnrQh4SD5BWkrkbCCUM2CPPQbeU6r51LECK34lD1E8v7XhgQqEr
	yTFYOIVdXujwKrHYUE/2AnlSZBoo=
X-Gm-Gg: ASbGncuIYUpO2DAaVCoeTYjNBJgmYLttF/z85EnOIjijsDINKknYmbdwpdGVzbC1ye7
	HZqQyQNWs15rL42TvBEJSGjBBDuwvFmOTElngtaBryGu3PsMOPXuf9t1MBZE+M5eA5j7rNVRaxw
	==
X-Google-Smtp-Source: AGHT+IHCak+6ZWfjbFFqHo/xIJzNDSDRrtPztkntxLpbJYNa1dGRVwPhhxVAUraO3P9FIWxcs/XZadwLeW1Xhm4Q+m0=
X-Received: by 2002:a05:622a:1b12:b0:471:a2d5:acda with SMTP id
 d75a77b69052e-471afe6d09bmr8881191cf.26.1739308266948; Tue, 11 Feb 2025
 13:11:06 -0800 (PST)
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
 <CAJnrk1ZkhNdCf_v4KHmsFoh3EcEaKY0Z8SVn2nJouVDxTZxv=A@mail.gmail.com> <dd9b064f0b140f9b83175ae15208d7a56af4651c.camel@kernel.org>
In-Reply-To: <dd9b064f0b140f9b83175ae15208d7a56af4651c.camel@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 11 Feb 2025 13:10:40 -0800
X-Gm-Features: AWEUYZmion1fONaEjSH0uaM2LEumNjfTl_1CMECZgdbOS8CnCTXNSiA_nTE9X5Q
Message-ID: <CAJnrk1aoS-XOL5uOE+ZJCT_dPCmZywMguqgJ772N7Kj11RoO4A@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
To: Jeff Layton <jlayton@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Josef Bacik <josef@toxicpanda.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Heusel <christian@heusel.eu>, Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 11:41=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Tue, 2025-02-11 at 11:23 -0800, Joanne Koong wrote:
> > On Tue, Feb 11, 2025 at 6:01=E2=80=AFAM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Mon, 2025-02-10 at 17:38 -0500, Jeff Layton wrote:
> > > > On Mon, 2025-02-10 at 20:36 +0000, Matthew Wilcox wrote:
> > > > > On Mon, Feb 10, 2025 at 02:12:35PM -0500, Josef Bacik wrote:
> > > > > > From: Josef Bacik <josef@toxicpanda.com>
> > > > > > Date: Mon, 10 Feb 2025 14:06:40 -0500
> > > > > > Subject: [PATCH] fuse: drop extra put of folio when using pipe =
splice
> > > > > >
> > > > > > In 3eab9d7bc2f4 ("fuse: convert readahead to use folios"), I co=
nverted
> > > > > > us to using the new folio readahead code, which drops the refer=
ence on
> > > > > > the folio once it is locked, using an inferred reference on the=
 folio.
> > > > > > Previously we held a reference on the folio for the entire dura=
tion of
> > > > > > the readpages call.
> > > > > >
> > > > > > This is fine, however I failed to catch the case for splice pip=
e
> > > > > > responses where we will remove the old folio and splice in the =
new
> > > > > > folio.  Here we assumed that there is a reference held on the f=
olio for
> > > > > > ap->folios, which is no longer the case.
> > > > > >
> > > > > > To fix this, simply drop the extra put to keep us consistent wi=
th the
> > > > > > non-splice variation.  This will fix the UAF bug that was repor=
ted.
> > > > > >
> > > > > > Link: https://lore.kernel.org/linux-fsdevel/2f681f48-00f5-4e09-=
8431-2b3dbfaa881e@heusel.eu/
> > > > > > Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
> > > > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > > > > ---
> > > > > >  fs/fuse/dev.c | 2 --
> > > > > >  1 file changed, 2 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > > > > index 5b5f789b37eb..5bd6e2e184c0 100644
> > > > > > --- a/fs/fuse/dev.c
> > > > > > +++ b/fs/fuse/dev.c
> > > > > > @@ -918,8 +918,6 @@ static int fuse_try_move_page(struct fuse_c=
opy_state *cs, struct page **pagep)
> > > > > >   }
> > > > > >
> > > > > >   folio_unlock(oldfolio);
> > > > > > - /* Drop ref for ap->pages[] array */
> > > > > > - folio_put(oldfolio);
> > > > > >   cs->len =3D 0;
> > > > >
> > > > > But aren't we now leaking a reference to newfolio?  ie shouldn't
> > > > > we also:
> > > > >
> > > > > -   folio_get(newfolio);
> > > > >
> > > > > a few lines earlier?
> > > > >
> > > >
> > > >
> > > > I think that ref was leaking without Josef's patch, but your propos=
ed
> > > > fix seems correct to me. There is:
> > > >
> > > > - 1 reference stolen from the pipe_buffer
> > > > - 1 reference taken for the pagecache in replace_page_cache_folio()
> > > > - the folio_get(newfolio) just after that
> > > >
> > > > The pagecache ref doesn't count here, and we only need the referenc=
e
> > > > that was stolen from the pipe_buffer to replace the one in pagep.
> > >
> > > Actually, no. I'm wrong here. A little after the folio_get(newfolio)
> > > call, we do:
> > >
> > >         /*
> > >          * Release while we have extra ref on stolen page.  Otherwise
> > >          * anon_pipe_buf_release() might think the page can be reused=
.
> > >          */
> > >         pipe_buf_release(cs->pipe, buf);
> > >
> > > ...so that accounts for the extra reference. I think the newfolio
> > > refcounting is correct as-is.
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
> >                         ap->folios[ap->num_folios] =3D folio;
> >                         ap->descs[ap->num_folios].length =3D folio_size=
(folio);
> >                         ap->num_folios++;
>
> That makes sense. My mistake was assuming the pointer in passed in via
> pagep would hold a reference, and that the replacement folio would
> carry one. I like the above better than assuming we have implicit
> reference due to readpages. It's slightly more expensive due to the
> refcounting, but it seems less brittle.
>
> We should couple this with a comment over fuse_try_move_page().
> Something like this maybe?
>
> /*
>  * Attempt to steal a page from the splice() pipe and move it into the
>  * pagecache. If successful, the pointer in @pagep will be updated. The
>  * folio that was originally in @pagep will lose a reference and the new
>  * folio returned in @pagep will carry a reference.
>  */

Great idea, I'll add this in.

>
> ...
>
> In any case, for this patch:
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

