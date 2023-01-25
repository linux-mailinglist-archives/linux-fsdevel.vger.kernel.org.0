Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093E067AE4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 10:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjAYJmE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 04:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbjAYJmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:42:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AEA869F
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 01:42:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3128A21C80;
        Wed, 25 Jan 2023 09:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674639720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Dte/4yhsHWpU9dGZkfSaM4oLYxYY4PCuzaDdP5EdEQ=;
        b=Yo43GBaIl5Dgf38qD+QYetIW40POSRXAL4DhcK6Yf1aL47QGMfaW83p6guFaYramHkZEws
        a8HL4vlhnUG8hp5ckO0CGhvC4shoACgeEZrVIcifF1wVcgC1Ng4y861quxl5U0xWmA4/ww
        o3hHhpCD5VswiK1LmE6iafSC2C09xuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674639720;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Dte/4yhsHWpU9dGZkfSaM4oLYxYY4PCuzaDdP5EdEQ=;
        b=R5WS7jA2NOIFIYRz28B3fTrCXhZt3a7USsDb3fCE6INrfFgas7VV4o7hVC6AwDso1q4eXL
        7JSPAsWYOwXlMFCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17C5F13A06;
        Wed, 25 Jan 2023 09:42:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u7sSBWj50GMSIgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 09:42:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 43F6FA06B9; Wed, 25 Jan 2023 10:41:59 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        syzbot+c27475eb921c46bbdc62@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 02/12] udf: Convert in-ICB files to use udf_writepages()
Date:   Wed, 25 Jan 2023 10:41:44 +0100
Message-Id: <20230125094159.10877-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230125093914.24627-1-jack@suse.cz>
References: <20230125093914.24627-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3814; i=jack@suse.cz; h=from:subject; bh=lpY+jaVzKgwDvo4FoC8bkZv2ZnGGLKYrbXTovEH8ekQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj0PlY8EbfNO2kx0Q+K82hC/HU6lelpYnCAPbIoM5e AXSrNXyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY9D5WAAKCRCcnaoHP2RA2aN3CA CyQKHdLFvYrkgqAJIXCy7Sn97+tiu8MoYQY+jawdD1sn4rKQE0aFLx1+KXtQIvAFg0jCRULK8RspXg xMuFXVayk8TWvM2QZWGcpZqWMQ63hQwxr36FDRLmiKe7tz+brlm+baKTb2/e7nNG3PnlATJCZWBpwu 0DTqsuSie0QZWhSlPZlBJ7g2X4vbhT6/SFsY3egojHbTcP4LHHdmhNR5BGaOdvysnlsmHjJYdxd0qV x7X4+aJcSh4Gp1pvjGW1ZtBoTl6y+4W7FHQ7yHGbS3WGUxvD5j8qdXDKoFrHSwAFoUkJRRM73Rp7LD mMT5RcqbP58Ivj0zz0aXtaKJeog1TI
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index b90b9862b073..3c6a129d1ae9 100644
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

