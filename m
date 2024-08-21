Return-Path: <linux-fsdevel+bounces-26465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87856959B2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 14:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9742FB22328
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 11:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF91178395;
	Wed, 21 Aug 2024 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="soGsd5Za"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FFD1B3B33
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 11:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724240652; cv=none; b=nHYPrx2ohnmaUmjtLBsUv2j8axMxyYYXZBQsCqrwuU5W9r1Kn6XsGGhDlmNe9hIruuTh00IsUKVDxTcpC9ti3bQAz6uboiuh/8d1ztYgOIjfzmqnsykcQ0LrxO6YOYxsuY7y52zgXgHk9v2A6Gw4TLzPoi91/oQ3N+5vNitEX8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724240652; c=relaxed/simple;
	bh=loir6ub4Jgl9EL63HTjD5sof3Gk9J8WuwpAwu6fgMY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk5vySOqc2aiwwCxTVPdqkILtwfB/sNfmb2LBlpPUfIlYFaMstDBiCTKT50u1kcw6xuQpxNFuXQb0qIC1xTZYlXIVgjRbCU8gOa4VgxTnKng9e3Eh6UmOyPJnItYL9Fdm4gSP2g9rjjL7LO2ERv5yt9aZKpsMh+AaSwoOzEmZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=soGsd5Za; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G1NccRhi7/UxbXUXfvO5IP+/hVG27t4u56SnhsRtCy0=; b=soGsd5ZaLfm9FSjnB5aMi6/WkQ
	pmMFWUo3lKcBJ32X09BwZxVo3CgANfs7wcJpX76m/O/zeG/UzM/QmZ9O2L0pKtzpApQhjbdDkF/8v
	GafDVUCF78szYZKI+TX/4hoXcqy5fNWPP+wopOIJrgxzwiNwzD+YbtsliXgKyh74hz64EasnV5KHU
	KI0xi0d29eYXuO+jpRSr5viNXLoDLU/PnUpl0H1lZdUvSV/L/EhWO1yJOM531hSyaG8PgPJO9Sww4
	g0NAdYLOziuKOMFUZrBEz835bEbVZJEd875YLK9kw/h0/5mpNydLyWs4V5hDK0EVHsw8O5bnaf/lK
	7i5rQnoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgjkx-00000008kj6-1UZH;
	Wed, 21 Aug 2024 11:44:03 +0000
Date: Wed, 21 Aug 2024 04:44:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, david@fromorbit.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] mm: document risk of PF_MEMALLOC_NORECLAIM
Message-ID: <ZsXTA_dOKxmLcOev@infradead.org>
References: <Zrxfy-F1ZkvQdhNR@tiehlicka>
 <CALOAHbCLPLpi39-HVVJvUj=qVcNFcQz=3cd95wFpKZzUntCtdw@mail.gmail.com>
 <ZrymePQHzTHaUIch@tiehlicka>
 <CALOAHbDw5_hFGsQGYpmaW2KPXi8TxnxPQg4z7G3GCyuJWWywpQ@mail.gmail.com>
 <Zr2eiFOT--CV5YsR@tiehlicka>
 <CALOAHbCnWDPnErCDOWaPo6vc__G56wzmX-j=bGrwAx6J26DgJg@mail.gmail.com>
 <Zr2liCOFDqPiNk6_@tiehlicka>
 <Zr8LMv89fkfpmBlO@tiehlicka>
 <Zr8MTWiz6ULsZ-tD@infradead.org>
 <Zr8TzTJc-0lDOIWF@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr8TzTJc-0lDOIWF@tiehlicka>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 16, 2024 at 10:54:37AM +0200, Michal Hocko wrote:
> Yes, I think we should kill it before it spreads even more but I would
> not like to make the existing user just broken. I have zero visibility
> and understanding of the bcachefs code but from a quick look at __bch2_new_inode
> it shouldn't be really terribly hard to push GFP_NOWAIT flag there
> directly. >

I don't understand that sentence.  You're adding the gfp_t argument to
it, which to mean counts as pushing it there directly.


> It would require inode_init_always_gfp variant as well (to not
> touch all existing callers that do not have any locking requirements but
> I do not see any other nested allocations.

inode_init_always only has 4 callers, so I'd just add the gfp_t
argument.  Otherwise this looks good modulo the fix your posted:

Acked-by: Christoph Hellwig <hch@lst.de>


