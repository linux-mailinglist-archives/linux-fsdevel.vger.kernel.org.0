Return-Path: <linux-fsdevel+bounces-52094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C22ADF611
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63AA57AB235
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 18:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704632F5499;
	Wed, 18 Jun 2025 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DsxNna+m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BEC2F5469;
	Wed, 18 Jun 2025 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271966; cv=none; b=hc9NbiJ4YVOjwyDuolIWLc3jtFlCbq9SN6cItUKg+8hIwW0XSPfBFUNUNIVuiAfMvgymP2bY1E11c0ln+1RKBZdnryThamUiuaMoM4SP9Q3JUpemhNj/+sMmRrZmXnqgWNnRjBVit8Y0JJ+zrzoZRJOKcXBpKTWZLSlX90rxwK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271966; c=relaxed/simple;
	bh=7a1PjeCpxWtk3iPqJuzL9cRDMGgzZs+7R/WwL76nTz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnJYgqs5imAaCovyRfolg5+zkCXjtHa2nnihPRVFvLiMM8a3Th3zd5bCRHJ1nXnYAkhiL7SI43Kz7zoKF4RGWmhWQ5r0bgRYwX11utoPJCi1OuyiVm9Pq29BOLgMI1w8BZl+4OWjAiCGnDj/z1iAdTlk7LEW1XEsh/m4ldpEI8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DsxNna+m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v5tYhFD1j+yv3Iu8PpEhj2ETO0QbZsDAEopsQ/A9bAk=; b=DsxNna+mqd14Y1R+bYWGnLXAQZ
	KD6LPHyGeHF0KI/3kpZdMUU/dhkMhaL8WEah3c3V+49Ysvqs6Bu1vdm9Vpq/S7pzTkPI7eJtMEYxU
	uBoRjKpFcj6CN3GQQtP1DGIdK3sIxGUq5tAbQdEdFNW6f1UST3AvhDLuU1qvMN21EAerKLDVmvRmF
	Bz18Agad3kUCnPAoloNaQzMvUnGOBL6wdnqo4xVUjT0N58jBE6K3YMI7r0d/dCaUiT95wlFWeD+R/
	7Mj3cTV1CtHQkWAw/n5cxdS/2TVEKUTcA+WwGRREV4fUaL5WvVYXbK9HuC1rY3t6P+y7zHGbMhwx9
	5BjmFRZw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRxgn-00000004Z0Q-0yr0;
	Wed, 18 Jun 2025 18:39:13 +0000
Date: Wed, 18 Jun 2025 19:39:13 +0100
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
Subject: Re: [PATCH RFC 07/29] mm/migrate: rename isolate_movable_page() to
 isolate_movable_ops_page()
Message-ID: <aFMH0TmoPylhkSjZ@casper.infradead.org>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-8-david@redhat.com>
 <9F76592E-BB0E-4136-BDBA-195CC6FF3B03@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9F76592E-BB0E-4136-BDBA-195CC6FF3B03@nvidia.com>

On Wed, Jun 18, 2025 at 02:14:15PM -0400, Zi Yan wrote:
> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
> 
> > ... and start moving back to per-page things that will absolutely not be
> > folio things in the future. Add documentation and a comment that the
> > remaining folio stuff (lock, refcount) will have to be reworked as well.
> >
> > While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and handle
> > it gracefully (relevant with further changes), and convert a
> > WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().
> 
> The reason is that there is no upstream code, which use movable_ops for
> folios? Is there any fundamental reason preventing movable_ops from
> being used on folios?

folios either belong to a filesystem or they are anonymous memory, and
so either the filesystem knows how to migrate them (through its a_ops)
or the migration code knows how to handle anon folios directly.

