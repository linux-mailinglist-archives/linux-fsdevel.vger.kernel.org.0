Return-Path: <linux-fsdevel+bounces-7079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8118219A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 11:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C79F1F21FF3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 10:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F809D298;
	Tue,  2 Jan 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GaHBC0aY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D41BD26A;
	Tue,  2 Jan 2024 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qcsy11Lg78ul7BZwYmkhJtiNOWE6BpqI+iiKcGsb37w=; b=GaHBC0aY6K78DLMSn5V2op9276
	hiLDlNytWIHRKwg4KkAuIyUSXMf3lorQYLLBjIqOiuQfTbMSmWvY4MWgVlryd7eE4KCA6+hTDUYUj
	F61LNgXNTKA6SiJ0/m3GfMOMXEM0roWqzeVonMDh7z5ItVWPgHZCnu9KrQmxgW5aSvVtuBIeQdvJC
	9qeNo51Ekl7BnrDroXwnHwnYK1jbu9LQHMP0YIDR5nO30REp/OB6i32Rc6QJYvPJVctYoiIOG12IK
	k+Zbiz3hCfLPhfJFhnAE5MX0BBERdRGcIpBGlVeSAHFICdbhwf7Ri9HwvHUHJgVW9WpUnNxPlLlzm
	iLaVTdmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rKbwd-009yqz-4e; Tue, 02 Jan 2024 10:24:23 +0000
Date: Tue, 2 Jan 2024 10:24:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: bio_vec, bv_page and folios
Message-ID: <ZZPkV2KU/dHvBB3d@casper.infradead.org>
References: <ZZPUKHTQ//eL53SM@casper.infradead.org>
 <3490948.1704185806@warthog.procyon.org.uk>
 <5779.1704189838@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5779.1704189838@warthog.procyon.org.uk>

On Tue, Jan 02, 2024 at 10:03:58AM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Tue, Jan 02, 2024 at 08:56:46AM +0000, David Howells wrote:
> > > Hi Christoph, Willy,
> > > 
> > > Will bv_page in struct bio_vec ever become a folio pointer rather than I page
> > > pointer?  I'm guessing not as it still presumably needs to be able to point to
> > > non-folio pages.
> > 
> > My plan for bio_vec is that it becomes phyr -- a physical address +
> > length.  No more page or folio reference.
> 
> Interesting...  What does that mean for those places that currently use
> bv_page as a place to stash a pointer to the page and use it to clean up the
> page later?

I don't intend to get rid of bio_for_each_folio_all() or bio_add_page()
for example.  It's just a phys_to_page() away.  The advantage is that
we wouldn't need a struct page to do I/O to a physical address.

