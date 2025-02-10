Return-Path: <linux-fsdevel+bounces-41443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC056A2F848
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E8717A2261
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 19:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC96925744A;
	Mon, 10 Feb 2025 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ewHdKpQU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133BA24BD03
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214761; cv=none; b=uhYxGLVu2URCvIy7Fl/t1KR1pfHOwFZIWI4RZUU16ejfH+JDFt37HVqCx2xEKh0ONwy+EdiX6TgZ3ThxfGXXEOz+ntUo8GNHO0Cr05TTQPW/hXr5S9Cf8lODMuU8ObphciTCwoZV4nKGeKu7EVX9C+ZbXLjpUgnAntoy+H4rN9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214761; c=relaxed/simple;
	bh=H4ylnKaNKrMj+l3283XhcHafdeHLnyAmQwYf6NcglIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWoZteGX8j84+SocER1uU3PlZj7GppK/WUCXk+0wGMQrURa89wb6zfCmVnHN7maLL0fASy7mFOoofYjMUTbqpa+bg2iLsKL/U3fPAHfkY94lj0PV4m7XLtEO8os8WRsdcW3z2yhNXmiLf1Wv+Hi4Gevm0sX5kI4806RsBShcZA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ewHdKpQU; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6efe4e3d698so42941667b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 11:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1739214757; x=1739819557; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7X6uNuQlMRodZ9pzqm1wHqWFoOKmQViZcOnpPZv5eDA=;
        b=ewHdKpQUa+cpyjjOvs8UwD32HI8c+LT6wGq/yzcUTh3/mVNG5Rscq7z3eczfHifHIE
         SB4MK9FaRVBzWo3T/k5sFJJU/v4+841iHMsIKTn1jerTF5cJrlWE57AfAsIdgv/oI1tu
         r3GVOTERry7JW0iCP6Gd21kWHIA40vO6fIm/W8+Yk7lcCx4RG3nX6iNIL4fex5NcK6c9
         z6GGa1e1cv+AV+2XpPvahwneXqCr/9ru5J5s0mUac+zoiwxD67T6+TAD7QowrAru7PxU
         krbvB767LMqK/qXwZVTPoQnhJaYkZ5iT+gbgbeMBV3OYQf6cQi6Kxl8MKnsjK0Nma+r0
         KlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739214757; x=1739819557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7X6uNuQlMRodZ9pzqm1wHqWFoOKmQViZcOnpPZv5eDA=;
        b=GWvk3LGMxR0lm70/WGmATITtJzT2Wg4mlKoXD7MJEntsb4SxmRlkyO4B2HpCsZMQig
         CXWGcauB2/fCIHV03Jb3/ziqeJCqAhgTuQRcjqzNc/4VSvT4wTzvnuHjzz5jnZZoV1fK
         xuwNeJKGVlr7xIJOwQdmgTOpKHLOQhFphBHv7U9IcfJwH7+WGCK08N79kScdiGQ4wWQE
         Bm45SKrgLo0ti5jhGyuKkUUWpFnDGGjrgV9DFPqCEUAOqzZGGzV0aMXL5Wub4nBaPXTS
         BHsufcGLr88rYNy5kQfH7NVtYqBKXVeNtK3OzoIRm49BX0GLtYcglWQQzTpx+rIn8Xh+
         6F+A==
X-Forwarded-Encrypted: i=1; AJvYcCUhn6sbKVnxv1NmxtF/wSWdCiaagKMpFElQY4ot/PCjR4VkjJktmPv+ZbqrR7jSYxPFn2FzuKxxrZSM+fxZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyEwkTs5JwT0Jh4kNIiPQ/klPdmrquzwGU3B4Ia9kbRrlQ2Fnek
	F5k0jxQkLrCVZMZgk7PsSMTfOXahubC3bfTBNP9ro7uhr/1qGm77QpxM18uYEPY=
X-Gm-Gg: ASbGncsgthqk+EoKrp1gjMdWm69sVGd4EVvkYhkiAwHSeNtjkQHCeYTobhYxum9yiyB
	VjnMOX6LC1iK6dUkGTQHsPLSl5W1LAeI0dVSdT0diowpqW/l+HCbnFWk+3/mgCkqoaHJcvss9/K
	+yRay04t2ldX2AcZKlalgzCBjlW67hTFP9OdHTEQMJQ3o/iUAnQLB//+k+c314VpRWj/hQVSYeo
	Sb1eiFb1jCkxolmQyGr9q9VHbsK7Egc1ChYXF/ywgCDIyI17k8nyX9Imu+eJoAR66jCfeRkDszm
	9P3Wt/GTDSzJylvdLDhjasG9i/ZT0DSudPsTn+rHnkzgYroxA1ve
X-Google-Smtp-Source: AGHT+IEyRIKhmgO/4HoHaCjVUun69PAKcV1oSQIHgk5rqDLOXak/j3xysFVCh8NWH5SOGRmd1WM8qQ==
X-Received: by 2002:a05:690c:7301:b0:6f9:7b99:8a29 with SMTP id 00721157ae682-6f9b2a07011mr124242147b3.34.1739214756954;
        Mon, 10 Feb 2025 11:12:36 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f99ff6a8e3sm17839597b3.90.2025.02.10.11.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:12:36 -0800 (PST)
Date: Mon, 10 Feb 2025 14:12:35 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Christian Heusel <christian@heusel.eu>,
	Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>,
	Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for
 FUSE/Flatpak related applications since v6.13
Message-ID: <20250210191235.GA2256827@perftesting>
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
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aBc5uvL78s3kdpXojH-B11wtOPSDUJ0XnCzmHH+eO2Nw@mail.gmail.com>

On Mon, Feb 10, 2025 at 10:13:51AM -0800, Joanne Koong wrote:
> On Mon, Feb 10, 2025 at 12:27 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 2/8/25 16:46, Joanne Koong wrote:
> > > On Sat, Feb 8, 2025 at 2:11 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >>
> > >> On Fri, Feb 07, 2025 at 04:22:56PM -0800, Joanne Koong wrote:
> > >> > > Thanks, Josef. I guess we can at least try to confirm we're on the right track.
> > >> > > Can anyone affected see if this (only compile tested) patch fixes the issue?
> > >> > > Created on top of 6.13.1.
> > >> >
> > >> > This fixes the crash for me on 6.14.0-rc1. I ran the repro using
> > >> > Mantas's instructions for Obfuscate. I was able to trigger the crash
> > >> > on a clean build and then with this patch, I'm not seeing the crash
> > >> > anymore.
> > >>
> > >> Since this patch fixes the bug, we're looking for one call to folio_put()
> > >> too many.  Is it possibly in fuse_try_move_page()?  In particular, this
> > >> one:
> > >>
> > >>         /* Drop ref for ap->pages[] array */
> > >>         folio_put(oldfolio);
> > >>
> > >> I don't know fuse very well.  Maybe this isn't it.
> > >
> > > Yeah, this looks it to me. We don't grab a folio reference for the
> > > ap->pages[] array for readahead and it tracks with Mantas's
> > > fuse_dev_splice_write() dmesg. this patch fixed the crash for me when
> > > I tested it yesterday:
> > >
> > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > index 7d92a5479998..172cab8e2caf 100644
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > > @@ -955,8 +955,10 @@ static void fuse_readpages_end(struct fuse_mount
> > > *fm, struct fuse_args *args,
> > >                 fuse_invalidate_atime(inode);
> > >         }
> > >
> > > -       for (i = 0; i < ap->num_folios; i++)
> > > +       for (i = 0; i < ap->num_folios; i++) {
> > >                 folio_end_read(ap->folios[i], !err);
> > > +               folio_put(ap->folios[i]);
> > > +       }
> > >         if (ia->ff)
> > >                 fuse_file_put(ia->ff, false);
> > >
> > > @@ -1049,6 +1051,7 @@ static void fuse_readahead(struct readahead_control *rac)
> > >
> > >                 while (ap->num_folios < cur_pages) {
> > >                         folio = readahead_folio(rac);
> > > +                       folio_get(folio);
> >
> > This is almost the same as my patch, but balances the folio_put() in
> > readahead_folio() with another folio_get(), while mine uses
> > __readahead_folio() that does not do folio_put() in the first place.
> >
> > But I think neither patch proves the extraneous folio_put() comes from
> > fuse_try_move_page().
> >
> > >                         ap->folios[ap->num_folios] = folio;
> > >                         ap->descs[ap->num_folios].length = folio_size(folio);
> > >                         ap->num_folios++;
> > >
> > >
> > > I reran it just now with a printk by that ref drop in
> > > fuse_try_move_page() and I'm indeed seeing that path get hit.
> >
> > It might get hit, but is it hit in the readahead paths? One way to test
> > would be to instead of yours above or mine change, to stop doing the
> > foio_put() in fuse_try_move_page(). But maybe it's called also from other
> > contexts that do expect it, and will leak memory otherwise.
> 
> When I tested it a few days ago, I printk-ed the address of the folio
> and it matched in fuse_readahead() and try_move_page(). I think that
> proves that the extra folio_put() came from fuse_try_move_page()
> through the readahead path.

This patch should fix the problem, let me know if it's stil happening

From 964c798ee9e8f2e8e2c37cfd060c76a772cc45b7 Mon Sep 17 00:00:00 2001
Message-ID: <964c798ee9e8f2e8e2c37cfd060c76a772cc45b7.1739214698.git.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 10 Feb 2025 14:06:40 -0500
Subject: [PATCH] fuse: drop extra put of folio when using pipe splice

In 3eab9d7bc2f4 ("fuse: convert readahead to use folios"), I converted
us to using the new folio readahead code, which drops the reference on
the folio once it is locked, using an inferred reference on the folio.
Previously we held a reference on the folio for the entire duration of
the readpages call.

This is fine, however I failed to catch the case for splice pipe
responses where we will remove the old folio and splice in the new
folio.  Here we assumed that there is a reference held on the folio for
ap->folios, which is no longer the case.

To fix this, simply drop the extra put to keep us consistent with the
non-splice variation.  This will fix the UAF bug that was reported.

Link: https://lore.kernel.org/linux-fsdevel/2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu/
Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/dev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5b5f789b37eb..5bd6e2e184c0 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -918,8 +918,6 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	}
 
 	folio_unlock(oldfolio);
-	/* Drop ref for ap->pages[] array */
-	folio_put(oldfolio);
 	cs->len = 0;
 
 	err = 0;
-- 
2.43.0


