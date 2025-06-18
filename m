Return-Path: <linux-fsdevel+bounces-52102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33724ADF6B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 21:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604AB3BEAE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14185207A0B;
	Wed, 18 Jun 2025 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uxWTjN/+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B02D3085DF;
	Wed, 18 Jun 2025 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750274298; cv=none; b=iCedYfglCpP+aSXsmt43lI8/CDL65jIKkIF0j9O+tmWsjpKfJp1jGur0zSh3XEP+RhX51JKLi9rMkj3ix+e3KDQriGXG6GHDhAud/Otv1F04v4ht3uo9P+wSU2P5JXlEFpZ8aL6MIlnxhqxNWcTZYBEUIWn3UxCQgs8ip/slBOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750274298; c=relaxed/simple;
	bh=8zXPPI7wQtFubFkuPAOZHHOy42oI8d2nYZJfltve1mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8Znc283esgqL+obRQ0wW6eqMzLgkE3wT6bDUKtNjp9l0BZ4vmEzG2ijFe0yuZ2zWzKgHop3u8iOF5isHpY2O3QueUMnTC/IwMMhUNV9x+u13BPpG5gdKdltn4UJMTls7oYpC2HGUtmlV7mR9LyaHTbwJJu01AOeNA7pSJ4TU0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uxWTjN/+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8hntqsSm7ttpU2p3v9XMZdIXXcuDbNK0+BZVau+dW3k=; b=uxWTjN/+ZWc+mTjBMRrp/oTsXW
	rnH540ClGs1DNrTnrTu8s8zdw72fa8ksy2E3fwirF0Tkn52OUhXgWXhaCsyhvWsUVTX55kVNy8YQj
	MCSW9Rl6c+qNx/WyXrJZCN7CWw+S26o6oF0PH+Xpc42Km6pTCtbsPIhLeO7f2toarX3K6oeojX+HP
	Wyn/eU55xKr3xiE3iMbBU8LkO4HEak7HXqbLdGOfXrtXYkL/c43HdgXdRHekTOG9H+ihWaRphVSnA
	H53jr1wk84BYDLQEZRUKbRv6gsckr3u0EDiswDQv3XKSdVhnREeXbczHdYwBqXH6OZgi16c/dTDqd
	c+X5pPGw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRyIO-00000004eRU-0SVD;
	Wed, 18 Jun 2025 19:18:04 +0000
Date: Wed, 18 Jun 2025 20:18:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH RFC 08/29] mm/migrate: rename putback_movable_folio() to
 putback_movable_ops_page()
Message-ID: <aFMQ65hUoOoLaXms@casper.infradead.org>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-9-david@redhat.com>
 <AD158968-D369-4884-806A-18AEE2293C8B@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AD158968-D369-4884-806A-18AEE2293C8B@nvidia.com>

On Wed, Jun 18, 2025 at 03:10:10PM -0400, Zi Yan wrote:
> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
> > +	/*
> > +	 * TODO: these pages will not be folios in the future. All
> > +	 * folio dependencies will have to be removed.
> > +	 */
> > +	struct folio *folio = page_folio(page);
> > +
> > +	VM_WARN_ON_ONCE_PAGE(!PageIsolated(page), page);
> > +	folio_lock(folio);
> > +	/* If the page was released by it's owner, there is nothing to do. */
> > +	if (PageMovable(page))
> > +		page_movable_ops(page)->putback_page(page);
> > +	ClearPageIsolated(page);
> > +	folio_unlock(folio);
> > +	folio_put(folio);
> 
> Why not use page version of lock, unlock, and put? Especially you are
> thinking about not using folio for these pages. Just a question,
> I am OK with current patch.

That would reintroduce unnecessary calls to compound_head().

