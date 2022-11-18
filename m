Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3850162F2BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 11:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241411AbiKRKiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 05:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbiKRKip (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:38:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AD0922EE
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 02:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668767865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=f5bu2IF1InfzvQ00y6+OuZ0Xhu88JGi4I8t2yA0L/fE=;
        b=Qbot/eD8pkekOskT8NYSEovFD5iCsMpCiDe9OFB/mACFcWo8R/5SieNTqfde2LW2G7/M6b
        hvrkRp6VpETZevSe1MEciOuwv0VRJUlF8BaTKV1b6CRlIbWyIYfWSaB9btknzAelcJK3kc
        OJCppsxb9IhjHRqtj/k5MtnMIRoVzZs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-Bsc1Dem6OEiKHGf63FHB2A-1; Fri, 18 Nov 2022 05:37:40 -0500
X-MC-Unique: Bsc1Dem6OEiKHGf63FHB2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86C4F101A54E;
        Fri, 18 Nov 2022 10:37:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79C7235429;
        Fri, 18 Nov 2022 10:37:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH] afs: Stop implementing ->writepage()
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 18 Nov 2022 10:37:35 +0000
Message-ID: <166876785552.222254.4403222906022558715.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We're trying to get rid of the ->writepage() hook[1].  Stop afs from using
it by unlocking the page and calling filemap_fdatawrite_wbc() rather than
folio_write_one().  We drop the folio lock so that writeback can include
pages on both sides of the target page in the write without risking
deadlock.

A hint flag is added to the writeback_control struct so that a filesystem
can say that the write is triggered by write_begin seeing a conflicting
write.  This causes do_writepages() to do a single pass of the loop only.

This requires ->migrate_folio() to be implemented, so point that at
filemap_migrate_folio() for files and also for symlinks and directories.

A couple of questions:

 (1) afs_write_back_from_locked_folio() could be called directly rather
     than calling filemap_fdatawrite_wbc(), but that would avoid the
     control group stuff that wbc_attach_and_unlock_inode() and co. seem to
     do.  Do I actually need to do this?

 (2) afs_writepages_region() has a loop in it to generate multiple writes.
     do_writepages() also acquired a loop[2] which will also generate
     multiple writes.  Should I remove the loop from
     afs_writepages_region() and leave it to the caller of ->writepages()?

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: Theodore Ts'o <tytso@mit.edu>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/20221113162902.883850-1-hch@lst.de/ [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80a2ea9f85850f1cdae814be03b4a16c3d3abc00 [2]
---

 fs/afs/dir.c              |    1 +
 fs/afs/file.c             |    3 +-
 fs/afs/write.c            |   63 +++++++++++++++++++++++----------------------
 include/linux/writeback.h |    1 +
 mm/page-writeback.c       |    3 +-
 5 files changed, 38 insertions(+), 33 deletions(-)

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
index 9ebdd36eaf2f..38d02ead3f38 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -38,6 +38,24 @@ static void afs_folio_start_fscache(bool caching, struct folio *folio)
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
+		.for_write_begin = true,
+	};
+
+	return filemap_fdatawrite_wbc(mapping, &wbc);
+}
+
 /*
  * prepare to perform part of a write to a page
  */
@@ -80,7 +98,8 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 
 		if (folio_test_writeback(folio)) {
 			trace_afs_folio_dirty(vnode, tracepoint_string("alrdy"), folio);
-			goto flush_conflicting_write;
+			folio_unlock(folio);
+			goto wait_for_writeback;
 		}
 		/* If the file is being filled locally, allow inter-write
 		 * spaces to be merged into writes.  If it's not, only write
@@ -99,8 +118,15 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
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
 
@@ -663,34 +689,6 @@ static ssize_t afs_write_back_from_locked_folio(struct address_space *mapping,
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
@@ -775,6 +773,9 @@ static int afs_writepages_region(struct address_space *mapping,
 
 		start += ret;
 
+		if (wbc->for_write_begin)
+			break;
+
 		cond_resched();
 	} while (wbc->nr_to_write > 0);
 
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 06f9291b6fd5..3832ac3425c8 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -61,6 +61,7 @@ struct writeback_control {
 	unsigned range_cyclic:1;	/* range_start is cyclic */
 	unsigned for_sync:1;		/* sync(2) WB_SYNC_ALL writeback */
 	unsigned unpinned_fscache_wb:1;	/* Cleared I_PINNING_FSCACHE_WB */
+	unsigned for_write_begin:1;	/* Flush conflicting write */
 
 	/*
 	 * When writeback IOs are bounced through async layers, only the
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 7e9d8d857ecc..04c65b8b4ded 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2469,7 +2469,8 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 			ret = mapping->a_ops->writepages(mapping, wbc);
 		else
 			ret = generic_writepages(mapping, wbc);
-		if ((ret != -ENOMEM) || (wbc->sync_mode != WB_SYNC_ALL))
+		if ((ret != -ENOMEM) || (wbc->sync_mode != WB_SYNC_ALL) ||
+		    wbc->for_write_begin)
 			break;
 
 		/*


