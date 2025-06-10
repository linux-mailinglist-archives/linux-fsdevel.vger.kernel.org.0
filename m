Return-Path: <linux-fsdevel+bounces-51094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2196DAD2C5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 06:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D840F16DF00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 04:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C025DAE9;
	Tue, 10 Jun 2025 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1FBoKFDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3773125D53B;
	Tue, 10 Jun 2025 03:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749527996; cv=none; b=Fg4bb4z7xh9M4kCtXMpNHG4nI4AnQUVUo/P/bcqiKoVd7RNGGufP35Qc3qJikQUbOR+ConWTWk1kNsdtyOUqwUvTbzFPCukQqALR/2xpVUdkBN2OHz+VeP4Vwe7vCYtFvrHFTRacRrlUW/8ArL6fPbVkrzquSchoI/4PU10Ydxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749527996; c=relaxed/simple;
	bh=KL0HhKIt6c3r3fAEsoxmA3elH6x2cfQygPx+5IUbRhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NILYvmWpzk5Dr9CuX/pROEytWXHUg11dy5nMjYBdrNjKGYmE0ht4ShBHwwZQVtZMSmmW7gHuHfu0YAj6VTk1VXhvd1/L6aqjDPt8Whu6ob+58ckmVkYH2gMTst8Zt39VWiuQzpIfX8kSzs6ddRkdeqnF3qHXF96oT3f94muIatU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1FBoKFDA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sU5sUAgpuF+2t3bLSMGu6a54oU4ikoAiS1gLuK6x3Gc=; b=1FBoKFDAcxgKfiPuLAzUUCEOzs
	jXtioUSLW9JBSVhxLsOuApjNKF6+grjpCHz28vZd/IGQfabO94E7Iy5zrXHaM7sXd5rWOt2ohXMjh
	IWjBY7xM6+f7ASZxAQImXZ6HEjUUUHZ59t4SqDwjBqb0ijo1fQSMNM3YVMJNRZTmW/JF7jVITfhFN
	Om33T3rbortPWrfpdDQwGCcW9bg9KwyLjGGEn4aa+lLwst/wrBxiji30T7o9I9d+l54gXlYhPL1Mz
	UUJc2OpwcU3Pi4aVWATmOfvoWIH1c766ic7f60/L0AflKqUPUEEjPU0/9pUl2qanhdNErWy5AQfO2
	NN74eOdA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOq9R-00000005ife-425e;
	Tue, 10 Jun 2025 03:59:53 +0000
Date: Mon, 9 Jun 2025 20:59:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm,
	kernel-team@meta.com, willy@infradead.org, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 5/8] iomap: add iomap_writeback_dirty_folio()
Message-ID: <aEetuahlyfHGTG7x@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-6-joannelkoong@gmail.com>
 <aEZoau3AuwoeqQgu@infradead.org>
 <20250609171444.GL6156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609171444.GL6156@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 09, 2025 at 10:14:44AM -0700, Darrick J. Wong wrote:
> > Where "folio laundering" means calling ->launder_folio, right?
> 
> What does fuse use folio laundering for, anyway?  It looks to me like
> the primary users are invalidate_inode_pages*.  Either the caller cares
> about flushing dirty data and has called filemap_write_and_wait_range;
> or it doesn't and wants to tear down the pagecache ahead of some other
> operation that's going to change the file contents and doesn't care.
> 
> I suppose it could be useful as a last-chance operation on a dirty folio
> that was dirtied after a filemap_write_and_wait_range but before
> invalidate_inode_pages*?  Though for xfs we just return EBUSY and let
> the caller try again (or not).  Is there a subtlety to fuse here that I
> don't know about?

My memory might be betraying me, but I think willy once launched an
attempt to see if we can kill launder_folio.  Adding him, and the
mm and nfs lists to check if I have a point :)


