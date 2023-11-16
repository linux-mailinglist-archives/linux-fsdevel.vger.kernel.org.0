Return-Path: <linux-fsdevel+bounces-2957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEC97EE2B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 15:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A017C1F26E3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 14:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A32F321AB;
	Thu, 16 Nov 2023 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DYS5m2HL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B417C4;
	Thu, 16 Nov 2023 06:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dgZYG76MUgPHX67tQhnkUTmVuk0UMwkw1IreH1RBeME=; b=DYS5m2HLHoY//Tuy5RMME89zll
	oXwSQYYlbXkvfFm2iQ/PoV3DrK+KxyjHJp9qSez3cEJDNrFkpzzliOw11VIdnyVPAYna1DAN8ovoy
	RVPskZbnE8TRDtt1ptf80glV4/0kDKIolfhVvU8q2ilfPg75Fu3l1Z/JmDkv06cod7YM1lcu3Fsa3
	2X4DBQumiAoky4S8QPU4HW1/2reoxLoV6t9Ec1qmzA0sDlhpCV/tOfNBm/WDD96H4SyUQvXEuZPeB
	jMkzrbdzBTGsqmojF8EgYM/lrlpnW83VXsT7Y9eeSYBAT371cxUOl6OwbWdonZatCw4vugfRr6gTT
	JHI8nVSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r3dHY-003SWQ-0b; Thu, 16 Nov 2023 14:23:48 +0000
Date: Thu, 16 Nov 2023 14:23:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Mixed page compact code and (higher order) folios for filemap
Message-ID: <ZVYl8z5A1ucf/GYt@casper.infradead.org>
References: <ec608bc8-e07b-49e6-a01e-487e691220f5@gmx.com>
 <ZVWjBVISMbP/UvGY@casper.infradead.org>
 <0e995d32-a984-4b65-b9e3-67fc62cc2596@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e995d32-a984-4b65-b9e3-67fc62cc2596@gmx.com>

On Thu, Nov 16, 2023 at 04:00:40PM +1030, Qu Wenruo wrote:
> On 2023/11/16 15:35, Matthew Wilcox wrote:
> > On Thu, Nov 16, 2023 at 02:11:00PM +1030, Qu Wenruo wrote:
> > > E.g. if I allocated a folio with order 2, attached some private data to
> > > the folio, then call filemap_add_folio().
> > > 
> > > Later some one called find_lock_page() and hit the 2nd page of that folio.
> > > 
> > > I believe the regular IO is totally fine, but what would happen for the
> > > page->private of that folio?
> > > Would them all share the same value of the folio_attach_private()? Or
> > > some different values?
> > 
> > Well, there's no magic ...
> > 
> > If you call find_lock_page(), you get back the precise page.  If you
> > call page_folio() on that page, you get back the folio that you stored.
> > If you then dereference folio->private, you get the pointer that you
> > passed to folio_attach_private().
> > 
> > If you dereference page->private, *that is a bug*.  You might get
> > NULL, you might get garbage.  Just like dereferencing page->index or
> > page->mapping on tail pages.  page_private() will also do the wrong thing
> > (we could fix that to embed a call to page_folio() ... it hasn't been
> > necessary before now, but if it'll help convert btrfs, then let's do it).
> 
> That would be great. The biggest problem I'm hitting so far is the page
> cache for metadata.
> 
> We're using __GFP_NOFAIL for the current per-page allocation, but IIRC
> __GFP_NOFAIL is ignored for higher order (>2 ?) folio allocation.
> And we may want that per-page allocation as the last resort effort
> allocation anyway.
> 
> Thus I'm checking if there is something we can do here.
> 
> But I guess we can always go folio_private() instead as a workaround for
> now?

I don't understand enough about what you're doing to offer useful
advice.  Is this for bs>PS or is it arbitrary large folios for better
performance?  If the latter, you can always fall back to order-0 folios.
If the former, well, we need to adjust a few things anyway to handle
filesystems with a minimum order ...

In general, you should be using folio_private().  page->private and
page_private() will be removed eventually.

The GFP_NOFAIL warning is:

        WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));


