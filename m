Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E5D6A8CDD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 00:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCBXSW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 18:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjCBXSP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:18:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA3158B46
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 15:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677799013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNYSQ/Y9B3aZRJt+LYUgV6EcG7vLla4aEHu0riyXHik=;
        b=ccQsJISbti997Ttdl2XBgh7bmwyhSQlSx3C9X5OHPsJbOIUfNYa1Yukvqv4NKoFngAu8op
        Bz2eL/FA15HwjbpruglQIHmYkTcjfHCvx/zLY35rXjJCDeuLyJxk4BH27S7w8UJfS3P+h0
        3mbAYQoQlJbNC9w14z0LbgUZ5QaLBZI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-Ema7s1klNeSsDP6d3fPMHw-1; Thu, 02 Mar 2023 18:16:50 -0500
X-MC-Unique: Ema7s1klNeSsDP6d3fPMHw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2767F1C05AC1;
        Thu,  2 Mar 2023 23:16:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15443492C3E;
        Thu,  2 Mar 2023 23:16:46 +0000 (UTC)
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
Subject: [PATCH 2/3] afs: Partially revert and use filemap_get_folio_tag()
Date:   Thu,  2 Mar 2023 23:16:37 +0000
Message-Id: <20230302231638.521280-3-dhowells@redhat.com>
In-Reply-To: <20230302231638.521280-1-dhowells@redhat.com>
References: <20230302231638.521280-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Partially revert the changes made by:

    acc8d8588cb7e3e64b0d2fa611dad06574cd67b1.
    afs: convert afs_writepages_region() to use filemap_get_folios_tag()

The issue is that filemap_get_folios_tag() gets a batch of pages at a time,
and then afs_writepages_region() goes through them one at a time, extends
each into an operation with as many pages as will fit using the loop in
afs_extend_writeback() and submits it - but, in the common case, this means
that the other pages in the batch already got annexed and processed in
afs_extend_writeback() and we end up doing duplicate processing.

Switching to write_cache_pages() isn't an immediate substitute as that
doesn't take account of PG_fscache (and this bit is used in other ways by
other filesystems).

So go back to finding the next folio from the VM one at a time and then
extending the op onwards.

Fixes: acc8d8588cb7 ("afs: convert afs_writepages_region() to use filemap_get_folios_tag()")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Steve French <sfrench@samba.org>
cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: linux-afs@lists.infradead.org
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/2214157.1677250083@warthog.procyon.org.uk/
---
 fs/afs/write.c | 118 ++++++++++++++++++++++++-------------------------
 1 file changed, 57 insertions(+), 61 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 571f3b9a417e..2ed76697be96 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -704,87 +704,83 @@ static int afs_writepages_region(struct address_space *mapping,
 				 bool max_one_loop)
 {
 	struct folio *folio;
-	struct folio_batch fbatch;
 	ssize_t ret;
-	unsigned int i;
-	int n, skips = 0;
+	int skips = 0;
 
 	_enter("%llx,%llx,", start, end);
-	folio_batch_init(&fbatch);
 
 	do {
 		pgoff_t index = start / PAGE_SIZE;
 
-		n = filemap_get_folios_tag(mapping, &index, end / PAGE_SIZE,
-					PAGECACHE_TAG_DIRTY, &fbatch);
-
-		if (!n)
+		folio = filemap_get_folio_tag(mapping, &index, end / PAGE_SIZE,
+					      PAGECACHE_TAG_DIRTY);
+		if (!folio)
 			break;
-		for (i = 0; i < n; i++) {
-			folio = fbatch.folios[i];
-			start = folio_pos(folio); /* May regress with THPs */
 
-			_debug("wback %lx", folio_index(folio));
+		start = folio_pos(folio); /* May regress with THPs */
 
-			/* At this point we hold neither the i_pages lock nor the
-			 * page lock: the page may be truncated or invalidated
-			 * (changing page->mapping to NULL), or even swizzled
-			 * back from swapper_space to tmpfs file mapping
-			 */
-			if (wbc->sync_mode != WB_SYNC_NONE) {
-				ret = folio_lock_killable(folio);
-				if (ret < 0) {
-					folio_batch_release(&fbatch);
-					return ret;
-				}
-			} else {
-				if (!folio_trylock(folio))
-					continue;
-			}
+		_debug("wback %lx", folio_index(folio));
 
-			if (folio->mapping != mapping ||
-			    !folio_test_dirty(folio)) {
-				start += folio_size(folio);
-				folio_unlock(folio);
-				continue;
+		/* At this point we hold neither the i_pages lock nor the
+		 * page lock: the page may be truncated or invalidated
+		 * (changing page->mapping to NULL), or even swizzled
+		 * back from swapper_space to tmpfs file mapping
+		 */
+		if (wbc->sync_mode != WB_SYNC_NONE) {
+			ret = folio_lock_killable(folio);
+			if (ret < 0) {
+				folio_put(folio);
+				return ret;
+			}
+		} else {
+			if (!folio_trylock(folio)) {
+				folio_put(folio);
+				return 0;
 			}
+		}
 
-			if (folio_test_writeback(folio) ||
-			    folio_test_fscache(folio)) {
-				folio_unlock(folio);
-				if (wbc->sync_mode != WB_SYNC_NONE) {
-					folio_wait_writeback(folio);
+		if (folio_mapping(folio) != mapping ||
+		    !folio_test_dirty(folio)) {
+			start += folio_size(folio);
+			folio_unlock(folio);
+			folio_put(folio);
+			continue;
+		}
+
+		if (folio_test_writeback(folio) ||
+		    folio_test_fscache(folio)) {
+			folio_unlock(folio);
+			if (wbc->sync_mode != WB_SYNC_NONE) {
+				folio_wait_writeback(folio);
 #ifdef CONFIG_AFS_FSCACHE
-					folio_wait_fscache(folio);
+				folio_wait_fscache(folio);
 #endif
-				} else {
-					start += folio_size(folio);
-				}
-				if (wbc->sync_mode == WB_SYNC_NONE) {
-					if (skips >= 5 || need_resched()) {
-						*_next = start;
-						_leave(" = 0 [%llx]", *_next);
-						return 0;
-					}
-					skips++;
-				}
-				continue;
+			} else {
+				start += folio_size(folio);
 			}
-
-			if (!folio_clear_dirty_for_io(folio))
-				BUG();
-			ret = afs_write_back_from_locked_folio(mapping, wbc,
-					folio, start, end);
-			if (ret < 0) {
-				_leave(" = %zd", ret);
-				folio_batch_release(&fbatch);
-				return ret;
+			folio_put(folio);
+			if (wbc->sync_mode == WB_SYNC_NONE) {
+				if (skips >= 5 || need_resched())
+					break;
+				skips++;
 			}
+			continue;
+		}
 
-			start += ret;
+		if (!folio_clear_dirty_for_io(folio))
+			BUG();
+		ret = afs_write_back_from_locked_folio(mapping, wbc, folio, start, end);
+		folio_put(folio);
+		if (ret < 0) {
+			_leave(" = %zd", ret);
+			return ret;
 		}
 
-		folio_batch_release(&fbatch);
+		start += ret;
+
+		if (max_one_loop)
+			break;
+
 		cond_resched();
 	} while (wbc->nr_to_write > 0);
 

