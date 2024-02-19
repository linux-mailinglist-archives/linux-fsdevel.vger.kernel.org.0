Return-Path: <linux-fsdevel+bounces-11990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C483C85A0BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 11:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483BD1F21F76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 10:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65912562A;
	Mon, 19 Feb 2024 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lEAKcObJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81BA25603
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337772; cv=none; b=V2Gra/AjUJWuZYiAFcxZX0QswX1Dm6L8eJu99RfQEyRTarQ4bZARYgHgY5Ln734SWBdbZq/Ij+0hjFUw9S1j6JlrtO5HhgdkvHhgeS2pDofCZzgkv1PNLl44aNl0fER4/qyt/O8PBVfCLNJzlBQ/6v82+cQGQprPhqEQazsbnLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337772; c=relaxed/simple;
	bh=LfGonh/vxzEvh4ssbdF8peYR0PFMnQMns4BKb2UYKGY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E4658Xzeymm4YEg9J5o7LzwXUkX6n6kGOdvq9aPl4HnGOoIulnEmUTKgAAk3St1CNU6zRsgwUdyaan8e1HV+UiWz/mqGWlqp4+T3tspnM7lgA3oT0Ww7hbJn7wzwkJQjI/JyAHibKMxEycJJNe8Bwa+wWIvh/VXyx23cXAqTwp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lEAKcObJ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6002317a427so33481227b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 02:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708337770; x=1708942570; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nGxwSEo7jdD6QsMjGOSy8a5TjT863H0VEZLOli0MF44=;
        b=lEAKcObJaq5f79BNkmV7VmD9rpFJ5JMWtHsQAAiJgo86tPKsCHchOZw79mB20sMKHF
         dMJVjUN2T3LSJSpNjSf6ejgR3vRovNuhNftSzKx0lvCCJwmko99Gq2ACZvrUqPWa9Rzl
         kj5kCUAJ8Hf+DRo33zHV5imrHHoheBohjbyugZCvZdPI9xR4Cu9SDabcPwNo3E8LSVP5
         7nk1DjbdhKPnKq2m4cxc6ohzaZ08vzjXYavHSp6y/hNdJnabPxxSWTghdIQFOz9w4ao5
         kNpcM40ZbJVzpZbLi9OkCMtLqs5P0LXt8lNemjt0KZ4sqmng5bf3ecff5yIT5319j0YU
         izXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708337770; x=1708942570;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGxwSEo7jdD6QsMjGOSy8a5TjT863H0VEZLOli0MF44=;
        b=dnZZclq2knR99syBIsSyM+3JfV7DRLfKTbirL90XJEGUsvccLY5m/qyIaPHYeIFm3m
         DEFneFSQS3dpCOFrHCyStuvlrVGCYQmWqLgeyUOKwfp8bSE7Tk7dNnjdcEWJyeKumiew
         CyQpuCc5RgT6D//RQHt3BYWppV6ylHchY0P6P1VcsmQ1QO5IZQ9LL0DNyT+h68TsXOL+
         k/nZrBoeXlq4NjHmXWjllDM7GeL7AyeOt6zMfXF5Aeg5+oiHyd3nXML3NdclZPsZ4jYH
         4C4zHr6mDaqEBfPNKt8J253llpU+JsWtnOuuEtHXFrooedV1KGdwMLeogeObn8js9uXI
         08WA==
X-Forwarded-Encrypted: i=1; AJvYcCXu+fkPOZ3g4AN4JKISpFVGMsDxK/KPUyKX/YtrDKr8ck45Koc9pOsD8JipqBP2/9QoOwP/WNOvVdDXr15dVIN/tNld5uTQtpi3UxG1TQ==
X-Gm-Message-State: AOJu0YwBbMyItbpdZBprt3G17B80iyRSgbf1NwdWEPyJz8+UZsHLMjt6
	f6bDpLpAXEsXAxgHCElErW9D1ukPPImLUm3UUsqBVcfLj8MsyLTT+l3QrdSZWA==
X-Google-Smtp-Source: AGHT+IFJoAVuMYzdGhio7jIt4XIuZS5LYL15OslIBX+wn0f8UO4hUX2IbPCCvqiWaqIn1dV8z44Zlg==
X-Received: by 2002:a81:431f:0:b0:608:e2f:e3d2 with SMTP id q31-20020a81431f000000b006080e2fe3d2mr4916030ywa.22.1708337769682;
        Mon, 19 Feb 2024 02:16:09 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id dt15-20020a05690c250f00b00607f86fa184sm1476113ywb.99.2024.02.19.02.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 02:16:08 -0800 (PST)
Date: Mon, 19 Feb 2024 02:15:47 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Daniel Gomez <da.gomez@samsung.com>
cc: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
    "brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>, 
    "hughd@google.com" <hughd@google.com>, 
    "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
    "dagmcr@gmail.com" <dagmcr@gmail.com>, 
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-mm@kvack.org" <linux-mm@kvack.org>, 
    "willy@infradead.org" <willy@infradead.org>, 
    "hch@infradead.org" <hch@infradead.org>, 
    "mcgrof@kernel.org" <mcgrof@kernel.org>, 
    Pankaj Raghav <p.raghav@samsung.com>, 
    "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 0/9] shmem: fix llseek in hugepages
In-Reply-To: <25i3n46nanffixvzdby6jwxgboi64qnleixz33dposwuwmzj7p@6yvgyakozars>
Message-ID: <e3602f54-b333-7c8c-0031-6a14b32a3990@google.com>
References: <20240209142901.126894-1-da.gomez@samsung.com> <CGME20240214194911eucas1p187ae3bc5b2be4e0d2155f9ce792fdf8b@eucas1p1.samsung.com> <25i3n46nanffixvzdby6jwxgboi64qnleixz33dposwuwmzj7p@6yvgyakozars>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 14 Feb 2024, Daniel Gomez wrote:
> On Fri, Feb 09, 2024 at 02:29:01PM +0000, Daniel Gomez wrote:
> > Hi,
> > 
> > The following series fixes the generic/285 and generic/436 fstests for huge
> > pages (huge=always). These are tests for llseek (SEEK_HOLE and SEEK_DATA).
> > 
> > The implementation to fix above tests is based on iomap per-block tracking for
> > uptodate and dirty states but applied to shmem uptodate flag.
> 
> Hi Hugh, Andrew,
> 
> Could you kindly provide feedback on these patches/fixes? I'd appreciate your
> input on whether we're headed in the right direction, or maybe not.

I am sorry, Daniel, but I see this series as misdirected effort.

We do not want to add overhead to tmpfs and the kernel, just to pass two
tests which were (very reasonably) written for fixed block size, before
the huge page possibility ever came in.

If one opts for transparent huge pages in the filesystem, then of course
the dividing line between hole and data becomes more elastic than before.

It would be a serious bug if lseek ever reported an area of non-0 data as
in a hole; but I don't think that is what generic/285 or generic/436 find.

Beyond that, "man 2 lseek" is very forgiving of filesystem implementation.

I'll send you my stack of xfstests patches (which, as usual, I cannot
afford the time now to re-review and post): there are several tweaks to
seek_sanity_test in there for tmpfs huge pages, along with other fixes
for tmpfs (and some fixes to suit an old 32-bit build environment).

With those tweaks, generic/285 and generic/436 and others (but not all)
have been passing on huge tmpfs for several years.  If you see something
you'd like to add your name to in that stack, or can improve upon, please
go ahead and post to the fstests list (Cc me).

Thanks,
Hugh

> 
> Thanks,
> Daniel
> 
> > 
> > The motivation is to avoid any regressions in tmpfs once it gets support for
> > large folios.
> > 
> > Testing with kdevops
> > Testing has been performed using fstests with kdevops for the v6.8-rc2 tag.
> > There are currently different profiles supported [1] and for each of these,
> > a baseline of 20 loops has been performed with the following failures for
> > hugepages profiles: generic/080, generic/126, generic/193, generic/245,
> > generic/285, generic/436, generic/551, generic/619 and generic/732.
> > 
> > If anyone interested, please find all of the failures in the expunges directory:
> > https://github.com/linux-kdevops/kdevops/tree/master/workflows/fstests/expunges/6.8.0-rc2/tmpfs/unassigned
> > 
> > [1] tmpfs profiles supported in kdevops: default, tmpfs_noswap_huge_never,
> > tmpfs_noswap_huge_always, tmpfs_noswap_huge_within_size,
> > tmpfs_noswap_huge_advise, tmpfs_huge_always, tmpfs_huge_within_size and
> > tmpfs_huge_advise.
> > 
> > More information:
> > https://github.com/linux-kdevops/kdevops/tree/master/workflows/fstests/expunges/6.8.0-rc2/tmpfs/unassigned
> > 
> > All the patches has been tested on top of v6.8-rc2 and rebased onto latest next
> > tag available (next-20240209).
> > 
> > Daniel
> > 
> > Daniel Gomez (8):
> >   shmem: add per-block uptodate tracking for hugepages
> >   shmem: move folio zero operation to write_begin()
> >   shmem: exit shmem_get_folio_gfp() if block is uptodate
> >   shmem: clear_highpage() if block is not uptodate
> >   shmem: set folio uptodate when reclaim
> >   shmem: check if a block is uptodate before splice into pipe
> >   shmem: clear uptodate blocks after PUNCH_HOLE
> >   shmem: enable per-block uptodate
> > 
> > Pankaj Raghav (1):
> >   splice: don't check for uptodate if partially uptodate is impl
> > 
> >  fs/splice.c |  17 ++-
> >  mm/shmem.c  | 340 ++++++++++++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 332 insertions(+), 25 deletions(-)
> > 
> > -- 
> > 2.43.0

