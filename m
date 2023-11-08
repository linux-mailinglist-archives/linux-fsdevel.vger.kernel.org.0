Return-Path: <linux-fsdevel+bounces-2396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE497E59EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 16:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37B801C20B4F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 15:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6503B3033F;
	Wed,  8 Nov 2023 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CI8K5UMU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAABD2592
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 15:23:04 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451AA1BF7
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 07:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZVwMMyCFylHELVoPXodIP6DHhsCSoTREusviqH4gvQE=; b=CI8K5UMUXZE+tGLSBIvqzrBUJo
	YuJJ9liNc1A9+NVevcF6zgoeM9dY+9B72xzNUiWaLPnZqdy/PX4eWD1ApnJS8crdgNJvmmxvRzHBZ
	ITKCtgm1kCM8HFKHuzvWMxtaJwEzndCoji5F2BtwgA3coSsWsmEwTKCD0499ujVl8SBHWQS77yml1
	s8FtV4kcFFoDsRDYmwHHvVPqD76il7K7IVLenNh8GXZO3jWvjEkK782DJWI1TuCKiQzG0qDIb7k+I
	STBzpsb6XKj2fgCAPgnpcsTH3YFh2wBHBkvFS9ji574bU9YvvlNQTA/vVflRYLZgz02jbfunw+pqA
	o5bubFGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0kOL-001kiU-57; Wed, 08 Nov 2023 15:22:53 +0000
Date: Wed, 8 Nov 2023 15:22:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] buffer: Calculate block number inside
 folio_init_buffers()
Message-ID: <ZUunzZEeZm5xu+qv@casper.infradead.org>
References: <20231107194152.3374087-1-willy@infradead.org>
 <20231107194152.3374087-3-willy@infradead.org>
 <CGME20231108145953eucas1p2eeaf54e93c10cbf501a43f594e23438a@eucas1p2.samsung.com>
 <20231108145951.a7o3uld7nd5icslf@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108145951.a7o3uld7nd5icslf@localhost>

On Wed, Nov 08, 2023 at 03:59:51PM +0100, Pankaj Raghav wrote:
> On Tue, Nov 07, 2023 at 07:41:49PM +0000, Matthew Wilcox (Oracle) wrote:
> > The calculation of block from index doesn't work for devices with a block
> > size larger than PAGE_SIZE as we end up shifting by a negative number.
> > Instead, calculate the number of the first block from the folio's
> > position in the block device.  We no longer need to pass sizebits to
> > grow_dev_folio().
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Not totally related to the patch but even though the variable "block"
> is sector_t type, but it represents the block number in logical block
> size unit of the device? My mind directly went to sector_t being 512
> bytes blocks.

Yes; it's confusing.  buffer_heads are always created for the logical
block size that the filesystem mounted on the device needs.  It's
never for the fixed-size 512 byte sectors (but might happen to be
512 bytes if that's what the fs has set the block device to).

> But the math checks out.
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

Thanks!

