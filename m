Return-Path: <linux-fsdevel+bounces-19246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE988C1D96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 07:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56061F22055
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 05:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC553152782;
	Fri, 10 May 2024 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1hrJDEXn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3370314F9F0;
	Fri, 10 May 2024 05:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715317717; cv=none; b=o37JLShjhxcuihKdxYZa7Cp+hroOokzLOGKXYOxi1U0JA4JOOvIuItr6TmuzI1cULn0hLSiM8SqN/L/IwCYsSAV5futqpdcZkau6PUwXGpp77Z7EdLlkcISGj+nOecb6VU4tQE72LZqqUjvlJZeUXGFSBNTDWGk5KSyOpGughUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715317717; c=relaxed/simple;
	bh=szAzEqHAl3mhrikNq0IrLuuMgLlC1lAZCTc80/t1JcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8Z55RSDs4XEnc27OE0rNJTG3XszsxI7DmyhIQft9QNibmAH1VbdMMcEVV8fy8nB7xbiOQ+fSy0qTF+zxz3tu1epw1P88PYnuNvvSvaxX/PTyB5K+D/5uVNEq/859O+kc6Bz+0kitJB3IuaYaNVlhjxKqCvh8uKdQzWCROPqqAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1hrJDEXn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xq+wQGWTlkCSADrFxu9APfyBr7tzlacKQFJbx7N4YGQ=; b=1hrJDEXnoiph0sbSLFjwp1Rmsv
	Dsuh+SI0C6b9caqQumDp6evPOTeBhBRl0xjpKqfs0xDZzZ3E6TAkN2c06mFDUINY1/ATUJngQDUtL
	/Lfm2RJ3FoQW53hZ0185eKpLUbaSznDVOxCgqXcaouXxPd/TnDzPzH1UaxA9HYVCQy3ehoMagZ/9f
	zaQ3GbbzQhv7KG4RkqiprMUhwppWwP9igDrqS1rTlySNMD0jAmzlOucBXSHmtvcWBd/27U0KJ1jIR
	1LnowI5p4yqPo/0yF0EkFbHFOGRCfQDGDgpawb4QvaM7VUuq7/9pMDDR1VlnnCHcmHLImGiql6Rcv
	7b3jzLUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5IUj-000000043YZ-06jS;
	Fri, 10 May 2024 05:08:33 +0000
Date: Thu, 9 May 2024 22:08:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	ebiggers@kernel.org, linux-xfs@vger.kernel.org, alexl@redhat.com,
	walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <Zj2r0Ewrn-MqNKwc@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680671.957659.2149857258719599236.stgit@frogsfrogsfrogs>
 <ZjHmzBRVc3HcyX7-@infradead.org>
 <ZjHt1pSy4FqGWAB6@infradead.org>
 <20240507212454.GX360919@frogsfrogsfrogs>
 <ZjtmVIST_ujh_ld6@infradead.org>
 <20240508202603.GC360919@frogsfrogsfrogs>
 <ZjxY_LbTOhv1i24m@infradead.org>
 <20240509200250.GQ360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509200250.GQ360919@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 09, 2024 at 01:02:50PM -0700, Darrick J. Wong wrote:
> Thinking about this further, I think building the merkle tree becomes a
> lot more difficult than the current design.  At first I thought of
> reserving a static partition in the attr fork address range, but got
> bogged donw in figuring out how big the static partition has to be.
> 
> Downthread I realized that the maximum size of a merkle tree is actually
> ULONG_MAX blocks, which means that on a 64-bit machine there effectively
> is no limit.

Do we care about using up the limit?  Remember that in ext4/f2fs
the merkle tree is stored in what XFS calls the data fork,
so the file data plus the merkle tree have to fit into the size
limit, be that S64_MAX or lower limit imposed by the page cache.
And besides being the limit imposed by the current most common
implementation (I haven't checked btrfs as the only other one),
that does seem like a pretty reasonable one.

> That led me to the idea of dynamic partitioning, where we find a sparse
> part of the attr fork fileoff range and use that.  That burns a lot less
> address range but means that we cannot elide merkle tree blocks that
> contain entirely hash(zeroes) because elided blocks become sparse holes
> in the attr fork, and xfs_bmap_first_unused can still find those holes.

xfs_bmap_first_unused currently finds them.  It should not as it's
callers are limited to 32-bit addressing.  I'll send a patch to make
that clear. 

> Setting even /that/ aside, how would we allocate/map the range?

IFF we stick to a static range (which I think still make sense),
that range would be statically reserved and should exist if the
VERITY bit is set on the inode, and the size is calculated from
the file size.  If not we'd indeed need to record the mapping
somewhere, and an attr would be the right place.  It still feels
like going down a rabit hole for no obvious benefit to me.


