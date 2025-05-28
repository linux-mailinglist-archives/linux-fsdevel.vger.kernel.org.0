Return-Path: <linux-fsdevel+bounces-49957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E35CCAC6443
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 10:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CFC189097D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 08:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C521C26A0B3;
	Wed, 28 May 2025 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KLemYWro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD21FBEBE
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748420092; cv=none; b=L/ZObQA3IJm9LRWydfKeLHoZB5I/qnYaIULeNS4UxL/CM3W+dB2pgBqciJv+L5AWp4w78kvQEpAO4oMWgWGEIvCGg79qcBXcZ16hvGU6kaClGZLlLtIls6b6Hgibv79HbPrZ3N7jSBs28CC+aScg96PG/PuUQVxk3yp+p7GcPlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748420092; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/1ZgDzaZ+S65Jc+sOIrm8dIlZz2TPfwiWK9RqUNZ5Edwjmd1U1F92urdq5upw1pFL4x8yJ2pn40TPQrgZizWrP9hCghPAP4Q/S3rLo3Ry6UHmzGcOVR5chjx5ivG+cgBML2odZxQrU1dQK/nou3a16B/CYTwRiVGOOyspLnQwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KLemYWro; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=KLemYWror9QytFWNr3VMhOLmV+
	3YlHsfah8+tN/1XvsDUfOLSJWgCMXc4I3wuOX603KVs1hJCOJ1+nYR0iMRZO05fMiX0yz1HrATMyS
	0ym1k+1AGQX5w1JJD2G7PlK7zyrN2THURUMC5rQ1V+N3VwOuSmPjJSc1U3J6/jtgs3YfZhD3hxu1S
	mKOF670p/jf9mV0Khq21B+4qDW2j+DtuUNEzcMYp4VvBKxOOPlt/5G6QClRvYhRJyjEP39BHznZ66
	8w6AtSLmjtLTVozl4kCsIsvGGSLsi3CKAxSFs9vN3GqZ/u6Yr1W4ixrBXTOCylT4H5x+ndAj8tLfO
	m+r8J70w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKBw2-0000000CXDb-1VQ0;
	Wed, 28 May 2025 08:14:50 +0000
Date: Wed, 28 May 2025 01:14:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	djwong@kernel.org, brauner@kernel.org,
	torvalds@linux-foundation.org, trondmy@hammerspace.com
Subject: Re: [PATCH 4/5] mm/filemap: unify read/write dropbehind naming
Message-ID: <aDbF-mnKxNwXgGbz@infradead.org>
References: <20250527133255.452431-1-axboe@kernel.dk>
 <20250527133255.452431-5-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527133255.452431-5-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


