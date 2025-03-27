Return-Path: <linux-fsdevel+bounces-45150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFA7A7375C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 17:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2843188BEAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 16:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194EB1CB51F;
	Thu, 27 Mar 2025 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tff+XbVM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266671FC7F4
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094325; cv=none; b=hLCTg2o2EMZ1Mfz+mktg/GGXX/bZJqEnApS3krqbb5hI4luIW8s5u/mjxAzCSevQl7FQhqd1BacTA9p4kfl3W5Y6cNW0y8hGr9Bu41lcdU0wcB+5QOjODUKpDBfq8da5Uoo3pTIVdIk63+tq0j0CEN9bVjXEGR07oZVHrk8goK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094325; c=relaxed/simple;
	bh=MnyuXudhgpuaDtXpTGAGQ77UPUNntDuff1BT8FAI/qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EirOPxLDhU2OLiQtqCFJPkhgu68Q/L7DZoQW1f5PJ1NXcw0v2ovDMkhpoL+fDAxt+Kp0qXlENc7DFU2DdmTyfzfsC66y4tUOJK6xBAvFtYags375HED+UMSkDTEU7YM1fM9BzB+VVpTq2UQ3XmAAtzls8pQPV3+6LXnbJzyJpA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tff+XbVM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WvJvXJ3OrGWCdtCx1QOheQY5gfEHa0CN+A8keiNSVBk=; b=tff+XbVM+3StuD0VjdfR5xxB7f
	evRprvJDo+8MKUQ+57677XAwMV1B5JST3TsTJ8sOoCtAHAHN1YDhcEJW79vFkdlpB/6qc0K9zPCn8
	b35pvaNzwEwWI+Rh+UHZDtvanMaUznfYLve9OBramtw+1lMqkzMUKM/0HuCuHv9RLeqDbkNo3BGUu
	JmNlDHggPEuQbsR82uCo1J1S6V0O9RRaYn4TL/khla44+qyBZwqkcIPhn1BkBhAi3kV1UanGct4qV
	WNandZeEwxWTn+XN9vGHser7aIl65P4YFNi2ItG+uhWo9Omgm1HWLPwqulzb6h5R1SKmmeN0xFyip
	QYSt2LiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txqSX-0000000DYhZ-1mPH;
	Thu, 27 Mar 2025 16:52:01 +0000
Date: Thu, 27 Mar 2025 16:52:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>, linux-mm@kvack.org,
	intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 06/11] migrate: Remove call to ->writepage
Message-ID: <Z-WCMYYQRsrRlikA@casper.infradead.org>
References: <20250307135414.2987755-1-willy@infradead.org>
 <20250307135414.2987755-7-willy@infradead.org>
 <D8R539L45F9P.3PIKZ5DUGGVS8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8R539L45F9P.3PIKZ5DUGGVS8@nvidia.com>

On Thu, Mar 27, 2025 at 11:04:57AM -0400, Zi Yan wrote:
> On Fri Mar 7, 2025 at 8:54 AM EST, Matthew Wilcox (Oracle) wrote:
> > The writepage callback is going away; filesystems must implement
> > migrate_folio or else dirty folios will not be migratable.
> 
> What is the impact of this? Are there any filesystem that has
> a_ops->writepage() without migrate_folio()? I wonder if it could make
> the un-migratable problem worse[1] when such FS exists.

As Christoph and I have been going through filesystems removing their
->writepage operations, we've been careful to add ->migrate_folio
callbacks at the same time.  But we haven't fixed any out-of-tree
filesystems, and we can't fix the filesystems which will be written in
the future.

So maybe what we should do is WARN_ON_ONCE() for filesystems which
have a ->writepages, but do not have a ->migrate_folio()?

> >  static int fallback_migrate_folio(struct address_space *mapping,
> >  		struct folio *dst, struct folio *src, enum migrate_mode mode)
> >  {
> > -	if (folio_test_dirty(src)) {
> > -		/* Only writeback folios in full synchronous migration */
> > -		switch (mode) {
> > -		case MIGRATE_SYNC:
> > -			break;
> > -		default:
> > -			return -EBUSY;
> > -		}
> > -		return writeout(mapping, src);
> > -	}
> 
> Now fallback_migrate_folio() no longer writes out page for FS, so it is
> the responsibilty of migrate_folio()?

->migrate_folio() doesn't need to write out the page.  It can migrate
dirty folios (just not folios currently under writeback, obviously)


