Return-Path: <linux-fsdevel+bounces-72440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F683CF7170
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 08:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D926B30478D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0DB3093B2;
	Tue,  6 Jan 2026 07:39:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4D5307AC6;
	Tue,  6 Jan 2026 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767685170; cv=none; b=kctL4pnSvdbexMlKttyv0JqY2hJJBbfGT5j2tCjmJdRrr3XrZVBJninrfUhdMGrB/+fxWp4OeZqNjKc96HzQwRvJ47GBV+IFgEBC7lJbRJQe+rxtqkXUUZOBPhBJE+0S2HNMBIKO1GvK3ZPsW08yY7tb1shNNf6Sqqlk19JcXTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767685170; c=relaxed/simple;
	bh=N2S9ZgFWUmhPx6ZiQF3h6z4xcgg+0RJuSDOOHUoQX/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2ximxrbRrIHJeG3926hwidoT2FMhHI+E1YLcRwlIo5l1BwY568TPiT6kGV+zT99MKBAwrovxcKcBX+A62v0tC68/MJXtqn0fdkHnfqkBusWQ7mYP0Usp8ykVgQuM9aFI7tht8vSe0PhgTUWaaXbn1S8n3Rt+LaKLCeFcJgOcFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E01636732A; Tue,  6 Jan 2026 08:39:24 +0100 (CET)
Date: Tue, 6 Jan 2026 08:39:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 7/9] blk-crypto: use mempool_alloc_bulk for encrypted
 bio page allocation
Message-ID: <20260106073924.GA18847@lst.de>
References: <20251217060740.923397-1-hch@lst.de> <20251217060740.923397-8-hch@lst.de> <20251219200244.GE1602@sol> <20251222221840.GA17565@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222221840.GA17565@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 22, 2025 at 11:18:40PM +0100, Christoph Hellwig wrote:
> That will now leak the pages that were successfully added to the bio.
> 
> I end up with a version that just adds the pages to the bio even
> on failure.  I've pushed the branch here:
> 
> https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/blk-crypto-fallback
> 
> but I plan to come up with error injection to actually test this
> patch given the amount of trouble it caused.

I've done a bit of manual testing on the new version only for now.
Keith has been looking into proper testing of unaligned dio vectors for
blktests and xfstests, and once that gets resent I plan to use that
framework to test for error handling of unaligned I/O to formalize this
testing.


