Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30599679740
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjAXMGi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjAXMGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:06:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4483F42BFA
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:06:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01FF51FDC3;
        Tue, 24 Jan 2023 12:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674561992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ara88Qb3ym1wwr9lS9t+NA7QgVpyzxdqZ5el5Ihlk9E=;
        b=Fr+ZyOiRsA57JCwwMd4PyEyS2i6YSg7HOmmFX1NYan7In8zt6I+aY8WGgA8RYsexTS2PWN
        MaQ9vqi+fK+dQ5pYte6STS115dr4Bqb5aEecDIjfvDa8gucrwjfqQ/8LW+uWnw91E/w7v5
        tbPNvglk9w7n949GAvEIihAvEQSOzxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674561992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ara88Qb3ym1wwr9lS9t+NA7QgVpyzxdqZ5el5Ihlk9E=;
        b=Dj+uuTaQqSsMISGHQdA76uTWd+hE9y4gr6DBdrkEaeZYWvxtgT7NpdhwFJpKeouW9dJcMb
        DTT1x0usObwU02DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E76DD139FB;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VFd5OMfJz2MRMQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:06:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 524F3A06D4; Tue, 24 Jan 2023 13:06:31 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 09/10] udf: Move udf_adinicb_readpage() to inode.c
Date:   Tue, 24 Jan 2023 13:06:20 +0100
Message-Id: <20230124120628.24449-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120221.31585-1-jack@suse.cz>
References: <20230124120221.31585-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2617; i=jack@suse.cz; h=from:subject; bh=Lptni6NBCCnC+8UssvGb4sOKDFLLkq3D2y+B0kOllHU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8m7SWTA/b8kiVk4ZO48Lm79PaLDJ/r1b+DpK+eV 0ZNHHK6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/JuwAKCRCcnaoHP2RA2caSCA C0MRB0NUCkckXXd/9UZGhCEjLxaPBpab0WbtciDp4F0Lzf/Jlmi12qFeY9B5vrhrO1lVH51v8JrnXA CHZ1qV52X2Dcqi1pJzDPiWUll+ndbWU+fCIAwqF+1siP5DqKasZlfNU8Q1KapBydSpMDtpftJ8L58k yaJ0wRaVUYIPCwgeOY9hMYg8mY7UvW0WddLB+BLJEt1Ql9W77JctQzF47L4b0FYbeQFJHTZyH1jvKM gOON6yVLxORpeaNCgMWvMevACz/RnM0jddEIXF8dfhJFIqjAmIi/vzYq1jNTAy5fN4CofD3I/m5D2k 69biOXUinZS0ZtxJnSVCZ6fTdknLMb
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

udf_adinicb_readpage() is only called from aops functions, move it to
the same file as its callers and also drop the stale comment -
invalidate_lock is protecting us against races with truncate.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/file.c    | 19 -------------------
 fs/udf/inode.c   | 15 +++++++++++++++
 fs/udf/udfdecl.h |  1 -
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 84e0b241940d..26592577b7da 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -38,25 +38,6 @@
 #include "udf_i.h"
 #include "udf_sb.h"
 
-void udf_adinicb_readpage(struct page *page)
-{
-	struct inode *inode = page->mapping->host;
-	char *kaddr;
-	struct udf_inode_info *iinfo = UDF_I(inode);
-	loff_t isize = i_size_read(inode);
-
-	/*
-	 * We have to be careful here as truncate can change i_size under us.
-	 * So just sample it once and use the same value everywhere.
-	 */
-	kaddr = kmap_atomic(page);
-	memcpy(kaddr, iinfo->i_data + iinfo->i_lenEAttr, isize);
-	memset(kaddr + isize, 0, PAGE_SIZE - isize);
-	flush_dcache_page(page);
-	SetPageUptodate(page);
-	kunmap_atomic(kaddr);
-}
-
 static vm_fault_t udf_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index af069a05919c..dcd3f1dac227 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -215,6 +215,21 @@ static int udf_writepages(struct address_space *mapping,
 	return write_cache_pages(mapping, wbc, udf_adinicb_writepage, NULL);
 }
 
+static void udf_adinicb_readpage(struct page *page)
+{
+	struct inode *inode = page->mapping->host;
+	char *kaddr;
+	struct udf_inode_info *iinfo = UDF_I(inode);
+	loff_t isize = i_size_read(inode);
+
+	kaddr = kmap_atomic(page);
+	memcpy(kaddr, iinfo->i_data + iinfo->i_lenEAttr, isize);
+	memset(kaddr + isize, 0, PAGE_SIZE - isize);
+	flush_dcache_page(page);
+	SetPageUptodate(page);
+	kunmap_atomic(kaddr);
+}
+
 static int udf_read_folio(struct file *file, struct folio *folio)
 {
 	struct udf_inode_info *iinfo = UDF_I(file_inode(file));
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 337daf97d5b4..88692512a466 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -137,7 +137,6 @@ static inline unsigned int udf_dir_entry_len(struct fileIdentDesc *cfi)
 
 /* file.c */
 extern long udf_ioctl(struct file *, unsigned int, unsigned long);
-void udf_adinicb_readpage(struct page *page);
 
 /* inode.c */
 extern struct inode *__udf_iget(struct super_block *, struct kernel_lb_addr *,
-- 
2.35.3

