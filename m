Return-Path: <linux-fsdevel+bounces-13966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF086875C99
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 04:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4502D1F21BA4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 03:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3B82B9AC;
	Fri,  8 Mar 2024 03:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQMqjpaT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79CB22F1E;
	Fri,  8 Mar 2024 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709867791; cv=none; b=XrwtZRR19rIS5G0MtjIfj9PY/sMuMheLGGB+vz+4Wq+sr7gI0U4Wgtcj+k3TrKTXQ/8ozJBIYnSdwbRMfRSTN8r4f9FKIJlnxTTACzqL12w7P/d+cJM7Wo1BhNSrA2QgAyUR8d9A+3SDBQIAct5nJOQt1stMX8h4qxamGjJ9KzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709867791; c=relaxed/simple;
	bh=BjpBZkxmyruywoYFAPVgRHonNYrUfOU/ggENIKnuy7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKPoa01d8x+75muNC7LyFMhxs7f4mZz0HB8HrS7JHGiEl4qs5H/k10Ves27fzB43+vysb4eIjgqFlkbSTZG6u+sl4Bc3QpZgmm2ruOLS+NhBdvuU4Kzyq9Tx63FoiCZygPnXfW59Pp+F+rWeWTRs3z8r1zy5h2kdfvWTLrEG8HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQMqjpaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C2BC433C7;
	Fri,  8 Mar 2024 03:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709867791;
	bh=BjpBZkxmyruywoYFAPVgRHonNYrUfOU/ggENIKnuy7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQMqjpaT6vfJgvoLgOn6CBPU37xA6M2HdRfS4ZqV5ckzCoJhzYE69yI8FVw99PKOT
	 CEg8/I1ykRnEfokMXzJ0ytu9rgPLsf0qhQtOQem2TpS6jV+LArHnwN7/JXjoz9oafb
	 3zLor05fFKAMvg2o/DdoqGU84bDvi9u23lybvS1ex4dWXpGB5Dy0EV4Bc3joZRWNHu
	 b6dbjh23G3wnbXA3N8NcrYZiBn70UY2lvZWUyMN/7ox+ufks07j/tdWzmXUgZx/reg
	 mYNx2NgIscxB7iEygtznvy7I1LmSfK0u5C0/XSxiEmDCFU5AqGk3nixBgqY4/aoe4k
	 gVdIndHkj4w0w==
Date: Thu, 7 Mar 2024 19:16:29 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 10/24] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <20240308031629.GB8111@sol.localdomain>
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
> 
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
> functionality by more than one distro, and so we just don't care
> about this overhead because the extra read IO bioset will always be
> necessary....

That's great that you're finding fsverity to be useful!

At the same time, please do keep in mind that there's a huge variety of Linux
systems besides the "enterprise" systems using XFS that you may have in mind.

The memory allocated for iomap_fsverity_bioset, as proposed, is indeed wasted on
any system that isn't using both XFS *and* fsverity (as long as
CONFIG_FS_VERITY=y, and either CONFIG_EXT4_FS, CONFIG_F2FS_FS, or
CONFIG_BTRFS_FS is enabled too).  The amount is also quadrupled on systems that
use a 16K page size, which will become increasingly common in the future.

It may be that part of your intention for pushing back against this optimization
is to encourage filesystems to convert their buffered reads to iomap.  I'm not
sure it will actually have that effect.  First, it's not clear that it will be
technically feasible for the filesystems that support compression, btrfs and
f2fs, to convert their buffered reads to iomap.  Second, this sort of thing
reinforces an impression that iomap is targeted at enterprise systems using XFS,
and that changes that would be helpful on other types of systems are rejected.

- Eric

