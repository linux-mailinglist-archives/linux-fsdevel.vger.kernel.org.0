Return-Path: <linux-fsdevel+bounces-62428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23A5B93488
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 22:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7CA447C1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 20:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AB32C21EA;
	Mon, 22 Sep 2025 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tztNpoEm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161D427F010;
	Mon, 22 Sep 2025 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574473; cv=none; b=TP0gq4iDBWQKJknbLrgsPjg0vpym2PyEq6jEfMe11L5HlwKm32bPNdNcGp59G/w64N6xqWrcvx6tEL1mdCx7oR/C4RYiZwRQSeVu+NXJt1aEX428z3lInd1LDK2ib5LgXsiBSCVrfTMJH5kD0eODrhxFNmJvZwi5VJ/x1R0F6WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574473; c=relaxed/simple;
	bh=f7q3TEwD3aLflrFvHhoiDxg46WLWGZSEaW1XQYUf3es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GV8Uvz2nWI8h2xPxLNEJgEcp4zM/KS+Q81l3TNjr8pab7CaMU1g4IPRBgxyynK6PKFh7h8lUUejZp5t6XyP8aVJ2ywv/5M/5MOJQBGV7BoOrfUeF0jE0hW5Sbm9pRQ1en6ilb1I3KwLLlj9E8eDpvJyR0qDweVZYmXZX80wsNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tztNpoEm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2Kl+e3jm0+RGBOpWVoG4L6YDYEHhTABce8AUL7oy7lg=; b=tztNpoEmtG4DENI2VjGo0RC1v7
	VyUgdZe/vaagfGLk9CEJb6x/oJv4VsYPxsanCZxulinF/y5iqC2eN7WaxKpqOpLgFY0oIFe2xFVj+
	I9jnWAgLpsFWtWn9txq/I83D52MNruVUzadOqtymPwxdWf5sDxFaklzRpvKsJ1LYucnCnF0oNBAKv
	jkhNOpyK6Roz70zH+DBrXqMetkCU1a+aIatiyuDcHR6aCBs0P/3r3KZHdTboubMomVEzucf4GeiZo
	Kt1cmHU27oaoEWXmC8v/p+md4sb+7mZw2mND4EAh7OF0wFu1Lv7AkxTI53JqyohHYrbqzQznKcA8u
	X5KfVDCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0nYE-0000000EvqI-1bQ8;
	Mon, 22 Sep 2025 20:54:22 +0000
Date: Mon, 22 Sep 2025 21:54:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	miklos@szeredi.hu, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v3 10/15] iomap: add bias for async read requests
Message-ID: <aNG3fnlbJhv1cenS@casper.infradead.org>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-11-joannelkoong@gmail.com>
 <20250918223018.GY1587915@frogsfrogsfrogs>
 <aNGWkujhJ7I4SJoT@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNGWkujhJ7I4SJoT@infradead.org>

On Mon, Sep 22, 2025 at 11:33:54AM -0700, Christoph Hellwig wrote:
> On Thu, Sep 18, 2025 at 03:30:18PM -0700, Darrick J. Wong wrote:
> > > +	iomap_start_folio_read(folio, 1);
> > 
> > I wonder, could you achieve the same effect by elevating
> > read_bytes_pending by the number of bytes that we think we have to read,
> > and subtracting from it as the completions come in or we decide that no
> > read is necessary?
> 
> Weren't we going to look into something like that anyway to stop
> the read code from building bios larger than the map to support the
> extN boundary conditions?  I'm trying to find the details of that,
> IIRC willy suggested it.  Because once we touch this area for
> non-trivial changes it might be a good idea to get that done, or at
> least do the prep work.

Yes, I did suggest it.  Basically, we would initialise read_bytes_pending
to folio_size(), then subtract from it either when a request comes in
or we decide to memset a hole.  When it reaches zero, we have decided
on the fate of every byte in the folio.

It's fewer atomics for folios which contain no holes, which is the case
we should be optimising for anyway.

