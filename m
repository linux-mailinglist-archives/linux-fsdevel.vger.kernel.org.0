Return-Path: <linux-fsdevel+bounces-4711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E371F80296D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 01:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7276DB2079C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 00:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35AD323B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 00:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="In21qF2/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8150ED7
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Dec 2023 15:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y3LBuPegj961tX4hMsjT+qqXDDKi0s85tHCAlRoUSZ8=; b=In21qF2/1tHy6lNkThOWluMJdj
	gM0yIwWGvsmhVbkh4DSaibR6bs3lvUfTyf/PRaxAvb6XNGljHbXv2e3EMECQ4NwQNPat8cpanB1+S
	XVHjhDLLnHEQ/+lY3MKJT+RlRmO+JUxd9x1HN+KWAhUqJ4tU2JHRoNLh7FOFhkWR+jee6LHyy7mSJ
	Q+lqN8YM+TSnTD5rI1QFCcH7+j62M4GuPUrbt1UguzMCtPs3IM6a5469jsOgd5aauHxuMrrOrEHh+
	9YSCq37Nz43N7gKJSTEep4NK60Og717b3kOfoJ3747A/F+4Ra/6La9jR3XU3INrSuO6NqsFscgEft
	tOx+RTyA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r9vd4-00089S-UN; Sun, 03 Dec 2023 23:12:02 +0000
Date: Sun, 3 Dec 2023 23:12:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org,
	Hugh Dickins <hughd@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: Issue with 8K folio size in __filemap_get_folio()
Message-ID: <ZW0LQptvuFT9R4bw@casper.infradead.org>
References: <B467D07C-00D2-47C6-A034-2D88FE88A092@dubeyko.com>
 <ZWzy3bLEmbaMr//d@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWzy3bLEmbaMr//d@casper.infradead.org>

On Sun, Dec 03, 2023 at 09:27:57PM +0000, Matthew Wilcox wrote:
> I was talking with Darrick on Friday and he convinced me that this is
> something we're going to need to fix sooner rather than later for the
> benefit of devices with block size 8kB.  So it's definitely on my todo
> list, but I haven't investigated in any detail yet.

OK, here's my initial analysis of just not putting order-1 folios
on the deferred split list.  folio->_deferred_list is only used in
mm/huge_memory.c, which makes this a nice simple analysis.

 - folio_prep_large_rmappable() initialises the list_head.  No problem,
   just don't do that for order-1 folios.
 - split_huge_page_to_list() will remove the folio from the split queue.
   No problem, just don't do that.
 - folio_undo_large_rmappable() removes it from the list if it's
   on the list.  Again, no problem, don't do that for order-1 folios.
 - deferred_split_scan() walks the list, it won't find any order-1
   folios.

 - deferred_split_folio() will add the folio to the list.  Returning
   here will avoid adding the folio to the list.  But what consequences
   will that have?  Ah.  There's only one caller of
   deferred_split_folio() and it's in page_remove_rmap() ... and it's
   only called for anon folios anyway.

So it looks like we can support order-1 folios in the page cache without
any change in behaviour since file-backed folios were never added to
the deferred split list.

Now, is this the right direction?  Is it a bug that we never called
deferred_split_folio() for pagecache folios?  I would defer to Hugh
or Kirill on this.  Ccs added.

