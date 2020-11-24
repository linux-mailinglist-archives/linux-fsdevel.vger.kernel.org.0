Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EA02C2746
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388003AbgKXN2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388071AbgKXN2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:28:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D35C0613D6;
        Tue, 24 Nov 2020 05:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Q/MCT6maV/iKaSxRRRnLFBnoEWfPfC40ypgl1Ci8nRk=; b=pWcZmhed1VtM52P3q1JMqqjfxR
        GWMfkfGGh21/NCT85snknz3WDUM0FCyAbepRt+ZELj82dad4m3br4Sawb66pKbQxSAEUaJxSeL+Ll
        71lYUsvhjLKgY/YbGp0X++3PkxXh+KrssNfKTT0h2mCWPuefl+mBpjJwTcCV+e1SRjBbrscsDgFCm
        lMW8Geg/e4WV3fB64E9SDr1XU5cgwgMIdLeq0nWxNCx03aqe1+hiU2wmbmGncWiO1/xxhiOEuXkHa
        z9KSmzy5zBC51q81wbv9yHNv1xP232XeeVA1TEmOLWeYTbWgkPDrO0cmsehbzSHT+I2DtVpVX0ELT
        qGUkh4WA==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYMO-0006UA-S8; Tue, 24 Nov 2020 13:27:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 02/45] filemap: consistently use ->f_mapping over ->i_mapping
Date:   Tue, 24 Nov 2020 14:27:08 +0100
Message-Id: <20201124132751.3747337-3-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
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
 mm/filemap.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d5e7c2029d16b4..4f583489aa3c2a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2886,14 +2886,14 @@ EXPORT_SYMBOL(filemap_map_pages);
 
 vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
 {
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	struct page *page = vmf->page;
-	struct inode *inode = file_inode(vmf->vma->vm_file);
 	vm_fault_t ret = VM_FAULT_LOCKED;
 
-	sb_start_pagefault(inode->i_sb);
+	sb_start_pagefault(mapping->host->i_sb);
 	file_update_time(vmf->vma->vm_file);
 	lock_page(page);
-	if (page->mapping != inode->i_mapping) {
+	if (page->mapping != mapping) {
 		unlock_page(page);
 		ret = VM_FAULT_NOPAGE;
 		goto out;
@@ -2906,7 +2906,7 @@ vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
 	set_page_dirty(page);
 	wait_for_stable_page(page);
 out:
-	sb_end_pagefault(inode->i_sb);
+	sb_end_pagefault(mapping->host->i_sb);
 	return ret;
 }
 
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

