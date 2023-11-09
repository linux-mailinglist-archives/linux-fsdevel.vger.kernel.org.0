Return-Path: <linux-fsdevel+bounces-2611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7567C7E706B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F5D4B20CF7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE81023744;
	Thu,  9 Nov 2023 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LTik8qcE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F2F225D7
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 17:37:32 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA62268D;
	Thu,  9 Nov 2023 09:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/zf0lTxBuvebjd5FmP2bSMJ+hk6qswmHlp1nwkj6kdY=; b=LTik8qcEySCdMDCuz34d3k9ufZ
	tIgcA/qhbd4WYY5aZm5G/BJ2NEhNKKXaDkYnnyUJAuigl/iM5tH7dRWI1ba0FvgpOqW7c+UKRpfQO
	RAvQnxfo8z2qPObIHJq1IJUTFhywlpF+wEQWWVRfnLbA9X5PZ5R4vGG5iuNEzgl7f+vo12OLuGXhO
	pe5VQDHRK0lqSD/ljuVimzlylfGVsSxVegB1RP+IXwbzxtIF3T+hEZfu9w1iPpvBgX/zKeVbg2U0w
	3vP9mNvXcffxVjBoGzc7OKfxYwn6qUASlkThQRGRrWJ66Pbuyc7n5VoIx/fr++kivBB8bQPN2Cpqp
	mkWfeIrA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r18y9-008YXP-0x; Thu, 09 Nov 2023 17:37:29 +0000
Date: Thu, 9 Nov 2023 17:37:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-ext4@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-erofs@lists.ozlabs.org, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH 1/3] mm: Add folio_zero_tail() and use it in ext4
Message-ID: <ZU0Y2NEMMlkHYcr6@casper.infradead.org>
References: <20231107212643.3490372-1-willy@infradead.org>
 <20231107212643.3490372-2-willy@infradead.org>
 <20231108150606.2ec3cafb290f757f0e4c92d8@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108150606.2ec3cafb290f757f0e4c92d8@linux-foundation.org>

On Wed, Nov 08, 2023 at 03:06:06PM -0800, Andrew Morton wrote:
> >  
> > +/**
> > + * folio_zero_tail - Zero the tail of a folio.
> > + * @folio: The folio to zero.
> > + * @kaddr: The address the folio is currently mapped to.
> > + * @offset: The byte offset in the folio to start zeroing at.
> 
> That's the argument ordering I would expect.
> 
> > + * If you have already used kmap_local_folio() to map a folio, written
> > + * some data to it and now need to zero the end of the folio (and flush
> > + * the dcache), you can use this function.  If you do not have the
> > + * folio kmapped (eg the folio has been partially populated by DMA),
> > + * use folio_zero_range() or folio_zero_segment() instead.
> > + *
> > + * Return: An address which can be passed to kunmap_local().
> > + */
> > +static inline __must_check void *folio_zero_tail(struct folio *folio,
> > +		size_t offset, void *kaddr)
> 
> While that is not.  addr,len is far more common that len,addr?

But that's not len!  That's offset-in-the-folio.  ie we're doing:

memset(folio_address(folio) + offset, 0, folio_size(folio) - offset);

If we were doing:

memset(folio_address(folio), 0, len);

then yes, your suggestion is the right order.

Indeed, having the arguments in the current order would hopefully make
filesystem authors realise that this _isn't_ "len".

