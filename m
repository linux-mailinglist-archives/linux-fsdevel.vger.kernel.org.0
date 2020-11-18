Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00272B7941
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 09:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgKRIso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 03:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbgKRIsm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:48:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83478C061A4D;
        Wed, 18 Nov 2020 00:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=p6UHeMdNPZtbtbIn43eVEAdBbhJQd+3671CGRMSmzGQ=; b=U+CT7FI/RNVqd8977Z9jys84zx
        D5PJs3XqwRZ2I4/5WIasYm3mO3hz6MEPuPBxpOUse9ZssA6t9l0w+A0keOeXTtOgMFzizktjEA7Hr
        lGo6ggP8TPFpI263wFUgLY4Kzp3fTQiuP7Z/THc501YB4CW12JxTpfjg2mdQPzSqE7OPNd4rECdn/
        7jivfGwOCd8eWfwYg+Y4GPsB7EFyXW29c/OGQJjvi228S9KWwCz09Usiub7OnZfO2EQoeDImpFdcG
        Z56X0eWsNkNq8gS/VMw0EsIXHjgjw650qnJtFnoE2b3neXJfoAYmgACwhZLOofNjqd+5jYI2I/PXp
        +43PTD3g==;
Received: from [2001:4bb8:18c:31ba:32b1:ec66:5459:36a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfJ8h-0007oc-Bb; Wed, 18 Nov 2020 08:48:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 17/20] filemap: consistently use ->f_mapping over ->i_mapping
Date:   Wed, 18 Nov 2020 09:47:57 +0100
Message-Id: <20201118084800.2339180-18-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118084800.2339180-1-hch@lst.de>
References: <20201118084800.2339180-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use file->f_mapping in all remaining places that have a struct file
available to properly handle the case where inode->i_mapping !=
file_inode(file)->i_mapping.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d5e7c2029d16b4..3e3531a757f8db 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2887,13 +2887,13 @@ EXPORT_SYMBOL(filemap_map_pages);
 vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = vmf->vma->vm_file->f_mapping->host;
 	vm_fault_t ret = VM_FAULT_LOCKED;
 
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vmf->vma->vm_file);
 	lock_page(page);
-	if (page->mapping != inode->i_mapping) {
+	if (page->mapping != vmf->vma->vm_file->f_mapping) {
 		unlock_page(page);
 		ret = VM_FAULT_NOPAGE;
 		goto out;
@@ -3149,10 +3149,9 @@ void dio_warn_stale_pagecache(struct file *filp)
 {
 	static DEFINE_RATELIMIT_STATE(_rs, 86400 * HZ, DEFAULT_RATELIMIT_BURST);
 	char pathname[128];
-	struct inode *inode = file_inode(filp);
 	char *path;
 
-	errseq_set(&inode->i_mapping->wb_err, -EIO);
+	errseq_set(&filp->f_mapping->wb_err, -EIO);
 	if (__ratelimit(&_rs)) {
 		path = file_path(filp, pathname, sizeof(pathname));
 		if (IS_ERR(path))
@@ -3179,7 +3178,7 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		/* If there are pages to writeback, return */
-		if (filemap_range_has_page(inode->i_mapping, pos,
+		if (filemap_range_has_page(file->f_mapping, pos,
 					   pos + write_len - 1))
 			return -EAGAIN;
 	} else {
-- 
2.29.2

