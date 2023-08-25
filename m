Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71042788FA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 22:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjHYUNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 16:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjHYUMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:12:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28C52689;
        Fri, 25 Aug 2023 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mO3HHnY77VFfHTGH36PqtwaRQYcAVHn1CQVQhem4mxs=; b=qS4UCDeqElyCb2OHi6eUCdf292
        tSXMUPdi1NBE5Pnenj0CQ2UZd0i0CginB4VphyEjoctBjN76eqG+QgzaaiG9V7V96iuUd7NVpU1No
        I9xC2LM8uWHdcjQ+KNvMtlnpzLWLp3rRlSGY2N+bZq3WbBjZUp7Gdm4EJnaBZ3OolRBAAxsh0CXgA
        Lbv78nTmn1pwfT10A7l8cX6SPBj5A6kYIGrrKmkom8A6IhFMXJqF49rG02UKMPV/aHIfByUYYg9hU
        CtVQT9ycwZwi6msRnp5E41Yrrz6vfNClyJBbqgK+YCA1E6i/zGM8L8XfMz7rVNNdUpzk+tzcthYfN
        /4BxjvCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZdAV-001SZs-No; Fri, 25 Aug 2023 20:12:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/15] ceph: Convert writepages_finish() to use a folio
Date:   Fri, 25 Aug 2023 21:12:18 +0100
Message-Id: <20230825201225.348148-9-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230825201225.348148-1-willy@infradead.org>
References: <20230825201225.348148-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove several implicit calls to compound_head().  Remove the
BUG_ON(!page) as it won't help debug any crashes (the WARN_ON will crash
in a distinctive way).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 02caf10d43ed..765b37db2729 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -806,7 +806,6 @@ static void writepages_finish(struct ceph_osd_request *req)
 	struct inode *inode = req->r_inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_osd_data *osd_data;
-	struct page *page;
 	int num_pages, total_pages = 0;
 	int i, j;
 	int rc = req->r_result;
@@ -850,29 +849,28 @@ static void writepages_finish(struct ceph_osd_request *req)
 					   (u64)osd_data->length);
 		total_pages += num_pages;
 		for (j = 0; j < num_pages; j++) {
-			page = osd_data->pages[j];
-			if (fscrypt_is_bounce_page(page)) {
-				page = fscrypt_pagecache_page(page);
+			struct folio *folio = page_folio(osd_data->pages[j]);
+			if (fscrypt_is_bounce_folio(folio)) {
+				folio = fscrypt_pagecache_folio(folio);
 				fscrypt_free_bounce_page(osd_data->pages[j]);
-				osd_data->pages[j] = page;
+				osd_data->pages[j] = &folio->page;
 			}
-			BUG_ON(!page);
-			WARN_ON(!PageUptodate(page));
+			WARN_ON(!folio_test_uptodate(folio));
 
 			if (atomic_long_dec_return(&fsc->writeback_count) <
 			     CONGESTION_OFF_THRESH(
 					fsc->mount_options->congestion_kb))
 				fsc->write_congested = false;
 
-			ceph_put_snap_context(detach_page_private(page));
-			end_page_writeback(page);
-			dout("unlocking %p\n", page);
+			ceph_put_snap_context(folio_detach_private(folio));
+			folio_end_writeback(folio);
+			dout("unlocking %lu\n", folio->index);
 
 			if (remove_page)
 				generic_error_remove_page(inode->i_mapping,
-							  page);
+							  &folio->page);
 
-			unlock_page(page);
+			folio_unlock(folio);
 		}
 		dout("writepages_finish %p wrote %llu bytes cleaned %d pages\n",
 		     inode, osd_data->length, rc >= 0 ? num_pages : 0);
-- 
2.40.1

