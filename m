Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB25467979B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjAXMSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbjAXMSZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DCB44BD7
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9F6531FE51;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/LexzJkYyZdL5w07xtp8eX7kMac/zwtvHB+V69eQ6mI=;
        b=FFCg81xwFEwDX1dNIKMaferuiGbBEwjcVz4PytqXj4/tj5YxVEsbify6GkqsFfnqEl43uF
        QtFFnJ7GE5/7wwi09V/Np/RHW3RjW2sxGZwfiDvkfulmLxbBRLNaZqLCjjgofFPs6PJqYm
        n+S6K/p9WeQLM5mNasGuEaK2mcjg+A8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/LexzJkYyZdL5w07xtp8eX7kMac/zwtvHB+V69eQ6mI=;
        b=nETo4woXX683PDV/GNGrgi+6aH5zTM9IlguTIv9V90wJg5uK6DKbpv0I53ThZtB95NX0+q
        8SwO3uOHPdA2hhDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90C5D139FB;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mgJUI4fMz2MEOAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 70E65A0709; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 19/22] udf: Allocate blocks on write page fault
Date:   Tue, 24 Jan 2023 13:18:05 +0100
Message-Id: <20230124121814.25951-19-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4298; i=jack@suse.cz; h=from:subject; bh=9tAb4yLTLO+EwlDOvr7dLHGRtCRctwuLmZopa9FLRyA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8x91DLpx34IN+Hbc9o3MFLgFKzQWZgKIJc9JTmf sTg5C/mJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/MfQAKCRCcnaoHP2RA2UvzCA CPWK78LvCrgGjeXW6rENaIkT7VNTbFn+DM+gt6qzKtROw22+tjEGy+AfRhz2BflFbk3yO/E46XXcuO y7bxOYEVFPQD4veUsLmmjRbfpzMFVpKy1qh8iWory/tBijs2A6K/71iwX97FM/Lc6zJBxe5pOTiO6n qmUfDIAaVqnwxPmh2NUu5ppJJUhI4y5tAyKIIvSwcOiMP6RRwSfrM+zIMeyqMVgNYb55q/Jrzg8oPY UjS+EK8khogT/qLolxtlGBwCEbA6bOLFspnPjHO3PJg5IQ9slNJp0ekI3cDMDPHYjNIiy1f9NnqDJX X+ONLM2QNWhtLjTQcwWFO/80B4wdTG
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently if file with holes is mapped, udf allocates blocks for dirtied
pages during page writeback. This however creates problems when to
truncate final extent to proper size and currently we leave the last
extent untruncated which violates UDF standard. So allocate blocks on
write page fault instead. In that case the last extent gets truncated
the file is closed and everything is happy.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/file.c    | 61 +++++++++++++++++++++++++++++++++++++++++++++++-
 fs/udf/inode.c   |  1 -
 fs/udf/udfdecl.h |  1 +
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index cf050bdffd9e..322115c8369d 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -134,6 +134,57 @@ const struct address_space_operations udf_adinicb_aops = {
 	.direct_IO	= udf_adinicb_direct_IO,
 };
 
+static vm_fault_t udf_page_mkwrite(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct inode *inode = file_inode(vma->vm_file);
+	struct address_space *mapping = inode->i_mapping;
+	struct page *page = vmf->page;
+	loff_t size;
+	unsigned int end;
+	vm_fault_t ret = VM_FAULT_LOCKED;
+	int err;
+
+	sb_start_pagefault(inode->i_sb);
+	file_update_time(vma->vm_file);
+	filemap_invalidate_lock_shared(mapping);
+	lock_page(page);
+	size = i_size_read(inode);
+	if (page->mapping != inode->i_mapping || page_offset(page) >= size) {
+		unlock_page(page);
+		ret = VM_FAULT_NOPAGE;
+		goto out_unlock;
+	}
+	/* Space is already allocated for in-ICB file */
+	if (UDF_I(inode)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
+		goto out_dirty;
+	if (page->index == size >> PAGE_SHIFT)
+		end = size & ~PAGE_MASK;
+	else
+		end = PAGE_SIZE;
+	err = __block_write_begin(page, 0, end, udf_get_block);
+	if (!err)
+		err = block_commit_write(page, 0, end);
+	if (err < 0) {
+		unlock_page(page);
+		ret = block_page_mkwrite_return(err);
+		goto out_unlock;
+	}
+out_dirty:
+	set_page_dirty(page);
+	wait_for_stable_page(page);
+out_unlock:
+	filemap_invalidate_unlock_shared(mapping);
+	sb_end_pagefault(inode->i_sb);
+	return ret;
+}
+
+static const struct vm_operations_struct udf_file_vm_ops = {
+	.fault		= filemap_fault,
+	.map_pages	= filemap_map_pages,
+	.page_mkwrite	= udf_page_mkwrite,
+};
+
 static ssize_t udf_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	ssize_t retval;
@@ -238,11 +289,19 @@ static int udf_release_file(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static int udf_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	file_accessed(file);
+	vma->vm_ops = &udf_file_vm_ops;
+
+	return 0;
+}
+
 const struct file_operations udf_file_operations = {
 	.read_iter		= generic_file_read_iter,
 	.unlocked_ioctl		= udf_ioctl,
 	.open			= generic_file_open,
-	.mmap			= generic_file_mmap,
+	.mmap			= udf_file_mmap,
 	.write_iter		= udf_file_write_iter,
 	.release		= udf_release_file,
 	.fsync			= generic_file_fsync,
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 7109adcceefe..7fd0aa2439e9 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -68,7 +68,6 @@ static void udf_prealloc_extents(struct inode *, int, int,
 static void udf_merge_extents(struct inode *, struct kernel_long_ad *, int *);
 static int udf_update_extents(struct inode *, struct kernel_long_ad *, int,
 			      int, struct extent_position *);
-static int udf_get_block(struct inode *, sector_t, struct buffer_head *, int);
 
 static void __udf_clear_extent_cache(struct inode *inode)
 {
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 98b4d89b4368..5ba59ab90d48 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -160,6 +160,7 @@ extern void udf_evict_inode(struct inode *);
 extern int udf_write_inode(struct inode *, struct writeback_control *wbc);
 extern int8_t inode_bmap(struct inode *, sector_t, struct extent_position *,
 			 struct kernel_lb_addr *, uint32_t *, sector_t *);
+int udf_get_block(struct inode *, sector_t, struct buffer_head *, int);
 extern int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
 				   struct extent_position *epos);
 extern int __udf_add_aext(struct inode *inode, struct extent_position *epos,
-- 
2.35.3

