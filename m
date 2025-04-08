Return-Path: <linux-fsdevel+bounces-46004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E17AA8133D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 19:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031611BA34DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 17:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4F22356C2;
	Tue,  8 Apr 2025 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwD72MB+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F941E5219;
	Tue,  8 Apr 2025 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132007; cv=none; b=m2U9J2Ed7sRqCgENXEq12pUSOTc+d+uMtkfOj2MNJm9MwNNliemnHS9uBmzptnFtH7tYstreV1tg2a04314kysfZiGC8bawfhJA7Nzz3ldcRRsyIQX/nJ3JG8snE4T8sXtBQlTXbGpg2hrzp3VWsTVC+H0LRJpdxk5sOESPHHR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132007; c=relaxed/simple;
	bh=/3eBMgubv0Yka0P/WzdDOXB50+TOIWFo5UCsRYv5O6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/mWrtKUyyWOopWPi6JxEN3QMWqxIxjUK9vmINVXOTfeq/pKaQeeQTgJbcF2EGuXOLZmr32VoEtTMKpEqBJMOhcCJNLx1C/9MYuPOZWkGYLQB2lzh4y+hScdX0Xat6OP9Fv9KvKjOUyN9BbJ/WfNKE7/U5i498u45WUePdmm/Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwD72MB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75D0C4CEE5;
	Tue,  8 Apr 2025 17:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744132007;
	bh=/3eBMgubv0Yka0P/WzdDOXB50+TOIWFo5UCsRYv5O6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RwD72MB+BLnSoW4IRomJp7Ix0Bjzj4kV+VhvB0wuUGsxqlzuVsRsQsocnqYiQUwdt
	 +31xpEKLmAjD/rDiUgNxpng4/1mhIqwM0gmMZgoBDuQdFhb3OILdr9wPBtIcwi6WGd
	 KQuiv/YxK6+xoFs1un5HzHmCG5i2X2L/p/USUzcH60z1/4nmmEDKI8gCy+9KbAtjen
	 o83YtH3vHx4ew7p5JAkCmQ0sQvzLVGhyDm7PA6YEc9Xi0HPweYqtgNtcB3RMcVBjd9
	 cdIIlqMXA+tuhAkRqxDvAHIRZ95wXGWoDHFD66LrEThTktBuifVsVEb/82Oo8mKM4D
	 GmfjnfjwmCVCQ==
Date: Tue, 8 Apr 2025 10:06:44 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>, David Bueso <dave@stgolabs.net>
Cc: Jan Kara <jack@suse.cz>, Kefeng Wang <wangkefeng.wang@huawei.com>,
	David Bueso <dave@stgolabs.net>, Tso Ted <tytso@mit.edu>,
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
Subject: Re: [linux-next:master] [block/bdev]  3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <Z_VXpD-d8iC57dBc@bombadil.infradead.org>
References: <20250331074541.gK4N_A2Q@linutronix.de>
 <20250408164307.GK6266@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408164307.GK6266@frogsfrogsfrogs>

On Tue, Apr 08, 2025 at 09:43:07AM -0700, Darrick J. Wong wrote:
> Hi Luis,
> 
> I'm not sure if this is related, but I'm seeing the same "BUG: sleeping
> function called from invalid context at mm/util.c:743" message when
> running fstests on XFS.  Nothing exciting with fstests here other than
> the machine is arm64 with 64k basepages and 4k fsblock size:

How exotic :D

> MKFS_OPTIONS="-m metadir=1,autofsck=1,uquota,gquota,pquota"
> 
> --D
> 
> [18182.889554] run fstests generic/457 at 2025-04-07 23:06:25

Me and Davidlohr have some fixes brewed up now, before we post we just
want to run one more test for metrics on success rate analysis for folio
migration. Other than that, given the exotic nature of your system we'll
Cc you on preliminary patches, in case you can test to see if it also
fixes your issue. It should given your splat is on the buffer-head side
of things! See _buffer_migrate_folio() reference on the splat. Fun
puzzle for the community is figuring out *why* oh why did a large folio
end up being used on buffer-heads for your use case *without* an LBS
device (logical block size) being present, as I assume you didn't have
one, ie say a nvme or virtio block device with logical block size  >
PAGE_SIZE. The area in question would trigger on folio migration *only*
if you are migrating large buffer-head folios. We only create those if
you have an LBS device and are leveragin the block device cache or a
filesystem with buffer-heads with LBS (they don't exist yet other than
the block device cache).

Regardless, the patches we have brewed up should fix this, regardless
of the puzzle described above. We'll cc you for testing before we
post patches to address this.

  Luis

