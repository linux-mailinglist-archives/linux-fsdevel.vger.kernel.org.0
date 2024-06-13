Return-Path: <linux-fsdevel+bounces-21607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F40906601
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 09:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F286281A87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 07:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04B813E3F5;
	Thu, 13 Jun 2024 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ufiRXK33"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BA213E03B;
	Thu, 13 Jun 2024 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265449; cv=none; b=RfmMKR9Vf87zN1DyI455c4yrK5snbObuQ03H4ChT9oc6Lfmw7YHTGtk3srteRCrU+ACEaoBW/NnaHbkiRUk6SwzKbbZGkf6Vtj4EdF3PMmLKx16YXvHvu/cveM+4opHbf3WSgor5HuGPJZh7kpWiYbzohH8cnAedUmbAtLYGgqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265449; c=relaxed/simple;
	bh=jZlE+jfvSGYynwcdqzbwfSCHe1JnKMQ9kdgo8UQiW0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxLLxkW7uRTyQ9tmfzjzCxKA3nckkVGL9jQkzWndIO560QRs8r3OYETbd4c4/wqQzgXGax0huS0L+dDWwY8BXj26rK8h22BlUGnDe2XrQciqxznIjDMii+b8vYdF/DwVUZzoLp84IGDZOxYOtkNbR+vNB8TG8plqZQlwnyccEec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ufiRXK33; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=79yFZYpSBlXzMXdhcFqLZ1+QEuQndmTfBg2z7dCBcsQ=; b=ufiRXK33iwPT52qMweawk+OWHz
	UHy76pHAoq4FtanliK55TY0PAhlq8bdzpGxLhXU7aMNxsbkShMh1E3thr/ooRajcAqRzIFfUtY8mi
	79YvdhtpJNLRRlIop6Tq9eT4ltptxwXXe8VEkHqLyxhDU9j3PmqH4dvK/kT9U1PIOwo+esP9BTFhS
	pExIIix2k1NIiFrjOm0ZfiWnrNMYhZOxhRR1fKKERHZ8WURp2MP4MwqqeNlfTf5EUczDN+cOPQVn4
	mCYoMgeMmQmtpG2Y0pqGoqWj5VmT/SvAi1Br10KqisT75BbPayg3B4lcdmwqBZ/g2wGHd5xsfrYGo
	kT32WvGA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHfKc-0000000FaHy-2BAQ;
	Thu, 13 Jun 2024 07:57:14 +0000
Date: Thu, 13 Jun 2024 00:57:14 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>, yang@os.amperecomputing.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	hare@suse.de, linux-kernel@vger.kernel.org,
	Zi Yan <zi.yan@sent.com>, linux-xfs@vger.kernel.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: Re: [PATCH v7 06/11] filemap: cap PTE range to be created to allowed
 zero fill in folio_map_range()
Message-ID: <ZmqmWrzmL5Wx2DoF@bombadil.infradead.org>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-7-kernel@pankajraghav.com>
 <ZmnyH_ozCxr_NN_Z@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmnyH_ozCxr_NN_Z@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Jun 12, 2024 at 08:08:15PM +0100, Matthew Wilcox wrote:
> On Fri, Jun 07, 2024 at 02:58:57PM +0000, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > Usually the page cache does not extend beyond the size of the inode,
> > therefore, no PTEs are created for folios that extend beyond the size.
> > 
> > But with LBS support, we might extend page cache beyond the size of the
> > inode as we need to guarantee folios of minimum order. Cap the PTE range
> > to be created for the page cache up to the max allowed zero-fill file
> > end, which is aligned to the PAGE_SIZE.
> 
> I think this is slightly misleading because we might well zero-fill
> to the end of the folio.  The issue is that we're supposed to SIGBUS
> if userspace accesses pages which lie entirely beyond the end of this
> file.  Can you rephrase this?
> 
> (from mmap(2))
>        SIGBUS Attempted access to a page of the buffer that lies beyond the end
>               of the mapped file.  For an explanation of the treatment  of  the
>               bytes  in  the  page that corresponds to the end of a mapped file
>               that is not a multiple of the page size, see NOTES.
> 
> 
> The code is good though.
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Since I've been curating the respective fstests test to test for this
POSIX corner case [0] I wanted to enable the test for tmpfs instead of
skipping it as I originally had it, and that meant also realizing mmap(2)
specifically says this now:

Huge page (Huge TLB) mappings
...
       For mmap(), offset must be a multiple of the underlying huge page
       size. The system automatically aligns length to be a multiple of
       the underlying huge page size.

So do we need to adjust this patch with this:

diff --git a/mm/filemap.c b/mm/filemap.c
index ea78963f0956..9c8897ba90ff 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3617,6 +3617,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	vm_fault_t ret = 0;
 	unsigned long rss = 0;
 	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
+	unsigned int align = PAGE_SIZE;
 
 	rcu_read_lock();
 	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
@@ -3636,7 +3637,10 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		goto out;
 	}
 
-	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
+	if (folio_test_pmd_mappable(folio))
+		align = 1 << folio_order(folio);
+
+	file_end = DIV_ROUND_UP(i_size_read(mapping->host), align) - 1;
 	if (end_pgoff > file_end)
 		end_pgoff = file_end;

[0] https://lore.kernel.org/all/20240611030203.1719072-3-mcgrof@kernel.org/

  Luis

