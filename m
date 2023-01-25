Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAA967AE55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 10:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjAYJmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 04:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbjAYJmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:42:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FC6869F
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 01:42:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6633621C87;
        Wed, 25 Jan 2023 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674639721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PLOgGtlxgWk8Df8C9rOhCqDe5ikolSIjDExntNB6zB8=;
        b=mk4gbM8nZdoOY4AT69M+/5ltfjTeTBEQkQpgQtQGFNhrrO0bLhVFKesEfP83tve1ajpXiI
        H+U8RpKXjES0mPc6PrRYORcxD1Zhn99solQcMQtQiBp8q0ac/0ffWRB/5NSmdaI3rYYl1D
        Q2ZMTt5H07Omhpgy0M/2ptOdH7gWcOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674639721;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PLOgGtlxgWk8Df8C9rOhCqDe5ikolSIjDExntNB6zB8=;
        b=K+KcV0VZEA9xexbuFEsUCHN1WC7F5c/s4n67EPyP2qqYrwq6QopRzi/PMaUAv+XsqcBeAT
        oDxgDxO/ozQtvCAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D8B913A08;
        Wed, 25 Jan 2023 09:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dhPqEmn50GMsIgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 09:42:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6DBA1A06D5; Wed, 25 Jan 2023 10:41:59 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 09/12] udf: Move udf_adinicb_readpage() to inode.c
Date:   Wed, 25 Jan 2023 10:41:51 +0100
Message-Id: <20230125094159.10877-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230125093914.24627-1-jack@suse.cz>
References: <20230125093914.24627-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2662; i=jack@suse.cz; h=from:subject; bh=E063OJasYfEby9ECqJUZOB5MJLzFH2niRlYkJ3uG2ys=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj0Pleg8XHnjrtvW4K8igHaDKjDlQwiLKC5O4+O8lp Obe+UjuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY9D5XgAKCRCcnaoHP2RA2SFZCA CxrZNmCapBoPT7zZe+02zzObJp/HRoV0im46eKHwXzcM+cp8a2VMCj6bf6AmFLFVVTw7d0O/QjKVzH 53QzHaOWX0DVgRAS0f6FbjFoeTYYDkcuOLemdJGwW/XZAcwQr5jYnLGknYk8Tl0nLB4LretfwnATNL HcckyoNgZ5tBFL7Tx5+3rQekpxb0g5K9LiyAKQh1J8v/mlszwGUUcSGEy/TVL1UggX/LO855AYHHh9 IwHZUmgwybchMNjpspt54uRwbf5hvSeL1J8wq4OKzG9fEQkrcBwHOXwCrD4IVA+WWN0bYabkMhVmbE PPkzd3CTEphYo0DhqjmXeXJ6y/zwmc
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index 688ecf60edfa..dc59b119d9ac 100644
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

