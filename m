Return-Path: <linux-fsdevel+bounces-19520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3028C65E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 13:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 773BEB22EAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 11:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2261F7443E;
	Wed, 15 May 2024 11:49:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D05B6EB4D;
	Wed, 15 May 2024 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715773747; cv=none; b=aG/6oFJBKzhiroQCAURY24/ZMifL6sdMEKglrGsmqsp615K84D2q5TmgnYf/9DcRQ4+ufOf3Z+yJ3+5/qicCbQwf6oNzJZX6gG1nC2saWeLqvokFDf3MZM7rAYZV2sQcirG3QIe6NWz98A9r77RQvJDxD+hMUlGFXThegXQpKxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715773747; c=relaxed/simple;
	bh=Fk4iWd0hQbRAsY4uPC6Kc9QaabxZ9cf5EOY8s+xuqXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8KoBMdiY47ZPBP4ScmHe7lq6QwI7aJzChO3BIY0rcAQo9XrVGVrFj8LqdN6BVU5t3QEWBLY54RMrj5kVeoVSVHmtJlKjXl9irmR2FCm6rYT/HGuzmgt/S9D5m0wLkxVZ2McJTZU+6nXkJ5LvqGaKNsGNlz6S1qEmL71QTJmdus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D53C268B05; Wed, 15 May 2024 13:48:50 +0200 (CEST)
Date: Wed, 15 May 2024 13:48:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, hch@lst.de,
	mcgrof@kernel.org, akpm@linux-foundation.org, brauner@kernel.org,
	chandan.babu@oracle.com, david@fromorbit.com, djwong@kernel.org,
	gost.dev@samsung.com, hare@suse.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	ritesh.list@gmail.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <20240515114850.GB1938@lst.de>
References: <20240503095353.3798063-8-mcgrof@kernel.org> <20240507145811.52987-1-kernel@pankajraghav.com> <ZkQG7bdFStBLFv3g@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkQG7bdFStBLFv3g@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 15, 2024 at 01:50:53AM +0100, Matthew Wilcox wrote:
> On Tue, May 07, 2024 at 04:58:12PM +0200, Pankaj Raghav (Samsung) wrote:
> > Instead of looping with ZERO_PAGE, use a huge zero folio to zero pad the
> > block. Fallback to ZERO_PAGE if mm_get_huge_zero_folio() fails.
> 
> So the block people say we're doing this all wrong.  We should be
> issuing a REQ_OP_WRITE_ZEROES bio, and the block layer will take care of
> using the ZERO_PAGE if the hardware doesn't natively support
> WRITE_ZEROES or a DISCARD that zeroes or ...

Not sure who "the block people" are, but while this sounds smart
it actually is a really bad idea.

Think about what we are doing here, we zero parts of a file system
block as part of a direct I/O write operation.  So the amount is
relatively small and it is part of a fast path I/O operation.  It
also will most likely land on the indirection entry on the device.

If you use a write zeroes it will go down a separate slow path in
the device instead of using the highly optimized write path and
slow the whole operation down.  Even worse there are chances that
it will increase write amplification because there are two separate
operations now instead of one merged one (either a block layer or
device merge).

And I'm not sure what "block layer person" still doesn't understand
that discard do not zero data, but maybe we'll need yet another
education campaign there.


