Return-Path: <linux-fsdevel+bounces-39464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CD5A14A7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 08:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E2D1888BB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 07:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E821F8663;
	Fri, 17 Jan 2025 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3g8uUr/z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C981F6687;
	Fri, 17 Jan 2025 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100573; cv=none; b=tu2rtKfaR1DDE9RC8zEkKBbOgkYqMs3oLkQr4hOFNjRNF/yR8iUsTyeFacR2ccq9S1qvgwJt/6UkWVs7pPIOWN+R/XMvtuAuUOUukuD+eVrCiOtmh7GJHG0WsTbZ/NJ9h9CST/2sk7KkPOoTuSCV4QR6j/xq1x8qcl9hhizcil4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100573; c=relaxed/simple;
	bh=vbsrK0oAOquXB6Qxnm6v5muRqOVJe9pjcUpbdG/aAbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ2nTWjqY2ATG6ZzT669frGMnpIRjJKLddJJfKPnCfRtejnw+Co/N9CksEMWKgvl7EFPe+o7bWcd1/4dA/eFVrtOyRVGzIZFKmWCXaPCIz1QQVONW3k/+a7LJpftJFmnOOBQYdauHWwByi7KmlspPzMeNEu3l2Ox3aie3SJD6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3g8uUr/z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0xS4rzAwShP4fR0GmRf+Y/L+j7Nhbi6WmSe8J0Qupus=; b=3g8uUr/zQeamxBYJg5IR9w1nI5
	4XFglwglcwD6Kg+PhuCwG7MVHgvS5R/Pv5qLbbjmqEPK6DcIdD8PqbKmKt2IqippGnsPrcU8W8Ymy
	XYnki7fkGVODbJ/QGQkw95oNIYJRFIlp6gFu4h4wfGz+AXhghuLQOG4XlVtrU+INYLUoGcKddyaCm
	q3GJGEWpcbQcUCO0eIRoTyJ1iV3dj8zetOQr9Rbg7SOb/YBakeHaz9vZ9YgflNRZZP5NVMotg68rR
	6TGchrX0Hlb2sgEsRFJEjDaIE7qkOcAzCPou0RQ4xolbPR3/9ssMsF8+dP0kUVg/7qGKwYqvmaaHR
	0EfZr12g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYhD7-0000000HGFi-3cg9;
	Fri, 17 Jan 2025 07:56:09 +0000
Date: Thu, 16 Jan 2025 23:56:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] f2fs: register inodes which is able to donate pages
Message-ID: <Z4oNGYJrN-XGX87M@infradead.org>
References: <20250115221814.1920703-1-jaegeuk@kernel.org>
 <20250115221814.1920703-2-jaegeuk@kernel.org>
 <Z4imEs-Se-VWcpBG@infradead.org>
 <Z4k_nKT3V1xuhXGc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4k_nKT3V1xuhXGc@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jan 16, 2025 at 05:19:24PM +0000, Jaegeuk Kim wrote:
> > mean a invalidate_inode_pages2_range.  Which is a strange use of the
> > word.  what are the use cases?  Why is this queued up to a thread and
> > not done inline?  Why is this in f2fs and not in common code.
> 
> The idea is let apps register some file ranges for page donation and admin
> recliam such pages all togehter if they expect to see memory pressure soon.
> We can rely on LRU, but this is more user-given trigger. I'm not sure whether
> there's a need in general, hence, wanted to put it in f2fs first to get more
> concrete use-cases beyond this Android case.

Well, that's certainly not a file system feature.  Please build this
as generic infrastucture and send it to the linux-mm list.


