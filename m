Return-Path: <linux-fsdevel+bounces-74244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3167D388F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 22:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC5493013999
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 21:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E2A30B506;
	Fri, 16 Jan 2026 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lX+hDrhm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E638246778;
	Fri, 16 Jan 2026 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600331; cv=none; b=FmRpZROLOAxt4VmFxeBc08WIrAY+GpHhDHWxY6/mPIs2FaVdyEy9Y1ugDycp7LHxQ4g6VNa5vk/o1LMZiz2yDLzrlD7Ymw68K38VkTAOY/kJXmD6jKOyjBM+jjdh7WrjNYt+p2esSBFbXtxN/Q9CJyggE6ZJeegIue2P9VwgAC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600331; c=relaxed/simple;
	bh=8h3QxMODzy+mufmZR78WB1ljv+J8HT2qr17zgu8bbUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofCutfW3XjRAegPm3pCxgez9PzVOp0dscs/mOdxpeM6pA6uNYSJ44+5ejSYsnhVPihkEZwC3TLqmKRDOnSFMyHPUth0adtiecjHp/2/ozgk5gw7Q2HZyCCRy/4xzOWQh67kQCFrnfEMOinT8EW5t6e3Y+FkiTFUqO0e2Gk4W+Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lX+hDrhm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sO6CuLE2UcmPyAhaQw75xpslUY+1xUQo3AbRBzOid4Q=; b=lX+hDrhmUakvkXozmzSSlYRsS2
	wu1OcECO80YjXoI9xrnOU76tIh1g8JajOiGVWkxmxOPhIolOR+U/tUtZtU5x0ePJS7vT3BWeS16NV
	l8Gvl+P2Q3xsGwOL1M2WUFlVCFhGgb1iVD7oaBnT49zSbkELni1NGKU8oiZ1icLdtA8Gm2RlYC0b9
	G/puvQxAlm15V5ubxLgCjgcMtEAvnDjhUTA+0+AIIYRImiOav5JS88OQpn+anq8a5o6vnDDc3VmU8
	RTYj0zxxRZmqf+EBJYhfiUKvk3sXDFHHendCjarFTL63kVoAz2jol+z/dzq6q0lCe2jcaI63vH8QE
	z08+V/+A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgrjj-00000009vGZ-1tXd;
	Fri, 16 Jan 2026 21:52:07 +0000
Date: Fri, 16 Jan 2026 21:52:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, djwong@kernel.org, david@fromorbit.com,
	hch@lst.de
Subject: Re: [PATCH v2 3/22] iomap: introduce IOMAP_F_BEYOND_EOF
Message-ID: <aWqzB1K-iGrFwOIc@casper.infradead.org>
References: <cover.1768229271.patch-series@thinky>
 <d5fc72ldfwyzbgiypzlhn5diiqyijxaicpa3w6obx4iismuko3@kttpcgqjy6i5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5fc72ldfwyzbgiypzlhn5diiqyijxaicpa3w6obx4iismuko3@kttpcgqjy6i5>

On Mon, Jan 12, 2026 at 03:50:05PM +0100, Andrey Albershteyn wrote:
> Flag to indicate to iomap that read/write is happening beyond EOF and no
> isize checks/update is needed.

Darrick and I talked to Ted about this yesterday, and we think you don't
need the writeback portions of this.  (As Darrick said, it's hard to
tell if this is all writeback or just some of it).

The flow for creating a verity file should be:

write data to pagecache
calculate merkle tree data, write it to pagecache
write_and_wait the entire file
do verity magic

If you follow this flow, there's never a need to do writeback past EOF.
Or indeed writeback on a verity file at all, since it's now immutable.


