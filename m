Return-Path: <linux-fsdevel+bounces-4709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE8280286D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 23:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7B02B203E3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 22:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2004E1D692
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XdMcWrW7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB1EB7
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Dec 2023 13:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T78NYOSEdis+VzY5gp3O6MA8KLiyzf1kByHBipMMA5o=; b=XdMcWrW7o51kVJ7ySQNIkTbmqW
	K6Dk2DzuGRJr1R8UHPGHly2w1/2MF02nZpZ+N++Cj9xiw5HHmksj40tXlrEIegQBvGRP9y11Cq5xk
	lGw5ewzvs+7pkzMLiauJUrRSVBVtLtK9YCjEuv0fQr1X3VS8hI+Ih2YI5oRMF/oLQ7Da9kVKtjHwo
	Rtyzht7CxxkPloZMZZ9RjlwOMeN8xnSyvhdGLBeWHJid22CBwBJ8UDus4zUj/sPNY+r8MDeqVyM6K
	cmg8Co+FRdEVJPYBVVVPynilE2w2sG9BxUbQnJAY176jvvWiCwHa9M2Wt0RN6G/6s1fTOvugEcaay
	XNJrBs2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r9u0L-0004nv-Bg; Sun, 03 Dec 2023 21:27:57 +0000
Date: Sun, 3 Dec 2023 21:27:57 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: Issue with 8K folio size in __filemap_get_folio()
Message-ID: <ZWzy3bLEmbaMr//d@casper.infradead.org>
References: <B467D07C-00D2-47C6-A034-2D88FE88A092@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B467D07C-00D2-47C6-A034-2D88FE88A092@dubeyko.com>

On Sun, Dec 03, 2023 at 11:11:14PM +0300, Viacheslav Dubeyko wrote:
> So, why do we correct the order to zero always if order is equal to one?
> It sounds for me like incorrect logic. Even if we consider the troubles
> with memory allocation, then we will try allocate, for example, 16K, exclude 8K,
> and, finally, will try to allocate 4K. This logic puzzles me anyway.
> Do I miss something here?

The problem I'm trying to avoid is that when we allocate an order-1
folio, we only have two struct pages for the folio.  At the moment, we
have the deferred_list stored in the third struct page of the folio.
There isn't quite space to squeeze it into the second struct page on
32-bit systems -- we have

_flags_1		flags
_head_1			lru.head
_folio_avail		lru.tail
_entire_mapcount	mapping
_nr_pages_mapped	index
_pincount		private

after that we'd start to collide with _mapcount (which is still used
per-page) and _refcount (which must be 0 on tail pages).  We have one
word available (_folio_avail), but we'd need two to fit in a list_head.

We might be able to reengineer things so that we don't need a list_head
for deferred_list.  eg we could store deferred-split folios in an
xarray and only store the index in the folio.  Or we could decline to
deferred-split folios that are order-1.  I haven't looked into it in
detail, but I feel like this might be an acceptable approach.

I was talking with Darrick on Friday and he convinced me that this is
something we're going to need to fix sooner rather than later for the
benefit of devices with block size 8kB.  So it's definitely on my todo
list, but I haven't investigated in any detail yet.

Thanks for raising the issue; it gave me a good opportunity to explain
my current thinking on the problem.  Adding linux-mm for insights from
the MM audience.

