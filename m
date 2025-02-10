Return-Path: <linux-fsdevel+bounces-41445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6F0A2F938
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B86097A33BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 19:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA52B81749;
	Mon, 10 Feb 2025 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq/ftJ6l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8E24C68B;
	Mon, 10 Feb 2025 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216552; cv=none; b=KDeFEHTRdJF7kw6vZf5uzcJ/hk3gL71VQD5t7QU3ssB93WuShKMpXr887hNgX91G5lenk0EMYEkLA/uXJjyasfplKMuVNACDcJdW6OtCpGeBt7F4YL7Y64e/tMvcunE/2Q/Cw0N0Ln86QQhMqniPz3rm/Es5S2i8QG1VjEoonIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216552; c=relaxed/simple;
	bh=iHTa3v6bu6Wa114W+rf3gxvNsMEALCyX/v82IapYydQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LWUS6Jfo1cGyzjuUTvXWnn2NVwJVZZJ7dMlZsTc/iJaAiR/rPU3ToWNrk+k+WVfu5cZgpuxcLUo2YhIo1wO8P/Cv1AsWYmdOJnh8g3UjkIQZq2rE3tqssmyoandH17eSndw9tat92ePZ5TIs9agmBHGA2qxQWqwECOwXsB7nD8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sq/ftJ6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BACC4CED1;
	Mon, 10 Feb 2025 19:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739216551;
	bh=iHTa3v6bu6Wa114W+rf3gxvNsMEALCyX/v82IapYydQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Sq/ftJ6lsZJdEtXnImb/P4VZviY7nXmGEQy9kAyjsJE7WMyOZ0jOKdcaqolnlpLv4
	 tFtFY5Foo6EPNQQNP0f2CJ2BE1qW9pW+NZataljEBFcKMo0h+4P6p0q+d71nmDnYcX
	 KOPaimrVvFcGCR5OWIe6E7AXcjTOqb3tuhoW6/6N+dIPNgewKoVpcDCTuJ2HlOyAfb
	 1DBlqNILdRTU1BsIiS15rjuD+a+8IIqlrmW+aworIjjQJjztSZs9Zpr1einHbuxsjf
	 8wvtxEFGq6wgo2JUwColvgjhkGVIvdPi/VpimCg7QVf0+a7ALBqQQLQhFZ5lSZM0u0
	 7xsV7ST959Ltg==
Message-ID: <87c9118a4456c008d321215cb4632055ce3e2204.camel@kernel.org>
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for
 FUSE/Flatpak related applications since v6.13
From: Jeff Layton <jlayton@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Joanne Koong <joannelkoong@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
 Miklos Szeredi <miklos@szeredi.hu>, Christian Heusel <christian@heusel.eu>,
 Miklos Szeredi <mszeredi@redhat.com>, 	regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, 	linux-fsdevel@vger.kernel.org, linux-mm
 <linux-mm@kvack.org>, Mantas =?UTF-8?Q?Mikul=C4=97nas?=	 <grawity@gmail.com>
Date: Mon, 10 Feb 2025 14:42:27 -0500
In-Reply-To: <20250210191235.GA2256827@perftesting>
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
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

On Mon, 2025-02-10 at 14:12 -0500, Josef Bacik wrote:
> On Mon, Feb 10, 2025 at 10:13:51AM -0800, Joanne Koong wrote:
> > On Mon, Feb 10, 2025 at 12:27=E2=80=AFAM Vlastimil Babka <vbabka@suse.c=
z> wrote:
> > >=20
> > > On 2/8/25 16:46, Joanne Koong wrote:
> > > > On Sat, Feb 8, 2025 at 2:11=E2=80=AFAM Matthew Wilcox <willy@infrad=
ead.org> wrote:
> > > > >=20
> > > > > On Fri, Feb 07, 2025 at 04:22:56PM -0800, Joanne Koong wrote:
> > > > > > > Thanks, Josef. I guess we can at least try to confirm we're o=
n the right track.
> > > > > > > Can anyone affected see if this (only compile tested) patch f=
ixes the issue?
> > > > > > > Created on top of 6.13.1.
> > > > > >=20
> > > > > > This fixes the crash for me on 6.14.0-rc1. I ran the repro usin=
g
> > > > > > Mantas's instructions for Obfuscate. I was able to trigger the =
crash
> > > > > > on a clean build and then with this patch, I'm not seeing the c=
rash
> > > > > > anymore.
> > > > >=20
> > > > > Since this patch fixes the bug, we're looking for one call to fol=
io_put()
> > > > > too many.  Is it possibly in fuse_try_move_page()?  In particular=
, this
> > > > > one:
> > > > >=20
> > > > >         /* Drop ref for ap->pages[] array */
> > > > >         folio_put(oldfolio);
> > > > >=20
> > > > > I don't know fuse very well.  Maybe this isn't it.
> > > >=20
> > > > Yeah, this looks it to me. We don't grab a folio reference for the
> > > > ap->pages[] array for readahead and it tracks with Mantas's
> > > > fuse_dev_splice_write() dmesg. this patch fixed the crash for me wh=
en
> > > > I tested it yesterday:
> > > >=20
> > > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > > index 7d92a5479998..172cab8e2caf 100644
> > > > --- a/fs/fuse/file.c
> > > > +++ b/fs/fuse/file.c
> > > > @@ -955,8 +955,10 @@ static void fuse_readpages_end(struct fuse_mou=
nt
> > > > *fm, struct fuse_args *args,
> > > >                 fuse_invalidate_atime(inode);
> > > >         }
> > > >=20
> > > > -       for (i =3D 0; i < ap->num_folios; i++)
> > > > +       for (i =3D 0; i < ap->num_folios; i++) {
> > > >                 folio_end_read(ap->folios[i], !err);
> > > > +               folio_put(ap->folios[i]);
> > > > +       }
> > > >         if (ia->ff)
> > > >                 fuse_file_put(ia->ff, false);
> > > >=20
> > > > @@ -1049,6 +1051,7 @@ static void fuse_readahead(struct readahead_c=
ontrol *rac)
> > > >=20
> > > >                 while (ap->num_folios < cur_pages) {
> > > >                         folio =3D readahead_folio(rac);
> > > > +                       folio_get(folio);
> > >=20
> > > This is almost the same as my patch, but balances the folio_put() in
> > > readahead_folio() with another folio_get(), while mine uses
> > > __readahead_folio() that does not do folio_put() in the first place.
> > >=20
> > > But I think neither patch proves the extraneous folio_put() comes fro=
m
> > > fuse_try_move_page().
> > >=20
> > > >                         ap->folios[ap->num_folios] =3D folio;
> > > >                         ap->descs[ap->num_folios].length =3D folio_=
size(folio);
> > > >                         ap->num_folios++;
> > > >=20
> > > >=20
> > > > I reran it just now with a printk by that ref drop in
> > > > fuse_try_move_page() and I'm indeed seeing that path get hit.
> > >=20
> > > It might get hit, but is it hit in the readahead paths? One way to te=
st
> > > would be to instead of yours above or mine change, to stop doing the
> > > foio_put() in fuse_try_move_page(). But maybe it's called also from o=
ther
> > > contexts that do expect it, and will leak memory otherwise.
> >=20
> > When I tested it a few days ago, I printk-ed the address of the folio
> > and it matched in fuse_readahead() and try_move_page(). I think that
> > proves that the extra folio_put() came from fuse_try_move_page()
> > through the readahead path.
>=20
> This patch should fix the problem, let me know if it's stil happening
>=20
> From 964c798ee9e8f2e8e2c37cfd060c76a772cc45b7 Mon Sep 17 00:00:00 2001
> Message-ID: <964c798ee9e8f2e8e2c37cfd060c76a772cc45b7.1739214698.git.jose=
f@toxicpanda.com>
> From: Josef Bacik <josef@toxicpanda.com>
> Date: Mon, 10 Feb 2025 14:06:40 -0500
> Subject: [PATCH] fuse: drop extra put of folio when using pipe splice
>=20
> In 3eab9d7bc2f4 ("fuse: convert readahead to use folios"), I converted
> us to using the new folio readahead code, which drops the reference on
> the folio once it is locked, using an inferred reference on the folio.
> Previously we held a reference on the folio for the entire duration of
> the readpages call.
>=20
> This is fine, however I failed to catch the case for splice pipe
> responses where we will remove the old folio and splice in the new
> folio.  Here we assumed that there is a reference held on the folio for
> ap->folios, which is no longer the case.
>=20
> To fix this, simply drop the extra put to keep us consistent with the
> non-splice variation.  This will fix the UAF bug that was reported.
>=20
> Link: https://lore.kernel.org/linux-fsdevel/2f681f48-00f5-4e09-8431-2b3db=
faa881e@heusel.eu/
> Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/fuse/dev.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 5b5f789b37eb..5bd6e2e184c0 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -918,8 +918,6 @@ static int fuse_try_move_page(struct fuse_copy_state =
*cs, struct page **pagep)
>  	}
> =20
>  	folio_unlock(oldfolio);
> -	/* Drop ref for ap->pages[] array */
> -	folio_put(oldfolio);
>  	cs->len =3D 0;
> =20
>  	err =3D 0;

Reviewed-by: Jeff Layton <jlayton@kernel.org>

