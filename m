Return-Path: <linux-fsdevel+bounces-71036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E94CB1E5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 05:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 323D2305D65C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 04:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691D12FB0BA;
	Wed, 10 Dec 2025 04:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rPZ2OfC+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCF92DF143;
	Wed, 10 Dec 2025 04:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765340483; cv=none; b=R01V23RQ5474mIC2BEE/9dzbVdgAaqPR1H/6w70GN9RETCMA2yxU2uu8gTnEG8mzvtzA93VaBfFsVGGwHWJlGivDVJXsbRGqiw7kt8CIucQ0VcJW97QiuMVMk84vani9dyGV1LlmT3UQ3KpbOodZcSNI+gHWXll74c/2gOSYotU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765340483; c=relaxed/simple;
	bh=In7ccyOvzgTazr+g3uMHx91uY5Ou8bsCMiKRgi5aQpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE1GYgcJnj0MtwR9FZMVX6Vg1HhQBi691NWvOXUTsWy0gEFIo0F3wNEu/wDWiz+oJOtcOyFxQqcCn36AVXBeTvvA7hSd24IEGeknDjj4npgYgT6cQlejW6ZGU3pXgaZrOQLW25bqDwxyh0sut6xx1+9866lRYq+kCV3TlDukxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rPZ2OfC+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RhZzd4RxFWfCiPBlHMg9tElryfzqqOKywWnzeWQeivw=; b=rPZ2OfC+B2cKXjPp5rn1GZDSNG
	MGHFYaiLOGAn6gsq9LTRpk8x8wK41CYK+qrFGZpJ/DzDLmJ8aw9kWNs1IY/OQXxetjZ6Lcwb2e+8T
	mG7X01YiGDX3twPCwIBc9ivXTtqkLxUB7X8jiD86dfJpPKYxJDRzMlR+tv3koOrtf/YJwwK/IdOy2
	f3Iymp6GwDHR5aEhoUHp75Gg9E2128V9MG0SJxkuVUa/Zs4G3gBVxC8xy7IBUDHzl+mcOQTXqHioE
	vdrpaCV/D4caXWKfNKr1hyYPFx9kqFPfYUag3GHgd2JBVHy7cA+D53y21e4/HY/nha5e4EaHg/2lQ
	Z5T5zAnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTBhQ-0000000CIxd-3jzN;
	Wed, 10 Dec 2025 04:21:12 +0000
Date: Wed, 10 Dec 2025 04:21:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: asmadeus@codewreck.org
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter()
 iovec
Message-ID: <aTj1OIsDmsB0WkLd@casper.infradead.org>
References: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>

On Wed, Dec 10, 2025 at 06:04:23AM +0900, Dominique Martinet via B4 Relay wrote:
> The problem is that iov_iter_get_pages_alloc2() apparently cannot be
> called on folios (as illustrated by the backtrace below), so limit what
> iov we can pin from !iov_iter_is_kvec() to user_backed_iter()
> 
> Full backtrace:
> ```
> [   31.395721][   T62] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x102600
> [   31.395833][   T62] head: order:9 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [   31.395915][   T62] flags: 0x2ffff800000040(head|node=0|zone=2|lastcpupid=0x1ffff)
> [   31.395976][   T62] page_type: f8(unknown)

This _isn't_ a folio.  It's a kmalloc allocation.  It's a very large
kmalloc allocation (something between 1024 * 1024 + 1 and 2048 * 1024
bytes inclusive).  You can _only_ use iov_iter_get_pages_alloc2() with
folios (or other struct pages that have a refcount, but I'm not sure how
many of those there really are; we're removing refcounts from various
types of pages)


