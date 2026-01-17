Return-Path: <linux-fsdevel+bounces-74282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB638D38B79
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 03:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CB6330336A1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 02:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8179330F808;
	Sat, 17 Jan 2026 02:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCoLZzWy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC6E26E708;
	Sat, 17 Jan 2026 02:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768615866; cv=none; b=jviz3N2Pn8ZeOgqc5T9vln/y/A4qZgoSSHU5y/5bml6Vwm2GdD+ZBcfkc6vG5zxR5VB9sYxjjfQGFBbtw1vH9FtMI4v+aTTY13d0jsZ+W5nPnb6L8EINVdKoK9p8Qhu3jOygptmmzrPE6poHfyxARJdWesgWPHeZRgi9ogDzznI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768615866; c=relaxed/simple;
	bh=P+ycLUtdnNN64P9miVh2+TTXa3WyrSXO7JTXCfPpBbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jt3b00LqwHmgOaQA1mu7n2VRBaUBDyCQrEm6XR0gTVwVyL3i8Fkks77hTSZIrDAhsm2LrBaYhcM49Wlbdoi6nldLSvvZ2qcCvybsYJZL1dtfS5YtqzXqfJNxclJnOeTIy4qaa+D3vZnUauM/6TEMqtC336veesShJHT5eC4xLFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCoLZzWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B58C116C6;
	Sat, 17 Jan 2026 02:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768615865;
	bh=P+ycLUtdnNN64P9miVh2+TTXa3WyrSXO7JTXCfPpBbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uCoLZzWysbjz8+yIaz10SUeCgZy4YumnNe04iRZD8AHWJLyOvAJPwTsx3k9eLY2Ws
	 JwSctNrjZSSgvbDfsSEIAAaUap92UM2kgflC6GD65XgnAMYpxH0KsWH+s8Vv3fCozR
	 Wj4en0PuIpFC71UcWt7YJti/j33375ThCxXh9Qtj9oMml4b3oCyiT2Pj7LSPoCDBMD
	 P2SEl6MoUSPgB3on86pRB1J86Eof6/DOHLschD0tSSjhjms8tpZHUjN33VUVK6aafW
	 LVp3LzFgVEwz8A4UO4FKVZruftaQxCzuXGvgOFuALEAlETOkYqPlPESy+nnayHJGBN
	 GC7HN2qzlhK3Q==
Date: Fri, 16 Jan 2026 18:11:05 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 3/22] iomap: introduce IOMAP_F_BEYOND_EOF
Message-ID: <20260117021105.GY15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <d5fc72ldfwyzbgiypzlhn5diiqyijxaicpa3w6obx4iismuko3@kttpcgqjy6i5>
 <aWqzB1K-iGrFwOIc@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWqzB1K-iGrFwOIc@casper.infradead.org>

On Fri, Jan 16, 2026 at 09:52:07PM +0000, Matthew Wilcox wrote:
> On Mon, Jan 12, 2026 at 03:50:05PM +0100, Andrey Albershteyn wrote:
> > Flag to indicate to iomap that read/write is happening beyond EOF and no
> > isize checks/update is needed.
> 
> Darrick and I talked to Ted about this yesterday, and we think you don't
> need the writeback portions of this.  (As Darrick said, it's hard to
> tell if this is all writeback or just some of it).
> 
> The flow for creating a verity file should be:
> 
> write data to pagecache
> calculate merkle tree data, write it to pagecache
> write_and_wait the entire file
> do verity magic
> 
> If you follow this flow, there's never a need to do writeback past EOF.
> Or indeed writeback on a verity file at all, since it's now immutable.

Hrmm, I came to rather opposite conclusions -- if you're going to write
the fsverity metadata via the pagecache then you *do* have to fix iomap
writeback to deal with post-EOF data correctly.  Right now it just
ignores everything beyond isize, and I think the xfs side of things will
still do things like try to update the ondisk size in the ioend.

I think hch or someone said that maybe those writes could be directio,
though using the pagecache for verity setup means it's all incore and
ready to go when the ioctl returns.

OTOH it would be convenient to preallocate unwritten extents for the
merkle tree, write it with directio, and now if isize ever gets
corrupted such that userspace actually /can/ read the merkle tree data,
they'll at least see zeroes.  Though I think there's an ioctl that lets
you do that anyway.

--D

