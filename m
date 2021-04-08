Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103D53585BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 16:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhDHOF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 10:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231856AbhDHOFY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617890713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+6MnupnFDHFPZGHm23L4GDfJd1a71lLkyYkmFy7lC8=;
        b=UZ9rdf1Yi/8wA1zE2h0ZTVuBr1RBFINC2uvvbAScn9WevXM98Hm4lU1kSJ11IZXdRmfqgq
        frFTGhd1WOcYt6+1+Xb07nR3rHItkUHB8Qcr2YSVrvkOYCYh8ezyt4wuiIf9v/8Ed1wnzo
        DByiuR2Y0qZ1rVDaobWEBgyHa5WdGsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-u2ujEYsSN3GB5M1nLFlduA-1; Thu, 08 Apr 2021 10:05:09 -0400
X-MC-Unique: u2ujEYsSN3GB5M1nLFlduA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC4578189CB;
        Thu,  8 Apr 2021 14:05:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E1635C1C5;
        Thu,  8 Apr 2021 14:04:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 05/30] mm: Implement readahead_control pageset expansion
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Mike Marshall <hubcap@omnibond.com>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        dhowells@redhat.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Thu, 08 Apr 2021 15:04:58 +0100
Message-ID: <161789069829.6155.4295672417565512161.stgit@warthog.procyon.org.uk>
In-Reply-To: <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
References: <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a function, readahead_expand(), that expands the set of pages
specified by a readahead_control object to encompass a revised area with a
proposed size and length.

The proposed area must include all of the old area and may be expanded yet
more by this function so that the edges align on (transparent huge) page
boundaries as allocated.

The expansion will be cut short if a page already exists in either of the
areas being expanded into.  Note that any expansion made in such a case is
not rolled back.

This will be used by fscache so that reads can be expanded to cache granule
boundaries, thereby allowing whole granules to be stored in the cache, but
there are other potential users also.

Changes:
v6:
- Fold in a patch from Matthew Wilcox to tell the ondemand readahead
  algorithm about the expansion so that the next readahead starts at the
  right place[2].

v4:
- Moved the declaration of readahead_expand() to a better place[1].

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christoph Hellwig <hch@lst.de>
cc: Mike Marshall <hubcap@omnibond.com>
cc: linux-mm@kvack.org
cc: linux-cachefs@redhat.com
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: ceph-devel@vger.kernel.org
cc: v9fs-developer@lists.sourceforge.net
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20210217161358.GM2858050@casper.infradead.org/ [1]
Link: https://lore.kernel.org/r/159974633888.2094769.8326206446358128373.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/160588479816.3465195.553952688795241765.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161118131787.1232039.4863969952441067985.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161161028670.2537118.13831420617039766044.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/161340389201.1303470.14353807284546854878.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/161539530488.286939.18085961677838089157.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/161653789422.2770958.2108046612147345000.stgit@warthog.procyon.org.uk/ # v5
Link: https://lore.kernel.org/r/20210407201857.3582797-4-willy@infradead.org/ [2]
---

 include/linux/pagemap.h |    2 +
 mm/readahead.c          |   75 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 9a9e558ce4c7..ef511364cc0c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -838,6 +838,8 @@ void page_cache_ra_unbounded(struct readahead_control *,
 void page_cache_sync_ra(struct readahead_control *, unsigned long req_count);
 void page_cache_async_ra(struct readahead_control *, struct page *,
 		unsigned long req_count);
+void readahead_expand(struct readahead_control *ractl,
+		      loff_t new_start, size_t new_len);
 
 /**
  * page_cache_sync_readahead - generic file readahead
diff --git a/mm/readahead.c b/mm/readahead.c
index 2088569a947e..f02dbebf1cef 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -638,3 +638,78 @@ SYSCALL_DEFINE3(readahead, int, fd, loff_t, offset, size_t, count)
 {
 	return ksys_readahead(fd, offset, count);
 }
+
+/**
+ * readahead_expand - Expand a readahead request
+ * @ractl: The request to be expanded
+ * @new_start: The revised start
+ * @new_len: The revised size of the request
+ *
+ * Attempt to expand a readahead request outwards from the current size to the
+ * specified size by inserting locked pages before and after the current window
+ * to increase the size to the new window.  This may involve the insertion of
+ * THPs, in which case the window may get expanded even beyond what was
+ * requested.
+ *
+ * The algorithm will stop if it encounters a conflicting page already in the
+ * pagecache and leave a smaller expansion than requested.
+ *
+ * The caller must check for this by examining the revised @ractl object for a
+ * different expansion than was requested.
+ */
+void readahead_expand(struct readahead_control *ractl,
+		      loff_t new_start, size_t new_len)
+{
+	struct address_space *mapping = ractl->mapping;
+	struct file_ra_state *ra = ractl->ra;
+	pgoff_t new_index, new_nr_pages;
+	gfp_t gfp_mask = readahead_gfp_mask(mapping);
+
+	new_index = new_start / PAGE_SIZE;
+
+	/* Expand the leading edge downwards */
+	while (ractl->_index > new_index) {
+		unsigned long index = ractl->_index - 1;
+		struct page *page = xa_load(&mapping->i_pages, index);
+
+		if (page && !xa_is_value(page))
+			return; /* Page apparently present */
+
+		page = __page_cache_alloc(gfp_mask);
+		if (!page)
+			return;
+		if (add_to_page_cache_lru(page, mapping, index, gfp_mask) < 0) {
+			put_page(page);
+			return;
+		}
+
+		ractl->_nr_pages++;
+		ractl->_index = page->index;
+	}
+
+	new_len += new_start - readahead_pos(ractl);
+	new_nr_pages = DIV_ROUND_UP(new_len, PAGE_SIZE);
+
+	/* Expand the trailing edge upwards */
+	while (ractl->_nr_pages < new_nr_pages) {
+		unsigned long index = ractl->_index + ractl->_nr_pages;
+		struct page *page = xa_load(&mapping->i_pages, index);
+
+		if (page && !xa_is_value(page))
+			return; /* Page apparently present */
+
+		page = __page_cache_alloc(gfp_mask);
+		if (!page)
+			return;
+		if (add_to_page_cache_lru(page, mapping, index, gfp_mask) < 0) {
+			put_page(page);
+			return;
+		}
+		ractl->_nr_pages++;
+		if (ra) {
+			ra->size++;
+			ra->async_size++;
+		}
+	}
+}
+EXPORT_SYMBOL(readahead_expand);


