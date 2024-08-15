Return-Path: <linux-fsdevel+bounces-26019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9E6952857
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 05:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8786BB23ED9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 03:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AB22C1A2;
	Thu, 15 Aug 2024 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8Zp33Ge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C6AF9CF
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 03:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723693124; cv=none; b=pVlfUeIfssmc2au7Hr1GynH3xjeo0/p/Mgc47O7PaWIh9+Ve0/LX1c3HcB3cUiLFrjAz94Pu/ANE9AKJebs3mcttj6XSn9BtMyYXDx9dpfzczGe5oe7atLm03oiBwSwnSlYy+N6OWW4kfW2Vel1GoLdOvz8PaqS9eLhRlY6k32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723693124; c=relaxed/simple;
	bh=2X7av+ZHaUcWuKWc03+jI3y1PNcP1itrbKA/47Unj6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxUExD6HXmGp7SOoFnNTaR8VqRVIeAvjmXc3WmxjMG2xth4Ki5PYcrssepGMi2lmEFjidwtH9/rJwCHaWl/+xDeBYD+z59uk1f3gsCTVAJ2WVfJlxRjxK+U9KpH56HdUl4t0WggMKFv/6ik6gXzUPQjPZTXh23DvSRIK6LAJWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8Zp33Ge; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7093705c708so503618a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 20:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723693121; x=1724297921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvhBfVaq4ky98Qq1ttq96d2l8SLRGhLbpdRRgm3Iero=;
        b=c8Zp33Ged7FbELqA2jCfkjJgxAWnwPog5ScZydwi27yeNmo+ekXhYTjY+hqM7AhqBJ
         KoZQCCMVhcJxQpA/pqUqb7FePQL7wikRLHKM4b6vBlsaeTXZLCio6XXx+mpYp/O5kWmT
         Fp0EY6+lLCK8Viwp5nZp08YIuZmrbkn6b9cxvYmDxphVpyxzeQZU46+u0uOwXA5X6prX
         947oWvnChiHkI8MPGKHAbz4Rcsz1rApF7szULEXDasVI4gIKuatf0mc8Yr2SXAWDVmUt
         96GZRIaYDfeKSX45g5UpiS0Y1hmy5k5vkjuNl0Hb/8o+4P0PL5zCjNd/IZ9iPNSl0P9e
         1Lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723693121; x=1724297921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvhBfVaq4ky98Qq1ttq96d2l8SLRGhLbpdRRgm3Iero=;
        b=L7bJyOtnj8gHMZKzi0KrYO7fVDi/1MZ7CqSg8V4wvtTg/jhS/SOcJ7+WZQP/aJluAF
         8llb64Q6d7NIEpYiELKR5JVZqbfp++r+ArEDrITBwOmAs6zVwOAsPRsBgDT1lGnGdc0n
         IBL+4z2y34yAyyqzdvo+nJdEIJ7lrO9xW/8g39PMCKDweqYC/hx8xvCse3JK5cKPiMD+
         DL9BoFl1mzIaiYD/K/aKx1GdD2SapsQy+h9FnoekNpJU//Gn6owJSF6f2Fr9T8UdSic3
         juAfuB/zZ9TfcAmadChBt7DiBBPkVKcToEQkEpCtV23InLIgPwQ6VmFcoxG0RLEbyP7q
         9MaA==
X-Forwarded-Encrypted: i=1; AJvYcCXqkMQgg0vcSHa3m42WVZjz7rBJnjTjK/egRLSjNqIdn0fva1s9zCpxlveqLd7GPTnMQK15OZctN+tAugq7DdoBN0xHl3f0AhK09FZQpw==
X-Gm-Message-State: AOJu0Yx8BSqbEgVHKsSbfInBIf4SGYv8mVT7kjdeF3+vydfqVjNjjGQQ
	2q/BAG1+ERWMwHpmuNFKizZTYYI8VDMXSuSeCOfYODsRnoUAIBP4HpEp+FMwTaoP46zQkdrsaQT
	ZxX7SAJpT4m19ne6kXwKo44+lHRU=
X-Google-Smtp-Source: AGHT+IFQ/ksUuT6O+ki8j4YfRoQVMxXkh8qy8kKXnxpHh8g0RltcFjxltw1nLmx2WpZc5zQ89OnT80jxGhK6BUo/noI=
X-Received: by 2002:a05:6358:5302:b0:1af:3e08:3992 with SMTP id
 e5c5f4694b2df-1b1aab5ae80mr587562355d.10.1723693121239; Wed, 14 Aug 2024
 20:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812090525.80299-1-laoar.shao@gmail.com> <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrv6Fts73FECScyd@dread.disaster.area> <CALOAHbAfQPdpXt0SHGxQdJEi1R_u+1x2KSwZ5XfrQD-sQmhKiA@mail.gmail.com>
 <ZrxDrSjOJRmjTGvM@dread.disaster.area> <CALOAHbCTv5w4Lg3SeA43yCAww8DobJ_CN+9BcQDMJzaHVPNZZQ@mail.gmail.com>
 <Zr1t2d/3tqNBc7qM@dread.disaster.area>
In-Reply-To: <Zr1t2d/3tqNBc7qM@dread.disaster.area>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 15 Aug 2024 11:38:05 +0800
Message-ID: <CALOAHbB4unfH8VY9qMHr0vw-956RxHn=9CZDC8=dWgH5oKA6kA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
To: Dave Chinner <david@fromorbit.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 10:54=E2=80=AFAM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> On Wed, Aug 14, 2024 at 03:32:26PM +0800, Yafang Shao wrote:
> > On Wed, Aug 14, 2024 at 1:42=E2=80=AFPM Dave Chinner <david@fromorbit.c=
om> wrote:
> > >
> > > On Wed, Aug 14, 2024 at 10:19:36AM +0800, Yafang Shao wrote:
> > > > On Wed, Aug 14, 2024 at 8:28=E2=80=AFAM Dave Chinner <david@fromorb=
it.com> wrote:
> > > > >
> > > > > On Mon, Aug 12, 2024 at 05:05:24PM +0800, Yafang Shao wrote:
> > > > > > The PF_MEMALLOC_NORECLAIM flag was introduced in commit eab0af9=
05bfc
> > > > > > ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN"). To=
 complement
> > > > > > this, let's add two helper functions, memalloc_nowait_{save,res=
tore}, which
> > > > > > will be useful in scenarios where we want to avoid waiting for =
memory
> > > > > > reclamation.
> > > > >
> > > > > Readahead already uses this context:
> > > > >
> > > > > static inline gfp_t readahead_gfp_mask(struct address_space *x)
> > > > > {
> > > > >         return mapping_gfp_mask(x) | __GFP_NORETRY | __GFP_NOWARN=
;
> > > > > }
> > > > >
> > > > > and __GFP_NORETRY means minimal direct reclaim should be performe=
d.
> > > > > Most filesystems already have GFP_NOFS context from
> > > > > mapping_gfp_mask(), so how much difference does completely avoidi=
ng
> > > > > direct reclaim actually make under memory pressure?
> > > >
> > > > Besides the __GFP_NOFS , ~__GFP_DIRECT_RECLAIM also implies
> > > > __GPF_NOIO. If we don't set __GPF_NOIO, the readahead can wait for =
IO,
> > > > right?
> > >
> > > There's a *lot* more difference between __GFP_NORETRY and
> > > __GFP_NOWAIT than just __GFP_NOIO. I don't need you to try to
> > > describe to me what the differences are; What I'm asking you is this:
> > >
> > > > > i.e. doing some direct reclaim without blocking when under memory
> > > > > pressure might actually give better performance than skipping dir=
ect
> > > > > reclaim and aborting readahead altogether....
> > > > >
> > > > > This really, really needs some numbers (both throughput and IO
> > > > > latency histograms) to go with it because we have no evidence eit=
her
> > > > > way to determine what is the best approach here.
> > >
> > > Put simply: does the existing readahead mechanism give better results
> > > than the proposed one, and if so, why wouldn't we just reenable
> > > readahead unconditionally instead of making it behave differently
> > > for this specific case?
> >
> > Are you suggesting we compare the following change with the current pro=
posal?
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index fd34b5755c0b..ced74b1b350d 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -3455,7 +3455,6 @@ static inline int kiocb_set_rw_flags(struct
> > kiocb *ki, rwf_t flags,
> >         if (flags & RWF_NOWAIT) {
> >                 if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
> >                         return -EOPNOTSUPP;
> > -               kiocb_flags |=3D IOCB_NOIO;
> >         }
> >         if (flags & RWF_ATOMIC) {
> >                 if (rw_type !=3D WRITE)
>
> Yes.
>
> > Doesn't unconditional readahead break the semantics of RWF_NOWAIT,
> > which is supposed to avoid waiting for I/O? For example, it might
> > trigger a pageout for a dirty page.
>
> Yes, but only for *some filesystems* in *some configurations*.
> Readahead allocation behaviour is specifically controlled by the gfp
> mask set on the mapping by the filesystem at inode instantiation
> time. i.e. via a call to mapping_set_gfp_mask().
>
> XFS, for one, always clears __GFP_FS from this mask, and several
> other filesystems set it to GFP_NOFS. Filesystems that do this will
> not do pageout for a dirty page during memory allocation.
>
> Further, memory reclaim can not write dirty pages to a filesystem
> without a ->writepage implementation. ->writepage is almost
> completely gone - neither ext4, btrfs or XFS have a ->writepage
> implementation anymore - with f2fs being the only "major" filesystem
> with a ->writepage implementation remaining.
>
> IOWs, for most readahead cases right now, direct memory reclaim will
> not issue writeback IO on dirty cached file pages and in the near
> future that will change to -never-.
>
> That means the only IO that direct reclaim will be able to do is for
> swapping and compaction. Both of these can be prevented simply by
> setting a GFP_NOIO allocation context. IOWs, in the not-to-distant
> future we won't have to turn direct reclaim off to prevent IO from
> and blocking in direct reclaim during readahead - GFP_NOIO context
> will be all that is necessary for IOCB_NOWAIT readahead.
>
> That's why I'm asking if just doing readahead as it stands from
> RWF_NOWAIT causes any obvious problems. I think we really only need
> need GFP_NOIO | __GFP_NORETRY allocation context for NOWAIT
> readahead IO, and that's something we already have a context API
> for.

Understood, thanks for your explanation.
so we need below changes,

@@ -2526,8 +2528,12 @@ static int filemap_get_pages(struct kiocb
*iocb, size_t count,
        if (!folio_batch_count(fbatch)) {
                if (iocb->ki_flags & IOCB_NOIO)
                        return -EAGAIN;
+               if (iocb->ki_flags & IOCB_NOWAIT)
+                       flags =3D memalloc_noio_save();
                page_cache_sync_readahead(mapping, ra, filp, index,
                                last_index - index);
+               if (iocb->ki_flags & IOCB_NOWAIT)
+                       memalloc_noio_restore(flags);
                filemap_get_read_batch(mapping, index, last_index - 1, fbat=
ch);
        }
        if (!folio_batch_count(fbatch)) {

What data would you recommend collecting after implementing the above
change? Should we measure the latency of preadv2(2) under high memory
pressure? Although latency can vary, it seems we have no choice but to
use memalloc_noio_save instead of memalloc_nowait_save, as the MM
folks are not in favor of the latter.

--
Regards
Yafang

