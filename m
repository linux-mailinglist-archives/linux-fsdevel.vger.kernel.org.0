Return-Path: <linux-fsdevel+bounces-66483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BFAC20A0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 15:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9007D1A6230A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 14:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68611274B40;
	Thu, 30 Oct 2025 14:33:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EDC1DDC2C;
	Thu, 30 Oct 2025 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834813; cv=none; b=PZhx/Q/ux1/Xq7kKWBfjcK69YSbIOi7oHBBx3n5zrSnkKH14UGudoMQCYSUT2b2sNjUt4CuSnO4hjcR0VzRjj91zPE6WizXbjIuQQiXU45UgeOy4n8GJLVPStYy9dQJudUHy4yumcyeQ9PJ5HS7N3H9vposSWHhNVtBXihpJNdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834813; c=relaxed/simple;
	bh=ExT2RxRHFPo7qmOs4C0UVaeDUgLlKh+axm1xCnP7fkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxsB8bN4ZsDZeP/Ao4j++6yy6mk0A059bzrEsZz/pqtQDu9fqhCY+FziUwb7smQ6kZ4T2RODhT25uCfMxu6uFs+lBT1TtqXAWlXVbuwayNobYfGZcJDyPQ6is6UgFK76/e2DBUfvmqJ/ejpOdY+fAf6GfeyUFGXwkwo/mTNWNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 330D7227A88; Thu, 30 Oct 2025 15:33:25 +0100 (CET)
Date: Thu, 30 Oct 2025 15:33:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <20251030143324.GA31550@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <aQNJ4iQ8vOiBQEW2@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQNJ4iQ8vOiBQEW2@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 30, 2025 at 10:20:02PM +1100, Dave Chinner wrote:
> > use cases, so I'm not exactly happy about.
> 
> How many applications actually have this problem? I've not heard of
> anyone encoutnering such RAID corruption problems on production
> XFS filesystems -ever-, so it cannot be a common thing.

The most common application to hit this is probably the most common
use of O_DIRECT: qemu.  Look up for btrfs errors with PI, caused by
the interaction of checksumming.  Btrfs finally fixed this a short
while ago, and there are reports for other applications a swell.

For RAID you probably won't see too many reports, as with RAID the
problem will only show up as silent corruption long after a rebuild
rebuild happened that made use of the racy data.  With checksums
it is much easier to reproduce and trivially shown by various xfstests.
With increasing storage capacities checksums are becoming more and
more important, and I'm trying to get Linux in general and XFS
specifically to use them well.  Right now I don't think anyone is
using PI with XFS or any Linux file system given the amount of work
I had to put in to make it work well, and how often I see regressions
with it.

> Forcing a performance regression on users, then telling them "you
> need to work around the performance regression" is a pretty horrible
> thing to do in the first place.

I disagree.  Not corruption user data for applications that use the
interface correctly per all documentation is a prime priority.


