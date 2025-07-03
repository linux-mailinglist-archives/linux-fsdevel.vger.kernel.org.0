Return-Path: <linux-fsdevel+bounces-53798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1F8AF74F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 15:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 783077B1B95
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 13:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456292E62DD;
	Thu,  3 Jul 2025 13:05:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4B3B67A;
	Thu,  3 Jul 2025 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751547909; cv=none; b=Ri34tCURjfz9Y6n8G74NuP1PtNhJ3r8tDVJ59PLzizJUVv5mKxAKGy8MrN51QGJs0xMG8xYVNA19wPsazcXC2B2hB0SuHEyY9mmqUk8XQ8Ol382PZkkbbQ43Jaqy9m+mcScZXL6t4s3kIE0fJ7+qBTyOu11x2/TUOLRzVGoa3M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751547909; c=relaxed/simple;
	bh=riu/oMZ4j8xMs0NKvk5hrwihCj5mHKuM//UsRwhQRF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1XaJB8wf5Vk4koNXB6HhVv+Ko0YcnvvY9FwLvNW6yCeJrh6L6gXoRxIfDiIoFObuk11NzBg5aLwio/zmF964PmuQokKSL8ZcevYZCdKjv/MAIdQgmvw1yGyoc3Ihp7jqWX3hsF2xmtmDydfBktsmQYfbvx9CEcJIOH96l1spaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5035468BFE; Thu,  3 Jul 2025 15:05:00 +0200 (CEST)
Date: Thu, 3 Jul 2025 15:05:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Kundan Kumar <kundanthebest@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org,
	chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, willy@infradead.org,
	mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de,
	ritesh.list@gmail.com, dave@stgolabs.net, p.raghav@samsung.com,
	da.gomez@samsung.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
Message-ID: <20250703130500.GA23864@lst.de>
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com> <20250529111504.89912-1-kundan.kumar@samsung.com> <20250529203708.9afe27783b218ad2d2babb0c@linux-foundation.org> <CALYkqXqs+mw3sqJg5X2K4wn8uo8dnr4uU0jcnnSTbKK9F4AiBA@mail.gmail.com> <20250702184312.GC9991@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702184312.GC9991@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 02, 2025 at 11:43:12AM -0700, Darrick J. Wong wrote:
> > On a spinning disk, random IO bandwidth remains unchanged, while sequential
> > IO performance declines. However, setting nr_wb_ctx = 1 via configurable
> > writeback(planned in next version) eliminates the decline.
> > 
> > echo 1 > /sys/class/bdi/8:16/nwritebacks
> > 
> > We can fetch the device queue's rotational property and allocate BDI with
> > nr_wb_ctx = 1 for rotational disks. Hope this is a viable solution for
> > spinning disks?
> 
> Sounds good to me, spinning rust isn't known for iops.
> 
> Though: What about a raid0 of spinning rust?  Do you see the same
> declines for sequential IO?

Well, even for a raid0 multiple I/O streams will degrade performance
on a disk.  Of course many real life workloads will have multiple
I/O streams anyway.

I think the important part is to have:

 a) sane defaults
 b) an easy way for the file system and/or user to override the default

For a) a single thread for rotational is a good default.  For file system
that driver multiple spindles independently or do compression multiple
threads might still make sense.

For b) one big issue is that right now the whole writeback handling is
per-bdi and not per superblock.  So maybe the first step needs to be
to move the writeback to the superblock instead of bdi?  If someone
uses partitions and multiple file systems on spinning rusts these
days reducing the number of writeback threads isn't really going to
save their day either.


