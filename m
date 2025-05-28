Return-Path: <linux-fsdevel+bounces-49955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1E0AC642E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 10:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5669A1885226
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 08:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0063F246795;
	Wed, 28 May 2025 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FryBI74C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFA319005E;
	Wed, 28 May 2025 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748420010; cv=none; b=EqXhAyphg1agvo1UT9qXr8MpGGZvMsSiAR33E0wAEziGQ9N+Ne3aHnD1UB46HZa38CfGuMDP3phvHJQO7ItX4xgbhFJCUYG63fbqTqcPhACDJIdgmyv766Yn1uMy8uLmHM4wgQLdPWCd3IVfLjRnRD3ziZzkIFvgPWdPhHly2Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748420010; c=relaxed/simple;
	bh=eenxFvJ4lhAn4vUH3Bc/HB+PVIgEKa++eVgYgscy01o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWmf6DKwIXoufbR7XCI+yLZr+SJAJ0dvc8NIh0fd4iTQTbz/Ag1UaZWpI3Ku9ncWmkMYBVpr/D9gef9VD6qR1SzHqWaqegFv8gT88qzeDAJbzE66KYYUnF51no+GNV2l9PjWkMPEiJCM881/tn8m15Y1ZOXg43Kii1zOU6DilyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FryBI74C; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eenxFvJ4lhAn4vUH3Bc/HB+PVIgEKa++eVgYgscy01o=; b=FryBI74CAzUpJjJrceJQ8191TE
	UXnQGMPcZ3CmIy39mc/4WuUU2ozi4UZ+0Q3ndzom/Wfh4xzhRvWYXGK+MP8gmHejC3Y+dCHnLnU+m
	dAxKcZrGq+4iiIIM/tHYir/Nxrew2Zkxc20Qjl4jOJo9lAgJWYLyxJGYTrPd+pnmoEanJppZ0eRVl
	BtPBQEb67cU4VnyVaiUgaTa42HNPGtgCQSt97hJyIPpfyGpqQiniIPQn5oPn2jbJBBtiK7+JAWW9g
	mTx4q3nZpPhZdOn+buU/vNus6qOFVplc9KtyO8drhhn+6DRSgIs+o6/UinJZuERPWbSFpItw95qS0
	/KHGd0Rw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKBui-0000000CWqs-2vlU;
	Wed, 28 May 2025 08:13:28 +0000
Date: Wed, 28 May 2025 01:13:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	djwong@kernel.org, brauner@kernel.org,
	torvalds@linux-foundation.org, trondmy@hammerspace.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/5] mm/filemap: use filemap_end_dropbehind() for read
 invalidation
Message-ID: <aDbFqMqYBhTejvhL@infradead.org>
References: <20250527133255.452431-1-axboe@kernel.dk>
 <20250527133255.452431-3-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527133255.452431-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 27, 2025 at 07:28:53AM -0600, Jens Axboe wrote:
> Use the filemap_end_dropbehind() helper rather than calling
> folio_unmap_invalidate() directly, as we need to check if the folio has
> been redirtied or marked for writeback once the folio lock has been
> re-acquired.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


