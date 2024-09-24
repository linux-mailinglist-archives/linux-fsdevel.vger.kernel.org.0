Return-Path: <linux-fsdevel+bounces-29928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EF4983C74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 07:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1659BB212D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 05:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5923646447;
	Tue, 24 Sep 2024 05:44:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E977BE65;
	Tue, 24 Sep 2024 05:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727156658; cv=none; b=ldY0KRSAlaZ8w+AY5GWjOYSExVw+JpICGIzYuHWZqA7dLikdEcH8jjXnaMWJSnfOweq661a1XIYS7eJb3GsiG16t0nqSnWg6VpY6Hol4tOBzBzkrez0IZtRZyl6pmnfb8XUdUb+aVlPXDU2UNYZSGsG+l4yJq1t5mG7Aq3XVRFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727156658; c=relaxed/simple;
	bh=hv1X+u1+8Q6qEph3JK1UACWQcuMKnZdQSrHPMRNh0aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyaxrBA6yHCsEZc+j5e5B2ghGBNFv4vWX1WpjBTPFet1eyuYa5WWx/O03AO0m+SaGVbDrrDHrhOHGkiDxQzXXrN7UhR2/uo/QxUf3/3ftatdT9nlebtr9VIOciYmyKO4jlwaZ6fVL2dw4YztVtG9gtLNq1ewDWdhMU4jYNjfoKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3EF6B227A8E; Tue, 24 Sep 2024 07:44:12 +0200 (CEST)
Date: Tue, 24 Sep 2024 07:44:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/10] xfs: zeroing already holds invalidate_lock
Message-ID: <20240924054411.GA10630@lst.de>
References: <20240923152904.1747117-1-hch@lst.de> <20240923152904.1747117-7-hch@lst.de> <20240923162249.GH21877@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923162249.GH21877@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 23, 2024 at 09:22:49AM -0700, Darrick J. Wong wrote:
> On Mon, Sep 23, 2024 at 05:28:20PM +0200, Christoph Hellwig wrote:
> > All XFS callers of iomap_zero_range already hold invalidate_lock, so we can't
> > take it again in iomap_file_buffered_write_punch_delalloc.
> > 
> > Use the passed in flags argument to detect if we're called from a zeroing
> > operation and don't take the lock again in this case.
> 
> Shouldn't this be a part of the previous patch?  AFAICT taking the
> invalidation lock in xfs_file_write_zero_eof is why we need the change
> to rwsem_assert_held_write here, right?

Most callers of zeroing already hold the lock.  So I can see arguments
for merging the patches now (don't make one case even worse before
fixing) or not (this is really two unrelated changes and easier to
understand).

Or now that the lockig is inside XFS we could even add a private iomap
flag to not do the locking for the eof zeroing, but that would create
even more special cases.


