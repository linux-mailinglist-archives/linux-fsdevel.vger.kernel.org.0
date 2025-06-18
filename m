Return-Path: <linux-fsdevel+bounces-52087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB43ADF57A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D24B1895D18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 18:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ADC3085D0;
	Wed, 18 Jun 2025 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a6vX8oca"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA573085A0;
	Wed, 18 Jun 2025 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270033; cv=none; b=f51nlG5V4Kfu8STiVupK8TdlS2XH6xGMY0GvzIIDVrNZBNYjN957EEMiMwQCQDLfpfMG8+xquhg+cvRVA0A/sH0uF/m8ISen5BtT5VesEiGNMjHKxSzpQSqw8q/qO1nRlSTAqqvVqcn9Jfe87LB6+Db4wbfsDmBO+NDsCNQMYgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270033; c=relaxed/simple;
	bh=KNokV8mdZiInOwdJ5eC48eeVWIPZcyZM/PsfuegyR0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiwoSuRRePMEXM5dC458nB5eKDoC+JdDxbPT8RFFiSsWj+AxfraNenhZ8XOXz01KxHh20FJKx+tX+CxXpyEwz3dN2ailzifT/2C17N3gYEOhVuivMSxMYt3E1XoY0xhlzsmIIbzTurPvgEbuePCAvK/nM/hUGo9NB+VPyAebbcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a6vX8oca; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=J4aHyFboA5TYykyYa0Jlj3sw+Op0fhB4LmjH5FwOZd4=; b=a6vX8ocaJ2qS7neeTyXhBP7TAr
	68s84eCnuZZugY9yDOtXOq+dInzY5Ri5o1cXxQPO0n8jy33xnrOkeWCEu4QW7VV+U4h64MOtP9fr4
	0TidPl1vB3ZLyUTFgZLx8jesTt4rgniAKKkrD6SzwP6j6ysUVfvFh9sUsWlTCWgvHZVAL7ZIqIaVq
	AsbGHPyCc+UKKfMpxx+/CBEE1jSLbt2G9bE9rKAgdRGaVt2xAqhiarAo33obYqKsLGkEwakZfOz+5
	oyN0+y7fCwzCDk1T59eooIug+hjqFPgBzcAXivpBb2u5dmg9CY76FgERkyiExRHDtkJiXJrLseR5r
	UFeLDxPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRxBa-00000004U8i-3jag;
	Wed, 18 Jun 2025 18:06:58 +0000
Date: Wed, 18 Jun 2025 19:06:58 +0100
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
Subject: Re: [PATCH RFC 04/29] mm/page_alloc: allow for making page types
 sticky until freed
Message-ID: <aFMAQs25hGnAq-hn@casper.infradead.org>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-5-david@redhat.com>
 <D80D504B-20FC-4C2B-98EB-7694E9BAD64C@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D80D504B-20FC-4C2B-98EB-7694E9BAD64C@nvidia.com>

On Wed, Jun 18, 2025 at 02:04:18PM -0400, Zi Yan wrote:
> > Let's allow for not clearing a page type before freeing a page to the
> > buddy.
> >
> > We'll focus on having a type set on the first page of a larger
> > allocation only.
> >
> > With this change, we can reliably identify typed folios even though
> > they might be in the process of getting freed, which will come in handy
> > in migration code (at least in the transition phase).

> > +	if (unlikely(page_has_type(page)))
> > +		page->page_type = UINT_MAX;
> > +
> >  	if (is_check_pages_enabled()) {
> >  		if (free_page_is_bad(page))
> >  			bad++;
> > -- 
> > 2.49.0
> 
> How does this preserve page type? Isn’t page->page_type = UINT_MAX clearing
> page_type?

The point is that the _caller_ used to have to clear the page type.
This patch allows the caller to free the page without clearing
the page type first.

