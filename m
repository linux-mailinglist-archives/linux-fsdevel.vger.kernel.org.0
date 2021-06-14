Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E243A67A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 15:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhFNNW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 09:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233793AbhFNNWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623676843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DliIdwz6p7S2ZjBM0Y5O6rTNS+fTmdq5K0te4r5zDIg=;
        b=LG0yS5+tR8f4t2WkXcq6cByqcnRf1SM0Mt9umOw9tbHZXFBXdGUSS0Ta4d91sjEbZuy+mx
        tmySgciTiNKFzhGdQnJQov/ohYL1OMYuSwW3QkN/KpR99fRt2SQN/X+1o+7NESYJ3kIQCF
        NMWSwcBR5dDp5M2aYB61RLFGk2OpHqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-pGrFHfIdP2WrhVUMJiLWPQ-1; Mon, 14 Jun 2021 09:20:41 -0400
X-MC-Unique: pGrFHfIdP2WrhVUMJiLWPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37127801A84;
        Mon, 14 Jun 2021 13:20:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F2F05D6A8;
        Mon, 14 Jun 2021 13:20:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/3] netfs: fix test for whether we can skip read when writing
 beyond EOF
From:   David Howells <dhowells@redhat.com>
To:     jlayton@kernel.org, willy@infradead.org
Cc:     Andrew W Elble <aweits@rit.edu>, ceph-devel@vger.kernel.org,
        dhowells@redhat.com, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 14 Jun 2021 14:20:33 +0100
Message-ID: <162367683365.460125.4467036947364047314.stgit@warthog.procyon.org.uk>
In-Reply-To: <162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk>
References: <162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

It's not sufficient to skip reading when the pos is beyond the EOF.
There may be data at the head of the page that we need to fill in
before the write.

Add a new helper function that corrects and clarifies the logic of
when we can skip reads, and have it only zero out the part of the page
that won't have data copied in for the write.

Finally, don't set the page Uptodate after zeroing. It's not up to date
since the write data won't have been copied in yet.

[DH made the following changes:

 - Prefixed the new function with "netfs_".

 - Don't call zero_user_segments() for a full-page write.

 - Altered the beyond-last-page check to avoid a DIV instruction and got
   rid of then-redundant zero-length file check.
]

Fixes: e1b1240c1ff5f ("netfs: Add write_begin helper")
Reported-by: Andrew W Elble <aweits@rit.edu>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: ceph-devel@vger.kernel.org
Link: https://lore.kernel.org/r/20210613233345.113565-1-jlayton@kernel.org/
---

 fs/netfs/read_helper.c |   49 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 725614625ed4..70a5b1a19a50 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -1011,12 +1011,42 @@ int netfs_readpage(struct file *file,
 }
 EXPORT_SYMBOL(netfs_readpage);
 
-static void netfs_clear_thp(struct page *page)
+/**
+ * netfs_skip_page_read - prep a page for writing without reading first
+ * @page: page being prepared
+ * @pos: starting position for the write
+ * @len: length of write
+ *
+ * In some cases, write_begin doesn't need to read at all:
+ * - full page write
+ * - write that lies in a page that is completely beyond EOF
+ * - write that covers the the page from start to EOF or beyond it
+ *
+ * If any of these criteria are met, then zero out the unwritten parts
+ * of the page and return true. Otherwise, return false.
+ */
+static noinline bool netfs_skip_page_read(struct page *page, loff_t pos, size_t len)
 {
-	unsigned int i;
+	struct inode *inode = page->mapping->host;
+	loff_t i_size = i_size_read(inode);
+	size_t offset = offset_in_thp(page, pos);
+
+	/* Full page write */
+	if (offset == 0 && len >= thp_size(page))
+		return true;
+
+	/* pos beyond last page in the file */
+	if (pos - offset >= i_size)
+		goto zero_out;
+
+	/* Write that covers from the start of the page to EOF or beyond */
+	if (offset == 0 && (pos + len) >= i_size)
+		goto zero_out;
 
-	for (i = 0; i < thp_nr_pages(page); i++)
-		clear_highpage(page + i);
+	return false;
+zero_out:
+	zero_user_segments(page, 0, offset, offset + len, thp_size(page));
+	return true;
 }
 
 /**
@@ -1024,7 +1054,7 @@ static void netfs_clear_thp(struct page *page)
  * @file: The file to read from
  * @mapping: The mapping to read from
  * @pos: File position at which the write will begin
- * @len: The length of the write in this page
+ * @len: The length of the write (may extend beyond the end of the page chosen)
  * @flags: AOP_* flags
  * @_page: Where to put the resultant page
  * @_fsdata: Place for the netfs to store a cookie
@@ -1061,8 +1091,6 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	struct inode *inode = file_inode(file);
 	unsigned int debug_index = 0;
 	pgoff_t index = pos >> PAGE_SHIFT;
-	int pos_in_page = pos & ~PAGE_MASK;
-	loff_t size;
 	int ret;
 
 	DEFINE_READAHEAD(ractl, file, NULL, mapping, index);
@@ -1090,13 +1118,8 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	 * within the cache granule containing the EOF, in which case we need
 	 * to preload the granule.
 	 */
-	size = i_size_read(inode);
 	if (!ops->is_cache_enabled(inode) &&
-	    ((pos_in_page == 0 && len == thp_size(page)) ||
-	     (pos >= size) ||
-	     (pos_in_page == 0 && (pos + len) >= size))) {
-		netfs_clear_thp(page);
-		SetPageUptodate(page);
+	    netfs_skip_page_read(page, pos, len)) {
 		netfs_stat(&netfs_n_rh_write_zskip);
 		goto have_page_no_wait;
 	}


