Return-Path: <linux-fsdevel+bounces-62425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A7B929B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 20:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 401C17A413D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AE031961C;
	Mon, 22 Sep 2025 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f1iGZvsI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C222D948A;
	Mon, 22 Sep 2025 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758566038; cv=none; b=EXN6wRfeyhYUUoTw6ZecWT936zEfecLUtDZk6oilERgGMN06LXGrYQvUFRER2aRwP7zmQGrsVx7dHi6pEZhsNGY4pQCCVFY3O8BysGH0qxJ7c4O2zuoufxgWm4QOakDsoEjbPOo6XUtfkkZDjqLOSkW63DTh+s8ZZ9l7/IxsJ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758566038; c=relaxed/simple;
	bh=7f6X9BK45s8s/WWNImS47ZKqL25dfIRyq6yzpkvPLqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XinDM+98GjGfAWU1B9Inr3drcQGfjuXIS/tKeI3FeofAJR2s6p3KzFIKMguSC2MHWQCjqQHoPxe/Q8OvLs4MfDTadfXF2wdE90XjNpohmHQGGiBO1FH5XY0zsI65VkUy9hRZgbACGxZIfh5t3eUkdm9emETi1upHONDwhJ4zAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f1iGZvsI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pk0qXAy77S9S9BN6W/egzghhkLeJ2kMDcymJHNW+Geo=; b=f1iGZvsI7MMMKm6AlFSw/0gMvE
	4kXNPJt5mE/WQfL5BfjwBu3uKLri5sv1tm7/Z22oRirtItJW4IDW9fNBItMCI4/xFMmQb0r23sMBs
	DXihmc7jXuoRR4WLkdIZZT9pnUhnFRJpeELTmHe8Vkc72WbpFYLQyxeAZxE290/KrSOOwX794+06w
	SXMUlvRPSC+q6DXiXaqZ2N6J4ihxbCdjzzjKxuxjp0kDrVtgKMiXc11Nl5f4z8026GSLnl8nfNVm0
	OsqTc9nDq1piwbGGfv/lZYpnDroXXhMfxjZ0ZR9+YcoJyGXaW0tCo856iVH3VkeP0scpzGAj+Lwal
	CILooQbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0lMI-0000000BFwN-46U7;
	Mon, 22 Sep 2025 18:33:54 +0000
Date: Mon, 22 Sep 2025 11:33:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	miklos@szeredi.hu, hch@infradead.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Matthew Wilcow <willy@infradead.org>
Subject: Re: [PATCH v3 10/15] iomap: add bias for async read requests
Message-ID: <aNGWkujhJ7I4SJoT@infradead.org>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-11-joannelkoong@gmail.com>
 <20250918223018.GY1587915@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918223018.GY1587915@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Sep 18, 2025 at 03:30:18PM -0700, Darrick J. Wong wrote:
> > +	iomap_start_folio_read(folio, 1);
> 
> I wonder, could you achieve the same effect by elevating
> read_bytes_pending by the number of bytes that we think we have to read,
> and subtracting from it as the completions come in or we decide that no
> read is necessary?

Weren't we going to look into something like that anyway to stop
the read code from building bios larger than the map to support the
extN boundary conditions?  I'm trying to find the details of that,
IIRC willy suggested it.  Because once we touch this area for
non-trivial changes it might be a good idea to get that done, or at
least do the prep work.

