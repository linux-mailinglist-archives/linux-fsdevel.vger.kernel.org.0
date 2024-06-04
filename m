Return-Path: <linux-fsdevel+bounces-20894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC388FAA06
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 07:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D4728A4A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 05:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7016D13DBA0;
	Tue,  4 Jun 2024 05:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V9Y0pG6T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D2E1304B1
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 05:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717479212; cv=none; b=nI4458PkcvyGId5cHK1zyrVCkLYx1AFMHJtVQdkq/Gzr1Bm6o0XxNvDutiG+rf45SbwRSrf+G8+UvPxGQEMJ4yWfJqvQ1So6Nxn9izlP+ZyJc21iFyYpHkAKhA1gOwSc+IUEjWxfKprGSQUZkGPMzlZussQ9ni+Gwnj5Q9eS9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717479212; c=relaxed/simple;
	bh=ZG7+8yM/rZTXntXE2MioujzuUgsZXHm6IsIQNEojiMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXfpypkfvzFinnDyNLJPQPDuZspC1nB5XX6ttFai9S5uE/RVR2WVGhL/bYi2B9ze0Az06R1HNMCg4Y5skdL2ubVc9xifLpXqo9W7lmzdqvjgkhCsuFJzvIsyNJ9aqyILKV6Jrv+EBFmuquKGNNU2xg1uRU6AdWQIX3HnkKhXIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V9Y0pG6T; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=snFUBA+0PibQFW2k0BaIkX6cAMOKUi7H7wkjjdaRGSQ=; b=V9Y0pG6TtidIA1CRqcFncjT/X8
	2B+hTOneJjTccf7wravsa1HsswOy3knSOQPmThjbAXslisr4tKvVSCEGndh4QRRrEXt67etDtSJv2
	ymbCqLDW+0o+YLa/Zk2Zwep6VN0t0wZ30ixfIccb4qk/Jk9xLu2FAxY3xisIRAaMDMsXFJAP5XNx9
	B7gwZ9G6qJRMV6kIHYZe0b4OszlsATgw5hiVVHxQpNN0yQk2xIOG3Mb+syMSUoCJ7kQdGYmWNtgX6
	P6gDTeiwTXs9XIDcvTL8PPrmk8NrE9Du6k1VKNmWy5s5eR3aUZ0rNSZiZT3qP3nTDehIh6FwSAxBi
	NlXsNkQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEMna-00000001HlV-1JGe;
	Tue, 04 Jun 2024 05:33:30 +0000
Date: Mon, 3 Jun 2024 22:33:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Johannes Thumshirn <jth@kernel.org>, linux-fsdevel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] zonefs: move super block reading from page to folio
Message-ID: <Zl6nKsdp09Yrrpdh@infradead.org>
References: <20240514152208.26935-1-jth@kernel.org>
 <Zk6e30EMxz_8LbW6@casper.infradead.org>
 <20240531011616.GA52973@frogsfrogsfrogs>
 <5eedc500-5d85-4e41-87b5-61901ca59847@kernel.org>
 <ZltfsUjv9RaVWCtd@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZltfsUjv9RaVWCtd@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jun 01, 2024 at 06:51:45PM +0100, Matthew Wilcox wrote:
> On Fri, May 31, 2024 at 10:28:50AM +0900, Damien Le Moal wrote:
> > >> This will stop working at some point.  It'll return NULL once we get
> > >> to the memdesc future (because the memdesc will be a slab, not a folio).
> > > 
> > > Hmmm, xfs_buf.c plays a similar trick here for sub-page buffers.  I'm
> > > assuming that will get ported to ... whatever the memdesc future holds?
> 
> I don't think it does, exactly?  Are you referring to kmem_to_page()?
> That will continue to work.  You're not trying to get a folio from a
> slab allocation; that will start to fail.

The point is that we doing block I/O on a slab allocation is heavily
used, and zonefs does this.  If you dislike going through the folio
we can just keep using pages in zonefs for now.

Eventually I'll get around lifting the logic to greedily build a bio
from arbitrary kernel virtual addresses from various places in XFS
into common code and we can convert to that.

> I think you should use read_mapping_folio() for now instead of
> complicating zonefs.  Once there's a grand new buffer cache, switch to
> that, but I don't think you're introducing a significant vulnerability
> by using the block device's page cache.

Please don't add pointless uses of the bdev page cache for users that
don't need caching.  This just creates more headaches later on to
untangle it again.

