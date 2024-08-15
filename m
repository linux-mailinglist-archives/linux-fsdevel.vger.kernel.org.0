Return-Path: <linux-fsdevel+bounces-26014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE40952806
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 04:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C183B2401D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 02:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC781D545;
	Thu, 15 Aug 2024 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="c9FBd6Kv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D2D18C0C
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 02:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723690463; cv=none; b=j87U9aSrzD7xX6++vmgrXN6VVvGMFplo9XRrgBwcGZPi1mAueYuj/mrXOv6qBk4oyy0hMssa0eSENCJU2ehxotsALOYmaNt/UW9quL7whKoa7FOceEFXYzAvENj3NmLs/kdyjMHBCYNstL2TzwCc6weU+yS9q7+FOw28y6ZhqFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723690463; c=relaxed/simple;
	bh=hNntKxrL8R/y8A9zP+ZdY4Lg5FSx3K6phE7/lHAQ978=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aL4KNUYTHwgHmyL4e2uF3EwD9ymClgMOeKy9WieqzqOSF8bd20rczDC6CMUmXbk0ysanu1WS92yyrTC8ljFvzKrODJR1zFVWyQVqzHK4OwxKZv25zAw3VhCk9zt64unn3Hk+ho9KJ74WoXfWitmttyiGMW6I0zthpd+v45Dh63M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=c9FBd6Kv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fdd6d81812so5427955ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 19:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723690461; x=1724295261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gPCANlIQhbsZqCNbnbbPmOo9t3kSZJf75lEGK3ZyGfQ=;
        b=c9FBd6KvAF9Wshvnl+3R6S0DTNIBZHMXd5Pv8xfmcEha85xF0ncJekKttSamp+EBTU
         23CVlXayzVm0bkSwjSLgBWwQH71jfUS2Vxt9zyz5hIofklRWeUC9CyHu8HI8bIRygZPm
         JGHNcn4P1/G3LYCB+LlOnFLcL2vXdhRTecsGzo++2u+bNLr1NPSkL2ZhB7VnLYSRmus0
         GjLGlwkc4xGJeTYaplgA9EjEFk1t/rvwGw7kKvsHaNCSm3iNvt2wTcz8EITX4QoF0M7B
         Cj8x8RT+H/Wm5D2ZvmMSKVHVZq1FEc1F285xlS/SLMZb4zn+RlWdtJsAdwhfTmehznl9
         DHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723690461; x=1724295261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPCANlIQhbsZqCNbnbbPmOo9t3kSZJf75lEGK3ZyGfQ=;
        b=lwsDhEs5vy9z3ICBtFNVep0Fxexp5AN/SOvJvZWxHRviEz4ud9uGcPxdZOXzkkVzq1
         K/dBl6UTn5e0irdkPKdTBHRjCDEKtlBYGh7oxaraKp9FJeSWjWIloqPOIJ94yK1r+D1D
         27p7AAr48ch8PMC0ODeYGNm2IjgIdSCrH5ccol/AUXORcKQddOIu9RcDO7y043mh8zI2
         eOtvAnJ14dcyNHxJoMwp2uRgPDL22t3FXaSfC5yuySGaskaCNYfysiv2NIGMs0Cvi9Du
         TmmQOP+MxPoTk/HZr9wiHCujywvnNPtJ/GJ7nHecilvuAFdCddFMeQr0YekOCHZ2chLe
         bYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVVCP06Ti3rAHxPApI3N+TqRC3udT1JRBdxmBkdFvB4VfWfbtZQkUF0GqmIBFcC8owxVtc4Ntc8yl+SSCMFcCRk6PBZYGVtfQrGlEfpw==
X-Gm-Message-State: AOJu0YzCTjo1D9RJ5ZIW4AZOsU1Is83RPwiRmm3wr2xmkYnFes7AEWdP
	viVjVqYVR8FUF0yxCpEGKNkY6u51eaZyXZpwg+t7k4joyeCmYH4ih2dLSvhvIY4=
X-Google-Smtp-Source: AGHT+IGc2IhX7zyTOdCDZ3pAno7WsNb+k6Dc+VYY9c0J/aKghpebQF37/a9W7U1qlF4/BFzJLfxWaw==
X-Received: by 2002:a17:902:ec8c:b0:201:daee:6fae with SMTP id d9443c01a7336-201daee71b6mr37989115ad.48.1723690460698;
        Wed, 14 Aug 2024 19:54:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038d715sm2985055ad.198.2024.08.14.19.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 19:54:20 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1seQcz-00HV6b-2j;
	Thu, 15 Aug 2024 12:54:17 +1000
Date: Thu, 15 Aug 2024 12:54:17 +1000
From: Dave Chinner <david@fromorbit.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
Message-ID: <Zr1t2d/3tqNBc7qM@dread.disaster.area>
References: <20240812090525.80299-1-laoar.shao@gmail.com>
 <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrv6Fts73FECScyd@dread.disaster.area>
 <CALOAHbAfQPdpXt0SHGxQdJEi1R_u+1x2KSwZ5XfrQD-sQmhKiA@mail.gmail.com>
 <ZrxDrSjOJRmjTGvM@dread.disaster.area>
 <CALOAHbCTv5w4Lg3SeA43yCAww8DobJ_CN+9BcQDMJzaHVPNZZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCTv5w4Lg3SeA43yCAww8DobJ_CN+9BcQDMJzaHVPNZZQ@mail.gmail.com>

On Wed, Aug 14, 2024 at 03:32:26PM +0800, Yafang Shao wrote:
> On Wed, Aug 14, 2024 at 1:42 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Wed, Aug 14, 2024 at 10:19:36AM +0800, Yafang Shao wrote:
> > > On Wed, Aug 14, 2024 at 8:28 AM Dave Chinner <david@fromorbit.com> wrote:
> > > >
> > > > On Mon, Aug 12, 2024 at 05:05:24PM +0800, Yafang Shao wrote:
> > > > > The PF_MEMALLOC_NORECLAIM flag was introduced in commit eab0af905bfc
> > > > > ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN"). To complement
> > > > > this, let's add two helper functions, memalloc_nowait_{save,restore}, which
> > > > > will be useful in scenarios where we want to avoid waiting for memory
> > > > > reclamation.
> > > >
> > > > Readahead already uses this context:
> > > >
> > > > static inline gfp_t readahead_gfp_mask(struct address_space *x)
> > > > {
> > > >         return mapping_gfp_mask(x) | __GFP_NORETRY | __GFP_NOWARN;
> > > > }
> > > >
> > > > and __GFP_NORETRY means minimal direct reclaim should be performed.
> > > > Most filesystems already have GFP_NOFS context from
> > > > mapping_gfp_mask(), so how much difference does completely avoiding
> > > > direct reclaim actually make under memory pressure?
> > >
> > > Besides the __GFP_NOFS , ~__GFP_DIRECT_RECLAIM also implies
> > > __GPF_NOIO. If we don't set __GPF_NOIO, the readahead can wait for IO,
> > > right?
> >
> > There's a *lot* more difference between __GFP_NORETRY and
> > __GFP_NOWAIT than just __GFP_NOIO. I don't need you to try to
> > describe to me what the differences are; What I'm asking you is this:
> >
> > > > i.e. doing some direct reclaim without blocking when under memory
> > > > pressure might actually give better performance than skipping direct
> > > > reclaim and aborting readahead altogether....
> > > >
> > > > This really, really needs some numbers (both throughput and IO
> > > > latency histograms) to go with it because we have no evidence either
> > > > way to determine what is the best approach here.
> >
> > Put simply: does the existing readahead mechanism give better results
> > than the proposed one, and if so, why wouldn't we just reenable
> > readahead unconditionally instead of making it behave differently
> > for this specific case?
> 
> Are you suggesting we compare the following change with the current proposal?
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd34b5755c0b..ced74b1b350d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3455,7 +3455,6 @@ static inline int kiocb_set_rw_flags(struct
> kiocb *ki, rwf_t flags,
>         if (flags & RWF_NOWAIT) {
>                 if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
>                         return -EOPNOTSUPP;
> -               kiocb_flags |= IOCB_NOIO;
>         }
>         if (flags & RWF_ATOMIC) {
>                 if (rw_type != WRITE)

Yes.

> Doesn't unconditional readahead break the semantics of RWF_NOWAIT,
> which is supposed to avoid waiting for I/O? For example, it might
> trigger a pageout for a dirty page.

Yes, but only for *some filesystems* in *some configurations*.
Readahead allocation behaviour is specifically controlled by the gfp
mask set on the mapping by the filesystem at inode instantiation
time. i.e. via a call to mapping_set_gfp_mask().

XFS, for one, always clears __GFP_FS from this mask, and several
other filesystems set it to GFP_NOFS. Filesystems that do this will
not do pageout for a dirty page during memory allocation.

Further, memory reclaim can not write dirty pages to a filesystem
without a ->writepage implementation. ->writepage is almost
completely gone - neither ext4, btrfs or XFS have a ->writepage
implementation anymore - with f2fs being the only "major" filesystem
with a ->writepage implementation remaining.

IOWs, for most readahead cases right now, direct memory reclaim will
not issue writeback IO on dirty cached file pages and in the near
future that will change to -never-.

That means the only IO that direct reclaim will be able to do is for
swapping and compaction. Both of these can be prevented simply by
setting a GFP_NOIO allocation context. IOWs, in the not-to-distant
future we won't have to turn direct reclaim off to prevent IO from
and blocking in direct reclaim during readahead - GFP_NOIO context
will be all that is necessary for IOCB_NOWAIT readahead.

That's why I'm asking if just doing readahead as it stands from
RWF_NOWAIT causes any obvious problems. I think we really only need
need GFP_NOIO | __GFP_NORETRY allocation context for NOWAIT
readahead IO, and that's something we already have a context API
for.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

