Return-Path: <linux-fsdevel+bounces-41440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00867A2F805
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 19:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE81E3A70B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F542288DB;
	Mon, 10 Feb 2025 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMk5rQFz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B389B179A7;
	Mon, 10 Feb 2025 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739213936; cv=none; b=iJnnYcj6xIXSbW+1TqoEoyW1VDBKoZoQ2LKwOCqarR6r1vysZbvgxruOBj5RO3WX9jw7v3rourmNgt8MPuUh+ljeiuererprX5nVl45Gb9h3M5QraaMXyzWJODq0kbXVK71D7LFY5Ng803PovhE0kLa5dMXwZPidjJbWCN+nqR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739213936; c=relaxed/simple;
	bh=ACE/dkbUZ1XUCycn18S094uP4VYPF9omfbNKrW5W5N0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RToInniY7k4WU9TkngqkIElG7tlMVVivZtTLrWqmblfEAhdmGbUk7h/mkdbqPLQpdaProsPILLjYJWZL7vt2KOqJ1M02qSaWMengf+FuI+i9XmLid8DdpgTuwvmCfoKeqVToGIHDpZmFdTySNH+atBmIRTSfCo2KGjY4YHwew3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMk5rQFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C742C4CED1;
	Mon, 10 Feb 2025 18:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739213936;
	bh=ACE/dkbUZ1XUCycn18S094uP4VYPF9omfbNKrW5W5N0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MMk5rQFzVvRPs3sbliT7PBNCGcBVQnwtyQBSHghSYIzAaJpZfcGE35Zwz3rWTltru
	 eHx0DsbPKzz8Qbju/ZynGkjGR7fvRoOM6l8yNl/o3Y0qfK089iM9AqgPRgUWSPwY2h
	 GwTajbztsoEg/Ix+TLf3YHnBBFliQLFPZPkNmlFwp9UTJkv5fdDDkXRtV2TZRCdBpi
	 od2n/SVtMdJFQAisN+X3Z0fldvoO8TDgEWjxg1tuMqK+LIETCdBq4XJmI61U1Yz17b
	 DtjtlHMiVgoh4sy1JToEMuNypLAIu4cPlBkaE1WkKp5nafjrurrRe2xSbMUDYqfGyl
	 phWKx4xdxjPKQ==
Message-ID: <169e0d9e3b1e4ab5fd84e41817a1aeb76c08851e.camel@kernel.org>
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for
 FUSE/Flatpak related applications since v6.13
From: Jeff Layton <jlayton@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Joanne Koong <joannelkoong@gmail.com>,
  Matthew Wilcox <willy@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Christian Heusel <christian@heusel.eu>, Miklos Szeredi
 <mszeredi@redhat.com>, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm	
 <linux-mm@kvack.org>, Mantas =?UTF-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>
Date: Mon, 10 Feb 2025 13:58:54 -0500
In-Reply-To: <81298bd1-e630-4940-ae5b-7882576b6bf4@suse.cz>
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
	 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
	 <9cd88643-daa8-4379-be0a-bd31de277658@suse.cz>
	 <20250207172917.GA2072771@perftesting>
	 <8f7333f2-1ba9-4df4-bc54-44fd768b3d5b@suse.cz>
	 <CAJnrk1aNVMCfTjL0vo-Qki68-5t1W+6-bJHg+x67kHEo_-q0Eg@mail.gmail.com>
	 <Z6ct4bEdeZwmksxS@casper.infradead.org>
	 <CAJnrk1aY0ZFcS4JvmJL=icigencsCD8g4qmZiTuoPWj2S2Y_LQ@mail.gmail.com>
	 <81298bd1-e630-4940-ae5b-7882576b6bf4@suse.cz>
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

On Mon, 2025-02-10 at 09:27 +0100, Vlastimil Babka wrote:
> On 2/8/25 16:46, Joanne Koong wrote:
> > On Sat, Feb 8, 2025 at 2:11=E2=80=AFAM Matthew Wilcox <willy@infradead.=
org> wrote:
> > >=20
> > > On Fri, Feb 07, 2025 at 04:22:56PM -0800, Joanne Koong wrote:
> > > > > Thanks, Josef. I guess we can at least try to confirm we're on th=
e right track.
> > > > > Can anyone affected see if this (only compile tested) patch fixes=
 the issue?
> > > > > Created on top of 6.13.1.
> > > >=20
> > > > This fixes the crash for me on 6.14.0-rc1. I ran the repro using
> > > > Mantas's instructions for Obfuscate. I was able to trigger the cras=
h
> > > > on a clean build and then with this patch, I'm not seeing the crash
> > > > anymore.
> > >=20
> > > Since this patch fixes the bug, we're looking for one call to folio_p=
ut()
> > > too many.  Is it possibly in fuse_try_move_page()?  In particular, th=
is
> > > one:
> > >=20
> > >         /* Drop ref for ap->pages[] array */
> > >         folio_put(oldfolio);
> > >=20
> > > I don't know fuse very well.  Maybe this isn't it.
> >=20
> > Yeah, this looks it to me. We don't grab a folio reference for the
> > ap->pages[] array for readahead and it tracks with Mantas's
> > fuse_dev_splice_write() dmesg. this patch fixed the crash for me when
> > I tested it yesterday:
> >=20
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 7d92a5479998..172cab8e2caf 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -955,8 +955,10 @@ static void fuse_readpages_end(struct fuse_mount
> > *fm, struct fuse_args *args,
> >                 fuse_invalidate_atime(inode);
> >         }
> >=20
> > -       for (i =3D 0; i < ap->num_folios; i++)
> > +       for (i =3D 0; i < ap->num_folios; i++) {
> >                 folio_end_read(ap->folios[i], !err);
> > +               folio_put(ap->folios[i]);
> > +       }
> >         if (ia->ff)
> >                 fuse_file_put(ia->ff, false);
> >=20
> > @@ -1049,6 +1051,7 @@ static void fuse_readahead(struct readahead_contr=
ol *rac)
> >=20
> >                 while (ap->num_folios < cur_pages) {
> >                         folio =3D readahead_folio(rac);
> > +                       folio_get(folio);
>=20
> This is almost the same as my patch, but balances the folio_put() in
> readahead_folio() with another folio_get(), while mine uses
> __readahead_folio() that does not do folio_put() in the first place.
>=20
> But I think neither patch proves the extraneous folio_put() comes from
> fuse_try_move_page().
>=20
> >                         ap->folios[ap->num_folios] =3D folio;
> >                         ap->descs[ap->num_folios].length =3D folio_size=
(folio);
> >                         ap->num_folios++;
> >=20
> >=20
> > I reran it just now with a printk by that ref drop in
> > fuse_try_move_page() and I'm indeed seeing that path get hit.
>=20
> It might get hit, but is it hit in the readahead paths? One way to test
> would be to instead of yours above or mine change, to stop doing the
> foio_put() in fuse_try_move_page(). But maybe it's called also from other
> contexts that do expect it, and will leak memory otherwise.
>=20

I think you're right that there is a double put in
fuse_try_move_page(). Let's assume that we enter that function and the
refcount on "oldpage" is 1:

1/ We take a reference to "oldfolio" when we enter the function, now
refcount is 2.

2/ We drop a reference on "oldfolio" with the call to
replace_page_cache_folio. Now refcount is 1.

3/ Now there are 2 folio_put(oldfolio) calls on the way out of the
function, refcount goes to -1.

Maybe it's expected that this function consumes an extra folio
reference, but it's certainly not evident why that is if so. I don't
see why the callers would expect that either.

> > Not sure why fstests didn't pick this up though since splice is
> > enabled by default in passthrough_hp, i'll look into this next week.
> >=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

