Return-Path: <linux-fsdevel+bounces-13958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2323875B58
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 00:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AAFF1F228C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1821E481A8;
	Thu,  7 Mar 2024 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooy63KAn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C21D698;
	Thu,  7 Mar 2024 23:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709855950; cv=none; b=QSYvDbymOfxfi0D0/DSST3nE4WI9OwFFAYNnPT+6TBgCQ2ayydpYhbll8CIwXdUJw6/Vvp0GiOh6U7z5BLfnfNfuj21kCluTsbtRsEQElN2VwUt0igNIvS7VkRGPuVp5EyiNMUph9tgDlqyU7207LUqE0cIOzYY7eGCLRKRmcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709855950; c=relaxed/simple;
	bh=a5US15sCcXIcbEgTJfexJPB25DKyVkJmnGBwUhjfdas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ii1Bu27Mh53gc24d2nLC1fXxDGiVLNv5QM91OAECNQx24KGKjIp9vkHWQKxO2u8CFu8d4X7DOlGlUj+6WWSvWZo+w1qTLC14ZrIisufCY6/dihgXu/9P4HyVF1kiCK/1hgCMR8kanQPjaxlgPZY+DIocARe0ztS6pHVSj+c1iXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooy63KAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE898C433F1;
	Thu,  7 Mar 2024 23:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709855950;
	bh=a5US15sCcXIcbEgTJfexJPB25DKyVkJmnGBwUhjfdas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ooy63KAnMfUyoesPu/pvIEQD3A0eVon4Jvh0Syib5RrYtxoSGIaDlWR9EsyGJaama
	 BwBxB722c4gDYukkB7E17T3gmGD/hsJx9oJIsocBsD8rY61lmg9DseoncbOFc4rR60
	 fqvW7VC4SC6agEXGXVHvjRuM0WWMcyjahUkvOQnNGZtFF56jPPhyYXwPwSQC9hLoo0
	 U5B41I6Txs6U22tTsq4xwJR6APjOqMUI0mRof9F7OSxlP9DQjJGtQB612WMy+BDZUP
	 tVI2k8DrFcJGcVWSZFbbEWnQHt3Fe/ayTguOlV+yUx6jhjDg/dUGuaIKRPnviyTvKe
	 0d0iec00en2BA==
Date: Thu, 7 Mar 2024 15:59:07 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 10/24] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <20240307235907.GA8111@sol.localdomain>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-12-aalbersh@redhat.com>
 <20240304233927.GC17145@sol.localdomain>
 <ZepP3iAmvQhbbA2t@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZepP3iAmvQhbbA2t@dread.disaster.area>

On Fri, Mar 08, 2024 at 10:38:06AM +1100, Dave Chinner wrote:
> > This makes all kernels with CONFIG_FS_VERITY enabled start preallocating memory
> > for these bios, regardless of whether they end up being used or not.  When
> > PAGE_SIZE==4096 it comes out to about 134 KiB of memory total (32 bios at just
> > over 4 KiB per bio, most of which is used for the BIO_MAX_VECS bvecs), and it
> > scales up with PAGE_SIZE such that with PAGE_SIZE==65536 it's about 2144 KiB.
> 
> Honestly: I don't think we care about this.
> 
> Indeed, if a system is configured with iomap and does not use XFS,
> GFS2 or zonefs, it's not going to be using the iomap_ioend_bioset at
> all, either. So by you definition that's just wasted memory, too, on
> systems that don't use any of these three filesystems. But we
> aren't going to make that one conditional, because the complexity
> and overhead of checks that never trigger after the first IO doesn't
> actually provide any return for the cost of ongoing maintenance.
> 
> Similarly, once XFS has fsverity enabled, it's going to get used all
> over the place in the container and VM world. So we are *always*
> going to want this bioset to be initialised on these production
> systems, so it falls into the same category as the
> iomap_ioend_bioset. That is, if you don't want that overhead, turn
> the functionality off via CONFIG file options.

"We're already wasting memory, therefore it's fine to waste more" isn't a great
argument.

iomap_ioend_bioset is indeed also problematic, though it's also a bit different
in that it's needed for basic filesystem functionality, not an optional feature.
Yes, ext4 and f2fs don't actually use iomap for buffered reads, but IIUC at
least there's a plan to do that.  Meanwhile there's no plan for fsverity to be
used on every system that may be using a filesystem that supports it.

We should take care not to over-estimate how many users use optional features.
Linux distros turn on most kconfig options just in case, but often the common
case is that the option is on but the feature is not used.

> > How about allocating the pool when it's known it's actually going to be used,
> > similar to what fs/crypto/ does for fscrypt_bounce_page_pool?  For example,
> > there could be a flag in struct fsverity_operations that says whether filesystem
> > wants the iomap fsverity bioset, and when fs/verity/ sets up the fsverity_info
> > for any file for the first time since boot, it could call into fs/iomap/ to
> > initialize the iomap fsverity bioset if needed.
> > 
> > BTW, errors from builtin initcalls such as iomap_init() get ignored.  So the
> > error handling logic above does not really work as may have been intended.
> 
> That's not an iomap problem - lots of fs_initcall() functions return
> errors because they failed things like memory allocation. If this is
> actually problem, then fix the core init infrastructure to handle
> errors properly, eh?

What does "properly" mean?  Even if init/main.c did something with the returned
error code, individual subsystems still need to know what behavior they want and
act accordingly.  Do they want to panic the kernel, or do they want to fall back
gracefully with degraded functionality.  If subsystems go with the panic (like
fsverity_init() does these days), then there is no need for doing any cleanup on
errors like this patchset does.

- Eric

