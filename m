Return-Path: <linux-fsdevel+bounces-2938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF797EDB03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 06:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3D81F2238C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 05:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A02C2CC;
	Thu, 16 Nov 2023 05:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aacNsqxh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAC6130;
	Wed, 15 Nov 2023 21:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Yl2SkyZs6uI/0pe9AfsD9HLwWMslWsjY3s28vGnjUts=; b=aacNsqxhN99G4fJVbgKJN8idkR
	JEaXhgQ/9JLpwOOiO3W79Utx7jQeSZeg7oSduCOc3UYHDRP0AodotcJv3tKiCCDpMV2GSaBLRj+CD
	yv2KmTEVQePSiMZDFRxoRfHdMKAYLvAxiK8+/Ixs4WdinT6E2kzMVqsYlQtNm79/YVD67JN4IJuye
	ni1G7NlKEz5Zhl+pKx0qgUYDyHxIYgIgv9gTM+SfwkF/lgpp9Plkahe99GAszdjzsqC6Tp0AOC4DR
	/B79Z6fXDIsI4qOHND+GE3Kn8SFSh4CjIUE4A+GYjviFbcsxfR2evjMIx99Y5TlWrcxp+irVMzlna
	WqVMWdQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r3UYv-000xIT-MU; Thu, 16 Nov 2023 05:05:09 +0000
Date: Thu, 16 Nov 2023 05:05:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Mixed page compact code and (higher order) folios for filemap
Message-ID: <ZVWjBVISMbP/UvGY@casper.infradead.org>
References: <ec608bc8-e07b-49e6-a01e-487e691220f5@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec608bc8-e07b-49e6-a01e-487e691220f5@gmx.com>

On Thu, Nov 16, 2023 at 02:11:00PM +1030, Qu Wenruo wrote:
> E.g. if I allocated a folio with order 2, attached some private data to
> the folio, then call filemap_add_folio().
> 
> Later some one called find_lock_page() and hit the 2nd page of that folio.
> 
> I believe the regular IO is totally fine, but what would happen for the
> page->private of that folio?
> Would them all share the same value of the folio_attach_private()? Or
> some different values?

Well, there's no magic ...

If you call find_lock_page(), you get back the precise page.  If you
call page_folio() on that page, you get back the folio that you stored.
If you then dereference folio->private, you get the pointer that you
passed to folio_attach_private().

If you dereference page->private, *that is a bug*.  You might get
NULL, you might get garbage.  Just like dereferencing page->index or
page->mapping on tail pages.  page_private() will also do the wrong thing
(we could fix that to embed a call to page_folio() ... it hasn't been
necessary before now, but if it'll help convert btrfs, then let's do it).

