Return-Path: <linux-fsdevel+bounces-39167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C9FA10F8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 19:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30CC188A580
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 18:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B0A1FE44E;
	Tue, 14 Jan 2025 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBJoDbcU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F201FECA5
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736878091; cv=none; b=sIKkdaFx+DXpS9DuYUhzyOnOJl0CkoECHTJ9nXxHScDLfeG4Jlt03wQoHBWWsohvT7Vc3O23p/nZZpDgB1GbluF5CeTGUi7RNkeBiu+wuUeBAS7ffWUi33SQKT30EW9p87zo7rxars+f5LPh2GS6xBJn6FVJhNJW6eAwE/NKStI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736878091; c=relaxed/simple;
	bh=a6HCtVNy5jLP2sehbS081/piEDamGHBx5akiGcKNKcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmEDHlKqmurl5W1fRknSwNPzopd1L6BK3M3AMumioNgrgZs5rxHkUA56R39YxNu/iTNfC/wjDme81K1v+60ujjkdy5DSW54u9vknMxvHXOZb4Z4eqRytGBv7e5WhjxKrrISo8xPOMRxGCo7Z6xVCudFaCejsyjrIy1NNr23CFO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBJoDbcU; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467a1ee7ff2so54445461cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 10:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736878088; x=1737482888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkcjj9ye7VhpQO7nkoxfXRniEXnmcjfLXAVoNZjBYe8=;
        b=KBJoDbcUayfbHZ5RmufnnVno7Tdnz2tg2Q5w6NNRc2FxYAkUbovipNhf4nrfK53452
         W+Gio9/x9ZsPcMaK/tf9DHudjYh6T1bR5M7BiDP+p215UovHZOf8kbOhCRyoXphAgb7n
         wj01S0X73oUI17cJjkDVupciYeq0t+kWI2WuDBujV6JN+etTXB+AoQaQteb7WDg4Txrp
         iVJ9ezjOjoKfIBtOIXFQhsa6DkFmL90bxF4xdJ9GtBWx7Cjw5H+tAsfsUoXgi7Bc26z3
         DPxtR4o9e2sblmmn2r5936sLmbolBMC+C25Ut4X7phud29hHQq8YyT5APSgTpWQJQ1PL
         tkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736878088; x=1737482888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkcjj9ye7VhpQO7nkoxfXRniEXnmcjfLXAVoNZjBYe8=;
        b=vwV96aTLCvL8B4yyAcWmG9i+qdEeD47jd2b6ASvVzKAIT5+20mPv8E+r/m8VOlQ75a
         KO067z5JrpjeCMSADDeULGPrc1dBJS5TwOkKyCb1NRbeE08AHknGODSqgHVRcydHHNka
         avLLmi56VTWde+/8gNrFGhzrR0Syxh6TFYDP33mzIkevZcbEhcHrtzgtqDY6FSVBY6Iq
         SwDtSO1Rk/MIiE3YFivqF4KaJmt526DdesiwpK5h0ZnS6EkLK8QcHdaRwHuooNll60c5
         Y9+X7gFSbeug9f6Nw2JRy1C0kDR30cG+I1hSEmIoYcawhnRRHOWQE18f8ZHxF5F6FqCu
         UEbg==
X-Forwarded-Encrypted: i=1; AJvYcCXhhJQ0cdboGr1oKAEheu0HdnX6abIqBblGf1xonDA7+RBDrkUFgPq+cN1dDM1NHq85NcWwppU3F1/e9Mf0@vger.kernel.org
X-Gm-Message-State: AOJu0YwZZlHSNjqNT+CmaEsAi7sWFpOa4A4MQYkkFEWxUs8Gzl78R4/K
	fBUVjfj/dWH+QIN4tlE7NvKiNiZXszfGTsf0FncPXVv3A4Zu8oeoGTLKe3MfW99u/A0Lh0DtQpa
	TimMUEQlpcQ1pzNB2tH+FM3BYHjo=
X-Gm-Gg: ASbGncuBQs57jduOHYpSZdrdoYxoY1WHEk/8vfBgnJfo5bCO6YtDDMtRuEXGgR1UODh
	PAh5P80ZfJUww86ZY+LbmidvbJSzqUFBSaV/pyxU=
X-Google-Smtp-Source: AGHT+IGPoYSnpqAltXzWcI643ahJNRlAh0V6u+sevmlmu2TNjNVPx9f9Nj08EYKqy0BUz9m7k0m0iJBN/gSmD86TqQs=
X-Received: by 2002:a05:622a:34c:b0:467:5dcf:79c2 with SMTP id
 d75a77b69052e-46c71086e9emr445423801cf.43.1736878088270; Tue, 14 Jan 2025
 10:08:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com> <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com> <plvffraql4fq4i6xehw6aklzmdyw3wvhlhkveneajzq7sqzs6h@t7beg2xup2b4>
 <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com> <54ebdef4205781d3351e4a38e5551046482dbba0.camel@kernel.org>
 <ccefea7b-88a5-4472-94cd-1e320bf90b44@redhat.com> <e3kipe2qcuuvyefnwpo4z5h4q5mwf2mmf6jy6g2whnceze3nsf@uid2mlj5qfog>
 <2848b566-3cae-4e89-916c-241508054402@redhat.com> <dfd5427e2b4434355dd75d5fbe2460a656aba94e.camel@kernel.org>
 <CAJfpegs_YMuyBGpSnNKo7bz8_s7cOwn2we+UwhUYBfjAqO4w+g@mail.gmail.com>
 <CAJfpeguSXf0tokOMjoOP-gnxoNHO33wTyiMXH5pQP8eqzj_R0g@mail.gmail.com>
 <060f4540-6790-4fe2-a4a5-f65693058ebf@fastmail.fm> <CAJfpegsrGX4oBHmRn_+8iwiMkJD_rcVEyPVH5tBAAByw4gSCQA@mail.gmail.com>
In-Reply-To: <CAJfpegsrGX4oBHmRn_+8iwiMkJD_rcVEyPVH5tBAAByw4gSCQA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 14 Jan 2025 10:07:57 -0800
X-Gm-Features: AbW1kvbKVbcACAuk6TgiE03IW8wO6yzdOx9PKHtUithqoc8AjDyLtE19OPOBAKI
Message-ID: <CAJnrk1ZP4yZZDR0fZghBmuN-N=JfrbJZALBH0pdaC5_gGWFwEw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Jeff Layton <jlayton@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 2:07=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 14 Jan 2025 at 10:55, Bernd Schubert <bernd.schubert@fastmail.fm>=
 wrote:
> >
> >
> >
> > On 1/14/25 10:40, Miklos Szeredi wrote:
> > > On Tue, 14 Jan 2025 at 09:38, Miklos Szeredi <miklos@szeredi.hu> wrot=
e:
> > >
> > >> Maybe an explicit callback from the migration code to the filesystem
> > >> would work. I.e. move the complexity of dealing with migration for
> > >> problematic filesystems (netfs/fuse) to the filesystem itself.  I'm
> > >> not sure how this would actually look, as I'm unfamiliar with the
> > >> details of page migration, but I guess it shouldn't be too difficult
> > >> to implement for fuse at least.
> > >
> > > Thinking a bit...
> > >
> > > 1) reading pages
> > >
> > > Pages are allocated (PG_locked set, PG_uptodate cleared) and passed t=
o
> > > ->readpages(), which may make the pages uptodate asynchronously.  If =
a
> > > page is unlocked but not set uptodate, then caller is supposed to
> > > retry the reading, at least that's how I interpret
> > > filemap_get_pages().   This means that it's fine to migrate the page
> > > before it's actually filled with data, since the caller will retry.
> > >
> > > It also means that it would be sufficient to allocate the page itself
> > > just before filling it in, if there was a mechanism to keep track of
> > > these "not yet filled" pages.  But that probably off topic.
> >
> > With /dev/fuse buffer copies should be easy - just allocate the page
> > on buffer copy, control is in libfuse.
>
> I think the issue is with generic page cache code, which currently
> relies on the PG_locked flag on the allocated but not yet filled page.
>   If the generic code would be able to keep track of "under
> construction" ranges without relying on an allocated page, then the
> filesystem could allocate the page just before copying the data,
> insert the page into the cache mark the relevant portion of the file
> uptodate.
>
> > With splice you really need
> > a page state.
>
> It's not possible to splice a not-uptodate page.
>
> > I wrote this before already - what is the advantage of a tmp page copy
> > over /dev/fuse buffer copy? I.e. I wonder if we need splice at all here=
.
>
> Splice seems a dead end, but we probably need to continue supporting
> it for a while for backward compatibility.
>

There was a previous discussion about splice and tmp pages here [1], I
see the following issues with having splice default to using tmp pages
as a workaround:

- my understanding is that the majority of use cases do use splice (eg
iirc, libfuse does as well), in which case there's no point to this
patchset then
- codewise, imo this gets messy (eg we would still need the rb tree
and would now need to check writeback against folio writeback state
and against the rb tree)
- for the large folios work in [2], the implementation imo is pretty
clean because it's rebased on top of this patchset that removes the
tmp pages and rb tree. If we still have tmp pages, then this gets very
gnarly. There's not a good way I see to handle large folios in the rb
tree given this scenario:
a) writeback on a large folio is issued
b) we copy it to a tmp folio and clear writeback on it since it's
being spliced, we add this writeback request to the rb tree
c) the folio in the pagecache is evicted
d) another write occurs on a larger range that encompasses the range
in the writeback in a) or on a subset of it
Maybe this is doable with some other data structure instead of the rb
tree (eg an xarray with refcounts maybe?), but it'd be ideal if we
could find a solution (my guess is this would have to come from the
the mm layer?) that obviates tmp pages altogether.


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1YwNw7C=3DEMfKQzN88Zq_2Qih5=
Te_bfkeaOf=3DtG+L3u9eA@mail.gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20241213221818.322371-1-joannelko=
ong@gmail.com/

> Thanks,
> Miklos

