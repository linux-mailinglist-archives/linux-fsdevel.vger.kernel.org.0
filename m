Return-Path: <linux-fsdevel+bounces-13974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADA8875CF4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 04:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22DF2827CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 03:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282822C6A7;
	Fri,  8 Mar 2024 03:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCBSjAZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E07D2C1BF;
	Fri,  8 Mar 2024 03:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709870229; cv=none; b=nKHlooM70rEkDcB29CCRA6t6tMOpyYsdCkZeknINV11bCohYaLvhcDinhHNpm7bi5XeFNG5kaQe2oCDo7BIREVJDFGBVgO8TF8Eeu4sLoCDoYqFgyFFTXBabFaXbtMVIEgJUiqeRbuX7ITgOoW7ibbzof7z8fd0j8FN0+odPR4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709870229; c=relaxed/simple;
	bh=ripCdWhlT1pQlW6KaF2ME2qhgs+ERXBTC8P9/+awXFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2+5B41P8HWAzYIEqLlJLx3GnnHl89RvoGRLwxamn06Jr2YJezh95aaM3v9n5WwW6LoYLhki3mQ6ZIwTkMqs17MXJxeQUqmyKWyOmCQOA3vm7cS44iX0PqNJPpvMFVIgazyVlKXI6CDLKoq10yOMfsG/Ve7cfhn60o3d562tAl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCBSjAZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AD1C433C7;
	Fri,  8 Mar 2024 03:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709870229;
	bh=ripCdWhlT1pQlW6KaF2ME2qhgs+ERXBTC8P9/+awXFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCBSjAZi5qJKqsYiO6vGPUXV5+gkkM5IYdUuU7wyrsoQK3kcN0h7iUnmEHYeT6RcL
	 lEO+FuPXMzWiFOKaFTjbf5z1LBOgMIVi86CO1lMYNdYlnrn59IRuWIKLZY2mxx/qT2
	 hX0f+u/QAlP8TkSgIpDPr3RwZWIWn46+Mfl8d5sAK1ngCbR4/0WZbwH9CZAiWOuEYZ
	 k/29Vm7H/d2/S8DVh6ZsHK5FC/OZAPnqOSpIG0gNvcOWg2n4H6ukhyulfONaILzlIY
	 jI5ViHvyB+tnPLT4FEXfcqgMpD7sDmklq387obKDY3ysZaz6rM4H3oKbhiw02HKMZa
	 y+vAw9ehOQRYA==
Date: Thu, 7 Mar 2024 19:57:08 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 10/24] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <20240308035708.GN1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-12-aalbersh@redhat.com>
 <20240304233927.GC17145@sol.localdomain>
 <ZepP3iAmvQhbbA2t@dread.disaster.area>
 <20240307235907.GA8111@sol.localdomain>
 <Zepn3ycweBrgwgDO@dread.disaster.area>
 <20240308031629.GB8111@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308031629.GB8111@sol.localdomain>

On Thu, Mar 07, 2024 at 07:16:29PM -0800, Eric Biggers wrote:
> On Fri, Mar 08, 2024 at 12:20:31PM +1100, Dave Chinner wrote:
> > On Thu, Mar 07, 2024 at 03:59:07PM -0800, Eric Biggers wrote:
> > > On Fri, Mar 08, 2024 at 10:38:06AM +1100, Dave Chinner wrote:
> > > > > This makes all kernels with CONFIG_FS_VERITY enabled start preallocating memory
> > > > > for these bios, regardless of whether they end up being used or not.  When
> > > > > PAGE_SIZE==4096 it comes out to about 134 KiB of memory total (32 bios at just
> > > > > over 4 KiB per bio, most of which is used for the BIO_MAX_VECS bvecs), and it
> > > > > scales up with PAGE_SIZE such that with PAGE_SIZE==65536 it's about 2144 KiB.
> > > > 
> > > > Honestly: I don't think we care about this.
> > > > 
> > > > Indeed, if a system is configured with iomap and does not use XFS,
> > > > GFS2 or zonefs, it's not going to be using the iomap_ioend_bioset at
> > > > all, either. So by you definition that's just wasted memory, too, on
> > > > systems that don't use any of these three filesystems. But we
> > > > aren't going to make that one conditional, because the complexity
> > > > and overhead of checks that never trigger after the first IO doesn't
> > > > actually provide any return for the cost of ongoing maintenance.
> > > > 
> > > > Similarly, once XFS has fsverity enabled, it's going to get used all
> > > > over the place in the container and VM world. So we are *always*
> > > > going to want this bioset to be initialised on these production
> > > > systems, so it falls into the same category as the
> > > > iomap_ioend_bioset. That is, if you don't want that overhead, turn
> > > > the functionality off via CONFIG file options.
> > > 
> > > "We're already wasting memory, therefore it's fine to waste more" isn't a great
> > > argument.
> > 
> > Adding complexity just because -you- think the memory is wasted
> > isn't any better argument. I don't think the memory is wasted, and I
> > expect that fsverity will end up in -very- wide use across
> > enterprise production systems as container/vm image build
> > infrastructure moves towards composefs-like algorithms that have a
> > hard dependency on fsverity functionality being present in the host
> > filesytsems.
> > 
> > > iomap_ioend_bioset is indeed also problematic, though it's also a bit different
> > > in that it's needed for basic filesystem functionality, not an optional feature.
> > > Yes, ext4 and f2fs don't actually use iomap for buffered reads, but IIUC at
> > > least there's a plan to do that.  Meanwhile there's no plan for fsverity to be
> > > used on every system that may be using a filesystem that supports it.
> > 
> > That's not the case I see coming for XFS - by the time we get this
> > merged and out of experimental support, the distro and application
> > support will already be there for endemic use of fsverity on XFS.
> > That's all being prototyped on ext4+fsverity right now, and you
> > probably don't see any of that happening.
> > 
> > > We should take care not to over-estimate how many users use optional features.
> > > Linux distros turn on most kconfig options just in case, but often the common
> > > case is that the option is on but the feature is not used.
> > 
> > I don't think that fsverity is going to be an optional feature in
> > future distros - we're already building core infrastructure based on
> > the data integrity guarantees that fsverity provides us with. IOWs,
> > I think fsverity support will soon become required core OS
> > functionality by more than one distro, and so we just don't care
> > about this overhead because the extra read IO bioset will always be
> > necessary....
> 
> That's great that you're finding fsverity to be useful!
> 
> At the same time, please do keep in mind that there's a huge variety of Linux
> systems besides the "enterprise" systems using XFS that you may have in mind.
> 
> The memory allocated for iomap_fsverity_bioset, as proposed, is indeed wasted on
> any system that isn't using both XFS *and* fsverity (as long as
> CONFIG_FS_VERITY=y, and either CONFIG_EXT4_FS, CONFIG_F2FS_FS, or
> CONFIG_BTRFS_FS is enabled too).  The amount is also quadrupled on systems that
> use a 16K page size, which will become increasingly common in the future.
> 
> It may be that part of your intention for pushing back against this optimization
> is to encourage filesystems to convert their buffered reads to iomap.  I'm not
> sure it will actually have that effect.  First, it's not clear that it will be
> technically feasible for the filesystems that support compression, btrfs and
> f2fs, to convert their buffered reads to iomap.

I do hope more of that happens some day, even if xfs is too obsolete to
gain those features itself.

>                                                  Second, this sort of thing
> reinforces an impression that iomap is targeted at enterprise systems using XFS,
> and that changes that would be helpful on other types of systems are rejected.

I wouldn't be opposed to iomap_prepare_{filemap,verity}() functions that
client modules could call from their init methods to ensure that
static(ish) resources like the biosets have been activated.  You'd still
waste space in the bss section, but that would be a bit more svelte.

(Says me, who <cough> might some day end up with 64k page kernels
again.)

--D

> - Eric
> 

