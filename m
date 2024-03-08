Return-Path: <linux-fsdevel+bounces-13967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AC8875CAB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 04:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C941F21DB8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 03:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBAD2C19A;
	Fri,  8 Mar 2024 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCeuW/vc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7342206E;
	Fri,  8 Mar 2024 03:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709868157; cv=none; b=nKjp0UiI6F5Nax9hBdlTXmWkoosN8g1xdvdRjJx1GvszLZHvHaaWPUkNpjVXeo4C0QVBrUX1WLB4yM63Itdor2pvFTFWlbWk9bhIrdmKP3cr0HKqLKeaO/ZdXzGynWQa+Yk2S2vXtcHg1o49YudK7fIiZH1Zof8Fg2qV7+p3snE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709868157; c=relaxed/simple;
	bh=w9pClHroTQxBlOh8S8BxqWSGGwFeKv959LpHQAgLEGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FopOZNChgJ8WV4vfkv+N7RHplc/nnhn30+X3GM4nRL0r9aJ1NhjgNDsXPROJOs7epfeKAsgvX/rVq2PsN3IF/OLJidcFf1CPkGqTKW0T2HRAIHUwZvSZsoS4PUOam2vT4xUfcmjVYcPoRO0ywShUTtlrlZrw4tXd9TFYhMnlvmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCeuW/vc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADF9C433F1;
	Fri,  8 Mar 2024 03:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709868157;
	bh=w9pClHroTQxBlOh8S8BxqWSGGwFeKv959LpHQAgLEGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RCeuW/vc1ttYm4nYFicSpGFCrllGx74TAzfjJ2E4uKGC2Se0HeuANwXEyUO3yeH+E
	 Pk9HDoOOLtGJtkPWaFWFbc/l2HQa2zOA2XzUXXhicC12gSrOySdq9NwfyBL26RtFq2
	 a7ObpKhUq4osnJmMdmbcnICT+xU7mZH0ZYQZ8j2kKCbL9TO/iGjXxGUo8SijLQdDf+
	 NnocmnrRs+HTGigH0YMspKVkJFvbGux6J29JLR9MrEW3js4xP3Tt/aY//33GhyMTQM
	 cKN1i0U8nvXVLpjbcAP40lSLuXjs/9QCRNMe0kA/Hm2284UYxbPHf5OF74JKOtcKg6
	 plD19RQlPdNtg==
Date: Thu, 7 Mar 2024 19:22:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 10/24] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <20240308032236.GM6184@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-12-aalbersh@redhat.com>
 <20240304233927.GC17145@sol.localdomain>
 <ZepP3iAmvQhbbA2t@dread.disaster.area>
 <20240307235907.GA8111@sol.localdomain>
 <Zepn3ycweBrgwgDO@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zepn3ycweBrgwgDO@dread.disaster.area>

On Fri, Mar 08, 2024 at 12:20:31PM +1100, Dave Chinner wrote:
> On Thu, Mar 07, 2024 at 03:59:07PM -0800, Eric Biggers wrote:
> > On Fri, Mar 08, 2024 at 10:38:06AM +1100, Dave Chinner wrote:
> > > > This makes all kernels with CONFIG_FS_VERITY enabled start preallocating memory
> > > > for these bios, regardless of whether they end up being used or not.  When
> > > > PAGE_SIZE==4096 it comes out to about 134 KiB of memory total (32 bios at just
> > > > over 4 KiB per bio, most of which is used for the BIO_MAX_VECS bvecs), and it
> > > > scales up with PAGE_SIZE such that with PAGE_SIZE==65536 it's about 2144 KiB.
> > > 
> > > Honestly: I don't think we care about this.
> > > 
> > > Indeed, if a system is configured with iomap and does not use XFS,
> > > GFS2 or zonefs, it's not going to be using the iomap_ioend_bioset at
> > > all, either. So by you definition that's just wasted memory, too, on
> > > systems that don't use any of these three filesystems. But we
> > > aren't going to make that one conditional, because the complexity
> > > and overhead of checks that never trigger after the first IO doesn't
> > > actually provide any return for the cost of ongoing maintenance.
> > > 
> > > Similarly, once XFS has fsverity enabled, it's going to get used all
> > > over the place in the container and VM world. So we are *always*
> > > going to want this bioset to be initialised on these production
> > > systems, so it falls into the same category as the
> > > iomap_ioend_bioset. That is, if you don't want that overhead, turn
> > > the functionality off via CONFIG file options.
> > 
> > "We're already wasting memory, therefore it's fine to waste more" isn't a great
> > argument.
> 
> Adding complexity just because -you- think the memory is wasted
> isn't any better argument. I don't think the memory is wasted, and I
> expect that fsverity will end up in -very- wide use across
> enterprise production systems as container/vm image build
> infrastructure moves towards composefs-like algorithms that have a
> hard dependency on fsverity functionality being present in the host
> filesytsems.

FWIW I would like to evaluate verity for certain things, such as bitrot
detection on backup disks and the like.  My employers are probably much
more interested in the same sealed rootfs blahdyblah that everyone else
has spilt much ink over. :)

> > iomap_ioend_bioset is indeed also problematic, though it's also a bit different
> > in that it's needed for basic filesystem functionality, not an optional feature.
> > Yes, ext4 and f2fs don't actually use iomap for buffered reads, but IIUC at
> > least there's a plan to do that.  Meanwhile there's no plan for fsverity to be
> > used on every system that may be using a filesystem that supports it.
> 
> That's not the case I see coming for XFS - by the time we get this
> merged and out of experimental support, the distro and application
> support will already be there for endemic use of fsverity on XFS.
> That's all being prototyped on ext4+fsverity right now, and you
> probably don't see any of that happening.
> 
> > We should take care not to over-estimate how many users use optional features.
> > Linux distros turn on most kconfig options just in case, but often the common
> > case is that the option is on but the feature is not used.
> 
> I don't think that fsverity is going to be an optional feature in
> future distros - we're already building core infrastructure based on
> the data integrity guarantees that fsverity provides us with. IOWs,
> I think fsverity support will soon become required core OS
> functionality by more than one distro, and so we just don't careg
> about this overhead because the extra read IO bioset will always be
> necessary....

Same here.

> > > > How about allocating the pool when it's known it's actually going to be used,
> > > > similar to what fs/crypto/ does for fscrypt_bounce_page_pool?  For example,
> > > > there could be a flag in struct fsverity_operations that says whether filesystem
> > > > wants the iomap fsverity bioset, and when fs/verity/ sets up the fsverity_info
> > > > for any file for the first time since boot, it could call into fs/iomap/ to
> > > > initialize the iomap fsverity bioset if needed.
> > > > 
> > > > BTW, errors from builtin initcalls such as iomap_init() get ignored.  So the
> > > > error handling logic above does not really work as may have been intended.
> > > 
> > > That's not an iomap problem - lots of fs_initcall() functions return
> > > errors because they failed things like memory allocation. If this is
> > > actually problem, then fix the core init infrastructure to handle
> > > errors properly, eh?
> > 
> > What does "properly" mean?
> 
> Having documented requirements and behaviour and then enforcing
> them. There is no documentation for initcalls - they return an int,
> so by convention it is expected that errors should be returned to
> the caller.

Agree.  I hated that weird thing that sync_filesystem did where it
mostly ignored the return values.

> There's *nothing* that says initcalls should panic() instead of
> returning errors if they have a fatal error. There's nothing that
> says "errors are ignored" - having them be declared as void would be
> a good hint that errors can't be returned or handled.
> 
> Expecting people to cargo-cult other implementations and magically
> get it right is almost guaranteed to ensure that nobody actually
> gets it right the first time...

Hrmm.  Should we have a iomap_init_succeeded() function that init_xfs_fs
and the like can call to find out if the initcall failed and refuse to
load?

Or just make it a module and then the insmod(iomap) can fail.

> > Even if init/main.c did something with the returned
> > error code, individual subsystems still need to know what behavior they want and
> > act accordingly.
> 
> "return an error only on fatal initialisation failure" and then the
> core code can decide if the initcall level is high enough to warrant
> panic()ing the machine.
> 
> > Do they want to panic the kernel, or do they want to fall back
> > gracefully with degraded functionality.
> 
> If they can gracefully fall back to some other mechanism, then they
> *haven't failed* and there's no need to return an error or panic.

I'm not sure if insmod(xfs) bailing out is all that graceful, but I
suppose it's less rude than a kernel panic :P

> > If subsystems go with the panic (like
> > fsverity_init() does these days), then there is no need for doing any cleanup on
> > errors like this patchset does.
> 
> s/panic/BUG()/ and read that back.
> 
> Because that's essentially what it is - error handling via BUG()
> calls. We get told off for using BUG() instead of correct error
> handling, yet here we are with code that does correct error handling
> and we're being told to replace it with BUG() because the errors
> aren't handled by the infrastructure calling our code. Gross, nasty
> and really, really needs to be documented.

Log an error and invoke the autorepair to see if you can really let the
smoke out? ;)

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

