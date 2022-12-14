Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B3364C70C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 11:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbiLNKZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 05:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbiLNKZE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 05:25:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FB11D651
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Dec 2022 02:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671013457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9DJ2kTciZzCUi4gXkRMDzEafqQw+pBRgsl61iDLuufk=;
        b=gfMDp63EH2iLAwKsMhNu8+vdNtFpVmZ6j3KHqmXdjnEpL63eCDYF4/kvJqhCQyBcQx467O
        GX4m2WJLRw9YZVSTV0Za7IKxQJVNwLQJ8323PnKrKr991wG+qAFGCPm3tWGMc02OD9aDp5
        waMUjj1KCBS0lIiUDOMRIOQ5w04LgwE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-lUglsYFDMFq9neTi2pjZgw-1; Wed, 14 Dec 2022 05:24:12 -0500
X-MC-Unique: lUglsYFDMFq9neTi2pjZgw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 382D318A6460;
        Wed, 14 Dec 2022 10:24:12 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-138.brq.redhat.com [10.40.192.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4A5F51FF;
        Wed, 14 Dec 2022 10:24:10 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] iomap: Move page_done callback under the folio lock
Date:   Wed, 14 Dec 2022 11:24:09 +0100
Message-Id: <20221214102409.1857526-1-agruenba@redhat.com>
In-Reply-To: <Y5l9zhhyOE+RNVgO@infradead.org>
References: <Y5l9zhhyOE+RNVgO@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Move the ->page_done() call in iomap_write_end() under the folio lock.
This closes a race between journaled data writes and the shrinker in
gfs2.  What's happening is that gfs2_iomap_page_done() is called after
the page has been unlocked, so try_to_free_buffers() can come in and
free the buffers while gfs2_iomap_page_done() is trying to add them to
the current transaction.  The folio lock prevents that from happening.

The only current user of ->page_done() is gfs2, so other filesystems are
not affected.  Still, to catch out any new users, switch from page to
folio in ->page_done().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c         |  7 ++++---
 fs/iomap/buffered-io.c |  4 ++--
 include/linux/iomap.h  | 10 +++++-----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index e7537fd305dd..c4ee47f8e499 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -968,14 +968,15 @@ static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
 }
 
 static void gfs2_iomap_page_done(struct inode *inode, loff_t pos,
-				 unsigned copied, struct page *page)
+				 unsigned copied, struct folio *folio)
 {
 	struct gfs2_trans *tr = current->journal_info;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
-	if (page && !gfs2_is_stuffed(ip))
-		gfs2_page_add_databufs(ip, page, offset_in_page(pos), copied);
+	if (folio && !gfs2_is_stuffed(ip))
+		gfs2_page_add_databufs(ip, &folio->page, offset_in_page(pos),
+				       copied);
 
 	if (tr->tr_num_buf_new)
 		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 91ee0b308e13..d988c1bedf70 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -714,12 +714,12 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		i_size_write(iter->inode, pos + ret);
 		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
 	}
+	if (page_ops && page_ops->page_done)
+		page_ops->page_done(iter->inode, pos, ret, folio);
 	folio_unlock(folio);
 
 	if (old_size < pos)
 		pagecache_isize_extended(iter->inode, old_size, pos);
-	if (page_ops && page_ops->page_done)
-		page_ops->page_done(iter->inode, pos, ret, &folio->page);
 	folio_put(folio);
 
 	if (ret < len)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 238a03087e17..bd6d80453726 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -116,18 +116,18 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
 
 /*
  * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
- * and page_done will be called for each page written to.  This only applies to
- * buffered writes as unbuffered writes will not typically have pages
+ * and page_done will be called for each folio written to.  This only applies
+ * to buffered writes as unbuffered writes will not typically have folios
  * associated with them.
  *
  * When page_prepare succeeds, page_done will always be called to do any
- * cleanup work necessary.  In that page_done call, @page will be NULL if the
- * associated page could not be obtained.
+ * cleanup work necessary.  In that page_done call, @folio will be NULL if the
+ * associated folio could not be obtained.
  */
 struct iomap_page_ops {
 	int (*page_prepare)(struct inode *inode, loff_t pos, unsigned len);
 	void (*page_done)(struct inode *inode, loff_t pos, unsigned copied,
-			struct page *page);
+			struct folio *folio);
 };
 
 /*
-- 
2.38.1

