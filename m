Return-Path: <linux-fsdevel+bounces-4323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ED27FE859
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 05:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32BCEB20CEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 04:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8281220DC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 04:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e0mvhCUn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD7E10D9;
	Wed, 29 Nov 2023 20:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R/BiU9GWKs+bhwEOjW3vWL3keOlVXNoi9F0ioV7m9Wg=; b=e0mvhCUn3b+hx7UrqkifA389t8
	SfAgzn9y6yKpry58uZ+Ftu3ZSCQxAk6WpX36mk7PNKC/k75vR49aEsyRU2R/1ze3KnY55AR9IOVnK
	pDxpZotrh5T4x1nPbKNIIRlrc4HBG4M9puvbI3qHX7Ckm4gRxfSk94/FUZEw9gXU+siCsPn38UbXm
	8/LvLp5+J3sjZ9wFaSUqLWOHM9nETZPzK7Ou6kWkqOf+5MSsNnDgULSyBCyoDAXdVDEVvWeNtP6eq
	uvHuADHXQlbowLhKiK8tosu1WFfFvM7VyS3f5o+2uW86lCxSA2rRLui6M/iLyNGu7O6USp3EDVoez
	m6vn6kQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r8Ygf-009uOz-2W;
	Thu, 30 Nov 2023 04:30:05 +0000
Date: Wed, 29 Nov 2023 20:30:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <ZWgPzfd8P+F/qQlh@infradead.org>
References: <87msv5r0uq.fsf@doe.com>
 <8734wnj53k.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734wnj53k.fsf@doe.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 30, 2023 at 08:54:31AM +0530, Ritesh Harjani wrote:
> So I took a look at this. Here is what I think -
> So this is useful of-course when we have a large folio. Because
> otherwise it's just one block at a time for each folio. This is not a
> problem once FS buffered-io handling code moves to iomap (because we
> can then enable large folio support to it).

Yes.

> However, this would still require us to pass a folio to ->map_blocks
> call to determine the size of the folio (which I am not saying can't be
> done but just stating my observations here).

XFS currently maps based on the underlyig reservation (delalloc extent)
and not the actual map size.   This works because on-disk extents are
allocated as unwritten extents, and only the actual written part is
the converted.  But if you only want to allocate blocks for the part
actually written you actually need to pass in the dirty range and not
just use the whole folio.  This would be the incremental patch to do
that:

http://git.infradead.org/users/hch/xfs.git/commitdiff/0007893015796ef2ba16bb8b98c4c9fb6e9e6752

But unless your block allocator is very cheap doing what XFS does is
probably going to work much better.

> ...ok so here is the PoC for seq counter check for ext2. Next let me
> try to see if we can lift this up from the FS side to iomap - 

This looks good to me from a very superficial view.  Dave is the expert
on this, though.


