Return-Path: <linux-fsdevel+bounces-71348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4325ECBE526
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 271F930024E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 14:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CA314B96E;
	Mon, 15 Dec 2025 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q0zXCTJG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFAE3B8D5E;
	Mon, 15 Dec 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809456; cv=none; b=ogBqk1p0S1GfzaY/tuglUEYDh9OXUZuKlXakQ01k3sDhyZI5BCx9/rU+KjJYUifZJSS15JRFYxx4ZZMXTd4wWALKtmEkw0GTeciW4/QzbhFipqQiW6yBfecIw0nMuitVNYG/9hktztfUrTyXKSfgVGGRAOk/uHNyqmET/YGDRCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809456; c=relaxed/simple;
	bh=/qa5s65gU3g1Q4gJa/dljDUWl87YAU2rtIPazQx17kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAp0o6FOLk2xn9pXz35jzzSByL+XRt47QBd6dgquyfxa9lSeh6NCeuvCBlEDiHFAKzIpypYRMsYL1ohEL6DO+K1wge92sArOJOzsFw0yD47wFHtdBfFfq41J0lmRwVULmVH2KGyiPvKJFehmGsb0sxFAqaG82O/BqCXKIOsWEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q0zXCTJG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GL+t1YP5Sq1fjsltWXMjIWkUSofjmPUmHoVyBGu/NzU=; b=Q0zXCTJGUBTpmj7QVRb7pb9/PF
	nCdmn1RvTIEinpSgDQ6jHJV2czMl0ToxHaEDZQVTTY9B2YoqqCb8dnTPROfHM0buxH2mY/71qAkbP
	ME+6cC4KCnOMT+GiiROyPbh/r5CUKKhpIQUZDmTvQix8CnhQb3+jBgGM7SXz3mi1djUADkkm5X78o
	Ac9tt4BmJBDmE8zD/NVqGbixmETmYYBEcQn4F1HZ45DytFxfXKV+KQKH3jtkf6qUzwBUk0lvLpEpO
	39txek78yC8C31LZ7NzNrICrlYUi0NBhyBroGkfO591MaIo+d1su/AyEKoQZ5zRZw9ZSarxQMGcqQ
	q4aiGbHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV9hb-00000003oUx-0ETP;
	Mon, 15 Dec 2025 14:37:31 +0000
Date: Mon, 15 Dec 2025 06:37:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter()
 iovec
Message-ID: <aUAdKxcC7195Od5N@infradead.org>
References: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
 <aTkNbptI5stvpBPn@infradead.org>
 <aTkjWsOyDzXq_bLv@codewreck.org>
 <aTkwKbnXvUZs4UU9@infradead.org>
 <aT1qEmxcOjuJEZH9@codewreck.org>
 <aT-iwMpOfSoRzkTF@infradead.org>
 <aT-59HURCGPDUJnZ@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aT-59HURCGPDUJnZ@codewreck.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 15, 2025 at 04:34:12PM +0900, Dominique Martinet wrote:
> Christoph Hellwig wrote on Sun, Dec 14, 2025 at 09:55:12PM -0800:
> > > Ok, I don't understand why the current code locks everything down and
> > > wants to use a single scatterlist shared for the whole channel (and
> > > capped to 128 pages?), it should only need to lock around the
> > > virtqueue_add_sg() call, I'll need to play with that some more.
> > 
> > What do you mean with "lock down"?
> 
> Just the odd (to me) use of the chan->lock around basically all of
> p9_virtio_request() and most of p9_virtio_zc_request() -- I'm not pretty
> sure this was just the author trying to avoid an allocation by recycling
> the chan->sg array around though, so ignore this.

Oh, ok.  This seems unrelated to the handling of the iov_iters and
I'm sorry that I don't really know anything about that part.

> 
> > > Looking at other virtio drivers I could probably use a sg_table and
> > > have extract_iter_to_sg() do all the work for us...
> > 
> > Looking at the code I'm actually really confused.  Both because I
> > actually though we were talking about the 9fs direct I/O code, but
> > that has actually been removed / converted to netfs a long time ago.
> >
> > But even more so what the net/9p code is actually doing..  How do
> > we even end up with user addresses here at all?
> 
> FWIW I tried logging and saw ITER_BVEC, ITER_KVEC and ITER_FOLIOQ --
> O_DIRECT writes are seen as BVEC so I guess it's not as direct as I
> expected them to be -- that code could very well be leftovers from
> the switch to iov_iter back in 2015...

Oh right, I think this from Dave's netfs_extract_user_iter.

> (waiting for David's answer here, but as far as I see the contract
> between the transport and the vfs is that the transport should handle
> whatever it's being fed, so it doesn't really matter if it's a bio_vec
> or an iov_iter -- ultimately virtio or whatever backend that wants to
> handle zc likely won't handle bio_vec any better so it'll need
> converting anyway)

Yeah.  Looking at what the code does with the pages, I think all this
should go away in favor of using extract_iter_to_sg and build the
scatterlists directly from the iters, without an extra page indirection.

(and of course one day virtio should migrate away from scatterlists,
but that's for another time).

