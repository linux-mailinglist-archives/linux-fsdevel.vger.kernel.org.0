Return-Path: <linux-fsdevel+bounces-52115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A73ADF763
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 22:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EA117F88B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE4A219EAD;
	Wed, 18 Jun 2025 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ieseRAba"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B05E3085A6;
	Wed, 18 Jun 2025 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750277055; cv=none; b=Towz8McBOLd4Y9MYSJs6H7ZsAmuDuIMzcLXtsSZHICs/qwuq6T11D+P5AyORftfzfSCka7JytIRb4fDtiJhl8tVwd1DJ+t46HAJ1y45WdL9l1Pyxus3QnhUJ+5CoD0Aed1E6QK/BxdJfhAitsceRMe3XpvZ4U+iQInuuh/nRJQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750277055; c=relaxed/simple;
	bh=6ZkxjQapZUXSy1w/otyjvrDRv9aX4E97f9yHVY3kDe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpSdaEML+MA89oTbkdtWES5TZzrJouJFeyhX0Rn4SEnvSHCUEBv/ArQmphJrNPT0LE7vzdNJXOClDC9njtxJbwmILMUsnHST8iRnWtAdzv1lTQDmpm0DpmfYCt+XXTuAjeIw1Rthq5W5jr3mC1NaPcxJLYrM+KuGqxou8GwxMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ieseRAba; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r+yILtYkX3FnYrUMXwUjtoYSq4aCkMrSL4SJ7/KGbLA=; b=ieseRAbaE2EB/gg0UrA4lAg0ya
	OMIrk68qActWNIrlU4+o3MUxlOdzs0sAzy8pvh0C+/FzDPucczlLfYPfD00o24KCkCuH+FFOkwmhp
	R1YimiUoY/XcQ89JvDBIwxhHk6PC6vuXgeyDcRBuG+/scNqdcGd/AmB3MCUJEVczHYhsFH/HtCuBD
	QUWwg5HM3SO54YGjy9XPxlOrywxz6rlNYI4GbAr78NL3JYgieExT9cy4hxQWUtJGM3OQ5TZX+EmC6
	ynJh94nA0G2clxmoy3o2IEFglpHpJc0flDhE2COS7zRIswWNpdaBNi0IJZT6aqdC3OgNSoC27mXmb
	kXWvpJxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRz0r-00000004xfj-0q6I;
	Wed, 18 Jun 2025 20:04:01 +0000
Date: Wed, 18 Jun 2025 21:04:01 +0100
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
Message-ID: <aFMbsdPYhcL8fyOo@casper.infradead.org>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-9-david@redhat.com>
 <AD158968-D369-4884-806A-18AEE2293C8B@nvidia.com>
 <aFMQ65hUoOoLaXms@casper.infradead.org>
 <DABB8764-8656-44A8-B252-0240F53BC0E3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DABB8764-8656-44A8-B252-0240F53BC0E3@nvidia.com>

On Wed, Jun 18, 2025 at 03:25:46PM -0400, Zi Yan wrote:
> On 18 Jun 2025, at 15:18, Matthew Wilcox wrote:
> >> Why not use page version of lock, unlock, and put? Especially you are
> >> thinking about not using folio for these pages. Just a question,
> >> I am OK with current patch.
> >
> > That would reintroduce unnecessary calls to compound_head().
> 
> Got it. But here page is not folio, so it cannot be a compound page.
> Then, we will need page versions without compound_head() for
> non compound pages. Could that happen in the future when only folio
> can be compound and page is only order-0?

I think the assumption that we'll only see compound pages as part of
folios is untrue.  For example, slabs will still allocate multiple
pages (though slabs aren't migratable at this point).  The sketch at
https://kernelnewbies.org/MatthewWilcox/Memdescs supports "misc pages"
with an order stored in bits 12-17 of the memdesc.  I don't know
how useful that will turn out to be; maybe we'll never implement that.

