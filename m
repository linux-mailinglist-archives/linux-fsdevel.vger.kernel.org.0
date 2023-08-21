Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B17782BFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 16:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjHUOgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 10:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbjHUOgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:36:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1B0E2;
        Mon, 21 Aug 2023 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2q41UfV5n98MJ5ge86F5yueit9/2pAEyQgCuf9zrqpk=; b=ERqNPjlFVAxH6r9HwrRpzFuQB+
        V2jSnmzJBKmlA98WO/NSzm4yPhQU5G/5Zxwwd/L2ZU+G/PUc4SoYoT1qx57nwgA2w7MA9pWYMgr9e
        R9dU8B7DQRKk2g7w0pNwLjQcG8oH2OOqI4SDU27nfeRMok8WKgJyB9VV8Y+9rp+eVd1VzGiWYrlVD
        509f7wO74USXzLqv9hwJAIWwIKgaf21b/NayMf9ONKVk0LkTtKl24uPGMed8R0Tzr5zi5ah9ofaRD
        QWurcihLhviG4dMw8hm0iup+Q971CqoHNpUB3Y6gqkCBwMQdCXRhEHyAXTUXoqq8OYPRFpiG1KTXB
        U6i7EluQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qY61K-00Aj45-MP; Mon, 21 Aug 2023 14:36:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] ceph: Convert ceph_page_mkwrite() to use a folio
Date:   Mon, 21 Aug 2023 15:36:39 +0100
Message-Id: <20230821143640.2556497-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
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

Operate on the entire folio instead of just the page.  There was an
earlier effort to do this with thp_size(), but it had the exact type
confusion between head & tail pages that folios are designed to avoid.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 59cbfb80edbd..5ff5ad408a2a 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1565,8 +1565,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_file_info *fi = vma->vm_file->private_data;
 	struct ceph_cap_flush *prealloc_cf;
-	struct page *page = vmf->page;
-	loff_t off = page_offset(page);
+	struct folio *folio = page_folio(vmf->page);
+	loff_t pos = folio_pos(folio);
 	loff_t size = i_size_read(inode);
 	size_t len;
 	int want, got, err;
@@ -1583,50 +1583,49 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 	ceph_block_sigs(&oldset);
 
-	if (off + thp_size(page) <= size)
-		len = thp_size(page);
-	else
-		len = offset_in_thp(page, size);
+	len = folio_size(folio);
+	if (pos + folio_size(folio) > size)
+		len = size - pos;
 
 	dout("page_mkwrite %p %llx.%llx %llu~%zd getting caps i_size %llu\n",
-	     inode, ceph_vinop(inode), off, len, size);
+	     inode, ceph_vinop(inode), pos, len, size);
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
 		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
 	else
 		want = CEPH_CAP_FILE_BUFFER;
 
 	got = 0;
-	err = ceph_get_caps(vma->vm_file, CEPH_CAP_FILE_WR, want, off + len, &got);
+	err = ceph_get_caps(vma->vm_file, CEPH_CAP_FILE_WR, want, pos + len, &got);
 	if (err < 0)
 		goto out_free;
 
 	dout("page_mkwrite %p %llu~%zd got cap refs on %s\n",
-	     inode, off, len, ceph_cap_string(got));
+	     inode, pos, len, ceph_cap_string(got));
 
-	/* Update time before taking page lock */
+	/* Update time before taking folio lock */
 	file_update_time(vma->vm_file);
 	inode_inc_iversion_raw(inode);
 
 	do {
 		struct ceph_snap_context *snapc;
 
-		lock_page(page);
+		folio_lock(folio);
 
-		if (page_mkwrite_check_truncate(page, inode) < 0) {
-			unlock_page(page);
+		if (folio_mkwrite_check_truncate(folio, inode) < 0) {
+			folio_unlock(folio);
 			ret = VM_FAULT_NOPAGE;
 			break;
 		}
 
-		snapc = ceph_find_incompatible(page);
+		snapc = ceph_find_incompatible(&folio->page);
 		if (!snapc) {
-			/* success.  we'll keep the page locked. */
-			set_page_dirty(page);
+			/* success.  we'll keep the folio locked. */
+			folio_mark_dirty(folio);
 			ret = VM_FAULT_LOCKED;
 			break;
 		}
 
-		unlock_page(page);
+		folio_unlock(folio);
 
 		if (IS_ERR(snapc)) {
 			ret = VM_FAULT_SIGBUS;
@@ -1650,7 +1649,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	}
 
 	dout("page_mkwrite %p %llu~%zd dropping cap refs on %s ret %x\n",
-	     inode, off, len, ceph_cap_string(got), ret);
+	     inode, pos, len, ceph_cap_string(got), ret);
 	ceph_put_cap_refs_async(ci, got);
 out_free:
 	ceph_restore_sigs(&oldset);
-- 
2.40.1

