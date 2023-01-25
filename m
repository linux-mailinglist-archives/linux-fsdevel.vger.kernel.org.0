Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1293D67AE54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 10:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbjAYJmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 04:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbjAYJmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:42:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F399930DF
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 01:42:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C30E21C74;
        Wed, 25 Jan 2023 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674639721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFsroFWVQ9Mnyo2w/YZq8LcTL1TArB27vUMXBp9llxE=;
        b=iTgvfZJuIiocP361KZiLKGvexIG0P/JOYexxyP17JcCpxjrcUS+2JxvibvQOCSFk8CWlPE
        PaP4kAJndPnGrBA7eY1tsFB4ENirP1gBe1t7GubnDF8QerEsfMCTjCBDaG4HMsYygLUwOi
        2+fbfabUVT5xeT/72hsE6rNVKotZQqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674639721;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFsroFWVQ9Mnyo2w/YZq8LcTL1TArB27vUMXBp9llxE=;
        b=M6TVGW7au1jYhh2KTk4rVnxruTWxp+TXWiRjGcYXVnhM/mnf4687C4pTjUjBLcHD2nsDdu
        ATy9rfzjQ1gD0+CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0622E1358F;
        Wed, 25 Jan 2023 09:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IVSWAWn50GMkIgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 09:42:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 55320A06D0; Wed, 25 Jan 2023 10:41:59 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 05/12] udf: Convert all file types to use udf_write_end()
Date:   Wed, 25 Jan 2023 10:41:47 +0100
Message-Id: <20230125094159.10877-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230125093914.24627-1-jack@suse.cz>
References: <20230125093914.24627-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3512; i=jack@suse.cz; h=from:subject; bh=d88CriuKCFiUkVD3qyJkIo32zhq3lnVoaV6ED6xbV9E=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj0PlbSC3ltAvMwQwcPcR5MWAcv6wqCQMp8N75Wve/ fK21E+eJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY9D5WwAKCRCcnaoHP2RA2a7RB/ 9AYYFirFwvanGXSwqjZSLf7Wb+oMcdlkYohD6EOcteQP5PU2A7yCbN2mFUxBKtETYcHeGu15bsOUEf Rs0fEARhC/YfyzpPDlmhWY4uK/T/N5vI4OLiQBifNeKrTS1bWSjH3jw0LNfR8YRpD9U1YY01IYzcav yfBsU3o5vecQTYt/ZbE2REMa7QWCEexdLqcn4Sz3f9SDrZsp8p9c9JUyUuExZyD8dF4j52K/Scs0tZ /lL8iASK70jySfHSX4om6Y8topDR3XFF5dazhPjS1OKIqYA8FL4OD2YM+7CAwQqRbeHISCksYxTGlI ERVWlvQQ1gd9xymjp5PxdnQqxFOb7B
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
in UDF, create udf_write_end() function that is able to handle both
normal and in-ICB files.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/file.c    | 16 +---------------
 fs/udf/inode.c   | 22 +++++++++++++++++++++-
 fs/udf/udfdecl.h |  3 +++
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 16aecf4b2387..8a37cd593883 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -57,27 +57,13 @@ void udf_adinicb_readpage(struct page *page)
 	kunmap_atomic(kaddr);
 }
 
-static int udf_adinicb_write_end(struct file *file, struct address_space *mapping,
-				 loff_t pos, unsigned len, unsigned copied,
-				 struct page *page, void *fsdata)
-{
-	struct inode *inode = page->mapping->host;
-	loff_t last_pos = pos + copied;
-	if (last_pos > inode->i_size)
-		i_size_write(inode, last_pos);
-	set_page_dirty(page);
-	unlock_page(page);
-	put_page(page);
-	return copied;
-}
-
 const struct address_space_operations udf_adinicb_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= udf_read_folio,
 	.writepages	= udf_writepages,
 	.write_begin	= udf_write_begin,
-	.write_end	= udf_adinicb_write_end,
+	.write_end	= udf_write_end,
 	.direct_IO	= udf_direct_IO,
 };
 
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index c165dd9714b9..ac00f2f5dbe3 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -257,6 +257,26 @@ int udf_write_begin(struct file *file, struct address_space *mapping,
 	return 0;
 }
 
+int udf_write_end(struct file *file, struct address_space *mapping,
+		  loff_t pos, unsigned len, unsigned copied,
+		  struct page *page, void *fsdata)
+{
+	struct inode *inode = file_inode(file);
+	loff_t last_pos;
+
+	if (UDF_I(inode)->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB)
+		return generic_write_end(file, mapping, pos, len, copied, page,
+					 fsdata);
+	last_pos = pos + copied;
+	if (last_pos > inode->i_size)
+		i_size_write(inode, last_pos);
+	set_page_dirty(page);
+	unlock_page(page);
+	put_page(page);
+
+	return copied;
+}
+
 ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
@@ -286,7 +306,7 @@ const struct address_space_operations udf_aops = {
 	.readahead	= udf_readahead,
 	.writepages	= udf_writepages,
 	.write_begin	= udf_write_begin,
-	.write_end	= generic_write_end,
+	.write_end	= udf_write_end,
 	.direct_IO	= udf_direct_IO,
 	.bmap		= udf_bmap,
 	.migrate_folio	= buffer_migrate_folio,
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 32decf6b6a21..304c2ec81589 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -164,6 +164,9 @@ int udf_writepages(struct address_space *mapping, struct writeback_control *wbc)
 int udf_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata);
+int udf_write_end(struct file *file, struct address_space *mapping,
+		  loff_t pos, unsigned len, unsigned copied,
+		  struct page *page, void *fsdata);
 ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 extern int8_t inode_bmap(struct inode *, sector_t, struct extent_position *,
 			 struct kernel_lb_addr *, uint32_t *, sector_t *);
-- 
2.35.3

