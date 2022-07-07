Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A1A56A62E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 16:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbiGGOxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 10:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiGGOwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:52:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9425A2F3;
        Thu,  7 Jul 2022 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=IIwSLAsT8Zxbwt+z53eMtSGI+LGR7i7cI8bTLNfzNEA=; b=UsmJLv9E+TzzzanA4UbLSfK2XL
        BD35d5yrp2WoJg25kIL8vZCnp69dJxtMOjQKDcB0lUqOq0EbFnGDQ7In9wqD63Xs/K5mjki1SHpj3
        TaikxZoWq2Po/ebSzacEYMuoDWMS6uz5WE6OpkkbbFoW5w7Jqo/QiayE70z531ioWl+ZbpbfQHhzC
        zD2QQLi/0CfAykmQPGHCRESkoaNwp2rxTUDDfID84WZ+ZYCZXRmM9iBHqQCjFZWxUQsYBnIOMM69Y
        fAPAVKNSgqYINYQhT7hFN2hO2yN7CFiY/Qr7sbCBeAvwAxjnmcktRHy36iE4rHCyyO02GobRviY3C
        uz1ZWmIg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9Sr4-002ezZ-D8; Thu, 07 Jul 2022 14:51:46 +0000
Date:   Thu, 7 Jul 2022 15:51:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC] Convert ceph_page_mkwrite to use a folio
Message-ID: <YsbzAoGAAZtlxsrd@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are some latent bugs that I fix here (eg, you can't call
thp_size() on a tail page), but the real question is how Ceph in
particular (and FS in general) want to handle mkwrite in a world
of multi-page folios.

If we have a multi-page folio which is occupying an entire PMD, then
no question, we have to mark all 2MB (or whatever) as dirty.  But
if it's being mapped with PTEs, either because it's mapped misaligned,
or it's smaller than a PMD, then we have a choice.  We can either
work in 4kB chunks, marking each one dirty (and storing the sub-folio
dirty state in the fs private data) like a write might.  Or we can
just say "Hey, the whole folio is dirty now" and not try to track
dirtiness on a per-page granularity.

The latter course seems to have been taken, modulo the bugs, but I
don't know if any thought was taken or whether it was done by rote.

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6dee88815491..fb346b929f65 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1503,8 +1503,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
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
@@ -1521,50 +1521,50 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 	ceph_block_sigs(&oldset);
 
-	if (off + thp_size(page) <= size)
-		len = thp_size(page);
+	if (pos + folio_size(folio) <= size)
+		len = folio_size(folio);
 	else
-		len = offset_in_thp(page, size);
+		len = offset_in_folio(folio, size);
 
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
@@ -1588,7 +1588,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	}
 
 	dout("page_mkwrite %p %llu~%zd dropping cap refs on %s ret %x\n",
-	     inode, off, len, ceph_cap_string(got), ret);
+	     inode, pos, len, ceph_cap_string(got), ret);
 	ceph_put_cap_refs_async(ci, got);
 out_free:
 	ceph_restore_sigs(&oldset);
