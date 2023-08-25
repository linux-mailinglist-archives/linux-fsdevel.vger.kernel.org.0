Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A526C788F96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjHYUNP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 16:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjHYUMt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:12:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E005268A;
        Fri, 25 Aug 2023 13:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jomRhgeRXKv1vsQXdMFLWYPA9/3kP5jRtYIdLxcDt9c=; b=IDto1b8yGyIj2PHG0DycPU8Taw
        UbueBIsuiN6DeAaFKZyqATDalKxH/5ldxSiGJETOZAXzaPnHEqANa+HQvIfs+W99CCoKx9tKlwjRC
        P3Xr4eWpMwODJW+cXrDRVcCoz8ULePwU20V9lQ15Rn2gE02FrPNihl/56s9MLGayrFnohcKG+A5CK
        oC+EZ4yJyaUgOuhA0Q5XYrki8xjMsukibH8acjboC7ov77zRguVKYfqVDGK7K7UJ7pAaKSnFHA8kD
        JKgzrtrogggGk4aXbzcwt8p8fwbEtyf6wE49fKGXwY/2gZ/i2gp0Dn/Xfh0jDoc1ZOwpKfyos/gO7
        KLAm9BWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZdAV-001SZo-I9; Fri, 25 Aug 2023 20:12:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/15] ceph: Convert ceph_find_incompatible() to take a folio
Date:   Fri, 25 Aug 2023 21:12:16 +0100
Message-Id: <20230825201225.348148-7-willy@infradead.org>
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

Both callers alredy have a folio, so pass it in.  Use folio->index
to identify the folio in debug output rather than the folio pointer.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 785f2983ac0e..0027906a9257 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1385,23 +1385,22 @@ static int context_is_writeable_or_written(struct inode *inode,
 
 /**
  * ceph_find_incompatible - find an incompatible context and return it
- * @page: page being dirtied
+ * @folio: folio being dirtied
  *
- * We are only allowed to write into/dirty a page if the page is
+ * We are only allowed to write into/dirty a folio if the folio is
  * clean, or already dirty within the same snap context. Returns a
  * conflicting context if there is one, NULL if there isn't, or a
  * negative error code on other errors.
  *
- * Must be called with page lock held.
+ * Must be called with folio lock held.
  */
-static struct ceph_snap_context *
-ceph_find_incompatible(struct page *page)
+static struct ceph_snap_context *ceph_find_incompatible(struct folio *folio)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	if (ceph_inode_is_shutdown(inode)) {
-		dout(" page %p %llx:%llx is shutdown\n", page,
+		dout(" folio %ld %llx:%llx is shutdown\n", folio->index,
 		     ceph_vinop(inode));
 		return ERR_PTR(-ESTALE);
 	}
@@ -1409,29 +1408,31 @@ ceph_find_incompatible(struct page *page)
 	for (;;) {
 		struct ceph_snap_context *snapc, *oldest;
 
-		wait_on_page_writeback(page);
+		folio_wait_writeback(folio);
 
-		snapc = page_snap_context(page);
+		snapc = folio->private;
 		if (!snapc || snapc == ci->i_head_snapc)
 			break;
 
 		/*
-		 * this page is already dirty in another (older) snap
+		 * this folio is already dirty in another (older) snap
 		 * context!  is it writeable now?
 		 */
 		oldest = get_oldest_context(inode, NULL, NULL);
 		if (snapc->seq > oldest->seq) {
 			/* not writeable -- return it for the caller to deal with */
 			ceph_put_snap_context(oldest);
-			dout(" page %p snapc %p not current or oldest\n", page, snapc);
+			dout(" folio %ld snapc %p not current or oldest\n",
+					folio->index, snapc);
 			return ceph_get_snap_context(snapc);
 		}
 		ceph_put_snap_context(oldest);
 
-		/* yay, writeable, do it now (without dropping page lock) */
-		dout(" page %p snapc %p not current, but oldest\n", page, snapc);
-		if (clear_page_dirty_for_io(page)) {
-			int r = writepage_nounlock(page, NULL);
+		/* yay, writeable, do it now (without dropping folio lock) */
+		dout(" folio %ld snapc %p not current, but oldest\n",
+				folio->index, snapc);
+		if (folio_clear_dirty_for_io(folio)) {
+			int r = writepage_nounlock(&folio->page, NULL);
 			if (r < 0)
 				return ERR_PTR(r);
 		}
@@ -1446,7 +1447,7 @@ static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_snap_context *snapc;
 
-	snapc = ceph_find_incompatible(folio_page(*foliop, 0));
+	snapc = ceph_find_incompatible(*foliop);
 	if (snapc) {
 		int r;
 
@@ -1705,7 +1706,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 			break;
 		}
 
-		snapc = ceph_find_incompatible(&folio->page);
+		snapc = ceph_find_incompatible(folio);
 		if (!snapc) {
 			/* success.  we'll keep the folio locked. */
 			folio_mark_dirty(folio);
-- 
2.40.1

