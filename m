Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E320E25AFBB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgIBPor (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:44:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728274AbgIBPoo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599061482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IeD2eb+VWg5M7oUOKQXGVzViS6gT7J8CCXVfRF+579k=;
        b=OZCfuR5hHwjKjvYOu918RLihhqkIHLU+PkGkZWUs5Vn98MAue51UxWDdWhdWMZBwd/y3iI
        l1ZVgkJtWxlcowJIMz91Lagowg9tHyirtAxK/+19bjPN0M3Cv7D/0V7CguZVeEAp7ORpaT
        0BMqmGtlCcIyfXiQTcCzJif7TZs8ysM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-gjU1a_hpMMef0Lw4gx0kRQ-1; Wed, 02 Sep 2020 11:44:41 -0400
X-MC-Unique: gjU1a_hpMMef0Lw4gx0kRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED54610ABDB1;
        Wed,  2 Sep 2020 15:44:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-6.rdu2.redhat.com [10.10.113.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D77025D9CC;
        Wed,  2 Sep 2020 15:44:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 3/6] mm: Push readahead_control down into
 force_page_cache_readahead() [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Sep 2020 16:44:38 +0100
Message-ID: <159906147806.663183.767620073654469472.stgit@warthog.procyon.org.uk>
In-Reply-To: <159906145700.663183.3678164182141075453.stgit@warthog.procyon.org.uk>
References: <159906145700.663183.3678164182141075453.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Push readahead_control down into force_page_cache_readahead() from its
callers in preparation for making do_sync_mmap_readahead() pass down an RAC
struct.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 mm/fadvise.c   |    5 ++++-
 mm/internal.h  |    3 +--
 mm/readahead.c |   19 +++++++++++--------
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/mm/fadvise.c b/mm/fadvise.c
index 0e66f2aaeea3..997f7c16690a 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -104,7 +104,10 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 		if (!nrpages)
 			nrpages = ~0UL;
 
-		force_page_cache_readahead(mapping, file, start_index, nrpages);
+		{
+			DEFINE_READAHEAD(rac, file, mapping, start_index);
+			force_page_cache_readahead(&rac, nrpages);
+		}
 		break;
 	case POSIX_FADV_NOREUSE:
 		break;
diff --git a/mm/internal.h b/mm/internal.h
index bf2bee6c42a1..c8ccf208f524 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -49,8 +49,7 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
 
-void force_page_cache_readahead(struct address_space *, struct file *,
-		pgoff_t index, unsigned long nr_to_read);
+void force_page_cache_readahead(struct readahead_control *, unsigned long);
 void __do_page_cache_readahead(struct readahead_control *,
 		unsigned long nr_to_read, unsigned long lookahead_size);
 
diff --git a/mm/readahead.c b/mm/readahead.c
index e3e3419dfe3d..366357e6e845 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -271,13 +271,13 @@ void __do_page_cache_readahead(struct readahead_control *rac,
  * Chunk the readahead into 2 megabyte units, so that we don't pin too much
  * memory at once.
  */
-void force_page_cache_readahead(struct address_space *mapping,
-		struct file *file, pgoff_t index, unsigned long nr_to_read)
+void force_page_cache_readahead(struct readahead_control *rac,
+		unsigned long nr_to_read)
 {
-	DEFINE_READAHEAD(rac, file, mapping, index);
+	struct address_space *mapping = rac->mapping;
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
-	struct file_ra_state *ra = &file->f_ra;
-	unsigned long max_pages;
+	struct file_ra_state *ra = &rac->file->f_ra;
+	unsigned long max_pages, index;
 
 	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages &&
 			!mapping->a_ops->readahead))
@@ -287,14 +287,17 @@ void force_page_cache_readahead(struct address_space *mapping,
 	 * If the request exceeds the readahead window, allow the read to
 	 * be up to the optimal hardware IO size
 	 */
+	index = readahead_index(rac);
 	max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
-	nr_to_read = min(nr_to_read, max_pages);
+	nr_to_read = min_t(unsigned long, nr_to_read, max_pages);
 	while (nr_to_read) {
 		unsigned long this_chunk = (2 * 1024 * 1024) / PAGE_SIZE;
 
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
-		__do_page_cache_readahead(&rac, this_chunk, 0);
+
+		rac->_index = index;
+		__do_page_cache_readahead(rac, this_chunk, 0);
 
 		index += this_chunk;
 		nr_to_read -= this_chunk;
@@ -656,7 +659,7 @@ void page_cache_sync_readahead(struct address_space *mapping,
 
 	/* be dumb */
 	if (filp && (filp->f_mode & FMODE_RANDOM)) {
-		force_page_cache_readahead(mapping, filp, index, req_count);
+		force_page_cache_readahead(&rac, req_count);
 		return;
 	}
 


