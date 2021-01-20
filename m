Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6772FDD72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 00:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404438AbhATXyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 18:54:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733008AbhATW1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 17:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611181556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TVQXfMRgcYF74aRdJN1EqRV7ahJ/l5qJeAzL/vDKTfE=;
        b=WCuwU06d2rLBqxVWDmxUxGvFTIaO7lxiQxHHe9lpcwxwhde1R/nVFg9O1izgOZn11923mQ
        Bnw/eAjFOEXR3Pu5DiXBTn+nHnj6xRvxKTj/Yj9L8zJkRZ36aLJLGyPBvLTrbVbroVT8J9
        jo8VlTkIIuAHBGeP08Ux1zjIEKzBUbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-xPH-US10MAuyz48DdtuL0w-1; Wed, 20 Jan 2021 17:25:55 -0500
X-MC-Unique: xPH-US10MAuyz48DdtuL0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02EE0835DE0;
        Wed, 20 Jan 2021 22:25:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13D2562462;
        Wed, 20 Jan 2021 22:25:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 22/25] afs: Extract writeback extension into its own function
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Jan 2021 22:25:46 +0000
Message-ID: <161118154610.1232039.1765365632920504822.stgit@warthog.procyon.org.uk>
In-Reply-To: <161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk>
References: <161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extract writeback extension into its own function to break up the writeback
function a bit.

Signed-off-by: David Howells <dhowells@redhat.com>
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


