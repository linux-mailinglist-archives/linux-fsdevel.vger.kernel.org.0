Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552A4788FAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 22:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjHYUNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 16:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjHYUNF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:13:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8393C2689;
        Fri, 25 Aug 2023 13:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dfPpMfT3npKcuIPDMg3T+cilMd95HrxU5W9P9LLusR8=; b=dK2IXa0WnxfkxKPz1IUR3RfKVO
        VdCaZiOH+iSafL7SHw4SfCTmiDtvTx1g9OWjN7/K185D3gORpdSBGAHsSj5Md/ahto23OUtSWw3/w
        niisieIEhpPUJLwQL7xyznQP1VA7F/E+JbHRDJOUiLqacYM8zfTelFZR7nCNz4SiHfukxnslHfHjA
        h9ubXySZwNnqKCp3ksA0Pf7X5RF/HvWSIy5mHE/Ye8CQW45BOz35akqeWGxqEF9xOITjY6bk+12Dk
        dGbBOQlhlnxbCLC8F2uBN9fDESTH0ZJzd8+XYo3JRa5MyuHqJUOLq1z1bP9WAtd0p6RJ28EDFSlaG
        4+GKW+yQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZdAV-001SZu-QY; Fri, 25 Aug 2023 20:12:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/15] ceph: Use a folio in ceph_filemap_fault()
Date:   Fri, 25 Aug 2023 21:12:19 +0100
Message-Id: <20230825201225.348148-10-willy@infradead.org>
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

This leg of the function is concerned with inline data, so we know it's
at index 0 and contains only a single page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 765b37db2729..1812c3e6e64f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1608,29 +1608,30 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		ret = VM_FAULT_SIGBUS;
 	} else {
 		struct address_space *mapping = inode->i_mapping;
-		struct page *page;
+		struct folio *folio;
 
 		filemap_invalidate_lock_shared(mapping);
-		page = find_or_create_page(mapping, 0,
+		folio = __filemap_get_folio(mapping, 0,
+				FGP_LOCK|FGP_ACCESSED|FGP_CREAT,
 				mapping_gfp_constraint(mapping, ~__GFP_FS));
-		if (!page) {
+		if (!folio) {
 			ret = VM_FAULT_OOM;
 			goto out_inline;
 		}
-		err = __ceph_do_getattr(inode, page,
+		err = __ceph_do_getattr(inode, &folio->page,
 					 CEPH_STAT_CAP_INLINE_DATA, true);
 		if (err < 0 || off >= i_size_read(inode)) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			ret = vmf_error(err);
 			goto out_inline;
 		}
 		if (err < PAGE_SIZE)
-			zero_user_segment(page, err, PAGE_SIZE);
+			folio_zero_segment(folio, err, folio_size(folio));
 		else
-			flush_dcache_page(page);
-		SetPageUptodate(page);
-		vmf->page = page;
+			flush_dcache_folio(folio);
+		folio_mark_uptodate(folio);
+		vmf->page = folio_page(folio, 0);
 		ret = VM_FAULT_MAJOR | VM_FAULT_LOCKED;
 out_inline:
 		filemap_invalidate_unlock_shared(mapping);
-- 
2.40.1

