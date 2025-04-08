Return-Path: <linux-fsdevel+bounces-46016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0FAA81437
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 20:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E111B6527E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 18:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD0A23E328;
	Tue,  8 Apr 2025 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ9isBnv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF3722B8D2;
	Tue,  8 Apr 2025 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744135361; cv=none; b=hL4HV0reZiK+yqBAiRpa3n8qvh/wj39LbIXxGQ7ZA6eFAL6ru1sUDKOozE1RGU2sy4b7MUSO8dBEXmYwEhI7oUoXgTV9/wn1gx+YE0zDDMv1kRqvQvX9RlvK5Ca1Bt/ChmGMTYbV7BvYIaaa4VT+Xn+bdPRv5kcmR+mwn/lGi28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744135361; c=relaxed/simple;
	bh=07hatUbfr/QmTsLAp8mRuajmYal+iTkS5lG3koX3sYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3S4VR5BuFPChryh/Rgl9gm32iTKUqI9An7A6rdFe7jeAiAoonvEenb+03d5ykRqSxicGup6HMHwaLYs8piGgL7V3T5hb4zoXxWjrdx0fBRQ8yqpMXFnw6hvlAfRXRUdlXe/VuOgLPRBYtxfr5lThpM1GZMr6Ylj3emJTRg8dPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ9isBnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA02C4CEEA;
	Tue,  8 Apr 2025 18:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744135360;
	bh=07hatUbfr/QmTsLAp8mRuajmYal+iTkS5lG3koX3sYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJ9isBnvY2+6BFEV76kbWaDeok+wm2ofnWbwGUqwgTl2wxqX/BGlrvL8ULraweZPl
	 i+MMspSS9DWV2ks9l5Lx4C4O6Fm33t0cuJzO++P3z49w3gD56+lZKZQpx8luT04Cp2
	 RcWRuhE9VVXE9uoGUhApmz3SqvwdHQuY8ERxxU8UTlG/5vEutUmxTYTaSyowy+pYlj
	 MWR21BXSD6n575rQfnQwae8Gft+3db/7XU/qN+ijRWyt99Cq87tUn4FdaMAehgVQik
	 SWAEtv4mGHyRc7RmQ4gFag7HX/oxBn6eZ8ckFaSZW6q0ii7xTZX3KOn60C9v8CrDLI
	 CgZWrYs4A6XYA==
Date: Tue, 8 Apr 2025 11:02:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, David Bueso <dave@stgolabs.net>,
	Jan Kara <jack@suse.cz>, Kefeng Wang <wangkefeng.wang@huawei.com>,
	Tso Ted <tytso@mit.edu>, Ritesh Harjani <ritesh.list@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Oliver Sang <oliver.sang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, John Garry <john.g.garry@oracle.com>,
	linux-block@vger.kernel.org, ltp@lists.linux.it,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Chinner <david@fromorbit.com>, gost.dev@samsung.com,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [linux-next:master] [block/bdev] 3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <20250408180240.GM6266@frogsfrogsfrogs>
References: <20250331074541.gK4N_A2Q@linutronix.de>
 <20250408164307.GK6266@frogsfrogsfrogs>
 <Z_VXpD-d8iC57dBc@bombadil.infradead.org>
 <CAB=NE6X2QztC4OGnJwxRWdeCVEekLBcnFf7JcgV1pKDn6DqhcA@mail.gmail.com>
 <20250408174855.GI6307@frogsfrogsfrogs>
 <Z_ViElxiCcDNpUW8@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_ViElxiCcDNpUW8@casper.infradead.org>

On Tue, Apr 08, 2025 at 06:51:14PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 08, 2025 at 10:48:55AM -0700, Darrick J. Wong wrote:
> > On Tue, Apr 08, 2025 at 10:24:40AM -0700, Luis Chamberlain wrote:
> > > On Tue, Apr 8, 2025 at 10:06 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > Fun
> > > > puzzle for the community is figuring out *why* oh why did a large folio
> > > > end up being used on buffer-heads for your use case *without* an LBS
> > > > device (logical block size) being present, as I assume you didn't have
> > > > one, ie say a nvme or virtio block device with logical block size  >
> > > > PAGE_SIZE. The area in question would trigger on folio migration *only*
> > > > if you are migrating large buffer-head folios. We only create those
> > > 
> > > To be clear, large folios for buffer-heads.
> > > > if
> > > > you have an LBS device and are leveraging the block device cache or a
> > > > filesystem with buffer-heads with LBS (they don't exist yet other than
> > > > the block device cache).
> > 
> > My guess is that udev or something tries to read the disk label in
> > response to some uevent (mkfs, mount, unmount, etc), which creates a
> > large folio because min_order > 0, and attaches a buffer head.  There's
> > a separate crash report that I'll cc you on.
> 
> But you said:
> 
> > the machine is arm64 with 64k basepages and 4k fsblock size:
> 
> so that shouldn't be using large folios because you should have set the
> order to 0.  Right?  Or did you mis-speak and use a 4K PAGE_SIZE kernel
> with a 64k fsblocksize?

This particular kernel warning is arm64 with 64k base pages and a 4k
fsblock size, and my suspicion is that udev/libblkid are creating the
buffer heads or something weird like that.

On x64 with 4k base pages, xfs/032 creates a filesystem with 64k sector
size and there's an actual kernel crash resulting from a udev worker:
https://lore.kernel.org/linux-fsdevel/20250408175125.GL6266@frogsfrogsfrogs/T/#u

So I didn't misspeak, I just have two problems.  I actually have four
problems, but the others are loop device behavior changes.

--D

