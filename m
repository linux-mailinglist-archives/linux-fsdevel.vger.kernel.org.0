Return-Path: <linux-fsdevel+bounces-61393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13715B57C4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878C9485044
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651093064A4;
	Mon, 15 Sep 2025 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nU9F+PlC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B47B1A316E;
	Mon, 15 Sep 2025 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941432; cv=none; b=RqtcEUZfNidpZoopCuK/HWPY7MQlYwdtI2bDCj/ibAt02FNqCOkS3KX1yRRnM5MKcZjWpQy+FQ4qRVVupcIqZDFR/3PJe92MD2U9iAa5RK1dznqeDe1Moul0212qjblpgU19tdN1OMSX+gYKAhC5QC0sWEZmMnZqiHUoNEcd9v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941432; c=relaxed/simple;
	bh=ICVn07kjtLiDg9UK89ce+K2GDfFxM/zZsLXu6KtGaZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qID7GrM2E8bPQJkJ6jc6EUHizj3bwIufMrl+ZPw4fjH7QyYQFk1A5ajetzweE1+q0LpAXf8i+4QGtwc20XXckILtO/Qhbvfk4jQ/BBatVrZJz6qLxEmcujc/yWdIO58CaamB2zSaIclaOvRvs7BGhJtXFWCCgatb5brDBgaYa4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nU9F+PlC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HecF/V9RIJz47JJ92Q0WH8NZR2yLKdnnccClZz9CwMM=; b=nU9F+PlCB4NHvlRloevMm9huBy
	NPcVaTx208rnn43lGy4pJZkNJo0Cj6tIBgiZ9MuleN4ZTOXHIO7e1u+tJGz1RyeYegSFQ6dXyksEJ
	8pwciMZBLfe2TB3DCbfjj7ClzUFO1LMftR4u4es4hknSiEVumI572pWTlj7DhFAsAZnFvYVBROpop
	eYjiGr+BiGdE+FpkN1eOxoiTPttmg3u7yIxvgm+uh3koonub/rFF1hTuidH3GljkIMTzTHV1vkfID
	Ux7e3yYKQNsr+cEzkh67FPQeiOYKqlW/o0a9NAU2/cKLk8yIcb5JkCyenXGhzf/tocKyK+L9bv+8k
	XpfXhwag==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy8s1-0000000Fcdi-0x0v;
	Mon, 15 Sep 2025 13:03:49 +0000
Date: Mon, 15 Sep 2025 14:03:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: Any way to ensure minimal folio size and alignment for iomap
 based direct IO?
Message-ID: <aMgOtdmxNoYB7_Ye@casper.infradead.org>
References: <9598a140-aa45-4d73-9cd2-0c7ca6e4020a@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9598a140-aa45-4d73-9cd2-0c7ca6e4020a@gmx.com>

On Mon, Sep 15, 2025 at 07:32:53PM +0930, Qu Wenruo wrote:
> - No fs block is allowed to cross (large) folio boundaries
>   This ensure that the btrfs checksum routine needs no multi-shot calls
>   for a single data block, and ensures we can use a lot of
>   bio_advance_iter_single() calls to move to the next block.

That's true for pagecache I/O, yes.

> But things are going crazy for iomap based direct IOs.
> 
> I'm getting the following bio during my local tests, which is using 8K fs
> block size with 4K page size:
> 
> [  130.957366] root=5 inode=2464 logical=15974400 length=8192 index=0
> bv_offset=0 bv_len=4096 is not aligned to 8192
> [  130.957376] i=0 page=0xffff8cc616e96000 offset=0 size=4096
> [  130.961977] i=1 page=0xffff8cc61730e000 offset=0 size=4096
> 
> The bio initially looks fine, the length is 8K, properly aligned.
> 
> But the dump of the bio shows it's not the case, instead of a large folio,
> it's two page sized folios.
> 
> This will not pass the btrfs requirement, but weirdly the alignment check
> for the iov_iter at check_direct_IO() shows no problem.
> 
> But unfortunately I can not find any folio allocation for the direct IO
> routine except the zero_page...
> 
> Any clue on the iomap part, or is the btrfs requirement incompatible with
> iomap in the first place?

It's nothing to do with iomap.  We can't make the assumption that
userspace is using large folios for, eg, anonymous memory.  Or if
the memory is backed by page cache, we can't assume that the file
that's mmaped is on a similarly-aligned block device.

