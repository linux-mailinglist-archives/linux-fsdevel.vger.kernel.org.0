Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3456A8CE1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 00:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjCBXSj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 18:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCBXSW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:18:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEF558B5B
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 15:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677799015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ix2GZROjqu1lNaAS5h0hXsC2zG3GiI8z8sp15KcpJfk=;
        b=gInwm2DDWXVk+jUIu0x2jXhEjo+erdwOPJQpRuXt9i8ChFttFtqExLGK2xIV15FxrIdQGG
        mtMhFiDIaVX54iMYKRrT2EFc0VmrAWaJwz71R3PAtTr6zDWim3GVMXgZXXtZ/MQn0pwuL9
        2Q5nFbANMxivIZAiQ+wkaZZb5+LOMvA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-zQT8bSDzMRqgB_Iir98xAw-1; Thu, 02 Mar 2023 18:16:52 -0500
X-MC-Unique: zQT8bSDzMRqgB_Iir98xAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4BAA85A5A3;
        Thu,  2 Mar 2023 23:16:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6EE72166B26;
        Thu,  2 Mar 2023 23:16:49 +0000 (UTC)
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
Subject: [PATCH 3/3] cifs: Partially revert and use filemap_get_folio_tag()
Date:   Thu,  2 Mar 2023 23:16:38 +0000
Message-Id: <20230302231638.521280-4-dhowells@redhat.com>
In-Reply-To: <20230302231638.521280-1-dhowells@redhat.com>
References: <20230302231638.521280-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mirror the changes made to afs to partially revert the changes made by:

    acc8d8588cb7e3e64b0d2fa611dad06574cd67b1.
    "afs: convert afs_writepages_region() to use filemap_get_folios_tag()"

that were then mirrored into cifs.

The issue is that filemap_get_folios_tag() gets a batch of pages at a time,
and then cifs_writepages_region() goes through them one at a time, extends
each into an operation with as many pages as will fit using the loop in
cifs_extend_writeback() and submits it - but, in the common case, this
means that the other pages in the batch already got annexed and processed
in cifs_extend_writeback() and we end up doing duplicate processing.

Switching to write_cache_pages() isn't an immediate substitute as that
doesn't take account of PG_fscache (and this bit is used in other ways by
other filesystems).

So go back to finding the next folio from the VM one at a time and then
extending the op onwards.

Fixes: 3822a7c40997 ("Merge tag 'mm-stable-2023-02-20-13-37' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Paulo Alcantara <pc@cjr.nz>
cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/2214157.1677250083@warthog.procyon.org.uk/
---
 fs/cifs/file.c | 115 +++++++++++++++++++++----------------------------
 1 file changed, 49 insertions(+), 66 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 4d4a2d82636d..a3e89e741b42 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2864,93 +2864,76 @@ static int cifs_writepages_region(struct address_space *mapping,
 				  struct writeback_control *wbc,
 				  loff_t start, loff_t end, loff_t *_next)
 {
-	struct folio_batch fbatch;
+	struct folio *folio;
+	ssize_t ret;
 	int skips = 0;
 
-	folio_batch_init(&fbatch);
 	do {
-		int nr;
 		pgoff_t index = start / PAGE_SIZE;
 
-		nr = filemap_get_folios_tag(mapping, &index, end / PAGE_SIZE,
-					    PAGECACHE_TAG_DIRTY, &fbatch);
-		if (!nr)
+		folio = filemap_get_folio_tag(mapping, &index, end / PAGE_SIZE,
+					      PAGECACHE_TAG_DIRTY);
+		if (!folio)
 			break;
 
-		for (int i = 0; i < nr; i++) {
-			ssize_t ret;
-			struct folio *folio = fbatch.folios[i];
-
-redo_folio:
-			start = folio_pos(folio); /* May regress with THPs */
+		start = folio_pos(folio); /* May regress with THPs */
 
-			/* At this point we hold neither the i_pages lock nor the
-			 * page lock: the page may be truncated or invalidated
-			 * (changing page->mapping to NULL), or even swizzled
-			 * back from swapper_space to tmpfs file mapping
-			 */
-			if (wbc->sync_mode != WB_SYNC_NONE) {
-				ret = folio_lock_killable(folio);
-				if (ret < 0)
-					goto write_error;
-			} else {
-				if (!folio_trylock(folio))
-					goto skip_write;
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
 			}
-
-			if (folio_mapping(folio) != mapping ||
-			    !folio_test_dirty(folio)) {
-				start += folio_size(folio);
-				folio_unlock(folio);
-				continue;
+		} else {
+			if (!folio_trylock(folio)) {
+				folio_put(folio);
+				return 0;
 			}
+		}
 
-			if (folio_test_writeback(folio) ||
-			    folio_test_fscache(folio)) {
-				folio_unlock(folio);
-				if (wbc->sync_mode == WB_SYNC_NONE)
-					goto skip_write;
+		if (folio_mapping(folio) != mapping ||
+		    !folio_test_dirty(folio)) {
+			start += folio_size(folio);
+			folio_unlock(folio);
+			folio_put(folio);
+			continue;
+		}
 
+		if (folio_test_writeback(folio) ||
+		    folio_test_fscache(folio)) {
+			folio_unlock(folio);
+			if (wbc->sync_mode != WB_SYNC_NONE) {
 				folio_wait_writeback(folio);
 #ifdef CONFIG_CIFS_FSCACHE
 				folio_wait_fscache(folio);
 #endif
-				goto redo_folio;
+			} else {
+				start += folio_size(folio);
 			}
-
-			if (!folio_clear_dirty_for_io(folio))
-				/* We hold the page lock - it should've been dirty. */
-				WARN_ON(1);
-
-			ret = cifs_write_back_from_locked_folio(mapping, wbc, folio, start, end);
-			if (ret < 0)
-				goto write_error;
-
-			start += ret;
-			continue;
-
-write_error:
-			folio_batch_release(&fbatch);
-			*_next = start;
-			return ret;
-
-skip_write:
-			/*
-			 * Too many skipped writes, or need to reschedule?
-			 * Treat it as a write error without an error code.
-			 */
-			if (skips >= 5 || need_resched()) {
-				ret = 0;
-				goto write_error;
+			folio_put(folio);
+			if (wbc->sync_mode == WB_SYNC_NONE) {
+				if (skips >= 5 || need_resched())
+					break;
+				skips++;
 			}
-
-			/* Otherwise, just skip that folio and go on to the next */
-			skips++;
-			start += folio_size(folio);
 			continue;
 		}
 
-		folio_batch_release(&fbatch);		
+		if (!folio_clear_dirty_for_io(folio))
+			/* We hold the page lock - it should've been dirty. */
+			WARN_ON(1);
+
+		ret = cifs_write_back_from_locked_folio(mapping, wbc, folio, start, end);
+		folio_put(folio);
+		if (ret < 0)
+			return ret;
+
+		start += ret;
 		cond_resched();
 	} while (wbc->nr_to_write > 0);
 

