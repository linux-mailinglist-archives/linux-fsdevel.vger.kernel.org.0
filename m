Return-Path: <linux-fsdevel+bounces-19124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1AF8C04E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 21:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33D3282395
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 19:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AE8130A5B;
	Wed,  8 May 2024 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T5J88gsR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263E11272B2;
	Wed,  8 May 2024 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196236; cv=none; b=XxRnX1ncQtfC0/7O2FLnte8KtYeAKVkAjDbHXZmM3oFFbZlCWCARgupLmeNjzsYYydZ5wF2X4Yb1yU1TbFbef8/lbspneboGYeqx2wWctB2QFKVZ1AabWOJUsyjgJ7ac9fJSjDU2RWJOUXDzKlh8MdsFTLGHulyNp2ZsGZ6EWBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196236; c=relaxed/simple;
	bh=GHuER5dbfZxlowizuRnXdNSV4RfCN5Z1qKuPNP9FXLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PycnjuUrmv9THdX89et1kd1txcYXs5Tr0gt0i8P2OC8JIFaG/WD1BVeVoZBvdC80RS0qPnqXrD7ZE/bp43Dwi3hMatUwJnyy81FICgGDKUruth7ZmTndH5Mco/p1cu7xU8I1q32piX9f/QkTu/KIajXq2Y4mvkw19ZRYZtwSbI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T5J88gsR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=owcYIBhREu30dQ7gp++xwkQ2QSY2wtlTxlrzCTL5bZI=; b=T5J88gsRvVqm7VXMGnlAXqj71K
	wogB+O1qSZcA3PbIWP8DCHh9ewoZQ3J5vwkhHhuyEPlhUJnobg2cuYu5Y5dca8RpEJjOPfM6Pt03B
	Pe+t/WCDCTXomOu/5YkL3h2wfP8s0sO1pER6ZmMtYxZ9VjfWUWTXEM7btge5E/kDl4YVNJeU7YRmj
	AyRdEJGilqUgwVkH1M2s5Ju9R8geUvTTb1iM/GLRS5dfmkEsVI4ze+tK7OIAbMH5McIRcPJ34Pa+E
	WawfRDbj+ExplViquzo2kLxJ3GvTB7Q+oGJfKxOpAnOZC6sElHOJfRqMhzErfPuFCXwWz3XgM074C
	ZWFoHYjw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4mtA-0000000GiK0-1rbQ;
	Wed, 08 May 2024 19:23:40 +0000
Date: Wed, 8 May 2024 12:23:40 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Lameter <christoph@lameter.com>,
	Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>
Cc: Daniel Gomez <da.gomez@samsung.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hughd@google.com" <hughd@google.com>,
	"ioworker0@gmail.com" <ioworker0@gmail.com>,
	"wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
	"ying.huang@intel.com" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"shy828301@gmail.com" <shy828301@gmail.com>,
	"ziy@nvidia.com" <ziy@nvidia.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/8] add mTHP support for anonymous shmem
Message-ID: <ZjvRPLaXQewA8K4s@bombadil.infradead.org>
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <CGME20240508113934eucas1p13a3972f3f9955365f40155e084a7c7d5@eucas1p1.samsung.com>
 <fqtaxc5pgu3zmvbdad4w6xty5iozye7v5z2b5ckqcjv273nz7b@hhdrjwf6rai3>
 <f44dc19a-e117-4418-9114-b723c5dc1178@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f44dc19a-e117-4418-9114-b723c5dc1178@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, May 08, 2024 at 01:58:19PM +0200, David Hildenbrand wrote:
> On 08.05.24 13:39, Daniel Gomez wrote:
> > On Mon, May 06, 2024 at 04:46:24PM +0800, Baolin Wang wrote:
> > > The primary strategy is similar to supporting anonymous mTHP. Introduce
> > > a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
> > > which can have all the same values as the top-level
> > > '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
> > > additional "inherit" option. By default all sizes will be set to "never"
> > > except PMD size, which is set to "inherit". This ensures backward compatibility
> > > with the shmem enabled of the top level, meanwhile also allows independent
> > > control of shmem enabled for each mTHP.
> > 
> > I'm trying to understand the adoption of mTHP and how it fits into the adoption
> > of (large) folios that the kernel is moving towards. Can you, or anyone involved
> > here, explain this? How much do they overlap, and can we benefit from having
> > both? Is there any argument against the adoption of large folios here that I
> > might have missed?
> 
> mTHP are implemented using large folios, just like traditional PMD-sized THP
> are.
> 
> The biggest challenge with memory that cannot be evicted on memory pressure
> to be reclaimed (in contrast to your ordinary files in the pagecache) is
> memory waste, well, and placement of large chunks of memory in general,
> during page faults.
> 
> In the worst case (no swap), you allocate a large chunk of memory once and
> it will stick around until freed: no reclaim of that memory.
> 
> That's the reason why THP for anonymous memory and SHMEM have toggles to
> manually enable and configure them, in contrast to the pagecache. The same
> was done for mTHP for anonymous memory, and now (anon) shmem follows.
> 
> There are plans to have, at some point, have it all working automatically,
> but a lot for that for anonymous memory (and shmem similarly) is still
> missing and unclear.

Whereas the use for large folios for filesystems is already automatic,
so long as the filesystem supports it. We do this in readahead and write
path already for iomap, we opportunistically use large folios if we can,
otherwise we use smaller folios.

So a recommended approach by Matthew was to use the readahead and write
path, just as in iomap to determine the size of the folio to use [0].
The use of large folios would also be automatic and not require any
knobs at all.

The mTHP approach would be growing the "THP" use in filesystems by the
only single filesystem to use THP. Meanwhile use of large folios is already
automatic with the approach taken by iomap.

We're at a crux where it does beg the question if we should continue to
chug on with tmpfs being special and doing things differently extending
the old THP interface with mTHP, or if it should just use large folios
using the same approach as iomap did.

From my perspective the more shared code the better, and the more shared
paths the better. There is a chance to help test swap with large folios
instead of splitting the folios for swap, and that would could be done
first with tmpfs. I have not evaluated the difference in testing or how
we could get the most of shared code if we take a mTHP approach or the
iomap approach for tmpfs, that should be considered.

Are there other things to consider? Does this require some dialog at
LSFMM?

[0] https://lore.kernel.org/all/ZHD9zmIeNXICDaRJ@casper.infradead.org/

  Luis

