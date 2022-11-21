Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645F7632097
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 12:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiKUL3p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 06:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiKUL30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:29:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E6B18E1A
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 03:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669029774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0fohpyxuh1ulUvSg7HMOO2E0zOAUAiDTJW4VYjB54wc=;
        b=NkUzRwPUEqENcwE1Q7AS+/oIikJr8H/lZpQwhXUXrOeNoP0bVeqL6mLGC5eae3w01ilGUg
        U2r6mo2HI0mkduMtNQFqHLmtmjlu90Vrkbpu6SWHTRBDUPrN5WenE0KvlqN+FnezDgk5GT
        eZ6KWLDWPEHEFqg8CRm5TPO41SIGu1A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-7lrjSWXmPIiiYovDaCpmag-1; Mon, 21 Nov 2022 06:22:51 -0500
X-MC-Unique: 7lrjSWXmPIiiYovDaCpmag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6E632A5954B;
        Mon, 21 Nov 2022 11:22:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD4A82024CB7;
        Mon, 21 Nov 2022 11:22:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH v2] afs: Stop implementing ->writepage()
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Nov 2022 11:22:47 +0000
Message-ID: <166902976709.269117.16991162776475572981.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We're trying to get rid of the ->writepage() hook[1].  Stop afs from using
it by unlocking the page and calling afs_writepages_region() rather than
folio_write_one().

A flag is passed to afs_writepages_region() to indicate that it should only
write a single region so that we don't flush the entire file in
->write_begin(), but do add other dirty data to the region being written to
try and reduce the number of RPC ops.

This requires ->migrate_folio() to be implemented, so point that at
filemap_migrate_folio() for files and also for symlinks and directories.

This can be tested by turning on the afs_folio_dirty tracepoint and then
doing something like:

   xfs_io -c "w 2223 7000" -c "w 15000 22222" -c "w 23 7" /afs/my/test/foo

and then looking in the trace to see if the write at position 15000 gets
stored before page 0 gets dirtied for the write at position 23.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/20221113162902.883850-1-hch@lst.de/ [1]
Link: https://lore.kernel.org/r/166876785552.222254.4403222906022558715.stgit@warthog.procyon.org.uk/ # v1
---

 fs/afs/dir.c   |    1 +
 fs/afs/file.c  |    3 +-
 fs/afs/write.c |   83 ++++++++++++++++++++++++++++++++------------------------
 3 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 230c2d19116d..baed7b095087 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -77,6 +77,7 @@ const struct address_space_operations afs_dir_aops = {
 	.dirty_folio	= afs_dir_dirty_folio,
 	.release_folio	= afs_dir_release_folio,
 	.invalidate_folio = afs_dir_invalidate_folio,
+	.migrate_folio	= filemap_migrate_folio,
 };
 
 const struct dentry_operations afs_fs_dentry_operations = {
diff --git a/fs/afs/file.c b/fs/afs/file.c
index d1cfb235c4b9..a2325e0b9d38 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -58,14 +58,15 @@ const struct address_space_operations afs_file_aops = {
 	.invalidate_folio = afs_invalidate_folio,
 	.write_begin	= afs_write_begin,
 	.write_end	= afs_write_end,
-	.writepage	= afs_writepage,
 	.writepages	= afs_writepages,
+	.migrate_folio	= filemap_migrate_folio,
 };
 
 const struct address_space_operations afs_symlink_aops = {
 	.read_folio	= afs_symlink_read_folio,
 	.release_folio	= afs_release_folio,
 	.invalidate_folio = afs_invalidate_folio,
+	.migrate_folio	= filemap_migrate_folio,
 };
 
 static const struct vm_operations_struct afs_vm_ops = {
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 9ebdd36eaf2f..197753181116 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -14,6 +14,11 @@
 #include <linux/netfs.h>
 #include "internal.h"
 
+static int afs_writepages_region(struct address_space *mapping,
+				 struct writeback_control *wbc,
+				 loff_t start, loff_t end, loff_t *_next,
+				 bool max_one_loop);
+
 static void afs_write_to_cache(struct afs_vnode *vnode, loff_t start, size_t len,
 			       loff_t i_size, bool caching);
 
@@ -38,6 +43,25 @@ static void afs_folio_start_fscache(bool caching, struct folio *folio)
 }
 #endif
 
+/*
+ * Flush out a conflicting write.  This may extend the write to the surrounding
+ * pages if also dirty and contiguous to the conflicting region..
+ */
+static int afs_flush_conflicting_write(struct address_space *mapping,
+				       struct folio *folio)
+{
+	struct writeback_control wbc = {
+		.sync_mode	= WB_SYNC_ALL,
+		.nr_to_write	= LONG_MAX,
+		.range_start	= folio_pos(folio),
+		.range_end	= LLONG_MAX,
+	};
+	loff_t next;
+
+	return afs_writepages_region(mapping, &wbc, folio_pos(folio), LLONG_MAX,
+				     &next, true);
+}
+
 /*
  * prepare to perform part of a write to a page
  */
@@ -80,7 +104,8 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 
 		if (folio_test_writeback(folio)) {
 			trace_afs_folio_dirty(vnode, tracepoint_string("alrdy"), folio);
-			goto flush_conflicting_write;
+			folio_unlock(folio);
+			goto wait_for_writeback;
 		}
 		/* If the file is being filled locally, allow inter-write
 		 * spaces to be merged into writes.  If it's not, only write
@@ -99,8 +124,15 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	 * flush the page out.
 	 */
 flush_conflicting_write:
-	_debug("flush conflict");
-	ret = folio_write_one(folio);
+	trace_afs_folio_dirty(vnode, tracepoint_string("confl"), folio);
+	folio_unlock(folio);
+
+	ret = afs_flush_conflicting_write(mapping, folio);
+	if (ret < 0)
+		goto error;
+
+wait_for_writeback:
+	ret = folio_wait_writeback_killable(folio);
 	if (ret < 0)
 		goto error;
 
@@ -663,40 +695,13 @@ static ssize_t afs_write_back_from_locked_folio(struct address_space *mapping,
 	return ret;
 }
 
-/*
- * write a page back to the server
- * - the caller locked the page for us
- */
-int afs_writepage(struct page *subpage, struct writeback_control *wbc)
-{
-	struct folio *folio = page_folio(subpage);
-	ssize_t ret;
-	loff_t start;
-
-	_enter("{%lx},", folio_index(folio));
-
-#ifdef CONFIG_AFS_FSCACHE
-	folio_wait_fscache(folio);
-#endif
-
-	start = folio_index(folio) * PAGE_SIZE;
-	ret = afs_write_back_from_locked_folio(folio_mapping(folio), wbc,
-					       folio, start, LLONG_MAX - start);
-	if (ret < 0) {
-		_leave(" = %zd", ret);
-		return ret;
-	}
-
-	_leave(" = 0");
-	return 0;
-}
-
 /*
  * write a region of pages back to the server
  */
 static int afs_writepages_region(struct address_space *mapping,
 				 struct writeback_control *wbc,
-				 loff_t start, loff_t end, loff_t *_next)
+				 loff_t start, loff_t end, loff_t *_next,
+				 bool max_one_loop)
 {
 	struct folio *folio;
 	struct page *head_page;
@@ -775,6 +780,9 @@ static int afs_writepages_region(struct address_space *mapping,
 
 		start += ret;
 
+		if (max_one_loop)
+			break;
+
 		cond_resched();
 	} while (wbc->nr_to_write > 0);
 
@@ -806,24 +814,27 @@ int afs_writepages(struct address_space *mapping,
 
 	if (wbc->range_cyclic) {
 		start = mapping->writeback_index * PAGE_SIZE;
-		ret = afs_writepages_region(mapping, wbc, start, LLONG_MAX, &next);
+		ret = afs_writepages_region(mapping, wbc, start, LLONG_MAX,
+					    &next, false);
 		if (ret == 0) {
 			mapping->writeback_index = next / PAGE_SIZE;
 			if (start > 0 && wbc->nr_to_write > 0) {
 				ret = afs_writepages_region(mapping, wbc, 0,
-							    start, &next);
+							    start, &next, false);
 				if (ret == 0)
 					mapping->writeback_index =
 						next / PAGE_SIZE;
 			}
 		}
 	} else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
-		ret = afs_writepages_region(mapping, wbc, 0, LLONG_MAX, &next);
+		ret = afs_writepages_region(mapping, wbc, 0, LLONG_MAX,
+					    &next, false);
 		if (wbc->nr_to_write > 0 && ret == 0)
 			mapping->writeback_index = next / PAGE_SIZE;
 	} else {
 		ret = afs_writepages_region(mapping, wbc,
-					    wbc->range_start, wbc->range_end, &next);
+					    wbc->range_start, wbc->range_end,
+					    &next, false);
 	}
 
 	up_read(&vnode->validate_lock);


