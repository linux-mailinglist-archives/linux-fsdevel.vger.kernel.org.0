Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA53636D99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 23:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiKWWum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 17:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiKWWu0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:50:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D05942F3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 14:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669243724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMSc8ri6PgRiNUl02Z6CVVLfho7VNuVLjNpxfTm/Xl8=;
        b=gEjrdxyyx07AaDsEEOgHp27ANDJujpVGRuqTK3MSAJIDHA4SnWPHSPPKuXGdgFBWBQLs87
        KSzrPxG1PYlhB/kbw20xhRlGD7kVhGr1zFN2FvbgZ8Qp9IYkdbQ2HXiplNmLPr0Yg66HCe
        L2nV7uwMQEjvt2J4yuT/qzJXjbglgHk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-lAdP3-VPME-myi-_rt7VcA-1; Wed, 23 Nov 2022 17:48:41 -0500
X-MC-Unique: lAdP3-VPME-myi-_rt7VcA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F35AD3C0D193;
        Wed, 23 Nov 2022 22:48:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B64641400C38;
        Wed, 23 Nov 2022 22:48:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH v4 1/3] mm: Merge
 folio_has_private()/filemap_release_folio() call pairs
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rohith Surabattula <rohiths.msft@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
        linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, dhowells@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 23 Nov 2022 22:48:35 +0000
Message-ID: <166924371591.1772793.13893659228628027575.stgit@warthog.procyon.org.uk>
In-Reply-To: <166924370539.1772793.13730698360771821317.stgit@warthog.procyon.org.uk>
References: <166924370539.1772793.13730698360771821317.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make filemap_release_folio() check folio_has_private().  Then, in most
cases, where a call to folio_has_private() is immediately followed by a
call to filemap_release_folio(), we can get rid of the test in the pair.

The same is done to page_has_private()/try_to_release_page() call pairs.

There are a couple of sites in mm/vscan.c that this can't so easily be
done.  In shrink_folio_list(), there are actually three cases (something
different is done for incompletely invalidated buffers), but
filemap_release_folio() elides two of them.

In shrink_active_list(), we don't have have the folio lock yet, so the
check allows us to avoid locking the page unnecessarily.

A wrapper function to check if a folio needs release is provided for those
places that still need to do it in the mm/ directory.  This will acquire
additional parts to the condition in a future patch.

Changes:
========
ver #4)
 - Split from fscache fix.
 - Moved folio_needs_release() to mm/internal.h and removed open-coded
   version from filemap_release_folio().

ver #3)
 - Fixed mapping_clear_release_always() to use clear_bit() not set_bit().
 - Moved a '&&' to the correct line.

ver #2)
 - Rewrote entirely according to Willy's suggestion[1].

Reported-by: Rohith Surabattula <rohiths.msft@gmail.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Dave Wysochanski <dwysocha@redhat.com>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: linux-cachefs@redhat.com
cc: linux-cifs@vger.kernel.org
cc: linux-afs@lists.infradead.org
cc: v9fs-developer@lists.sourceforge.net
cc: ceph-devel@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/Yk9V/03wgdYi65Lb@casper.infradead.org/ [1]
Link: https://lore.kernel.org/r/164928630577.457102.8519251179327601178.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/166844174069.1124521.10890506360974169994.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/166869495238.3720468.4878151409085146764.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/1459152.1669208550@warthog.procyon.org.uk/ # v3 also
---

 fs/splice.c         |    3 +--
 mm/filemap.c        |    2 ++
 mm/huge_memory.c    |    3 +--
 mm/internal.h       |    8 ++++++++
 mm/khugepaged.c     |    3 +--
 mm/memory-failure.c |    3 +--
 mm/migrate.c        |    3 +--
 mm/truncate.c       |    6 ++----
 mm/vmscan.c         |    7 +++----
 9 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 0878b852b355..563105304ccc 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -65,8 +65,7 @@ static bool page_cache_pipe_buf_try_steal(struct pipe_inode_info *pipe,
 		 */
 		folio_wait_writeback(folio);
 
-		if (folio_has_private(folio) &&
-		    !filemap_release_folio(folio, GFP_KERNEL))
+		if (!filemap_release_folio(folio, GFP_KERNEL))
 			goto out_unlock;
 
 		/*
diff --git a/mm/filemap.c b/mm/filemap.c
index 08341616ae7a..93757247cd11 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3941,6 +3941,8 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
 	struct address_space * const mapping = folio->mapping;
 
 	BUG_ON(!folio_test_locked(folio));
+	if (!folio_needs_release(folio))
+		return true;
 	if (folio_test_writeback(folio))
 		return false;
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 811d19b5c4f6..308d36aa3197 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2683,8 +2683,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		gfp = current_gfp_context(mapping_gfp_mask(mapping) &
 							GFP_RECLAIM_MASK);
 
-		if (folio_test_private(folio) &&
-				!filemap_release_folio(folio, gfp)) {
+		if (!filemap_release_folio(folio, gfp)) {
 			ret = -EBUSY;
 			goto out;
 		}
diff --git a/mm/internal.h b/mm/internal.h
index 6b7ef495b56d..1fefb5181ab7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -163,6 +163,14 @@ static inline void set_page_refcounted(struct page *page)
 	set_page_count(page, 1);
 }
 
+/*
+ * Return true if a folio needs ->release_folio() calling upon it.
+ */
+static inline bool folio_needs_release(struct folio *folio)
+{
+	return folio_has_private(folio);
+}
+
 extern unsigned long highest_memmap_pfn;
 
 /*
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4734315f7940..7e9e0e3e678e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1883,8 +1883,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			goto out_unlock;
 		}
 
-		if (page_has_private(page) &&
-		    !try_to_release_page(page, GFP_KERNEL)) {
+		if (!try_to_release_page(page, GFP_KERNEL)) {
 			result = SCAN_PAGE_HAS_PRIVATE;
 			putback_lru_page(page);
 			goto out_unlock;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index bead6bccc7f2..82673fc01eed 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -831,8 +831,7 @@ static int truncate_error_page(struct page *p, unsigned long pfn,
 
 		if (err != 0) {
 			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
-		} else if (page_has_private(p) &&
-			   !try_to_release_page(p, GFP_NOIO)) {
+		} else if (!try_to_release_page(p, GFP_NOIO)) {
 			pr_info("%#lx: failed to release buffers\n", pfn);
 		} else {
 			ret = MF_RECOVERED;
diff --git a/mm/migrate.c b/mm/migrate.c
index dff333593a8a..d721ef340943 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -905,8 +905,7 @@ static int fallback_migrate_folio(struct address_space *mapping,
 	 * Buffers may be managed in a filesystem specific way.
 	 * We must have no buffers or drop them.
 	 */
-	if (folio_test_private(src) &&
-	    !filemap_release_folio(src, GFP_KERNEL))
+	if (!filemap_release_folio(src, GFP_KERNEL))
 		return mode == MIGRATE_SYNC ? -EAGAIN : -EBUSY;
 
 	return migrate_folio(mapping, dst, src, mode);
diff --git a/mm/truncate.c b/mm/truncate.c
index c0be77e5c008..0d4dd233f518 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -19,7 +19,6 @@
 #include <linux/highmem.h>
 #include <linux/pagevec.h>
 #include <linux/task_io_accounting_ops.h>
-#include <linux/buffer_head.h>	/* grr. try_to_release_page */
 #include <linux/shmem_fs.h>
 #include <linux/rmap.h>
 #include "internal.h"
@@ -276,7 +275,7 @@ static long mapping_evict_folio(struct address_space *mapping,
 	if (folio_ref_count(folio) >
 			folio_nr_pages(folio) + folio_has_private(folio) + 1)
 		return 0;
-	if (folio_has_private(folio) && !filemap_release_folio(folio, 0))
+	if (!filemap_release_folio(folio, 0))
 		return 0;
 
 	return remove_mapping(mapping, folio);
@@ -581,8 +580,7 @@ static int invalidate_complete_folio2(struct address_space *mapping,
 	if (folio->mapping != mapping)
 		return 0;
 
-	if (folio_has_private(folio) &&
-	    !filemap_release_folio(folio, GFP_KERNEL))
+	if (!filemap_release_folio(folio, GFP_KERNEL))
 		return 0;
 
 	spin_lock(&mapping->host->i_lock);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 04d8b88e5216..b9316f447238 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1978,7 +1978,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * (refcount == 1) it can be freed.  Otherwise, leave
 		 * the folio on the LRU so it is swappable.
 		 */
-		if (folio_has_private(folio)) {
+		if (folio_needs_release(folio)) {
 			if (!filemap_release_folio(folio, sc->gfp_mask))
 				goto activate_locked;
 			if (!mapping && folio_ref_count(folio) == 1) {
@@ -2592,9 +2592,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 		}
 
 		if (unlikely(buffer_heads_over_limit)) {
-			if (folio_test_private(folio) && folio_trylock(folio)) {
-				if (folio_test_private(folio))
-					filemap_release_folio(folio, 0);
+			if (folio_needs_release(folio) && folio_trylock(folio)) {
+				filemap_release_folio(folio, 0);
 				folio_unlock(folio);
 			}
 		}


