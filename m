Return-Path: <linux-fsdevel+bounces-20133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 752FF8CEA63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 21:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31484283871
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 19:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588785D903;
	Fri, 24 May 2024 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rPMFhge0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5814F5CDF0
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2024 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716579350; cv=none; b=hiG3GYVPbWWl2Pc6oLRUKeID7DMRP+5GtKV2hog3DFsx6NiFqPiTWiqCNnmX5ZQtHnXhuxXH32Oyx+ZYm9KHD594Bsddi7pmvageY2ml5jaodwi3FXBTRMxArSFAS4AKNa2CeWtXFic6EW3GmDPfXJTmvwaRKkGJcAR2p2TPX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716579350; c=relaxed/simple;
	bh=24/lwouqRsEp7nneCQc6V04pBZKF65XYqcfL437L/8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+dcSMqaPRczdCOV9Uh1kPbxGXCGvE89X6FIAqLuzAZR7hB45HsiXN9d9qQkJOhYOq8NKKKJEcqpwg3/sv4UIXl1p+PjiFhp1Ybv4qpgla6C281bQlyoXq4f+bNQglXHtzQFZnhvEEDJxtuGSvuhPv4wtBwhhy+SK2pmguRm7n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rPMFhge0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AyyjBRM/oGbKwS/F1k3nCZ4DCLqWSP9z6Y1OTn0tq60=; b=rPMFhge0ahdl71ZsNYTzvVrhSy
	/vtyHGQDDNmVjNyZsFZ53I2pL7aA26sFwNXh0U4kSbhu/+M674TesodD2y4fRjF+Spq8nHtCpIGrs
	XIQvFWdrGhwkJgBxlA8+yW53ZtkpudzGOlrZ/FyoYQIBRzIhi2V5ew8jao0zTCxVTq3JJuqxf0a+i
	i39blRb3kd8B9aX0QyHWT/0uujokWPRVlE8Q2kehh0Oj3O190bjuSvbQGnc1wZrnKnn1LLDdAtHe4
	ilSHf/ORZLziiJDeGhwzoGsxzjZpijjdM3bf/3L5L/AXLjEYwnMmFapZnWwDjU9xlqayogyuwVvkf
	OsmatEqg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAahb-00000002ymJ-0BSN;
	Fri, 24 May 2024 19:35:43 +0000
Date: Fri, 24 May 2024 20:35:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Viacheslav Dubeyko <slava@dubeyko.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org
Subject: Re: kmap + memmove
Message-ID: <ZlDsDifoQJM5RDy_@casper.infradead.org>
References: <Zjd61vTCQoDN9tUJ@casper.infradead.org>
 <ZjhZHQShGq_LDyDe@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjhZHQShGq_LDyDe@casper.infradead.org>

On Mon, May 06, 2024 at 05:14:21AM +0100, Matthew Wilcox wrote:
> On Sun, May 05, 2024 at 01:25:58PM +0100, Matthew Wilcox wrote:
> > Here's a fun bug that's not obvious:
> > 
> > hfs_bnode_move:
> >                                 dst_ptr = kmap_local_page(*dst_page);
> >                                 src_ptr = kmap_local_page(*src_page);
> >                                 memmove(dst_ptr, src_ptr, src);
> 
> OK, so now we know this is the only place with this problem, how are we
> going to fix it?

Fabio?

> I think the obvious thing to do is to revert the kmap -> kmap_local
> conversion in this function.  The other functions look fine.
> 
> Longer term, hfs_bnode_move() makes my eyes bleed.  I really think we
> need to do something stupider.  Something like ...
> 
> void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
> {
> 	void *data;
> 	int first, last;
> 
> 	if (!len || src == dst)
> 		return;
> 	if (src < dst && src + len < dst)
> 		return hfs_bnode_copy(node, dst, node, src, len);
> 	if (dst < src && dst + len < src)
> 		return hfs_bnode_copy(node, dst, node, src, len);
> 
> 	src += node->page_offset;
> 	dst += node->page_offset;
> 	first = min(dst, src) / PAGE_SIZE;
> 	last = max(dst + len, src + len) / PAGE_SIZE;
> 	data = vmap_folios(bnode->folios + first, last - first + 1);
> 	src -= first * PAGE_SIZE;
> 	dst -= first * PAGE_SIZE;
> // maybe an off-by-one in above calculations; check it
> 	memmove(data + dst, data + src, len);
> 	vunmap(data);
> }
> 

