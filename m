Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FA425989A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbgIAQ2w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 12:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731087AbgIAQ2q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598977724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QThCaj3yKRlrpSDZKjm2r3cHMRA+tuJqvE+bEULa31k=;
        b=NfVDufuv8+DG4Up65gBqDwPgmFuy0/m0UwmPmy3MjV4MYbfS7pW5ykAx9tqGlyiPgdb2a0
        pRXHQmdziKUmFHeOar9Y38QUAaFge0FHNdvPemaDbX85oXREV2KZ6+baW0PVqDEMFjUXkl
        yDKA2oL3oyIL32jfehoLontRsecXbdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223--a5lUd7MOXaS6lKak9CuOQ-1; Tue, 01 Sep 2020 12:28:40 -0400
X-MC-Unique: -a5lUd7MOXaS6lKak9CuOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A14051007467;
        Tue,  1 Sep 2020 16:28:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-231.rdu2.redhat.com [10.10.113.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C40378B40;
        Tue,  1 Sep 2020 16:28:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 3/7] mm: Push readahead_control down into
 force_page_cache_readahead()
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 01 Sep 2020 17:28:37 +0100
Message-ID: <159897771776.405783.305183815956274924.stgit@warthog.procyon.org.uk>
In-Reply-To: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
References: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Push readahead_control down into force_page_cache_readahead() from its
callers in preparation for making do_sync_mmap_readahead() pass down an RAC
struct.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 mm/fadvise.c   |    6 +++++-
 mm/internal.h  |    3 +--
 mm/readahead.c |   20 ++++++++++++--------
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/mm/fadvise.c b/mm/fadvise.c
index 0e66f2aaeea3..b68d2f2959d5 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -104,7 +104,11 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 		if (!nrpages)
 			nrpages = ~0UL;
 
-		force_page_cache_readahead(mapping, file, start_index, nrpages);
+		{
+			DEFINE_READAHEAD(rac, file, mapping, start_index);
+			rac._nr_pages = nrpages;
+			force_page_cache_readahead(&rac);
+		}
 		break;
 	case POSIX_FADV_NOREUSE:
 		break;
diff --git a/mm/internal.h b/mm/internal.h
index bf2bee6c42a1..2eb9f7f5f134 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -49,8 +49,7 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
 
-void force_page_cache_readahead(struct address_space *, struct file *,
-		pgoff_t index, unsigned long nr_to_read);
+void force_page_cache_readahead(struct readahead_control *);
 void __do_page_cache_readahead(struct readahead_control *,
 		unsigned long nr_to_read, unsigned long lookahead_size);
 
diff --git a/mm/readahead.c b/mm/readahead.c
index 0e16fb4809f5..e557c6d5a183 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -271,13 +271,12 @@ void __do_page_cache_readahead(struct readahead_control *rac,
  * Chunk the readahead into 2 megabyte units, so that we don't pin too much
  * memory at once.
  */
-void force_page_cache_readahead(struct address_space *mapping,
-		struct file *file, pgoff_t index, unsigned long nr_to_read)
+void force_page_cache_readahead(struct readahead_control *rac)
 {
-	DEFINE_READAHEAD(rac, file, mapping, index);
+	struct address_space *mapping = rac->mapping;
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
-	struct file_ra_state *ra = &file->f_ra;
-	unsigned long max_pages;
+	struct file_ra_state *ra = &rac->file->f_ra;
+	unsigned long max_pages, index, nr_to_read;
 
 	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages &&
 			!mapping->a_ops->readahead))
@@ -287,14 +286,19 @@ void force_page_cache_readahead(struct address_space *mapping,
 	 * If the request exceeds the readahead window, allow the read to
 	 * be up to the optimal hardware IO size
 	 */
+	index = readahead_index(rac);
 	max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
-	nr_to_read = min(nr_to_read, max_pages);
+	nr_to_read = min_t(unsigned long, readahead_count(rac), max_pages);
 	while (nr_to_read) {
 		unsigned long this_chunk = (2 * 1024 * 1024) / PAGE_SIZE;
 
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
-		__do_page_cache_readahead(&rac, this_chunk, 0);
+
+		rac->_index = index;
+		rac->_nr_pages = this_chunk;
+		// Do I need to modify rac->_batch_count?
+		__do_page_cache_readahead(rac, this_chunk, 0);
 
 		index += this_chunk;
 		nr_to_read -= this_chunk;
@@ -658,7 +662,7 @@ void page_cache_sync_readahead(struct address_space *mapping,
 
 	/* be dumb */
 	if (filp && (filp->f_mode & FMODE_RANDOM)) {
-		force_page_cache_readahead(mapping, filp, index, req_count);
+		force_page_cache_readahead(&rac);
 		return;
 	}
 


