Return-Path: <linux-fsdevel+bounces-39128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C54A103A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 11:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AB318898D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 10:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241E41CBE95;
	Tue, 14 Jan 2025 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Vs9c+g19"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C61ADC94
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849250; cv=none; b=hacmF7PUDm1UCoUIe5x7rgErEx0boHqob8O2XlHau1Wy4DYe6Z5Cnwks8PQl3vR/2ZPi1pSjbqLVHlHEwvnKiVDRVNpNhgb6V3S3aqcWX9QjzFS9WtvBekSk4B4TfWHMp9lUqhHt0o+tAMSS/CXhrN5MQL2jdt9kDkWd/1FGIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849250; c=relaxed/simple;
	bh=gNQjL+ThElg03uwgW4KfhxZyUTult/3H70ZhHObdAAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WX7KQv8xykm0ue4MpHdIs3O+O2oSJNUlY6XNV+/GhSm/keh7WkuPgokEBk2hbaVBssJl2cLw7w9o3MJ0za1PgGOspF+SmkX28hY3nOfLWB0Yg/aqiK25EE9kT37nFVcE4SCD3I1O564RRC0w+lSmb1kf2JIJgmjxA7xNpbI0re8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Vs9c+g19; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-467bc28277eso45054511cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 02:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736849247; x=1737454047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0tU4xnHoOQ4ptkjuyhR+xNOthzAVEDHZG5olEh1NuX4=;
        b=Vs9c+g19nncASNqOsWZ2cl1hjTDc5ZszJcIdJayet81Z3V2xLmAc39Beqp/s38fQOv
         MnHQ+ypEa5HVOaN62oDvA6acU/tdnd+9MJ3s9soqOjP18xAhQ0/EdGG3o3ehmenwnMIP
         zdSf3jW8n246GvjLAKy8b5B2c/9q/eqQFI6lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736849247; x=1737454047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tU4xnHoOQ4ptkjuyhR+xNOthzAVEDHZG5olEh1NuX4=;
        b=sWe4nwrV3dQgv7VlJJltF+zRjKpTsg7X6gOMsbgFj7iVkYRkzTEKQHgGyibOVb091e
         jb/ooP7aXD+ddtZ4rm7TNschLn8ubDjTyHx+uYckMKhiroLKTUrdy1uppL26U3leGLB4
         NRT0InN+fz4o7wBcmjZUpN9uTAEHxT1x+NpL03QtHfubaiURseo37fAmiC4dVe0wbFg7
         kx0pNSz3qL5CrJN4cVnUNYTicddNb2Y5rgyQJxJ3xPSt73w4VQQpOBmDmO3o280lJCN0
         7M+m4KHRVfDuNXnIAlusF9xeydUapVSlWoaboxPnLvzuAqXkDsxvKHl5ag1R3XxNdCj6
         DOiw==
X-Forwarded-Encrypted: i=1; AJvYcCWIeOgQIWu0mzy1dkt2QP5lgv/iacyHpWZ587KNCZ6xINSlhhySrcDvw/BrruGieT6x6xXc7PXJOrGKBEsf@vger.kernel.org
X-Gm-Message-State: AOJu0YwSvA+lc9yHAYVcgZmsNMpsBpghiQy0OtsGbk0E8egdfG9+SE/d
	1ODxZls9caHhX/KtwcfYTqIfNHPeiAeWphuOn4K5WOYqw9zsbgk8mxovrSq/ghNLgqKIKphmTs7
	CGPhnneVWSSMfM8GAZZg2vaLxxG09IcemzxDpxw==
X-Gm-Gg: ASbGncsYM88noeQoVirs8Ij4KtgtGYyDINwJHbXKNDdScVkAG2LTRvVUpCqapBPaKjh
	KmM0Ht+txJbhb3LHKX1WazIsDINf4MYsq0heB
X-Google-Smtp-Source: AGHT+IHM86AcpqAe+taIwtf4Bv/WyP95VBljCDSvtwFKlz4VZuwT4EO7BxYiZqXJP006KUCweFrn4ezF43sKGkn029I=
X-Received: by 2002:ac8:5f91:0:b0:467:451b:eb99 with SMTP id
 d75a77b69052e-46c7101e8d9mr319619141cf.29.1736849247564; Tue, 14 Jan 2025
 02:07:27 -0800 (PST)
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
 <CAJfpeguSXf0tokOMjoOP-gnxoNHO33wTyiMXH5pQP8eqzj_R0g@mail.gmail.com> <060f4540-6790-4fe2-a4a5-f65693058ebf@fastmail.fm>
In-Reply-To: <060f4540-6790-4fe2-a4a5-f65693058ebf@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Jan 2025 11:07:16 +0100
X-Gm-Features: AbW1kvYDCYoxl7hbvd-9qDmaQUUlOh63oYsNN5iCyn7r6KKsxo4LXqtOm8tWtGY
Message-ID: <CAJfpegsrGX4oBHmRn_+8iwiMkJD_rcVEyPVH5tBAAByw4gSCQA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Jeff Layton <jlayton@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Joanne Koong <joannelkoong@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jan 2025 at 10:55, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 1/14/25 10:40, Miklos Szeredi wrote:
> > On Tue, 14 Jan 2025 at 09:38, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> >> Maybe an explicit callback from the migration code to the filesystem
> >> would work. I.e. move the complexity of dealing with migration for
> >> problematic filesystems (netfs/fuse) to the filesystem itself.  I'm
> >> not sure how this would actually look, as I'm unfamiliar with the
> >> details of page migration, but I guess it shouldn't be too difficult
> >> to implement for fuse at least.
> >
> > Thinking a bit...
> >
> > 1) reading pages
> >
> > Pages are allocated (PG_locked set, PG_uptodate cleared) and passed to
> > ->readpages(), which may make the pages uptodate asynchronously.  If a
> > page is unlocked but not set uptodate, then caller is supposed to
> > retry the reading, at least that's how I interpret
> > filemap_get_pages().   This means that it's fine to migrate the page
> > before it's actually filled with data, since the caller will retry.
> >
> > It also means that it would be sufficient to allocate the page itself
> > just before filling it in, if there was a mechanism to keep track of
> > these "not yet filled" pages.  But that probably off topic.
>
> With /dev/fuse buffer copies should be easy - just allocate the page
> on buffer copy, control is in libfuse.

I think the issue is with generic page cache code, which currently
relies on the PG_locked flag on the allocated but not yet filled page.
  If the generic code would be able to keep track of "under
construction" ranges without relying on an allocated page, then the
filesystem could allocate the page just before copying the data,
insert the page into the cache mark the relevant portion of the file
uptodate.

> With splice you really need
> a page state.

It's not possible to splice a not-uptodate page.

> I wrote this before already - what is the advantage of a tmp page copy
> over /dev/fuse buffer copy? I.e. I wonder if we need splice at all here.

Splice seems a dead end, but we probably need to continue supporting
it for a while for backward compatibility.

Thanks,
Miklos

