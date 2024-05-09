Return-Path: <linux-fsdevel+bounces-19150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F98F8C0ABF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 07:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9991F23E6F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 05:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC53914900E;
	Thu,  9 May 2024 05:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0NeAc5+4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8A610E5;
	Thu,  9 May 2024 05:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715230975; cv=none; b=G1Wy2YrsZaLzDJVc20zl2IYTYSkWXwJ7ZUta7qnwmb0FTCRvC0jvjLZCOQStvd286cJ4FKJFv6RQxjZYmRzm2fUJ14n2z79/+TSXmPh+hvxczYJcgljKJf1lIQX6bXoSasHAoBF2wPgXEAkbWg9S0bEltMhIa0WtC1QARf5fLdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715230975; c=relaxed/simple;
	bh=Bo7YPrimVLRfu0RC5aBuLe6PQOQORrbE7QsqDdRA97A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBcwk4TIkSHWSrn3nsuFn00jj9qW6WmCTeVp8heltpApIoQ57IcPXH/6uh/yQ5xDog4ZxE73IpOWsuxvOLHEMoIIb9bosLYlyzo1GeOOpy6w9v8J5f/1z7kzvvharLWFUX1mdYkfFxAw8TNPySOYUAOoSYqGbHZK7ltOA9at/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0NeAc5+4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sIgpUHQJOxrME09BWK1JmkXjNqGRuCrBRP23P5hGmCI=; b=0NeAc5+4JrlPuTchzUKezLX7xZ
	G1ocSP9t58+IEef/fppdusIWDlMf5oJa3lkY7lQglKl/k3u8zKzS6+LRzydu1jO/vGJ59Y4SkjBAS
	GlrsyOPHQ3CCwwtv7Y1hWqL/g8vsrouWKUn4VtQe5HdPK0rYoSUNtDWFW6BmhEX0QPJKuNbmIB8vD
	pnbRpT/F+DxPp7GG+v4RSYMbh89B5Y3KpGtDhSh3CNYtJRZkR+N77ZzvUGiCpR2E7J3F/4GJtoVue
	djpbbhO1UAHcCBLvkEnED7l1X4MQDJYWtbOBE4UgxLyrz5t4BU7HLZrNCIXkpU5zxIuZ8C0N8tzCf
	5s1tpJNw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4vvh-00000000N8d-06ul;
	Thu, 09 May 2024 05:02:53 +0000
Date: Wed, 8 May 2024 22:02:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	ebiggers@kernel.org, linux-xfs@vger.kernel.org, alexl@redhat.com,
	walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <ZjxY_LbTOhv1i24m@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680671.957659.2149857258719599236.stgit@frogsfrogsfrogs>
 <ZjHmzBRVc3HcyX7-@infradead.org>
 <ZjHt1pSy4FqGWAB6@infradead.org>
 <20240507212454.GX360919@frogsfrogsfrogs>
 <ZjtmVIST_ujh_ld6@infradead.org>
 <20240508202603.GC360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508202603.GC360919@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 08, 2024 at 01:26:03PM -0700, Darrick J. Wong wrote:
> I guess we could make it really obvious by allocating range in the
> mapping starting at MAX_FILEOFF and going downwards.  Chances are pretty
> good that with the xattr info growing upwards they're never going to
> meet.

Yes, although I'd avoid taking chances.  More below.

> > Or we decide the space above 2^32 blocks can't be used by attrs,
> > and only by other users with other means of discover.  Say the
> > verify hashes..
> 
> Well right now they can't be used by attrs because xfs_dablk_t isn't big
> enough to fit a larger value.

Yes.

> The dangerous part here is that the code
> silently truncates the outparam of xfs_bmap_first_unused, so I'll fix
> that too.

Well, we should check for that in xfs_attr_rmt_find_hole /
xfs_da_grow_inode_int, totally independent of the fsverity work.
The condition is basically impossible to hit right now, but I'd rather
make sure we do have a solid check.  I'll prepare a patch for it.


