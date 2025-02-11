Return-Path: <linux-fsdevel+bounces-41539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153B8A31586
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 20:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6D53A88CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 19:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E12326E629;
	Tue, 11 Feb 2025 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TScLFLDf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AC126E621;
	Tue, 11 Feb 2025 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302886; cv=none; b=DqXQRRktY0f5uWCpnIEeSjF7SKd/TC7bvuZN2A0dYlWgmYDZ2j/AXm/+OUMY9elkoAADXFEurglTTdZ6OtVvuK/exEvLPUbYdUyJlC8hYkLxtA9hOW3G7jF00XhMEjNs46Qc8wPL/aKgVYfB0i+eui8MXSsxOQ2l7eO5E27vcWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302886; c=relaxed/simple;
	bh=wyuWO4+BsTqL7ZYVZIiN1q+tRwj/Y51Gd1Rz4sTVDLc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HpxPcH5ECkPK4lrdbOnlZA4bI2caHvScK7AzYrdGa+OQ+5RsxIMjKFHoUPektr/XNDoqmbkBNXGvJnfGI3PWrokHOY10zi9sJT1ELVtHHsyXO1dzfG/st9OR1hr3M3BoVTTjKU34k2Flt2ZkwvkOezre+VS5KvndqDev4eOjDfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TScLFLDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C68C4CEDD;
	Tue, 11 Feb 2025 19:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739302885;
	bh=wyuWO4+BsTqL7ZYVZIiN1q+tRwj/Y51Gd1Rz4sTVDLc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TScLFLDfuuxsBNDBlTgtYSZxCyoBxR2L74eWFlR2NQq6ewwX7MOw61Vonw/NnsPmZ
	 rZMhvLVxP1wp5nJuMYKIZ0jNln1hUMMXkugjdFLOIAzieV6jV8M+WZ3ZL10VpSOCzW
	 0Knck6uHIplLBFbNrIWyr/rF0Er+/LUHpg4WXlZKqb/ysjYTN2AfR9PzOi33yEcIRU
	 O59ZF8eXAdAlJaCaOQrJzonChuDFApPqzqPf7AI+McdN1ssU3IXqre4pNl+080wGFz
	 UMM/nppEmOajz//NyJw21aTVhRS8ig3v0Fd2BWHPdgFRhNHSKY049hN8mVNLMxaeRR
	 d+FJNw5km01PQ==
Message-ID: <dd9b064f0b140f9b83175ae15208d7a56af4651c.camel@kernel.org>
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for
 FUSE/Flatpak related applications since v6.13
From: Jeff Layton <jlayton@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Josef Bacik
 <josef@toxicpanda.com>,  Vlastimil Babka	 <vbabka@suse.cz>, Miklos Szeredi
 <miklos@szeredi.hu>, Christian Heusel	 <christian@heusel.eu>, Miklos
 Szeredi <mszeredi@redhat.com>, 	regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, 	linux-fsdevel@vger.kernel.org, linux-mm
 <linux-mm@kvack.org>, Mantas =?UTF-8?Q?Mikul=C4=97nas?=	 <grawity@gmail.com>
Date: Tue, 11 Feb 2025 14:41:23 -0500
In-Reply-To: <CAJnrk1ZkhNdCf_v4KHmsFoh3EcEaKY0Z8SVn2nJouVDxTZxv=A@mail.gmail.com>
References: 
	<CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
	 <9cd88643-daa8-4379-be0a-bd31de277658@suse.cz>
	 <20250207172917.GA2072771@perftesting>
	 <8f7333f2-1ba9-4df4-bc54-44fd768b3d5b@suse.cz>
	 <CAJnrk1aNVMCfTjL0vo-Qki68-5t1W+6-bJHg+x67kHEo_-q0Eg@mail.gmail.com>
	 <Z6ct4bEdeZwmksxS@casper.infradead.org>
	 <CAJnrk1aY0ZFcS4JvmJL=icigencsCD8g4qmZiTuoPWj2S2Y_LQ@mail.gmail.com>
	 <81298bd1-e630-4940-ae5b-7882576b6bf4@suse.cz>
	 <CAJnrk1aBc5uvL78s3kdpXojH-B11wtOPSDUJ0XnCzmHH+eO2Nw@mail.gmail.com>
	 <20250210191235.GA2256827@perftesting>
	 <Z6pjSYyzFJHaQo73@casper.infradead.org>
	 <8a99f6bf3f0b5cb909f11539fb3b0ef0d65b3a73.camel@kernel.org>
	 <ecee2d1392fcb9b075687e7b59ec69057d3c1bb3.camel@kernel.org>
	 <CAJnrk1ZkhNdCf_v4KHmsFoh3EcEaKY0Z8SVn2nJouVDxTZxv=A@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-11 at 11:23 -0800, Joanne Koong wrote:
> On Tue, Feb 11, 2025 at 6:01=E2=80=AFAM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > On Mon, 2025-02-10 at 17:38 -0500, Jeff Layton wrote:
> > > On Mon, 2025-02-10 at 20:36 +0000, Matthew Wilcox wrote:
> > > > On Mon, Feb 10, 2025 at 02:12:35PM -0500, Josef Bacik wrote:
> > > > > From: Josef Bacik <josef@toxicpanda.com>
> > > > > Date: Mon, 10 Feb 2025 14:06:40 -0500
> > > > > Subject: [PATCH] fuse: drop extra put of folio when using pipe sp=
lice
> > > > >=20
> > > > > In 3eab9d7bc2f4 ("fuse: convert readahead to use folios"), I conv=
erted
> > > > > us to using the new folio readahead code, which drops the referen=
ce on
> > > > > the folio once it is locked, using an inferred reference on the f=
olio.
> > > > > Previously we held a reference on the folio for the entire durati=
on of
> > > > > the readpages call.
> > > > >=20
> > > > > This is fine, however I failed to catch the case for splice pipe
> > > > > responses where we will remove the old folio and splice in the ne=
w
> > > > > folio.  Here we assumed that there is a reference held on the fol=
io for
> > > > > ap->folios, which is no longer the case.
> > > > >=20
> > > > > To fix this, simply drop the extra put to keep us consistent with=
 the
> > > > > non-splice variation.  This will fix the UAF bug that was reporte=
d.
> > > > >=20
> > > > > Link: https://lore.kernel.org/linux-fsdevel/2f681f48-00f5-4e09-84=
31-2b3dbfaa881e@heusel.eu/
> > > > > Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
> > > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > > > ---
> > > > >  fs/fuse/dev.c | 2 --
> > > > >  1 file changed, 2 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > > > index 5b5f789b37eb..5bd6e2e184c0 100644
> > > > > --- a/fs/fuse/dev.c
> > > > > +++ b/fs/fuse/dev.c
> > > > > @@ -918,8 +918,6 @@ static int fuse_try_move_page(struct fuse_cop=
y_state *cs, struct page **pagep)
> > > > >   }
> > > > >=20
> > > > >   folio_unlock(oldfolio);
> > > > > - /* Drop ref for ap->pages[] array */
> > > > > - folio_put(oldfolio);
> > > > >   cs->len =3D 0;
> > > >=20
> > > > But aren't we now leaking a reference to newfolio?  ie shouldn't
> > > > we also:
> > > >=20
> > > > -   folio_get(newfolio);
> > > >=20
> > > > a few lines earlier?
> > > >=20
> > >=20
> > >=20
> > > I think that ref was leaking without Josef's patch, but your proposed
> > > fix seems correct to me. There is:
> > >=20
> > > - 1 reference stolen from the pipe_buffer
> > > - 1 reference taken for the pagecache in replace_page_cache_folio()
> > > - the folio_get(newfolio) just after that
> > >=20
> > > The pagecache ref doesn't count here, and we only need the reference
> > > that was stolen from the pipe_buffer to replace the one in pagep.
> >=20
> > Actually, no. I'm wrong here. A little after the folio_get(newfolio)
> > call, we do:
> >=20
> >         /*
> >          * Release while we have extra ref on stolen page.  Otherwise
> >          * anon_pipe_buf_release() might think the page can be reused.
> >          */
> >         pipe_buf_release(cs->pipe, buf);
> >=20
> > ...so that accounts for the extra reference. I think the newfolio
> > refcounting is correct as-is.
>=20
> I think we do need to remove the folio_get(newfolio); here or we are
> leaking the reference.
>=20
> new_folio =3D page_folio(buf->page) # ref is 1
> replace_page_cache_folio() # ref is 2
> folio_get() # ref is 3
> pipe_buf_release() # ref is 2
>=20
> One ref belongs to the page cache and will get dropped by that, but
> the other ref is unaccounted for (since the original patch removed
> "folio_put()" from fuse_readpages_end()).
>=20
> I still think acquiring an explicit reference on the folio before we
> add it to ap->folio and then dropping it when we're completely done
> with it in fuse_readpages_end() is the best solution, as that imo
> makes the refcounting / lifetimes the most explicit / clear. For
> example, in try_move_pages(), if we get rid of that "folio_get()"
> call, the page cache is the holder of the remaining reference on it,
> and we rely on the earlier "folio_clear_uptodate(newfolio);" line in
> try_move_pages() to guarantee that the newfolio isn't freed out from
> under us if memory gets tight and it's evicted from the page cache.
>=20
> imo, a patch like this makes the refcounting the most clear:
>=20
> From 923fa98b97cf6dfba3bb486833179c349d566d64 Mon Sep 17 00:00:00 2001
> From: Joanne Koong <joannelkoong@gmail.com>
> Date: Tue, 11 Feb 2025 10:59:40 -0800
> Subject: [PATCH] fuse: acquire explicit folio refcount for readahead
>=20
> In 3eab9d7bc2f4 ("fuse: convert readahead to use folios"), the logic
> was converted to using the new folio readahead code, which drops the
> reference on the folio once it is locked, using an inferred reference
> on the folio. Previously we held a reference on the folio for the
> entire duration of the readpages call.
>=20
> This is fine, however for the case for splice pipe responses where we
> will remove the old folio and splice in the new folio (see
> fuse_try_move_page()), we assume that there is a reference held on the
> folio for ap->folios, which is no longer the case.
>=20
> To fix this and make the refcounting explicit, acquire a refcount on the
> folio before we add it to ap->folios[] and drop it when we are done with
> the folio in fuse_readpages_end(). This will fix the UAF bug that was
> reported.
>=20
> Link: https://lore.kernel.org/linux-fsdevel/2f681f48-00f5-4e09-8431-2b3db=
faa881e@heusel.eu/
> Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 7d92a5479998..6fa535c73d93 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -955,8 +955,10 @@ static void fuse_readpages_end(struct fuse_mount
> *fm, struct fuse_args *args,
>                 fuse_invalidate_atime(inode);
>         }
>=20
> -       for (i =3D 0; i < ap->num_folios; i++)
> +       for (i =3D 0; i < ap->num_folios; i++) {
>                 folio_end_read(ap->folios[i], !err);
> +               folio_put(ap->folios[i]);
> +       }
>         if (ia->ff)
>                 fuse_file_put(ia->ff, false);
>=20
> @@ -1049,6 +1051,12 @@ static void fuse_readahead(struct readahead_contro=
l *rac)
>=20
>                 while (ap->num_folios < cur_pages) {
>                         folio =3D readahead_folio(rac);
> +                       /*
> +                        * Acquire an explicit reference on the folio in =
case
> +                        * it's replaced in the page cache in the splice =
case
> +                        * (see fuse_try_move_page()).
> +                        */
> +                       folio_get(folio);
>                         ap->folios[ap->num_folios] =3D folio;
>                         ap->descs[ap->num_folios].length =3D folio_size(f=
olio);
>                         ap->num_folios++;

That makes sense. My mistake was assuming the pointer in passed in via
pagep would hold a reference, and that the replacement folio would
carry one. I like the above better than assuming we have implicit
reference due to readpages. It's slightly more expensive due to the
refcounting, but it seems less brittle.

We should couple this with a comment over fuse_try_move_page().
Something like this maybe?

/*
 * Attempt to steal a page from the splice() pipe and move it into the
 * pagecache. If successful, the pointer in @pagep will be updated. The
 * folio that was originally in @pagep will lose a reference and the new
 * folio returned in @pagep will carry a reference.
 */

...

In any case, for this patch:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

