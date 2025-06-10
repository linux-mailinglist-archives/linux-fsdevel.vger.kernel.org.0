Return-Path: <linux-fsdevel+bounces-51092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E73C6AD2C48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 05:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E58170380
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 03:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358F925D204;
	Tue, 10 Jun 2025 03:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G2+6OHpm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB2822837F;
	Tue, 10 Jun 2025 03:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749527367; cv=none; b=IMndreVZkiJp1w0BclEMeqmdiFy4HqGilIHtthCxT1P/IzkQdFrrqdXKhoJI6tKqWkY1vvRLQ938NYwM7ZRMk0Y1XhEuQU17+qNQ69yB7PKPnpUxW9ziaupMK8pb7QQ10ujF6WIVv9rDqxfLe5zJbxqu1zGmkIVFYwGaX2p/jOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749527367; c=relaxed/simple;
	bh=96gf3+9RfeP1SR68eJdyHt3SeP3bW1j6v7cQwo2RfX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXNPw76Zj2mmFqbGrCe8iWTe7SNu3bH9YTmqPHQzKkcnTsun8L9pdCpX34EAHwUkx6nE1aViMOpRGqPQt2ODcDBtSnYj6uHZIeBJSmJmOkMsi1GrnY6J3KwEYNjIOJZqb0VFR8rytC9LIq4YVP98UbNvRazpm0a7evJjeVoPCfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G2+6OHpm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uBRuHciQtVNLJM1VRmIo0ajCcX2iRkczdJU3q9Eyj/o=; b=G2+6OHpm1c0hYazxJAvTYikA1x
	aPUVyDDmhmuyge/3iK0mVGpa6L8vv8R8yzknxRMAcpR9df6Y0bJKPwJrNqAMXXDLyxQ5fNGBxTaUU
	gH5HMy3j8sgmH6Yb5wEiHLr4+UcS9rdFeSIXlGuAfv2N+/obxek6S1MYqezR3bDppRHV/rNj9ONKw
	L5fYcWswEz2v6UNpdyq29WPrE4pSxQJGx2vgbVov0E2WkTdLojuA40pMOahHJYThlStFzsp4n5gcs
	3gaii/Yvz5D89iv5LICWfdF/XrProbVEJjck62WhN4/iJOVrA03WCkD4kzzr4BUMJwFph2WSfKdkK
	uhP8bH1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOpzJ-00000005i0r-1ocY;
	Tue, 10 Jun 2025 03:49:25 +0000
Date: Mon, 9 Jun 2025 20:49:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: Re: [PATCH v1 4/8] iomap: add writepages support for IOMAP_IN_MEM
 iomaps
Message-ID: <aEerRblqiB-h8UeL@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-5-joannelkoong@gmail.com>
 <aEZx5FKK13v36wRv@infradead.org>
 <20250609165741.GK6156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609165741.GK6156@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 09, 2025 at 09:57:41AM -0700, Darrick J. Wong wrote:
> > It might also be worth stating what you don't use.  One big thing
> > that springs to mind is ioends.  Which are really useful if you
> > need more than one request to handle a folio, something that is
> > pretty common in network file systems.  I guess you don't need
> > that for fuse?
> 
> My initial thought was "I wonder if Joanne would be better off with a
> totally separate iomap_writepage_map_blocks implementation"

I think that's basically what the patches do, right?


> since I
> *think* fuse just needs a callback from iomap to initiate FUSE_WRITE
> calls on the dirty range(s) of a folio, and then fuse can call
> mapping_set_error and iomap_finish_folio_write when those FUSE_WRITE
> calls complete.  There are no bios, so I don't see much point in using
> the ioend machinery.

Note that the mapping_set_error in iomap_writepage_map is only for
synchronous errors for mapping setup anyway, all the actual I/O error
are handled asynchronously anyway.  Similar, clearing the writeback
bit only happens for synchronous erorr, or the rare case of (almost)
synchronous I/O.


