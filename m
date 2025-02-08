Return-Path: <linux-fsdevel+bounces-41276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ED0A2D1EF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 01:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458CD188E0A2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 00:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5C0C8FE;
	Sat,  8 Feb 2025 00:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5VexVQR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8993C2C9D;
	Sat,  8 Feb 2025 00:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974190; cv=none; b=kHNsBu1jj8iG38/pM3B6fx4VT01Ss5KvY5DuYMK+wwvjbfsJja4Mt3MIgr9pZNCbLouhCYIRhA3lXIgP7hR3e4WD7oKMH/MniGmhoUAtSYxKx5JVY9hXIl+KNpFmXMQ3ETrOP1E6FMzOkySVP6mVzAm0aGX1PywJkD9BR3rgqlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974190; c=relaxed/simple;
	bh=ry6MqBL4uPyr0sqR/k4Epg3DTn1nUp6TOZStvyfvzek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CU8b1FBrEMWh+uk3sOP1Auvj/R1oUg578MNZ8vxcBVeWMhFQa2m78V2ZROKmZZaQDOrH4tMTaH8uIXrJze2Gx4A9hNHGFaF2v3bJEUGGm4DbZsB/lTOToSNg44x/OSw+l39AbAb0sIvB3Z4aPnmR+cHuI2KtGmXfC+xYxJBmNO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5VexVQR; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467b086e0easo14214781cf.1;
        Fri, 07 Feb 2025 16:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738974187; x=1739578987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMMA64lDvybDlSuA0rt3djW23m9gTKqcOUi9JQbLAKk=;
        b=b5VexVQRBbnv+yhB87W/EBNdpkhTGBOO0OWYTlE51jwfi3alUboUibap6+Tv0pn4DG
         qPqFQeFBF8yDQgut5g21nY8fEtdxy4yA4dRx/VqWLZebZrHtG/vySI90f6KB1TZuEg9r
         hW0T7ndYIGB0lQHHIoccdAL2tFnf1F6qw2exoRQzHP8eNkkZQyT20/inRW/jbIUYTt3u
         GLRDiSwvSmS50JpGbrMZKFZaIdpI32MaWpVA9dMrel2qF231znWeEBVKDALgN/JbvXbg
         8yXXjYDXHqpRgkwiH8qvVfea2HFRrob2ofU0GG1MRcDYZDU80OgKNxn+tfPTv8mYMNYT
         3Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738974187; x=1739578987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMMA64lDvybDlSuA0rt3djW23m9gTKqcOUi9JQbLAKk=;
        b=t3CUgByzTe6Kg0y85/fQatUQSwEXFhY87PyeBB+jzjoP2ZO8EOCB4SNdyz03piL2Fh
         Z50Gk2xbZjXuZ03/WXxfYn8ORBSMGDQQvwWGoNT/kp+rCsl0Uq+MB/TE03JiHdwQ1tCu
         Gex8b6gbvYkGXHByOyjLf0Kz/sBZxFnxGNXVr6UE52vw3a82HUtEbQ21TvvPA4XWmnQd
         PWmCjPVk01vydsg+ucyhviyYNV+k6sl0LzH3/AFkXfML8P2KxDpmNXZgf6FdLFRBVJO2
         npcX81a8FgOSlwz1p9fJ5l8pHjbjXiGVJ+IyoROCzBFbeAfhMjX8u2rjMSQD35wkDxQY
         J+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0Rn1HjfIjJuAUO5tbrUOh0i8WIqj5lbT5tCbDR1oHJ35Md2MaCixUOtuuudlEanHCQ/mn9I4M93OZ/KeR@vger.kernel.org, AJvYcCUnJ4SqJ+vulrZsiZap6E+Zh4P3ULfHarZ0puzyT3a911TMtI3GrkXS+oqQXV4ZxeeiURcLxY0BctqBTiJd@vger.kernel.org
X-Gm-Message-State: AOJu0YwPI69yGhTrnNDAVPK6MXGxXDbl22DSS0vTX3YcwNrPLhBRlMsE
	3eQLZsH8BY3K5yW/EjLzhnT1RRXrtgJgrYgq2pSr5e9k/7ovXPybKyqjLzQ2WkAuejIp0jkuMq/
	sWqQrEZw8AuEwUsMdC1WAgGU7lkw=
X-Gm-Gg: ASbGncv10+0bTshMmppl4fYrvrI0AKjlJLeiqp96bLyagfWhX14m+FfitcE1F9ns9+n
	nLdyHAvvzXFIFeIEQKIlvDiRYR0QJ91Qsfx/2KEfHPo8kIUV0AENHOZ1BthbX3ntb9a9eEH7xyg
	==
X-Google-Smtp-Source: AGHT+IFynXnfoPvMksQZzaLkrmUUnGS4bSe4CamOZn8jJ/vYzyH5WcI7y0Y0eR9P7OnCEJANNBRyyGlLcn/pqDWXcug=
X-Received: by 2002:a05:622a:1802:b0:468:fb3c:5e75 with SMTP id
 d75a77b69052e-47167b31c04mr90216311cf.38.1738974187204; Fri, 07 Feb 2025
 16:23:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <9cd88643-daa8-4379-be0a-bd31de277658@suse.cz> <20250207172917.GA2072771@perftesting>
 <8f7333f2-1ba9-4df4-bc54-44fd768b3d5b@suse.cz>
In-Reply-To: <8f7333f2-1ba9-4df4-bc54-44fd768b3d5b@suse.cz>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 7 Feb 2025 16:22:56 -0800
X-Gm-Features: AWEUYZnFp_ULZNnOUQ3w9lhp7jHrWUkkYz1PD0CpILo4xK1xPJS4vjBA4OF3cJg
Message-ID: <CAJnrk1aNVMCfTjL0vo-Qki68-5t1W+6-bJHg+x67kHEo_-q0Eg@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Heusel <christian@heusel.eu>, Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	=?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 10:39=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/7/25 18:29, Josef Bacik wrote:
> > On Fri, Feb 07, 2025 at 05:49:34PM +0100, Vlastimil Babka wrote:
> >> On 2/7/25 10:34, Miklos Szeredi wrote:
> >> > [Adding Joanne, Willy and linux-mm].
> >> >
> >> >
> >> > On Thu, 6 Feb 2025 at 11:54, Christian Heusel <christian@heusel.eu> =
wrote:
> >> >>
> >> >> Hello everyone,
> >> >>
> >> >> we have recently received [a report][0] on the Arch Linux Gitlab ab=
out
> >> >> multiple users having system crashes when using Flatpak programs an=
d
> >> >> related FUSE errors in their dmesg logs.
> >> >>
> >> >> We have subsequently bisected the issue within the mainline kernel =
tree
> >> >> to the following commit:
> >> >>
> >> >>     3eab9d7bc2f4 ("fuse: convert readahead to use folios")
> >>
> >> I see that commit removes folio_put() from fuse_readpages_end(). Also =
it now
> >> uses readahead_folio() in fuse_readahead() which does folio_put(). So =
that's
> >> suspicious to me. It might be storing pointers to pages to ap->pages w=
ithout
> >> pinning them with a refcount.
> >>
> >> But I don't understand the code enough to know what's the proper fix. =
A
> >> probably stupid fix would be to use __readahead_folio() instead and ke=
ep the
> >> folio_put() in fuse_readpages_end().
> >
> > Agreed, I'm also confused as to what the right thing is here.  It appea=
rs the
> > rules are "if the folio is locked, nobody messes with it", so it's not =
"correct"
> > to hold a reference on the folio while it's being read.  I don't love t=
his way
> > of dealing with folios, but that seems to be the way it's always worked=
.
> >
> > I went and looked at a few of the other file systems and we have NFS wh=
ich holds
> > it's own reference to the folio while the IO is outstanding, which FUSE=
 is most
> > similar to NFS so this would make sense to do.
> >
> > Btrfs however doesn't do this, BUT we do set_folio_private (or whatever=
 it's
> > called) so that keeps us from being reclaimed since we'll try to lock t=
he folio
> > before we do the reclaim.
> >
> > So perhaps that's the issue here?  We need to have a private on the fol=
io + the
> > folio locked to make sure it doesn't get reclaimed while it's out being=
 read?
> >
> > I'm knee deep in other things, if we want a quick fix then I think your
> > suggestion is correct Vlastimil.  But I definitely want to know what Wi=
lly
> > expects to be the proper order of operations here, and if this is exact=
ly what
> > we're supposed to be doing then something else is going wrong and we sh=
ould try
> > to reproduce locally and figure out what's happening.  Thanks,
>
> Thanks, Josef. I guess we can at least try to confirm we're on the right =
track.
> Can anyone affected see if this (only compile tested) patch fixes the iss=
ue?
> Created on top of 6.13.1.

This fixes the crash for me on 6.14.0-rc1. I ran the repro using
Mantas's instructions for Obfuscate. I was able to trigger the crash
on a clean build and then with this patch, I'm not seeing the crash
anymore.

>
> ----8<----
> From c0fdf9174f6c17c93a709606384efe2877a3a596 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Fri, 7 Feb 2025 19:35:25 +0100
> Subject: [PATCH] fuse: prevent folio use-after-free in readahead
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  fs/fuse/file.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 7d92a5479998..a40d65ffb94d 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -955,8 +955,10 @@ static void fuse_readpages_end(struct fuse_mount *fm=
, struct fuse_args *args,
>                 fuse_invalidate_atime(inode);
>         }
>
> -       for (i =3D 0; i < ap->num_folios; i++)
> +       for (i =3D 0; i < ap->num_folios; i++) {
>                 folio_end_read(ap->folios[i], !err);
> +               folio_put(ap->folios[i]);
> +       }
>         if (ia->ff)
>                 fuse_file_put(ia->ff, false);
>
> @@ -1048,7 +1050,7 @@ static void fuse_readahead(struct readahead_control=
 *rac)
>                 ap =3D &ia->ap;
>
>                 while (ap->num_folios < cur_pages) {
> -                       folio =3D readahead_folio(rac);
> +                       folio =3D __readahead_folio(rac);
>                         ap->folios[ap->num_folios] =3D folio;
>                         ap->descs[ap->num_folios].length =3D folio_size(f=
olio);
>                         ap->num_folios++;
> --
> 2.48.1
>
>

