Return-Path: <linux-fsdevel+bounces-64340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EE0BE171E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 06:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E06C84E57F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 04:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0FF216605;
	Thu, 16 Oct 2025 04:40:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836D6DDD2;
	Thu, 16 Oct 2025 04:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760589605; cv=none; b=uY90msAiFXSsZ3AOTvWID1gfYKTKmfI6wku6j/OcWUP2bBb3a3yIb1adF0U9XayN9etYrq/spz/xu6OWr1Rtfi8SYc5AJAjB3HzcuVN8trvYfpAkJrlR8oNcLOIm2BJ70QCbPMzG/7vHi8bOljDAj0N2vTEQC5vsAo62azmMeFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760589605; c=relaxed/simple;
	bh=B2dmelacR9KDdjcvdVHbE8VVaP1pY5MFfMjNVGaoa18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6iTeTtvGXYOvJhArYWTsw3va4ByvnDw+R6crBGJFviBelDi8FAHW+9OHw5G0DMQ+fM/7IQxq1tTl9Tl/VYlG6pYrCvBC0u+/A4TlSEpMtQXVfJVqDN4sNh0fKdycqglIPWbiMTSphetV+/VPlv/LFLj6OtnaNc7+liUvdepHdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 66F11227A87; Thu, 16 Oct 2025 06:39:59 +0200 (CEST)
Date: Thu, 16 Oct 2025 06:39:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	dlemoal@kernel.org, hans.holmberg@wdc.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] writeback: allow the file system to override
 MIN_WRITEBACK_PAGES
Message-ID: <20251016043958.GC29905@lst.de>
References: <20251015062728.60104-1-hch@lst.de> <20251015062728.60104-3-hch@lst.de> <aPAI0C23NqiON4Uv@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPAI0C23NqiON4Uv@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 16, 2025 at 07:49:20AM +1100, Dave Chinner wrote:
> On Wed, Oct 15, 2025 at 03:27:15PM +0900, Christoph Hellwig wrote:
> > The relatively low minimal writeback size of 4MiB leads means that
> > written back inodes on rotational media are switched a lot.  Besides
> > introducing additional seeks, this also can lead to extreme file
> > fragmentation on zoned devices when a lot of files are cached relative
> > to the available writeback bandwidth.
> > 
> > Add a superblock field that allows the file system to override the
> > default size.
> 
> Hmmm - won't changing this for the zoned rtdev also change behaviour
> for writeback on the data device?  i.e. upping the minimum for the
> normal data device on XFS will mean writeback bandwidth sharing is a
> lot less "fair" and higher latency when we have a mix of different
> file sizes than it currently is...

In theory it is.  In practice with a zoned file system the main device
is:

  a) typically only used for metadata
  b) a fast SSD when not actually on the same device

So I think these concerns are valid, but not really worth replacing the
simple superblock field with a method to query the value.  But I'll write
a comment documenting these assumptions as that is useful for future
readers of the code.

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
---end quoted text---

