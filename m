Return-Path: <linux-fsdevel+bounces-26832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BB095BE87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 20:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2359A1C20CED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FB01D0481;
	Thu, 22 Aug 2024 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EVyFlZcd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E2F13A3E6
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724352862; cv=none; b=dJr2fDuysgBhIV29AikX6RGP4ZbaSICfEmPIjqllSofkFWBJrvc3UTsDuxdJq9Kw8Pn98R0iQBX/oOk1yShA9JRK90Nhio5M5CUHpVxxR0U0J9D3cOfJOp8YZH8psdPWiehwQ0o9dl5HwnQ45cj/JT2BF6W4Yh+P6ZH8iD9I7k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724352862; c=relaxed/simple;
	bh=Vz8+iHOJWkwf1F6Pu7BHiE2txmxREOqh6ZcZDnQeJgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlByrqxvT/3MGsitwGByXMmm0kp2NWFp7MTuHv+O+x3JkvtuWmUHM7ab7zRYI+mmnTu8WdXHD6Xq6YbL4Qi9UpePWDIlVDvN4P6WIMMKlkLb6V5lV20edJf14YWWpfFZ9cfEb4/z/9sl/uRgRa6k4rNa4+iq9NPdscCM8lrdKb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EVyFlZcd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UIRnfEAB13O5nPWitVGo44g8nt43zD3Aa8xFf/3Jl70=; b=EVyFlZcdwolQcAq1m0uwWnWMzn
	ZcF+DOPP/zHKtqxCEGoiD4UFEUGodgmE7gOXkvq0qNQ1YIHdsmYY9scqG9a1+5Ic6qkMvr8WfJtEZ
	u/VxfmEPYfEgT8VHqrB03uWux3iBDzQHK1xulCekiwpteNTOaLUZsTAxovZmP1mwgUKL+HH3sIxvw
	0IAZKtu+UMIC7uGpQpVFjTXG8rZpObf1Ir7kZZ4V50fsKUqlW4EbAdOntZRFGm+iIZLgZXRfsYV42
	3sNXJEEkpH83MB93Q/e2oq4lyLyPLHwKmzsEgse6cPyYWFM0F7aDUfEnxQnggm8fxKVhBUv7Y9fug
	pvf97gkg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shCwq-0000000ApjQ-0sys;
	Thu, 22 Aug 2024 18:54:16 +0000
Date: Thu, 22 Aug 2024 19:54:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Viacheslav Dubeyko <slava@dubeyko.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org
Subject: Re: kmap + memmove
Message-ID: <ZseJVwUYa9FCPFkv@casper.infradead.org>
References: <Zjd61vTCQoDN9tUJ@casper.infradead.org>
 <ZjhZHQShGq_LDyDe@casper.infradead.org>
 <ZlDsDifoQJM5RDy_@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlDsDifoQJM5RDy_@casper.infradead.org>

On Fri, May 24, 2024 at 08:35:42PM +0100, Matthew Wilcox wrote:
> On Mon, May 06, 2024 at 05:14:21AM +0100, Matthew Wilcox wrote:
> > On Sun, May 05, 2024 at 01:25:58PM +0100, Matthew Wilcox wrote:
> > > Here's a fun bug that's not obvious:
> > > 
> > > hfs_bnode_move:
> > >                                 dst_ptr = kmap_local_page(*dst_page);
> > >                                 src_ptr = kmap_local_page(*src_page);
> > >                                 memmove(dst_ptr, src_ptr, src);
> > 
> > OK, so now we know this is the only place with this problem, how are we
> > going to fix it?
> 
> Fabio?

Fabio?

> > I think the obvious thing to do is to revert the kmap -> kmap_local
> > conversion in this function.  The other functions look fine.
> > 
> > Longer term, hfs_bnode_move() makes my eyes bleed.  I really think we
> > need to do something stupider.  Something like ...
> > 
> > void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
> > {
> > 	void *data;
> > 	int first, last;
> > 
> > 	if (!len || src == dst)
> > 		return;
> > 	if (src < dst && src + len < dst)
> > 		return hfs_bnode_copy(node, dst, node, src, len);
> > 	if (dst < src && dst + len < src)
> > 		return hfs_bnode_copy(node, dst, node, src, len);
> > 
> > 	src += node->page_offset;
> > 	dst += node->page_offset;
> > 	first = min(dst, src) / PAGE_SIZE;
> > 	last = max(dst + len, src + len) / PAGE_SIZE;
> > 	data = vmap_folios(bnode->folios + first, last - first + 1);
> > 	src -= first * PAGE_SIZE;
> > 	dst -= first * PAGE_SIZE;
> > // maybe an off-by-one in above calculations; check it
> > 	memmove(data + dst, data + src, len);
> > 	vunmap(data);
> > }
> > 
> 

