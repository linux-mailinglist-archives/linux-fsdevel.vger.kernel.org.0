Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B0067AE4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 10:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbjAYJmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 04:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjAYJmD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:42:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8014A2B29F
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 01:42:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 38C2421C82;
        Wed, 25 Jan 2023 09:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674639720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTexrFokGErC1DDMr8ao4jUpUNu1UsdaZ82C7rmjD58=;
        b=puwUbTe87RttOHWh+5ArPV5/RqAaqJYWkkahjlp4GjC2V/nmg9xzuou21mpEMONXdqxL30
        Osxi5FRdTI1UjPs89JObnrEPjU/Bm4cpT+Tx0028qC5GrN0Lo0ig9votKLg/55z7aBgoab
        vAug5Tp/7KF5qA573yDccCzqLpoqYKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674639720;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTexrFokGErC1DDMr8ao4jUpUNu1UsdaZ82C7rmjD58=;
        b=b+btVccKW12trPBN8ezNGT6i+U0PjlATRDRq3Tx/6e3mmMS6I5VCh0BdC/yCdF0mHVif2R
        sSb7cTtPNXCXyaAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2967F13A09;
        Wed, 25 Jan 2023 09:42:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BKEHCWj50GMWIgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 09:42:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5060EA06C6; Wed, 25 Jan 2023 10:41:59 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 04/12] udf: Convert in-ICB files to use udf_write_begin()
Date:   Wed, 25 Jan 2023 10:41:46 +0100
Message-Id: <20230125094159.10877-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230125093914.24627-1-jack@suse.cz>
References: <20230125093914.24627-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3688; i=jack@suse.cz; h=from:subject; bh=Q35WItHGUnCNRlRjCs8qc4xP7+XrQgyl03pCdYb76xU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj0PlalD8FlrflI4tRJ6J9e8TxzGp36FO0Am4IDUt5 VkEPiZGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY9D5WgAKCRCcnaoHP2RA2bY0CA DuCjhkgosDftPsH81fNQE9QqDHHhp2rhd547gNmpzwKeXT0gvBb2p3Gj75mucVH1L3sY+3V3MUh41D qAIoU0hj2KwA9yREETzo3exK7oVnGpR90hgxrcui360A0ox37ej+SUz1ZPVc4jT2UFUrk9IOPBuqU/ c3Ck7D7KYHlDYWjVu57SWW5wMugSSFLKgS03Gs2uK748w4z5ErbmvKYj+oFfv4bXBrZbnvDXVbC1UI 8tx0Ebzi382dxp1qQ7JEJTN9y/bFtu1M7Hcov1om0QEGK1CPpIE1Yp00hg5vQFHSUvPyk22vgcNxH9 yuIxT+bKMQfAN++H84bILte2+mMzk1
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switching address_space_operations while a file is used is difficult to
do in a race-free way. To be able to use single address_space_operations
in UDF, make in-ICB files use udf_write_begin().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/file.c    | 21 +--------------------
 fs/udf/inode.c   | 24 +++++++++++++++++++-----
 fs/udf/udfdecl.h |  3 +++
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 6bab6aa7770a..16aecf4b2387 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -57,25 +57,6 @@ void udf_adinicb_readpage(struct page *page)
 	kunmap_atomic(kaddr);
 }
 
-static int udf_adinicb_write_begin(struct file *file,
-			struct address_space *mapping, loff_t pos,
-			unsigned len, struct page **pagep,
-			void **fsdata)
-{
-	struct page *page;
-
-	if (WARN_ON_ONCE(pos >= PAGE_SIZE))
-		return -EIO;
-	page = grab_cache_page_write_begin(mapping, 0);
-	if (!page)
-		return -ENOMEM;
-	*pagep = page;
-
-	if (!PageUptodate(page))
-		udf_adinicb_readpage(page);
-	return 0;
-}
-
 static int udf_adinicb_write_end(struct file *file, struct address_space *mapping,
 				 loff_t pos, unsigned len, unsigned copied,
 				 struct page *page, void *fsdata)
@@ -95,7 +76,7 @@ const struct address_space_operations udf_adinicb_aops = {
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= udf_read_folio,
 	.writepages	= udf_writepages,
-	.write_begin	= udf_adinicb_write_begin,
+	.write_begin	= udf_write_begin,
 	.write_end	= udf_adinicb_write_end,
 	.direct_IO	= udf_direct_IO,
 };
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index dafbc99b78a3..c165dd9714b9 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -231,16 +231,30 @@ static void udf_readahead(struct readahead_control *rac)
 	mpage_readahead(rac, udf_get_block);
 }
 
-static int udf_write_begin(struct file *file, struct address_space *mapping,
+int udf_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
+	struct udf_inode_info *iinfo = UDF_I(file_inode(file));
+	struct page *page;
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, pagep, udf_get_block);
-	if (unlikely(ret))
-		udf_write_failed(mapping, pos + len);
-	return ret;
+	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
+		ret = block_write_begin(mapping, pos, len, pagep,
+					udf_get_block);
+		if (unlikely(ret))
+			udf_write_failed(mapping, pos + len);
+		return ret;
+	}
+	if (WARN_ON_ONCE(pos >= PAGE_SIZE))
+		return -EIO;
+	page = grab_cache_page_write_begin(mapping, 0);
+	if (!page)
+		return -ENOMEM;
+	*pagep = page;
+	if (!PageUptodate(page))
+		udf_adinicb_readpage(page);
+	return 0;
 }
 
 ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index a851613465c6..32decf6b6a21 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -161,6 +161,9 @@ extern void udf_evict_inode(struct inode *);
 extern int udf_write_inode(struct inode *, struct writeback_control *wbc);
 int udf_read_folio(struct file *file, struct folio *folio);
 int udf_writepages(struct address_space *mapping, struct writeback_control *wbc);
+int udf_write_begin(struct file *file, struct address_space *mapping,
+			loff_t pos, unsigned len,
+			struct page **pagep, void **fsdata);
 ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 extern int8_t inode_bmap(struct inode *, sector_t, struct extent_position *,
 			 struct kernel_lb_addr *, uint32_t *, sector_t *);
-- 
2.35.3

