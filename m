Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A1A334470
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 18:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhCJRAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 12:00:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233581AbhCJQ7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615395592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0NFc/6bTxidZIbh3ksStRf2pMhjGVlLFuNwIaLmNRWM=;
        b=JxQuD/HMXhWs9wp19juah6HRQF6rknjqaszLgi7s0TvwqmRlwkDmjXcc+UdHRw6tvL+SRL
        YqqW9EO7Zx5jqwNMulE7a17eKOlZ9Wq6eYKvL0bcnfVQIeNOCliWraUd2lMMroaRnSrrpK
        B96C4nzak+tq95ShbIbvcMe4drAzO24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-RCIFmV8FMF6G_eCrsVBQ7g-1; Wed, 10 Mar 2021 11:59:50 -0500
X-MC-Unique: RCIFmV8FMF6G_eCrsVBQ7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EFACE5760;
        Wed, 10 Mar 2021 16:59:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 211C560C13;
        Wed, 10 Mar 2021 16:59:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 24/28] afs: Extract writeback extension into its own
 function
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Mar 2021 16:59:44 +0000
Message-ID: <161539558417.286939.2879469588895925399.stgit@warthog.procyon.org.uk>
In-Reply-To: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
References: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extract writeback extension into its own function to break up the writeback
function a bit.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/160588538471.3465195.782513375683399583.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161118154610.1232039.1765365632920504822.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161161050546.2537118.2202554806419189453.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/161340414102.1303470.9078891484034668985.stgit@warthog.procyon.org.uk/ # v3
---

 fs/afs/write.c |  109 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 42 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index e1791de90478..89c804bfe253 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -490,47 +490,25 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter,
 }
 
 /*
- * Synchronously write back the locked page and any subsequent non-locked dirty
- * pages.
+ * Extend the region to be written back to include subsequent contiguously
+ * dirty pages if possible, but don't sleep while doing so.
+ *
+ * If this page holds new content, then we can include filler zeros in the
+ * writeback.
  */
-static int afs_write_back_from_locked_page(struct address_space *mapping,
-					   struct writeback_control *wbc,
-					   struct page *primary_page,
-					   pgoff_t final_page)
+static void afs_extend_writeback(struct address_space *mapping,
+				 struct afs_vnode *vnode,
+				 long *_count,
+				 pgoff_t start,
+				 pgoff_t final_page,
+				 unsigned *_offset,
+				 unsigned *_to,
+				 bool new_content)
 {
-	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
-	struct iov_iter iter;
 	struct page *pages[8], *page;
-	unsigned long count, priv;
-	unsigned n, offset, to, f, t;
-	pgoff_t start, first, last;
-	loff_t i_size, pos, end;
-	int loop, ret;
-
-	_enter(",%lx", primary_page->index);
-
-	count = 1;
-	if (test_set_page_writeback(primary_page))
-		BUG();
-
-	/* Find all consecutive lockable dirty pages that have contiguous
-	 * written regions, stopping when we find a page that is not
-	 * immediately lockable, is not dirty or is missing, or we reach the
-	 * end of the range.
-	 */
-	start = primary_page->index;
-	priv = page_private(primary_page);
-	offset = afs_page_dirty_from(primary_page, priv);
-	to = afs_page_dirty_to(primary_page, priv);
-	trace_afs_page_dirty(vnode, tracepoint_string("store"), primary_page);
-
-	WARN_ON(offset == to);
-	if (offset == to)
-		trace_afs_page_dirty(vnode, tracepoint_string("WARN"), primary_page);
-
-	if (start >= final_page ||
-	    (to < PAGE_SIZE && !test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags)))
-		goto no_more;
+	unsigned long count = *_count, priv;
+	unsigned offset = *_offset, to = *_to, n, f, t;
+	int loop;
 
 	start++;
 	do {
@@ -551,8 +529,7 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 
 		for (loop = 0; loop < n; loop++) {
 			page = pages[loop];
-			if (to != PAGE_SIZE &&
-			    !test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags))
+			if (to != PAGE_SIZE && !new_content)
 				break;
 			if (page->index > final_page)
 				break;
@@ -566,8 +543,7 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 			priv = page_private(page);
 			f = afs_page_dirty_from(page, priv);
 			t = afs_page_dirty_to(page, priv);
-			if (f != 0 &&
-			    !test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags)) {
+			if (f != 0 && !new_content) {
 				unlock_page(page);
 				break;
 			}
@@ -593,6 +569,55 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 	} while (start <= final_page && count < 65536);
 
 no_more:
+	*_count = count;
+	*_offset = offset;
+	*_to = to;
+}
+
+/*
+ * Synchronously write back the locked page and any subsequent non-locked dirty
+ * pages.
+ */
+static int afs_write_back_from_locked_page(struct address_space *mapping,
+					   struct writeback_control *wbc,
+					   struct page *primary_page,
+					   pgoff_t final_page)
+{
+	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
+	struct iov_iter iter;
+	unsigned long count, priv;
+	unsigned offset, to;
+	pgoff_t start, first, last;
+	loff_t i_size, pos, end;
+	bool new_content = test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
+	int ret;
+
+	_enter(",%lx", primary_page->index);
+
+	count = 1;
+	if (test_set_page_writeback(primary_page))
+		BUG();
+
+	/* Find all consecutive lockable dirty pages that have contiguous
+	 * written regions, stopping when we find a page that is not
+	 * immediately lockable, is not dirty or is missing, or we reach the
+	 * end of the range.
+	 */
+	start = primary_page->index;
+	priv = page_private(primary_page);
+	offset = afs_page_dirty_from(primary_page, priv);
+	to = afs_page_dirty_to(primary_page, priv);
+	trace_afs_page_dirty(vnode, tracepoint_string("store"), primary_page);
+
+	WARN_ON(offset == to);
+	if (offset == to)
+		trace_afs_page_dirty(vnode, tracepoint_string("WARN"), primary_page);
+
+	if (start < final_page &&
+	    (to == PAGE_SIZE || new_content))
+		afs_extend_writeback(mapping, vnode, &count, start, final_page,
+				     &offset, &to, new_content);
+
 	/* We now have a contiguous set of dirty pages, each with writeback
 	 * set; the first page is still locked at this point, but all the rest
 	 * have been unlocked.


