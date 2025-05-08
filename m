Return-Path: <linux-fsdevel+bounces-48477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20307AAFA8D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 14:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B9A1899496
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 12:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12D622A4FD;
	Thu,  8 May 2025 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rksiu0jY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E620C477;
	Thu,  8 May 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746708788; cv=none; b=BkahYy9XBWfLByHmaIfPlndCDLEw9/HGDJ4gGZhw/qTcYzmIC3F5m1oYCI4/cc6KxLLCfO5OkPsKP4ib315DtAGxjXYA4x5ryhmwlMbP5XpqcPNIQKld0q1g8FtYB/YMBlZFljVuCXsOyR/kUQws2SVNwlVt2WPEdrvKLyMhObs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746708788; c=relaxed/simple;
	bh=+OKsmWIqirjLNLgB/OYgCox2giTsrvgb9T9Fw9gcsb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVfj6Jo61vhWh6XyM87zKhADxWD+nHOZqo95/oFg4hsAXH2yI+vFWvfEUBqko5dLiwBIKtO/CWF0+fvrrEIiht1lwSkiC/pN4dD7kZ+xDpfMN9yCtWKKPhHO3RyzpO7pzhPKY754+eZcaom3jSh+ItlX1PYGlRzMxx1SYdmxkbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rksiu0jY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sXoi1TJFyjujTc+R9sDMTKQcOlnSzSlkhjvJHe++WoE=; b=Rksiu0jYbK/kyu9WBhj1U8uRIr
	Hbg7hQOIJyghpic1Pu0xqwRyNRLN5ddzJKn1WebxVtuURQooQecIBTNOlBUgHJD+8fw/VNFcHGrlC
	ROC0wEQsNw1P8/wr+QzblVBip28zJFoPX4Fl+AZoxIQnESbByvXfG90d7+I0jXbv6uQ0cJgELkN0I
	WWOSz7P8ZfaMim5ZcY8GQKipIGPu/9KVsP6TzFzXcunTFpDjS9f3a0ZnPPnvuhj+s6817ynS9DLIh
	qC8kPSk0DFsuAfQFSnR1aoiYC5+yU68Pta7RdEtlvpzYxKrscUppRR148A6ys4iYFv+sqhfnW40mZ
	/BlITmyA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD0kF-00000000WaK-1eHN;
	Thu, 08 May 2025 12:52:59 +0000
Date: Thu, 8 May 2025 13:52:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 02/19] block: add a bdev_rw_virt helper
Message-ID: <aBypK_nunRy92bi5@casper.infradead.org>
References: <20250507120451.4000627-1-hch@lst.de>
 <20250507120451.4000627-3-hch@lst.de>
 <a789a0bd-3eaf-46de-9349-f19a3712a37c@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a789a0bd-3eaf-46de-9349-f19a3712a37c@kernel.dk>

On Wed, May 07, 2025 at 08:01:52AM -0600, Jens Axboe wrote:
> On 5/7/25 6:04 AM, Christoph Hellwig wrote:
> > +int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
> > +		size_t len, enum req_op op)
> 
> I applied the series, but did notice a lot of these - I know some parts
> like to use the 2-tab approach, but I still very much like to line these
> up. Just a style note for future patches, let's please have it remain
> consistent and not drift towards that.

The problem with "line it up" is that if we want to make it return
void or add __must_check to it or ... then we either have to reindent
(and possibly reflow) all trailing lines which makes the patch review
harder than it needs to be.  Or the trailing arguments then don't line
up the paren, getting to the situation we don't want.

I can't wait until we're using rust and the argument goes away because
it's just "whatever rustfmt says".

