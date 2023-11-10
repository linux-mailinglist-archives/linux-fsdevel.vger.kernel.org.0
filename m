Return-Path: <linux-fsdevel+bounces-2733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 272757E7E06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 18:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EB81F20EC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 17:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F4B2031B;
	Fri, 10 Nov 2023 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ng7dBymG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EE7208A8
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 17:09:34 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C0143912;
	Fri, 10 Nov 2023 09:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=5iIz9LZtzoUA/MUQ6eEhfr6QsbZtT819GM3S7MYEDJM=; b=Ng7dBymG5jMgVsYPsLxyRKew+b
	lU2Xqfa14/vmIzf1LtQxbPXQJO/ngwL7OrxcDp9FV+g6fX+UdG4xcw42fKX6QsFwuCD61MO8rFHUr
	rHsGmhB15MpQEZsO4qmTJar3Ln7u++at4FUy4n1HeSr13wq+2cTCC/zhRDIhiylXVpv/FeOs5nNJN
	V5wPt/4lnoEVBrC4nRKHfmPpArlqc2AaYXpy6ogF/HN6y71eoGj77eift0Hx1YftuJkgDqXkbSj+5
	rs8Er3hQETONDuKWwrCiHT1DcR/qnjxz5xn5zS/BDdA3/AgaFqMl1wa3Xw2mjDTOf6IAdPg3UmjpB
	YKculXXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r1V0Z-00EaZj-3C; Fri, 10 Nov 2023 17:09:27 +0000
Date: Fri, 10 Nov 2023 17:09:27 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
	linux-erofs@lists.ozlabs.org, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 2/3] mm: Add folio_fill_tail() and use it in iomap
Message-ID: <ZU5jx2QeujE+868t@casper.infradead.org>
References: <20231107212643.3490372-1-willy@infradead.org>
 <20231107212643.3490372-3-willy@infradead.org>
 <CAHc6FU550j_AYgWz5JgRu84mw5HqrSwd+hYZiHVArnget3gb4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU550j_AYgWz5JgRu84mw5HqrSwd+hYZiHVArnget3gb4w@mail.gmail.com>

On Thu, Nov 09, 2023 at 10:50:45PM +0100, Andreas Gruenbacher wrote:
> On Tue, Nov 7, 2023 at 10:27 PM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> > +static inline void folio_fill_tail(struct folio *folio, size_t offset,
> > +               const char *from, size_t len)
> > +{
> > +       char *to = kmap_local_folio(folio, offset);
> > +
> > +       VM_BUG_ON(offset + len > folio_size(folio));
> > +
> > +       if (folio_test_highmem(folio)) {
> > +               size_t max = PAGE_SIZE - offset_in_page(offset);
> > +
> > +               while (len > max) {
> > +                       memcpy(to, from, max);
> > +                       kunmap_local(to);
> > +                       len -= max;
> > +                       from += max;
> > +                       offset += max;
> > +                       max = PAGE_SIZE;
> > +                       to = kmap_local_folio(folio, offset);
> > +               }
> > +       }
> > +
> > +       memcpy(to, from, len);
> > +       to = folio_zero_tail(folio, offset, to);
> 
> This needs to be:
> 
> to = folio_zero_tail(folio, offset  + len, to + len);

Oh, wow, that was stupid of me.  I only ran an xfstests against ext4,
which doesn't exercise this code, not gfs2 or erofs.  Thanks for
fixing this up.

I was wondering about adding the assertion:

	VM_BUG_ON((kaddr - offset) % PAGE_SIZE);

to catch the possible mistake of calling kmap_local_folio(folio, 0)
instead of kmap_local_folio(folio, offset).  But maybe that's
sufficiently unlikely a mistake to bother adding a runtime check for.

