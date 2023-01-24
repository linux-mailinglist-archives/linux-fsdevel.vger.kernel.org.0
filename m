Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F9D679741
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjAXMGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjAXMGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:06:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE3D2330C
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:06:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E7C82186E;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674561991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ty2kukv5CA/sDrV7h7EMy8mqPfLF2jDWPEmcN+kLzCs=;
        b=3DqDROsRgyVjdFXsWohp4GFnEvZJ3wSaVM2qywsYTkhRIQzdSVhRxv6766/da5yT5Kr65c
        yQqzFHsVOyD0AkVna5gX5shPdzPY5YtaVyRNM1lRYi6yVbVWE7oHzFCN2FNdBvabdLDMND
        bbvA+JRZBJw5Nv05DJsM1B3k5kQ7FFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674561991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ty2kukv5CA/sDrV7h7EMy8mqPfLF2jDWPEmcN+kLzCs=;
        b=4yTi8BOlFZ+ssvnWf73mnzDliS3km0ANjvHKoT1fKhyZv5EjPicklui0jlVuKtl3VOIj5Y
        neZqEdg0FwYEiXDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8227A139FF;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IgPJH8fJz2P/MAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:06:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 27ADAA06B6; Tue, 24 Jan 2023 13:06:31 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        syzbot+c27475eb921c46bbdc62@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/10] udf: Convert in-ICB files to use udf_writepages()
Date:   Tue, 24 Jan 2023 13:06:13 +0100
Message-Id: <20230124120628.24449-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120221.31585-1-jack@suse.cz>
References: <20230124120221.31585-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3769; i=jack@suse.cz; h=from:subject; bh=2Z4cAOOiB13cyQgSOEL1SkmEftf7+sJCV2/2EOyYTKk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8m1vhS5QeerQ3cvpkVz/Thgcbj7TA7oI+aeybcf t/V2j8iJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/JtQAKCRCcnaoHP2RA2az3B/ 98bAwhMyONWA+O4GXVrkDDLl66gCN7G0pO4iHgxH6txbEwAgQXfqN6jPiQT4IOy1dCMOLmgKmqiLgs 6h35WtVYHZ7qGFwwPD+8HQWfkkQEgqO6uTPeKgsMEby7l50lXRVi0dvyNuRJ+XBO84+/qgJ2QmUKKV Ki9NjQQV278fU6V+jA6lW95K9QB7k5kA1iaIlZ8ulEJLIDWYAEp+XglnrQS8z//XBGKUj7+JFLmI5f jjHquVjNLork+4tZvRJv9dq5HWo4sAbGGhRBn1/GfQ/7tWC4xTwaohRQlH7p3zgFngdzZ5mPcsbExS 0kuljquYLIj1XLgqojhO4ycyURYnkR
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

Switching address_space_operations while a file is used is difficult to
do in a race-free way. To be able to use single address_space_operations
in UDF, make in-ICB files use udf_writepages().

Reported-by: syzbot+c27475eb921c46bbdc62@syzkaller.appspotmail.com
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/file.c    | 21 +--------------------
 fs/udf/inode.c   | 29 ++++++++++++++++++++++++++---
 fs/udf/udfdecl.h |  1 +
 3 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 2666234a5204..7a8dbad86e41 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -57,25 +57,6 @@ void udf_adinicb_readpage(struct page *page)
 	kunmap_atomic(kaddr);
 }
 
-static int udf_adinicb_writepage(struct page *page,
-				 struct writeback_control *wbc)
-{
-	struct inode *inode = page->mapping->host;
-	char *kaddr;
-	struct udf_inode_info *iinfo = UDF_I(inode);
-
-	BUG_ON(!PageLocked(page));
-
-	kaddr = kmap_atomic(page);
-	memcpy(iinfo->i_data + iinfo->i_lenEAttr, kaddr, i_size_read(inode));
-	SetPageUptodate(page);
-	kunmap_atomic(kaddr);
-	mark_inode_dirty(inode);
-	unlock_page(page);
-
-	return 0;
-}
-
 static int udf_adinicb_write_begin(struct file *file,
 			struct address_space *mapping, loff_t pos,
 			unsigned len, struct page **pagep,
@@ -119,7 +100,7 @@ const struct address_space_operations udf_adinicb_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= udf_read_folio,
-	.writepage	= udf_adinicb_writepage,
+	.writepages	= udf_writepages,
 	.write_begin	= udf_adinicb_write_begin,
 	.write_end	= udf_adinicb_write_end,
 	.direct_IO	= udf_adinicb_direct_IO,
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 9ef56574e452..54e6127ebf55 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -185,10 +185,33 @@ static void udf_write_failed(struct address_space *mapping, loff_t to)
 	}
 }
 
-static int udf_writepages(struct address_space *mapping,
-			struct writeback_control *wbc)
+static int udf_adinicb_writepage(struct page *page,
+				 struct writeback_control *wbc, void *data)
 {
-	return mpage_writepages(mapping, wbc, udf_get_block_wb);
+	struct inode *inode = page->mapping->host;
+	char *kaddr;
+	struct udf_inode_info *iinfo = UDF_I(inode);
+
+	BUG_ON(!PageLocked(page));
+
+	kaddr = kmap_atomic(page);
+	memcpy(iinfo->i_data + iinfo->i_lenEAttr, kaddr, i_size_read(inode));
+	SetPageUptodate(page);
+	kunmap_atomic(kaddr);
+	unlock_page(page);
+	mark_inode_dirty(inode);
+
+	return 0;
+}
+
+int udf_writepages(struct address_space *mapping, struct writeback_control *wbc)
+{
+	struct inode *inode = mapping->host;
+	struct udf_inode_info *iinfo = UDF_I(inode);
+
+	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB)
+		return mpage_writepages(mapping, wbc, udf_get_block_wb);
+	return write_cache_pages(mapping, wbc, udf_adinicb_writepage, NULL);
 }
 
 int udf_read_folio(struct file *file, struct folio *folio)
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 6b93b393cb46..48647eab26a6 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -160,6 +160,7 @@ extern int udf_setsize(struct inode *, loff_t);
 extern void udf_evict_inode(struct inode *);
 extern int udf_write_inode(struct inode *, struct writeback_control *wbc);
 int udf_read_folio(struct file *file, struct folio *folio);
+int udf_writepages(struct address_space *mapping, struct writeback_control *wbc);
 extern int8_t inode_bmap(struct inode *, sector_t, struct extent_position *,
 			 struct kernel_lb_addr *, uint32_t *, sector_t *);
 int udf_get_block(struct inode *, sector_t, struct buffer_head *, int);
-- 
2.35.3

