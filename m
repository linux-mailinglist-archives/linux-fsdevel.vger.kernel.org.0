Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AC56A8CDB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 00:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCBXSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 18:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBXSO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:18:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E73A59415
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 15:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677799010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eE9Pafa530L5JjpUU74EsDdw6S9K1gsLvm9PBz92W8=;
        b=SPhkFSgxWifBjmP1F1Jt8+5V5ymjtD88Y1PhXux1hRWFp8xLu7bkdjvx43uMo5e5FuDwzb
        0lyMhv1VTSa4sDvHe09iOo32qGI8x1+wWdgtAlYcZwxiEpXiS28h0QyfFJ7qGE+LNduVMs
        qriuZS57zHc5oBa88MieKb0HDN+Xna0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-zwFLchJEPOeBqPxHgNImPw-1; Thu, 02 Mar 2023 18:16:47 -0500
X-MC-Unique: zwFLchJEPOeBqPxHgNImPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 630DB800B23;
        Thu,  2 Mar 2023 23:16:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54038440D9;
        Thu,  2 Mar 2023 23:16:44 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Paulo Alcantara <pc@cjr.nz>, Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve French <sfrench@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH 1/3] mm: Add a function to get a single tagged folio from a file
Date:   Thu,  2 Mar 2023 23:16:36 +0000
Message-Id: <20230302231638.521280-2-dhowells@redhat.com>
In-Reply-To: <20230302231638.521280-1-dhowells@redhat.com>
References: <20230302231638.521280-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a function to get a single tagged folio from a file rather than a batch
for use in afs and cifs where, in the common case, the batch is likely to
be rendered irrelevant by the {afs,cifs}_extend_writeback() function.

For filemap_get_folios_tag() to be of use, the batch has to be passed down,
and if it contains scattered, non-contiguous folios, these are likely to
end up being pinned by the batch for significant periods of time whilst I/O
is undertaken on earlier pages.

Further, for write_cache_pages() to be useful, it would need to wait for
PG_fscache which is used to indicate that I/O is in progress from a folio to
the cache - but it can't do this unconditionally as some filesystems, such
as btrfs, use PG_private_2 for other purposes.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/2214157.1677250083@warthog.procyon.org.uk/
---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 58 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0acb8e1fb7af..577535633006 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -741,6 +741,8 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
 unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch);
+struct folio *filemap_get_folio_tag(struct address_space *mapping, pgoff_t *start,
+				    pgoff_t end, xa_mark_t tag);
 
 struct page *grab_cache_page_write_begin(struct address_space *mapping,
 			pgoff_t index);
diff --git a/mm/filemap.c b/mm/filemap.c
index 2723104cc06a..1b1e9c661018 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2339,6 +2339,64 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 }
 EXPORT_SYMBOL(filemap_get_folios_tag);
 
+/**
+ * filemap_get_folio_tag - Get the first folio matching @tag
+ * @mapping:    The address_space to search
+ * @start:      The starting page index
+ * @end:        The final page index (inclusive)
+ * @tag:        The tag index
+ *
+ * Search for and return the first folios in the mapping starting at index
+ * @start and up to index @end (inclusive).  The folio is returned with an
+ * elevated reference count.
+ *
+ * If a folio is returned, it may start before @start; if it does, it will
+ * contain @start.  The folio may also extend beyond @end; if it does, it will
+ * contain @end.  If folios are added to or removed from the page cache while
+ * this is running, they may or may not be found by this call.
+ *
+ * Return: The folio that was found or NULL.  @start is also updated to index
+ * the next folio for the traversal or will be left pointing after @end.
+ */
+struct folio *filemap_get_folio_tag(struct address_space *mapping, pgoff_t *start,
+				    pgoff_t end, xa_mark_t tag)
+{
+	XA_STATE(xas, &mapping->i_pages, *start);
+	struct folio *folio;
+
+	rcu_read_lock();
+	while ((folio = find_get_entry(&xas, end, tag)) != NULL) {
+		/*
+		 * Shadow entries should never be tagged, but this iteration
+		 * is lockless so there is a window for page reclaim to evict
+		 * a page we saw tagged. Skip over it.
+		 */
+		if (xa_is_value(folio))
+			continue;
+
+		if (folio_test_hugetlb(folio))
+			*start = folio->index + 1;
+		else
+			*start = folio_next_index(folio);
+		goto out;
+	}
+
+	/*
+	 * We come here when there is no page beyond @end. We take care to not
+	 * overflow the index @start as it confuses some of the callers. This
+	 * breaks the iteration when there is a page at index -1 but that is
+	 * already broke anyway.
+	 */
+	if (end == (pgoff_t)-1)
+		*start = (pgoff_t)-1;
+	else
+		*start = end + 1;
+out:
+	rcu_read_unlock();
+	return folio;
+}
+EXPORT_SYMBOL(filemap_get_folio_tag);
+
 /*
  * CD/DVDs are error prone. When a medium error occurs, the driver may fail
  * a _large_ part of the i/o request. Imagine the worst scenario:

