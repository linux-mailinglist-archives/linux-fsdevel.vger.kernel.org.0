Return-Path: <linux-fsdevel+bounces-21653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0747C9076A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 17:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043291C23226
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88B7149E01;
	Thu, 13 Jun 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZvsXJYxP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92AC149C52;
	Thu, 13 Jun 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292459; cv=none; b=I9+cwDMX38sUsAwRhU5RSgdUVrP5ERPGKPtimJ/yP2MEMM5SmjaEI7HczjlQPIh+xqXXiT+zZtyuMw6egCczB0ZODinq/1mHJqBQ9u2+zqm1tL+sc6Ys75YphtWXjmcDEFnG6/uqvv6dUsNb/h1v37ByHLE8e1G18T+FA2AC9zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292459; c=relaxed/simple;
	bh=nGyWR1dJ/Cx1/kNOjC/sFq0kgMjjBZAKk9JiNCTt1nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ie8NWejDKrQszXvnnABekTrmd3b/Um2o6SKKy1+nul9x+u2yEzetG4CFm+sY4YA5Z0dgwXASUlbPuXBAPgYbiL6pahj40jW44pJZENXUhIfI1D4e/1b7dOzYA3DwPB3ynHtVBuXlI1H+4DMnu1zOZb8m5Ydwo0a15AsjzqwByAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZvsXJYxP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LGtsgFmy+c+3jY1klBtEAn+SFOvN7+PibxqK++aoOQw=; b=ZvsXJYxP8UkMA2jQImJwq9hj8k
	lnMacW7gxkiWWjInImcqZHz6qwzqOxkqqK5ifqaleu1y5CPmgGsrjqjzXgNmwhEr/fBbfxqnMIpQd
	vza3Ug5c25Bgj8dwzQerlRaE5w/hl0FC2kppP1KTGuZXYymgQPndNEfAvFQiAaGeLJcIwqTntKwj6
	VimCBobGx4Zds43cmQCEG5jPxWtqeS9hSyj1se5p1KfvJ7+qNL1FUQJHyHu3W6tPH0mUX4D1MrVTM
	tbBBKbOLZmpABQNmBS0kJSUb+UpJOQeO8Wx8fIPqKWH7nLGgtoGoXk2anaroCu+J7rqqmauuZ8bJn
	PL3MtXiA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHmMJ-0000000HAMB-4A70;
	Thu, 13 Jun 2024 15:27:27 +0000
Date: Thu, 13 Jun 2024 08:27:27 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
	yang@os.amperecomputing.com, linmiaohe@huawei.com,
	muchun.song@linux.dev, osalvador@suse.de,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	hare@suse.de, linux-kernel@vger.kernel.org,
	Zi Yan <zi.yan@sent.com>, linux-xfs@vger.kernel.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: Re: [PATCH v7 06/11] filemap: cap PTE range to be created to allowed
 zero fill in folio_map_range()
Message-ID: <ZmsP36zmg2-hgtak@bombadil.infradead.org>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-7-kernel@pankajraghav.com>
 <ZmnyH_ozCxr_NN_Z@casper.infradead.org>
 <ZmqmWrzmL5Wx2DoF@bombadil.infradead.org>
 <818f69fa-9dc7-4ca0-b3ab-a667cd1fb16d@redhat.com>
 <ZmqqIrv4Fms-Vi6E@bombadil.infradead.org>
 <b3fef638-4f4a-4688-8a39-8dfa4ae88836@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3fef638-4f4a-4688-8a39-8dfa4ae88836@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Jun 13, 2024 at 10:16:10AM +0200, David Hildenbrand wrote:
> On 13.06.24 10:13, Luis Chamberlain wrote:
> > On Thu, Jun 13, 2024 at 10:07:15AM +0200, David Hildenbrand wrote:
> > > On 13.06.24 09:57, Luis Chamberlain wrote:
> > > > On Wed, Jun 12, 2024 at 08:08:15PM +0100, Matthew Wilcox wrote:
> > > > > On Fri, Jun 07, 2024 at 02:58:57PM +0000, Pankaj Raghav (Samsung) wrote:
> > > > > > From: Pankaj Raghav <p.raghav@samsung.com>
> > > > > > 
> > > > > > Usually the page cache does not extend beyond the size of the inode,
> > > > > > therefore, no PTEs are created for folios that extend beyond the size.
> > > > > > 
> > > > > > But with LBS support, we might extend page cache beyond the size of the
> > > > > > inode as we need to guarantee folios of minimum order. Cap the PTE range
> > > > > > to be created for the page cache up to the max allowed zero-fill file
> > > > > > end, which is aligned to the PAGE_SIZE.
> > > > > 
> > > > > I think this is slightly misleading because we might well zero-fill
> > > > > to the end of the folio.  The issue is that we're supposed to SIGBUS
> > > > > if userspace accesses pages which lie entirely beyond the end of this
> > > > > file.  Can you rephrase this?
> > > > > 
> > > > > (from mmap(2))
> > > > >          SIGBUS Attempted access to a page of the buffer that lies beyond the end
> > > > >                 of the mapped file.  For an explanation of the treatment  of  the
> > > > >                 bytes  in  the  page that corresponds to the end of a mapped file
> > > > >                 that is not a multiple of the page size, see NOTES.
> > > > > 
> > > > > 
> > > > > The code is good though.
> > > > > 
> > > > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > 
> > > > Since I've been curating the respective fstests test to test for this
> > > > POSIX corner case [0] I wanted to enable the test for tmpfs instead of
> > > > skipping it as I originally had it, and that meant also realizing mmap(2)
> > > > specifically says this now:
> > > > 
> > > > Huge page (Huge TLB) mappings
> > > 
> > > Confusion alert: this likely talks about hugetlb (MAP_HUGETLB), not THP and
> > > friends.
> > > 
> > > So it might not be required for below changes.
> > 
> > Thanks, I had to ask as we're dusting off this little obscure corner of
> > the universe. Reason I ask, is the test fails for tmpfs with huge pages,
> > and this patch fixes it, but it got me wondering the above applies also
> > to tmpfs with huge pages.
> 
> Is it tmpfs with THP/large folios or shmem with hugetlb? I assume the tmpfs
> with THP. There are not really mmap/munmap restrictions to THP and friends
> (because it's supposed to be "transparent" :) ).

The case I tested that failed the test was tmpfs with huge pages (not
large folios). So should we then have this:

diff --git a/mm/filemap.c b/mm/filemap.c
index ea78963f0956..649beb9bbc6b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3617,6 +3617,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	vm_fault_t ret = 0;
 	unsigned long rss = 0;
 	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
+	unsigned int align = PAGE_SIZE;
 
 	rcu_read_lock();
 	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
@@ -3636,7 +3637,16 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		goto out;
 	}
 
-	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
+	/*
+	 * As per the mmap(2) mmap(), the offset must be a multiple of the
+	 * underlying huge page size. The system automatically aligns length to
+	 * be a multiple of the underlying huge page size.
+	 */
+	if (folio_test_pmd_mappable(folio) &&
+	    (shmem_mapping(mapping) || folio_test_hugetlb(folio)))
+		align = 1 << folio_order(folio);
+
+	file_end = DIV_ROUND_UP(i_size_read(mapping->host), align) - 1;
 	if (end_pgoff > file_end)
 		end_pgoff = file_end;
 

