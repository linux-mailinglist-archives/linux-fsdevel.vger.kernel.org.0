Return-Path: <linux-fsdevel+bounces-46017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E58F0A8143F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 20:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F9B4233A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 18:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3330D23E330;
	Tue,  8 Apr 2025 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZTRLlZs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7658B235BF5;
	Tue,  8 Apr 2025 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744135603; cv=none; b=mJDjRH+0pkj2glu40LPnLzsHKcXhbfIiF+MmDujZa9mKG1kw/pJ1C46ensA4ximeNbWUs6HD6Diqmfnc0cZJHXZ1idMcaRJo+RxSQhbGyQ/8Vt3d0jIg3g1xTbZ1JllDxVzuK+/DOD9ho5yNNlrVDHYd6FjZGOCsJzZAk+rnDp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744135603; c=relaxed/simple;
	bh=Tp1KLkGydqnHF26lk/Kt0Weyj/mcdsm8Zy6mmUhq+L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMS19GD98Zl+YHqC5xWOxWA3iw1YW01T5AApIar+87BLEoyu5zCFsNpdg/RBryJe4xpS2nWdZvK6aA5TjTsrze0q32WIad4Uq6kQJ4qX84wAb+DjK5kliq5OcUxyDwmtK5quH0MmIsw/oau7sg5zIvUMdbzfoEgKXxFXFwWkGAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZTRLlZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4529EC4CEE5;
	Tue,  8 Apr 2025 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744135602;
	bh=Tp1KLkGydqnHF26lk/Kt0Weyj/mcdsm8Zy6mmUhq+L8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qZTRLlZsgsR2ikOa/87ONS7coMzrc9mQFK88J/FCDu4fbyg4rMW9QHcYs0EyeojPA
	 p8B9V7aznJ0rCr2wJXhiLnnxpcXNCwhAXxafIFjA3lRZCTjsDLD8nLDe5i+cfymVzC
	 AbrGm890ErR1Jysv/8XD9PVOvKMjI4Uga2lTWuW08MoRdNofGbbSLpg6bstfH1ss1U
	 9wtvy8mePK/+dINHjjT4qdRqwEJClrtoxctv4cAPzd3A4vt5K3OApxB1GLk1Uo62SB
	 bhzDWg3AS7cyKAHBlYSWGtvy0smd656QjTCkiWR+n9s1wjoJ7UrRMLDNCP1H63vfrD
	 Mh2rhPNo0BuOQ==
Date: Tue, 8 Apr 2025 11:06:40 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: David Bueso <dave@stgolabs.net>, Jan Kara <jack@suse.cz>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, Tso Ted <tytso@mit.edu>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Oliver Sang <oliver.sang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <Z_VlsLGTbx9Ub843@bombadil.infradead.org>
References: <20250331074541.gK4N_A2Q@linutronix.de>
 <20250408164307.GK6266@frogsfrogsfrogs>
 <Z_VXpD-d8iC57dBc@bombadil.infradead.org>
 <CAB=NE6X2QztC4OGnJwxRWdeCVEekLBcnFf7JcgV1pKDn6DqhcA@mail.gmail.com>
 <20250408174855.GI6307@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250408174855.GI6307@frogsfrogsfrogs>

On Tue, Apr 08, 2025 at 10:48:55AM -0700, Darrick J. Wong wrote:
> On Tue, Apr 08, 2025 at 10:24:40AM -0700, Luis Chamberlain wrote:
> > On Tue, Apr 8, 2025 at 10:06 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > Fun
> > > puzzle for the community is figuring out *why* oh why did a large folio
> > > end up being used on buffer-heads for your use case *without* an LBS
> > > device (logical block size) being present, as I assume you didn't have
> > > one, ie say a nvme or virtio block device with logical block size  >
> > > PAGE_SIZE. The area in question would trigger on folio migration *only*
> > > if you are migrating large buffer-head folios. We only create those
> > 
> > To be clear, large folios for buffer-heads.
> > > if
> > > you have an LBS device and are leveraging the block device cache or a
> > > filesystem with buffer-heads with LBS (they don't exist yet other than
> > > the block device cache).
> 
> My guess is that udev or something tries to read the disk label in
> response to some uevent (mkfs, mount, unmount, etc), which creates a
> large folio because min_order > 0, and attaches a buffer head.  There's
> a separate crash report that I'll cc you on.

OK so as willy pointed out I buy that for x86_64 *iff* we do already
have opportunistic large folio support for the buffer-head read/write
path. But also, I don't think we enable large folios yet on the block
device cache aops unless we have a min order block device... so what
gives?

  Luis

