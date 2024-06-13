Return-Path: <linux-fsdevel+bounces-21652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929799076A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 17:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353F72894E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 15:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2A3149C44;
	Thu, 13 Jun 2024 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mz9v5sLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC1B1494DE
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292455; cv=none; b=hIMdWxjzhBOcmjnDt0KJRjEoCb9WjAonyJNysREfmEMWQq2qjSkzuC2kN3DneHSZ1EIit+lwlFHLjlA0U4qDjS+/Ara4+FNklD8XRFtO7E/asQvzXF3GT5FVQE1XKkrJ+HHaY0T+8rujU6rS9YLPmOx3N1cRzCyFEwfmpOqy1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292455; c=relaxed/simple;
	bh=LmVAO773UJkhrLecFNZvNwgFrKy4gaNBqTYrsAbWq5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdAoeAgbVATy5U0PuLNG9aJJ92fly62BeWL29a1mQJA8zp+kliFrJBQjcd8zWNBTtoLOuF2pXdN9FK6hcDvf/6XpLrVvjjNYDisn/DXDWDcSWfRvlnWx8Bhci4CrR89/YoY+vcFql61O2zZsmKEABh/i5Pop0Kw+CSEM1tVLRQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mz9v5sLL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LOlbv8znOvI0IP14C94g8NaNgiykaUXtqZjMUPywTmA=; b=mz9v5sLLtQhr6s7OLuccoFZxTD
	JK1zXSC9nBcbA5clRVa+RBuRPp1zS7ZPT0Q5Bt+nh7JORf09uDrfWLojPSUqg7Lhz3vqNJKJ/qR0a
	0LVyUMBonpd2Fx6Y0r1eQyZmxJXZ+mjWT+QXl0wuvocGyZeYAjjSpkxBEGWhQ7b/NMjgPaU/hUJZV
	AWNsm9yMZ6F6HgJWgGt7AEOeaoLYmcskDTxkkComGTLAs0xpkXYrzlaVR+nQpGEjeEm/uBi/a5afl
	ZDwy0XBj6TfmXt6n5ara8L7HOYhEibdH0ctqVxcL8aet2SWUoykrdvV0GEUpf5p3pzEdgJoXguAGn
	h99NOWQg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHmMM-0000000FuFQ-3fQI;
	Thu, 13 Jun 2024 15:27:30 +0000
Date: Thu, 13 Jun 2024 16:27:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] mm: Provide a means of invalidation without using
 launder_folio
Message-ID: <ZmsP4hTMHOz3yB2S@casper.infradead.org>
References: <8b6bd8e0-04a2-4b51-9b29-74804ba11564@moroto.mountain>
 <ZmsIl5y3-RKtlxVZ@casper.infradead.org>
 <d0615dd0-1321-4e32-a71f-e1de2921ca7f@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0615dd0-1321-4e32-a71f-e1de2921ca7f@moroto.mountain>

On Thu, Jun 13, 2024 at 06:13:19PM +0300, Dan Carpenter wrote:
> On Thu, Jun 13, 2024 at 03:56:23PM +0100, Matthew Wilcox wrote:
> > On Thu, Jun 13, 2024 at 04:55:30PM +0300, Dan Carpenter wrote:
> > > Hello David Howells,
> > > 
> > > Commit 74e797d79cf1 ("mm: Provide a means of invalidation without
> > > using launder_folio") from Mar 27, 2024 (linux-next), leads to the
> > > following Smatch static checker warning:
> > > 
> > > 	mm/filemap.c:4229 filemap_invalidate_inode()
> > > 	error: we previously assumed 'mapping' could be null (see line 4200)
> > 
> > I think David has been overly cautious here.  I don't think i_mapping
> > can ever be NULL.  inode_init_always() sets i_mapping to be
> > &inode->i_data and I don't see anywhere that changes i_mapping to be
> > NULL.
> > 
> 
> I don't really understand the errors from this function, though...  I
> would have expected it to return -EINVAL on this path but it instead
> looks up if any error flags as set in the mapping, otherwise it returns
> success.

Assuming that the '!mapping' check is just a thinko, then it makes
sense.  The other two things being tested are (a) Are there no pages
in the mapping? (b) Is the end of the range before the start.

In either case, we have invalidated "all" of the pages in the range
(since there are no pages in the range), so we want to return success.

