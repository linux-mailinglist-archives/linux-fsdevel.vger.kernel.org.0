Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436A7788F8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 22:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjHYUNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 16:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHYUMk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:12:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022F22689;
        Fri, 25 Aug 2023 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=A9e9J+dnjCMMc42iX3zzfqVkWCVEH8VUZ/HYaNwAhhc=; b=CagZXzLXuThc8baN2nwM8XfRJN
        YbdQX6dtKhmbFS05r0NgijXYb3fAT98IPpHszGOlgO88v4SswgP9vHxD36boL3hsVFdBxD+zLH3gb
        /67Ng23CL7XEAfPnlWPlgps895UvfIevcOvGEOg7soNsWbkYewo8VGjLelwJFFAG747jIiDqmVfwF
        qYWEfcDLaEGZvcpjhCZ/kDyAm0nROWwy0TcDKJtmlxkiUMPHJ1VpGwhb5p8qsSr379zeknq9JR420
        SlkWcFE3YxORScNkSuTJnNiMyEtjyY5ioXZE3HianNXgqgXv7pCcxZEfVtR2pg7KV/RY0pxpQ5Np1
        QJJMM5Hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZdAW-001SaN-9p; Fri, 25 Aug 2023 20:12:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/15] ceph: Convert ceph_fill_inline_data() to take a folio
Date:   Fri, 25 Aug 2023 21:12:23 +0100
Message-Id: <20230825201225.348148-14-willy@infradead.org>
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

Its one caller now has a folio, so use the folio API within this
function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c  | 44 ++++++++++++++++++++------------------------
 fs/ceph/inode.c |  2 +-
 fs/ceph/super.h |  2 +-
 3 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 09178a8ebbde..79d8f2fddd49 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1748,47 +1748,43 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	return ret;
 }
 
-void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
+void ceph_fill_inline_data(struct inode *inode, struct folio *locked_folio,
 			   char	*data, size_t len)
 {
 	struct address_space *mapping = inode->i_mapping;
-	struct page *page;
+	struct folio *folio;
 
-	if (locked_page) {
-		page = locked_page;
+	if (locked_folio) {
+		folio = locked_folio;
 	} else {
 		if (i_size_read(inode) == 0)
 			return;
-		page = find_or_create_page(mapping, 0,
-					   mapping_gfp_constraint(mapping,
-					   ~__GFP_FS));
-		if (!page)
+		folio = __filemap_get_folio(mapping, 0,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+				mapping_gfp_constraint(mapping, ~__GFP_FS));
+		if (IS_ERR(folio))
 			return;
-		if (PageUptodate(page)) {
-			unlock_page(page);
-			put_page(page);
+		if (folio_test_uptodate(folio)) {
+			folio_unlock(folio);
+			folio_put(folio);
 			return;
 		}
 	}
 
-	dout("fill_inline_data %p %llx.%llx len %zu locked_page %p\n",
-	     inode, ceph_vinop(inode), len, locked_page);
+	dout("fill_inline_data %p %llx.%llx len %zu locked_folio %lu\n",
+	     inode, ceph_vinop(inode), len, locked_folio->index);
 
-	if (len > 0) {
-		void *kaddr = kmap_atomic(page);
-		memcpy(kaddr, data, len);
-		kunmap_atomic(kaddr);
-	}
+	memcpy_to_folio(folio, 0, data, len);
 
-	if (page != locked_page) {
+	if (folio != locked_folio) {
 		if (len < PAGE_SIZE)
-			zero_user_segment(page, len, PAGE_SIZE);
+			folio_zero_segment(folio, len, PAGE_SIZE);
 		else
-			flush_dcache_page(page);
+			flush_dcache_folio(folio);
 
-		SetPageUptodate(page);
-		unlock_page(page);
-		put_page(page);
+		folio_mark_uptodate(folio);
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 }
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index d5f0fe39b92f..70f7f68ba078 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1277,7 +1277,7 @@ int ceph_fill_inode(struct inode *inode, struct folio *locked_folio,
 	ceph_fscache_register_inode_cookie(inode);
 
 	if (fill_inline)
-		ceph_fill_inline_data(inode, &locked_folio->page,
+		ceph_fill_inline_data(inode, locked_folio,
 				      iinfo->inline_data, iinfo->inline_len);
 
 	if (wake)
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index d741a9d15f52..a986928c3000 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1311,7 +1311,7 @@ extern ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 				struct iov_iter *to, int *retry_op,
 				u64 *last_objver);
 extern int ceph_release(struct inode *inode, struct file *filp);
-extern void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
+void ceph_fill_inline_data(struct inode *inode, struct folio *locked_folio,
 				  char *data, size_t len);
 
 /* dir.c */
-- 
2.40.1

